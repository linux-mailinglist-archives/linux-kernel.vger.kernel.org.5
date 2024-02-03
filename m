Return-Path: <linux-kernel+bounces-51106-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BCFDE84868B
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Feb 2024 14:39:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 648C51F237FD
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Feb 2024 13:39:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E89F35CDCC;
	Sat,  3 Feb 2024 13:39:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=rwarsow@gmx.de header.b="YTXSe0IQ"
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 766675DF01;
	Sat,  3 Feb 2024 13:39:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706967587; cv=none; b=liBLKa2kUr+m5ngPU7+fMEftEkPNBoSW0kjTY79uX+ykpro9HEDXaiBn3a8nIELidQUCmIJBPu8GMlPaMg1/sEb1MgaBmVG7WpydJFVtDB4Ux8N3PLMDNJbXAm3XDqre34+mZMWS8O0siijuqz2tyV6Xu1IdJ+F13wRXTbufaCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706967587; c=relaxed/simple;
	bh=JM+qhCQHHHoXmUGLpcSRnertDD/feaRM25mS6GIRcWs=;
	h=Message-ID:Date:MIME-Version:From:To:Cc:Subject:Content-Type; b=X1VeOGl3Y1GiK/v6SRhdamOl/l9TcTKGr3PHR4Z/V8AeoJzta+xXS1GVvGz1QbJ3v2kZBZmggEtVfggQrsI31VY7jgnoCIy6DAolYL4U0s3EV6K2CgnMclFuxy7tfsrqJC5qWrh9RtgSz+XEMc8yNdsBdwiNURFo4KNxJxTPn/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=rwarsow@gmx.de header.b=YTXSe0IQ; arc=none smtp.client-ip=212.227.15.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
	t=1706967582; x=1707572382; i=rwarsow@gmx.de;
	bh=JM+qhCQHHHoXmUGLpcSRnertDD/feaRM25mS6GIRcWs=;
	h=X-UI-Sender-Class:Date:From:To:Cc:Subject;
	b=YTXSe0IQ5fehwM3rcLDp51QpdlKIlOe+RtlDVxKBkSPob+mxr3SQJZdK3epFyT8F
	 nOiXERBPFKL/URKi+qEfBCFMiqfKPfUJ3JcU0+ydqP3Y/Z2Gge7uMfy6bp1jRNNBu
	 7eT4hJsiStwN5xxRK4z/astsP061cUGOYx4bYfcpA64qiPzbtfsHjM15aim5he76P
	 FRGVmqT2EbakMjVrgowKyRX4wqrXCGrK2y837hJlyaWtY7GLZJ9yOmh7ksurpKU2g
	 LxHkpT235ZhWZEvjLIUwZxvyN5J5dhF1/CfneluaL5UAin9YusEi6sWOMRo3PopOI
	 D+8JxwfM0rBCBvTuwg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.100.20] ([46.142.35.89]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1My32L-1r6mna41CJ-00zWng; Sat, 03
 Feb 2024 14:39:42 +0100
Message-ID: <295b099e-3b60-416f-a28c-6d58bb5564bb@gmx.de>
Date: Sat, 3 Feb 2024 14:39:41 +0100
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
Subject: Re: [PATCH 6.7 000/353] 6.7.4-rc1 review
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:rmtUvSKC406CC1RhZUVFRG9TFlHDwO5d981bPHk4/0QLr7AYA02
 DxdGIbqlxSaGAG+cFOewY48JTq81nAUCVZ0Or06rYL6cNV/w4WZIEXjolQ20NUUf41UZBZa
 REAh4tevdwgQVBj2CbRkH46bIO4TXJb2n9m4JLla0o4jvrBE3bh8ErUf1z51A17KsVjVsel
 we2hYpbA0Ctn2jc4M1qWg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:fBkzQlnevZc=;v9V4EGAncxKlQ48daLaaLyOkK7W
 TT7BzVxknHn1spSA5uweu7gClpgjgRtffVMxZoTWggmbrFLzr4kWRVqES/K9aCGSJe0L37gM5
 iGKy0ykeNYAeKNzSN1QHeiPSxYc/8TaS1P+MBCerQ+alHXzB3m809U9x22TZt8sWj+M41+wON
 KzW3Nov56QpbwOxyZTh93SSocUvm1kFRDaEQ3SN7yI9kiDE4y5NLIB7wybpyqhde94/pp+NQt
 nvY1cGziU0FJAwvjOmGSDsL7cbefUnRXqRrxWZ63AKY9kQrfqraNdGVXi68FC6lSQJaPH7roK
 LrlDlm98+LjASyqxd0XpwjGcjq/Cz6tldBjcrCdEb5gs90+n1xhDP5pvJCw/T1XW/du9mQksT
 c13wWGsRlh2A28JESaFrFzkHnU1RvJ58KUbb1Bigmc1eOgyJS1ucugugaGGja9Sl+KeZrEASw
 tsj87JS8ptQfVAaObn05+H1mrHVQ4z1orgyatptT3mLyeXQlWlEsRRJXWmS43lu4jfn8CetiW
 A+ILKmSz9rvBfjuRoHN1k+diufRPe1DiAd8LGAa2n5erhOCCU+zclo26V8sioCC1Pjhv6Do+6
 a9OMv8Y22hJrnmmmnduUyngobqxAqNHk2kyMfWCq38lKmVCo3MlxHPk1Y9RYTdf1h9Fykm4xk
 2W30FJve1gomjQhkhQH6OpcROV6VuQ0q174eEpr9a3TR6R10SlNQ9bXD6k41N67FK8hg7AGm2
 A4Ih/kzjUyoq9KiUmh6f4hpwYJBMqvvQYAskdjdaitysB0OJ5vap/J6VLj5n3lIK8H/3lNzpp
 l95AXyNnBe1ng4+daLB2y7qBk0KD1XiEaRzWuEwoWnehQ=

Hi Greg

Kernel does *NOT* boot here on x86_64 (Intel Rocket Lake: i5-11400) and
Fedora 39

just after grub the box is dead; not pingable, etc ...


Thanks

Tested-by: Ronald Warsow <rwarsow@gmx.de>


