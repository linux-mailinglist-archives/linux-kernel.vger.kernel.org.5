Return-Path: <linux-kernel+bounces-44429-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AF4098421F4
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 11:51:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 696EC2964C7
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 10:51:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B41C2664D9;
	Tue, 30 Jan 2024 10:50:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="Gtd7Q019"
Received: from mout.web.de (mout.web.de [212.227.15.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB969657BC;
	Tue, 30 Jan 2024 10:50:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706611823; cv=none; b=LDOzQSChaO+hLjFRxLibABHmtRKqiT5qtmLtcEXAoThu3ggO1Ls+8FZmQ5u3O5io1vGKMuCmXdbukdxYJasAxnQ6ZyyBCKD7Rju1wwB094lhbkNX4SP1fCVte8tM9CbBfabD4wwLCXRRXVz1uVD1wcBPuobuOhS/vl4Maw2GWzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706611823; c=relaxed/simple;
	bh=ak+VEmhPjrrv3eoPoWuXgfFeFRuBlQCGLMapi9FoAXo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OvO9mOVjSL5f1jN6nsKP23MrFe9i7R86IlAEl9nvxYf8/pe2PTb9A3mpvxu/uiuMwokrkYFoefNvlzGW1B/EvHTMN8BwWZyRxHXB3Gtb9Rl+H4/up2Hmrzru0PY0+UvkYKtSdmF69KeW8+r5QbAs5RCS4YekXpQcEQVxgVAwg5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=Gtd7Q019; arc=none smtp.client-ip=212.227.15.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1706611772; x=1707216572; i=markus.elfring@web.de;
	bh=ak+VEmhPjrrv3eoPoWuXgfFeFRuBlQCGLMapi9FoAXo=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
	 In-Reply-To;
	b=Gtd7Q019bwtpKAt4oJqIODulE3pzRxHXZCbFV/YNNIn979A3j04JjjkbW+2I+W2K
	 OoItXwHLACd+yG9fPyCSPWgALUNFSdIZplFrQD/12xz3qrV9sz2BehRNbZujnbxY7
	 j0dJmFvjWh6sVhaSX2JZk0vcyI7im0plAwmDfD48CYLHNWkzTt1JGGbMegCmckZRY
	 S1mp9Pe2qDqkuaV/BM1EBS3863pbWES36h340SBuE00gAStMl3IU4jrIGkx1q4XQ0
	 2VFr2bEK5LUHf8Vx1aTancffJSVvOYyW5TOMmnZTYBxftc79Br8U27yKw6/tYq7+V
	 AQIsC7esd3vjQX+xyw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.81.95]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1Mvbik-1rEbyU2W1O-00sveS; Tue, 30
 Jan 2024 11:49:32 +0100
Message-ID: <49183574-ea83-4517-8e34-5d6e87ede064@web.de>
Date: Tue, 30 Jan 2024 11:48:31 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: fpga: dfl: fme: Return directly after a failed devm_kasprintf()
 call in fme_perf_pmu_register()
To: Xu Yilun <yilun.xu@linux.intel.com>, linux-fpga@vger.kernel.org,
 kernel-janitors@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Luwei Kang <luwei.kang@intel.com>, Moritz Fischer <mdf@kernel.org>,
 Tom Rix <trix@redhat.com>, Wu Hao <hao.wu@intel.com>,
 Xu Yilun <yilun.xu@intel.com>, LKML <linux-kernel@vger.kernel.org>,
 Kunwu Chan <chentao@kylinos.cn>
References: <d94376b6-12e8-45bb-a9be-4887bb316d35@web.de>
 <ZbjJYMlDifIv0WId@yilunxu-OptiPlex-7050>
 <ZbjPDX1y2I9Heanq@yilunxu-OptiPlex-7050>
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <ZbjPDX1y2I9Heanq@yilunxu-OptiPlex-7050>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:7VTb9LLznircDPxFLGcyGvPsGEb+ynPhRgQeOkBmMkBT4hJ0Dkf
 SUTcEQH/5r8NmS4GGMGw+F8BSDJ8AZFEWL4ImF1zTOjuEhLWBm84d84vGAWMaIA0N7lugAl
 sF95PywaopbOLFyFntygqjg1F1I65LQ5zdqTp2Fd6B6XXUeVomR7CKglERdK8ryfIc48J9G
 l7MNYLt15UtN6Otgd2vaw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:diN0LIWrJRI=;0d0L3w3qZ7vY2fg7r8ey+304ViY
 gMwinlg+WZSc4nfK2sn90qgDNLocc+wUxGW2Dx3Y/iRJAIIZSHy80G5Gb6IEjAbMuNqkc33Fp
 McOmQemZuP/D99uUVQ6+Y7PnwXJbI5yxTCN5gdFAG2AkLkAqZnMCAhk7+QZtWRQI6SGnLN3nC
 /24l1NHCyO2KllwuvOtdnCJRt61wDV9kjN64ltbGze7YgS4YiU/OswomXz5t9Z5DrlWwVOu/b
 M1t6IroKQ9G/IKOt1wkbzbubrz0wLwCQBHKFSn1hepn3fxU6qx1m+oKjavUj+zquFKD7DqXGe
 G/KMdX6KgZ2yB/+amtE/qbEpEnRqlHuWDDmjWcp0LQwFWFO5H1RLdFmgO+8LxKFSe0QDxI0h+
 aaaP0YL1TkOOlMo54xuwmM9DAj65pL+ov4PQbJggqzhR1b0VpBsO4fQoevWDLIPJmEvU9PrU5
 /D8l2ATXyC1JK5damWiW75EfHHg/K4XQdFoW5+T/bYMLYOmpR6Sxl4xCsIukyFd/I3WVAIed4
 6eFYTDCrnEnyvyGEs4dyd8+F3emuOZ0IHT9+61y3L/bgsf+lK3sAO/lsiT4d6QJ8fz1+T8rug
 L0Y6NYvedsrVqSCeaiFT66grRjh7Go2eZDZ3MUAW4gsDnocjNQ7ReJJO9k6kAYYs/dtxeye28
 rSPM+uAgsUjlE//Ts1SkyR4rZdL0Guz2OIucRtlWSY0BdADZZwX6Ni/bGGzQtFMAh5R7exS52
 1D821E1rdWdzxeO/7P0WnX9Kr/BEBj2mTIW5r63Kpp42ItGyemT/w4hklpLFZedumPobfSsIP
 SVWXP/ZZ9uYNPe1C1G/ynz6e/FiG6+0WR8VhTk+PSOHxN0+Ma5Q7PL0a6T9m5glHDIku7Vu4u
 mDW/KCpoJPfoy9/OUKDqUT0I6L3SXrGSRAwo4acN0BiXHd46UG+NiuK4Nqw7Jbho0mBWHldkc
 FT36Ww==

>>> Thus return directly after a failed devm_kasprintf() call.
>>>
>>> Fixes: 724142f8c42a7 ("fpga: dfl: fme: add performance reporting suppo=
rt")
>
> One more char of sha.

There are different preferences involved.
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Do=
cumentation/process/submitting-patches.rst?h=3Dv6.8-rc2#n109

Regards,
Markus

