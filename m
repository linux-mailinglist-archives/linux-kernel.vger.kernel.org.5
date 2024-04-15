Return-Path: <linux-kernel+bounces-145640-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D12158A58D8
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 19:12:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6F90F1F20592
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 17:12:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C36284A5C;
	Mon, 15 Apr 2024 17:08:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=rwarsow@gmx.de header.b="g4zAKdQI"
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E032882D75;
	Mon, 15 Apr 2024 17:08:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713200935; cv=none; b=IJX+wLQ/uMjFsI34RYBlxw1UxYPnV8KXI2kwNBH5b/Wc2Es78eE7nJNj6F5iTpY+WqehyfibTd15pn6d6x1ICNogOPn8mosOQ0sfr71IPqxTekYFOpL4OU0/LkQ7bqGKmfXQ3J8GwZGs+EYFz92kbjtFIgqR8xyWXf/eq0Phy9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713200935; c=relaxed/simple;
	bh=dmMdDLN3YgL1qMEqV22WwccWKGPvTDnUyQtKaq9KA84=;
	h=Message-ID:Date:MIME-Version:From:To:Cc:Subject:Content-Type; b=LlfCtdoyZL8KEVeGtjZFjRil83YYZV3N43PS1yIB8GuTVagBoDiNGmm2AiZPkZGVrRq2D7jIVP3Q7BrARqHV6MKKThAnDUQmxKaZElRA19cd5fQzaUHmHiUgNsF8LHKKkcMil3Ta4yFZHxv4T4Xs1Xuocnxn4SR9wpCXwZQAvOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=rwarsow@gmx.de header.b=g4zAKdQI; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1713200930; x=1713805730; i=rwarsow@gmx.de;
	bh=dmMdDLN3YgL1qMEqV22WwccWKGPvTDnUyQtKaq9KA84=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:From:To:Cc:
	 Subject:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=g4zAKdQIxUtzsJc8HkUgKwP1ZFTgS12sya2+H50LhisgImBJ1AH6jWhRMPrupDHX
	 UrvcqfW1wLTb+doEDvmjbkknUux4DYbqgIeTbsTTgOShd7FxDcpXNnhu25uV+9khO
	 X7FT6slScGVoYBwp1CiiYCmow0nzrmTeXO9jeGIzZ/hNopyuS51FdElqpnpUQCFHd
	 D23+mXcHIiWofPikM/5YdjWU7NzZTsFx9TZRog/tElbbPW/slfNkha98kYK1Y2tH9
	 7eMs05V4wLlemZsRjmmS51jp3jsGf9Lx5ZN/AexsVakjuPEVSalnTCID6/ek0sf0R
	 TSN9OIWxaMWUmK5rlg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.100.20] ([46.142.35.142]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MNbkp-1s7an31Tzf-00P8CF; Mon, 15
 Apr 2024 19:08:50 +0200
Message-ID: <f37a5dee-3580-4db2-ab5b-488c20a5e16a@gmx.de>
Date: Mon, 15 Apr 2024 19:08:49 +0200
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
Subject: Re: [PATCH 6.8 000/172] 6.8.7-rc1 review
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:VVr0raUEtCN5wDhi5HcdABdQb1twQD+p2bRg7V0GYQ1bitH8Yo1
 XrVspr6Xbx+2aY5nr5cvJSgEWlYKW32aX1RshXeeiO2sI5XEEGwU51/hGWNr+Cg7YSjqU5d
 rLc5vGe6BbYot6SUYc8yo9LXOkoN5EyKo8rHF5kvEZuLnGv7beqdV5Dgi9K0NGIIU53OcmL
 cimjAzPauKj0d81BCP0zw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:JObNOgxnbn0=;4vOZuCGOwZz01HwE+6AaMt9uUOo
 nkZ64t0qIIpHHW6DIhrwmu+1MwmpPLcbzC1VyR3Xn8gtpcFFPuh+hlp9mgJCuHOKojPj/gyvN
 giramcqYNehfH2ciqMab5vr7a6LryVpPNG9016etLmQk1Km20CWQitXbKVKmr/PfAM3IsW+7E
 ArGmNemEa8maV9+HZ84rik/mi/m3YFud+U0Q5+w1wlTiAMD7GttA92naEjd6TOdj1cn86H6yB
 uax/eS5g2OnPaRW3L/fKMp4hq3jQVxxPAZXahkSym9OTwqzPfDIBjpRFr4kuqY2cxjTISWZGl
 2EQZgX5AEU1EaSeGkO7SBd5Sl7w5m1f/QbnaV69A8VUmvgNOoOtl4HaIudahq0jhrglD2jmI1
 8pJCEK14+ufgYdUHcbLa/M++/Sse3Nzaz9FS2/UieTsUsww+7PyOcGa5Hu7EJ/Y/HIHrycuBT
 Dq5DfHydjMyE/BdXv7ZLg9sTTxUzVERzWhLSLSBDvAh7dRaQlT82f/TwNKeCEhk9nKI3B6kR7
 PKiVnYgpUKQmlCZipT4uuqbPVx70pRYI5nEWDmXzO/RQB/FOhfKbEotk6JOz/FZaIkafbVLoI
 msvz4bhafnY3TkQLKsi6OCsqaXC7au2vOAOmoyInGz/Yzm9WNFA8Bhap9hMVhmH1Wsy0WNKiN
 FhgsvvE2odZoURCY3vaFiV8DC83Fkf5IgeWie26ZLIESW/NSs6GD4uSnnIInPdQNWNqD2P0+K
 I+Qm0233aM8FU3hIPwN//7Mk9FQiRtaxpExQu7kmlgkHXlxbzmfiIRBNZQVSIaPNVQvO6W/uN
 Llq3moQ7XW8rIo6kyZvt2QshJplKm8jVJLTZOa/+z4BLc=

Hi Greg

*no* regressions here on x86_64 (RKL, Intel 11th Gen. CPU)

Thanks

Tested-by: Ronald Warsow <rwarsow@gmx.de>


