Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A26C47DB101
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Oct 2023 00:27:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232453AbjJ2X11 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Oct 2023 19:27:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231598AbjJ2X1O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Oct 2023 19:27:14 -0400
Received: from mail-yw1-x1133.google.com (mail-yw1-x1133.google.com [IPv6:2607:f8b0:4864:20::1133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99DE57A8D
        for <linux-kernel@vger.kernel.org>; Sun, 29 Oct 2023 16:19:48 -0700 (PDT)
Received: by mail-yw1-x1133.google.com with SMTP id 00721157ae682-5af6c445e9eso27387387b3.0
        for <linux-kernel@vger.kernel.org>; Sun, 29 Oct 2023 16:19:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1698621587; x=1699226387; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=xuWU9MUb030nVJsD+BEmc/ZxZiX/gNjtxDSBKfLdpaA=;
        b=bY5+COy6sYWPmzCX68KmfnephgrQBiiItB1EScGi4ZH1Rhac6Bt9zlXFKxQv9qUzBB
         XJhawbYhJq4z7rWK9ieJrp6E3RyRNxDfy1Qnv/lSGtyDqiGFjTj6st1jDR+05RaDn8Zf
         QU37kVCgOF3yvx/+qUTCW86208gKZJ4c79RJkm7kersfdKQX2A3f6shp52Antci4An6z
         r6/Qt6n7XI7O1AFrw/EEPvRiu50Uj8U15DCXKKG4PRiLv3RpZd7UjhE1GY4m34tJ9nF1
         JvaLC9zszFxv+M5K6lhgSDralMfPBxUMy/9D2A+9X2SJfzg6jEGoCuSJzjPYz+5dchee
         13NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698621587; x=1699226387;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xuWU9MUb030nVJsD+BEmc/ZxZiX/gNjtxDSBKfLdpaA=;
        b=KUcx44VfHQe8nEXxe7v7okq8Jn0nT5Yluz2etvRlg58EZuNUKRB3rShXevahQsMwMH
         RTnLBPZBalNp8XRc1rIkKR/Jfl/2qe+00fFflV3+3w+GO3xqBDoyLJZC3c/gNoYvHwWA
         DRG82ANcpab3KNFGnC2W5iEwMyP0OhnVDvfS49WacXaaBVTrJKu78KSMwPAKqnLjEMH9
         wCRitFAewByDrmRjlau/aYnyqAnvCyFn//C2X7lOfHnM8zYvAxDMSYgzsHVydKzNe5rp
         IfyWYu+dGM1YRMf+5xOU0yBIffnA6s9qhzMBsMvRkfpU+6Y/wQhcje0JZKQgo9Z0jvVa
         ejJQ==
X-Gm-Message-State: AOJu0YzF0SnXffaLGegwvxNzYYg3jvtiHz7VulU+vH+pBcmL317rbIT0
        L0eb2xYAmpBXOm1uheUp4H0TGPlrNBZ1u9gHWVrk2g==
X-Google-Smtp-Source: AGHT+IEnpFKWPrIRVQHeaFdGi2QsJDkeV8m8Ju1h+8EhHXVWGlzOH3mBMAnBjd5mEcVeX2yzwvBVR7Y7vhJWP9xOkXQ=
X-Received: by 2002:a81:ad06:0:b0:5a7:b515:ae47 with SMTP id
 l6-20020a81ad06000000b005a7b515ae47mr8100852ywh.9.1698621587653; Sun, 29 Oct
 2023 16:19:47 -0700 (PDT)
MIME-Version: 1.0
References: <20231029194607.379459-1-suijingfeng@loongson.cn> <20231029194607.379459-8-suijingfeng@loongson.cn>
In-Reply-To: <20231029194607.379459-8-suijingfeng@loongson.cn>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Mon, 30 Oct 2023 01:19:36 +0200
Message-ID: <CAA8EJpqrWV1f_pFqZt1Evo+WrZfy1mOynaTQ85uY9o4tVPZJPw@mail.gmail.com>
Subject: Re: [PATCH 7/8] drm/loongson: Support to infer DC reversion from
 CPU's PRID value
To:     Sui Jingfeng <suijingfeng@loongson.cn>
Cc:     Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 29 Oct 2023 at 21:46, Sui Jingfeng <suijingfeng@loongson.cn> wrote:
>
> Due to the fact that the same display IP core has been integrated into
> different platform, there is a need to differentiate them on the runtime.
> The DC in LS7A1000/LS2K1000 has the PCI vendor & device ID of 0x0014:0x7A06
> The DC in LS7A2000/LS2K2000 has the PCI vendor & device ID of 0x0014:0x7A36
>
> Because the output ports and host platform of the DC IP varies, without a
> revision information we can't achieve fine-grained controls. The canonical
> approach to do such a thing is to read reversion register from the PCIe
> device. But LS2K1000 SoC was taped out at 2017, it is rather old. Our BIOS
> engineer don't assign a different revision ID to it, probably because of
> ignorance.
>
> LS2K2000 SoC was newly taped on 2023, we strictly force the BIOS engineer
> assign a different revision ID(0x10) to it. But the problem is that it is
> too casual, there is no formal convention or public documented rule
> established. For Loongson LS2K series SoC, the display controller IP is
> taped togather with the CPU core. For Loongson LS7A series bridge chips,
> the display controller IP is taped togather with the bridge chips itself.
> Consider the fact the all Loongson CPU has a unique PRID, this patch choose
> to infer DC reversion from CPU's PRID value.
>
>  - LS3A4000/LS3A5000 has 0xC0 as its processor ID.
>  - LS2K2000 has 0xB0 as its processor ID.
>  - LS2K2000LA has 0xA0 as its processor ID.
>
> The provided approach has no dependency on DT or ACPI, thus is preferfed.
> Besides, this approach can be used to acquire more addtional HW features.
> So the provided method has the potential to bring more benifits.
>
> Signed-off-by: Sui Jingfeng <suijingfeng@loongson.cn>
> ---
>  drivers/gpu/drm/loongson/lsdc_drv.h   |  2 ++
>  drivers/gpu/drm/loongson/lsdc_probe.c | 35 +++++++++++++++++++++++++++
>  drivers/gpu/drm/loongson/lsdc_probe.h |  2 ++
>  3 files changed, 39 insertions(+)
>
> diff --git a/drivers/gpu/drm/loongson/lsdc_drv.h b/drivers/gpu/drm/loongson/lsdc_drv.h
> index 46ba9b88a30d..e1f4a2db2a0a 100644
> --- a/drivers/gpu/drm/loongson/lsdc_drv.h
> +++ b/drivers/gpu/drm/loongson/lsdc_drv.h
> @@ -42,6 +42,8 @@
>  enum loongson_chip_id {
>         CHIP_LS7A1000 = 0,
>         CHIP_LS7A2000 = 1,
> +       CHIP_LS2K1000 = 2,
> +       CHIP_LS2K2000 = 3,
>         CHIP_LS_LAST,
>  };
>
> diff --git a/drivers/gpu/drm/loongson/lsdc_probe.c b/drivers/gpu/drm/loongson/lsdc_probe.c
> index 48ba69bb8a98..f49b642d8f65 100644
> --- a/drivers/gpu/drm/loongson/lsdc_probe.c
> +++ b/drivers/gpu/drm/loongson/lsdc_probe.c
> @@ -54,3 +54,38 @@ unsigned int loongson_cpu_get_prid(u8 *imp, u8 *rev)
>
>         return prid;
>  }
> +
> +enum loongson_chip_id loongson_chip_id_fixup(enum loongson_chip_id chip_id)
> +{
> +       u8 impl;
> +
> +       if (loongson_cpu_get_prid(&impl, NULL)) {
> +               /*
> +                * LS2K2000 only has the LoongArch edition.
> +                */
> +               if (chip_id == CHIP_LS7A2000) {
> +                       if (impl == LOONGARCH_CPU_IMP_LS2K2000)
> +                               return CHIP_LS2K2000;
> +               }
> +
> +               /*
> +                * LS2K1000 has the LoongArch edition(with two LA264 CPU core)
> +                * and the Mips edition(with two mips64r2 CPU core), Only the
> +                * instruction set of the CPU are changed, the peripheral
> +                * devices are basically same.
> +                */
> +               if (chip_id == CHIP_LS7A1000) {
> +#if defined(__loongarch__)
> +                       if (impl == LOONGARCH_CPU_IMP_LS2K1000)
> +                               return CHIP_LS2K1000;
> +#endif
> +
> +#if defined(__mips__)
> +                       if (impl == LOONGSON_CPU_MIPS_IMP_LS2K)
> +                               return CHIP_LS2K1000;
> +#endif

Can you drop the ifdefs here? The code blocks do not seem to conflict
with each other.

> +               }
> +       }
> +
> +       return chip_id;
> +}
> diff --git a/drivers/gpu/drm/loongson/lsdc_probe.h b/drivers/gpu/drm/loongson/lsdc_probe.h
> index 8bb6de2e3c64..8c630c5c90ce 100644
> --- a/drivers/gpu/drm/loongson/lsdc_probe.h
> +++ b/drivers/gpu/drm/loongson/lsdc_probe.h
> @@ -9,4 +9,6 @@
>  /* Helpers for chip detection */
>  unsigned int loongson_cpu_get_prid(u8 *impl, u8 *rev);
>
> +enum loongson_chip_id loongson_chip_id_fixup(enum loongson_chip_id chip_id);
> +
>  #endif
> --
> 2.34.1
>


-- 
With best wishes
Dmitry
