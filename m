Return-Path: <linux-kernel+bounces-66911-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0935F856381
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 13:44:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 219DB1C2372C
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 12:44:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7D8D12DD83;
	Thu, 15 Feb 2024 12:44:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="QqDoWKPq"
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C327712AACB;
	Thu, 15 Feb 2024 12:44:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708001058; cv=none; b=ej2Xsv7gzKvqNq3b4wIkVJHSdi+BfG5kmScJ6d+VuJf2f+XydT/Th0gITX7rVxYFX8L0miW/8Nrue1vd9XSKbHeJPvQlSwGNioROpXLcE9GEWY16CiTqQT1bH+dAm2Nrr30wFttd5MAsfp7r9X8F1bkw6fHIBUsEZBls6g6ULlo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708001058; c=relaxed/simple;
	bh=r1FxEu7xC45zbK6jeor2QIQRLZj0KW7OA0dTG6OjJEQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qGg450sc2ZBhHrl34UxVijoFIwJfcdwOkypxGYJXR0Ckmfn52wf+OFyiruNANZ5vDdrek/Gjtj5Vm0nOF5yN4uN/HAN6NqyJDEhtkNfqNQmODx0ArWhGPD0gMh5zREzybtp3jJioHmf4TzbUotODheR+8QzFxu0pNuzmQzVS7Vo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=QqDoWKPq; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41FCgsA0004998;
	Thu, 15 Feb 2024 12:44:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=r1FxEu7xC45zbK6jeor2QIQRLZj0KW7OA0dTG6OjJEQ=;
 b=QqDoWKPqye//nidmakhAh/uu47+gWQXWCa+JjfskzZsqAjcTh3hE4wW871vboFLsghcH
 /BXyDgUviSCS9Pp5nICJSZEl4JEihmoCeDvq4t7gL+QnR8yjVfecVsDTWiT/n/55b7K0
 XepwpDAzlO76DwnUYbgypZMl5QL1SVBiV+bSlNVmU7xHxH762XuKXnPkdeTcB4YqGTin
 mToz7exhsU9i3eIJvof/IjcnVAjA0OTdx3gKPQ5qSd0a/jqjvNiQgfx3kkTOWYwk3+bS
 +G4WoBm0BFjhrELi9VTG03NyrGo6zpQOlbJPiUL9lLxFwgZFP+BkcW94diG9Zt1PxMiM Kw== 
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3w9juvr0qk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 15 Feb 2024 12:44:14 +0000
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 41FA0TmG032605;
	Thu, 15 Feb 2024 12:44:13 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 3w6kftvww5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 15 Feb 2024 12:44:13 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 41FCi8Rh18088480
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 15 Feb 2024 12:44:10 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4E29F2005A;
	Thu, 15 Feb 2024 12:44:08 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1FB942004F;
	Thu, 15 Feb 2024 12:44:08 +0000 (GMT)
Received: from li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com (unknown [9.155.204.135])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Thu, 15 Feb 2024 12:44:08 +0000 (GMT)
Date: Thu, 15 Feb 2024 13:44:06 +0100
From: Alexander Gordeev <agordeev@linux.ibm.com>
To: Alexandra Winter <wintera@linux.ibm.com>
Cc: Thorsten Winkler <twinkler@linux.ibm.com>, linux-s390@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net/iucv: fix the allocation size of iucv_path_table
 array
Message-ID: <Zc4HFotndpEHAnjb@li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com>
References: <20240214163240.2537189-1-agordeev@linux.ibm.com>
 <9b93b9c0-4b0f-4654-b9e6-4fc045cb6817@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9b93b9c0-4b0f-4654-b9e6-4fc045cb6817@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: kSf-l5Lh_exKnladEW-Evr_FwHX0R--F
X-Proofpoint-ORIG-GUID: kSf-l5Lh_exKnladEW-Evr_FwHX0R--F
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-15_11,2024-02-14_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 phishscore=0
 mlxscore=0 adultscore=0 bulkscore=0 mlxlogscore=510 impostorscore=0
 clxscore=1015 malwarescore=0 suspectscore=0 priorityscore=1501
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402150101

On Thu, Feb 15, 2024 at 09:30:39AM +0100, Alexandra Winter wrote:
> Reviewed-by: Alexandra Winter <wintera@linux.ibm.com>

Thank you, Alexandra.

> Good catch, thank you.
> As we allocate a more than we need, I don't this
> needs to be backported to stable. Do you agree?


Frankly, I do not know. It does not hurt and if it is a matter of
few bytes, I would not bother.

Thanks!

