Return-Path: <linux-kernel+bounces-161745-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B6FEB8B509C
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 07:13:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6C6491F21F3D
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 05:13:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2319FDDB2;
	Mon, 29 Apr 2024 05:13:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="ggtbx8GZ"
Received: from mout.web.de (mout.web.de [212.227.15.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB05ED28D;
	Mon, 29 Apr 2024 05:13:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714367605; cv=none; b=BED3j11u8ahbVT5su3cN0MuY1gpRpcbLxzQXehEA1nT7n6k66CsvbOHRJ/ZtNC8mwbEdN48X1IXEBY/wvUOln3d2HBH5IvCuKYjJ148Ov8J6+aDLfHenWP3HkRq6HEYnkBn7q4Kb4SDLagiwi8GGtyIihXg8i/Q3jo7IZ7MIe6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714367605; c=relaxed/simple;
	bh=6MCnqWatVGDcoOaSP4XU/7z/EyzaAOWkNis5N5nlYaM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EwpGxhVS2BGxLqataUAgGAhUkYKWBDjIC14cMjvaY0lpl/zlvIalyV2fW+RXlb8ddSWLj+/kIiREj8ANaEwUjzGcoqTwZvumfF9jt9n2xTfOmWWhARFTYhO+gcLLfP2Y3G5mxKMX6rcR/wKqZPCtV6qQFKuMkvaHiy6AgsCIfeU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=ggtbx8GZ; arc=none smtp.client-ip=212.227.15.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1714367581; x=1714972381; i=markus.elfring@web.de;
	bh=6MCnqWatVGDcoOaSP4XU/7z/EyzaAOWkNis5N5nlYaM=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=ggtbx8GZyoxvcRXMXVSA4+UD1FYD6gKjIJKwXeOBPgHQQiw2WpgTUKxSAIMPmP5U
	 ja/Vg6xCGt9KSSjV46bo4eY7tdG4BUnU8BNy5ARLoUzuuKL1HdN0bxAEbH4KF/uaO
	 RM+ZJFppmeQAuiKmtNZ+trpL02zSL9jEndRcDU6lnsMV7jDFQhj79f9fmHpmRbRxg
	 L/cSC/gzGT1CoZRkFv1VYB0HfYnwEx+Mj0FodfGmiS+7JucAI7EwxaEggYJDPe5qT
	 L2jqnwzPNRmPk7nHRnms53No3nAhsNYuZb06eRCgB8B89aXdPfXJln5Y1yTW3PUtB
	 uJcOwt2zGvubhdCfig==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.85.95]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1M4sbr-1rzNuc2MmV-00DN2m; Mon, 29
 Apr 2024 07:13:01 +0200
Message-ID: <9c711441-6e79-422f-9405-ee271929e77c@web.de>
Date: Mon, 29 Apr 2024 07:12:17 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2] scsi: qla2xxx: Fix double free of fcport in error
 handling path
To: Yongzhi Liu <hyperlyzcs@gmail.com>,
 GR-QLogic-Storage-Upstream@marvell.com, linux-scsi@vger.kernel.org,
 kernel-janitors@vger.kernel.org,
 James Bottomley <James.Bottomley@HansenPartnership.com>,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 Nilesh Javali <njavali@marvell.com>, Saurav Kashyap <skashyap@marvell.com>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Himanshu Madhani <himanshu.madhani@oracle.com>, huntazhang@tencent.com,
 jitxie@tencent.com
References: <443fb75b-948b-430f-be33-170e6f592280@web.de>
 <20240428113404.12522-1-hyperlyzcs@gmail.com>
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20240428113404.12522-1-hyperlyzcs@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:RuBQhBXJ9LkR6nSLm4sThUW+g2XoGD7/LUNVqS786SrnlYGBLVV
 C5U/OXjjhn4AEinIdtRTdTjpUrvc8f/QFW8YY37sKQ5Wpy0nlvayt60g1xRdSAhO1PP8QhP
 2Iio2UYT65lSCOuW5E0cFskmlk85yMF2mWQVoPEOLT2uAXicawGIa3ds7PD7o5SfPyzFCgl
 eMPBPzYHOszZTfwxkL6ZQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:+YnWFr0EOwE=;N+eqH2g0sE03ptK/f70HTfP0LH9
 0yWmlGSL4qjaK8f16suCY1Taqs/oigN+Nubl2NkXlCGapzcb5/zO6jrJVOQJdDVKEtZZREZB+
 pn9CUFptwZtJ3PTZK4XOw+EX9btyaqzTvLNgejrEtcWleAM9Ph4DgzUnyO6v7jV0IZFaIRG6O
 +9dus4XM6r3DWH6m3DWF0bKMWvojk3SuluS6lswz2fjIc46VHNogJJgaYfZKosX0i4lIf0nTJ
 Xry+McXnhmVfw44FMR6Ixcpcu68jX7QO6imEWfga1sp0K6iR0NSNZ0OiglNa8e/j2G82acQ6U
 WW5UBCy7ICCX+NKZKocCG9m+Jm0q4JgXgZMP7NYrMv4xD/6fNJ/6jzUIM66drfvpve/VkuL9X
 SufAaia7oXJJkuh3/52uiV6nookfzS7uQ/5DsOwEBOsm4zQxaDCN6tBGyUCvdqovyAllbOS0/
 7QdrRRnrK9NSeoe9bJZDPYONWKUYa9Pz0D8w+XomK/m44bE0nY0b2YrF5zwhRvAW7DESuGGHD
 VwElIyZAWbGltFGD3/VoU0ls+MCQzXiqv309F02XFd7F01vCw25f57zNlUkdLMXzjRqyonf17
 xPeVI5OSqldMdZqBoiOhPStVRG7n9RO81quKpbh7VRHiChSNcbdxLhCCm6GV9CGqESQ5/bgex
 QhUzLz27k4F+3Zd7IdW0z1zeKonAjyw+Oh9FmqD52IhPaR0r0A9FYSWyW/xf32s47LWoM9CXj
 3B8WvVVrw5Q6R5miY7KH2gpEkxqiyLySysapCMMGzJnuu8ZOZAgkNDuTPT1wO/5SdrQgEZwdl
 VmkL/a0ZiLem96avyLciboD4SL64BgYXCokLj2wSI2GBI=

=E2=80=A6> Fix this by cleaning up the redundant qla2x00_free_fcport() and
> replacing error handling with a goto chain.

I imagine that there can be a need to provide the desired software adjustm=
ent
as a patch series with two separate update steps.
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Do=
cumentation/process/submitting-patches.rst?h=3Dv6.9-rc5#n81

* Deletion of inappropriate function calls

* Optimisation of exception handling



How do you think about to refer to the affected function
(instead of the hint =E2=80=9Cerror handling path=E2=80=9D) in the summary=
 phrase?

Regards,
Markus

