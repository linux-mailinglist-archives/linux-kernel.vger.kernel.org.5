Return-Path: <linux-kernel+bounces-22293-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 469A5829BED
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 15:00:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EB1E4287004
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 14:00:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EBEF495E1;
	Wed, 10 Jan 2024 14:00:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="pMvWtcyG"
Received: from mout.web.de (mout.web.de [212.227.15.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 275C441774;
	Wed, 10 Jan 2024 14:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1704895214; x=1705500014; i=markus.elfring@web.de;
	bh=Jwx6RUu0T4aaPWwRQRpFEsh34I/+eQWkne2OrHPvH8A=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
	 In-Reply-To;
	b=pMvWtcyGLZRQyDLBKtYNUuolMrAqMV0MsgAlNo+N8eVNIyXwHkfn2SaCJ4Wp7Q+E
	 Hr7kUmchb3DgUxkcMRAACrnRb5m4Y3ZHlqYqW2tjmbP2h6zDKHt8M0SdsRhpCKDZn
	 UNoOGqK//xgzaZPl/mhGuJXOSt4GqKbc/hrYm6Mxf+f98nddrL81DlwYWNxUnF982
	 vWvMZIKvWz78xytHWSw0salqkGN5KYNYmILcv/rQ+acL+pVrqmKsIAjuY96HwBq3L
	 B2a/03hL0atFaH2gEymD4lo4HLmqfzy+UTDqArod/HHAF2nNyWGR6SRNexSt95J6X
	 uyxgqhzeXVQAUEkrhA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.86.95]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MSZMD-1rm5BM48pF-00SiOD; Wed, 10
 Jan 2024 15:00:14 +0100
Message-ID: <89406360-b6ee-455c-a575-031b87cf41ae@web.de>
Date: Wed, 10 Jan 2024 15:00:11 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [0/2] ARM: Adjustments for init_atags_procfs()
Content-Language: en-GB
To: Russell King <linux@armlinux.org.uk>,
 linux-arm-kernel@lists.infradead.org, kernel-janitors@vger.kernel.org
Cc: LKML <linux-kernel@vger.kernel.org>, cocci@inria.fr
References: <6cbcf640-55e5-2f11-4a09-716fe681c0d2@web.de>
 <562a6f99-3f8e-9a77-e519-b668e24dced2@web.de>
 <b3c42397-c879-4381-aa96-c7887e81c068@web.de>
 <7dd19987-6590-4756-a929-1ff01503ad1c@web.de>
 <ZZ6MZl14bcIaCaQn@shell.armlinux.org.uk>
 <1c38e495-5c9c-4ff8-b453-93b882dd2c4c@web.de>
 <ZZ6R6KSQo9ph3ARZ@shell.armlinux.org.uk>
 <09c4cb2e-967b-4d0e-b5c6-f959e80290d9@web.de>
 <ZZ6gq5sOFf33GhM7@shell.armlinux.org.uk>
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <ZZ6gq5sOFf33GhM7@shell.armlinux.org.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:2I0WKPnqw99G/fiSpEwxcqFTU+W9/ORe+BYTH/Q764foAz/ZINn
 oBtBSGopdJnv1BH5wUHRTiNU3k4od0zS4xYO5SV67fOV0dNfVkyACGIBwqAyOFKV/EQCDsY
 XUQyKIvPBswczhMFNQQ1vDeYU7lybo05TJ3OAGyRGRDvb9eSqwnK7kDlgjqdOBssNQmXY16
 mPpMhn13UuZ6KgvSaqWjw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:CVYO9yQsxSg=;8xUQMGmY8Aqw6326Or0c0/bHD7A
 gCBeLl+VSwEKp9s6Ug77VuURafOpZVQr+X6yfdQCHwf0GlIcv0zju0BdwB5QbbavYi38XO2F3
 YU7WHCEFnYDReauxAl/Fci0OxoICtyCWC7OCNZDsz7ObRw/EXGcH6vMIguQfanI+ASKiaKlfQ
 GNx31eo2dcdlSdoDF5FUm2b1IWOGjUky+9uRWeVv/MU38xfsqVhBfrWr3kehMwmeeQ9K2F9Fg
 5RFiBinMzF0+FcxzBNhji6QbK//hMo4OzqFE1+eeR3HIDVdc/g2OQWlowK/5DCHe1imIRvhQ3
 V/kvf3ZgF9yDKIM7ID2Mg7mA2OjN1aoAZZj6GLxcA81A7pZK0A1r789g6NJKlaUNjdGcSeIMT
 zJs2sYFNN3mDKVUU+Xyw9Glg+CfJTF5uUCnH2xr71zfpxrXO2VpC3YDQlDFtjPJ4j5GE1Kot6
 Ubh+7ZOW3ZIuiJrL6q5veZzrnS36+u8/txU6SDD4iMzekBXdEdzCxaqd04Szq6z8b2rWk3VNy
 eQoQgEzw9m+31ZCj+gPrZvpqNuMIoTnYfRw6R8TApbEMSSAcf7brdBzIOZVzbB4tCJg7lnu1A
 cKYGocyCNMZSd8UKCqpCJ9r0WBzGWNROU6YD3jjM1xvIANZHSQH0mWcosCaGDD6QoDBxivaKN
 RDNKuT2vf7XnO94j46NSsOiI304Pi8ND+rjIeipltTtmqS0vt0ZHlioZov32bkxMNegJqOL9B
 nm8aZXKBh5MI+u+o0zJlc8OqpVlZsGp+izAlgzTnTHFxjrMVAG+HHWYWNjpu7QTFAI6aAA+XG
 AE5B3UrawuPEUaR5gXLg/pAT75jqNz6/hOyGbwMoi1wXgFF54Nv3PwqEwiI6ZEhxIdDx4IK59
 PnznidfxCeYdfBwAle4QhqkbdoRenXL2ShJbHl7lnPxlVlHobXP13M7T+89E+Wk0dIEjJxYxb
 rKIN+A==

>> Are you going to pick any patches up from linked information sources?
>
> No. Did you read my first reply which told you how patches get applied
> to arch/arm? If you didn't, your patch won't get applied.

Do you request a resend of affected patches here?

Regards,
Markus

