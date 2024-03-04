Return-Path: <linux-kernel+bounces-90971-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D8C988707D0
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 18:00:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9907E284C97
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 17:00:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A6F85F578;
	Mon,  4 Mar 2024 17:00:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hoRGuqDx"
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A232A20;
	Mon,  4 Mar 2024 17:00:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709571646; cv=none; b=S7o4XLom38g0PCR3CfNOcG80wpokoNS81oCY/IgBmw6mIwLPBg4bckALsxKxMOib8znzOG7TYDA31t+hrMXNhkW23gbvi7VcyH7tlTxIUpaiO57A6jRdzIdwKSgIEHEd4bfNFjhGhI5RWZ/Cz5kCNgU5xHqOVya0kpyVhhBsAj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709571646; c=relaxed/simple;
	bh=MyhsxxXHVsWHcZLxon29jxFLEZA6UpUKQkWcvJRLCQE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tFR93Z9O8ivqyoq4bW12wKlUbz1KKXPoy6YFDIxQoTMa9hXyvW+3KNToa2C4hCoPfRKIXQG8tEm1tNSXhsUFnP2PmgeZ4SM96kmXydy5sUkmsj+vLYqSW5xL5E83aS5F/6AijPNiIbtn7K7+60ZZflbWAbGcQratoun7nvwvqQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hoRGuqDx; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-5e42b4bbfa4so3454174a12.1;
        Mon, 04 Mar 2024 09:00:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709571644; x=1710176444; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=NLIYEcljrpVJM3SeFnZJOhHaAq7VOKkXSn2CtLrUrCU=;
        b=hoRGuqDxBUH5YenxKMUdRUVv1P8iO7Vql0RxKUvlmYbCoDheiz14g9LZG9Ke3k4vli
         so+j24R3cjAfseRa4iVmic+k/Q9j8a9y0vG5a7Iq60gzdp4K3CNKFNmpfoA/kJFECYno
         7Gob7B4PpmtSamA/8hnUgH6tSPH5LtasVBk2XXXr0DRkLSQOWgK75eC1BEFYWQlLqnYS
         MFXOu5UpoOvruGTyqdmkL6Ih6w0sDh2FxKkl3ob8XESY8wIqAq275jkQz92drRirSthl
         kI884a70jPzexn7CSBSuvLJMlupfcBcfe2V8UGhD4gRl1kqePD2HLdwe65mvBmcwGrEq
         O4Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709571644; x=1710176444;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NLIYEcljrpVJM3SeFnZJOhHaAq7VOKkXSn2CtLrUrCU=;
        b=oBDMgU8jREKECe5Da/pdU6+vI1r/oA7hSkO2dCaRXW/8RQ3aSFHcpJ4QmM3jTOQqTJ
         VCkr0Ramc7OYuKBOZ8qOcLlciZLHkLQ5cJWUwY6RMgmv+VOTTZmwJo6JSQAHwWuuvm+X
         MRJ6Adz1xZCXl5SEnx0t5RcsV7Fb0Fjwqew1cdj3y/TvySKPsDCJuwNZNubqn09SNNyQ
         Fi55YEq6cSskrwEL71FcZ2TTIZXTkOMw+V2uE8a8NPCnIQdP9VNc0QMXfUhqzdsTYEkd
         FOqdt0tgqRZQGdzTvgi9MlZ9Et8bLsmOnP5huitwXLTzMxnOZnUDzkQAcRX4ZB+tGloP
         Nrag==
X-Forwarded-Encrypted: i=1; AJvYcCWJyDncYLvtkDMG/0SA0F+RBMH+6NXSca2lieaeClR0pYMv1rDCqXDNQzpTiEiQN+X16kCvmiR9hylTygClvdO6YVp5k6OIy6gC2mPXQ5azJ3MtidiHp3pNLiwQJHX50D5OnGs3Nrck2Cs=
X-Gm-Message-State: AOJu0YyGSTkswU21B7CLO/DOU6kSDPOdqybheR0cqg2SSo+Nf3yESNme
	9BsognBifLqmmaRp8qxxx8EEOGIYwYKGKPksIs6k/T5Uq/HPlByN
X-Google-Smtp-Source: AGHT+IEsdBC+BhPNnFSpkEH6bVRY5m4oiEMDy4P8WPGaaV7Nfzv3cUCzzuvlpdhaM5UCHdZ3hfxELg==
X-Received: by 2002:a17:90b:101:b0:299:8e70:e9a5 with SMTP id p1-20020a17090b010100b002998e70e9a5mr7870698pjz.20.1709571644146;
        Mon, 04 Mar 2024 09:00:44 -0800 (PST)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id m15-20020a17090a158f00b0029a73913ae8sm8866539pja.40.2024.03.04.09.00.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Mar 2024 09:00:42 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <3383421b-bda2-48c5-bc49-d3d9f2ecfe25@roeck-us.net>
Date: Mon, 4 Mar 2024 09:00:41 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] hwmon: (pmbus/mp2975) Fix IRQ masking
Content-Language: en-US
To: Naresh Solanki <naresh.solanki@9elements.com>,
 Jean Delvare <jdelvare@suse.com>
Cc: mazziesaccount@gmail.com, Patrick Rudolph
 <patrick.rudolph@9elements.com>, linux-hwmon@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240304164446.4153915-1-naresh.solanki@9elements.com>
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <20240304164446.4153915-1-naresh.solanki@9elements.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/4/24 08:44, Naresh Solanki wrote:
> From: Patrick Rudolph <patrick.rudolph@9elements.com>
> 
> The MP2971/MP2973 use a custom 16bit register format for
> SMBALERT_MASK which doesn't follow the PMBUS specification.
> 
> Map the PMBUS defined bits used by the common code onto the custom
> format used by MPS and since the SMBALERT_MASK is currently never read
> by common code only implement the mapping for write transactions.
> 
> Signed-off-by: Patrick Rudolph <patrick.rudolph@9elements.com>
> Signed-off-by: Naresh Solanki <naresh.solanki@9elements.com>
> ---

What will it take for people to start providing change logs ?
Why is that do difficult, and why do people seem to assume that
I have the time to look up old e-mail chains ?

I'll have to write some boilerplate reply. Until I get to do that,
I'll simply ignore patches without change logs (which I will do
once I have the boilerplate as well, only then it will look nicer).

Guenter


