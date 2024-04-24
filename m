Return-Path: <linux-kernel+bounces-157177-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DEB28B0DDF
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 17:18:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DE71828A93B
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 15:18:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A9D215F413;
	Wed, 24 Apr 2024 15:18:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b="WqzvqSdV"
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A1C115ECFA;
	Wed, 24 Apr 2024 15:18:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713971885; cv=none; b=sFrMrE6UmPd3z51M1Dcm3UrHOQCU1aThPYRG0muT2NmLPkSjnr1KH9mfqhgKhbMNlBaCTdnK40ssI/LwXkg4zM6Q+iXg5r3HmzBy2onaCfz04CYK/iFL6urtH8OzSw+1nEf0M7vgNk0EGEdktvxy+27VC/3UNdcfEit7MSBrhxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713971885; c=relaxed/simple;
	bh=hKhgyBQaIZdPBanYauPTJQBk8T8HfLnU6YYfO1XTBqs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kTwlVAL2/AeB0Z7XaWU7e/R+sCyrKrU9poNLsFY4qRwiTvmGqdASOT4e4uj0dPMwGduPQWMgmN89Y98vnTFM/1aAIhQhlsrVRMn9bcAeu4xp9wMMcfwNH+iUkP0RVEdh2ywub5YMc6rc03k+pPv4dLSR2nPEZjGjy/dnn+p+3c0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b=WqzvqSdV; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1713971861; x=1714576661; i=wahrenst@gmx.net;
	bh=9l8Ej71+gVBCVmFttV71A3zsw73ohtw5kgeGzerzOQk=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=WqzvqSdVwnO7rcI/gEN5JWKi3KApwpr0aP6DODflLyI5SWV7brLSGf3O+9IhHlTu
	 YV07j7nylJrIgh823aMGA/Qk9j4Z+e5vhMg0erSkVFnVmH/DampHvHLyy6+/6vIZB
	 vIu/A691/0EYb/2tSHyBhwFYCqtAl2CyQiMFyXeQ5OtGdgKrnuTZPO+xKRAlhgNgm
	 xM5IPUxTwhLS8A9iFQ7wyWWlEQ2/xXL7luBKLC7dBLecILD2cBR1EeQnPMa/2UfX8
	 0dvGqMclUj2I0X3tyj7ypd1BLQvbPdPjws/9l6x9I+uKfiGmUyuhD8pngzJg7zaJF
	 kIziT2Rxeu2T45xNGQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.1.167] ([37.4.248.43]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MsYqp-1sojfC1XQ3-00u5QI; Wed, 24
 Apr 2024 17:17:41 +0200
Message-ID: <35562a06-6f6c-4b41-844a-9e7d79c2a83a@gmx.net>
Date: Wed, 24 Apr 2024 17:17:40 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] staging: vc04_services: Delete unnecessary NULL check
To: Dan Carpenter <dan.carpenter@linaro.org>,
 Florian Fainelli <florian.fainelli@broadcom.com>
Cc: Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Umang Jain <umang.jain@ideasonboard.com>,
 linux-rpi-kernel@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
 kernel-janitors@vger.kernel.org
References: <526ec2ff-6277-4d5d-b2d9-63b087a97c7c@moroto.mountain>
Content-Language: en-US
From: Stefan Wahren <wahrenst@gmx.net>
In-Reply-To: <526ec2ff-6277-4d5d-b2d9-63b087a97c7c@moroto.mountain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:pn54EqEI+ReomyIvYGsabZS7u5ZeWG/xdblQ4zKi5SKm3Po5+A9
 nisTkwc+oL4la1YiyMWdAgy25cWqykZFAsOyFUTBWdHS8hJmHDRda3CuIK7fgswOTTFMpyV
 SdSKXfnf7ZIKpjNxXLINZ65kXUXGVruDfK0fOYFzEDJLcWFFtUv2MdjUF0xP2weU1vNDmY2
 AwY5McmMu/FcZkjiZgfRw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:zhvqWFM7hNA=;yogIy8PFBLK0D16lXiKYdmse7qm
 5TEkh5odup+x9sjC7I5wSMLxoElokGYC8yZF4en9A5aj8bV1tJvslSfIhk482rIntm/tx1NUs
 j3Yea2d3gPXCUZ85ixzEmDKkjHW1EwVB/QsMPDvS6CkSuCoFle3mXMeTVL35OzRqFWTK1dDVg
 Imr9hwIjqiwRYAiCeQ9F85Y9g5N2J4bzV7REupt+3z2z3o8oj7cuiwVTh9z23RLb/6XLcdFbl
 q8THSjoOXwA6XGKnNAl9xiiX4fT5BwKd1KzRuqAIa8nOG2ehnaEovOgQBQojhDURK9aCnqsME
 CKizLU24XxitG0LSlz4CPV6fVI/uz1elR0M7HZtVnSs5c+SrMpDHPHC1F7n14zkJIGqR5IhxK
 3SnFSqnXnbTT+XY91RR0txzsEylF/6tidFUZokJByNUIVbBtIq2gFN63+O/5TUxFFQoZhlnih
 VZMx5PU2f8fHlzUYAqxG3TVsURqGXn6Xg37XmuapHeVG/bnFb9/pm4kFnj+36cmtUZtcAtWhK
 PVMwTw5/GdhI4Dm/KkXeJsDrPG+Qbw8o6DdMYbpt4J9th5NhUtG6gUFn6Ppa/yerOpqqU/Apt
 iyYiSpDK9W6YF50mnJ8RNoC9LthQfU8PpvA7zD3MZY/cuZJkOV/zTb/Htzv8Blx8mIit+yvBf
 AzPRfGIzohv2jfBMszSWd5iSquSBxXLsf/Uf4Aegrl+klcJZe5IccOT6KOx7Ck3Lfn/nTg0yl
 c6Nf2agIDGj5TtfdNmkDucq6A3eOwXkmOfojoBQGtUlgQjzpxmQ0V5LdiDCjSS5u8PjXVBvHr
 pjvulL2/YN4MmY4pPYz+G0Q1gfTnH+PWn0oCeRnBzifEw=

Am 24.04.24 um 13:43 schrieb Dan Carpenter:
> The "state" pointer points to an offset in the middle of the "mgmt"
> struct so it can't possibly be NULL.  And also we dereferenced it on the
> line before.  So this NULL check is pointless.  Delete it.
>
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
Reviewed-by: Stefan Wahren <wahrenst@gmx.net>

Thanks

