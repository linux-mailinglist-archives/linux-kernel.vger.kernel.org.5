Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EF2580984D
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 02:02:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235574AbjLHBCW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 20:02:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230510AbjLHBCU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 20:02:20 -0500
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BC46D59
        for <linux-kernel@vger.kernel.org>; Thu,  7 Dec 2023 17:02:26 -0800 (PST)
Received: by mail-pl1-x62f.google.com with SMTP id d9443c01a7336-1d0c94397c0so12237685ad.2
        for <linux-kernel@vger.kernel.org>; Thu, 07 Dec 2023 17:02:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1701997345; x=1702602145; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=IHjpYG+aTG+cGWCfpcLI6dqd/B/j+rYpLgN/+rREz9Y=;
        b=oGY1xCSVLMH2HUOCihrvU5FyDOcRXlFz3TUaXWvtJcvfHO6lXyj25xy1IEBaebLJiD
         6QvGXxWccw74IrPM1jrgOKIS3clt1v2rBGpTfgsYOLhJRNg1P6VGQ92I4O8HHqirXEke
         /XXDfPJQBIpiQOMYsDgP3pmRS6juBl+jqYWDHj90THCrMTF33ulb/wdph90g3YdgRZhs
         gyaPAD/5FCa+8DIITIRIGxkXObKaZuxW9HsfXcozPSkp6ZwpP3j7okkBsc6HeIbE9eU9
         ahHG6iytt7/CuBKbTWLqvnPWahO+q4UWoj9TOcgrIZh9x1w88F++IqCU75bpz3vPywm6
         eiZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701997345; x=1702602145;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IHjpYG+aTG+cGWCfpcLI6dqd/B/j+rYpLgN/+rREz9Y=;
        b=uUYOTXerG8ugvp5OoHgcZU1m2VedC9393qtXGMy/cY16G+gTNh4N1V0XgZAVomc8ld
         AVwMeu0iS8OBCh8Lfino/JAxV/rnOBjzAybQRqTaWqJvsNladSxlf9WadMnLA2t7hCUd
         UoEQk3cjRsDRDCNP1WfyXKLq20fdYdLYUX+kdrc21UnEAdOck9UaOb+Pe6OQpiMP8AUa
         D1W1gtpoXXMNZJ6mpHH5OUNQnzbscZHjqYjsVimjtfOfNhkMqY9bOGtRlt0rBVRHfk7K
         V9tpgWKMavaNlEPifM9FG9aml/tcH7RUsu5izV91JDBb8UCeB86MtEmYJYmdjkMFM4ER
         E1ag==
X-Gm-Message-State: AOJu0Yz6XMwm0sdxeKt2qP+cnsTcKjJsE+I4yRZAmHAwdD0bOBdjf5WD
        6u6QnlGWSrZqPXnI5vWER1MsQw==
X-Google-Smtp-Source: AGHT+IETnkjdJb69QIsZhyHN/XmPatwPLHf0ROdLScBWbQw+jQfCeWBk6Qo8WhgUG+EzAY3jUQSopQ==
X-Received: by 2002:a17:903:32ca:b0:1d0:6ffd:ae05 with SMTP id i10-20020a17090332ca00b001d06ffdae05mr3258630plr.108.1701997345466;
        Thu, 07 Dec 2023 17:02:25 -0800 (PST)
Received: from ghost ([12.44.203.122])
        by smtp.gmail.com with ESMTPSA id g24-20020a170902869800b001bc930d4517sm436637plo.42.2023.12.07.17.02.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Dec 2023 17:02:24 -0800 (PST)
Date:   Thu, 7 Dec 2023 17:02:16 -0800
From:   Charlie Jenkins <charlie@rivosinc.com>
To:     Maxim Kochetkov <fido_max@inbox.ru>
Cc:     linux-riscv@lists.infradead.org, bigunclemax@gmail.com,
        Amma Lee <lixiaoyun@binary-semi.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Conor Dooley <conor.dooley@microchip.com>,
        Andrew Jones <ajones@ventanamicro.com>,
        Jisheng Zhang <jszhang@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/1] riscv: optimize ELF relocation function in riscv
