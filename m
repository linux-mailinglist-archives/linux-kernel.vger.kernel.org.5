Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28B5578CD50
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 22:05:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240166AbjH2UFA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 16:05:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239958AbjH2UEv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 16:04:51 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44B8BD2;
        Tue, 29 Aug 2023 13:04:49 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id d2e1a72fcca58-68a42d06d02so3366278b3a.0;
        Tue, 29 Aug 2023 13:04:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693339488; x=1693944288; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YShQRRIoUyeyVMKKWVcVmBlF4Nh0zIEcHUDD0S50i3Y=;
        b=pXBZ/FTvovqhVwVdSlqmG0VWdpzUSbmFO/G8jktn5vdMQ5yIJBDWYzJh3n0DtcuG5r
         rskHLGSvA55QpZUWDNsF3wtofHDscYVs4T4VAHsLpuauZcIUycB+pfAZdfn3dWnFtMEQ
         yhOu0MAkUjRI7AngcLHnlZjnEiKD31i2gVK41I9Qudbp8LnYjyyBy82v/dInILSzonf/
         ldyoj4sXZGKpv7BOrs+87iFl8iEhuEGEEYCocGY/emGh2r6NAp/WbgmtOMP9461eKsEH
         4y+d+wZqgx43gYEvhteFxtxxe7SrnBq9f65c7C8GDnAD1xZ0BeaalNIP4mpEPIleW6Ke
         zxYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693339488; x=1693944288;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YShQRRIoUyeyVMKKWVcVmBlF4Nh0zIEcHUDD0S50i3Y=;
        b=lsdgcXQ4TRTixGpF1DW03KZlzOK9HspL1AqKXQPFYt/rENdyWegrWvOr5EOC3EG3EI
         pvXFP0tP9vDf5nvPnYxIeaMCNBK9r/qgvDvmVnIkuKwPAtp5s3KfPFBGQKXMG63TPeEf
         EqM6CK0E7sLEENUHmF3XZhWuJpj0KM8khebeMsL3lCpEVXQRNuYGtdvZHqIV2PuiJgmc
         IT+KiTZ+L8jyswJ+o8DhuJAehKf5AeWOzRuDt3oCuqoAD/5z0vPbiJW0xnS/uGPdrKhN
         Dp3ESavE5V0kC/wjNj7O1//5zXbYyENfeb6ySs6+LW8WogyVZzBsPT3D/vHCacv/J2kf
         Y94Q==
X-Gm-Message-State: AOJu0YxfP8E/3/PLpU0VLtVNIAG1imNG4xzaLc4aFMNoZzmHuCTbfHYj
        u/3WZcxGDCRGfebj2TX+LH8JQ6ykCwBixoqfnUM=
X-Google-Smtp-Source: AGHT+IF6MhqDzAOisq0kHguEIaPPsIYjONL9aE/QSQ+8Gt4dzCwb8f5PtvxGbko/WhJSAI9ZUBceCJ/2/Jyov7xHLBg=
X-Received: by 2002:a17:90a:d41:b0:263:931b:bb5f with SMTP id
 1-20020a17090a0d4100b00263931bbb5fmr262103pju.14.1693339488394; Tue, 29 Aug
 2023 13:04:48 -0700 (PDT)
MIME-Version: 1.0
References: <20230817035155.84230-1-liusong@linux.alibaba.com>
In-Reply-To: <20230817035155.84230-1-liusong@linux.alibaba.com>
From:   Yang Shi <shy828301@gmail.com>
Date:   Tue, 29 Aug 2023 13:04:36 -0700
Message-ID: <CAHbLzkrUQ2i0jtgiDf25t_VD4W8hm3jZvd=N=dTyCqvFXc8Q1g@mail.gmail.com>
Subject: Re: [PATCH] mm/khugepaged: increase transparent_hugepage_recommend_disable
 parameter to disable active modification of min_free_kbytes
To:     Liu Song <liusong@linux.alibaba.com>
Cc:     corbet@lwn.net, akpm@linux-foundation.org, paulmck@kernel.org,
        rdunlap@infradead.org, catalin.marinas@arm.com,
        dave.hansen@linux.intel.com, rostedt@goodmis.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 16, 2023 at 8:52=E2=80=AFPM Liu Song <liusong@linux.alibaba.com=
