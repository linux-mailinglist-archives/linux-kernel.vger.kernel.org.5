Return-Path: <linux-kernel+bounces-93097-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DF0C872B08
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 00:28:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F31991F219E4
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 23:28:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADF7412D753;
	Tue,  5 Mar 2024 23:28:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g2YLOl/e"
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A82B212D210;
	Tue,  5 Mar 2024 23:28:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709681283; cv=none; b=tsOz2EFZscd5x6JLns6j4QMkW2ksL8EtlXXeGlTwU2ZFJZPn5QhyiOE6UWSXaf3lrEFU/40mP4jOju0rSN6QtPHT2hxSvWZ8PEEJ4sLdHiHtrQvi/xWEGF7Pr8XfhFArQsYJLa8GQhxLUCh5xc44uXaibD5n0J0/yhlEMOorYIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709681283; c=relaxed/simple;
	bh=yJxdZoQL8RIgiKiQsnedGkzuTvSUAiuG0Dq+5qOhp+o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uCV3UCJfR9ibB+BN3JSiwILMItWNyJiZdMhb5bzXKTPk7BWm4xpZidUChVYP/BDOkWig5/ipLCzH9aK0P8A6LVXLzG/+UbrDDijj29RQdbJYAoaBMySGJMXBnbQbD2No/BQNh90NTr6UhBRsvo+PCOMnu2WE7S/2JeZO25quudc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g2YLOl/e; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-299dba8fd24so4200900a91.2;
        Tue, 05 Mar 2024 15:28:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709681281; x=1710286081; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WLF8UJAVQjlxnLZMXvpLfFuhmxKmWCuaQi8QBSFA+Bw=;
        b=g2YLOl/e9N1C1QPAm0Unj1fFJWEtwBysRVy9fPLoSjQWTLj27JcbKxvXhecTGdFLmM
         fpeBJC9QVBxKoVHBqK7sibhF+SLo5EckrzJ2Q6rbl5TF7zszzW2+zXcRBy/BSyc6zWyM
         j/Ogt4nPG0XRaF7E3MpXPwvFyB/xZiOlp41i9eZt1cXlKRUsgKafPqfwDvCT0+vF6ERR
         QMATFGiMijHkAto92oG5Pmm0pWdxNwHVRIrxUaP63FCjjXQAPazhB/UeIsBLkF1wkSRH
         pvMwI9HGWXI0ucV5cmS9EbNCXVvM5wTn0viiGZCKNPKCTHmxckF51dDtDrCodJ4xf353
         wrNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709681281; x=1710286081;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WLF8UJAVQjlxnLZMXvpLfFuhmxKmWCuaQi8QBSFA+Bw=;
        b=lJXLjehZRbpSeKPe5Yq3xcEQ9omH6GBfAlpLTlUOU3BuS/1inVKCvGA1luQYW0JDF8
         triRgGXo80pWCYWWQC9TbYbog9LomXZtTikkvwD1DNzVYOfnKjV/QXEAdp5cOZZ5aw+1
         eDIVBOWGZOWuyZMeWcy1jOjLGSE9g467B2dGZFRnG/5noeu5+RiL+t/gvGe+yhjJY1Z1
         tQusy2UMb3wm2H+nzW4vgN0ubn73RY45MQ8XJy3hVZzd0ylKnB3Yb9nm8gnSSRaJ3XSU
         vTIdaJJOm/HMSS+XhXW0t0u0TewW+gfBi6rVcZajys6MSK6yOHYeGJD0wULRBkKlysB1
         kPsQ==
X-Forwarded-Encrypted: i=1; AJvYcCX6sWfR1jMyviLD+H28oKx03q+J4oIumB7wULz/tbF4lSxrtkfuGQDUSHD8wmWQ3KmNafRRRPbhKdLKus1grQq0WtSt+eeMMfaA3jgl
X-Gm-Message-State: AOJu0YzuCaFFPIMK/Aa6fAnrVCzRM+G2xmtvLfoWfqzAPHxxpCC63QEf
	oEXXtY3qCUIJ8FQu2+Z0kXu/O+OXcSY/zogpt9MJgrfDKud93w4d
X-Google-Smtp-Source: AGHT+IE76685i6WlhZUOACKhQwR71itjo6rVdCsZaadvl32oaDwe/VyMQ6Q1j9gxkF7/c/OAyubp7w==
X-Received: by 2002:a17:90b:886:b0:299:3c2e:64ca with SMTP id bj6-20020a17090b088600b002993c2e64camr10686488pjb.14.1709681280842;
        Tue, 05 Mar 2024 15:28:00 -0800 (PST)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id f14-20020a17090a638e00b0029b3c08508dsm613646pjj.1.2024.03.05.15.27.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Mar 2024 15:28:00 -0800 (PST)
Message-ID: <51913f10-892e-42b0-b609-c4f56878c473@gmail.com>
Date: Tue, 5 Mar 2024 15:27:55 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v6 00/16] net: dsa: vsc73xx: Make vsc73xx usable
Content-Language: en-US
To: Linus Walleij <linus.walleij@linaro.org>,
 Pawel Dembicki <paweldembicki@gmail.com>
Cc: netdev@vger.kernel.org, Simon Horman <horms@kernel.org>,
 Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Claudiu Manoil <claudiu.manoil@nxp.com>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>,
 UNGLinuxDriver@microchip.com, Russell King <linux@armlinux.org.uk>,
 linux-kernel@vger.kernel.org
References: <20240301221641.159542-1-paweldembicki@gmail.com>
 <CACRpkdY1QfeqRfU-doq_qss8VzgWo9jLnULQREGmHPqsgpqWaQ@mail.gmail.com>
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <CACRpkdY1QfeqRfU-doq_qss8VzgWo9jLnULQREGmHPqsgpqWaQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 3/5/24 14:45, Linus Walleij wrote:
> On Fri, Mar 1, 2024 at 11:17 PM Pawel Dembicki <paweldembicki@gmail.com> wrote:
> 
>> This patch series focuses on making vsc73xx usable.
> 
> Can't help to think it is a bit funny regarding how many units
> of this chips are shipped in e.g. home routers.

How many use this particular DSA driver as opposed to an user-space SDK 
driver though?

> 
> They all work pretty much like the in-kernel driver, or a bit
> less than that, just hammered down spraying packets in all
> directions.

Do you have a list of devices, so I make sure I don't buy those :P?
-- 
Florian


