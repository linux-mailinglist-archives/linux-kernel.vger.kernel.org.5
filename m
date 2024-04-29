Return-Path: <linux-kernel+bounces-161937-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 748FC8B5392
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 10:56:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2FEC1281497
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 08:56:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E64718041;
	Mon, 29 Apr 2024 08:55:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="ZciszVDJ"
Received: from mout.web.de (mout.web.de [212.227.17.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A487717BB4;
	Mon, 29 Apr 2024 08:55:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714380956; cv=none; b=snu6KPFyEn7MWeN45ZVvaPNmlPX23fHi/9wYI0GJZt+WLv9b3VYCWYGl4DTrERNzxYGkKjxkHYPq842PyEDd2tamGSernrlkFhP3zIAtxjkO6vuEm3iftzMYhi2zJv7qG5GOzuIIFUeNlD0303dCeafA182K5QjcnEbIAiMpa1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714380956; c=relaxed/simple;
	bh=l8Xof23BbhSzLfOSXDkmbn8p+6qq1fPgKfJxk7WsIQI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=s3qEJI7lWPtvm6XFvc6cjGRg1rK1kxccCqmyx6LsHAG6M9avXfE9khcxwlMgzvRKQallHt0Vd9WU7Q0n4ueQtYU7vy7P57NQbjhp/NM3l6in4LDUmjbpSpLhi6Nv7wol2Tr/B6pO/31XANGRAMspXBRaeKGWegGz8lYzSbGdK7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=ZciszVDJ; arc=none smtp.client-ip=212.227.17.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1714380931; x=1714985731; i=markus.elfring@web.de;
	bh=l8Xof23BbhSzLfOSXDkmbn8p+6qq1fPgKfJxk7WsIQI=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=ZciszVDJL+Cfft0UBUcPRH7hJ48Q85n5943psKjryJugXdgh8XhJP+TNVljqXUms
	 BIom+RgdMWRWlumtjXc5OmgxM07bJA3Qo3BbjxXyQUo1hzkns5+n/Y1xq7gJSYpNb
	 yzqgOK/brRsLtNg7nLCAOt2r5BInpPWXyH08lk1tEvBo2D4rE9bjC9xRv+z9jFml+
	 qMxJoGegZoRtRcErky6bK0bxyPIW8AYbwceHhGdTKlR6d0y1IbKFGPGEs24T90wqj
	 vmBFiV/Ri6QLfa8ePRMXxE9nw64aNfgxa0NwjuWO1Q/GQHqWuuufwK8W/iA30RaNI
	 AeOQbJefAKy/ajo1fQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.85.95]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MSZHv-1s7b9W1mFF-00T4oM; Mon, 29
 Apr 2024 10:55:31 +0200
Message-ID: <ace70750-6f58-4bd9-a18f-9889dae30061@web.de>
Date: Mon, 29 Apr 2024 10:55:29 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [1/2] cxl/region: Fix potential invalid pointer dereference
To: Li Zhijian <lizhijian@fujitsu.com>, linux-cxl@vger.kernel.org,
 kernel-janitors@vger.kernel.org,
 Alison Schofield <alison.schofield@intel.com>,
 Dan Williams <dan.j.williams@intel.com>, Dave Jiang <dave.jiang@intel.com>,
 Davidlohr Bueso <dave@stgolabs.net>, Ira Weiny <ira.weiny@intel.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Vishal Verma <vishal.l.verma@intel.com>
Cc: LKML <linux-kernel@vger.kernel.org>
References: <20240429013154.368118-1-lizhijian@fujitsu.com>
 <1df4e8d4-733f-43d9-a9d7-3764b6df7ed7@web.de>
 <bbcab973-46b5-4d91-b8b3-c91d43c0f58b@fujitsu.com>
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <bbcab973-46b5-4d91-b8b3-c91d43c0f58b@fujitsu.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:B9QWJts4awVPIctxoxeBFcWVCQbZFqFvtDiFDwvRjStPFwA9s7w
 Yt57WdkqEGnhbxG19RpDG3LLuVvkVmeSfjJyZ+uFMjfe2c0DTDMiYPILQj0YEx4pwogeF1s
 mfChOtNiLMLbaipx/gdmEiUpwPDU7ywZOfWj5d4+jz7c/D3KoZyJMdakWAWhcjoEs/11zxH
 4jJi+Y5FDTlAlXVRrl6ZQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:mPqRFujCFQI=;EnfOIVo2BLueNwmCRkDBAiaorcL
 hwM4eo45Mf4J6+w7XznnHRFYtultKYv7pK2voUv8nq2EGZy8TcxT3vdmPjV30V4j1XSHKmupY
 h1D11FtG/gKuG0rTalH4eNCkc60BK7+KuFNYphsuEKu89hBoSYHNg+w/qAHrmYYmrMVmFBmWC
 FQt+CaXlupuhpD8LuhyD0SSyxN+sKfibZ9YIrvWyJIWFmOLa6/aiQVU+33IJ1cethzhdPGCGi
 g+0OSinfnyjSUBwUKZyKK0BVB7eN65IK9LedqduZJCY+cNE19MoKSQoCpJqcjTYi6BjL4C6zS
 G48YMqt2kZBnuGo3iq178IUovHhiCjgaGhpWOMqlXfBLts9EBA9eN+tvlVoso7orAxsmXxImU
 rljHF6Wu5nz1m+mWOE/dyg1JqVh7u3GW+K+hIAp36Hwf2nQtO+uIZG7rFiD+Jz9QI/dOyXeM7
 fMcqUsEtv3udvUX9L64W9fWzC986AuO6pzZQybGLAludfLZjN2yCZMiNqce1vMj83I0sN6aDs
 tnoBzWHqgbxQkG8tQJbloaLSvAiH1QXyIeuDRHXJBDSuBtdY48Rvin9Q6BwMnFw0/jwKgiF0x
 CHC4tRbXpoykIbHRkOZIV6QolBY5yGyU/HNVKZItmgyz/EK53BrD1uJuYaGpI7HgKS87v87RL
 Zvt4aVU4FnjwF+xqV1yfzgpUQPdK7lHL3IGGAiZf0KDvdw1nYsc1SiMgcywLGUNAD0JK0Fhoj
 0m1dUgL+WSHNq8baD3EdQLHYxwiDCoRY+lbr6vaPzFLVhDdfLLphmUK/X+jy4kwAWnUOVTP+W
 F9LaPHuY3gFq+wzlEj0KW+NOfAnjqaPGYxhhfRg3Y0Wl0=

>> I suggest to simplify such source code by using a conditional operator =
expression.
>
> Thanks for your suggestion. Do you mean something like:
> cxlr =3D region_dev ? to_cxl_region(region_dev) : construct_region(cxlrd=
, cxled);

Yes.


> If so, I'm open to this option, but the kernel does not always obey this=
 convention.

Involved developers present different coding style preferences.
I hope that further source code parts can become a bit more succinct.

Regards,
Markus