> wrote:
>
> In the arm64 environment, when PAGESIZE is 4K, the "pageblock_nr_pages"
> value is 512, and the recommended min_free_kbytes in
> "set_recommended_min_free_kbytes" usually does not exceed 44MB.
>
> However, when PAGESIZE is 64K, the "pageblock_nr_pages" value is 8192,
> and the recommended min_free_kbytes in "set_recommended_min_free_kbytes"
> is 8192 * 2 * (2 + 9) * 64K, which directly increases to 11GB.
>
> According to this calculation method, due to the modification of min_free=
_kbytes,
> the reserved memory in my 128GB memory environment reaches 10GB, and MemA=
vailable
> is correspondingly reduced by 10GB.
>
> In the case of PAGESIZE 64K, transparent hugepages are 512MB, and we only
> need them to be used on demand. If transparent hugepages cannot be alloca=
ted,
> falling back to regular 64K pages is completely acceptable.
>
> Therefore, we added the transparent_hugepage_recommend_disable parameter
> to disable active modification of min_free_kbytes, thereby meeting our
> requirements for transparent hugepages in the 64K scenario, and it will
> not excessively reduce the available memory.

Thanks for debugging this. I agree 11GB for min_free_kbytes is too
much. But a kernel parameter sounds overkilling to me either. IMHO we
just need to have a better scaling for bigger base page size. For
example, we just keep one or two pageblock for min_free_kbytes when
the base page size is bigger than 4K.

>
> Signed-off-by: Liu Song <liusong@linux.alibaba.com>
> ---
>  .../admin-guide/kernel-parameters.txt         |  5 +++++
>  mm/khugepaged.c                               | 20 ++++++++++++++++++-
>  2 files changed, 24 insertions(+), 1 deletion(-)
>
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentat=
ion/admin-guide/kernel-parameters.txt
> index 654d0d921101..612bdf601cce 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -6553,6 +6553,11 @@
>                         See Documentation/admin-guide/mm/transhuge.rst
>                         for more details.
>
> +       transparent_hugepage_recommend_disable
> +                       [KNL,THP]
> +                       Can be used to disable transparent hugepage to ac=
tively modify
> +                       /proc/sys/vm/min_free_kbytes during enablement pr=
ocess.
> +
>         trusted.source=3D [KEYS]
>                         Format: <string>
>                         This parameter identifies the trust source as a b=
ackend
> diff --git a/mm/khugepaged.c b/mm/khugepaged.c
> index 78fc1a24a1cc..ac40c618f4f6 100644
> --- a/mm/khugepaged.c
> +++ b/mm/khugepaged.c
> @@ -88,6 +88,9 @@ static unsigned int khugepaged_max_ptes_none __read_mos=
tly;
>  static unsigned int khugepaged_max_ptes_swap __read_mostly;
>  static unsigned int khugepaged_max_ptes_shared __read_mostly;
>
> +/* default enable recommended */
> +static unsigned int transparent_hugepage_recommend __read_mostly =3D 1;
> +
>  #define MM_SLOTS_HASH_BITS 10
>  static DEFINE_READ_MOSTLY_HASHTABLE(mm_slots_hash, MM_SLOTS_HASH_BITS);
>
> @@ -2561,6 +2564,11 @@ static void set_recommended_min_free_kbytes(void)
>                 goto update_wmarks;
>         }
>
> +       if (!transparent_hugepage_recommend) {
> +               pr_info("do not allow to recommend modify min_free_kbytes=
\n");
> +               return;
> +       }
> +
>         for_each_populated_zone(zone) {
>                 /*
>                  * We don't need to worry about fragmentation of
> @@ -2591,7 +2599,10 @@ static void set_recommended_min_free_kbytes(void)
>
>         if (recommended_min > min_free_kbytes) {
>                 if (user_min_free_kbytes >=3D 0)
> -                       pr_info("raising min_free_kbytes from %d to %lu t=
o help transparent hugepage allocations\n",
> +                       pr_info("raising user specified min_free_kbytes f=
rom %d to %lu to help transparent hugepage allocations\n",
> +                               min_free_kbytes, recommended_min);
> +               else
> +                       pr_info("raising default min_free_kbytes from %d =
to %lu to help transparent hugepage allocations\n",
>                                 min_free_kbytes, recommended_min);
>
>                 min_free_kbytes =3D recommended_min;
> @@ -2601,6 +2612,13 @@ static void set_recommended_min_free_kbytes(void)
>         setup_per_zone_wmarks();
>  }
>
> +static int __init setup_transparent_hugepage_recommend_disable(char *str=
)
> +{
> +       transparent_hugepage_recommend =3D 0;
> +       return 1;
> +}
> +__setup("transparent_hugepage_recommend_disable", setup_transparent_huge=
page_recommend_disable);
> +
>  int start_stop_khugepaged(void)
>  {
>         int err =3D 0;
> --
> 2.19.1.6.gb485710b
>
>
