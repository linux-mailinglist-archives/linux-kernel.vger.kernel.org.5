Return-Path: <linux-kernel+bounces-137472-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AAA889E29C
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 20:32:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5C3E91C22687
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 18:32:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FDDA156F21;
	Tue,  9 Apr 2024 18:32:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=rwarsow@gmx.de header.b="XyeLBRX9"
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2BFE79CF;
	Tue,  9 Apr 2024 18:32:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712687557; cv=none; b=FzwU/wzxyOAK2I8WIyv+lor6EZBGK2uh8v0YhLVHiRfqmRCUXPQHuYVHinGY4vPLlSmVtgd7zrtk64rXkj8kTNJgNJspu0U14jIJGTIUapYZ805DdfMKE5fBzoIJgoe4MSyL8IvFIqIN5zS8SWTa85+/uQ0rh0hqbLZcjf4xjy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712687557; c=relaxed/simple;
	bh=dmMdDLN3YgL1qMEqV22WwccWKGPvTDnUyQtKaq9KA84=;
	h=Message-ID:Date:MIME-Version:From:To:Cc:Subject:Content-Type; b=qp3ESlQTu3BYCz6qGVtQPAFZ//TkU2Ad4dJ3Bu69714jyuExLf8mfeyoQnlRBwxUmUfi8eYtCdRF5K3v7jXBFDn++Bf61xowAYJKVRKXLIFViKCQqEirZfJbA0zS8KyWzO9juGoEpexEIf77QbI4sZbEjlptTLKSPovNi02heE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=rwarsow@gmx.de header.b=XyeLBRX9; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1712687552; x=1713292352; i=rwarsow@gmx.de;
	bh=dmMdDLN3YgL1qMEqV22WwccWKGPvTDnUyQtKaq9KA84=;
	h=X-UI-Sender-Class:Date:From:To:Cc:Subject;
	b=XyeLBRX9Qx/FsPcjAYMu8xyhFgLp2cnsX7n6uBhlQzMIa5mzySCoNFphlScCZUTZ
	 CTBwXHa2kx29A6Ov7fXldpSfKEl0x+du0mFjfqdUYy2b7d0LewkjFGIr0wSCw8QCX
	 ewejgu5nEl5F9Jp1sC+WnhskaDAxyFjyXxZXG73xlNuUOi+cxzr6CHGkTOg3HH5bX
	 WEcKEWHTtyzRNXnyRMSo+KeKO1LGHSf7bJrcauxNz6QvURnfwiqOCo7TUaLs4ijwm
	 5v8SvWcknPd5vCkgxWX4KkjhFxt2v9seJPjAdtGOBaPxZib0U34LU6fK/H8kcusxt
	 Wwe/BjrBXG9y2vCHCA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.100.20] ([87.122.66.78]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MyKDU-1shhZE0yj6-00yhOI; Tue, 09
 Apr 2024 20:32:32 +0200
Message-ID: <2da62874-d10b-4149-ad9f-c1b6a936e2cd@gmx.de>
Date: Tue, 9 Apr 2024 20:32:31 +0200
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
Subject: Re: [PATCH 6.8 000/280] 6.8.5-rc3 review
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:HYzSsak6QFYH/SaDDIC4psBVJP+6Bv4e0pRHtTf1syWoGPfWnQS
 BqUgnTwI1b9fqjeyH2eqK/5Vs7JT7epMWbSpwi8/Jxs4l6KkudJ8dadLcwxfC+byFl1UQPP
 z5CFfaJaPEMmLpeawFR/GGQjmee4j8pW1MqWVRPWRJ1qXywqFk412Lqz9GSjqPFlxMTz+KM
 yx2107ClnlgTxhYKyQQuw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:t5PNVBFZ2LE=;7JDAWgS7WHLvaloa5ktDAndqYga
 6otbbBU3Bg2Rn7pcLUNpeurO6e//8cXH7q/KOkUU7RBWdS7znV3Kh9mGb672itrqEvMgOTIvP
 bG04HCGS0sXx1JFEXlk0DH/JRvnw00dyk9+CFNdilbtWZ9ff8aT+zJ5Yo7U/TYm756vt4GAVD
 DHwtIrZeadm1+hACJBDY+lmiVQq/jFeJ8j9lKOmnbeEoBTe+2wvYxWcWEm2d0ZreVGdx4rX8k
 94+fkeRDxOx+RBidc51Vx+IaP4TRSzqGbsjPiw7XVQoTEZGa7cDYvvSh3SO1BuzTmXk3oGNUm
 6pyCwbugjM4xWzNU6nq5CVnhPLjpSgkeeAKxyTEIOdSxx4dGWlAYrw8KXkp8iB3i6TkoB8e5a
 T9UdeEoG0/UylfqGg3UaiH68lNymi46g2tuBoe16TqSmU3BVU3cUUvMle4c0LT9vBOV97JLUN
 OupMjpN8xX7RNnF67hQdcDORTEEDdOoTCq8D9gF4GG00yiI4nsMwa5EI6YS6D+PpZgGVG06y4
 mOGdvIa7R2mq6TUK1sv1PhN6EP1JzEMbe2z1d8yZ4WFJ8wtuVSHcy1HNJWysgUzzFl5Ldk8sj
 pvM6AwrBeJz8cIoXR+nJDWrAbazFcrdrBRb5wxu0yP4zf56n6bLsAR+cRvEHs1lmwQyOzPaBa
 74f+HP1Qi+8TValxYeJ9iLFdhQKVpus33GLkeYqZY5SEtIpIZKXwLfaED9H1th56s6Prl8Shw
 c+sMguh6WEQVBkrCisoJ7DsJz9kyZmlIUhkb1mlqTmNGFxyUwl/0+rfeT66i4v5F36tfZLZW/
 RpeMTsuI8MIl1eRdNqWedDC+O5Lla4Ejw2xMrKzgoS3SA=

Hi Greg

*no* regressions here on x86_64 (RKL, Intel 11th Gen. CPU)

Thanks

Tested-by: Ronald Warsow <rwarsow@gmx.de>


