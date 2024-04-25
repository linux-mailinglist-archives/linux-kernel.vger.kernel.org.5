Return-Path: <linux-kernel+bounces-158449-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF29E8B204D
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 13:31:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0CB55B273BA
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 11:31:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A56212AAE4;
	Thu, 25 Apr 2024 11:31:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="JDgv6BOS"
Received: from mout.web.de (mout.web.de [212.227.15.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B40B612A177;
	Thu, 25 Apr 2024 11:31:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714044699; cv=none; b=F/dlZlUbEcWbdcd6sjAFYK2OyzjP7p/qrkYAZfAnINlcB7VpMtTHrK/KhyldfYgZHhwHJyOEEQUz26U5bZ02w0HWytkurZ4NrsI3cFrup4eZZRM6HGIV8dNpxXqq8sIhsDsJVE5vYDh7XDfExLMxaQoGrN4zAdpur4o22hZk4Ng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714044699; c=relaxed/simple;
	bh=Ez2bxHXu5SIbri+3JxnQYlp/HhXRtM9O9+3SjmOrYl8=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=O33qsR8ibg1LI0os2moBUnbHPgVWFPRbXN1sw47IHfr8Yh9R8um6EQAcGeUbXVBB5pWDTgYu/cx8Qd8+zgMEXy0hwqW/RgjtBEVdn6/CP391+/pY95hAgV4WdhaZhHHh9tuA0LoDrdRXcTXbOEgqi4ViFrsisCwzzSnXYVf5SYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=JDgv6BOS; arc=none smtp.client-ip=212.227.15.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1714044671; x=1714649471; i=markus.elfring@web.de;
	bh=Ez2bxHXu5SIbri+3JxnQYlp/HhXRtM9O9+3SjmOrYl8=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=JDgv6BOS+3ptpfg/FGSvGR/jwOZ0ShR0z/Ulf/cX78rpae/JrXHyi8q/qGmGYhuS
	 BWP18nkCLwBOKchkwCEYFlt1qQETat3VpvGnC1QXEnyGC15lZMLK2Nt4m3Bb+vQjV
	 eVq4n4CqAQywhoK3NyPcMgCEWBGQp1UjyOQiz0qpuVyE2chuEoGQEJ9jUGkEgsljP
	 XBSkuQk9zBFk2SieVGMS63owBH303N62ElWcaUm827xRu6w/lU6a413yKwMp3XFTp
	 MTfuktHH1/tM3eTjstdY1oSDYCT6/AsvGQZtYRjKXU+ByHonjrodUY3l547eAwJgl
	 ZlMKrBwm26a2YvYxXw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.85.95]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MtPvm-1spIDR1Tgs-00utGA; Thu, 25
 Apr 2024 13:31:11 +0200
Message-ID: <443fb75b-948b-430f-be33-170e6f592280@web.de>
Date: Thu, 25 Apr 2024 13:31:02 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Yongzhi Liu <hyperlyzcs@gmail.com>,
 GR-QLogic-Storage-Upstream@marvell.com, linux-scsi@vger.kernel.org,
 kernel-janitors@vger.kernel.org,
 James Bottomley <James.Bottomley@HansenPartnership.com>,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 Nilesh Javali <njavali@marvell.com>, Saurav Kashyap <skashyap@marvell.com>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Himanshu Madhani <himanshu.madhani@oracle.com>, huntazhang@tencent.com,
 jitxie@tencent.com
References: <20240425093744.22207-1-hyperlyzcs@gmail.com>
Subject: Re: [PATCH] scsi: qla2xxx: Fix double free of fcport in error
 handling path
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20240425093744.22207-1-hyperlyzcs@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:qgYE2j9FnfcZ5w3AGFM0qf7qU03OwoE/pxhkXiYg3RKajS0rl5K
 Er/6ZWmyWgSnhtwheqS4bpaCVVti+dEhPCKrdBJYq+CJVeFcLGCpfX55k/aTZvC0MN4w9HA
 ZlkAed4Vnf8E6zgeIpUL99xEJm9pN9z2c4wTluiRn+d5TeUyacUTWCu/bymspQA9DF9mVa5
 Au9bHiXP6t8t8UbEcZQBw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:gRl9QCJFNIU=;d8YLuQIeac7D/k7QKBPPGe8MT+R
 pE5GZJ+hXkDYikK+jF5vES6Rva2pvjw8U1lDsnkNN//V/z7fNAOIrLv8SY2659RNMzu8BnBjw
 vCqaZpgMI1Rmvr1qU1C4sRya9mZAHzDDOcCcRIElQ3qdMr10qRJD0/xloF3oiZtOH2N1Krx9f
 7zfgmJrCYpqUGfLbbPvNplIokWKpa409Q4kLEX5lL2EhLP55L/3+YZnWrTxnfktNiGflIVf7K
 88FY0Q0Xr1zaqeuvoEtpXFVmnQFVXv075e+jLAKs4hM5l0WLRINF2mlXFY3tTqbD8UbdjSlp0
 Fz0PeNhI23FGzLwXznEGgxhn5PGu70qyWNZwu1xkcEL9iEsVq06rn9gRiXZRFzS4bH/Ib7JPP
 p3sFKdd5mKgl8I+C0agY6bdWSaR7shVDM5QkiJvlmvABwASnVKmPabC2mPYha1jn1Uc7nQWfv
 2KOMgOG8DVPw6Ldg4ULsSmvqOR9UtdjOyCP6v7UnQklsbCFITaxNbOcWSHrQOEQtZDrks1cnk
 mbi7Xo3461cPhQr1UwWpYPv5d5Ry4TiPXRHDxllD6yGI9nuqIm37ACTclNFlpqNz65jen4KTw
 9x9iO0Ixft8Q7J5CkkSYgynAioedrD++itK4gNw8aCwfv1lIeEUz9ZNV1Un2QtT51QXJcZm0S
 FQDUWDI0e7LBy5lUrpglb/L1KcPl9284hZG51GjqaXJqn9lkiNJyPWAlmWj0z/ZDmLc6tXYAZ
 0tW8RzO9pcQEih4f/Qv77TZchm0wQNMjXw4H+Ygdr2/qOvjHxBd7RQrS+USSIVuZpN87uUPMN
 ugW/tcp9X+ouUI2tyc4AvQcRYH9vCltfNNxlshR4bJEV0=

=E2=80=A6
> Fix this by cleaning up the redundant qla2x00_free_fcport().
=E2=80=A6

I suggest to avoid duplicate error handling code a bit more
also for the implementation of the function =E2=80=9Cqla24xx_els_dcmd_iocb=
=E2=80=9D.
https://elixir.bootlin.com/linux/v6.9-rc5/source/drivers/scsi/qla2xxx/qla_=
iocb.c#L2751

See also:
https://wiki.sei.cmu.edu/confluence/display/c/MEM12-C.+Consider+using+a+go=
to+chain+when+leaving+a+function+on+error+when+using+and+releasing+resourc=
es

Regards,
Markus

