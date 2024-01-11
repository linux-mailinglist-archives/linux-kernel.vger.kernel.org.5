Return-Path: <linux-kernel+bounces-23388-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D25FF82AC1B
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 11:35:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 82066286BF6
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 10:35:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66A8614AAB;
	Thu, 11 Jan 2024 10:35:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=public-files.de header.i=frank-w@public-files.de header.b="Li3rwdYO"
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A482D12E7B;
	Thu, 11 Jan 2024 10:35:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=public-files.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=public-files.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=public-files.de;
	s=s31663417; t=1704969310; x=1705574110; i=frank-w@public-files.de;
	bh=gj747UejXEsKCNfBnSiWE2Z/QSUkFJ5UibHghFxO4iE=;
	h=X-UI-Sender-Class:Date:From:To:CC:Subject:Reply-to:In-Reply-To:
	 References;
	b=Li3rwdYO2pCvYoOc3MgilYPlzjOgGRw1SLQ1Bs5kD5lB6CVY8vXZVXOI1VQtolft
	 J255mxVlPh4vON7a2kJ8Yax33TJGGCPRiwap05CuK/dqOQIjHKP0yRUWH6d+qk6FF
	 vU6gXqQf5SDo8fDXOWGVcG0/YnSq/YyDRvDMlE7MW54Bbkj1aAkE7uKRYQ+/drawf
	 A2zCVkiqAb1ZdS/l/ejQEUyAalY5PYphW25UWZqB8gnDSGWp+C1a98HpNnzIVKE44
	 gPC7hh7SxMQsw1+jbRmVLPMnAfGQx4VLl2hjeumxOxyPMKLOmuKba2DrJrwTbz9b9
	 +PjFx5hg2+cJKkUtjQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [127.0.0.1] ([217.61.145.175]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1Mxm3Q-1qxqUd4Av8-00zGJf; Thu, 11
 Jan 2024 11:35:10 +0100
Date: Thu, 11 Jan 2024 11:35:02 +0100
From: Frank Wunderlich <frank-w@public-files.de>
To: Vladimir Oltean <olteanv@gmail.com>,
 =?UTF-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>
CC: Dan Carpenter <dan.carpenter@linaro.org>, Simon Horman <horms@kernel.org>,
 Daniel Golle <daniel@makrotopia.org>, Landen Chao <Landen.Chao@mediatek.com>,
 DENG Qingfang <dqfext@gmail.com>, Sean Wang <sean.wang@mediatek.com>,
 Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Russell King <linux@armlinux.org.uk>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org,
 Bartel Eerdekens <bartel.eerdekens@constell8.be>, mithat.guner@xeront.com,
 erkin.bozoglu@xeront.com
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_net-next_07/1?= =?US-ASCII?Q?5=5D_net=3A_dsa=3A_mt7530=3A_do_n?= =?US-ASCII?Q?ot_run_mt7530=5Fsetup=5Fport5=28=29_if_port_5_is_disabled?=
User-Agent: K-9 Mail for Android
Reply-to: frank-w@public-files.de
In-Reply-To: <20240111103146.t5fzr2wlw2tyrkkb@skbuf>
References: <20231207184015.u7uoyfhdxiyuw6hh@skbuf> <9b729dab-aebc-4c0c-a5e1-164845cd0948@suswa.mountain> <20231208184652.k2max4kf7r3fgksg@skbuf> <c3a0fc6a-825c-4de3-b5cf-b454a6d4d3cf@arinc9.com> <48b664fb-edf9-4170-abde-2eb99e04f0e5@suswa.mountain> <2ad136ed-be3a-407f-bf3c-5faf664b927c@arinc9.com> <20240109145740.3vbtkuowiwedz5hx@skbuf> <0a086b5f-b319-4f08-9513-a38c214e1da7@arinc9.com> <20240110182358.ci7pg7ipcbsjxqjf@skbuf> <009fec43-0669-419e-a3a9-ce54c676a324@arinc9.com> <20240111103146.t5fzr2wlw2tyrkkb@skbuf>
Message-ID: <316D9D48-5765-4A94-9937-81AF95AEB16E@public-files.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:POuABXpDzjGaTaQzOShQ67leLrEB5m9D1ckR+umNPv2yLSb1vB3
 8ZhsLXvywDqOvjjX5Nio56FT9mrtER5pfWdA5seDJFnwcpGNzIxZM5K6JfYwHkHwN4kqlmG
 qwrwIK/xv3cwMqAsmACEktlWssQG/943ya3iaKbhiCBWKAJPb/h1kZAyGn+nBoRBueTTyqW
 OtvIVuw8P6b1BtRfEXf2g==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:N7GEtj/ZZtY=;I8B4FXA8RsDsV1nrAfqOpSMQ8+R
 Z5/5wSg6zU2kAhsPtFIPQPStzBMY1tl4qUXBedRPh3RVFRH7frYafUoMEmPKWLrZh2CIFM21T
 twI2W0Iie1cj8PC7XPP8KtrCbAXJtkz/cfCmyBo6lm3yEI6WjBq/LiBlmOif7S3BbOKuAk/pY
 u+WBF3VR55x2AhfU/75BUujCLBYWWhPpEih9OoNsoMRw8Y2YJEpFdEG8UPjcFzPVOK9NeaZ3W
 RXGUr3bFGgnFc/K5OYV2gD+hXcaRGskn3qTzFGraVjJyVKs+sD1QYIPJTLiAX5x+9xGjCj8zH
 ACPGj4KO/UlIqMOgJdw2ophkUKkDEMiSRP/2iLqfSpWay6lxwE9TZnQdNhmw0k/LCXwKVC56p
 uP/k+gwoTPtMnjTZkVT3BD7nyZCyD08VwEzip+ikc6meo8fDhLhg0Kb0XEUCdD/9UcOg5EzlZ
 uJ4Da1S1TUCKr5smYzFAvCChLB9GOE2xPUPT+V7f3XIMmXd3Ee8b8GQIf14zEgNFrnt4HWkZ4
 8nzg3NY9Y5qf3gb0T2uqD3F7GX4yVQrAvgIYWArv1ZPx2zhv/wcFRKaaLVh8U3grjcfsPD137
 OfjN4ZyBSbZEGiqJCaP6fAZYplcptGaUV06FTHR96Es0xFSnuiymwkzSBXUI0+wHubftLdak0
 2HXwYOZMQ51zyDKOnwZlQuP2GWYcGN0X7dFXozxviQfUvGbsdxoLIV4dgwS/jyvLp48lSD7/B
 EXeRWLi95nAGn8hA1lKl74htnkCiqrYrzcueEeZzt4MES4L5J1Qiok5urQWhFFwyvB9aGLMFH
 eVdVOwhIZ77cK8b+lyP84mYR57xQa4M+Ze6GcGuA8lN2C5aj4w+WvADIiMcscS/WpLxe7prY0
 dl8isd9WcSX0QRAkILJCf3kBrxYBVmeD5LWyk+kT9W4S8BCNb6NqfwjHrqOb6unJFnv8Jmj/U
 ocAHew==

Am 11=2E Januar 2024 11:31:46 MEZ schrieb Vladimir Oltean <olteanv@gmail=2E=
com>:
>On Thu, Jan 11, 2024 at 01:22:12PM +0300, Ar=C4=B1n=C3=A7 =C3=9CNAL wrote=
:
>> > BTW, besides OpenWrt, what other software is deployed on these SoCs
>> > typically?
>>=20
>> Other than OpenWrt which is widely used for these SoCs for its ease of
>> flashing and upgrading, compatibility with legacy U-boot versions that
>> usually come with any vendor making a product out of these SoCs, I can =
only
>> talk about what I deploy to run Linux=2E I use mainline U-Boot along wi=
th the
>> device trees from the Linux repository to boot mainline Linux kernels w=
ith
>> Buildroot as the filesystem=2E
>>=20
>> Ar=C4=B1n=C3=A7
>
>I meant what other software (operating system) _instead_ of OpenWRT=2E
>I'm trying to figure out what other users of PHY muxing there might be=2E

Hi

I (and possibly others) use debian/ubuntu and there are also archlinux ima=
ges for the bpi router boards=2E


regards Frank

