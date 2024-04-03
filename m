Return-Path: <linux-kernel+bounces-130469-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A7BE189788C
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 20:48:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5C18A1F24E07
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 18:48:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 939251552E2;
	Wed,  3 Apr 2024 18:48:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=rwarsow@gmx.de header.b="E1a7BLzG"
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4709A14C5B3;
	Wed,  3 Apr 2024 18:48:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712170100; cv=none; b=ua9/yvhq5t8Ws8INmwThmms2/drDOB+VMPU+TPKMUiNRs9Rc/I4Z6hwwkBILmyhQHzS9bNrKsebG1MaNJ7+hLDrXUWfQLmZ7ADltfmtz6itbSK6L9bAh8kyCSsq7x3sPn2QFZcNpDa2glXSVq2G38T2RKWvK17up2C8SMiTOuEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712170100; c=relaxed/simple;
	bh=dmMdDLN3YgL1qMEqV22WwccWKGPvTDnUyQtKaq9KA84=;
	h=Message-ID:Date:MIME-Version:From:To:Cc:Subject:Content-Type; b=FpGdB1Et027Gx0oJji6MkmR2Tk5ohSqt4Gpbd2JgFzkKxO7swlxf5WL9fMfgvlSdWxAs/JymUov6EUGSFtvgON90cPZ8+9LRKJ3orHONAbhFctU+9aovyTLE8aRMg1fb9erKp1KNX90LaBWGpISk0Y+GfSYZxpqgwsYEqlmVN5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=rwarsow@gmx.de header.b=E1a7BLzG; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1712170096; x=1712774896; i=rwarsow@gmx.de;
	bh=dmMdDLN3YgL1qMEqV22WwccWKGPvTDnUyQtKaq9KA84=;
	h=X-UI-Sender-Class:Date:From:To:Cc:Subject;
	b=E1a7BLzG8pqS1vmy4VoFGlYABUnCufTVH2Ll3z/H1GsF7P+IfbBmWdZMi2EGvgBI
	 YGNaGx+36APG52pvESRnxyZNO0Yci+lt4RXYRXt+yKt8jbfnUzWlgYGeC5JD9wifn
	 as41FWKTcFuYyZSVpVY/UNHLESmO/zHH3tFzC5b3eG8QIKrH03QVxQX8O+CVeBruz
	 GPR/4+zAptolRFRK26yGiTR4P1TJQDKRl4dbiKKqViLI77IooWg8QwElHON6PgFiH
	 mEDXa+puRUh+Lowyyx1RLmjHbhuZhocrVv56Pg2R71uXhVBzD/q6pdonJRoxqravw
	 8RyPY7iU3T2TIBsMUg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.100.20] ([46.142.35.117]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MeCpR-1sQKD23T8x-00bIPq; Wed, 03
 Apr 2024 20:48:15 +0200
Message-ID: <eeeb94f2-1e66-4e54-9d52-65e6b172a4eb@gmx.de>
Date: Wed, 3 Apr 2024 20:48:15 +0200
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
Subject: Re: [PATCH 6.8 00/11] 6.8.4-rc1 review
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:wQ+TM6hJBmyF2nhSyRjOuO4NUb/6LlsIbWNIF4PUxq/LJFEwrTq
 G06+lE1SBD2ydiXC9iUU3Wt3dWrcTPtKdhbRygPbibDdB/+filWUrv3LTn09EulcLG/+FMp
 ChACAaGhK1hfhL83rc12Rfr0o1y/W10qXZ/xVVFOnGfyt4xKnxzoMW6ob/Fipl2aCKnr5sb
 1wXzgnZ5nTdYIltfWFKtw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:zQy/BHzC0cQ=;S0bG7JcL3HL2JsOjVt7fKsWUd+/
 F5fwfWoFuDjngetGFJviuQTRRDX8UMjBZtkC54mEf1HNZX/wBJth3w74tN6S4D8/AxO+w6h7Q
 0272IO5vq6OAi2XxG/+sRnOQKJ3NVq4Dml2SQcyvHNqj29WPNYHZvgmmB4ANEPLJvUmF0SgFY
 HERNUY1oDVmcsjo1thKWU8ABjJWSV6B3o2lf6BzuLUKPR3OuORut0J/BfnDX82XDpBb0XROmp
 015B/U9CwjrQsPTxpko9mDVPA576ozUHux69Ivi8NtozFr2PcrAv8U1DxwuZ5PQFFaQAW/O5D
 EX7xixl4yDUBEU/MRYJ2HmcwVnYjcv/KL90Y6LP0K7JMqNaDAAv0dO1VU3gjzTwnbJkV6PLrB
 tS+jpIxa4FJH5xRySJUSUoVyaWxfPyqaokGwbBxKfKlOT60ZFrevwNyf/BhurSw+RTTdGkdGJ
 D3t9bcASvB6nzoGnL159MYGr0jEEKK5MPGwcl8OFaTg0UiwJe0FiMKxrTBir1Fo0ug+1Ezocd
 GveV7X89ULON/Ik6wPTxcZefFPGlo9NytlknT1lNM5YSLU3wLLY4IcwfMbag8BKLzWQZRJ4Su
 1rqqrlMtn+QMg7qrvozNNcMPl9aYhf8Oj1SUHkwWMhg5yAAgTIXLYSk0aNTIbW6mSjAo5rRuf
 VUaNFzInGOYXikjgxhWMyvjWfCU+Zpncy1FQB/Qm7fyPmt9TDEr2VY7rB/T7yHMHIIT+pIbJa
 CxpOKCga1+TWz5Lm0b4q4kHnCONRiE/vslowWO0EBiN/Nmqnf1uodQ3yzpjAfYkr+CPa38vmw
 WLCVhTH6CtW2UINODpjUOw23v18xiA9fLZ10NSc2pKhts=

Hi Greg

*no* regressions here on x86_64 (RKL, Intel 11th Gen. CPU)

Thanks

Tested-by: Ronald Warsow <rwarsow@gmx.de>


