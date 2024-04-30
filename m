Return-Path: <linux-kernel+bounces-164523-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 36ADE8B7EB7
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 19:36:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 54B621C22745
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 17:36:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8841B1802B8;
	Tue, 30 Apr 2024 17:36:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MAQNwedx"
Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com [209.85.219.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41399176FBE
	for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 17:36:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714498602; cv=none; b=BFtwbJtlVnakHUkexsbkeZWje4SwUqe0gwPjHndJX3foVPNNpfG0dw14xmX/iywnC9YVempCdlVYW2SiXLLg/Pk06bbU+VisnOKogtROTB4OYUxZ1Z1P4vKkIReuI4sk1iEDufxEKrIA+T8CrOGVpDLPzQpihl16E4zvU8IZmnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714498602; c=relaxed/simple;
	bh=xFtSPxUGw71BhdpCbB5jr4yrprGHJkBPo4PeEhElfSo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pltEgvsgK95Gi9TRLDKn4bNkhgodsJF7HyTEQKW+pwb8x0jbUTBjeYJaRlOEkRULYRV3pCjQFZekNSQO4CdMwqX7fJDTBknYsI+x+txJAD1PbfNFv8zRzVoT+3kHns2wWg78TEkwX1TV9MNU8s+dtQ4EapN0cSjcTxGy31FfWTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MAQNwedx; arc=none smtp.client-ip=209.85.219.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f177.google.com with SMTP id 3f1490d57ef6-de60380c04aso2379532276.2
        for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 10:36:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714498600; x=1715103400; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=oxBeIwOcZKLL8JOVHDchIL8pEo8i2juAaZDJd2xhcwQ=;
        b=MAQNwedxoOiedgO7hqHWBkEHPMepLrktR2u9p7ksY1PxQb0iC5VdRniOf71VYDBjYn
         mpdbao3otqPw+lKHFn9t/ht53btCslapKM2bLmPluTxIDPUfpyh3u1DKtGxhRcJJW/nl
         4FtfGLpZ5zJvUG1tVx2/I0ecTAbtAP2jEtm0ZM6zfKOc8SSKri2KqtCjxtE4B3zLizJH
         rvCGDlAndzfiaelC09rT3WhVbyMS2YaANPdKdS9xTeNg4pnoIzbb0Qa3qqmZIm2W3zLv
         cBvqXs2oJnfLWgL5V3hcx5MJKuUWd/rvtQt3k8poOw4rasoAewpulIqT17zCMy2ULbQx
         8EtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714498600; x=1715103400;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oxBeIwOcZKLL8JOVHDchIL8pEo8i2juAaZDJd2xhcwQ=;
        b=O/6bUgRHnl+W02J15jn/GawRz4nmJBK5SOEux1OystpxiYRO1/vDo/4BnAEiU7kB0i
         dtRydI4mbjFNotye2GFhXPl0Ic2VFyTIJTbxqu4HnGhvWT+2ly6h/2L6hWzohzK/nkb7
         OlxsOdRVv7e7tsgj3RHjKbRSgTZDN/uU5jMF1NOEgVPlhguMuWVKFh4U83ekJsKGPCc0
         9O91H1NbwaSBQOZgw1RIcrJstv8c0AUJAguH64307zt+pknQIPEC3lNcwCci79PegP1F
         /ktfE5WUXMts6r9FA1hquh6feGfjDdhn/ciRKzaBSgeEkM+PqvgB3LmWp7/ggupfpUoe
         guXg==
X-Forwarded-Encrypted: i=1; AJvYcCXgoMWTbQR6oEs5vHnxn/D4t82IANK4zF/7E3ZK2tal6CIqsbP60Cq0aiZLmkaEwXBllnPoiVUMOGEy85Pa05Eb0gsvC0764WYcCds1
X-Gm-Message-State: AOJu0YxclNp/iyAG1RXBwwH9LB2XlymQ5G0oA55ZaErwrT4R71y6sHK5
	iUaT6fzkrmzsBA3i0O5T3yggkqcJfZsLlHSr3EFza37DVfEoLqvu
X-Google-Smtp-Source: AGHT+IFdLlgVSHPImCdrSXAGylwVxQtS1e09FxMyULFCPryK+Fwz3ny2rn59lc2hJMWhZMY5Iw/Hlg==
X-Received: by 2002:a25:7446:0:b0:de4:6c1f:8275 with SMTP id p67-20020a257446000000b00de46c1f8275mr327293ybc.29.1714498599970;
        Tue, 30 Apr 2024 10:36:39 -0700 (PDT)
Received: from localhost ([69.73.66.55])
        by smtp.gmail.com with ESMTPSA id y9-20020a2586c9000000b00dc9c5991ecdsm6061092ybm.50.2024.04.30.10.36.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Apr 2024 10:36:39 -0700 (PDT)
Date: Tue, 30 Apr 2024 10:36:38 -0700
From: Yury Norov <yury.norov@gmail.com>
To: Kuan-Wei Chiu <visitorckw@gmail.com>
Cc: akpm@linux-foundation.org, linux@rasmusvillemoes.dk,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] bitops: Optimize fns() for improved performance
Message-ID: <ZjEsJu3L/pfDcl09@yury-ThinkPad>
References: <20240430054912.124237-1-visitorckw@gmail.com>
 <20240430054912.124237-3-visitorckw@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240430054912.124237-3-visitorckw@gmail.com>

