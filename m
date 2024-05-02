Return-Path: <linux-kernel+bounces-165869-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 785378B92B1
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 02:12:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 038F7282886
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 00:12:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DB1928FA;
	Thu,  2 May 2024 00:12:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GbP9yuea"
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25464632;
	Thu,  2 May 2024 00:12:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714608731; cv=none; b=kIV4rwaYAiOOM6EQgV7aUwMRm+KlEbYIjH8wvI9al+WTyA4JphqlODKENTJ35RF5GJqEO5j0OAZo93InZ0BgXoC1o2AtnyB6wJ6NlP0t+dhFW6hU6h0vgwNNqydP29EpBUVbpbZdFad+Fv+wCApNVKnvdshFtJ9fxLfy9fTdSKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714608731; c=relaxed/simple;
	bh=bECK87npZVbuZG5ZXL7WvoOTyXcE7lCaC0NfdLC2g9c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ud8qa0rX4p3fcW0bcUsD71kemQgNfHaGY5vTxeqmYeQ6wqaNsU+sifswsbfQCWAR/x7hR6lWkjv4qfQYK7hvJeQw4h56sDJQkQBXkZiPJHXF5TNrvQ64+zzwBNqg8E2l6DCV+mE9CNln3xzZf7kvDCrA5UMUeGc6dvIUgwmLJ/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GbP9yuea; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-1e9ffd3f96eso59926875ad.3;
        Wed, 01 May 2024 17:12:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714608729; x=1715213529; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=Qb2U8h1Yi2ovdnDt+Xys7SbynARb2UyzdqOp8qJa1Ok=;
        b=GbP9yueaA0yNPm9pMZ5afDta3FCQJVxjO2cnBuLACNCCr2J1vnYe3hdWiEhsQfAY2x
         +Of1T9DoQYBBUyXtl9CRVZaUIXuxg43CFfnKG9uhRIdx5lz7DJYtQZEMspJjP4VEjnpA
         5Ernp+R6uKuc1M8IIm2o7Wp4q4KUB9Z+rAMlwBR3O593f/YTGH6moYv94WPPPWhdWVzw
         pw/60JmGv27w1KdW+Tql/wera1Wg3iyNdiwTiRCUty0y4HFfDLB/wukH/BNQEO0x7N0n
         ZvqUvID0AORnbYMP9Oz+XJxbq5OuOZqd7qWOxGkizsaDsw1HBJxLyqFA/EAOP2N/JpBb
         kmnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714608729; x=1715213529;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Qb2U8h1Yi2ovdnDt+Xys7SbynARb2UyzdqOp8qJa1Ok=;
        b=QIujZpOweBiNvXbU7tjTxkew67S78b1zM9NxoEP/JO1zcQ7dfx6TN1B/4DC6czhZGA
         BJUV6/ahBqRKUo7zhG5vNKPrOPtAjQQiVvy+zB4FlTDUDg6BQcuZlDquwRHwHn5NC516
         3S6lazcEEg1y+MzDEIXml1ZLPdvc3OFcdAP5PAcXOz2zLOv80frTt16A2v8KKobUaKCh
         sDYZhXk7n2mBt4iwiebNgITXtmyQrrdz/7deBPydAmHH1i1V1oJo/A4NhZ8B9cXNhYU8
         0vlu5nj6kTgks9W0dpiNjcWiwrh/ys/bjM0vTjjRzd2K5698vrcZpmEQx7cJc2JEgcVS
         m9fw==
X-Gm-Message-State: AOJu0YwV8QkuJkZEkSFKET7k8NE/CXh86aEeUVE3kKCE+UXAbo80Lv0T
	zOnAuaFPnxJDqLzuENf48SG6SjdiVz9MhTqnkt/6NbBsyks82AMEdh7H2Q==
X-Google-Smtp-Source: AGHT+IGlLrWNDc8SzHf8rHqQYzjvOQrpK3FjHprboC5UvLTmWXXmcQ5cah+Yn0n8LAXbyBR8d2h0JQ==
X-Received: by 2002:a17:902:f807:b0:1ec:2977:d934 with SMTP id ix7-20020a170902f80700b001ec2977d934mr3623298plb.62.1714608726707;
        Wed, 01 May 2024 17:12:06 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id n6-20020a170902d2c600b001ecc6bd414dsm803635plc.145.2024.05.01.17.12.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 May 2024 17:12:05 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <521c0829-95de-4cc4-894b-6167c4f943a6@roeck-us.net>
Date: Wed, 1 May 2024 17:12:04 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RTF PATCH] hwmon: (emc1403) Convert to with_info API
To: linux-hwmon@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
 Lars Petter Mostad <lars.petter.mostad@appear.net>
References: <20240501224447.735869-1-linux@roeck-us.net>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <20240501224447.735869-1-linux@roeck-us.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/1/24 15:44, Guenter Roeck wrote:
> Convert driver to register with the hwmon subsystem using
> devm_hwmon_device_register_with_info() instead of
> devm_hwmon_device_register_with_groups() to simplify the code
> and to reduce its size. As side effect, this also fixes a couple
> of overflow problems when writing limit and hysteresis registers.
> 
> Cc: Lars Petter Mostad <lars.petter.mostad@appear.net>
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> ---
> RFT: Module tested only.

Oops. Obviously the subject was supposed to start with RFT as well :-)

Guenter


