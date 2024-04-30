Return-Path: <linux-kernel+bounces-163179-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F36D28B66D3
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 02:18:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 932741F21E48
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 00:18:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AC0D64D;
	Tue, 30 Apr 2024 00:17:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GYBFM52m"
Received: from mail-il1-f174.google.com (mail-il1-f174.google.com [209.85.166.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1278F161
	for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 00:17:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714436274; cv=none; b=Lij2sqn++HjzFQRPDHUs+4SKPnF7Md/ms1/YR17LS0Wspzxz/Mwlb2EBVMBISPY5BcudYoAO/TeZGpdTrOiwwzjf72MBVqihyYF78g3ma/wWwCYrOju/1Bj0hlZotap5Xl5Bf2TH9bQLGTrDtawc2aJ0LWJRfbADs8mpr9xc9bg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714436274; c=relaxed/simple;
	bh=zcQMVubjuiX7aI5h+1mB/JKiS+LzDcsoiUn13gUVidY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q1Ga2T5YXV8qKFSn8IqEsW39TfDboFsf+yrDZ85/oIWQ96daznXyq5+DvS7gs1olblDuOiFIteJyOu/VSVqs3rRwBAft8F1yCrSjsCPwVQpyIhdLcTOkCAZDcBjeTWRlhIolJtyE8VKeOdtCTMMAFvQQDfjQQuaanzIfnSkQ+OQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GYBFM52m; arc=none smtp.client-ip=209.85.166.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-il1-f174.google.com with SMTP id e9e14a558f8ab-36c14e5d54cso20024755ab.1
        for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 17:17:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1714436272; x=1715041072; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Wwskn8wHob0aiuWt7oahW5gvmqR22bCIIQzL1vy/1Vk=;
        b=GYBFM52mYo4rUUhrbqS72PIED0GdN96iqGCW5qV0jQnzygTu0HoHRU7Oe+vwvshR4m
         EKO5HRvAqB/i6lMdQCoE0ygVYOCW+MXgiL7KA/SwPiOKYPPbqLq+8HTjPS6hzwJ87p9l
         j+YmjA6DG3T3OeF2UN1nVhqUzAsiQgyHUCnO1V9zdxjP2BQr9RV9Lf95E/U5y4FAbRZz
         C6kNpv38xs+FDteyqvJger+FB12Txei3DDkRU3ZT1Rf4I/kYlZNBNS1ay7UP6fjqfRn5
         48fpt9p2nK1Nnky35V5FkahTvfsqYsx04hEfpks5R9q5LRvJDcT9FC7JCr1zKQ+S87cJ
         SwCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714436272; x=1715041072;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Wwskn8wHob0aiuWt7oahW5gvmqR22bCIIQzL1vy/1Vk=;
        b=YPJ8P2vkF63YhF9B81Qm3nd7Ff0dPqFeCQfIZ1Gn+9RfwBBXlcFhpwkqf7OtfXmSfz
         qWJSn/GpG4gApmqsgjYIZIFxZgokt7W8YZK+yw2AE4JC5sM0zfnOqnF014KCoK+LW1zS
         anJQVMeRgTR7kyofzL6qPG1hHGHbnF5Zj1q9IRlNQKKYmEENKVXySlyzN7FdmpZYqoOI
         UfzmEDtX2saVCjAwV5m1adnn7wOccrbH0eH8GXINOM1chzYy48V2oIJleiUE0sGiLAq0
         PhDoPmMrpghL4W12qNQ5JlAMO4lhU2F0EFrBb+I8lMeiv2qnSqSN/KvXf0ENGUJK5bOj
         Hijw==
X-Gm-Message-State: AOJu0Yx9Lugunzc2oPVNPQzGfdt2O+dEgiXOCMAT0AKiAzx/Tn1HGmyo
	DK39ESsIFEPhAYIFwRqalKX5NeCp21vRUVMkGSNh8vjOzhTcL43dG1w8UXfEL+yQDd8a/x4nX3V
	meQ==
X-Google-Smtp-Source: AGHT+IH9ZpHbIbR+PH37031tfohQuWl2RhYefdfEjAqVtOPnbjU6itGtSPkwvvkahLjNm79OM9oG9g==
X-Received: by 2002:a05:6e02:1aa3:b0:36c:442f:9590 with SMTP id l3-20020a056e021aa300b0036c442f9590mr1155822ilv.13.1714436272103;
        Mon, 29 Apr 2024 17:17:52 -0700 (PDT)
Received: from google.com (195.121.66.34.bc.googleusercontent.com. [34.66.121.195])
        by smtp.gmail.com with ESMTPSA id bv7-20020a056638448700b004874ea2e03csm2369644jab.124.2024.04.29.17.17.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Apr 2024 17:17:51 -0700 (PDT)
Date: Tue, 30 Apr 2024 00:17:46 +0000
From: Justin Stitt <justinstitt@google.com>
To: Edward Liaw <edliaw@google.com>
Cc: linux-kernel@vger.kernel.org, Shuah Khan <shuah@kernel.org>, 
	Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>, 
	Bill Wendling <morbo@google.com>, "H. Peter Anvin" <hpa@linux.intel.com>, 
	Andy Lutomirski <luto@mit.edu>, linux-kselftest@vger.kernel.org, kernel-team@android.com, 
	llvm@lists.linux.dev
Subject: Re: [PATCH] selftests/vDSO: Fix assignment in condition without
 parentheses
Message-ID: <mwrlqn2ddkepz6ayksk562uloq3ksejf3vu4i5xaoz2xnj6cl6@mwuquhhp3lwj>
References: <20240429203441.143607-1-edliaw@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240429203441.143607-1-edliaw@google.com>

On Mon, Apr 29, 2024 at 08:34:36PM +0000, Edward Liaw wrote:
> Fixes clang compiler warnings by adding parentheses:
> 
> parse_vdso.c:65:9: warning: using the result of an assignment as a condition without parentheses [-Wparentheses]
>                 if (g = h & 0xf0000000)
>                     ~~^~~~~~~~~~~~~~~~
> parse_vdso.c:65:9: note: place parentheses around the assignment to silence this warning
>                 if (g = h & 0xf0000000)
>                       ^
>                     (                 )
> parse_vdso.c:65:9: note: use '==' to turn this assignment into an equality comparison
>                 if (g = h & 0xf0000000)
>                       ^
>                       ==
> 
> Fixes: 98eedc3a9dbf ("Document the vDSO and add a reference parser")
> Signed-off-by: Edward Liaw <edliaw@google.com>

For readability's sake, I tend to prefer just taking the assignment out
of the if statement:

g = h & 0xf0000000;
then testing it:
if (g) ...

but as it stands it's fine and the warning goes away.

Reviewed-by: Justin Stitt <justinstitt@google.com>
> ---
>  tools/testing/selftests/vDSO/parse_vdso.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/vDSO/parse_vdso.c b/tools/testing/selftests/vDSO/parse_vdso.c
> index 413f75620a35..b9cf771006da 100644
> --- a/tools/testing/selftests/vDSO/parse_vdso.c
> +++ b/tools/testing/selftests/vDSO/parse_vdso.c
> @@ -62,7 +62,7 @@ static unsigned long elf_hash(const unsigned char *name)
>  	while (*name)
>  	{
>  		h = (h << 4) + *name++;
> -		if (g = h & 0xf0000000)
> +		if ((g = h & 0xf0000000))
>  			h ^= g >> 24;
>  		h &= ~g;
>  	}
> -- 
> 2.44.0.769.g3c40516874-goog
> 

