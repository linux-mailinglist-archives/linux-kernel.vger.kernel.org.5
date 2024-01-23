Return-Path: <linux-kernel+bounces-35850-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E60D6839759
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 19:11:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 900B91F2D8DC
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 18:11:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D5A381AA1;
	Tue, 23 Jan 2024 18:11:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=rwarsow@gmx.de header.b="B7FhG8M2"
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C73B61674;
	Tue, 23 Jan 2024 18:11:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706033478; cv=none; b=oVLlOMRLGZt+BrRV5mWEhJN7Ni0S6CPyD59uGYGyeN/0hhaYa8vX8kwgd/UZztg79sMvWtEgrOp26bRm6izqSU0OZeQdq7/FeHUhom1+sHnaX496LLeeNBC9RKou1/l5tT5a/nHt9BQausanYAzea4b/cfRdcrGCJMHsVZ4PFUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706033478; c=relaxed/simple;
	bh=c/DzI/EJtwNTt/biOBCBJkuhhi5FFYaQGErDt8KLdHg=;
	h=Message-ID:Date:MIME-Version:From:To:Cc:Subject:Content-Type; b=uXJKnGALDzDFR5mJqGxT4LHt2FI+L+M5YTAetmKACdL2V9RcmZdXW5MktKtgbBobfbO8283JBr4W+3XvRVLE2OiAY+gSgWGVk8B390a34iFXQ4mE+PYhccUbgBKl1Kt8F07BHutxJiBTz4Go+97g/ME3rw5/z0foqV5RQKHe9uk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=rwarsow@gmx.de header.b=B7FhG8M2; arc=none smtp.client-ip=212.227.15.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
	t=1706033473; x=1706638273; i=rwarsow@gmx.de;
	bh=c/DzI/EJtwNTt/biOBCBJkuhhi5FFYaQGErDt8KLdHg=;
	h=X-UI-Sender-Class:Date:From:To:Cc:Subject;
	b=B7FhG8M2wEcLcV/hVgxC2aiIVNG8comhnxzoTu4/ks7rBQze2xYjPJSOgESskViQ
	 aTyNor96n8hg0N8trviIXPYmjUkfevz54RUQFNBU+n5kpLGn+LH4LgLkeOnWRkc/b
	 aXxG8qkwtsdYJ/Apnm1cb2RjPTucleBLprd4k0oL5KVIY3Qch0tzVz2+LWHagbdPv
	 215S0J8p8uZSuq3BoczbLBAWJZmbhcNJO6ZrVt/OGSWjpErvRaFz4SCX2vccFxlY1
	 HJD44XqGsBlgPfCbK0RFg4bY4v43LRRNqDfdFruiRyg0cUPpMmc4Zh+Po3aMSk2xF
	 OfJ5TQdxzOoeWQeNGQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.100.20] ([46.142.33.246]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MmlT2-1qmAo33d8o-00jstl; Tue, 23
 Jan 2024 19:11:13 +0100
Message-ID: <e7a25e06-c91d-40bc-8695-4e44cdf2ddc0@gmx.de>
Date: Tue, 23 Jan 2024 19:11:13 +0100
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
Subject: Re: [PATCH 6.7 000/638] 6.7.2-rc2 review
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:NX+PSeyRHvFQjWXcdeESU+lS8VsWoYYshfQ4ZW45Vw8lCJovVjv
 flkF7RUTqZCPYqwXGDHhmDOshdIwJY6H1tn1lcB1567HHyI2NLPFDAsMyacIDHa674CnPbp
 llIAJXeJ0y0SiP/mUWjwlpJdLvTTB6IVrvlaILNWbHjeGlwloUJoaniPoIKrst6GV+8zXW4
 qVap9FgP86xgro4EYkyyg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:pehPlRCHpn8=;CT5q0Z2BbHFw693tb0lIaJmuszb
 91cZwZvjvwX6FuG9b9PAxzdCEtKQdHioBAS34P0st8hwpq80Wjg0QNBdtDY7COa/8Y2GIo89C
 vhbgmV1h3kuekI89ish2XmsvKUmw8Pzvmrr29KK6G1yAuSgRqm+Z8Yhx2VVqGiXAy397pRsT0
 5TFIu8nv80B6wHli7gH1HZSJ/p67xu6nhv9kRq+sHBfXZr6iJRgoL8r8jYUeAyJik7oP0JaQJ
 0KiNDYYEhu1XpatGH4c7Y8pEAIK2M1IkCnhGBrddXggoZ3TQ03dec+5n5bAwhI3SldAxvXaFF
 XfQoQm6wI3HD3gxHWh8PYfHICWBmmGP6Y8AMTE7YmALDkFOmCNnev60ylOdE5AXGbD1tvljHo
 jel9PY4WcILXO6nS65Z28vEWX3BHAvm0EonQ7XidkZXkLvPy2QKxntPFSRNnsFCzFPBN1A3nj
 ZiPSBBZpP9SfEfPvT5Qxe3+LXI84NhA9sSg0YInH1xym4VAEgqBRjYx137xxc/0OzO2Qw8Azn
 Q3qfeoMDgyBafVaUWmor7ZiEHh7UKT4MPo+5BFJk6aiWPTgKKA/idwrjgltaaw4uGQwHKT6AC
 jhPIq8RvmzMRctO7YNXdMhk33Jn4GtK/Y3JqNQV1+iAmbu8BFjkNW8y0e9ZAwN5QFq9P1pMJU
 eBm9l7FqxxWK+hglfRcGybsXV2KkWMt+KwfNtHv9V/1W62dDDMjn4MZjIHEsAKhQYrqfw+2ZD
 SzIzPNhwl79rCFfqUR5vwCud4snjd5QnWxPLui8I2CSwP3G9eGxtTiql8KUJxKSRvAblRO6or
 p2fG27PdUgF40hXrMlSP5ar9VQqWUF1Gn9kSCvqnTIQ712/ANw4zM2O11I0/CSyiAY+NRysMb
 HaV2eiMXfYSzT0WOdRPcAbz1bkYQWDOMz5C4xj1iyIGRZF8jq2mZt8aEtUUEX+ETnfhTtAwg4
 MJsy6g==

Hi Greg

no regressions here on x86_64 (Intel Rocket Lake: i5-11400)

Thanks

Tested-by: Ronald Warsow <rwarsow@gmx.de>


