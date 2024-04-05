Return-Path: <linux-kernel+bounces-133089-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EA11899E9A
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 15:42:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 59770283FCE
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 13:42:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D48D516D4E7;
	Fri,  5 Apr 2024 13:42:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="c71Cu5Cw"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB75C59B45;
	Fri,  5 Apr 2024 13:42:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712324563; cv=none; b=rV+XKbCmHarDzHMS3LSUUguIQOCT4SN59g9a/oevZv7Lt6RYON9oUgN+2CK2GzD0SK8fnpF2B9WkLOIlNHqpgG21USuy5bONsx306WerzoxtmRNPVlPLZcnUb7nbhFgSayHKjSoSrcXW0XPcSK4yplRrkydOYB6aVOVc2oSNtCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712324563; c=relaxed/simple;
	bh=SDdvBIcKn7as+6UQJEJnhQvJgZeDe3KluWIoa8MxMMk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Vw4NGLzktmGAr04WJ0k957KqvaZryzMG5uJAPq09PSwhBi0idEv64BaEpWdgQWVE/Q7qki2oKelAdE1NpfnWOJQgtDP6ezyZXdGvjuQpvo0a+RNZ39wSN6pHMe5mTRqs40IcN9K0sltgJTK05FyATV+kgomwVgTjyJi0uEitXqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=c71Cu5Cw; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 435DRhqi017240;
	Fri, 5 Apr 2024 13:41:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : content-transfer-encoding : mime-version; s=pp1;
 bh=ur1sz8/inVs3473cndk7CPmY9sCJYefK6091WN0g5uw=;
 b=c71Cu5Cwvj2ChpAT7E7fw0vFOuJpQvQ7JDtzZeFwcWGC7n1vE8w/I//CzbEzvWsWKdyo
 i4vvU9VaRk8Kd8kftjrbvWipzAITEKuYGxHJhuOXuYzshO3JpEWOs+98JGphBttgmuZX
 9MGJ1ozgtCXhnbwDGZclu7pcplpMIePGdxQSIs83XHHeeANiOak6qO58/pqly+O0Al/L
 cYAE5HtdOMedqgXUnRWQisdE3qLgCd7+l6UXxPK5oyr9jbcXMrjdS1JH6vPrS8K+AHB6
 EPjodk/iBJVVpE0gz0NcYgxTn4NdjPSJU8gyicn2CbDNFaJGSYz7gsWb240xaFyc49BL QQ== 
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3xaj6ng1bx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 05 Apr 2024 13:41:57 +0000
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 435CnUxs007713;
	Fri, 5 Apr 2024 13:41:56 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 3x9epwtree-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 05 Apr 2024 13:41:56 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 435DfpSU33686004
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 5 Apr 2024 13:41:53 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5ADFB2004B;
	Fri,  5 Apr 2024 13:41:51 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2DECC20040;
	Fri,  5 Apr 2024 13:41:51 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri,  5 Apr 2024 13:41:51 +0000 (GMT)
From: Niklas Schnelle <schnelle@linux.ibm.com>
To: Benson Leung <bleung@chromium.org>, Tzung-Bi Shih <tzungbi@kernel.org>
Cc: chrome-platform@lists.linux.dev, Arnd Bergmann <arnd@kernel.org>,
        Heiko Carstens <hca@linux.ibm.com>, linux-kernel@vger.kernel.org,
        Niklas Schnelle <schnelle@linux.ibm.com>
Subject: [PATCH 0/1] platform: Handle HAS_IOPORT dependencies
Date: Fri,  5 Apr 2024 15:41:50 +0200
Message-Id: <20240405134151.5560-1-schnelle@linux.ibm.com>
X-Mailer: git-send-email 2.40.1
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: R4J0kqD-UZzCXLnWF5L8irXfRDXw39-X
X-Proofpoint-GUID: R4J0kqD-UZzCXLnWF5L8irXfRDXw39-X
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
 definitions=2024-04-05_10,2024-04-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 spamscore=0 mlxscore=0 phishscore=0 suspectscore=0 malwarescore=0
 mlxlogscore=999 adultscore=0 bulkscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2404010000
 definitions=main-2404050098

Hi Benson, Tzung-Bi,

This is a follow up in my ongoing effort of making inb()/outb() and
similar I/O port accessors compile-time optional. Previously I sent this
as a treewide series titled "treewide: Remove I/O port accessors for
HAS_IOPORT=n" with the latest being its 5th version[0]. With a significant
subset of patches merged I've changed over to per-subsystem series. These
series are stand alone and should be merged via the relevant tree such
that with all subsystems complete we can follow this up with the final
patch that will make the I/O port accessors compile-time optional.

The current state of the full series with changes to the remaining subsystems
and the aforementioned final patch can be found for your convenience on my
git.kernel.org tree in the has_ioport branch[1]. As for compile-time vs runtime
see Linus' reply to my first attempt[2].

Thanks,
Niklas

[0] https://lore.kernel.org/all/20230522105049.1467313-1-schnelle@linux.ibm.com/
[1] https://git.kernel.org/pub/scm/linux/kernel/git/niks/linux.git/log/?h=has_ioport
[2] https://lore.kernel.org/lkml/CAHk-=wg80je=K7madF4e7WrRNp37e3qh6y10Svhdc7O8SZ_-8g@mail.gmail.com/

Niklas Schnelle (1):
  platform: add HAS_IOPORT dependencies

 drivers/platform/chrome/Kconfig          | 1 +
 drivers/platform/chrome/wilco_ec/Kconfig | 1 +
 2 files changed, 2 insertions(+)

-- 
2.40.1


