Return-Path: <linux-kernel+bounces-96330-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C2085875A4F
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 23:32:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 61A5E1F22AFA
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 22:32:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9F861DFF5;
	Thu,  7 Mar 2024 22:32:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="MDJVHqRc"
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4133DEAC5;
	Thu,  7 Mar 2024 22:32:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709850751; cv=none; b=JVhJcc/84zSWjxTPYXu5Y8DI+yW8EeCZNwT5YE2NGX/cduSCCiBtC8EJq6HPdBA1NIMTM1fIuBSHqlcg7wAknwVUFzlWf9ec2wk7AzFLTHX0KS0ZfkN3WoQgYou7B2+p5t2+HLZ5fEpx5QTrzIvv8VHanL0CO4DaqizqxtuFsLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709850751; c=relaxed/simple;
	bh=u4cpstnscbWR8dmXfx6Sy/c8Zz7Bb/PV+G7RDLhBWfg=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=TnKYXbrhQKXF3OJlxicEke0bIGTW+OSG+LKBCMM77vdKH/1Cvq218U1IncAgR20eoKy9JJQ5ASevy84hNgivfmxkKAKTFPmOFhxHpVmb9VkQAd04Sal/80D9z3VlItN7MplxFXyRtMv9LWn4RS1diCtfIBfU3IxVIyIeDpsv7gE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=MDJVHqRc; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353722.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 427MP8Sl014312;
	Thu, 7 Mar 2024 22:32:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=7KJaeb4WPG6XTg1zWaL5lAvmQqbTahirLRchW6PR/yY=;
 b=MDJVHqRctt51+2y8MPZus1Qbz/yn3RdldHAVOpXwDxJOT1u7VQpZ08spXwcrc/7toSAE
 PSUyVJzhg64pAAToBic4Q1nyQj53YqqcG2vq2TpoRSTWIYgb0OyuzT6b0Qmu2q5CT4Am
 CvVRVdV9xvFdn2wZqpc0f5rXtwwAhkbeHfxRbep0NgoGwBgRSRSWAhwD6O/31JxNDqU+
 frv/qNJQS3SWhtbDW8jIZlP2V6xn6glDAG3L3f4vjVa2PhtMZ2aRUC/GxkgwxeWe700H
 wHmtIrsxqw/zcdNDSJjag7jy1cmvNbMenNR0jyDfmBZaQdCRdnQiwMaMVlX80EacFfMo 9A== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wqpbtr4u2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 07 Mar 2024 22:32:16 +0000
Received: from m0353722.ppops.net (m0353722.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 427MQIcl016977;
	Thu, 7 Mar 2024 22:32:15 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wqpbtr4th-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 07 Mar 2024 22:32:15 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 427LARAX024211;
	Thu, 7 Mar 2024 22:32:15 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3wpjwskx2e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 07 Mar 2024 22:32:15 +0000
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com [10.39.53.232])
	by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 427MWBuk30343646
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 7 Mar 2024 22:32:14 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C67F558059;
	Thu,  7 Mar 2024 22:32:11 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CB2F658063;
	Thu,  7 Mar 2024 22:32:10 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
	by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  7 Mar 2024 22:32:10 +0000 (GMT)
Message-ID: <38981112-9091-46d4-a815-8a5f47e15bb2@linux.ibm.com>
Date: Thu, 7 Mar 2024 17:32:09 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] Preserve TPM log across kexec
Content-Language: en-US
To: Rob Herring <robh@kernel.org>
Cc: mpe@ellerman.id.au, linux-integrity@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        jarkko@kernel.org, rnsastry@linux.ibm.com, peterhuewe@gmx.de,
        viparash@in.ibm.com
References: <20240306155511.974517-1-stefanb@linux.ibm.com>
 <b6f74cd0-d1c8-4a6f-a05d-364595c5b079@linux.ibm.com>
 <20240307214245.GA3110385-robh@kernel.org>
From: Stefan Berger <stefanb@linux.ibm.com>
In-Reply-To: <20240307214245.GA3110385-robh@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: Gfox5Ao2_x58Z2tumrcR_iJRlYjt0JFa
X-Proofpoint-ORIG-GUID: z6y-P8Opt4OzWbVuDpYT0M4qYmYm-6dZ
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-07_17,2024-03-06_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 phishscore=0
 lowpriorityscore=0 bulkscore=0 spamscore=0 malwarescore=0 mlxscore=0
 mlxlogscore=858 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2311290000 definitions=main-2403070162



On 3/7/24 16:42, Rob Herring wrote:
> On Wed, Mar 06, 2024 at 11:08:20AM -0500, Stefan Berger wrote:
>>
>>
>> On 3/6/24 10:55, Stefan Berger wrote:
>>> This series resolves an issue on PowerVM and KVM on Power where the memory
>>> the TPM log was held in may become inaccessible or corrupted after a kexec
>>> soft reboot. The solution on these two platforms is to store the whole log
>>> in the device tree because the device tree is preserved across a kexec with
>>> either of the two kexec syscalls.
>>>
>> FYI: This was the previous attempt that didn't work with the older kexec
>> syscall: https://lore.kernel.org/lkml/4afde78d-e138-9eee-50e0-dbd32f4dcfe0@linux.ibm.com/T/#m158630d214837e41858b03d4b025e6f96cb8f251
> 
> Doesn't everyone else still need that? Is powerpc the only ones that
Are you referring to the old series with 'that' ? I more or less had to 
abandon it because it wouldn't solve the problem for the old kexec 
syscall, so that's why I am embedding the whole log now in the 
devicetree since the DT is properly carried across the kexec soft reboot 
on PowerVM and KVM for Power. Maybe other platforms will (have to) 
follow, but I don't know.

> care about the old kexec syscall?
> 
> Rob

