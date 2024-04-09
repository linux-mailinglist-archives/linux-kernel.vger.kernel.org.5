Return-Path: <linux-kernel+bounces-137647-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A52B89E4F9
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 23:30:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D87A3281D30
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 21:30:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BF07158A1B;
	Tue,  9 Apr 2024 21:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="imq1dgdM"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40078158878;
	Tue,  9 Apr 2024 21:30:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712698224; cv=none; b=umUqxK/JImevp6oV6Z+HT02T+rbeynaC0fvQMT3W8i7BL4Q9YUgKW4A+fFuktPbeM3SNXECOP/qcAOSuO5Wz6IT2G/1lbOfpztqQoSq8p7v168iT8JaRBdRUuilkHAcK36W0R8yuNIxukubBwrQJcgXKEASTdTQoWqS+TvmbZ5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712698224; c=relaxed/simple;
	bh=QRV/Zb+ly7i9pgKEj1ZMeVmuwUAc36lVzMrvbf+R6ZQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=dasIRRmbzcKVsL40+fpLnQDQQZVTQasYRQmKUm+P6+zLMGElM4Aaqe3mIF4p0Whg927A/9trCBxSAEhJAmAfXtd2bi998LdhpA/IlDB0Ti2nhAGVqSioh0i+8669Dt2s8SN4lHETSu3eGdX17HXjnlNmMlcYIcVXJtQG5ugPT9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=imq1dgdM; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353726.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 439LOJGS018910;
	Tue, 9 Apr 2024 21:29:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=96pJxP6pETz15iq1+bZgYkpINBYsGWNv4yDJqnirgIs=;
 b=imq1dgdMuYZU3TREMdr+qzdKlhWLMjPW3E8qWs3JXiNnfDW/i6a4bUgAHwzHWo1cx8MJ
 EhID8TVhjNQ7MULkGQU4sBnC/YjB22D6bycJfSViSwbhrqhQ03A5VtL8p6Jxvkl2DKsl
 KlDpozZmT8WJERc0FlcUl+IaiIQvQan3YvGcq+BOG3zNWVMKFjW17wZ0FP1VT7/LO3vy
 FFpgP1y+/tNG+YXZ8lxSjvUhEQG/87KDNUt1oh9JDL2CJeGaLU8zzWtH0mdZkL+LsJ5u
 TiqqnkRnRpTXdXcEXFOAIP/0wqG6mYivSe3+pwtS/CGOkoMTiZyHy/cMebCz/bnDhT5G rw== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3xdc9jg5bu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 09 Apr 2024 21:29:58 +0000
Received: from m0353726.ppops.net (m0353726.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 439LTvv4027805;
	Tue, 9 Apr 2024 21:29:57 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3xdc9jg5bt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 09 Apr 2024 21:29:57 +0000
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 439KIUFt022564;
	Tue, 9 Apr 2024 21:29:56 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3xbhqp0vht-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 09 Apr 2024 21:29:56 +0000
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com [10.241.53.102])
	by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 439LTrBk38535542
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 9 Apr 2024 21:29:55 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5BFCA58063;
	Tue,  9 Apr 2024 21:29:53 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 923FA58056;
	Tue,  9 Apr 2024 21:29:52 +0000 (GMT)
Received: from li-5cd3c5cc-21f9-11b2-a85c-a4381f30c2f3.ibm.com (unknown [9.61.188.131])
	by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  9 Apr 2024 21:29:52 +0000 (GMT)
Message-ID: <da46b1105f294df78535f1f5b6833cd8e2a4262e.camel@linux.ibm.com>
Subject: Re: [PATCH v3 00/10] evm: Support signatures on stacked filesystem
From: Mimi Zohar <zohar@linux.ibm.com>
To: Stefan Berger <stefanb@linux.ibm.com>, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-unionfs@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, paul@paul-moore.com, jmorris@namei.org,
        serge@hallyn.com, roberto.sassu@huawei.com, amir73il@gmail.com,
        brauner@kernel.org, miklos@szeredi.hu
Date: Tue, 09 Apr 2024 17:29:52 -0400
In-Reply-To: <20240223172513.4049959-1-stefanb@linux.ibm.com>
References: <20240223172513.4049959-1-stefanb@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-23.el8_9) 
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 4OPDvHSEV7UuX3UR8ykomoVFtY88C32A
X-Proofpoint-GUID: NTCCHltqIjanuGsxaH9U6_zCXoa4C0V0
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
 definitions=2024-04-09_12,2024-04-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 adultscore=0
 lowpriorityscore=0 suspectscore=0 impostorscore=0 malwarescore=0
 priorityscore=1501 clxscore=1015 phishscore=0 bulkscore=0 spamscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2404010000 definitions=main-2404090145

On Fri, 2024-02-23 at 12:25 -0500, Stefan Berger wrote:
> EVM signature verification on stacked filesystem has recently been
> completely disabled by declaring some filesystems as unsupported
> (only overlayfs). This series now enables copy-up of "portable
> and immutable" signatures on those filesystems and enables the
> enforcement of "portable and immultable" as well as the "original"
> signatures on previously unsupported filesystem when evm is enabled
> with EVM_INIT_X509. HMAC verification and generation remains disabled.
> 
> "Portable and immutable" signatures can be copied up since they are
> not created over file-specific metadata, such as UUID or generation.
> Instead, they are only covering file metadata such as mode bits, uid, and
> gid, that will all be preserved during a copy-up of the file metadata.
> 
> This series is now based on the 'next' branch of Paul Moore's LSM tree and
> requires the following two commits from the vfs.misc branch of the vfs git
> repo at https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
> 
> commit 2109cc619e73 ("fs: remove the inode argument to ->d_real() method")
> commit c6c14f926fbe ("fs: make file_dentry() a simple accessor")

Thanks, Stefan.  The patch set is now queued in the next-integrity branch.
https://git.kernel.org/pub/scm/linux/kernel/git/zohar/linux-integrity.git/

Mimi


