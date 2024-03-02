Return-Path: <linux-kernel+bounces-89429-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0248286F040
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Mar 2024 12:26:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 826301F21C32
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Mar 2024 11:26:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52E1D17561;
	Sat,  2 Mar 2024 11:26:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="aXCy6Sxw"
Received: from mout.web.de (mout.web.de [212.227.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C821017593;
	Sat,  2 Mar 2024 11:26:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709378764; cv=none; b=mRL2OhLxZ2kZJgk3URMOnpphZ5Z6MvyLMtPNOAiivG/QcvLrSW5y9sqU4EoMLwc7WQapxvJ7tLvvYo8q24RxhdAqd1V3CLmSdO8VRbc3hocrNt4LLx29Xa1qjlTQckD8qjXddyw7oqObBYjKPOOeccVD8mcofmTEMNmjUcww55w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709378764; c=relaxed/simple;
	bh=OUTrGAUUb83ehkuew994F0ovDeCHlzF87rm1EoH0du4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=crNONbYlj8yX2EbmvO4kzksH9SN6G69XsykgNz+XvintSvuDIyTcpivXa+obL6IrUS7FFtDztUbVa1UNCTqa/vGhPshKAP8oCvX6q5a6f1MHiGXt3NNAEVSEZMra/Mxyz4wKlbFQLGA7GplRpboIqqlkaA6tkQfjg3x7PZtBh+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=aXCy6Sxw; arc=none smtp.client-ip=212.227.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1709378739; x=1709983539; i=markus.elfring@web.de;
	bh=OUTrGAUUb83ehkuew994F0ovDeCHlzF87rm1EoH0du4=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
	 In-Reply-To;
	b=aXCy6SxwmIowIzZrMg0w+a9rBfVupG/Hihlj0+1CFt20ewJU+b3RpC3JrSJNTux2
	 ws7d1tfAKLe+O6zrNk6P5/sVKQ18pzawuVw30ggiXPMWfbwwN8dcDOyjufGhGQl5r
	 GuFz+8fk8LhUnuI/pzXfjZFLPT2I4sxbxU6HJPIQ1q8fNY+IHkbBewkC9mLg+CU6b
	 YHxpTJYKYa4r2pJMHWyWon1U15oF0XW2DXeejR/Z8VIAv2IpHmFQ2HB03Yqh/SzcZ
	 iPH4hcWytxjq7Yic4pfb1ZUCIm2cuG6MzxOkEuhUfmMcYeVi95Q1Zbip0svgCn/mv
	 Ixu+b9vD8ug+G4bX0w==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.86.95]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MGgNU-1rbTvs3eVe-00EIP2; Sat, 02
 Mar 2024 12:25:38 +0100
Message-ID: <5b2ac08c-cede-44f3-af7f-1bd1b89d113e@web.de>
Date: Sat, 2 Mar 2024 12:25:37 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] media: i2c: ds90ub960: Delete duplicate source code in
 ub960_parse_dt_rxports()
Content-Language: en-GB
To: Dan Carpenter <dan.carpenter@linaro.org>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 linux-media@vger.kernel.org, kernel-janitors@vger.kernel.org
Cc: Sakari Ailus <sakari.ailus@linux.intel.com>,
 Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 LKML <linux-kernel@vger.kernel.org>
References: <79fa4854-976d-4aad-86ac-c156b0c4937e@web.de>
 <ZeGV_siWFkfqSEgZ@kekkonen.localdomain>
 <db1d7227-f9a4-42fa-89ba-b484e1260e0b@ideasonboard.com>
 <ZeGZsRtH6YLx2FiM@kekkonen.localdomain> <ZeISEYXTaiyA-b4K@smile.fi.intel.com>
 <8ece4c88-dbc7-4327-ac2a-0a097fc990d0@moroto.mountain>
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <8ece4c88-dbc7-4327-ac2a-0a097fc990d0@moroto.mountain>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:2f5M1q42L5ZXnK64WgtMumJwOpZhYCe7tAAq+BvQzoMSUfSjy2P
 d87nDiGvj4rLSyfGkbCgRu71ZSV4a9VzsKQB4NX3Y23HcwulkC55LWYn1eUHgDFBLEl1xNy
 8i0rY+bWT75o58AwhdCQnazlDw0tSPs6UN8V8vSZf7OLQiHu+Kw+yXaM1fVygId+m/ET6QF
 577BEdO954NNg+Co4Upeg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:VGhGnEHWso4=;IsBx7aGkzCw3jSEWa5tjcGrRH8P
 zlnwb9yarrgkzR2Ur2L67ka0yCnsCS0wR3EnI5BYn9Bd6AH62wr5LaAqma7iH1FKzQWjg5Hav
 +3HMmsrdRzLy1KnijjuI/jrsoKNBrsDVTSMztdao3pDxuVVmin2YxE2Sln9B7DZfZOu1V7vzd
 g24BOXh5mTMQ4FEyjGBpDT8U72uUP1skgglXbKjiKtW5G5e6Gn2KjXSor4Y93xfGwOw/I9T4g
 rJtRPWj7dlbJQf24qNx1ITAsc3M4wP++fmX88diGjLEILmpYfOgu9Dd6H+R5LLrYtnIgvcopa
 q5vxHTATBmpBKCesU1r09pr7Z0MEZZae0/+UivKTog9r/l4zVQyn8ZWRX+RF2lk/f643oLdEm
 E6AGqWWipDOeZQCZGu4B4uXetntU2iZ4ifl3fZQXC4JzvHO8Ixq5oHukc8RtSdYCp/+oRLb0N
 DmsW5OPZ4nwp6A5itWjluM0f3YQEovJUX6gyV2wKeqLwukwrEGR3PSDd/c8RBV6ne6jBs+lE7
 c6nn9b0sIsG7thM+dCEcDfRDfVytCu+TxMjrYxYuWZiRr1JheVtCmVACj6rv7VKryphGxAqFk
 zEts5mDXs2/TzHg671pDSfjdTZ7NQnAfxvmtc6PG6+wyjB7lu0NxAeTjGVBoNIxFdoFb9hugx
 aYRqfA4lLp+te0axijvp8f6K/n6lKKUrJwxidoSpvJZ2XLyWcf30QM4YW0IZqoLI01BXA1N9I
 haWLPL+GrG/b6Tj4cuPhJZhTd//cmk4NNtU4kc6+0Oqr7zBKPd6Za6JpQJyeT2ffaqJBL+ZWx
 vAW5cLjWSS6+AON4wLvC1FytND+pQYWMcvJF++1n2T0eE=

> The __free(fwnode_handle) stuff has already been merged.

Would you like to point a corresponding commit out?

Regards,
Markus

