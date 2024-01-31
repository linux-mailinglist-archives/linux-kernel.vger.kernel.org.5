Return-Path: <linux-kernel+bounces-45952-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 76DB184384E
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 08:51:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 343E1289B2E
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 07:51:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DEB255C2D;
	Wed, 31 Jan 2024 07:51:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="YrCcDfV/"
Received: from mout.web.de (mout.web.de [212.227.15.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A32845810C;
	Wed, 31 Jan 2024 07:51:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706687497; cv=none; b=D/hF1NpXLo7iM94YwYygPMB7v2uqhAHuvTby88AuLqrN98Pz5dQI0TKC1rH56/D+TgGcJs0R5coi09eEiwsbgcHvTZwqcQoK9grJw8+MiAmexYlC5UN6JewOxMZmbfnuKtA//sUHK/nIwrLv2H4uOIidhh2F3MQUa82l0A1Tmv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706687497; c=relaxed/simple;
	bh=RCpx2LOg9/ZmAaeB9rFYkX9ZLKhwvnqQppjV3dOKF78=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=peTHoKYwLHSQr6IKSoLpQ5WJzDg/XCBbuzKjPtjtQYN5rbiMONWmWOCBTmcgo6DIG7QlJKng/UAqCKKTXs7wl3xc1oPYJehO33N19bJ5T/JhEXE9dH6yRb/ZDKetrLa79ab23QOSmzg+ybei5vyvaKE3OlNThAhZjykijptNP/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=YrCcDfV/; arc=none smtp.client-ip=212.227.15.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1706687464; x=1707292264; i=markus.elfring@web.de;
	bh=RCpx2LOg9/ZmAaeB9rFYkX9ZLKhwvnqQppjV3dOKF78=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
	 In-Reply-To;
	b=YrCcDfV/YvrBQAMq1T8G78gtbH3KS2AwJOZJYkHFFOnIVVTLrDczUsxGgDZgAKqv
	 STfA2c4sAXxrLmmUaMYeg6imxW7oY+gd7rfYOvqPOpp4vETYlK0OpIcPVw7PBYtVi
	 0kmGPHapdqh13Prk6rNx/oA5jcO65k+/B8my+PyxbJI96RjDhWvCoIKIwSSEnpf66
	 JIvxnwFBZYKbl/iqFZwLA/cyAQ1rusJXn6d1wc7Q/l1UzfiR8Da6WcTEEKdhCBFgb
	 HuOsB+h88m5oz85ozx9EyuMvFoJj4AInNIQC1guYL1SQ5y045tEmuhQ1vXeOE0CIQ
	 AlUHyr7XeQTvs7y9rA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.81.95]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MPaII-1rikLS1lly-00Munv; Wed, 31
 Jan 2024 08:51:04 +0100
Message-ID: <35f48b58-8687-4620-a859-e16a0ef142e5@web.de>
Date: Wed, 31 Jan 2024 08:51:02 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: fpga: dfl: fme: Return directly after a failed devm_kasprintf()
 call in fme_perf_pmu_register()
Content-Language: en-GB
To: Dan Carpenter <dan.carpenter@linaro.org>, linux-fpga@vger.kernel.org,
 kernel-janitors@vger.kernel.org,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Moritz Fischer <mdf@kernel.org>, Tom Rix <trix@redhat.com>,
 Wu Hao <hao.wu@intel.com>, Xu Yilun <yilun.xu@intel.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Kunwu Chan <chentao@kylinos.cn>
References: <d94376b6-12e8-45bb-a9be-4887bb316d35@web.de>
 <b7e2e9d1-5e3e-44b2-a4b7-327d334b776d@moroto.mountain>
 <e760bd1b-30bf-489f-b745-128d05397feb@web.de>
 <5a3a1c80-47ae-45c7-86ca-8aa40566551b@moroto.mountain>
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <5a3a1c80-47ae-45c7-86ca-8aa40566551b@moroto.mountain>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:ezTFH0oi9O4DbezQPSoY98o1En7nW7T6V/09QuY+3PKrMaNo/CX
 f/ojdEBeK4DGkzVDOmK1Bl/r5M+rJFw2fjirevGhIvvjweZKnO6eEJgMyxDIfCcjBK0/2En
 vJ19HiQtGQfu7C+GTOBjyyTCmtptPPFoZ737xD6zUza44cA1Lkje+cX4hvOBUp0PvVthVzK
 OQi3+J7oM1Q/lFwBy2u+w==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:vPoORXPt/OI=;jr5MxVXfcURfY/GOeGuCh6k6qZW
 7gaJYMLUtiOWDy0jdnkrTyPREOPJ0lazjBV/hWpObpx7D+YLylL5FHuMzRwdaBp6zqbcpWi4p
 S3LBzbRIGwSro+waOYYyCUe3AnjR/NMRFAW/yOU7iBVT3IDKpeOYwavnrlYzKSkNlBc+yxPbL
 k/d63Uzth8qHRpTnu7thtGhNyEgEsmldl8C+TipxEqG3CgKqQCNvnLkEZ9o6ANIXFnBBPsU/I
 PzhvTxldQAIKYvEKSK9pxhbVwaYxzWPAMJMKZmZqi2Mxvo6e4GzyzFbpRHWCPDn4KR+Pe3RZe
 lQNxJQITSPCQvzmKjHceHmW56NApZbIRUYVntDwoUD25/AHg5QKpnXCG50i0Hi+a0eOjtyFYM
 OcCHPOEsPngcW9Bv7wx+YQHsvWScL3yI5R38zdv/K3C4MHdMIZsTlkcPgDM8pXey9U5t3uwTp
 oVj6MAgbcPfWeIsjdu7OzBkyp9tUizWMHLlXd+nXYoJwFTMzDIci1JaQNKaSK88oYgIJWkeSv
 EbAA0cbx8M/kPzNJ3UYuky3xlFFlIvAZXnJp+9UNSgwOOVfkeM/BbGZpGynyQLw1NEyh2eGmd
 8nEI0uY9reHFaPsAOExbW0BDT2vcJceT+LtI3vg0HfkrWnsS9yPfgPS/vcO4EGA9QJaYO90Nr
 p/K8d0IxvIn7usOdGAHTyWNBZe+JEs2CcP1r2w9/k0JGbl+i1laOqIP2tk4D/f1sNYIlg13sA
 qg07Cu/4XVarbG/R0yYnfY+B9DKFsD0uWMIiD32IXBd/z9GONfacApCeHS5iFI2KF8g290h6B
 PTJNOae7LEOrdqdw9a0bMNPAIf8dHkc3vHqfL+IdC5P/Ei4GCmLMi9Ya+spZAnYoMyKwumg5v
 PU1rgnbk3RRt5c46ucQw2pSNKmWysO6PtN8nOYKN2CitslON/79aY3mxYKZVdFTwmODrmgFdF
 XO76BA==

> The check is right before that on line 11527.
>
> https://elixir.bootlin.com/linux/v6.8-rc2/source/kernel/events/core.c#L1=
1527

Do you find a warning message like =E2=80=9CCan not register anonymous pmu=
=E2=80=9D acceptable
in addition to eventual other indications for memory allocation failures s=
o far?

Regards,
Markus

