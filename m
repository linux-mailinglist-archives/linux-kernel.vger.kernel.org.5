Return-Path: <linux-kernel+bounces-161333-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 48AE18B4AC6
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Apr 2024 10:54:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E6F731F21336
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Apr 2024 08:54:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA4BF54BD7;
	Sun, 28 Apr 2024 08:53:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="CCrJIi0H"
Received: from mout.web.de (mout.web.de [212.227.15.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E690F516;
	Sun, 28 Apr 2024 08:53:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714294435; cv=none; b=OPDD5IJ7pFUONa9AtG5ph2RdXOnlIZysr0PAcDmAyFfThwzh49RXsJSeT06a8PMNwg5DfTYGfEum0rnwYEIOL11YCKGsU0Xwp/WXKpOoOJeG90BpJyq2wPsDrMbdKURcKWEpVJHNhI+xEWc1/cybgoqOYTsCBpGtmDV+Txry1zM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714294435; c=relaxed/simple;
	bh=4FYYvXtebx1umtlWiVHfZrloGyYitjsrHCQowXGs9fI=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=Jxt+9YtD15Hn7MpWbo0zVLo7oXm/+WeWzsi8nf0oewp4jUk9VKJXWWApNQD2RgUgj7tL4+DwlLg+VMSgbNtVGb5Uh86YvLmA9fBJQo5Ii3LExY1gCcZIoqW1RobMF4w8dKe5LX6UAM+dgNB7KM87lK+hh82+tyvlY3ZsGNs1RkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=CCrJIi0H; arc=none smtp.client-ip=212.227.15.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1714294376; x=1714899176; i=markus.elfring@web.de;
	bh=4FYYvXtebx1umtlWiVHfZrloGyYitjsrHCQowXGs9fI=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=CCrJIi0H7wex0VAQlUYa364LXPoHUrA6nAduJ9ESJJxiOw8J2/yYP9V3clzIPoRQ
	 iu5/YxerI3ByPssPVl3gb/8n4GWV/NfZbROp1Qpb+NvxYdAXxPYPfa+S8u9UdgHr2
	 An71vl+7V9OVPfKNxW5HMYjcYzEcoLJyeCPQrViSZhcG47lCf3TEmKG6P+MF0mjpu
	 yANFhxEM78hjbCQxPornZ940BPlomRsAJtr64MnR0XJS9zgx9Y/2GTt5lCNwKTIRI
	 YxBzYo6WwAjvItHIJwVMesMbGU7pHyWgm6tcs9G2yewF1fMsjun8QHv+b3FBqbJbb
	 qRscDh68Q3+YZ3GVvw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.85.95]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MD5nx-1rsVx30pgf-006C1H; Sun, 28
 Apr 2024 10:52:56 +0200
Message-ID: <ca80e477-0008-468d-8e33-cbf1d61f223d@web.de>
Date: Sun, 28 Apr 2024 10:52:52 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: LuMingYin <lumingyindetect@126.com>
Cc: LuMingYin <lumingyindetect@163.com>, LKML <linux-kernel@vger.kernel.org>,
 kernel-janitors@vger.kernel.org, Josh Poimboeuf <jpoimboe@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>
References: <20240323065550.603005-1-lumingyindetect@163.com>
Subject: Re: [PATCH] tools: Fix a memory leak in disas_funcs()
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20240323065550.603005-1-lumingyindetect@163.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:MqzjkRcsUqvVBNQOED2Vv92dFj5+JzxkE0jQbNKBZ9ZzKiXfYPN
 SJECP5XGLImyQeU9VOeiDQJM1Kp28WfewNmXY8pZqzlj0KuGpaPcF/GkNMLt6t8UE+QhUDI
 QOX5Zxh6HwhIyWQ4JyjLl7Jn4b6+O7Cq/ntk7Za4rk10QmhkqaXcPZoOemDcSleVzLCHkl2
 SSYwWul6vRX7nZnH0h/Sg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:bkOo4M0Swbc=;aACqtNQQJFJaO2T5PWnZjNW02eC
 td5qCHWqQ4+Yzq/g7+MpNWYX4EFgkVKFbl4LyqvtK2RmvwBMvuuSxDrDsy+BTY6N2JNmx3rmS
 J1c0dLcmnj6c0hoXP0zPA+Yw52+PBUQ7u7P4TLznAnXTfkzdFBls4SDQ4QA3BAhLXQztFGC90
 +oW9fZmXBy6eF6A4PTGue68G+hP2pip+YNmbhztRQ77YNWvYB4dfp4UhfAv/aY08Wc025qw23
 Qlw7TPjikMLjNbSUyTxmefVLayEogW8b/A+IKyxuMKFm66YQiXlmIsP5nJplaq2V3l42rD8It
 w38zbdbLOQtEPs7C6AaernNWBq6c7g8K1XK27Xn65/+bQoKBkrZeOrue5kcwhr1wAKMPJElq9
 DAhTxemwwzI4TnOj1y0oWYC52juAcfCy70jCagh8xECDqZvzjLhDJooCgIhjozOnCLlXwwvLE
 g2o1bwFKbcSqyuJc3YKlwuIezB++HVJ1tlPEe53skqUjNTITUywOYR5ZbpFKYmpyHYaytS/R8
 PnfULofLhrmvMzH+GAluIHGAM/8VWLVgt8/PbGL5dsqZx+AnmWE4jVlD1zZn59PhLKzhFYeMz
 bUUuGyCariNXQdL7hu9qy/gA8AdNfULHydWqYKvYGDG6kLmIE8i01+f+6XlEjETUIY2P+QbYf
 GczrwVOOo6PDy4b2dRZ5RVZKE9Gxv2sxN8/EVYHeeMtCLo6PIPCTnwwmRTZxDRi52KX8GEEdA
 TtrT+Eb3mU7m6i1HUH5EGG1SrzlpSYneW9O43OIBmxAdm3JjWMUbvcyJjigR5yLIHkaK9+9PV
 /12T7eUoZdgtpM0CIsXo2B+la6it41raCTojZdrpaE+Vs=

=E2=80=A6
> However, after using the memory area pointed to by 'cmd' (line 4619), it=
 is not deallocated, resulting in a memory leak bug. This commit fixes the=
 bug.

Please take advices from known information sources better into account.

* https://kernelnewbies.org/FirstKernelPatch

* https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/=
Documentation/process/submitting-patches.rst?h=3Dv6.9-rc5#n3


I got the impression that Josh Poimboeuf answered your development concern=
 already.
https://lore.kernel.org/lkml/20240323182209.xqzb6rsswvfbg74n@treble/
https://lkml.org/lkml/2024/3/23/285


Would you like to support faster execution of the mentioned program
so that manual memory releases can be omitted so far?


Did your email address change in the meantime?

Regards,
Markus

