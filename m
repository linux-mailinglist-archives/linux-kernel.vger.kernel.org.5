Return-Path: <linux-kernel+bounces-131168-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 65A368983FB
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 11:30:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EC3F0B20A95
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 09:30:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54B95745C2;
	Thu,  4 Apr 2024 09:29:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="OzZ8xerE"
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9342874438;
	Thu,  4 Apr 2024 09:29:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712222989; cv=none; b=X5dgYehKmJ3erKlztiNQP0cPzwA7ohofw0BUOxG7UwbzUo/4k0Wjxg+d9g1WEhZO9PgKCq/etJqAupj2DPkoox/sWX+6a3eFjP0GO+mvCLMu3rtpQ27yZxYBI/Kdu/mGCKp49pS8ejLitffTDjfN56cqXvG8wlM7dqzgMN8eg5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712222989; c=relaxed/simple;
	bh=2QnvXzbebQJrGbHL7BZuZLKSyvtQ0R8V8+Jj4+BLYXA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=sx3YOrQyxlsET/3KgnqaYfgfVH5ALyTCuqUxKXVkL2IHcAtrWoTj6yXWxQ8S7vWBZ7Ri0ne4S1hRVlustkYcvYS607R+7nUjZ6lgMmmxsgKKgIG6KfFQqqhZUvjpoItNQ+xV1j4ts1FRj24DnbtFy0FGE5Phe7fpQMqLejanGmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=OzZ8xerE; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 4349NQ05024591;
	Thu, 4 Apr 2024 09:29:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : content-transfer-encoding : mime-version; s=pp1;
 bh=fTBgcB7azCZbQ/QcIvc9v9Z7pd/0bT6XdzC9MEtuYIE=;
 b=OzZ8xerE7bCc5MUis66sswg8vhlwFUH0gyHDdnUck+jHzcpLhoLa/ZwirZw3ynIbvBKQ
 hI6aooyZ/r2765IG8Jo7Ot5cPH9OT2l0w468mg2MH2yP/Ug9pvkyNFtbgFPlT1YEw9Oi
 EiaXEnP52EwrFqMqPG9J6cW52K9AObZWVPFmBIm9zSR0pz/qDYT0mQ+kAoq/pBBrQDXG
 THkbiVhR/XRFu2OwXyxi5f15rWPThBnsrRDFD6elpWF4NXqmNBttfHTWnWD54ulRIUCb
 czRZqotXDbTSYzWyHZhsXSQb+Q2LOlO6YkFTyVYN0Uz8lDmpur9dody/RzV2UEqMEHue SA== 
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3x9sh9g0jr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 04 Apr 2024 09:29:43 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 43470nnx009109;
	Thu, 4 Apr 2024 09:29:42 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3x9epxu9rj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 04 Apr 2024 09:29:42 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4349Tac648431362
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 4 Apr 2024 09:29:38 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 812992004B;
	Thu,  4 Apr 2024 09:29:36 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 54BD520043;
	Thu,  4 Apr 2024 09:29:36 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  4 Apr 2024 09:29:36 +0000 (GMT)
From: Niklas Schnelle <schnelle@linux.ibm.com>
To: Damien Le Moal <dlemoal@kernel.org>, Niklas Cassel <cassel@kernel.org>
Cc: linux-ide@vger.kernel.org, Arnd Bergmann <arnd@kernel.org>,
        Heiko Carstens <hca@linux.ibm.com>, linux-kernel@vger.kernel.org,
        Niklas Schnelle <schnelle@linux.ibm.com>
Subject: [PATCH 0/1] ata: Handle HAS_IOPORT dependencies
Date: Thu,  4 Apr 2024 11:29:35 +0200
Message-Id: <20240404092936.3127972-1-schnelle@linux.ibm.com>
X-Mailer: git-send-email 2.40.1
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: h6slJHewhCna2YVjds5j_qF08PVAV7jj
X-Proofpoint-GUID: h6slJHewhCna2YVjds5j_qF08PVAV7jj
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
 definitions=2024-04-04_05,2024-04-04_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 priorityscore=1501 clxscore=1011 mlxscore=0 lowpriorityscore=0
 mlxlogscore=999 adultscore=0 bulkscore=0 impostorscore=0 spamscore=0
 phishscore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2404010000 definitions=main-2404040063

Hi Damien, Niklas,

This is a follow up in my ongoing effort of making inb()/outb() and
similar I/O port accessors compile-time optional. Previously I sent this
as a treewide series titled "treewide: Remove I/O port accessors for
HAS_IOPORT=n" with the latest being its 5th version[0]. With a significant
subset of patches merged I've changed over to per-subsystem series. These
series are stand alone and should be merged via the relevant tree such
that with all subsystems complete we can follow this up with the final
patch that will make the I/O port accessors compile-time optional.

The current state of the full series with changes to the remaining
subsystems and the aforementioned final patch can be found for your
convenience on my git.kernel.org tree in the has_ioport_v6 branch[1] with
signed tags. As for compile-time vs runtime see Linus' reply to my first
attempt[2].

Thanks,
Niklas

[0] https://lore.kernel.org/all/20230522105049.1467313-1-schnelle@linux.ibm.com/
[1] https://git.kernel.org/pub/scm/linux/kernel/git/niks/linux.git/log/?h=has_ioport_v6
[2] https://lore.kernel.org/lkml/CAHk-=wg80je=K7madF4e7WrRNp37e3qh6y10Svhdc7O8SZ_-8g@mail.gmail.com/

Niklas Schnelle (1):
  ata: add HAS_IOPORT dependencies

 drivers/ata/Kconfig      | 28 ++++++++++++++--------------
 drivers/ata/libata-sff.c |  4 ++++
 2 files changed, 18 insertions(+), 14 deletions(-)

-- 
2.40.1