Message-ID: <ZXJrGLwxtjf6cK42@ghost>
References: <20230913130501.287250-1-fido_max@inbox.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230913130501.287250-1-fido_max@inbox.ru>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 13, 2023 at 04:05:00PM +0300, Maxim Kochetkov wrote:
> The patch can optimize the running times of insmod command by modify ELF
> relocation function.
> In the 5.10 and latest kernel, when install the riscv ELF drivers which
> contains multiple symbol table items to be relocated, kernel takes a lot
> of time to execute the relocation. For example, we install a 3+MB driver
> need 180+s.
> We focus on the riscv architecture handle R_RISCV_HI20 and R_RISCV_LO20
> type items relocation function in the arch\riscv\kernel\module.c and
> find that there are two-loops in the function. If we modify the begin
> number in the second for-loops iteration, we could save significant time
> for installation. We install the same 3+MB driver could just need 2s.
> 
> Signed-off-by: Amma Lee <lixiaoyun@binary-semi.com>
> Signed-off-by: Maxim Kochetkov <fido_max@inbox.ru>
> ---
> Changes in v4:
> - use 'while' loop instead of 'for' loop to avoid code duplicate
> ---
>  arch/riscv/kernel/module.c | 20 ++++++++++++++++----
>  1 file changed, 16 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/riscv/kernel/module.c b/arch/riscv/kernel/module.c
> index 7c651d55fcbd..8c9b644ebfdb 100644
> --- a/arch/riscv/kernel/module.c
> +++ b/arch/riscv/kernel/module.c
> @@ -346,6 +346,7 @@ int apply_relocate_add(Elf_Shdr *sechdrs, const char *strtab,
>  	Elf_Sym *sym;
>  	u32 *location;
>  	unsigned int i, type;
> +	unsigned int j_idx = 0;
>  	Elf_Addr v;
>  	int res;
>  
> @@ -384,9 +385,10 @@ int apply_relocate_add(Elf_Shdr *sechdrs, const char *strtab,
>  		v = sym->st_value + rel[i].r_addend;
>  
>  		if (type == R_RISCV_PCREL_LO12_I || type == R_RISCV_PCREL_LO12_S) {
> -			unsigned int j;
> +			unsigned int j = j_idx;
> +			bool found = false;
>  
> -			for (j = 0; j < sechdrs[relsec].sh_size / sizeof(*rel); j++) {
> +			do {
>  				unsigned long hi20_loc =
>  					sechdrs[sechdrs[relsec].sh_info].sh_addr
>  					+ rel[j].r_offset;
> @@ -415,16 +417,26 @@ int apply_relocate_add(Elf_Shdr *sechdrs, const char *strtab,
>  					hi20 = (offset + 0x800) & 0xfffff000;
>  					lo12 = offset - hi20;
>  					v = lo12;
> +					found = true;
>  
>  					break;
>  				}
> -			}
> -			if (j == sechdrs[relsec].sh_size / sizeof(*rel)) {
> +
> +				j++;
> +				if (j > sechdrs[relsec].sh_size / sizeof(*rel))
> +					j = 0;
Very interesting algorithm here. Assuming the hi relocation is after the
previous one seems to be a good heuristic. However I think we can do
better. In GNU ld, a hashmap of all of the hi relocations is stored and
a list of all of the lo relocations. After all of the other relocations
have been parsed, it iterates through all of the lo relocations and
looks up the associated hi relocation in the hashmap.

There is more memory overhead here but I suspect it will be faster. I
had started to mock up a hashmap implementation to see if it was faster
but decided I should mention it here first in case somebody had some
additional insight. 

- Charlie

> +
> +			} while (j_idx != j);
> +
> +			if (!found) {
>  				pr_err(
>  				  "%s: Can not find HI20 relocation information\n",
>  				  me->name);
>  				return -EINVAL;
>  			}
> +
> +			/* Record the previous j-loop end index */
> +			j_idx = j;
>  		}
>  
>  		res = handler(me, location, v);
> -- 
> 2.40.1
> 
> 
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv
