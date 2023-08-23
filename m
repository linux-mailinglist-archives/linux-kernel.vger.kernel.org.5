Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B2A97851A3
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 09:35:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233397AbjHWHfG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 03:35:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231473AbjHWHfE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 03:35:04 -0400
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com [IPv6:2607:f8b0:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81CA6E72
        for <linux-kernel@vger.kernel.org>; Wed, 23 Aug 2023 00:34:59 -0700 (PDT)
Received: by mail-oi1-x22f.google.com with SMTP id 5614622812f47-3a81154c5f5so3563280b6e.1
        for <linux-kernel@vger.kernel.org>; Wed, 23 Aug 2023 00:34:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=monstr-eu.20221208.gappssmtp.com; s=20221208; t=1692776099; x=1693380899;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KeOy8rB4aqL4Xzbr1ytZ4fk0Rr7Hk4+R5GsKeEbg62s=;
        b=m3Nt1QpJ8ldYsiFraoQb2GQF970/6Cl7+xQcmlGLK5mrAS7dFv1XTFCZcdRGZqhAkL
         Fh/OwP446OY2wLXDssEzqiIHFKbj4dHQyg6QwOOBZ/S3SnblCQeQ24f8OKbdBOUpzv0h
         YYx+5pBf70d7YTXIVNRYHuJGkxJ1aMNdQn6NpthzQqriJV9bxtyyknZHHmfswnW9kYPF
         TVwJ89eFTKK+aLwiAXL+muYlYmd73c8Er4ukHWrGH0wF2wFR+rQE5NzaeDRiMDAcYdkW
         /h7yqA4IdPdTsi+OBaR5c0cSSD/oiPc60PCCHrCwOhNp8NTfwCfYK9iNS7B8PT/CWKjB
         67hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692776099; x=1693380899;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KeOy8rB4aqL4Xzbr1ytZ4fk0Rr7Hk4+R5GsKeEbg62s=;
        b=dg7j1kSQlhCwVibr4g/I2nLimfoF/gTnE/8revOx5LM9pfAWKUqPFJtmjtGHlsqw8b
         zT8zOEMw/ffLd6/VJfGSv4XgoiGfGoiRRERWma+EIsGOof3ze/+G3hABLhSXG1SkDDVN
         yoSoPXOlQq0TGEprFkFqiL5eimGDJKLYJquAcFxzMjBNY1Huzh3IuoEtnlgvKUzJ0jf/
         Act/14KGhB+GEF1DnKYqcjl1qDpR/Cz1bJDU7ZBwYc9M/xqygxeAsUuhL41MC1ejTdQz
         dw+jiXpiLheu24a3y+RR6m9gpZMG3BCuiTJa+4YUClJYcsdZ6ZzD/ImIV+lsSiA8bGwx
         eQ/w==
X-Gm-Message-State: AOJu0YzjaAGKI08UDopszkIA+YsIJwQHPNegT2aImKoU68MbiZe97qzl
        siPWE6HkMAJcoENj1yJYxohiTA==
X-Google-Smtp-Source: AGHT+IFSyfbeh3k7Ppr5ga1cUW0Bxh7M9asthVfft5GudLGidCddcjejFEnK1hywZmL8xXqsnzwWFQ==
X-Received: by 2002:aca:1212:0:b0:3a3:6f20:39b4 with SMTP id 18-20020aca1212000000b003a36f2039b4mr11228402ois.29.1692776098869;
        Wed, 23 Aug 2023 00:34:58 -0700 (PDT)
Received: from [192.168.137.2] ([149.199.80.128])
        by smtp.gmail.com with ESMTPSA id s7-20020aa78d47000000b0068620bee456sm8762916pfe.209.2023.08.23.00.34.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Aug 2023 00:34:58 -0700 (PDT)
Message-ID: <63e5eac9-6c90-f343-49e1-01d4d23e9dfd@monstr.eu>
Date:   Wed, 23 Aug 2023 09:34:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH 08/17] microblaze: mark flush_dcache_folio() inline
Content-Language: en-US
To:     Arnd Bergmann <arnd@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        "Mike Rapoport (IBM)" <rppt@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>
References: <20230810141947.1236730-1-arnd@kernel.org>
 <20230810141947.1236730-9-arnd@kernel.org>
From:   Michal Simek <monstr@monstr.eu>
In-Reply-To: <20230810141947.1236730-9-arnd@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/10/23 16:19, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> The newly added flush_dcache_folio() causes a harmless warning that
> turns into a build failure with CONFIG_WERROR:
> 
> arch/microblaze/include/asm/cacheflush.h:77:13: error: 'flush_dcache_folio' defined but not used [-Werror=unused-function]
> 
> Mark it as inline to avoid this.
> 
> Fixes: 1330c94f53996 ("microblaze: implement the new page table range API")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>   arch/microblaze/include/asm/cacheflush.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/microblaze/include/asm/cacheflush.h b/arch/microblaze/include/asm/cacheflush.h
> index e6641ff98cb30..ffa2cf3893e4b 100644
> --- a/arch/microblaze/include/asm/cacheflush.h
> +++ b/arch/microblaze/include/asm/cacheflush.h
> @@ -74,7 +74,7 @@ do { \
>   	flush_dcache_range((unsigned) (addr), (unsigned) (addr) + PAGE_SIZE); \
>   } while (0);
>   
> -static void flush_dcache_folio(struct folio *folio)
> +static inline void flush_dcache_folio(struct folio *folio)
>   {
>   	unsigned long addr = folio_pfn(folio) << PAGE_SHIFT;
>   

This patch depends on e77d93073327 ("microblaze: implement the new page table
range API")
which has been taken by Andrew via his tree that's why

Acked-by: Michal Simek <michal.simek@amd.com>

If this is not pick up by Andrew I will take it after merge windows is closed.

Thanks,
Michal


-- 
Michal Simek, Ing. (M.Eng), OpenPGP -> KeyID: FE3D1F91
w: www.monstr.eu p: +42-0-721842854
Maintainer of Linux kernel - Xilinx Microblaze
Maintainer of Linux kernel - Xilinx Zynq ARM and ZynqMP/Versal ARM64 SoCs
U-Boot custodian - Xilinx Microblaze/Zynq/ZynqMP/Versal/Versal NET SoCs
TF-A maintainer - Xilinx ZynqMP/Versal/Versal NET SoCs
