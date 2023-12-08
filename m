Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27C3D80AC06
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 19:26:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229872AbjLHS0N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 13:26:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229811AbjLHS0L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 13:26:11 -0500
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E9E690
        for <linux-kernel@vger.kernel.org>; Fri,  8 Dec 2023 10:26:17 -0800 (PST)
Received: by mail-pl1-x634.google.com with SMTP id d9443c01a7336-1cc79f73e58so8085ad.1
        for <linux-kernel@vger.kernel.org>; Fri, 08 Dec 2023 10:26:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1702059977; x=1702664777; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=75zio9oghTkUElUZUVPQLES5Kw5emjlawW+mI0eiLfs=;
        b=q28rMezCcPtRMa56QW+O2YFjtrVIezvWd0PlN5IELBdx6Qoc6lBjG+tG8yxKCXTNKm
         qR20DY8hoUu+cIAiUatPbRhg6AuazGWNCvNpp9iGQI/ualX2Vh0X1L/nN9h/FGxBj8iP
         HnS3xS8bdLcTpYuAR0rdGJNLYwVddVtjLnlU48xp0sGJm/pMxUnDgbtT9iKEbH4HRR2b
         GTy3VmMOPKogjYiBEU65GRXtvUoagI7o9QucyUQH2oWBWKL3tCDDYBeseHgpEqMkLlzR
         vl5fuAX/KiWEqzNk1xf67ygRQWkPtsmoUGtcBhLIkcQK79Xz5EuygGHhZUnrOKLvgyH6
         8xZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702059977; x=1702664777;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=75zio9oghTkUElUZUVPQLES5Kw5emjlawW+mI0eiLfs=;
        b=AofpsUNAW5yfzynZQktOCCuc0KxCBJb3QE2syzDnGLbXiwsNKVECRHABj7glP781H5
         YwXeIsjjqdwqbj4ZL8eZSEFhtMNhPIulLgAt7Zdo+2Q4o9WbKqJoeoj1Lv7jYLyYmecs
         psfd2fbFJ4rRMgx1F8cuyIvHSIh/jADu1wk8OJ/NI4oIf1uoGpL/VconRK6wZO5Q7G1P
         EdQkImjQwlFpCnuDZXPUt2HT30JWsnINpNKpLNRKBoqVFPZ4KQhJMaIBY709uIizQlDS
         9utVO2lz4xBo2y5tkktSHbEYVLzUQTylu5RwP3X40/TIb+rduNYJHoybE2P2B6kt6ha5
         J7Yw==
X-Gm-Message-State: AOJu0Yz52FVpI3LRIQz0dFnHj562RPE7op+6Ch9N4eBYkgRdwE4ul0mG
        ok+L1/xhuy6GZaW8rjILuTiSOVRDSsQU6KfB/osO3Q==
X-Google-Smtp-Source: AGHT+IG1AfEt/Tw51pB1tsGJgVQsx5i9xByxbif3lqRSlA8jKdPIkrRKdier/oxRIv+d1qmJOHXgkvTs0WvAfHdNXkE=
X-Received: by 2002:a17:903:244f:b0:1cf:9f0e:9524 with SMTP id
 l15-20020a170903244f00b001cf9f0e9524mr175431pls.27.1702059976843; Fri, 08 Dec
 2023 10:26:16 -0800 (PST)
MIME-Version: 1.0
References: <20231201214737.104444-1-tony.luck@intel.com> <20231207195613.153980-1-tony.luck@intel.com>
 <20231207195613.153980-3-tony.luck@intel.com>
In-Reply-To: <20231207195613.153980-3-tony.luck@intel.com>
From:   Peter Newman <peternewman@google.com>
Date:   Fri, 8 Dec 2023 10:26:06 -0800
Message-ID: <CALPaoCgR5qNsSegKLzg2g2eE8EgQB9vixAdDOryQOr8HQ+CPAw@mail.gmail.com>
Subject: Re: [PATCH v6 2/3] x86/resctrl: Use total bandwidth for mba_MBps
 option when local isn't present
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
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 7, 2023 at 11:56=E2=80=AFAM Tony Luck <tony.luck@intel.com> wro=
te:
>
> On Intel systems the memory bandwidth monitoring events are
> independently enumerated. It is possible for a system to support
> total memory bandwidth monitoring, but not support local bandwidth
> monitoring. On such a system a user could not enable mba_sc mode.
> Users will see this highly unhelpful error message from mount:
>
>  # mount -t resctrl -o mba_MBps resctrl /sys/fs/resctrl
>  mount: /sys/fs/resctrl: wrong fs type, bad option, bad superblock on
>  resctrl, missing codepage or helper program, or other error.
>  dmesg(1) may have more information after failed mount system call.
>
> dmesg(1) does not provide any additional information.
>
> Modify the existing "mba_MBps" mount option to switch to total bandwidth
> monitoring if local monitoring is not available.
>
> Signed-off-by: Tony Luck <tony.luck@intel.com>
> ---
>  arch/x86/kernel/cpu/resctrl/rdtgroup.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu=
/resctrl/rdtgroup.c
> index 5f64a0b2597c..7410513db45a 100644
> --- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> +++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> @@ -2725,6 +2725,8 @@ static int rdt_parse_param(struct fs_context *fc, s=
truct fs_parameter *param)
>                         return -EINVAL;
>                 if (is_mbm_local_enabled())
>                         ctx->enable_mba_mbps_local =3D true;
> +               else if (is_mbm_total_enabled())
> +                       ctx->enable_mba_mbps_total =3D true;
>                 else
>                         return -EINVAL;
>                 return 0;
> --
> 2.41.0
>

Reviewed-by: Peter Newman <peternewman@google.com>
