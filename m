Return-Path: <linux-kernel+bounces-132587-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 009AF8996E3
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 09:48:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 328591C2161C
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 07:48:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EC2213DDCB;
	Fri,  5 Apr 2024 07:48:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e8QUqPa7"
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6954121379
	for <linux-kernel@vger.kernel.org>; Fri,  5 Apr 2024 07:48:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712303284; cv=none; b=VkvbI06qBqH5GOvhc3bC9MOiRXN+Pm5+AkYW0zyHwW9bJaOgS7fJDV6+dPfCHJ0qPDfdK9H5tsD2CYmliOcW2MSzhgS+WwUsV8I6vgsPuGjU2Jv+y7G35vkgBm8R4G3bd3Q7DPd6n1puguBE9LTkPUqkvwtCgJcdzHe1M/VOLZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712303284; c=relaxed/simple;
	bh=gOG1yICSBmPjhUbFo9boDY9KzUjbnwLfl9fXH6ZAGzs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=O+pQKqOpUIGqIJn0zhOxGX8CqndFxQfJhmiSRbyksLM9JJM8YWUecSyYGNj1/DnEtaw6r/ZB2pui0v603xxmTD1Ycp/4HcNOZ9p0HslSC3gu/BjhAu2jbR66vFCfspKH2BR+brJV3y6/egx7iaBKcs+CisX1sWnr6DOo3YrXAKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e8QUqPa7; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-33ddd1624beso1026916f8f.1
        for <linux-kernel@vger.kernel.org>; Fri, 05 Apr 2024 00:48:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712303281; x=1712908081; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mjYtOFS/YUqjywKLI686Ne/5YotV1Em6o9D2DdIDwZQ=;
        b=e8QUqPa7IZ3bQySukMtxIbEuggiSqG1rLopvJZeGNhGLmeQ3GNKpm0IUVLVUi6bYSH
         6gQDDaOnF0yPBCJfJJgJLZGKLqdiyY3Gm68uDrVu+ZHK5c3TK+OWESsz0yE2n8UdwpxS
         H5avY3yJgHlw54xwEwv9Gb/8E9PhELKD2iKOs8YIvx+dMQsAWfM4aG+OnDQjo4Z7RSR7
         YKUskhKwkygQcNnMgKMfOPIVjUnRgnggj1Si5N7OfxaQ2fTdjIl+A8OZnrwC8z6kwzcb
         R6EJqGUXr1mt6SfEXLDQVacSGKPpqfrzItmsllRlkdazXZvTdi0MFr4ZaCJSyi9ISZLI
         tcJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712303281; x=1712908081;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mjYtOFS/YUqjywKLI686Ne/5YotV1Em6o9D2DdIDwZQ=;
        b=ZbiNIh1xQQJrCn6QL7ZDdrGVlhvFz+5oINMMV61pYLVTdpIhpX4hHI8fAPzx+d6wkS
         HG271+rx95uHwx6J6kKAseKp7pMFWAvRA6supHIBCDYgazaBK6tJ9B17skb4XOmqQ2JI
         V3ElIoXlJzNLw/QkPEn3oPYwA976H5W82kIDsFDND/qDClUQNfnT7ggbFsHHGFxyiU8I
         E4fYJkREZCk/MCIykdeKzohYXD9+NbBN+GNqtfrvEZhoish9BlFPJ48eoTAUfK7/3j4A
         P4TvZbmvMaMOOMQH8YIzX3LFwuKuMVAdqkLfsJZKYYHK3wA7FLV9kQEOp33qJ51ySm3D
         hvtw==
X-Forwarded-Encrypted: i=1; AJvYcCXaD/hF0deeoUGOlm7KmA/cQvu87v1ot9sncn50tfIfC55+nMGr6doz1Y13XcNWlR70xrWj6fo2tSK8aerxSp/cwPGbDpyWBSLM68wo
X-Gm-Message-State: AOJu0YyjioTZnum6AgKrUU1YaXx84JTARtLv7rUIwtlqmNu7xDpWb6Bf
	4LHJ3r18UNCyk92ShxuoiFwcB+VI/5rabPyHuxkkX8A9ikT4WU2w
X-Google-Smtp-Source: AGHT+IH6cPLZwgitk6VaqGQan35d4fZJ0GiH/3NOfsbxR5dOYAmgRvrukm3gTBuMwCEhG962fGyqjA==
X-Received: by 2002:adf:f04a:0:b0:343:eb7d:bfb with SMTP id t10-20020adff04a000000b00343eb7d0bfbmr695346wro.27.1712303280839;
        Fri, 05 Apr 2024 00:48:00 -0700 (PDT)
Received: from ?IPV6:2a06:c701:737b:ef00:2bdf:f41a:ebd1:fb2c? ([2a06:c701:737b:ef00:2bdf:f41a:ebd1:fb2c])
        by smtp.gmail.com with ESMTPSA id p5-20020adfce05000000b00343e760c637sm878397wrn.84.2024.04.05.00.47.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Apr 2024 00:48:00 -0700 (PDT)
Message-ID: <b03d3689-9519-4b2a-a9bf-3fe278356e67@gmail.com>
Date: Fri, 5 Apr 2024 10:47:58 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 6/6] staging: pi433: Rename return value from "status"
 to "ret".
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: gregkh@linuxfoundation.org, hverkuil-cisco@xs4all.nl,
 andriy.shevchenko@linux.intel.com, robh@kernel.org, felixkimbu1@gmail.com,
 linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20240402111414.871089-1-ikobh7@gmail.com>
 <20240402111414.871089-7-ikobh7@gmail.com>
 <1f1572b9-9b0f-45b4-94ec-7f79467a7205@moroto.mountain>
Content-Language: en-US
From: Shahar Avidar <ikobh7@gmail.com>
In-Reply-To: <1f1572b9-9b0f-45b4-94ec-7f79467a7205@moroto.mountain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 02/04/2024 19:50, Dan Carpenter wrote:
> On Tue, Apr 02, 2024 at 02:14:14PM +0300, Shahar Avidar wrote:
>> Drivers init functions usually use either "ret" or "rc" naming their
>> return variable.
>>
> 
> status is also fine.  Just leave this as-is probably.
> 
Patch dropped.

> regards,
> dan carpenter
> 
-- 
Regards,

Shahar


