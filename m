Return-Path: <linux-kernel+bounces-135587-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 551D989C804
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 17:18:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E99571F24509
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 15:18:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FEAB13F45F;
	Mon,  8 Apr 2024 15:18:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=rwarsow@gmx.de header.b="IhX291S7"
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 355A313F44E;
	Mon,  8 Apr 2024 15:18:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712589494; cv=none; b=DIABQg3ni+xtn0HIvBf+7eXEFNKzxcIM0bQHYm5+2ncDAIiwl4LEF2zpAQJe6AVRpa0l9hjWRU4g3B4/CM8O29/gMnBYZm/2g85Jm6Qs4OeMjZvNAUKiSNACHq7zMaPFF+tLAhFbLUrPSgpPV1ikCmawi1M0NyeGRlk+BEZBIkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712589494; c=relaxed/simple;
	bh=dmMdDLN3YgL1qMEqV22WwccWKGPvTDnUyQtKaq9KA84=;
	h=Message-ID:Date:MIME-Version:From:To:Cc:Subject:Content-Type; b=nGsfrjJxbwOke0WHc+38FvKKK+OtL7S4bXEPNh4HCKwUzWAXrTB03TbnRUi3WS/3J5tp0x8tQhLMnyRArf0tLmThjZJtnGuZNy/lNy1zUp2colD/eOkFu252wU6KEVfqAkFRLyJTNShuGEsblDFayzjxt/Lx16TGMvZ/FC2gYYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=rwarsow@gmx.de header.b=IhX291S7; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1712589489; x=1713194289; i=rwarsow@gmx.de;
	bh=dmMdDLN3YgL1qMEqV22WwccWKGPvTDnUyQtKaq9KA84=;
	h=X-UI-Sender-Class:Date:From:To:Cc:Subject;
	b=IhX291S7lluxMBwADQ/JU54g0ZsokY32Kf9kDPmNuC/NdbFbkubo8Pbn88ZC1pvr
	 0SJndP3U6Lo9oui8D9b6EbplTa3SLb3JFrLijSCQJRh5qopkmXqqIG9APU/EONtxK
	 3BrDvWKtZk39CndhmcBvrYcLGTZxMF3Vgpse/ns8ekzNavSTKk/XlqolTGwlw03JZ
	 9dhl51auzqSYXij4ASYHyLM47OVFyidpvVDb/ICHT1Bqq3oKAiaM+GFAZ/223aJUg
	 Ltq4uGgdfgLcQFy3rEBSrZo9xkmXvDiB7+tFhTA0ZaA5IQuH9Rp6NGxDSoidHYt8r
	 rEwSAw99ECOqYEu/4g==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.100.20] ([87.122.66.77]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1Mz9Yv-1shIHK1zBz-00wBJz; Mon, 08
 Apr 2024 17:18:09 +0200
Message-ID: <fbc9fbef-5ab9-436c-a52e-c8de3948e364@gmx.de>
Date: Mon, 8 Apr 2024 17:18:09 +0200
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
Subject: Re: [PATCH 6.8 000/273] 6.8.5-rc1 review
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:8y7W4j/LFXy0ER6gdmDeZFNO0WKY1pmWPbfoD6B37TcDpjpk7iZ
 zZKG6zDcXDlSYcX1GImbHlJYo2LSJEGpshiN1wLBpBjLfkpC6Li3mjGfJIPenk7mgsQALwL
 2o560llNAaxUEUziVyXheQtdxOZpW+tzgfeMqJVcFHwBfjq/PONsLibeY/e29ifkkK+S/eb
 +D4GdVcGBC01Inlqj9iPw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:WwSEaqeBBik=;XsXGWh+06gqUIirR6ebvrhpmcBt
 wbqC0ayuQ3fOlSgWLmy2k9uieqmpUwEeYr20AUC6tAmF+2JULATZ61pjCMhxupEw4OtvOjv6m
 BHQ2RrEV5bkV9M0BAthWBnw3dSjAIK5xSeejtckoH5H5+I6RYm7FrDuwdOUqR2Jc4ZmVrzzTP
 dtZlEnHOQcpGfmC0ynlIT7bgtfwFW5pflbdvZhW4e9vd+btz1HMe9Vx6iAQtSQcaV3F/GtnSd
 Fa6h9BcjavktF4/gEQHwD5FUrzpM2YyX8qkThzdjJVzX4siPfoa+j9h8wirY75XpEBLsi2elB
 EgXt3yTmmWlLa1WMnBsXZDegftBm918jO8BehQifUyUinl/ssetTnvq39yqaYCUVDNiZLF9FJ
 MSMEZpNIAMXlpJEsdkD7ct1aPyQcJqX4BlUMoBfY0K6nHNmNIxFCmGW285uVfl+MqvAqY0r2k
 gZrzUqvcF/bZXKiW3dgUPMhj60G1njagY+V+Qa3c4DG84tHsjqh1v9got1rVLxSdwKH7GyMXL
 AdZGE+nkjODPcvfN2YDDGnXW2MMiqWpcoORWl2fdelCnhE87h9C//hg2+c9AkySoyXL1rJd+O
 DoTjSJg/yWOh6CkGI0pIcqhsZtG7/DhCrm54sJT7IElh9P1hmfoomeOgctZL/wqnz8kNgqG4T
 mfpHwGqkZDURPFix3k+n0iRoL8X4E/1GxvIpAmxK8JjnMaditECMb9bg8/P5sn7eE88E682aW
 ARUFmX42/4J4f51SL5kIDZM6Fd1l6lsNOI9ILCA+dbrLYdWe1KHn2kz5LAJYwWq1qCTRGcx9U
 /0HfHfSaptKcoqd/Mi4s39xOqX8kJQwDB6nqALdUFFKtk=

Hi Greg

*no* regressions here on x86_64 (RKL, Intel 11th Gen. CPU)

Thanks

Tested-by: Ronald Warsow <rwarsow@gmx.de>


