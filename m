Return-Path: <linux-kernel+bounces-109533-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 13032881A9E
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 02:20:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 36EA41C20E0A
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 01:20:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3DBE1FA2;
	Thu, 21 Mar 2024 01:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="d0MBLGU9"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 536B4811;
	Thu, 21 Mar 2024 01:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710984007; cv=none; b=XaSatWESCGqXeba/VytSZpdoqeJZEtjQr2G1A65AoC2XzHQ2zjhRsTlOB5XsMjIu0xO8GbQKV4hTMOgGB7jQuNTqTVYBxSQ57DYiAlfVdCh6InvYHGvEwKp4sULgd4yloElFmWndzYq5VGo79q7FZnBgNQPEpCFlH8HHUPezJfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710984007; c=relaxed/simple;
	bh=RsNA/5JZKebCm6fRja9FmKgCaXXHLp5WhpCmkZu+xNw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:Mime-Version; b=jHxY4m3on7JRxyMzb9aLB+X+orG0yzTnwQLjsLSO/HEYo22ecunrxNZZhh/b0p6uMxSL9Ov8Ux9PQJsNy0qYrG+C3/T3FEEBLBBki2PtToCrx4o7pVreh+ncD0VyLB990JVAqr8CCrukTvyb8BRwpp/wSanZNlGT5QHzk+mpXUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=d0MBLGU9; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353728.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 42L0Ym7b006617;
	Thu, 21 Mar 2024 01:19:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=KqJFUYVMHiOldIb0TF5vITt6dEK34rJkS96KxpU6txs=;
 b=d0MBLGU93kXYjugHUEUli3MmgToKh6lc1NA7DaLB0N0G+fcRbT5lMx4GHwOzcSiCflDs
 avVE6ME9Dem6Ixn6wlSmVSAIYrPYTuZ2OZLbsIdO6De1+0thioyy0+5sp5llgzEGgkuG
 nlv81a+ajzI3u5BoJvIvPujdj3Hskbrw6cJUAmFXMzPFSakJLZzHo42tpM4CEWz69Q1W
 r+MNDmZTnXMxYQoHV9cXo3e9W5uOs5rlW8OJwQRk4rxjsL7yuccWjpLopMGC7h2f8h1k
 C+l2EgQaNzJCRXK0leJfbvN4yOVeFS+YzMYol4/WUVi5F2tlTMr39P3Gb8rwnKyCZvNH KA== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3x05ts8kg8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 21 Mar 2024 01:19:42 +0000
Received: from m0353728.ppops.net (m0353728.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 42L1JfTt015814;
	Thu, 21 Mar 2024 01:19:41 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3x05ts8kg6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 21 Mar 2024 01:19:41 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 42L0N4cV011582;
	Thu, 21 Mar 2024 01:19:40 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3wwq8m9tyt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 21 Mar 2024 01:19:40 +0000
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com [10.241.53.101])
	by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 42L1JbYH45220162
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 21 Mar 2024 01:19:39 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 679525805C;
	Thu, 21 Mar 2024 01:19:37 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B3C9F58051;
	Thu, 21 Mar 2024 01:19:36 +0000 (GMT)
Received: from li-5cd3c5cc-21f9-11b2-a85c-a4381f30c2f3.ibm.com (unknown [9.61.94.57])
	by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 21 Mar 2024 01:19:36 +0000 (GMT)
Message-ID: <bbae0060d6ed7a0b033dc07e8d26c9d68585080b.camel@linux.ibm.com>
Subject: Re: [PATCH][next] integrity: Avoid -Wflex-array-member-not-at-end
 warnings
From: Mimi Zohar <zohar@linux.ibm.com>
To: "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Roberto Sassu
 <roberto.sassu@huawei.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        Eric Snowberg <eric.snowberg@oracle.com>,
        Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>
Cc: linux-integrity@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
        Kees Cook
	 <keescook@chromium.org>
Date: Wed, 20 Mar 2024 21:19:36 -0400
In-Reply-To: <ZeYKWrXvACBBrAP8@neat>
References: <ZeYKWrXvACBBrAP8@neat>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-23.el8_9) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: _y9Apma0B-Un1vvdG49kx4BrQis0celO
X-Proofpoint-ORIG-GUID: 4-rXkoYoiEkQ1CnyscYFsfX3nWOJ-4rL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-20_14,2024-03-18_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 bulkscore=0
 phishscore=0 adultscore=0 mlxscore=0 spamscore=0 mlxlogscore=956
 impostorscore=0 priorityscore=1501 clxscore=1011 suspectscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2403140000 definitions=main-2403210007

Hi Gustavo,

Sorry for the delay...

On Mon, 2024-03-04 at 11:52 -0600, Gustavo A. R. Silva wrote:
> -Wflex-array-member-not-at-end is coming in GCC-14, and we are getting
> ready to enable it globally.
> 
> There is currently an object (`hdr)` in `struct ima_max_digest_data`
> that contains a flexible structure (`struct ima_digest_data`):
> 
>  struct ima_max_digest_data {
> 	struct ima_digest_data hdr;
>         u8 digest[HASH_MAX_DIGESTSIZE];
>  } __packed;
> 
> So, in order to avoid ending up with a flexible-array member in the
> middle of another struct, we use the `struct_group_tagged()` helper to
> separate the flexible array from the rest of the members in the flexible
> structure:
> 
> struct ima_digest_data {
>         struct_group_tagged(ima_digest_data_hdr, hdr,
> 
> 	... the rest of the members
> 
>         );
>         u8 digest[];
> } __packed;
> 
> With the change described above, we can now declare an object of the
> type of the tagged struct, without embedding the flexible array in the
> middle of another struct:
> 
>  struct ima_max_digest_data {
>         struct ima_digest_data_hdr hdr;
>         u8 digest[HASH_MAX_DIGESTSIZE];
>  } __packed;
> 
> We also use `container_of()` whenever we need to retrieve a pointer to
> the flexible structure.

Nice!

> 
> So, with these changes, fix the following warnings:
> 
> security/integrity/evm/evm.h:45:32: warning: structure containing a flexible
> array member is not at the end of another structure [-Wflex-array-member-not-
> at-end]
> security/integrity/evm/evm.h:45:32: warning: structure containing a flexible
> array member is not at the end of another structure [-Wflex-array-member-not-
> at-end]
> security/integrity/evm/evm.h:45:32: warning: structure containing a flexible
> array member is not at the end of another structure [-Wflex-array-member-not-
> at-end]

A similar change would need to be made to struct evm_digest:

struct evm_digest {
        struct ima_digest_data hdr;
        char digest[IMA_MAX_DIGEST_SIZE];
} __packed;

Is there are another patch?

Mimi

> 
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
> 


