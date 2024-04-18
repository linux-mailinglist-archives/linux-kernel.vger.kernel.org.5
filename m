Return-Path: <linux-kernel+bounces-149681-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F11F8A9478
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 09:56:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B83FE1F2290E
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 07:56:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D56C75804;
	Thu, 18 Apr 2024 07:56:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="Ws5E5j6u"
Received: from mout.web.de (mout.web.de [212.227.17.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD4CB2561F;
	Thu, 18 Apr 2024 07:56:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713426993; cv=none; b=hIkaYZHFKhb1IXDcUaZYetXC5dxHf7oyBWZNceSswnmqVsFTzKybjlcwLRVhfmU0ZwKFHV7kkA/Chwq0Uf7UZnm3PCSZ7oT9tTh1aqdJtGP1p0XQBBvhpxbU90ZKybQ/FrNpBZ/zrw0DuPd24Un17FWZt6fodc2HY0Agk+GRaCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713426993; c=relaxed/simple;
	bh=Mq64Yga/5Le5ofKIbHbo772juJ7fU0Y2p6pNDzewj9U=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:Cc:
	 In-Reply-To:Content-Type; b=r8e/jK+labwtRQaD1YXbKcnTN4FlfXBukTM+c9542SGJ+sHI2n8yT2cJaIJPVZS/ZWYBp7Gi9ZRHAaPPCD7byd4iYsVPXzhhI9RYjwgU1P7ny8fw/4SUEifa8LEmusvbh3YRF2OXZW+FlDV2T2Nokho3cri7xt5U3UBG8c4CFGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=Ws5E5j6u; arc=none smtp.client-ip=212.227.17.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1713426939; x=1714031739; i=markus.elfring@web.de;
	bh=S5LbYc5u6ubQyPAzR54z+x8sjP3fqCyXFzNnN4fh8/w=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:Cc:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=Ws5E5j6ua7QUO0x4V4RtZfwRKThzajC5iyb2F/kshR56DdfCIZDVpmLDSKVHa29g
	 qNexSk5/MsBTsLn08vOQr12G2tQeiVITpNGinVYYC6mVrg8pmaRLerHtXlCyTQDlJ
	 Oda7raZ1W5dNqSqL5dfuC7o2AAghI/kCoRP9jzF4TiAPK1zocvIIHM8J7Pm41pYpG
	 8LScCyAdX8bFjpxTAkrlrWtWYr4cXAAAd9ocjmfAVOps7AnfOvCrrFj2yeEM+Gozl
	 Iw4NQ74KHOFSBvaEzLb9Qji+ygFf+cRFuo0MEPfWKJefdo7hqmuip+2x1+OHLucGD
	 PLviSm8Vx3HOAn8mKw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.85.95]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1Myv72-1sst7B0agM-00wH5a; Thu, 18
 Apr 2024 09:55:39 +0200
Message-ID: <dd8cb3dc-8ac8-408c-845d-af60307d72e4@web.de>
Date: Thu, 18 Apr 2024 09:55:29 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 1/2] irqchip/gic-v3-its: Fix double free on error
To: Guanrui Huang <guanrui.huang@linux.alibaba.com>,
 linux-arm-kernel@lists.infradead.org, kernel-janitors@vger.kernel.org,
 Marc Zyngier <maz@kernel.org>, Zenghui Yu <yuzenghui@huawei.com>
References: <20240418061053.96803-1-guanrui.huang@linux.alibaba.com>
 <20240418061053.96803-2-guanrui.huang@linux.alibaba.com>
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Shannon Zhao <shannon.zhao@linux.alibaba.com>,
 Thomas Gleixner <tglx@linutronix.de>
In-Reply-To: <20240418061053.96803-2-guanrui.huang@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:PZdgHBN78wyizsyQQpAlel0izI1xBOV2XE/QQJ3lqSH/ApYzPKa
 1JuhYm46c0zVdGschPAk9CVNt6EULxTGXLVr824CjLk3SXKnKibf+7PmSSczPbWKL97JBjo
 mXcrUvXu6XxguteaggAGT4bbWeUG1Jh7k10dFEC43QQDzDvmeFR+mNQo6ntUYKu6ccORgzn
 CWafBsblbYkIVL6VtRSuQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:CByfIuwNzkY=;m0HxHAxu7d19iH5LThEdoCnWYDL
 MpbkOmjDC/jWtmVA/jVcxNJDja7muhsw1KvR/1KT44kkItDXc0Fk8AZQfkQji9YqQnMpfVl16
 RO/r+yDOgrjsC47rMPt/4OuARN/slGOiWO2WIjjO9lv8gDaSgI15oZPBmkXG/9qXIaeWYZXwL
 9IRuenbJARfLjkT/3yPymZ0KrhVp8PNGhA0Ezg/T8yAp+gPn6j2LFeOqajXJezKJGEu1yA57k
 ipRWZvRpQDzxw6fWrFtHDkO7jTbafPKBKfXrNHSUPVIAjjnR9l5gS+qusA0a/660WgAgqI/Op
 gWP7BCdFPkr+O4tl6+1kz5ArVXyaU5LSkdcZoR/+eFPxAfGhQzf9JQllUgqODTLzD4k7ScjJX
 38iQIvqKzuoScXIykgzSZOKFa0j4zEqGvRFTTdnsgLQDcRsJ/GZeLyyTpA57GHQmzEKybFELJ
 a348mj/Tl262Hs8v1ozN2gMjIxN6JkQDFikppUQmAok504fdYiRHakSaP1I/x2IFjGr+AfQOc
 uwgGxbTeSkrVJK923UZg2UuE8lxh2u4Jtmf8V0rjnGsEsgDQzi9j8i7v/FwQUoGuevvDuokyh
 6qdvPGOrFICNm4KlzAhHlONSHt6D24GhtnEVDYE74wqqUVJHnW4X7BJaJLNyvJgGebrSN1bp3
 wo0mDXHtJoQfeypSgGr5zdYlpdjs0mNipZFpzRGOmjha7tLuo+f+S+8lCwAbaUGkNdZtsHIlS
 T8K4y5WcFEWWF8k137SXYiASZFnjGEjscmL4iKEnzWDH/mldmZMmkOkNPGeM6Jse+hSDcHVnz
 kSYpjI8VhbySvFYtkJ8lOqbSx3q3x8Pbmq7kNe60t++MA=

I propose to improve the commit message another bit.

How do you think about to append the text =E2=80=9Cin its_vpe_irq_domain_a=
lloc()=E2=80=9D
to the summary phrase?


> In its_vpe_irq_domain_alloc, when its_vpe_init() returns an error
> with i > 0, its_vpe_irq_domain_free may free bitmap and vprop_page,
> and then there is a double free in its_vpe_irq_domain_alloc.

Can it be nicer to avoid the duplicate specification of a function name
in this change description?


> Fix it by calling its_vpe_irq_domain_free directly, bitmap and
> vprop_page will be freed in this function.

* Can the phrase =E2=80=9CFix it by=E2=80=9D be omitted for an other imper=
ative wording variant?

* Would you like to separate sentences by a dot instead of combining them
  with a comma?

Regards,
Markus

