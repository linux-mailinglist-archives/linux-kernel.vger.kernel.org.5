Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE61A7B34C5
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Sep 2023 16:21:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233395AbjI2OVk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Sep 2023 10:21:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233364AbjI2OVX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Sep 2023 10:21:23 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 477121B3
        for <linux-kernel@vger.kernel.org>; Fri, 29 Sep 2023 07:21:22 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id d9443c01a7336-1c6185cafb3so155705ad.1
        for <linux-kernel@vger.kernel.org>; Fri, 29 Sep 2023 07:21:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1695997282; x=1696602082; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tIjMyRkvD4vXS0iKt2DZ+VffYOy0NMhKbaOoqihxMXc=;
        b=Zr8S8KiZRNyyujON9N70qnnLVUQ+dBwqeskbQLlCxhPlOQzGVkKvppKYdfkKmy6Q0k
         DLh6pHWf+4oWYEWTBSQ0IXB8P0SHG5aaec6ZjZHuSKV4uy23lM0xEVMnjNa1rIvnQAzc
         T+COiifbwWAeKqqnO/Ry/Yf9eyvAdtTqxJPkK2OKksBn7Lb35gm98BP1OhyWpXlHPyeB
         DqVwrT7Si44g11NFhX+FyrZCY2D16IkY5/BEyWVdIwRNZKrfQYVCBZA9GH38Dld7gUOd
         5Iwnur9purhDp3ygAcufcKg5QqLuex0uC4qfxbNgjUtNDsou69dcBgW4SNTuhgi985Er
         BN3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695997282; x=1696602082;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tIjMyRkvD4vXS0iKt2DZ+VffYOy0NMhKbaOoqihxMXc=;
        b=a73EhO1o7h//7zJXRDj4nN9kk2kPLHCRcwBrKpa7bdPmclU489bC5WwI9GszHetUeS
         vyQZL8PO/+JvbI0wf82y5pP2NwYoyTMxDT9Ifegcijvv0KvFDxJHEussVlxzV1EEH1Fb
         VZgwUE2srbrHnBnJ04NIqm9UGlGu+mCLywE6z4a7uR6xUCwGDl7EQUeESxxJ+s4MjFuG
         RVeu+JAr7fyVpPpPauZhUKM7cfM7VTzwfqNXap+3zxGbXGQOC999S8+FIVrVm1vERra1
         HMtzh7q1ZevKGrG7TTOKi9l9AjoF0a93wmxSspY7G6m1gxQ98TU6/lpkR8A5L44X/GY3
         OQyw==
X-Gm-Message-State: AOJu0Yy7yOxJxUwFc0i8L9ZeuONcRfBumDKbsDZ/fqwJwRrc5KLbkX45
        3x1o3Ld4xH8qBRHxOaA9bGSXm9XjQGTwvJe1f7BF0A==
X-Google-Smtp-Source: AGHT+IHsG1ktZ0SAurPZ0QFRvK0fU8aHMiW++bixgCyT5nwhEB/N1BLwp8n50oH0IVEBUeadXQvjE9aoL/FG8TN+++0=
X-Received: by 2002:a17:902:f54f:b0:1c7:1fbc:b9e8 with SMTP id
 h15-20020a170902f54f00b001c71fbcb9e8mr792263plf.10.1695997281453; Fri, 29 Sep
 2023 07:21:21 -0700 (PDT)
MIME-Version: 1.0
References: <20230829234426.64421-1-tony.luck@intel.com> <20230928191350.205703-1-tony.luck@intel.com>
 <20230928191350.205703-6-tony.luck@intel.com>
In-Reply-To: <20230928191350.205703-6-tony.luck@intel.com>
From:   Peter Newman <peternewman@google.com>
Date:   Fri, 29 Sep 2023 16:21:10 +0200
Message-ID: <CALPaoCgJ2qcwvKOG2aUrkd=dwwPdGGtaJS43Tgs=DwXxMmwUhg@mail.gmail.com>
Subject: Re: [PATCH v6 5/8] x86/resctrl: Add node-scope to the options for
 feature scope
To:     Tony Luck <tony.luck@intel.com>
Cc:     Fenghua Yu <fenghua.yu@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Shuah Khan <skhan@linuxfoundation.org>, x86@kernel.org,
        Shaopeng Tan <tan.shaopeng@fujitsu.com>,
        James Morse <james.morse@arm.com>,
        Jamie Iles <quic_jiles@quicinc.com>,
        Babu Moger <babu.moger@amd.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        patches@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tony,

On Thu, Sep 28, 2023 at 9:14=E2=80=AFPM Tony Luck <tony.luck@intel.com> wro=
te:
>
> Currently supported resctrl features are all domain scoped the same as th=
e
> scope of the L2 or L3 caches.
>
> Add RESCTRL_NODE as a new option for features that are scoped at the
> same granularity as NUMA nodes. This is needed for Intel's Sub-NUMA
> Cluster (SNC) feature where monitoring features are node scoped.
>
> Signed-off-by: Tony Luck <tony.luck@intel.com>
> ---
>
> Changes since v5:
>
> Updates to commit message.
>
>  include/linux/resctrl.h            | 1 +
>  arch/x86/kernel/cpu/resctrl/core.c | 2 ++
>  2 files changed, 3 insertions(+)
>
> diff --git a/include/linux/resctrl.h b/include/linux/resctrl.h
> index 1c925e3db2ea..18ed787f9798 100644
> --- a/include/linux/resctrl.h
> +++ b/include/linux/resctrl.h
> @@ -165,6 +165,7 @@ struct resctrl_schema;
>  enum resctrl_scope {
>         RESCTRL_L2_CACHE =3D 2,
>         RESCTRL_L3_CACHE =3D 3,
> +       RESCTRL_NODE,
>  };
>
>  /**
> diff --git a/arch/x86/kernel/cpu/resctrl/core.c b/arch/x86/kernel/cpu/res=
ctrl/core.c
> index 726f00c01079..e61bf919ac78 100644
> --- a/arch/x86/kernel/cpu/resctrl/core.c
> +++ b/arch/x86/kernel/cpu/resctrl/core.c
> @@ -511,6 +511,8 @@ static int get_domain_id_from_scope(int cpu, enum res=
ctrl_scope scope)
>         case RESCTRL_L2_CACHE:
>         case RESCTRL_L3_CACHE:
>                 return get_cpu_cacheinfo_id(cpu, scope);
> +       case RESCTRL_NODE:
> +               return cpu_to_node(cpu);
>         default:
>                 break;
>         }
> --
> 2.41.0
>

Looks fine.

Reviewed-by: Peter Newman <peternewman@google.com>
