Return-Path: <linux-kernel+bounces-148979-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CB6A8A8A06
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 19:13:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 329A51F2458F
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 17:13:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C675171670;
	Wed, 17 Apr 2024 17:13:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XubTWGUF"
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9751C14199C;
	Wed, 17 Apr 2024 17:13:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713374020; cv=none; b=DYCsdSoS+4eHB/3FAHUJa4+kDzmpbdjo7iHpS93uU5k/VIxnFW6pxixrEsMQp07WiiwXepv83chvCAiw7iv+ufX5Amu3FsjYdVYVq8lXRlnKftLk4UcKUz0WGK6bvB0V9CpDxQKnzYSp7bOSQ2v5JCMNBf4X3LSi3QPCYOmWsKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713374020; c=relaxed/simple;
	bh=7qhKToHeqr72R+UX6oz1defReAsUlZPMCU2ywC1yEqo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GWeogqjNX3iUdcSOBxz8N3M28RKMZSSud78mLzoUkXUU3ONfcvlBCHUVF3kGtdH0rKYVGgcBxrPO02NwgcHgzKOPxj77XwLl4BY5gmsa+1rwYzrroF+QCslW8uo+hdjUNZ4BgkS12hT3wBrVMGJRuJReZHdFj/mV2tNvo0g8jrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XubTWGUF; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-434d0a63151so32615571cf.3;
        Wed, 17 Apr 2024 10:13:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713374017; x=1713978817; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SoMVffGlPrm+MFyOIcZFIoKUdPgF6ZH9Z9crMv5R1AM=;
        b=XubTWGUFoD+XlhZjxXtTij69YW9AKAqdKnxMbuvvy3clb1sfcRX2o0IKpVG1WBcG/e
         +HuVw7nGHREv4ACC3bHryEPjSfgmN92QZmRJfzSBPEB29ljXBrbT4Qm99BW697/IL5Dg
         qLhjiH1BaT0308aKypQv23oM9rJ9jYM0lPFefzasqbp9hPXUW6XYJR9w9RO0rHswDGlW
         8b2QlLHcoUKweWqEFYBYPC6pOdocf6krhQBOwf8U5PSCggB8EBj5qFhVWcJStO4/Cl2J
         TQXNT3OrlMShn/Rxu+tQeoDbitAU6rNvdz8mjmtGJcbyOUPo2xKZ2WEAt+kDbfbjhqWo
         LOlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713374017; x=1713978817;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SoMVffGlPrm+MFyOIcZFIoKUdPgF6ZH9Z9crMv5R1AM=;
        b=uJu5C7X3M9GVZMG6UCjf9SbP6CCNzv2/gcwHujXKhiA1rJPvwjh/DCFLeS9iT8zkAy
         XiH2U2wCIXqNxPsMig6cYIpXyzrzwQpwzgKSAcOf7y3zwh0LrPn1PHkVfvQgx5tphz5L
         FssV7QvvrGNpaouvtP75+lMSgT0//JA0eX2k1UhZ1yfo+Kddt18CRLOqE3mF03Ryr99N
         7UNKP39KNj29MhKK+X979ia7CV/xdCeNve0TQM0WhMJuyKyKBS0ELNhzfUG/cctpGCQ9
         pRc+yEKCJK0th8EZQK0WTFwCM5fnu5Gjuohf+RZUcKs2YaUBReC3gnLaJ9ByvalG09h4
         OJEw==
X-Forwarded-Encrypted: i=1; AJvYcCWViLUX+bU+Nlem12rs5EV+EQMQ0lvS8bFr/yYLOUbH2DWAZcrCMStNFSpflfXDzD52JZn8lhiIonXpTGpu/faeQkaGBAHnTAm9pAc/4YukXQmXuL+FfYQpiJIJ6WsKvli2gKiO+Fqx
X-Gm-Message-State: AOJu0YzL5cXF27VBaQ31MNeM//Dj1O1dpJJKLA4V+ddOeiB65jMhvPjm
	SO6LiOQrwyaRRlXb6xhuuhLa1t1pys7ZoqQFmqmbNOxgVxWVY28g/TOKLA==
X-Google-Smtp-Source: AGHT+IEwvVAGeqDMetg/k7oP2EviQw8jDsoog+bYAOSxCSgeSpqFDWkHLG1bzCZ2SMykTxtnEg2QVA==
X-Received: by 2002:ac8:7f88:0:b0:436:8bfd:138d with SMTP id z8-20020ac87f88000000b004368bfd138dmr99961qtj.11.1713374017308;
        Wed, 17 Apr 2024 10:13:37 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id e15-20020ac8490f000000b00434d86fb403sm8247196qtq.86.2024.04.17.10.13.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Apr 2024 10:13:33 -0700 (PDT)
Message-ID: <b83b1f5b-a989-40b1-8874-85f75f17b4dc@gmail.com>
Date: Wed, 17 Apr 2024 10:13:27 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Please create the email alias do-not-apply-to-stable@kernel.org
 -> /dev/null
To: Willy Tarreau <w@1wt.eu>, Greg KH <gregkh@linuxfoundation.org>
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>,
 Thorsten Leemhuis <linux@leemhuis.info>, helpdesk@kernel.org,
 "workflows@vger.kernel.org" <workflows@vger.kernel.org>,
 LKML <linux-kernel@vger.kernel.org>
References: <b452fd54-fdc6-47e4-8c26-6627f6b7eff3@leemhuis.info>
 <20240417090918.77360289@sal.lan> <2024041715-calorie-late-c4de@gregkh>
 <Zh+M+NWKbpQeT/Z6@1wt.eu>
Content-Language: en-US
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <Zh+M+NWKbpQeT/Z6@1wt.eu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/17/24 01:48, Willy Tarreau wrote:
> On Wed, Apr 17, 2024 at 10:16:26AM +0200, Greg KH wrote:
>>> at the scripts used by stable developers - and maybe at the ML server - to
>>> catch different variations won't hurt, as it sounds likely that people will
>>> end messing up with a big name like "do-not-apply-to-stable", typing
>>> instead things like:
>>>
>>> 	do_not_apply_to_stable
>>> 	dont-apply-to-stable
>>>
>>> and other variants.
>>
>> I want this very explicit that someone does not want this applied, and
>> that it has a reason to do so.  And if getting the email right to do so
>> is the issue with that, that's fine.  This is a very rare case that
>> almost no one should normally hit.
> 
> For using a comparable approach in haproxy on a daily basis, I do see
> the value in this. We just mark a lot of fixes "no backport needed" or
> "no backport needed unless blablabla" for everything that is only
> relevant to the dev tree, and that's a huge time saver for those working
> on the backports later.
> 
> Maybe "not-for-stable" would be both shorter and easier to remember BTW ?

Yes, "not-for-stable" looks like a good name to me.
-- 
Florian


