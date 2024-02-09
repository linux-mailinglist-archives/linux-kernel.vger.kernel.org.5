Return-Path: <linux-kernel+bounces-59606-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DC3C684F99F
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 17:30:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 44FDF285A75
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 16:30:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 921947B3D8;
	Fri,  9 Feb 2024 16:30:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CbdhDlaj"
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5689953398
	for <linux-kernel@vger.kernel.org>; Fri,  9 Feb 2024 16:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707496234; cv=none; b=lEez/KOmhTHCbhPvDuSKDUMLGldvlOJX0MpOskKBkwI54liECGQ+/Y0peqeBhGE/ZKnMxirODgCXLcc4K+tD4x8LGJ/IqTZ/dTEWDl9H3uKBumR0KEphMH3v6gvxaHIC5k5VVKNODL8Q9kstL9R8U1i09JI3+KfrEfZxv4sF/xk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707496234; c=relaxed/simple;
	bh=+DlFeW0B9I+U+AgdhITog37dlFBHUgS6Uth5RohG5X8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=f3/+6b5pfl/aXLgce7VvFh3cm4ekGTUliPW/fpIg6ylNs7mCq5iB2/JJyjFdTJOodQ6ABxOSoi/62t7HnkGNWU7bACWGtjG70/kzspOIPRGm10WX3MF0bW2tWa9bU+BJrQZ7allosVA9aL8jmfZwcMGPlbl7kYP2I4rjRbuooBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CbdhDlaj; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-1d9b2400910so8272235ad.0
        for <linux-kernel@vger.kernel.org>; Fri, 09 Feb 2024 08:30:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707496232; x=1708101032; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=1npTdiT741JpBb9/54GkOelM0JJCH7AAkexG1GOPV38=;
        b=CbdhDlaj9UCBbuneVaCi/0f4/aSbt9d65DvWnQv3ficeAtiXH6ApIhmGZlNw+iJygP
         WImYGD8rsTd9D51ku4Zp7TjcBMqn8ltDNOMB6stywcKF1525DChe436+t8u5WSx3g4wj
         cuK1fnpjhM8vGVE6QxHZtIL826XP0i+IUiU0cKQIcrLnYnrKlDkkNVh/LXQgDdn7VGNZ
         dk/BTpbXbYCnIx3Qom8WWNyRZ1AxeTpRHKAUJPv2RM5e3na+2rU9R+SnUm5DRjtCUAdm
         v3CRnsXsZtG/1Q1UAN9hhsHkRvKPU2EXBGsgihU0WKp9gCvvoMBXkN13WA7TIkM3Fi5c
         Jq1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707496232; x=1708101032;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1npTdiT741JpBb9/54GkOelM0JJCH7AAkexG1GOPV38=;
        b=J/aofZAPj5oQ7ULgPV7OZf+NQ5FxpSRZqNyXHaefpLkg+esBky0K9TMb3ep/Ecdp5j
         +FyGVMuARXXD457QTPvRc0MwEigWmaKC5cRKtUkEvu3ZGDFHhNB1ug1/9Zf+B4F5IPso
         RudSzcPxAWxzWbc/xkbC2x1dQkO1nsxKRSQs+P2lKFYW3Lt2jM0CfCe4ltTA2eaB1KfM
         mdL9GI1MY3jYzJ1jPWBideIU2cSNyCJEzBMpXLeeX+ht6auRY7S9WREeOJ7goNdmkVaU
         LRr5rirbQxGuVmLRWnbgbXJu1tzq2KX68HjK4S/tdklpbFLJAe+Gm66WGr415jAIyFev
         FywA==
X-Gm-Message-State: AOJu0Yzp2qNNFvyWG661j6blTssUsHjF5sptiWpaCzK4EeUqGDtPUjDl
	Xa9KYXmoESJ/PrdTficRCh5Vm90lsJwCVBkKmweoZXaV7XBrw6ouacGz1eBq
X-Google-Smtp-Source: AGHT+IFvISCMrbbWBJHRobMUW0ajCMCNR6HQr2ywOzAm3JXBWdoeCxTXuuWYjzz2FGHJCjlvmR3l6w==
X-Received: by 2002:a17:902:da8b:b0:1d5:6d76:997a with SMTP id j11-20020a170902da8b00b001d56d76997amr1950380plx.28.1707496232409;
        Fri, 09 Feb 2024 08:30:32 -0800 (PST)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id je3-20020a170903264300b001d93765f38dsm1690305plb.228.2024.02.09.08.30.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 Feb 2024 08:30:32 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <f9aec946-a969-4f63-859b-4769ca392faa@roeck-us.net>
Date: Fri, 9 Feb 2024 08:30:30 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Sporadic regmap unit test failure in raw_sync
Content-Language: en-US
To: Mark Brown <broonie@kernel.org>
Cc: linux-kernel@vger.kernel.org
References: <dc5e573d-0979-4d7e-ab4a-de18a4711385@roeck-us.net>
 <ZcVRcH/D945GKWjG@finisterre.sirena.org.uk>
 <91218892-d8df-47f1-99a0-6c4564c7bebe@roeck-us.net>
 <ZcX7HMQBIG75In/A@finisterre.sirena.org.uk>
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <ZcX7HMQBIG75In/A@finisterre.sirena.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/9/24 02:14, Mark Brown wrote:
> On Thu, Feb 08, 2024 at 10:17:02PM -0800, Guenter Roeck wrote:
>> On 2/8/24 14:10, Mark Brown wrote:
> 
>>> I guess it's possible that we randomly generated the same value for the
>>> initial and modified values here?
> 
>> I think the diffs below should fix the problem. Would that do, or do you
>> have a better idea ?
> 
> Something like that, perhaps not that specific diff.  There's a bunch of
> tests that might be impacted as well so probably a helper would make

You are correct, though, unless I am missing something, those other cases
will result in wrongly passed tests, not wrongly failed tests. Not that
this is really better, but in a way it is less severe since that will also
only happen with the same low probability.

> sense here if nothing else, I should be able to take a look today or
> tomorrow.

Sounds good.

Thanks,
Guenter


