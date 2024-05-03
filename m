Return-Path: <linux-kernel+bounces-167163-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 254C98BA51F
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 04:00:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 557D31C21C43
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 02:00:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36C64134A9;
	Fri,  3 May 2024 02:00:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E9nWNXn5"
Received: from mail-oo1-f53.google.com (mail-oo1-f53.google.com [209.85.161.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3759BBA2F
	for <linux-kernel@vger.kernel.org>; Fri,  3 May 2024 02:00:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714701613; cv=none; b=tU/bNshCXiexZLt1SlQM4TnyL0TAWPxiZ0aNLTG5o5Ox5qz/kcj+vg2VFysVyBnaSmhjCuR+rmiiEqO3gXjfBdViPur00gILN0A2bi9ipstxVe9MQZUwpAXmItN3jzb1cE/VKKg+eJF29SQIx1Y5uKcUhrbZHFukaI/kTpphlL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714701613; c=relaxed/simple;
	bh=IgtySo/J8gV28TExFPrAsMeWYcGz6Ns9BbQF6xqsQ/s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cZW/kYoEmcQ18iOSCB07qTBUqagLdD/ttSMJRf+JP+pUh1juBERz2SVdW00l6exswwbGlHPTS3WAW14VYPymIpEees11UddsETDYkhwzNMFA4MShnkq6UdWFOlg6/7qXKkNk/8fDaTt3Pnr6VWfMgo1b/jGbbXzVZqxXFPLdWzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E9nWNXn5; arc=none smtp.client-ip=209.85.161.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f53.google.com with SMTP id 006d021491bc7-5acdbfb7fe4so235334eaf.3
        for <linux-kernel@vger.kernel.org>; Thu, 02 May 2024 19:00:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714701611; x=1715306411; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3NWBEjkxGi+L5lBZst5fB6INosDzoSqFnqJ5mwpVEOE=;
        b=E9nWNXn50mEzzwOd4ZQL5097+hxGWkfeMAGYu7aVQ+ZpF38ZFtjJNWaaOTZYn/6N/m
         LH+iyzquC9NGVbPaLM2XOo3QXw8ukHslna0bv8RBUYTaBgwrjsoFYrARSltmBVTDCijQ
         Sb+3HLtkeXWrpeD2IGsIHFTFzXVzXVHj9kDVlsz8Y7yxkqx4paFuWPrxAell7bZTR/7C
         epQX+x4TjFu2OYgbvZC9A25eTkyKLxzIAJBQDgg2awk6/zOBZ/nUWLFPdMmCzsC4BpEq
         /UzfjKX9WpH4R7hRnWYI+mrbOeyL+nhrzBnVrB5eSrKHvwNz5Sdfh5uvUIRpTzAT/Ugo
         3GUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714701611; x=1715306411;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3NWBEjkxGi+L5lBZst5fB6INosDzoSqFnqJ5mwpVEOE=;
        b=GeqK74XgJELXiDdZ//sWiaPEP5/qc1XJWecniZVFvBu/KitOADD4NY4tTKM2MAP0AH
         O8slj7rO8ml7lIi0zDF7rf+aG+i8xchLYZJZRcwXcE1nbIquqWc/7tDoL23rfcdL3Rp4
         poqYzERDvMvx6secZS06xmIrYtsTsk/Khf5MECfhIZcVUU9DlEm9m5mWJOSXUD5FndPD
         u2eyiKko6jfoyuwB0h7qeaF3F1Jqj7cKrRaeFJwKA+CEugwchr5G42MEbjSzZG/EXwuH
         GhgsibQd/aDcCP60Vdn+sVGbZy63IiDlwAVbd2bnxkyoxfLuvPun0USePsWZKiXQcnBq
         za3w==
X-Gm-Message-State: AOJu0Ywos3P7E7V7lboN+76JLLCDgN8zdwWIu9QrKgQUtKCeTfM3uBBW
	2detyGLQDoMnGakcsTzPYKOy0lzPv3UMBH18CStPlJmfKoneNgda
X-Google-Smtp-Source: AGHT+IGwm/RJwWfWnhLonoxtrHKi1Phaf+l4SMyzyodryE27zQfNCftBavtif18LFSyQ6pZade20Ng==
X-Received: by 2002:a05:6871:5d3:b0:235:3e97:ed24 with SMTP id v19-20020a05687105d300b002353e97ed24mr1868642oan.1.1714701611216;
        Thu, 02 May 2024 19:00:11 -0700 (PDT)
Received: from visitorckw-System-Product-Name ([140.113.216.168])
        by smtp.gmail.com with ESMTPSA id n26-20020a63591a000000b005cf450e91d2sm1969878pgb.52.2024.05.02.19.00.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 May 2024 19:00:10 -0700 (PDT)
Date: Fri, 3 May 2024 10:00:07 +0800
From: Kuan-Wei Chiu <visitorckw@gmail.com>
To: Yury Norov <yury.norov@gmail.com>
Cc: linux-kernel@vger.kernel.org,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 1/4] lib: make test_bitops compilable into the kernel
 image
Message-ID: <ZjRFJ2Kig7l+hieS@visitorckw-System-Product-Name>
References: <20240502233204.2255158-1-yury.norov@gmail.com>
 <20240502233204.2255158-2-yury.norov@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240502233204.2255158-2-yury.norov@gmail.com>

On Thu, May 02, 2024 at 04:32:01PM -0700, Yury Norov wrote:
> The test is limited to be compiled as a module. There's no technical
> reason for it. Now that the test bears performance benchmark, it would
> be reasonable to allow running it at kernel load time, before userspace
> starts, to reduce possible jitter.
> 
> Signed-off-by: Yury Norov <yury.norov@gmail.com>
> ---
>  lib/Kconfig.debug | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
> index c63a5fbf1f1c..fc8fe1ea5b49 100644
> --- a/lib/Kconfig.debug
> +++ b/lib/Kconfig.debug
> @@ -2436,7 +2436,6 @@ config TEST_LKM
>  
>  config TEST_BITOPS
>  	tristate "Test module for compilation of bitops operations"
> -	depends on m


Perhaps it would be better to modify the description in the following
help section at the same time?

Reviewed-by: Kuan-Wei Chiu <visitorckw@gmail.com>

>  	help
>  	  This builds the "test_bitops" module that is much like the
>  	  TEST_LKM module except that it does a basic exercise of the
> -- 
> 2.40.1
> 

