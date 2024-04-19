Return-Path: <linux-kernel+bounces-151432-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AAF828AAECA
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 14:46:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 334BBB222BE
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 12:46:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B3D8128362;
	Fri, 19 Apr 2024 12:46:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="CczZO4ya"
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39CD17F7C7;
	Fri, 19 Apr 2024 12:45:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713530762; cv=none; b=SklA3/KSukqAsD1g24UELQSrIpDijkpk1RIlTZzzkr73mHwRT1B47XLrdM8pLwEM4+xFu9awnvlmkdT3ggaRe1oVN6oMiaxiZr4MLml2h7G8S+AQVDvurk0XS/hjEkMvmCKLqbbv7AxhSyauuiD5xNaTLtATBseBVXzP6748CaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713530762; c=relaxed/simple;
	bh=OMaHKk8t8LEdVTTsMeE2nM3fij2IhQCS7yN4v4SA/1I=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=LXAWGrKRl9y//gWIaFGynd7pfrbcoQaBvVKYxDdzc8HmCFZreG2mpyyAz4Cj8WWIsfgOoOrr8z+tEe26kUrwO/nLEmjD8K9nbJvuWhMgs9okDW1ZTqRUuz8gHzUAomSynD7Zf6jlgYzwKftYS+mvKAlGrk0r+ls7cf2WC2d78Dw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=CczZO4ya; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 43JCiMmd017734;
	Fri, 19 Apr 2024 12:45:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : reply-to : to : cc : date : in-reply-to : references : content-type
 : mime-version : content-transfer-encoding; s=pp1;
 bh=+CrSGVTTFSyh+0AYRUWPdbxc3c984cPMqgN1EpYlOB4=;
 b=CczZO4yaUK67gdUK1ITRDkHuQiJbsDk4j36G9NNcu5Cn7bhQtZ9IszcIdz97qjc9E22l
 ZhAIJ4JSC1hn5kRWfZqE6MA4Ly0lQ8zdyXrlEYoPdFsyoATzxKRPS52uX9QHB/YbcgBT
 OvucVN+jGKDAbrVPg5O9ix6P/dytdHXbRfDcZ/meXPpoqZJGSoFWknI3CdRA25NgXLMB
 xWv5bM8/UyLTmiK2nFsxxSUcAf+HgNUr+6UANanweHoiNco0vBj7ekTGbkq2UQlbxGv3
 pwDTFZM3fm3cdvD7zRDY+/u2ravsng5vv/fQX92iufGpVsej4nIFU7Dx9Qe+f32fvxQd Lg== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3xkruqg08d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 19 Apr 2024 12:45:55 +0000
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 43JCjsB5019552;
	Fri, 19 Apr 2024 12:45:54 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3xkruqg089-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 19 Apr 2024 12:45:54 +0000
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 43JCFUuK010526;
	Fri, 19 Apr 2024 12:45:54 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3xkbmm3ma9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 19 Apr 2024 12:45:54 +0000
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com [10.241.53.101])
	by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 43JCjptM28246754
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 19 Apr 2024 12:45:53 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 727F458062;
	Fri, 19 Apr 2024 12:45:51 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E9BFC5805A;
	Fri, 19 Apr 2024 12:45:49 +0000 (GMT)
Received: from lingrow.int.hansenpartnership.com (unknown [9.67.0.28])
	by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 19 Apr 2024 12:45:49 +0000 (GMT)
Message-ID: <cd505cc611db537c1ecfab8a35e43ba9e1e28171.camel@linux.ibm.com>
Subject: Re: [PATCH] scsi: qla2xxx: Use -EIO in qla_get_tmf()
From: James Bottomley <jejb@linux.ibm.com>
Reply-To: jejb@linux.ibm.com
To: Markus Elfring <Markus.Elfring@web.de>, linux-scsi@vger.kernel.org,
        kernel-janitors@vger.kernel.org,
        GR-QLogic-Storage-Upstream@marvell.com,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Nilesh Javali
 <njavali@marvell.com>
Cc: LKML <linux-kernel@vger.kernel.org>
Date: Fri, 19 Apr 2024 08:45:48 -0400
In-Reply-To: <18be23bd-415e-4030-8035-d1f180cdca7a@web.de>
References: <18be23bd-415e-4030-8035-d1f180cdca7a@web.de>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: c3VLcOXeB-MS_GU2ZZtpLn1RLqTuimcd
X-Proofpoint-GUID: q-z0rHhkmaTtsWL_lJajXG_95dBh8k-9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-19_08,2024-04-19_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 suspectscore=0
 lowpriorityscore=0 priorityscore=1501 adultscore=0 bulkscore=0
 clxscore=1011 impostorscore=0 spamscore=0 phishscore=0 malwarescore=0
 mlxlogscore=554 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2404010000 definitions=main-2404190095

On Fri, 2024-04-19 at 14:34 +0200, Markus Elfring wrote:
> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Fri, 19 Apr 2024 14:24:56 +0200
> 
> Add a minus sign before the error code “EIO”
> so that a negative value will eventually be returned
> as in another error case.

No it won't.  If you look how it's used the consumer doesn't pass on
the error.

James


