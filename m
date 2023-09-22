Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 596917AB3C4
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 16:36:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230343AbjIVOgk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 10:36:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230085AbjIVOgi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 10:36:38 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8F39100
        for <linux-kernel@vger.kernel.org>; Fri, 22 Sep 2023 07:36:32 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id d9443c01a7336-1c382f23189so174455ad.0
        for <linux-kernel@vger.kernel.org>; Fri, 22 Sep 2023 07:36:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1695393392; x=1695998192; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4aUf2v6QvLVbT8m/zyw2bs6Z3ENgPEgB0H4K7IAot/U=;
        b=MQvhpRVmzLcPK5ScYZQYCU4sQ2fCp/ehXRf/WPCVPGLtUVlCfoHg2aIZRR7kwKhkzE
         5nk65Bfozn2kgWrt/2yZgciOOHP5HpObyLSDbScFMMZ02b4BpjWemv5GIeutJGu6Pdh6
         9HyNBtxwOfgXmZ3GhASTkz76Fn34YpuGLTiJ9sdn8tv58ljEOVVscZMoC3i+hcwucS9t
         uXXDJpVLv06hBjJjJXxGMMDAVwLYCC+XqzMVUbqEp/aUkIyVNZFhrUqYW30EI+OpUccI
         0OwvLmUHCrdyI9A5QytOC7RqbOmfdT/1VyoBkc9mYGfy9IcpkLzw6xslKvPqTwO6wOqo
         FC7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695393392; x=1695998192;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4aUf2v6QvLVbT8m/zyw2bs6Z3ENgPEgB0H4K7IAot/U=;
        b=JH+Nap2BgtoWY/1kr5x87exQrQKVD5NsOnlfvI9B8VUuc+TNwZW8be6tjG0YVxg4Lq
         tqCHJBd+fCgx32uhIXD/vaMWcnJNOdVY7Ih7U9f2A6OvLkTNQIqx0GXmNa5jDpiBv+Ns
         sRHPBo1MWzREjUrWAnU+0wQODQyo/yG5sbRXZmsmZRxLLcOv9SH5KCVAiDZb28j/aN6x
         WxZ3GeBUWFgI+sLh7x4uZCEuSTxfwygC5afTQcXc+gx9OotCtxKqCw6UPg420tBftmXm
         Vud7NVpK55XEIL8CwEusK6qhMnswXAPAfGk7fZwkZTar5bNauDrerHFiFhLVevQxvEsO
         Q0kQ==
X-Gm-Message-State: AOJu0YzgBvQLmvuAVDWJswK+uqvzF57aSFWJI8tGWxirLlLpxd52TD1p
        hJvreNsMIWvy8YWwqT63XU9KA+v48hc65mzMlSDVYw==
X-Google-Smtp-Source: AGHT+IH0jVRnmCGhVgl6h8vYBSPLpagiWf9oF1HtBxKdFKlHJ1yAkZcyn2pEdwwt1QQw369sBYUmL4obJSO65DXhJ9E=
X-Received: by 2002:a17:902:c70a:b0:1c0:7dec:e5b2 with SMTP id
 p10-20020a170902c70a00b001c07dece5b2mr170349plp.4.1695393391893; Fri, 22 Sep
 2023 07:36:31 -0700 (PDT)
MIME-Version: 1.0
References: <20230915224227.1336967-1-babu.moger@amd.com> <20230915224227.1336967-11-babu.moger@amd.com>
In-Reply-To: <20230915224227.1336967-11-babu.moger@amd.com>
From:   Peter Newman <peternewman@google.com>
Date:   Fri, 22 Sep 2023 16:36:20 +0200
Message-ID: <CALPaoCj46dDCFruHW3EcqRQ90SZpOsKK2UVPzb+88rzs5aTTJg@mail.gmail.com>
Subject: Re: [PATCH v10 10/10] x86/resctrl: Display RMID of resource group
To:     Babu Moger <babu.moger@amd.com>
Cc:     corbet@lwn.net, reinette.chatre@intel.com, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, fenghua.yu@intel.com,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
        paulmck@kernel.org, akpm@linux-foundation.org,
        quic_neeraju@quicinc.com, rdunlap@infradead.org,
        damien.lemoal@opensource.wdc.com, songmuchun@bytedance.com,
        peterz@infradead.org, jpoimboe@kernel.org, pbonzini@redhat.com,
        chang.seok.bae@intel.com, pawan.kumar.gupta@linux.intel.com,
        jmattson@google.com, daniel.sneddon@linux.intel.com,
        sandipan.das@amd.com, tony.luck@intel.com, james.morse@arm.com,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        bagasdotme@gmail.com, eranian@google.com,
        christophe.leroy@csgroup.eu, jarkko@kernel.org,
        adrian.hunter@intel.com, quic_jiles@quicinc.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Babu,

On Sat, Sep 16, 2023 at 12:42=E2=80=AFAM Babu Moger <babu.moger@amd.com> wr=
ote:
>
> In x86, hardware uses RMID to identify a monitoring group. When a user
> creates a monitor group these details are not visible. These details
> can help resctrl debugging.
>
> Add RMID(mon_hw_id) to the monitor groups display in resctrl interface.
> Users can see these details when resctrl is mounted with "-o debug" optio=
n.

When I reviewed this, I went through the whole series second-guessing
the wording above and wondering whether "monitoring groups" applied to
CTRL_MON groups.

I was able to confirm that mon_hw_id did appear and had a believable
value in CTRL_MON groups which had allocated monitors. (and I added
some comma-separated PID lists to the tasks node)

for the series:
Tested-By: Peter Newman <peternewman@google.com>

> diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu=
/resctrl/internal.h
> index a07fa4329b65..b4910892b0a6 100644
> --- a/arch/x86/kernel/cpu/resctrl/internal.h
> +++ b/arch/x86/kernel/cpu/resctrl/internal.h
> @@ -296,6 +296,11 @@ struct rdtgroup {
>   *     --> RFTYPE_BASE (Files common for both MON and CTRL groups)
>   *         Files: cpus, cpus_list, tasks
>   *
> + *             --> RFTYPE_MON (Files only for MON group)

If monitoring is supported, all groups are MON groups. I think the
"only" above caused me to second guess whether this takes into account
CTRL_MON groups getting the RFTYPE_MON flag set dynamically.

However, I think the documentation above is still technically accurate.

for the series:
Reviewed-By: Peter Newman <peternewman@google.com>

Thanks!
-Peter
