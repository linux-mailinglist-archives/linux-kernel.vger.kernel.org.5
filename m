Return-Path: <linux-kernel+bounces-92709-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D09068724BD
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 17:48:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 34488B275A2
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 16:48:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 718C2D27E;
	Tue,  5 Mar 2024 16:48:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=rwarsow@gmx.de header.b="DVhW26hh"
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6028FC129;
	Tue,  5 Mar 2024 16:48:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709657310; cv=none; b=JiV/b140Knvp7HXh1Lsxj/l4bm4K5F8DC+2vUFuLYztJhZCMC5/JhRd6WYkAo13dqwTwk+TL/v3rDHXuyrd9mMgAc8GV1N8qJGSDm7CzWKOibawSs0WA3ZjHOaJXbgS2GQNttWvYYD90T9VAIi9mT639H6DUKBe9S2f8dPHYYpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709657310; c=relaxed/simple;
	bh=dmMdDLN3YgL1qMEqV22WwccWKGPvTDnUyQtKaq9KA84=;
	h=Message-ID:Date:MIME-Version:From:To:Cc:Subject:Content-Type; b=m1aNO/1iRzehS6eQq/9PJ6g87ITaNZYJRfXWOt3LnLst4A2wfxAfRnPTSF3zN1HoMB9cnIjjNbn3T1Iunb92JV9jQMKgsmNP45z4Lg30F4txoQmhQ/XfFaPjBH+wUZ8pR0jGr0KlAZROJ7rO4KtXhh4KGDnKsafUR/TGb+Uy410=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=rwarsow@gmx.de header.b=DVhW26hh; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
	t=1709657305; x=1710262105; i=rwarsow@gmx.de;
	bh=dmMdDLN3YgL1qMEqV22WwccWKGPvTDnUyQtKaq9KA84=;
	h=X-UI-Sender-Class:Date:From:To:Cc:Subject;
	b=DVhW26hhjPCdv2ks2WlNG4XA7icNzr/nakHCJ1M4Zf2wRhXGXHNbtU+9+J8snZrr
	 XVBpzKGzwapua86e2Gjtlj7uaIbq1pCARRiDxX+Of7RDw8GJ9j6WPUUGMgul4yLqR
	 8yWiifTcP+3pGHouPeO0vC+KqpUKhbT2Tb8GGpRr+LO2q/Roikp9AtjsHQYegK7aY
	 aXALiffdxU5YaCVGkyCNodjIabxA6q2FJDTYT7CIyLLUjDpBJn+55nnJo91S8nd/7
	 SpMQYuXyPIAVWDHTFmEpgEGxOMC7iEcl5Ifu0nlDBBCiv2rUeY0qwmw3YOLNXgPh0
	 DEcgPHg50YOGC7gJKw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.100.20] ([46.142.32.27]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MQ5vc-1rUIOn36Q4-00M7dJ; Tue, 05
 Mar 2024 17:48:25 +0100
Message-ID: <ab31e8b6-eca1-4bfe-9748-0f32186dcf77@gmx.de>
Date: Tue, 5 Mar 2024 17:48:25 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Ronald Warsow <rwarsow@gmx.de>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Content-Language: de-DE, en-US
Subject: Re: [PATCH 6.7 000/161] 6.7.9-rc3 review
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:S7GgjzMZQ5/v7HuiOEWSGxmtjJYWQuowpEKxONyBZgu7fM6Sd6t
 QpdvbrR79zmD/tdph6pwLY1ilO70b3VknjpeCQIP0i1KXKjU/X5I5++xDW4dtR88jnzHFhn
 QGav5ZcHTqTbQBYCIxr8Rd6ak23+pos5+stfvHEqpyopd2YUuwna381cDrNKofj04kCzNdN
 QDQ/se5T0i/mc2/cmgzAw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:8BwGdnCZSZs=;ed7YT5V16l8XqPcG2l24iUPDsv4
 ZBjbM+w8WKuo/0VwJeoI0D8nGy8vphPlpGy6HNScScxikJwHnVN7Kc2t6KC9W4Q71PXMNDJQ3
 4u9sVaavZl/r56JCYVnD45waTI8vjZbXnbODdYyw0+XnewUlRmHJrweRb6gLi73xzDvfcis8X
 5AtqG9cNlZWJGPiiQDiuuhRUJEt8s7oLNTW0cy5QY3CgRDALHU7W/zoOI9+TfHH88F7hiJ8/i
 lzCTPOk6enZzNDYLAY3fzap/lsLdk9LaGTn3fVuayNhu3j0aFpr/3hmPuGo4jtbDDDMK1lBvA
 6CS3rMEjsjT6mPKv9XM1HxyUEEebJlXCpTMKUy4sWOMbLBGn2pf45uqoT8DRnnnVIawStykLW
 Ilhgf1JWv6dsiU58BibOIb6I2D/zlPWtGiIFQxXCYTUHvt/mhj/Z0+hui5jIQwLa8dnxes+DG
 UDCR7VaKVJFIKX9WIBk4p2DNAd1VtzuBG2Tm+7cg6OJo82Q4lVLY6g7YD2vHuBWEr/Q0HduoS
 wAoOl5sxFYjDLcXl3F8dom4oCJgoa0lTycdG6wVJwbuUoTohESQ76txUk1dU2hI/+z3QXVQo1
 k8rnlCg7SepRIl5NHcHGvOqPVmxhRbHmy3et5ZuTxFFywr0F217bmyQIv0UAOJl9v39+yY9xd
 FeePDOyQTLNkw3aNZ86WjZe5mU/gjwcEj/ey02AXSACehCdt9s/8q5+a7GkWmv/AgaBpoBI1A
 08ZkbIDvg0/uQm+GYlyklUgk2EZ+xH06WY4DcPYrXYrCsBJFtsUZwBLfDXYi3ylydg6pYdqnk
 jFNo8S2bexsFQv+YyLdcNVprbgERHIkt1FlJFJJov0hNc=

Hi Greg

*no* regressions here on x86_64 (RKL, Intel 11th Gen. CPU)

Thanks

Tested-by: Ronald Warsow <rwarsow@gmx.de>


