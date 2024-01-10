Return-Path: <linux-kernel+bounces-22138-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 46D8B8299D9
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 12:54:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C1D92B27AA7
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 11:54:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7E20481DA;
	Wed, 10 Jan 2024 11:52:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="iY327sZQ"
Received: from mout.web.de (mout.web.de [212.227.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D59A247A57;
	Wed, 10 Jan 2024 11:52:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1704887531; x=1705492331; i=markus.elfring@web.de;
	bh=Fx2PvW1vnbtKBJHl0DGshYhQo+DOVDzf3oIV2q8o+Us=;
	h=X-UI-Sender-Class:Date:Subject:From:To:Cc:References:
	 In-Reply-To;
	b=iY327sZQGe5qfkwc/wAg5TLNCJODecJQWoqVMWlHS+jHUVxj40EZeG6yJrbw18jp
	 oLdzXWf7xtREx6O3Heur+sbLV3UR+Rd1vYuRElckzGOQJci8uJGTU10s9rGr8Qe5o
	 btSLPc6B8miFN7eN6wvvkS/xXGA/pEEyvopP9pV7tjXY0RIF4aHCT776uiJYYARaF
	 CKnRkLdBMz8kHV/ra9ZpEZcXXoola790E3YWAXEqSk7zHaUzda2qqO+fy24wwK3tO
	 bDhxALLyFSQYndThjMBl14IO0NhrXPafjmClY6KL19RgaYirJYTNzFjoDEH8Z5HCb
	 HaWVgz9yjXrdyKQERg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.86.95]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MElV3-1rPWOO2Y39-00GN4U; Wed, 10
 Jan 2024 12:52:11 +0100
Message-ID: <7dd19987-6590-4756-a929-1ff01503ad1c@web.de>
Date: Wed, 10 Jan 2024 12:52:10 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [0/2] ARM: Adjustments for init_atags_procfs()
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
To: kernel-janitors@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 Russell King <linux@armlinux.org.uk>
Cc: cocci@inria.fr, LKML <linux-kernel@vger.kernel.org>
References: <6cbcf640-55e5-2f11-4a09-716fe681c0d2@web.de>
 <562a6f99-3f8e-9a77-e519-b668e24dced2@web.de>
 <b3c42397-c879-4381-aa96-c7887e81c068@web.de>
In-Reply-To: <b3c42397-c879-4381-aa96-c7887e81c068@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:78MVXJYGeOng5Nrg3pXzSH+pVQlPJscZCzkpuAXP/MvbNNfr0oY
 hmvsMBZKJ0iy/FbSLADC1sBQEH8yjRPkcUZwXzLAz3Q5pKyWNPmHyf9wCzi+mtVmWICpr6Q
 TtJprGgbtOvAJ+yfZK7Im0NhDcxv5xLvskGTUxpY/Az4bVgqI007/YmuMvXMtc0DT3xTPW8
 L3rOLFTzEXPgpwbnObH0g==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:euQvSKxPaY4=;HxgieC7LrfEjUWt50KQoSpmEHI3
 bMmCqQHlYuxsGQUhwIWUcM2PuatrGd/zt1NU670VgRtoIsI/2l8xlRX8oo5+2W07e5yHVZS6c
 grTIxjmffp3W2UGa9mR+Dt08w1SN6DVtAlvzWy3BxdPbSCnKaMsqwV3YkzfbUFMtP2pJTfcFt
 e/vtfxORqS9gVGAnJRXTohuOUvM3YxSnZ94wTgpRpBlu4R1Uatq+UPB533uIf11LXZr3ufQxv
 gSm+WZSi0GJRg9WcCCaqD6LzxXbUFX/jWuDGya3tbDw7OD81DKpAJPEdTy3uVoXFa/H4uwr20
 tUUn64IgGcGzT0oQa1qYQXlnthpdQQgnESmOGPg7S2kiPNnapTZOAbq9RFZ/A52OqQWPfW8vE
 Ph9KIjVUYwjGKPFDYR4nm+lGYEKBSF5I7a+c3rcNxmkrQ9h0G2Cd8vyiA+wpHAhGG3/+AwNMM
 dhtIhZ5JA0SxXQeCKWcryE/qVifHVCbIBeEIBElc4EjBpetwWG3miahd24cGPB8RZfasVwOdi
 nevnNiM/IjyjD+Kp5U4M0JlPGCOlqeYprLqiJ8P6fcir47ocY8jBRbn7cD9PQKcwNhgnCMWqI
 iRHYCJzipnt0tQRDBNmasAHLftZPBNxV7sdljfanfpcegs+Qc/k+VYmisMQmgXJ3ZsmLgUJQ8
 3yi1DFf0nRWQGhqzIjZdw5L5OFiSQZMTBExdnRKP+O6xEwEKsJYaZJXlIifejLBWUw8hXMMLo
 sYtjRCBVfKxtIETQG7vR8TK8d1Hrkv7gXErQ9PyJkor1T8P8pSiIp6xTYB68A7kETj3TgimVM
 lT3r5Zrmeu066nIE3qDqSx4le/ZmiSevUiP5lM3NrzrJy92iEQNmWNiIYp2wyuLBe3LLqnpyV
 cwBbeIJ7QWpVuKZEb2dTH0uKRMuTbSJT+6FMf0PXqJlvGwUW8bnhTXJzDVACmk4ryj3ao+c/M
 6vY0iRWMKJOOUKAkN8ru9J2XTso=

> Is this patch series still in review queues?

See also:
https://lore.kernel.org/cocci/562a6f99-3f8e-9a77-e519-b668e24dced2@web.de/
https://sympa.inria.fr/sympa/arc/cocci/2023-03/msg00098.html

Regards,
Markus

