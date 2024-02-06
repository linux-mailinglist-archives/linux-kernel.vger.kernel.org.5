Return-Path: <linux-kernel+bounces-55401-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6214484BC44
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 18:39:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E0EF61F252F3
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 17:39:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 089D89473;
	Tue,  6 Feb 2024 17:37:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EnUFg8FJ"
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A391AD51A
	for <linux-kernel@vger.kernel.org>; Tue,  6 Feb 2024 17:37:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707241057; cv=none; b=LwDvy86MzOr2FcgL6xHIaJdnce+ni05D/tHTJEp/PQgYG3/s2Txbws0zknQAFzlSK0OHeODeBHeSqB7keqvQ8pBSZlGBL9uCPFMDp6ahSVKJAVZAVTD3Du7EBOEzpuC4y6LVSyg3MCRD6B9uenHUhT+s1H5P7XUsA9jaa9V+Cpo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707241057; c=relaxed/simple;
	bh=0ulRdwAfllDKwrIAOGdtjw0COs1yGyS4qGnSte2NhnI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Q+SSQyxIpHww1D8xMgv7yVOP7m3z8gn98++CobTFihevAKLAEwvnLaWi6CsnHWi/52tiF9DnLyYq4P/2RfCTIvWxqcp8S3o996y3nV1zLl2yeENJHdHXp+lBCffvBaKmjuCODYe3xc5M9blDV86gLfow13stpKTX6HXXdwx1Gvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EnUFg8FJ; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-1d93ddd76adso8846455ad.2
        for <linux-kernel@vger.kernel.org>; Tue, 06 Feb 2024 09:37:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707241055; x=1707845855; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=MzKq1zG/Z0d8fnc6YSb0Nhx3iwiy0dFsmrhm9qNiyfk=;
        b=EnUFg8FJjCR5XQSgPA+VXG3jnakUTHjpxhwGo1ysKy5YgaxRmzWa0MfNXTS00LULKT
         sPgj9zmqn7YNsZ68BEL3iFG4PmQUiEBDjksJfGyKxs/N0U4DwvTN86FnW5OHaKZ7k+Th
         HlccpxGp48knt1ZvV7VbxKmWqrVb0eoX7umPA2WzQ632uu5vOXd9ecH/7s0jpPWAAo1+
         Hp/i3OCnbIoDe7Hedq9CvPvX60RkVFuEfzllwH/ZVy5xk5PCYzTgSpr4x+2kwwL6Qi2g
         4Pb2BBTB5vuhapq8seW5hfQVOMz9jA4rw/xLm5yqeVbhJJwv+JddHpZwoCCQ5Z1QU7aI
         Lb/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707241055; x=1707845855;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MzKq1zG/Z0d8fnc6YSb0Nhx3iwiy0dFsmrhm9qNiyfk=;
        b=a67f3ISx5bWsPp9Vw3MzwSLGUrESsn6GJMX576Ke1qekjpqXF6qv5wJcP2adLvoEKm
         q/mKhvc6iyN+UFVG1NDTDpB5og9/EKjAoTX73sEE0OQefOVQeihN5Wag7wH5Cm1RMvsG
         5y4tdMqLdFzdHAInceqN5o4JXI0q7gpX/sYxM5Hbc4PJ4hZ/PFoAg4y9alIa54cfJCpn
         ZqQKjP9NrCO/wI8TgLHDVJDXwS39m3raXDYlc2hdtgXeWSjO7vSSBSri1EtNYXXVWRtk
         rmZnpr1tRyrk6YIkt5OcrT5q9ojcyV6CJMF5IRuijFoJpX3VyV1OY5GgBHH9IgKrSkPm
         xMXQ==
X-Gm-Message-State: AOJu0YzcNHz1TREz90Eh7z/F9oYODMLFdcgILwgWPqfokyjS7cXUdVgW
	dYvP19GV7S24HRjz8pIH37BaErltXThMAp9Y2Z0Fm33s0K8c7kqS
X-Google-Smtp-Source: AGHT+IGia33hKROOZE1YgOZ008vsCXov/AuKLvpV6J8BQVODf2QW5M4fq2WVOEqzCgTurPVy9xfI5w==
X-Received: by 2002:a17:90a:68c5:b0:296:d85:d3d2 with SMTP id q5-20020a17090a68c500b002960d85d3d2mr210322pjj.34.1707241054641;
        Tue, 06 Feb 2024 09:37:34 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCWYlIiJBJmPFi7ncmj8remTEffZ3y5WCyYq3Zv83+mHlJ0jLFLwUpCCJNBOJt1nfLfZi0/UEWIheNqi0BHA4+nlDh1TSZdjEOlQnjKPC8uw2kda4PyCTI/tVwkxOoIbVAO9DxdABDlOaN6pLY2nHy83Vg/CefSmjORaGfw=
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id bk7-20020a17090b080700b00296b2f99946sm1949517pjb.30.2024.02.06.09.37.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Feb 2024 09:37:33 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <a93ca301-243a-4e75-afa5-fdf80b20eb8f@roeck-us.net>
Date: Tue, 6 Feb 2024 09:37:32 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] regmap: kunit: fix raw noinc write test wrapping
Content-Language: en-US
To: Ben Wolsieffer <ben.wolsieffer@hefring.com>, linux-kernel@vger.kernel.org
Cc: Mark Brown <broonie@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>
References: <20240206151004.1636761-2-ben.wolsieffer@hefring.com>
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <20240206151004.1636761-2-ben.wolsieffer@hefring.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/6/24 07:10, Ben Wolsieffer wrote:
> The raw noinc write test places a known value in the register following
> the noinc register to verify that it is not disturbed by the noinc
> write. This test ensures this value is distinct by adding 100 to the
> second element of the noinc write data.
> 
> The regmap registers are 16-bit, while the test value is stored in an
> unsigned int. Therefore, adding 100 may cause the register to wrap while
> the test value does not, causing the test to fail. This patch fixes this
> by changing val_test and val_last from unsigned int to u16.
> 
> Signed-off-by: Ben Wolsieffer <ben.wolsieffer@hefring.com>
> Reported-by: Guenter Roeck <linux@roeck-us.net>
> Closes: https://lore.kernel.org/linux-kernel/745d3a11-15bc-48b6-84c8-c8761c943bed@roeck-us.net/T/

I no longer see the problem with this patch applied.

Tested-by: Guenter Roeck <linux@roeck-us.net>

Thanks,
Guenter


