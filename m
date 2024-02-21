Return-Path: <linux-kernel+bounces-74800-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FA9B85DA96
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 14:33:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 59744285616
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 13:33:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5A667B3EA;
	Wed, 21 Feb 2024 13:29:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=rwarsow@gmx.de header.b="T4F4HLg0"
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64AF67A708;
	Wed, 21 Feb 2024 13:29:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708522196; cv=none; b=JlnDh9QK+MUbnm9/5Bk18yHkbj6N6HcUKZqQY6/7m9AmbVDURPtKIrgcuNL1QaRFCrGzKaX83f51kswM7orVPhEg1+a468QfcV3BfDBYNmxKMmbCLeo8ato4wVl7v4D2m0pzktjUTcF30nyCgD4vn69QKUPCR43mgbZ3HXbuJG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708522196; c=relaxed/simple;
	bh=dmMdDLN3YgL1qMEqV22WwccWKGPvTDnUyQtKaq9KA84=;
	h=Message-ID:Date:MIME-Version:From:To:Cc:Subject:Content-Type; b=TBgqPmKiStVdahxzIagWF3TwYRK+I/T780LcUlYUFk1SfPlZKHG118pKt4y99iPwBVAZcvcH1/XDZKK2uCvm7cQEBJsHkDrV4BlMNO/lLd0xQWcBpa5PeSz4SZIKYFljhH6h5x8iSNcjljzQJDmxkyDLoqTFFF2Pke4HfiK6HEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=rwarsow@gmx.de header.b=T4F4HLg0; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
	t=1708522190; x=1709126990; i=rwarsow@gmx.de;
	bh=dmMdDLN3YgL1qMEqV22WwccWKGPvTDnUyQtKaq9KA84=;
	h=X-UI-Sender-Class:Date:From:To:Cc:Subject;
	b=T4F4HLg0nPw/2zBMLoqeSXa2aAQp6dlZEuJRLhc1JijIVSrHzejasJYjz1/J2g2h
	 8vyajs8yvsymbIGhB7o/AsOWIKesRkcVSy6w7qs2dU0qPdSDSST+ASYnq4D0QYSbT
	 HK44YNCn0b49lRCC/s91AFy1kcBTeJR4ochNIdGlvYlHGEnAEvIi5N8d26VGG3fue
	 QMF9oCzWNid54KxBUIYF6FRIReL6SgLz0RtFNrKu1doHzkyczfERvBMbnjqtzTJbC
	 1Tecka9Z734cElLBeGh116tMEYeGFCRmPg3NaAvlVJWBWYdCIqPw6F71dHqp+WNcf
	 gxA8x6gKKzn6EW15hA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.100.20] ([46.142.35.10]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1M9Wuq-1rXGtW2qxA-005ZsS; Wed, 21
 Feb 2024 14:29:50 +0100
Message-ID: <ed9e1bca-d07b-42fa-9ceb-d0eef3976168@gmx.de>
Date: Wed, 21 Feb 2024 14:29:50 +0100
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
Subject: Re: [PATCH 6.7 000/313] 6.7.6-rc2 review
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:ayLDWO6wf4+dBELFk/xktZHN4tAjCUArOfsCZahHSpyLq0UxX0x
 JkJmhHmx0b9SBvKDcegJNVjwb/5YgKQr+hZlB+uF90dZ30Fbq610gTtCtlPrMVpuIpshAkN
 Z/dqOoovyjReueX0JSjboMb/YEGgTbBYAEWAl17mn/Qy2j/wdekLOwVyTJb7G5Tq+N8Noqz
 Rtk4LT4HFhU9Y2bhGNMUQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:JvHcfjh6AdM=;VeZxAMuq6mF+WZz78amNjlygTOR
 +RlhiN+HVL6Gczg4k8suIuoFLiP2RVMMCgnc4Kvt3HfeaLtngvmUQgBhMY50g4ajoR5sQ5AZX
 PNAmI7q0s5z4NkrGYEJ7RpC6zzBa6cw0QYJqi2Bk8E0ejf0vEwAE/eX5296RplRDgL7AhRqrI
 wMhyisX35Ni57RvUL6FIVyqmHTJfHOxqbA9TOwtSzjdLPPSlxDwA0h6CIdQ9jDe1QIX/YP1kd
 WHG0H3gOHAcYVLe7WuKAhOXRalSFCbWQOaGxzNNAE5RHgly2vhvzd5pxvFlItoOatGbue/4Tl
 lDC9LYA5aYlBxyQBx242uojjcHf0FwiCFtlyGjG0QvK6cjYRVYqwErVB6cst3HlBeGXgnK2lF
 4oLiemTAviMFQyFMXIXyIpT+iGP6X+SpfOdOV2gxRIc2Bu/SJehQzh50iyymzOwwbKZ7o3pLP
 OOdeDJhu2GQ0WOTXx+VwjkYFdzBzIxzP+LgND4HdZYeuavbhz/uJZPgs8qtmWvvYI38Sz6dqK
 IfoM4Y/Olr8PDLXKecSzfYXm8N65uzk/Jly6qqr926LDuoicpigqeqmpWS0RH94x2ppsAjOYV
 JUUQvKeBIfkOYezCN8OUbenTE9bZ6elnXlqM793XSrORoaX2IRnGkq+uOltkLGL7A5CgpdB2l
 +y/Z+F79BBk8UIh5z8DhhvFcI56V+Ac/vqzkSHiw6RRGuBDSLQR2IACOxcad0Msp8auhuAdum
 KGQsLFB30nhrXYvNYFRfn2R+PD9SBw+AN/axTs+6TtZ6qPAOBeLkDcBWqH7aAUMstu+W9U8OK
 RoAWC2ADAM9xCzHIOn1QvYgOR/s63EnPuTT81vdjjk96M=

Hi Greg

*no* regressions here on x86_64 (RKL, Intel 11th Gen. CPU)

Thanks

Tested-by: Ronald Warsow <rwarsow@gmx.de>


