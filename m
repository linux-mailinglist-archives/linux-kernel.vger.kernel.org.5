Return-Path: <linux-kernel+bounces-14299-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 075FB821B0E
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 12:35:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 951D71F22809
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 11:35:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1985EAD9;
	Tue,  2 Jan 2024 11:35:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="AuRYyMVa"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7617DE572;
	Tue,  2 Jan 2024 11:35:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.vnet.ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 402BCYTw022567;
	Tue, 2 Jan 2024 11:35:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : to : cc : from : subject : content-type :
 content-transfer-encoding; s=pp1;
 bh=gs9Qiinqbf7yu2XrNTAz0gOXR9S0zfMkA9/GBX+J6AA=;
 b=AuRYyMVaERF6uOEMrelKYO7O5ST+NbmeWr5aAE6TKsu+Gc2lzVJdML9/LHX+oQvr2EXd
 FpHckmhQguhcZaCLUEoP4JfByP8kQlMEWoypSbmsfr8KgtLt4x0DqylTulnbC1YaED/w
 gq/loAtoQePpavkZaE2SxhxhGQrBBUZQzqnnf7TdLWQ4tvNaFkabrBW++k/wsjbkcehJ
 skmqaLDNlqcu37klbgDFu2DnM0qOoNb58e7NOX6RfKLUQPHLzaJZPfe8QxdJvp37q9pq
 wwUR+Rqs4zIbL8ok5xbmK3g24LH3Q+pxLemsIACS/AYyvRgV1O3h09bHSAy2IvmuVWlw XQ== 
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3vchddrdh8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 02 Jan 2024 11:35:38 +0000
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 402AEIWE017830;
	Tue, 2 Jan 2024 11:35:36 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3vawwymm44-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 02 Jan 2024 11:35:36 +0000
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com [10.241.53.104])
	by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 402BZaEP13959680
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 2 Jan 2024 11:35:36 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 34BB158052;
	Tue,  2 Jan 2024 11:35:36 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9056F58065;
	Tue,  2 Jan 2024 11:35:33 +0000 (GMT)
Received: from [9.43.79.31] (unknown [9.43.79.31])
	by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  2 Jan 2024 11:35:33 +0000 (GMT)
Message-ID: <2b1814f7-c7a2-4ea3-8bc7-abd8712ebef8@linux.vnet.ibm.com>
Date: Tue, 2 Jan 2024 17:05:31 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-next@vger.kernel.org" <linux-next@vger.kernel.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
Cc: "abdhalee@linux.vnet.ibm.com" <abdhalee@linux.vnet.ibm.com>,
        "mputtash@linux.vnet.com" <mputtash@linux.vnet.com>,
        "sachinp@linux.vnet.com" <sachinp@linux.vnet.com>
From: Tasmiya Nalatwad <tasmiya@linux.vnet.ibm.com>
Subject: [Mainline/linux-next-netdev/net-next/scsi]Dlpar remove, drmgr phb and
 pci remove operations are failing
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: JbG6rU-2UqTSb0FpKaEtMEEgl9-OSqIM
X-Proofpoint-ORIG-GUID: JbG6rU-2UqTSb0FpKaEtMEEgl9-OSqIM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-02_02,2024-01-02_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 suspectscore=0
 bulkscore=0 phishscore=0 priorityscore=1501 lowpriorityscore=0
 impostorscore=0 clxscore=1011 mlxscore=0 spamscore=0 mlxlogscore=834
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2401020088

Greetings,

  [Mainline/linux-next-netdev/net-next/scsi]Dlpar remove, drmgr phb and 
pci remove operations are failing

command ---> chhwres -r io --rsubtype slot -m "managed system name" -o r 
--id 6 -l 21030014

output --->

HSCL2929 The dynamic removal of I/O resources failed: The I/O slot 
dynamic partitioning operation failed.  Here are the I/O slot IDs that 
failed and the reasons for failure:

Jan 02 02:20:22 caDlparCommand:execv to drmgr
Validating PHB DLPAR capability...yes.
Could not find drc index 0x20000014 to add to phb list
There are no DR capable slots on this system
Could not find PHB PHB 20



The OS return code is 3.

-- 
Regards,
Tasmiya Nalatwad
IBM Linux Technology Center


