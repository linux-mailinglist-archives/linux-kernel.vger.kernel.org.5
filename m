Return-Path: <linux-kernel+bounces-53139-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DEA984A12C
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 18:45:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4A394281AAA
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 17:45:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1E0045953;
	Mon,  5 Feb 2024 17:45:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JnP/l/04"
Received: from mail-oo1-f43.google.com (mail-oo1-f43.google.com [209.85.161.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0C0645949;
	Mon,  5 Feb 2024 17:45:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707155104; cv=none; b=QlGuth+VTofqhVALzZgHRt5uhv54Zbl7MwDuct3PAV678HspkhYPDDwmRWCDVGg/vRS/PUyawlH1ME6tMsEWkwn6zjpPlIrgkfkK2cglvfmo3Evlsow+Uzbeao9bA2KHgPDls1SJZFQJJiJpaMcQ/+451RWhTM3e/TIEVWy2ypk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707155104; c=relaxed/simple;
	bh=aqqnMA5SoWfZA9DBTv6yHfAy2o+WRNv2ptmq6E3Xqy0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F+ME7VZi+BxlRNb9I0hr7FogTqcccIilG7iAOLlsJIC7wApOzSjTeivpd6ZqRehv/kVoPF0qnnCDWcMyduFoWMKLURFzEFa2kwaaJtfuRvHhbngnyNjRj3XcfHmPf+c9c9MQKvQA73kgcI2Cpm8j0JC4QoIR7zd5XOQQtm1/RJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JnP/l/04; arc=none smtp.client-ip=209.85.161.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f43.google.com with SMTP id 006d021491bc7-59a94c0fb55so2473637eaf.0;
        Mon, 05 Feb 2024 09:45:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707155102; x=1707759902; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=edMJymLmLx9Tj55QtDpqgq3g4mXEx+8yl/I8rdy5fuw=;
        b=JnP/l/04su+4TxkREzaW1WeRv9iyaye3IHzjf3GhNhYGCBKeNKWSH7Ffmv7tAouHzF
         eb3AAhQrd+0Qa/XBf26tNEwdVXzi0k1o2XvxdB+c+ZD9c7r5eBVyah8VxrqG77AOb3SX
         WScc1WMcntfnuZFnZTOl9FCJJzOKRGSm/EkiM8hRsfhUymF4Ll0xnar/uPULnM4+DOco
         kBD+yLnpfbeAcEyln8O1c8eCQ9lbGkA3VO1CCO+mWIZHZbAar9HFbNcJAvn05wb0Bgd1
         3Leh1pRyqr1iHRkL7rraRr53J/v8RB4v+plggZ6+m/lpAD9DgzC859YOLJiLLv/Hodsc
         cjuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707155102; x=1707759902;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=edMJymLmLx9Tj55QtDpqgq3g4mXEx+8yl/I8rdy5fuw=;
        b=wvFpOFPnzUjvQhNt1Z472Toofo/jjmNyFFbzHcHfu5/0d4sRO8M+Qn92mqsGH4aE64
         U1MQtRejUIoMGOZ2PsIDM0KU1CfJgUVZXxDamY6xXbmBiQHVkMc1U4162KZi+dPJGxAz
         0idVqAMiXS7RxTJ67yU5CnTYleYho6yp11gsk014VX/R76/fDxOo5paFIIrASNxzvfkV
         49+53IM8Jv+VmY0iZTIcjAtRG/vQzDsrOz1RYSrkpSVslnahkfiq3SSZuA+PkBmq9dQt
         xfo7eYe/VWpWQ+Ykw7miaNDCjlEalp7wtMzA6CILbq/u5y/D5mzdt5NC0fJWVr6N7CAn
         SXVw==
X-Gm-Message-State: AOJu0Yw3hmiWsbmNVSiDV8rmlw/3VjaxZd64JcC5np/99VWpd4Pj+3WD
	zGU5p6BKbZc5VHFSgW4RCj6QEvzAqJpx5P64fJPUfk7TJyOHtUNn
X-Google-Smtp-Source: AGHT+IEh3POXVY/xKsQmrIWHNU+A4f6jZdt6zXynNcy1ZXmgXh7bbqM/EN+vjanSEamY9hhKj/PIUw==
X-Received: by 2002:a05:6358:291f:b0:178:c7b6:b563 with SMTP id y31-20020a056358291f00b00178c7b6b563mr587283rwb.15.1707155101792;
        Mon, 05 Feb 2024 09:45:01 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCXOwm3S9V14t1CnUivoW4lq78qsUIW1WMA29ELL2H14gd31E88qH58AjZUyRtwNsu0oTT3Zi7IQGFUFDV9OEGNZ7XmWAjwhFdidO4t6Rm8v5eLULf41LDeS1pC+9Ap20CR0ayml+hlmAbyZzOw+wzxcJaNf+K98dVqbxReGJRyIJdikx8Ou9ijUbn0NQLuSej5ZY7Ki
Received: from localhost (dhcp-141-239-144-21.hawaiiantel.net. [141.239.144.21])
        by smtp.gmail.com with ESMTPSA id e12-20020a63f54c000000b005c2420fb198sm270434pgk.37.2024.02.05.09.45.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Feb 2024 09:45:01 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date: Mon, 5 Feb 2024 07:45:00 -1000
From: Tejun Heo <tj@kernel.org>
To: Helge Deller <deller@gmx.de>
Cc: Helge Deller <deller@kernel.org>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	linux-kernel@vger.kernel.org, linux-parisc@vger.kernel.org
Subject: Re: [PATCH][RFC] workqueue: Fix kernel panic on CPU hot-unplug
Message-ID: <ZcEenNqfJo2lSuNK@slm.duckdns.org>
References: <ZbqfMR_mVLaSCj4Q@carbonx1>
 <ZbrJq3X63hIMkbl2@slm.duckdns.org>
 <8a266076-b3dc-4a39-aac4-089e2ef77da3@gmx.de>
 <ZbvM1V8CYNeds14r@slm.duckdns.org>
 <e6916a78-7872-442d-922d-31ea3920da4f@gmx.de>
 <ZbxHuS6vOc0MB7-R@slm.duckdns.org>
 <983189ec-e8fc-41ef-bad7-cfebad20ac83@gmx.de>
 <f75e7606-0904-4e97-b337-e8f74843e87d@gmx.de>
 <Zb0mbHlIud_bqftx@slm.duckdns.org>
 <12d876ba-a325-4442-9526-3ea9e2117c0b@gmx.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <12d876ba-a325-4442-9526-3ea9e2117c0b@gmx.de>

Hello,

On Mon, Feb 05, 2024 at 10:58:26AM +0100, Helge Deller wrote:
> It seems the commit 0921244f6f4f ("parisc: Only list existing CPUs in cpu_possible_mask")
> is the culprit. Reverting that patch makes cpu hot-unplug work again.
> Furthermore this commit breaks the cpumask Kunit test as reported by Guenter:
> https://lkml.org/lkml/2024/2/4/146
> 
> So, I've added the revert to the parisc git tree and if my further tests
> go well I'll push it upstream.

Yeah, it probably just needs to happen way earlier so that the
cpu_possible_mask doesn't change while the kernel is already half
initialized.

Thanks.

-- 
tejun

