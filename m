Return-Path: <linux-kernel+bounces-16644-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 511FB8241D7
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 13:36:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F3DE0286C26
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 12:36:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CE272137C;
	Thu,  4 Jan 2024 12:36:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UjCgyTSA"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 294371EB57
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jan 2024 12:36:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a1915034144so53148466b.0
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jan 2024 04:36:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1704371759; x=1704976559; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=wA8tdLBKnR1x8I35Fv0XH19oWXShs3g89QU/QFpxadM=;
        b=UjCgyTSAfcLbBbF408fRlDeVqJFxuyWivKrVaKsZDYmxSEHMB7d2WTIiISvlHFmN3j
         wV/ikltavfEbC5+nPxcHH88Peez0QsPxdqTs3WtnL1y+xesjcQpMuXjUDmZdx5NE9KvA
         eoYAhm9nuKo9DnlawnslgfHcFEV05iamnBr5ur4qo8f13iVzu4uUXnhkhQzxupCkNwI8
         4rfvUTeOb0HB+hwPverQoeiQwEIppoNAPMVemGdeU7h+k/YioO1TAzcyDctKBlrWdLgH
         BAAxAVKxPPPaInfS7b1ecCe+QGo10EsL/cuTSfimwzGkiXNmBQUL4iy7X9YGnvRDbEWc
         LjBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704371759; x=1704976559;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wA8tdLBKnR1x8I35Fv0XH19oWXShs3g89QU/QFpxadM=;
        b=vTn/SL9qQB6TWQf002bu0NB2AfgmWdLvVwTm27eDYeegv117NtsYH4F+kuaJzUQOhs
         BwC8R8WlAOJCcH2Jx6r+cKf6rsuS9UlKe+aOSR44bhc8JAJIxYgKBta3UQOz/2eNmLLl
         q8UyaIonPa2pOxLVEAZHLT9Vyzxxa2pOMuAozWyCWG7W7mWZUQcfdJXzwZ+sEoUzPSlI
         BYhdk1eLiX3sfSvB7Y8tRAM6YPGzb/aTYyZFV0Shqy7oxGi82nB81n0Z+7pXS9rz4CwJ
         i28ALeWUm9Kyt0q/wZT1npBIYXrtUROo0f/cHrqf+Rsb9u2QO6SR7thR0Z7lctloaVnv
         tG5w==
X-Gm-Message-State: AOJu0YxYOXz7aOZekim6t/jBEsHGHFM4AwCaQm+MSa9qNZRRXyXsVNGy
	n+pLN29lssR4INxYAErNlRe6yMKfArBksqso5guPBfkl3Gw=
X-Google-Smtp-Source: AGHT+IGEsf/5+Eq93O64/3AUioi3tODLzSGliLS5eYTKrhpMxJDu9nQZTe6WatVkiHprqqTI7tEpDQ==
X-Received: by 2002:a17:906:4:b0:a28:9d4e:f065 with SMTP id 4-20020a170906000400b00a289d4ef065mr215474eja.13.1704371759375;
        Thu, 04 Jan 2024 04:35:59 -0800 (PST)
Received: from localhost ([102.140.209.237])
        by smtp.gmail.com with ESMTPSA id l2-20020a170907914200b00a269b4692a9sm13804758ejs.84.2024.01.04.04.35.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jan 2024 04:35:59 -0800 (PST)
Date: Thu, 4 Jan 2024 15:35:55 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Charlie Jenkins <charlie@rivosinc.com>
Cc: Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Palmer Dabbelt <palmer@rivosinc.com>,
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
	kernel test robot <lkp@intel.com>,
	Dan Carpenter <error27@gmail.com>
Subject: Re: [PATCH v2 4/4] riscv: Convert relocation iterator to do-while
Message-ID: <39727434-a265-484b-9ee6-da6611487b47@moroto.mountain>
References: <20240103-module_loading_fix-v2-0-292b160552c9@rivosinc.com>
 <20240103-module_loading_fix-v2-4-292b160552c9@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240103-module_loading_fix-v2-4-292b160552c9@rivosinc.com>

On Wed, Jan 03, 2024 at 12:22:03PM -0800, Charlie Jenkins wrote:
> Use a do-while loop to iterate through relocation entries to prevent
> curr_type from being marked as uninitialized.
> 
> Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
> Fixes: d8792a5734b0 ("riscv: Safely remove entries from relocation list")
> Reported-by: kernel test robot <lkp@intel.com>
> Reported-by: Dan Carpenter <error27@gmail.com>
> Closes: https://lore.kernel.org/r/202312130859.wnkuzVWY-lkp@intel.com/
> ---
>  arch/riscv/kernel/module.c | 26 +++++++++++++++++++++-----
>  1 file changed, 21 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/riscv/kernel/module.c b/arch/riscv/kernel/module.c
> index ceb0adb38715..581e425686ab 100644
> --- a/arch/riscv/kernel/module.c
> +++ b/arch/riscv/kernel/module.c
> @@ -633,15 +633,31 @@ process_accumulated_relocations(struct module *me,
>  					  bucket_iter->bucket, node) {
>  			buffer = 0;
>  			location = rel_head_iter->location;
> -			list_for_each_entry_safe(rel_entry_iter,
> -						 rel_entry_iter_tmp,
> -						 rel_head_iter->rel_entry,
> -						 head) {
> +			rel_entry_iter =
> +				list_first_entry(rel_head_iter->rel_entry,
> +						 typeof(*rel_entry_iter), head);
> +			rel_entry_iter_tmp =
> +				list_next_entry(rel_entry_iter, head);
> +
> +			/*
> +			 * Iterate through all relocation entries that share
> +			 * this location. This uses a do-while loop instead of
> +			 * list_for_each_entry_safe since it is known that there
> +			 * is at least one entry and curr_type needs to be the
> +			 * value of the last entry when the loop exits.
> +			 */

I know that I reported this static checker and all, but actually after
reading this comment, I think we should stay with original code.  So
long as we know the list has "least one entry" which we do then the
original code worked fine.

To be honest, I probably would not have even reported this static
checker warning except that I saw there were some other issues and
thought "Eh, why not throw this warning in as well, in case the list
can be empty."

The other three patches look good.

regards,
dan carpenter


