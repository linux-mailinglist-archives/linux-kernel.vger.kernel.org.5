Return-Path: <linux-kernel+bounces-77755-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 99A858609CC
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 05:20:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 071111F266BE
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 04:20:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10A1210A19;
	Fri, 23 Feb 2024 04:20:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eCY90VNh"
Received: from mail-vk1-f181.google.com (mail-vk1-f181.google.com [209.85.221.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE48AD2E6
	for <linux-kernel@vger.kernel.org>; Fri, 23 Feb 2024 04:20:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708662016; cv=none; b=gtEUtfFjsHUcETQLn1qKvi1EoVLXHueisYbVHQjWMkn4pgfd2dup+1NQBIJBwm2k4IxI/RI1iPno/GOQSHQHT0Er98GczCZycpDyVdhhli5IOin2IOi8skmNILZksEvLyzzvxr14W/Cg9geD4Lf7obVIVJZUGtiZFIAPh00Wr3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708662016; c=relaxed/simple;
	bh=3aSkqCDyuDAnn4aoKsyn9oPyncLsKaXsAkp1FWB8Tqc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hpjEtbGkm9+yu69afkwUNcKkHLG3pjxrJ2nNUxqX0GfyqrjkgB7Gbq08v6Oi1ZRGVYxxHQhOVROCSJtO8wRhe6a2s6NQG3yfep7Beni4+BLDdv6N9Jurir3hKHfwHeHLhTG2FLL3y50JXkl+HvL/8dwqY1lqfcsDjtp7ia3cuCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eCY90VNh; arc=none smtp.client-ip=209.85.221.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f181.google.com with SMTP id 71dfb90a1353d-4c78b074fe0so134317e0c.3
        for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 20:20:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708662013; x=1709266813; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IlVNrNUcEvLBYtZ/R3wczPrppgdB8B334NNJl78BewM=;
        b=eCY90VNhTD3ITIQqRU8qfb6A64raxkKU1Qq6A70S6sS9FMn6nXFZvUtzF8c9RLu1nZ
         T9yZ7Kd3NiDV4Ga2ouwUiNl+fa4RC+GyDy0x6PgSVhKVWuAKxW9wUE6erS7+fCRWtriN
         EJ9nO1YbX+pf80zRuM39KcuYroiCbwynhwCfPjSI60YVf5BsXJYilUyNA5BWP7E/Svvb
         Cytcb87XW/oauFLABvOYO93U/z9pnqo2Cb543CXqb4Ze6hpKFuRmfjC9uP4EcFCrg/gK
         VDrVpJhDF9M+8AoN36CFBlZDe4ssMwDnJXw+eCxnpSuIpCOpI5o3PM2kyM0RcrUBjKBz
         XfJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708662013; x=1709266813;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IlVNrNUcEvLBYtZ/R3wczPrppgdB8B334NNJl78BewM=;
        b=icy8R+HBzjLzab4HG+peOVmv6dgoolsVqBkHDiLyAYVSVbqiFgTMT7gn7qEiCIUHOL
         egixV6vtHReW7XbRerffZh71EbZ1UX2OLrX5C+DIQYcaf0Qs2Kg7bhtyETpe8c3FU6Id
         UPcfTpPaaa9B0GpzJJWFB52vdQ0qBV9onXr9BOBnki3Azp4v9GjgRQnodSiOZKsmOi1v
         Dilth5BwXAX2ep9vH6Cf9jt9fnez+xnVqb1oF+Uok/YRS04PrdV3Sz9YlGJ3Q3O6J1XT
         FetrViR5lDHc52VuOyzyGVPpXNB7rTHNvTm+w7R3OwOUP3RoClLkwUT8+WcXxrGw0fUz
         B3OQ==
X-Forwarded-Encrypted: i=1; AJvYcCWyfbGD1WzC/OWdNTp7rqbvj0r0JMtje892E7P2bQAq2YSLOf9WYPxFNTmsNcKVNbPIe1a8RlsbqUIjwTT0cDYdtf10VRTiul3hFU99
X-Gm-Message-State: AOJu0YzGoRemBUisIgB2rAC87jf8dQT/cxWUivX/yqiW3QftHIkB2r32
	1Bsl9A/syk+jbwCx9Jlcd4MDbLFigmaSzaAlOLwlVxshLenUUU9I
X-Google-Smtp-Source: AGHT+IHNYz8ui9bmM5AXfuUQTZHUJJqwDxpL3NhzRWFZom+4Tbuq2mDgCO5c/ar3KzUA7uEadTMX/g==
X-Received: by 2002:a67:ad19:0:b0:46d:2d23:f500 with SMTP id t25-20020a67ad19000000b0046d2d23f500mr951202vsl.18.1708662013521;
        Thu, 22 Feb 2024 20:20:13 -0800 (PST)
Received: from [192.168.1.3] (ip68-4-215-93.oc.oc.cox.net. [68.4.215.93])
        by smtp.gmail.com with ESMTPSA id xq18-20020a05620a5cb200b007853f736893sm6004275qkn.5.2024.02.22.20.20.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Feb 2024 20:20:12 -0800 (PST)
Message-ID: <dd64a40d-0a7e-4f70-a516-632a3d57807a@gmail.com>
Date: Thu, 22 Feb 2024 20:20:08 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 01/13] mtd: rawnand: brcmnand: exec_op helper functions
 return type fixes
Content-Language: en-US
To: William Zhang <william.zhang@broadcom.com>,
 Linux MTD List <linux-mtd@lists.infradead.org>,
 Linux ARM List <linux-arm-kernel@lists.infradead.org>,
 Broadcom Kernel List <bcm-kernel-feedback-list@broadcom.com>
Cc: kursad.oney@broadcom.com, joel.peshkin@broadcom.com,
 anand.gore@broadcom.com, dregan@mail.com, kamal.dasu@broadcom.com,
 tomer.yacoby@broadcom.com, dan.beygelman@broadcom.com,
 David Regan <dregan@broadcom.com>, Dan Carpenter <dan.carpenter@linaro.org>,
 Miquel Raynal <miquel.raynal@bootlin.com>, linux-kernel@vger.kernel.org,
 Vignesh Raghavendra <vigneshr@ti.com>,
 Brian Norris <computersforpeace@gmail.com>,
 Richard Weinberger <richard@nod.at>
References: <20240223034758.13753-1-william.zhang@broadcom.com>
 <20240223034758.13753-2-william.zhang@broadcom.com>
From: Florian Fainelli <f.fainelli@gmail.com>
Autocrypt: addr=f.fainelli@gmail.com; keydata=
 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
 HGuUuzv+GKZ6nsysJw==
In-Reply-To: <20240223034758.13753-2-william.zhang@broadcom.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2/22/2024 7:47 PM, William Zhang wrote:
> From: David Regan <dregan@broadcom.com>
> 
> Fix return types for exec_op reset and status helper functions.
> 
> Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
> Closes: http://lists.infradead.org/pipermail/linux-mtd/2023-December/102423.html
> Fixes: 3c8260ce7663 ("mtd: rawnand: brcmnand: exec_op implementation")
> Signed-off-by: David Regan <dregan@broadcom.com>
> Signed-off-by: William Zhang <william.zhang@broadcom.com>
> Reviewed-by: William Zhang <william.zhang@broadcom.com>

Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
-- 
Florian

