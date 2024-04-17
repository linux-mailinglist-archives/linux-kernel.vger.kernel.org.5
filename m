Return-Path: <linux-kernel+bounces-148847-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D88E78A8810
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 17:49:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9845E1F22EAC
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 15:49:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56A801482F5;
	Wed, 17 Apr 2024 15:49:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="K/nRFmq3"
Received: from mout.web.de (mout.web.de [212.227.15.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E419A140389;
	Wed, 17 Apr 2024 15:49:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713368968; cv=none; b=TWxwQg6+nWd0js5bWPSXkhBGACzR9iC/wTFkHHVK36Bg6VKUWYPwZXSQfE5HnURrAqB7XZ7lqK2rgBoQ8EkWGyFZuDtIvMH6PzNvxUAFfV4R26Atxmp8lRslbDyl+xyYUnY+jZH3BPMRhK4y1EDly85r71GJlI1KutXmLvjM+0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713368968; c=relaxed/simple;
	bh=i+P82q/tekMc6tNfNG2RWz3zLZWMY0FAb26UI7miaxA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aOAdgNwjMmk6aAmlL/tLbsh9w/fufDzy027ZgYdpoANgX+Z1uL9w3XQvLXgBnf0Phd0Lth9Hu9XhjPRZP4MkYr3VH5odF5Yen6AqUgT4Utyt6xzn0sjm6y+ZFJMC/1FgZuygAvlrl1Av/zp7s9r5gzvkxKGrfj3MgsVwZqWf19w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=K/nRFmq3; arc=none smtp.client-ip=212.227.15.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1713368918; x=1713973718; i=markus.elfring@web.de;
	bh=i+P82q/tekMc6tNfNG2RWz3zLZWMY0FAb26UI7miaxA=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=K/nRFmq3doFBdGMs9j3Yx6hycO2x50V3yW2mJiz01T+NVfq4+8W9AGzaCGYtwRnu
	 QaAEQpYVXURmxVxfiENn8HrEWa2EamQ7xINx5Fc4FUpoY/jzXFQWYSdTgLmv/Mskj
	 Ry7Kjh6rYDUyVDpFPpwa9YJe4Bs5tK3XemCcnCI5n6VA5D/NIM7yKGCxpAF9OEI6v
	 Oq9YWC+U52zGHqi9Sy8xoV0KukYMzyALTEAbZVu+53NJvCmWJJc9ymLVcU3Qh8SWR
	 xWGfRXI7GILqG+e4a0yDqzpNvojBehBv0D1ieq5CeobzP8KTvkIa6CZhC/r0K5YMl
	 foY1/0UoQK4Kc66cgA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.85.95]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MOUtm-1s6P2R3sly-00N7pz; Wed, 17
 Apr 2024 17:48:37 +0200
Message-ID: <4b9a14d0-b4bd-4b91-8466-5f8849b0c08e@web.de>
Date: Wed, 17 Apr 2024 17:48:35 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [v4 0/3] SCSI: Fix issues between removing device and error
 handle
To: Wenchao Hao <haowenchao22@gmail.com>, Julia Lawall
 <julia.lawall@inria.fr>, linux-scsi@vger.kernel.org,
 kernel-janitors@vger.kernel.org, "James E. J. Bottomley"
 <jejb@linux.ibm.com>, "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: Wenchao Hao <haowenchao2@huawei.com>, LKML <linux-kernel@vger.kernel.org>
References: <20240307144311.73735-1-haowenchao2@huawei.com>
 <99598b98-8550-4dca-beea-4c2d61d46f78@web.de>
 <b55da065-dbbb-4d8e-8baf-50807b507cc4@gmail.com>
 <173b55ca-cde-ab3-be92-d9c8b4b6b5c@inria.fr>
 <799944de-dcee-46a8-b43b-8876177c61a2@gmail.com>
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <799944de-dcee-46a8-b43b-8876177c61a2@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:l8gXR0DDWYxOQAa7TWh9N40VLCl2PgZ0Uyevu68+Kn0pOqf39WJ
 XZrIhvzeM1qK50ABQkrhIiRxrHsQfobUOOV/CFtjYXtmgH93cyKOTMOVgLpmdn8QLcjFrLh
 3PCuv/6tcfIONuzt8nroibmq2jbRXmVuyP3BSNtgwqWEYiY1ica4ZM8QsQInJMQQmdgdW4n
 FH0MllNrH+6FwBKHEHY7Q==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:2hyj7KGRkig=;cU+8XFuLsqheAqdENeGUw0MzhTn
 7OX3IZnDRImJVWCv+bZhg1EytFTq7vdhuLNnjXCKXDLvKSWskNdKDbCJ6h6OSbOzvKdgYC2EQ
 aA1OpGdeI9qS6QaNwxPQY3fHIAPRgVVBcXnAsZkasgrjLupY8Bd8fKw+54+fE5jR+Tzv+l2uP
 JgnQWe84cP4bPMhAmXOQHE4L271wMshE4pQu9INTJKkISI8eQA1naqfa4C3JTTKwDTL14eVql
 OTJioJi0JArBSmNrHjR65QFNdeexhWBKRmLMjLFpDAW28utEhCC02Xomorjb8wNHUshb7wN6u
 vZJKc+36RLkn2Ms6RnEqAiIVo9V3CIzmWCe9O1Du4BHUlPAP6Rzkm3W/upKWbTHVVqhWNRBIS
 yU474PaP++fWUM1NvqZZMZLnHH4dy8BYMHLAdfzfljOsQ+ddHL2OvrnuMzHlw/SmhE6GcG8PE
 vfaxodxtjjnmQgpS2iXxsDuhb9X1nMTU3bcUe4Hxg7X5MamlmNfpSvu80sOhnlASf4VI8ZXaz
 utt+oHdO5YkVnMLyFFiAYtR774EUujsY2L6qS3VtCjEPLYxOzP7pWQEejcvkH48nGrHG23Hgs
 uTp9OBxYigIiU1Z+pLB1JwlnRjvKo44mNfOtGj2Z/2VwYPgWNIRxgysDngGihiXwRUtjTqQ5c
 u/WkZALwh8Yu57Vnf+dAxtu6pnaeM5+uIwufggBTz8P3t2iRauVzWz0tuMcJVZ3raG2SxTZ0s
 L5KfV7M/CO++ZO0CTUAH7MzkrZ1IYCL+5q/cJ7ddqRignPjY/7MaWq/6ASmHByTUhpoR1ZoPc
 GhdzG3vpIydQ66ICoT2Y2AlIVLKc1aqF6r7ZllJw/Bf28=

>> Search in process/submitting-patches.rst for Fixes:
>
> These issues are introduced at first version of git record, which is
> 1da177e4c3f4 ("Linux-2.6.12-rc2"). I think "Fixes" tag should not added
> for this commit.

I suggest to take also another look at information in a table
like =E2=80=9CReleases fixed in v6.8=E2=80=9D from the article =E2=80=9CDe=
velopment statistics for 6.8=E2=80=9D
by Jonathan Corbet.
https://lwn.net/Articles/964106/

Regards,
Markus

