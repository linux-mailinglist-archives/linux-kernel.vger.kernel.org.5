Return-Path: <linux-kernel+bounces-156895-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E38D78B0A06
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 14:50:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 14202B26786
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 12:50:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D2DB15ADA4;
	Wed, 24 Apr 2024 12:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=rwarsow@gmx.de header.b="F0nZJ2Kf"
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB47B142E70;
	Wed, 24 Apr 2024 12:50:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713963035; cv=none; b=pzcBHYH9a23o6Ix3a+NHW0yHtw23omOa17idM6A6oYXSN9Ny4OcsavgZRofS1DSMQur2g9FccmRwO3kvt3Inir/5A0fEznYXGYCENG/GoXt+Tpe8auwZd7qWwIDGiaow8m+d0ygfXl7dJXQGihiTnu7N720Wmtm3KJtg7DwSYFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713963035; c=relaxed/simple;
	bh=dmMdDLN3YgL1qMEqV22WwccWKGPvTDnUyQtKaq9KA84=;
	h=Message-ID:Date:MIME-Version:From:To:Cc:Subject:Content-Type; b=MZyn4AUzdVxdS8RRCPdBZaOvKZNwO39lINcjUtVe9M5R1UUuvDw9Be4N56oVOtsqONg8/6zpfZSNzqpAa6DTch4MJTD7q1vUtf1IpvdKsJbaf3dh1Nq6mEFUnne4w3Yd8KS5F5xzLpKJtlJ5Lm3eG3mAZZs9xDRYRjWSX+emOe4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=rwarsow@gmx.de header.b=F0nZJ2Kf; arc=none smtp.client-ip=212.227.15.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1713963030; x=1714567830; i=rwarsow@gmx.de;
	bh=dmMdDLN3YgL1qMEqV22WwccWKGPvTDnUyQtKaq9KA84=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:From:To:Cc:
	 Subject:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=F0nZJ2Kf2K8UV+aURnxIK6tNTXl4SLFKR1iXPbOamIY2bcrxTtaaDgOLbaFuerNY
	 dwn4cRNLDKDyQwUEG+W2I0pk1tQ1JJEs2EXIZVs+j5YHrNGgl79d4/B3geqdaP2YM
	 z//EvFRz2RMuD28otlCCn3f1w/kevQsaY9/jaV1RcunoyyHIx+WSk/1rIWdHbGhNg
	 9LmnM4+mv9bu5xU+htPgzCWEEwO/f7uUmo107hagOPIBs+/njle5vD6GpLELvQuQR
	 Gbh/gFBqeNlKHl2rRmh0hDhVyHF+NLWaHNRPKFvwYjISxdiBMRGAnfnGkJ4XhioWB
	 MQ8GNRNl7tIRXqcbTw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.100.20] ([46.142.33.109]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MCsPy-1rqqeb3Qie-00Ayme; Wed, 24
 Apr 2024 14:50:29 +0200
Message-ID: <9e51e052-afab-4cc1-a89d-37fa011b3c56@gmx.de>
Date: Wed, 24 Apr 2024 14:50:28 +0200
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
Subject: Re: [PATCH 6.8 000/158] 6.8.8-rc1 review
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:E06AIrlnUqaRSG0AcL5eJUYfjpw9Tod8fXNlOacax8MWCXmPI3d
 gHoTB4dezzOytiApIzoZzf1ZYwEPrdo+mvPcat8sXsmvjGhPzDEtb1iAVx28VJJ6+ruJB8x
 zGTZ3jSIjdUdBkOmXhBZ1RPK61hcdg8k/r7mqg8h5a26e8qnG/wxtKml/Pdwv/g25HWQUMy
 Z6QXhxQ5NrjZGfcOOPKlg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:zULSEayqDwI=;inryPKku8TsNxJReu5EMSFixVE4
 cXmYJpZXefB5DBOla+n99AH/5SFeoBX7NZa1DSf724iosKzc4yubkM/xGuF8hm1s0h3w695Si
 2a5XUKenralOVb8mqVkzEgj2M9xULrDddbNH732Zwm/VjTGN4mv6YMz+fCaOQYYn//+mG+a2r
 LHZXhdfroY9kJBKagxw8mLPNZG0h+cQIvUSFUYmucd8DJ0+sya2MTh3MBcp7oQzGQWsoH1L9N
 T3/8aH9XSEgl5x3Whefxr38dwGtRUc71GbF+sdfjd+qDjNcImjtGfZUrXQ5zwIUtM1aBKSoLh
 D0sCq3jncXNiBp4XghCVaSTYV6sY4a8luFhNrz12pva1SjeXqx9SLmCsN4fmVdex1Tyz1nvLj
 CvScJxnLo8e9W8lLSMsYCtcDmZe6ERF+tMCeaBXp9fcFsgUArOGKVe+FSjbSGFSram4aA1fdD
 sEb6NyAXBqkMWONEex8OBSFXHuZb5IuPV1PSfeT2At+2PBg6+dT6gVMk9glBsUPM277DQS0Jl
 +K8cEB3SaQdGaFYIkTV014sQnl2FhBJb9sOmoQrWzKLKpNFak0hHDOXqFyHvkkLgvbKfN29Nh
 XjF4Q5BiZcgPsbnmVzcQi44g/HVpo5qfg538G9Z+sCWBuOb4lJh9VeW1pq/7t1wsJMs40TOyA
 Oys/dwA6KhFZf/HCboifKX0mhHuGE2H7HtGKmGefCsnSWpkFlCvvW7wtRwoRXVUPgajM6Ww71
 8DTwbAMMLiGC98iDOJXlykOh2kHf05aU338tIo0zuFydjRx1HZU+fibbnjGNjKW7SFqplggXk
 D6hVuyGFBDHbGDZXFUAobVjKLL1YkDs7LgEop3Vz1GdUM=

Hi Greg

*no* regressions here on x86_64 (RKL, Intel 11th Gen. CPU)

Thanks

Tested-by: Ronald Warsow <rwarsow@gmx.de>


