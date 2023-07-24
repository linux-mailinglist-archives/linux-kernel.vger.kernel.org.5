Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89CA875EAE5
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 07:34:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229956AbjGXFeq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 01:34:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229941AbjGXFeo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 01:34:44 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6986DE43
        for <linux-kernel@vger.kernel.org>; Sun, 23 Jul 2023 22:34:42 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id d9443c01a7336-1b9ecf0cb4cso21370345ad.2
        for <linux-kernel@vger.kernel.org>; Sun, 23 Jul 2023 22:34:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690176881; x=1690781681;
        h=content-transfer-encoding:in-reply-to:mime-version:user-agent:date
         :message-id:from:references:cc:to:subject:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CrRCs9J9cuqFytw0CPsTvJ0/VgtZFNZF2StTT2ELhYQ=;
        b=QNd/QcPvcruooUOIbD5r6HqalozOx29e4KE4dL4CktOGQTb8pvqoAas1HziuVSBmRi
         ONZzaGCN5OnsPEXFNrK+EL0JjW/Q35tesDHqKlv77NudflLqq9fe8kwKxklLVs6L+/jk
         uMBGeu3j2eB5FZ5RQuO4Y7RyWThlGaCNnZFfSKEPgj4pz3B9L2rooB6iu6DBx4i/QqBT
         FylWcPrrs1xbjZGDQK/yIs4F9xfxIEjIHNgrkeNi5WB1+2qQEmUaV4+WJz9cUuL06BpT
         Uxzd2ugL6q9wMfoAzh2XIfVqNN+jc8RseYguWsBKntzh7Oe2SXwGXW8I4zknRu+C6YF+
         5LdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690176881; x=1690781681;
        h=content-transfer-encoding:in-reply-to:mime-version:user-agent:date
         :message-id:from:references:cc:to:subject:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=CrRCs9J9cuqFytw0CPsTvJ0/VgtZFNZF2StTT2ELhYQ=;
        b=Fa7nDr6fFkbEcf7tKZY6rgTPtXYVO9g3fYd7L6KyhewEzxTjCLvVyjryxco9kMXAcp
         d1Z039h8gHG+Kb34TIzUpVG55eN21gn8wIcTrS1449Yq7M1lGQE2zQtWfrJ2II3RZCQD
         VZ7eGpPJcNyA7rkofKv0mm6X4uXMfb0s2jDngzNbmkdk/oO9pDhygpnyC8MXa4NCL4Ct
         ibHoCMEh20CsK6wvQnfDGqf9d3uQdHl+lW/BKgXsZoqg2nuJqQtgbq2IbGXFCjM6LHSM
         L0r/t8THi2nGnK73p2xdLEqSTI5Sp8aCcJCdAMMzc6QVPhqIYP/C1ll1D6pg4Io661RG
         kvbQ==
X-Gm-Message-State: ABy/qLZ9gf80JIZZ1m00rV+Hxl6Ab37+U25hSsRFscg4xWZ7DvK5jpFw
        TTnQrG3u1Vz5eRLNAiMk/QkWxCHM2DA=
X-Google-Smtp-Source: APBJJlGYQmm1yrikG0bziSH6O/bk592oPBNWHtfn+yfH3VGi/UD+ryBeFDTfYs8FpGzJ+DcBkJM5Ww==
X-Received: by 2002:a17:90a:d803:b0:268:a26:d9ee with SMTP id a3-20020a17090ad80300b002680a26d9eemr3112946pjv.46.1690176880778;
        Sun, 23 Jul 2023 22:34:40 -0700 (PDT)
Received: from Schmitz-MacBook-Pro.local (222-152-184-54-fibre.sparkbb.co.nz. [222.152.184.54])
        by smtp.googlemail.com with ESMTPSA id s26-20020a63a31a000000b0055c178a8df1sm7394104pge.94.2023.07.23.22.34.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 23 Jul 2023 22:34:40 -0700 (PDT)
Subject: Re: [PATCH] m68knommu: Fix warnings in io_no.h: Delete one of
 repeated word 'readw readl writew writel' in comment. WARNING: Possible
 repeated word: 'readw' WARNING: Possible repeated word: 'readl' WARNING:
 Possible repeated word: 'writew' WARNING: Possible repeated word: 'writel'
To:     huzhi001@208suo.com, gerg@linux-m68k.org, geert@linux-m68k.org
Cc:     linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org
References: <tencent_816D5035481D1083943D8E965A59860D5E06@qq.com>
 <9e13fec02524afde21bdf5783dcf7246@208suo.com>
From:   Michael Schmitz <schmitzmic@gmail.com>
Message-ID: <b0c9bf6d-786d-29b8-7811-e132534227fe@gmail.com>
Date:   Mon, 24 Jul 2023 17:34:34 +1200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.11; rv:78.0)
 Gecko/20100101 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <9e13fec02524afde21bdf5783dcf7246@208suo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

please reconsider - "#define something something" is legitimate use, and
quite intentional.

Pattern matching can only get you so far, sorry ...

Cheers,

    Michael

Am 24.07.23 um 12:40 schrieb huzhi001@208suo.com:
> Signed-off-by: ZhiHu <huzhi001@208suo.com>
> ---
>  arch/m68k/include/asm/io_no.h | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/arch/m68k/include/asm/io_no.h
> b/arch/m68k/include/asm/io_no.h
> index 2c96e8480173..b24eb741e666 100644
> --- a/arch/m68k/include/asm/io_no.h
> +++ b/arch/m68k/include/asm/io_no.h
> @@ -62,7 +62,7 @@ static int cf_internalio(const volatile void __iomem
> *addr)
>   * endian on m68k/ColdFire. Bus based address ranges, like the PCI bus,
>   * are accessed little endian - so we need to byte swap those.
>   */
> -#define readw readw
> +#define readw
>  static inline u16 readw(const volatile void __iomem *addr)
>  {
>      if (cf_internalio(addr))
> @@ -70,7 +70,7 @@ static inline u16 readw(const volatile void __iomem
> *addr)
>      return swab16(__raw_readw(addr));
>  }
>
> -#define readl readl
> +#define readl
>  static inline u32 readl(const volatile void __iomem *addr)
>  {
>      if (cf_internalio(addr))
> @@ -78,7 +78,7 @@ static inline u32 readl(const volatile void __iomem
> *addr)
>      return swab32(__raw_readl(addr));
>  }
>
> -#define writew writew
> +#define writew
>  static inline void writew(u16 value, volatile void __iomem *addr)
>  {
>      if (cf_internalio(addr))
> @@ -87,7 +87,7 @@ static inline void writew(u16 value, volatile void
> __iomem *addr)
>          __raw_writew(swab16(value), addr);
>  }
>
> -#define writel writel
> +#define writel
>  static inline void writel(u32 value, volatile void __iomem *addr)
>  {
>      if (cf_internalio(addr))
