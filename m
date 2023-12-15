Return-Path: <linux-kernel+bounces-1764-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BB4928153B3
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 23:33:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F173CB22F7F
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 22:33:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FCCC18EB8;
	Fri, 15 Dec 2023 22:33:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="GJjZijPr"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B89113AC6
	for <linux-kernel@vger.kernel.org>; Fri, 15 Dec 2023 22:33:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-6d9f879f784so902089a34.2
        for <linux-kernel@vger.kernel.org>; Fri, 15 Dec 2023 14:33:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1702679595; x=1703284395; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Z6gE5MsrAaAORf3VjfmyHVqm+yqircqVcZWJ66dQBiE=;
        b=GJjZijPrRZJtU65a1Wv+o9R0gpgwdTvlYlDeT4K0p1wUeXWyt71xbL+avcWDRoHYxF
         nKC/Wt89SpZlxWY/uUpbi7oqaHlzS36LW2i2nxcUwu/p3rPsrPHxNmvD6OsJMlhNbQoh
         0KVIKvdkVjptOjygVPKBUTNWf/9Ty3iaM+DV/DNiZg62fdKlMlb9D/kODBcrZ+CTqLJa
         7hF5giyG6Pif95Z1LOTMQf9CWPRSUmyZVlm/fFkuG8ZycRY5uGoUfFcP5i4SMn/wIbu8
         cxiXMDlip5FwBkXpJiigC/U4THsoam6eOw3tfi+HzUcTv9bbWKU0O02/TKEgixqgCyPJ
         ql3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702679595; x=1703284395;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z6gE5MsrAaAORf3VjfmyHVqm+yqircqVcZWJ66dQBiE=;
        b=AoyVHNFbPHA4wlPvcohngSFjilzKRmDd8/Sn3JTh0BbJpDE5xDYtyvZyJgJ+7qJGE3
         kqB/wlr4ddeSCgzVEVZnKkax5GNcl8nnfnr/apWBa1S1o/jNaKULGPqsdRGD7B5LCZQz
         6rPwQ6xw5667dcy9SmhS6zDhCCd8O8gSGRgOk4Bm7c1DbTJQQCOR44jrQZ4a8wV06XFj
         whUMfEEqOp1IKkONliIe21x5ALWXG2o8fV/STNjkP3Vx7BeVEDf07g6ZaMCNkwTuBKIq
         l6hpaEgfM2IQBzCxVQv+IA47F2ufEokgITtNdUpW6ZxfWsb15ccRJGnWAMkS5rVRqNDC
         7QJA==
X-Gm-Message-State: AOJu0YyZRw7U1DZraBkq385AUa/+FZNwxMGoSTcdGtCYJOhgH6sCcRm6
	SoIGwq7Qubgqn38O5zuZQKFwGg==
X-Google-Smtp-Source: AGHT+IHAjy/n+9LSsWcF/6bO2PqjY1xvSOY9SLi18Nb1Y+tenM+ZEAVFDierCTE97UZVs23EOm4Viw==
X-Received: by 2002:a9d:5603:0:b0:6d9:e8e6:d00c with SMTP id e3-20020a9d5603000000b006d9e8e6d00cmr10217426oti.40.1702679595243;
        Fri, 15 Dec 2023 14:33:15 -0800 (PST)
Received: from ghost ([12.44.203.122])
        by smtp.gmail.com with ESMTPSA id x11-20020aa793ab000000b006ce497add69sm14013700pff.103.2023.12.15.14.33.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Dec 2023 14:33:14 -0800 (PST)
Date: Fri, 15 Dec 2023 14:33:12 -0800
From: Charlie Jenkins <charlie@rivosinc.com>
To: Alexandre Ghiti <alexghiti@rivosinc.com>
Cc: Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	syzbot+afb726d49f84c8d95ee1@syzkaller.appspotmail.com
Subject: Re: [PATCH -fixes v2] riscv: Fix wrong usage of lm_alias() when
 splitting a huge linear mapping
Message-ID: <ZXzUKD95hmTPDbaq@ghost>
References: <20231212195400.128457-1-alexghiti@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231212195400.128457-1-alexghiti@rivosinc.com>

On Tue, Dec 12, 2023 at 08:54:00PM +0100, Alexandre Ghiti wrote:
> lm_alias() can only be used on kernel mappings since it explicitly uses
> __pa_symbol(), so simply fix this by checking where the address belongs
> to before.
> 
> Fixes: 311cd2f6e253 ("riscv: Fix set_memory_XX() and set_direct_map_XX() by splitting huge linear mappings")
> Reported-by: syzbot+afb726d49f84c8d95ee1@syzkaller.appspotmail.com
> Closes: https://lore.kernel.org/linux-riscv/000000000000620dd0060c02c5e1@google.com/
> Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
> ---
> 
> Changes in v2:
> - Fix llvm warning about unitialized return value
> 
>  arch/riscv/mm/pageattr.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/riscv/mm/pageattr.c b/arch/riscv/mm/pageattr.c
> index fc5fc4f785c4..96cbda683936 100644
> --- a/arch/riscv/mm/pageattr.c
> +++ b/arch/riscv/mm/pageattr.c
> @@ -305,8 +305,13 @@ static int __set_memory(unsigned long addr, int numpages, pgprot_t set_mask,
>  				goto unlock;
>  		}
>  	} else if (is_kernel_mapping(start) || is_linear_mapping(start)) {
> -		lm_start = (unsigned long)lm_alias(start);
> -		lm_end = (unsigned long)lm_alias(end);
> +		if (is_kernel_mapping(start)) {
> +			lm_start = (unsigned long)lm_alias(start);
> +			lm_end = (unsigned long)lm_alias(end);
> +		} else {
> +			lm_start = start;
> +			lm_end = end;
> +		}
>  
>  		ret = split_linear_mapping(lm_start, lm_end);
>  		if (ret)
> -- 
> 2.39.2

Reviewed-by: Charlie Jenkins <charlie@rivosinc.com>

> 
> 
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv

