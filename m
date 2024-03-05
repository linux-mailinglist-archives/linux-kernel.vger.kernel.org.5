Return-Path: <linux-kernel+bounces-92345-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 30ACC871EDC
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 13:17:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4FA8A1C224B2
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 12:17:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB8395C8E5;
	Tue,  5 Mar 2024 12:15:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="qvDZjgOt"
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51A165C602;
	Tue,  5 Mar 2024 12:15:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709640929; cv=none; b=gEim7u3C+F/+ublZrm1ZwFSZ2H+ILpOBF1A5zM+TenxqzcI8NuEP1Odj7a68ka++LDd/f+pKkDHqtHPc2CyUvcPKkiifC8twTnXDpuSgtmkonSYsHF98+id52mbsnzIHnaYD/o0PMqU4+cK3bgnFXs/+pFfkmCLBxJg0DZy2p3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709640929; c=relaxed/simple;
	bh=8XVY4yDvTbI92l/7aGIsmQNytdvsX7b8EhXWeJNDsv8=;
	h=Message-ID:Subject:From:To:Cc:Date:Content-Type:MIME-Version; b=bS7R6XMt7+spS6USlYWcRIQNALP1nVgMtlc4fjuU2PKjTqEmpR/ceKkUYvtfunfvW21PlL+knGAKRD3uYi9yYj/MKQXK5oEfHh1d+2Ifa69ccuCoBZtttmV/X6rQFxrYBZwCm3fnLb20YOZFmUmA3TBjfGFj1lKYAjekL+4nHAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=qvDZjgOt; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353723.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 425C2x3L007898;
	Tue, 5 Mar 2024 12:15:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : content-type : content-transfer-encoding :
 mime-version; s=pp1; bh=2B5vC5/EsMpHo+R4RtClTfGr+IYp86B+aXqVoME+TRQ=;
 b=qvDZjgOtR446fZ6q9smD4Dwrtw7aCimSQGxIHRYO354t2Al9/a3Gt/Mg+dRYf9rtyqVO
 Kw8HyzWZTWSh9BKetx2ukrDddo/YDgOfx7yLPw4Bfa/PknXJwgu72xqe+lChPQ9zEFjl
 YyCxxLW0AH0ExkRJCKhw4AackBSvesQqKxGXt0kwoBiv4s7NMnqMXKf7P6BRqcpaqY89
 dsa2cVdfdJmMQ2ZHgPjnMLMe69TOW0N2zlm0C4U20kkDqzdYE7EEN/Cc/p/23nT+y3Pj
 RZEePT3QCUEBVFQ2I4ecXYOrgNAW4bav1kRWKuMRydZKSj1LKAWB+E7w9HrUguuqKFDj hw== 
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wp3248dr4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 05 Mar 2024 12:15:19 +0000
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 425A5gF4025387;
	Tue, 5 Mar 2024 12:15:19 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3wmetyfhr4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 05 Mar 2024 12:15:19 +0000
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com [10.241.53.101])
	by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 425CFGat30998952
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 5 Mar 2024 12:15:18 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 864A95806F;
	Tue,  5 Mar 2024 12:15:16 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3B9E458051;
	Tue,  5 Mar 2024 12:15:16 +0000 (GMT)
Received: from li-5cd3c5cc-21f9-11b2-a85c-a4381f30c2f3.ibm.com (unknown [9.61.160.159])
	by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  5 Mar 2024 12:15:16 +0000 (GMT)
Message-ID: <987924a8c1e3e4e99a483e432f1418518af0b7aa.camel@linux.ibm.com>
Subject: [GIT PULL] integrity: subsystem update for v6.8-rcX
From: Mimi Zohar <zohar@linux.ibm.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-integrity <linux-integrity@vger.kernel.org>,
        linux-kernel
	 <linux-kernel@vger.kernel.org>,
        Roberto Sassu <roberto.sassu@huawei.com>
Date: Tue, 05 Mar 2024 07:15:15 -0500
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-22.el8) 
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: z5zaDE47WWQw6Y0qibrKsr02IJuVICjp
X-Proofpoint-ORIG-GUID: z5zaDE47WWQw6Y0qibrKsr02IJuVICjp
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
 definitions=2024-03-05_08,2024-03-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 adultscore=0 mlxscore=0 mlxlogscore=999 impostorscore=0 suspectscore=0
 spamscore=0 phishscore=0 priorityscore=1501 clxscore=1015 bulkscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2403050098

Hi Linus,

Here's a single fix to eliminate an unnecessary msg.

thanks,

Mimi

The following changes since commit 841c35169323cd833294798e58b9bf63fa4fa1de:

  Linux 6.8-rc4 (2024-02-11 12:18:13 -0800)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/zohar/linux-integrity.git/ tags/integrity-v6.8-fix

for you to fetch changes up to 85445b96429057d87446bcb24ec0cac9ea9c7fdf:

  integrity: eliminate unnecessary "Problem loading X.509 certificate" msg (2024-02-16 08:04:17 -0500)

----------------------------------------------------------------
integrity-v6.8-fix

----------------------------------------------------------------
Coiby Xu (1):
      integrity: eliminate unnecessary "Problem loading X.509 certificate" msg

 security/integrity/digsig.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)


