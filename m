Return-Path: <linux-kernel+bounces-48627-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B0E71845F04
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 18:57:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E3FEB1C24384
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 17:57:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 342B174293;
	Thu,  1 Feb 2024 17:57:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b="n9hopJPb"
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DEE57C6FD;
	Thu,  1 Feb 2024 17:57:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706810233; cv=none; b=exTnmSq6rtrBHioFNWJ80+OnYWs8kPQeZ6LqisfoZBNaOShRZsLVsK4fwihl5Me9rR/Q0hPkxf2dERJZ5vzL9NZ7MBX1n3ZpHNGESGutXYoF+6rhS3kQPzEmphNNN6wbrRBsCUPJrC0ohV+tWvlD7QzTmYkqy8JvrqA7aoAMiJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706810233; c=relaxed/simple;
	bh=uaWEivoYqSswCbXULhbTZ0MXP7ArIKokVpkpfv2RJiw=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=TFVcSsfVE2QrNyMf5r+sbjDQSXoEM3VFsRrcj0zh3L+KrI5f6BAbYL5Q9FYcdM+JDyG9sxP84P4QJaUQfusb8itsLt0DtcHBzeOx0V5OQ0DEX8C8D5eLNa/45fTWUdticQ6oGsLUuxeTTal2jTDixKCNda1ej563elLjiMmUjj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b=n9hopJPb; arc=none smtp.client-ip=212.227.15.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
	s=s31663417; t=1706810213; x=1707415013; i=wahrenst@gmx.net;
	bh=uaWEivoYqSswCbXULhbTZ0MXP7ArIKokVpkpfv2RJiw=;
	h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
	b=n9hopJPbtcDw2O7Nz3N3Gbb3M9mtAecehUucUXsOb9Bi5glH7lb788xBOPzVRBfU
	 2RWSRWuANp7584zQgru3B8R+L4pyWH3ysgu0PFdYVgguj1MuRKjC1eJRcyo/65ODw
	 x9pXVN9tWcoKa/8SXoMKMiU6bCQYKU5tAo3ayRYELCQeSaFnIZAatpTtCUtKXAZb9
	 9GFMAYtl+wBi8XkEhURbwQrE3Vvpf7XpGgLfCJ/rZ5VjmjWRdSyhXU1fdZtZkjbq8
	 5tixvLy9nB2IL35sZPDYnOT5ypq0/PWgykDuf+fp3k/Gfaz8zLNWmrkyWtdEj2bZf
	 bUQQqobLH4a+//9WeA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.1.167] ([37.4.248.43]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1Ml6qM-1qmOeP1m3w-00lRlv; Thu, 01
 Feb 2024 18:56:53 +0100
Message-ID: <4498d3df-762b-4ecf-a196-605c096913e0@gmx.net>
Date: Thu, 1 Feb 2024 18:56:52 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] spi-mxs: Fix chipselect glitch
To: Ralf Schlatterbeck <rsc@runtux.com>, Mark Brown <broonie@kernel.org>,
 Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>, NXP Linux Team <linux-imx@nxp.com>,
 Vinod Koul <vkoul@kernel.org>, Miquel Raynal <miquel.raynal@bootlin.com>,
 linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20240201131540.3dlqoxlrrbzshz7w@runtux.com>
Content-Language: en-US
From: Stefan Wahren <wahrenst@gmx.net>
In-Reply-To: <20240201131540.3dlqoxlrrbzshz7w@runtux.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:Nn3mcMdInQWNUh32aNt/rbWYVtvKDDtukqQaAxOdV3HgNEjDFiH
 +eg+rrA3Pvd8bz9DZ1Nn8I6rqgCNBL6bi/Ri81grg+dWTHDdPamQvCj4Yki/Me2gLo4CMrj
 MY+f4rQ9nDax3wec0lV3Hqechp1QYYapplAOdWhPvYvg9GQGNW7ld+TVCGq5XY2fSaxihEZ
 Te10Hy19dvkbYm2re7QyA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:h8hWU1j0xoY=;FbyD95JtcaiwtKLjhP0G8KZe8uH
 6bYPieLQ6uTdHT2MsdbKRdCvCi9/uvqnOScMvGhLuOhSU9/K0mVKKJJLMOiXwLH8KutvHzS4a
 YD8bmkp2ZGpaiO8+NYxFbZqYAbWDm/OPafSw6+A9Vp245uiRiGoS3uxMwZ2OiQ76OESs3K5of
 TdbVhykmk5o1eP/l+0YzHglegiSJA1Xw1qYxFHNu3+GtnqnqBobyp8iSTTnQ0AUbGfnkL81WO
 b3P4dpXe++T80pChcbOWiekqa9Zby77NXrd6viR7aO0nnv28b1WHMmk8OnwHnXn1lCzFRG58E
 +x7CGD5qq0kC+RcYLSH+/fij7Snm3ea88nvNnOcSDtIpbx1pNwH+FGLTgLEKr5uViDgVAgXhF
 ovlJOyiKquie0ZJNAvVLLnR+nZg4eKDefzmp8BZx5CJMdVFdpWpidrVBmHlRaAL4qkH6miLDt
 eRvQJ16ZloyW8rocoWSIuxIR0Ksklt1vGbJCAq2KPDlYh1w9BgB/H70WGOf05psmCYQnPmsqo
 VDgFzmNPFAGbc9zmI5XrCeOaGThxtN0pf0y9IKmHkWV6B7x8KJTJmORpDnGpsdNOZiCntbGC9
 pIW9B9a/RFzpfSAIa1owWXKMJRhqG6NgE3sXweG/ikzOigk3suqCs2Np94NCNYtXHUgJ23m+w
 bewcGbBriBrBxaJYMGrGTtRDqNODxAdRqCG3vXI0BX3bankqgl30v1YhAZon9N7DyKSyMzdWQ
 f4wo+fCYCdjOLGcSnIxi3Lujn5pEKu/2zmFyh6xovc7mggA88YJ4DgLg1OOyabzcmVbUrA+vv
 goAiXZvW00Uu3l4wCo9AvfOIWWiWFeoVZnNKKQeqPnFgo=

Am 01.02.24 um 14:15 schrieb Ralf Schlatterbeck:
> There was a change in the mxs-dma engine that uses a new custom flag.
> The change was not applied to the mxs spi driver.
> This results in chipselect being deasserted too early.
> This fixes the chipselect problem by using the new flag in the mxs-spi
> driver.
>
> Fixes: ceeeb99cd821 ("dmaengine: mxs: rename custom flag")
> Signed-off-by: Ralf Schlatterbeck <rsc@runtux.com>
Tested-by: Stefan Wahren <wahrenst@gmx.net>

Thanks

