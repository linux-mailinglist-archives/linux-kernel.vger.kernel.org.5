Return-Path: <linux-kernel+bounces-46671-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CC5708442BD
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 16:12:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AE96EB3206A
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 15:02:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E87412DDB5;
	Wed, 31 Jan 2024 14:55:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="JZizRkAf"
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 809E678B58;
	Wed, 31 Jan 2024 14:55:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706712933; cv=none; b=W/peFHMJ3rQqPGhAlkuz8/xS2/j9A7eLR7FPJeW1WPLEpXy/loVPA5MLpr6tIGX4t7ZeeAYvJIA81xq+MFvvmvqmyXOa7wQpl5ha/mAl4ZHty8Ou9tLk7SWxvsBJp7/Ge13ppixF4wMMk8lFB9PCvPxOCiLjrtrlcQtHcaSHsxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706712933; c=relaxed/simple;
	bh=j43exEgynH+hrdT6l5Mc26Soi5YL7PII8LJE6SllSvE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Zn0Mr/mdT7hV6YiPUM9DE9UxHT+Z6BUc3wGyh1d0pwxSmX+uqFbvYQ9v5+4c3Cr92p4sY36o1R6qkNiuDL+8aCzMp5+bB8uLGB+v4moRAMOA1XtT4Ay7+7akif8B6ocSN2kOdHz0ZqRGBRmHXyS5owvlsPgLMHh2eyGeiKX41kQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=JZizRkAf; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353723.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 40VEaOhW018873;
	Wed, 31 Jan 2024 14:55:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=m8oPPpBE9/jjxHLvwdInXhrtC8tJ2Uj816ArhfmsDks=;
 b=JZizRkAfi3BFWpMAUpNMpY/7IMrNGZza9WWli7BC3BVcVv3zLuwIXc5AZWpZNuTPEJzF
 vOG0pexG9+iBysIqgpeYGoHe6Tv9SkuNTduXA1ZLcO/Ro9SxByr7Yh7XaiAm8T0dqvNf
 RqhvhucwHifqAL6Rjx9MMolYJnCNOCiofEoW5lArtTE9thTsjP4pasJ4ssuuTZHYj8OV
 dsKLL6enzy4xEfFH+rlLbof+Q0avCn08PTj83F/oTXL34PNnHbvUi+NI/c7sSehG3HE1
 aVUJb9Fw44pIHCh4w4nfceGvjHsYoV5inH03mgc99f/yRm2s5sTLy/ciU0JfWa+0KA0i /w== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3vyq9jt7r4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 31 Jan 2024 14:55:21 +0000
Received: from m0353723.ppops.net (m0353723.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 40VDkZKZ032594;
	Wed, 31 Jan 2024 14:55:16 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3vyq9jt7ga-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 31 Jan 2024 14:55:14 +0000
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 40VD7fpZ010884;
	Wed, 31 Jan 2024 14:52:47 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 3vwecknpad-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 31 Jan 2024 14:52:47 +0000
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com [10.39.53.233])
	by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 40VEqkYL37486934
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 31 Jan 2024 14:52:46 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5260C58054;
	Wed, 31 Jan 2024 14:52:46 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2CBE55803F;
	Wed, 31 Jan 2024 14:52:45 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
	by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 31 Jan 2024 14:52:45 +0000 (GMT)
Message-ID: <015c3a14-0d23-43ba-9593-3d4ff588f1bb@linux.ibm.com>
Date: Wed, 31 Jan 2024 09:52:44 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/5] evm: Support signatures on stacked filesystem
Content-Language: en-US
To: Amir Goldstein <amir73il@gmail.com>
Cc: linux-integrity@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-unionfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        paul@paul-moore.com, jmorris@namei.org, serge@hallyn.com,
        zohar@linux.ibm.com, roberto.sassu@huawei.com, miklos@szeredi.hu
References: <20240130214620.3155380-1-stefanb@linux.ibm.com>
 <CAOQ4uxg9VQ9LksxX5eFFg7E1VO_iFZNmNBaC3pED+a2=ixOhdw@mail.gmail.com>
From: Stefan Berger <stefanb@linux.ibm.com>
In-Reply-To: <CAOQ4uxg9VQ9LksxX5eFFg7E1VO_iFZNmNBaC3pED+a2=ixOhdw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: baJzSSSfc6NAr5gdJX5P92ig7rAHEN-1
X-Proofpoint-ORIG-GUID: 9_azz8zb9r4UUIFse6vB9B3KaEx7v_Sr
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-31_08,2024-01-31_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 clxscore=1015 spamscore=0 malwarescore=0 bulkscore=0 mlxscore=0
 priorityscore=1501 phishscore=0 adultscore=0 impostorscore=0
 suspectscore=0 mlxlogscore=976 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2311290000 definitions=main-2401310114



On 1/31/24 08:18, Amir Goldstein wrote:
> On Tue, Jan 30, 2024 at 11:46 PM Stefan Berger <stefanb@linux.ibm.com> wrote:
>>
>> EVM has recently been completely disabled on unsupported (e.g.,
>> overlayfs). This series now enables copy-up of "portable and immutable"
>> signatures on those filesystems and enables the enforcement of
>> "portable and immutable" as well as the "original" signatures on
>> previously unsupported filesystem when EVM is enabled with EVM_INIT_X509.
>> HMAC verification and generation remains disabled on those filesystems.
>>
> 
> I am missing a high level description of what is in those "portable
> and immutable"
> signatures and how those signatures remain valid across copy up.
> 

 From 2/5:
"Portable and immutable EVM signatures can be copied up by stacked file-
system since the metadata their signature covers does not include file-
system-specific data such as a file's inode number, generation, and UUID."

Instead, the signatures cover file metadata such as file mode bits, uid, 
and gid as well as xattrs, which can all be preserved unchanged across a 
copy-up.

Reference: 
https://elixir.bootlin.com/linux/v6.7.2/source/security/integrity/evm/evm_crypto.c#L169


> Thanks,
> Amir.
> 

