Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C981766DB0
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 14:57:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236021AbjG1M5M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 08:57:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233660AbjG1M5J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 08:57:09 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7369F30FA
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jul 2023 05:57:07 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id 2adb3069b0e04-4fe0e34f498so3466547e87.2
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jul 2023 05:57:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1690549026; x=1691153826;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7TcuxbE1UmD9Aws4Vk4iwIGKsEWIhL1t3hDINkZP8BM=;
        b=MJq+yStd64RJULVR6xIyGKMfDvJY/8gPnfCgrWUJ2PGBeiEnLeBY+gxcUgbEZhMYah
         OOl137jgbX5DbfJSptbCfz75WzP42GHTgJBubqWJI0NfAuQ1YO7OrLLyzsaL+otn0o+P
         nkdb2Elzr3r+odfHe2sh9YYEDp1TnroP2YkvgHcGQjKjGOProLgadzRBGENGhEJS84Ys
         SRcPgU3Q4mDBytkFD1slMZEAJMtaQ5QjJ11MPABWQ6zph1XZL9nZVwOnwVPZYVIAHqDG
         frG6dXdhI57xX7QEE+Ct6rAmW2dENPQfYtjqlOo9lMP5InM6v3WXrkSSHBpmbIAaDPNd
         Wcyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690549026; x=1691153826;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7TcuxbE1UmD9Aws4Vk4iwIGKsEWIhL1t3hDINkZP8BM=;
        b=jA68eeL0+Sn2ZACCLyMK9nSsSQFBuqrjw8C+iNSl6kYc3zy0Vzc2+/VWzdUbV+kfhz
         ZKLQgtXKawI4uA3HXMtkOpsFbQqDh3sxSudS4ClppBVYMVOQ5kUvah8Lkv8f1wmLZjE/
         L1Abqha+Zhs2OhuiemNaXwNj/eoKa55Xj+s6Pu6DAjK+l5YyBqdtWhM5PGLBwJG3XhD2
         toXp/MBBVS7ehbkLQ/jsOX1dMwIoF3XsmIZ03MfqiLtxBVXonZQu/QsCuFMeYQlpyX39
         Z+mtSk40FqevaWOHj+KE0WoKO+KCu6C1dSjRlHh76K5nEdAIyK4ftdjbmE0jOif5IksA
         i6Fg==
X-Gm-Message-State: ABy/qLYj86z6Nin8qxq92nncUAkDSCmZpF6EvHdZ1eWwUj3WwOr9FwdR
        04tGUkjdwEPsFMYMiVerMZtIk+AUL+anKhb5vSE=
X-Google-Smtp-Source: APBJJlGAVzKRZrbvPLrokCZ6PchUVUuxj0h7VwayM1HDhdl1TGZU2eHqQdxRs3d1Jy/+SVoWyEI0zw==
X-Received: by 2002:a05:6512:3d06:b0:4f8:4177:e087 with SMTP id d6-20020a0565123d0600b004f84177e087mr1909770lfv.47.1690549025552;
        Fri, 28 Jul 2023 05:57:05 -0700 (PDT)
Received: from localhost (2001-1ae9-1c2-4c00-20f-c6b4-1e57-7965.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:20f:c6b4:1e57:7965])
        by smtp.gmail.com with ESMTPSA id w16-20020a50fa90000000b0052275deb475sm1774659edr.23.2023.07.28.05.57.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jul 2023 05:57:04 -0700 (PDT)
Date:   Fri, 28 Jul 2023 14:57:03 +0200
From:   Andrew Jones <ajones@ventanamicro.com>
To:     Jisheng Zhang <jszhang@kernel.org>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] riscv: vdso.lds.S: merge .data section into .rodata
 section
Message-ID: <20230728-cec389a85a7dc8dcca803e06@orel>
References: <20230726173024.3684-1-jszhang@kernel.org>
 <20230726173024.3684-3-jszhang@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230726173024.3684-3-jszhang@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 27, 2023 at 01:30:23AM +0800, Jisheng Zhang wrote:
> The .data section doesn't need to be separate from .rodata section,
> they are both readonly.
> 
> Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
> ---
>  arch/riscv/kernel/vdso/vdso.lds.S | 15 +++++++--------
>  1 file changed, 7 insertions(+), 8 deletions(-)
> 
> diff --git a/arch/riscv/kernel/vdso/vdso.lds.S b/arch/riscv/kernel/vdso/vdso.lds.S
> index d43fd7c7dd11..671aa21769bc 100644
> --- a/arch/riscv/kernel/vdso/vdso.lds.S
> +++ b/arch/riscv/kernel/vdso/vdso.lds.S
> @@ -29,7 +29,13 @@ SECTIONS
>  	.eh_frame_hdr	: { *(.eh_frame_hdr) }		:text	:eh_frame_hdr
>  	.eh_frame	: { KEEP (*(.eh_frame)) }	:text
>  
> -	.rodata		: { *(.rodata .rodata.* .gnu.linkonce.r.*) }
> +	.rodata		: {
> +		*(.rodata .rodata.* .gnu.linkonce.r.*)
> +		*(.got.plt) *(.got)
> +		*(.data .data.* .gnu.linkonce.d.*)
> +		*(.dynbss)
> +		*(.bss .bss.* .gnu.linkonce.b.*)

Looking at other architectures, it appears the last three lines of
sections could be discarded, but I don't know enough about this to
state they should be.

Thanks,
drew


> +	}
>  
>  	/*
>  	 * This linker script is used both with -r and with -shared.
> @@ -44,13 +50,6 @@ SECTIONS
>  	.alternative : {
>  		*(.alternative)
>  	}
> -
> -	.data		: {
> -		*(.got.plt) *(.got)
> -		*(.data .data.* .gnu.linkonce.d.*)
> -		*(.dynbss)
> -		*(.bss .bss.* .gnu.linkonce.b.*)
> -	}
>  }
>  
>  /*
> -- 
> 2.40.1
> 