On Tue, Apr 30, 2024 at 01:49:12PM +0800, Kuan-Wei Chiu wrote:
> The current fns() repeatedly uses __ffs() to find the index of the
> least significant bit and then clears the corresponding bit using
> __clear_bit(). The method for clearing the least significant bit can be
> optimized by using word &= word - 1 instead.
> 
> Typically, the execution time of one __ffs() plus one __clear_bit() is
> longer than that of a bitwise AND operation and a subtraction. To
> improve performance, the loop for clearing the least significant bit
> has been replaced with word &= word - 1, followed by a single __ffs()
> operation to obtain the answer. This change reduces the number of
> __ffs() iterations from n to just one, enhancing overall performance.
> 
> This change speeds up the find_nth_bit() in the find_bit benchmark by
> approximately ~1.26 times:

26% sounds better.

> Before:
> find_nth_bit:                  4254313 ns,  16525 iterations
> 
> After:
> find_nth_bit:                  3362863 ns,  16501 iterations
> 
> The following microbenchmark data, conducted on my x86-64 machine,
> shows the execution time (in microseconds) required for 1000000 test
> data generated by get_random_u64() and executed by fns() under
> different values of n:
> 
> +-----+---------------+---------------+
> |  n  |   time_old    |   time_new    |
> +-----+---------------+---------------+
> |  0  |     29194     |     25878     |
> |  1  |     25510     |     25497     |
> |  2  |     27836     |     25721     |
> |  3  |     30140     |     25673     |
> |  4  |     32569     |     25426     |
> |  5  |     34792     |     25690     |
> |  6  |     37117     |     25651     |
> |  7  |     39742     |     25383     |
> |  8  |     42360     |     25657     |
> |  9  |     44672     |     25897     |
> | 10  |     47237     |     25819     |
> | 11  |     49884     |     26530     |
> | 12  |     51864     |     26647     |
> | 13  |     54265     |     28915     |
> | 14  |     56440     |     28373     |
> | 15  |     58839     |     28616     |
> | 16  |     62383     |     29128     |
> | 17  |     64257     |     30041     |
> | 18  |     66805     |     29773     |
> | 19  |     69368     |     33203     |
> | 20  |     72942     |     33688     |
> | 21  |     77006     |     34518     |
> | 22  |     80926     |     34298     |
> | 23  |     85723     |     35586     |
> | 24  |     90324     |     36376     |
> | 25  |     95992     |     37465     |
> | 26  |    101101     |     37599     |
> | 27  |    106520     |     37466     |
> | 28  |    113287     |     38163     |
> | 29  |    120552     |     38810     |
> | 30  |    128040     |     39373     |
> | 31  |    135624     |     40500     |
> | 32  |    142580     |     40343     |
> | 33  |    148915     |     40460     |
> | 34  |    154005     |     41294     |
> | 35  |    157996     |     41730     |
> | 36  |    160806     |     41523     |
> | 37  |    162975     |     42088     |
> | 38  |    163426     |     41530     |
> | 39  |    164872     |     41789     |
> | 40  |    164477     |     42505     |
> | 41  |    164758     |     41879     |
> | 42  |    164182     |     41415     |
> | 43  |    164842     |     42119     |
> | 44  |    164881     |     42297     |
> | 45  |    164870     |     42145     |
> | 46  |    164673     |     42066     |
> | 47  |    164616     |     42051     |
> | 48  |    165055     |     41902     |
> | 49  |    164847     |     41862     |
> | 50  |    165171     |     41960     |
> | 51  |    164851     |     42089     |
> | 52  |    164763     |     41717     |
> | 53  |    164635     |     42154     |
> | 54  |    164757     |     41983     |
> | 55  |    165095     |     41419     |
> | 56  |    164641     |     42381     |
> | 57  |    164601     |     41654     |
> | 58  |    164864     |     41834     |
> | 59  |    164594     |     41920     |
> | 60  |    165207     |     42020     |
> | 61  |    165056     |     41185     |
> | 62  |    165160     |     41722     |
> | 63  |    164923     |     41702     |
> | 64  |    164777     |     41880     |
> +-----+---------------+---------------+

Please, just a total gross in the commit message.
 
> Signed-off-by: Kuan-Wei Chiu <visitorckw@gmail.com>
> ---
> 
> Changes in v2:
> - Change the loop in fns() by counting down from n to 0.
> - Add find_bit benchmark result for find_nth_bit in commit message.
> 
>  include/linux/bitops.h | 12 +++---------
>  1 file changed, 3 insertions(+), 9 deletions(-)
> 
> diff --git a/include/linux/bitops.h b/include/linux/bitops.h
> index 2ba557e067fe..57ecef354f47 100644
> --- a/include/linux/bitops.h
> +++ b/include/linux/bitops.h
> @@ -254,16 +254,10 @@ static inline unsigned long __ffs64(u64 word)
>   */
>  static inline unsigned long fns(unsigned long word, unsigned int n)
>  {
> -	unsigned int bit;
> +	while (word && n--)
> +		word &= word - 1;
>  
> -	while (word) {
> -		bit = __ffs(word);
> -		if (n-- == 0)
> -			return bit;
> -		__clear_bit(bit, &word);
> -	}
> -
> -	return BITS_PER_LONG;
> +	return word ? __ffs(word) : BITS_PER_LONG;
>  }
>  
>  /**
> -- 
> 2.34.1

