Return-Path: <linux-kernel+bounces-98931-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 44BBE878131
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 15:02:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 767801C22875
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 14:02:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72D0033CCD;
	Mon, 11 Mar 2024 14:02:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="pWMWeKlh"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F0B83EA64;
	Mon, 11 Mar 2024 14:02:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710165735; cv=none; b=l43MEotG/czXja+6fQAqwGveEpLGlclxIROr2qouHRsGkcZTTGDtwm4Em4+LWPFfUuVypounczURAYyo4tsNOIGVZO/p0lgSRp2dnYEv8Y2Hb1/a5cJKnlhFhTXrDoh58gVQjF+CaMK00MRBQntDQClOaUxP6fGcKz2Z9qAK+HM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710165735; c=relaxed/simple;
	bh=IiDhdI0p6YSxPuGncTwB9Q4x26gQ/GNeSvzVzFtOYo0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:Mime-Version; b=dmdIxQSJhY2wxChFyS8c8lsBuETWMewS4nFTbaejuBK+KQ3QuWygu/4tMI1iuocW4P/HrfbEVyGd01hwzTIC+EuWvilsyLjWqCCyDaQ9J/RcxG+zVUoI0yzI6soISdj0Y8VPFc1DN5TUrdwaU4EsC7qUThqSF/XoQDqRNPxzcXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=pWMWeKlh; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353728.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 42BDxHE1019090;
	Mon, 11 Mar 2024 14:00:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=IiDhdI0p6YSxPuGncTwB9Q4x26gQ/GNeSvzVzFtOYo0=;
 b=pWMWeKlhKfTBmXU86QnOWcvve9X+RB+TrreYeaBWbEHMLIyS08/kPVEkiPBjdLTRw7qg
 bANrdBJtcyrZk6GDQcGsCbEwXPDlXoYIW9Z7/2senJQxiUQueIxKjcivgbYp814nGuDk
 gRBEWo5eULJQuA/9yRvTrH3JzyMFUzK5K4N5twanXJ4al9ya00qOyRpT3ltIQbUYgtJC
 a9LSS3JJB+rAdh0qqi9xWpefrhu2BOlzUDVJXmago3Y8ct58JW/tOa8Cuh48SWYy3Bt9
 M48VYZHHMRAZjysFT8JI5snR58IGRkU5uI1p7J1jDABhGp7GLwEQWkqyvZsypLr3wK2P yQ== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wt2mrh69s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 11 Mar 2024 14:00:51 +0000
Received: from m0353728.ppops.net (m0353728.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 42BDxxv2022576;
	Mon, 11 Mar 2024 14:00:51 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wt2mrh66s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 11 Mar 2024 14:00:50 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 42BDwfoM020496;
	Mon, 11 Mar 2024 14:00:47 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3ws3kkrqtc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 11 Mar 2024 14:00:47 +0000
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com [10.39.53.231])
	by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 42BE0jsE24183328
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 11 Mar 2024 14:00:47 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4DC2658063;
	Mon, 11 Mar 2024 14:00:45 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0D9EB58060;
	Mon, 11 Mar 2024 14:00:43 +0000 (GMT)
Received: from li-5cd3c5cc-21f9-11b2-a85c-a4381f30c2f3.ibm.com (unknown [9.61.133.174])
	by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 11 Mar 2024 14:00:42 +0000 (GMT)
Message-ID: <7f486a5d3b6ac6c1af3974975888d0383b5826c6.camel@linux.ibm.com>
Subject: Re: [RFC][PATCH 5/8] ima: Record IMA verification result of digest
 lists in digest cache
From: Mimi Zohar <zohar@linux.ibm.com>
To: Roberto Sassu <roberto.sassu@huaweicloud.com>, corbet@lwn.net,
        dmitry.kasatkin@gmail.com, eric.snowberg@oracle.com,
        paul@paul-moore.com, jmorris@namei.org, serge@hallyn.com
Cc: linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-integrity@vger.kernel.org, linux-security-module@vger.kernel.org,
        wufan@linux.microsoft.com, pbrobinson@gmail.com, zbyszek@in.waw.pl,
        hch@lst.de, mjg59@srcf.ucam.org, pmatilai@redhat.com, jannh@google.com,
        dhowells@redhat.com, jikos@kernel.org, mkoutny@suse.com,
        ppavlu@suse.com, petr.vorel@gmail.com, petrtesarik@huaweicloud.com,
        mzerqung@0pointer.de, kgold@linux.ibm.com,
        Roberto Sassu <roberto.sassu@huawei.com>
Date: Mon, 11 Mar 2024 10:00:42 -0400
In-Reply-To: <20240214143525.2205481-6-roberto.sassu@huaweicloud.com>
References: <20240214143525.2205481-1-roberto.sassu@huaweicloud.com>
	 <20240214143525.2205481-6-roberto.sassu@huaweicloud.com>
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
X-Proofpoint-GUID: BSm5942N8Msoz5zbZnbmekoawL09eek7
X-Proofpoint-ORIG-GUID: eD4MDpRznV5_ydSjbwCAtrPcKQ35iYcx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-11_08,2024-03-06_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 mlxscore=0
 malwarescore=0 phishscore=0 lowpriorityscore=0 clxscore=1015 spamscore=0
 priorityscore=1501 mlxlogscore=999 suspectscore=0 impostorscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2403110105

Roberto, please consider renaming this patch.

IMA is informing the digest_cache LSM of the digest_list verification result.
Instead of "ima: Record IMA verification result of digest lists in digest
cache", it should be "ima: inform digest_cache LSM of digest list verification
result".

Mimi


