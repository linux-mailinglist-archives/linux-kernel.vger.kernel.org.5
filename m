Return-Path: <linux-kernel+bounces-29837-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 37199831437
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 09:10:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5BDCE1C234FF
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 08:10:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42533219ED;
	Thu, 18 Jan 2024 08:04:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="OBK3Uu4x"
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02E9320B0C;
	Thu, 18 Jan 2024 08:04:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705565084; cv=none; b=UWeKWWKSauCm1p7YAvgc7RRV/bpYUNomYaNFKBMl1eIJbvr8a4dx8QVgbU2Gv/Yukx1zV47MqZ+PyIFedr4wVL3lRH3sc743YKdAC8frwVSYbVnx8ZCfAuKJsU9pWWh21H4kSOPzEvgq34VJ8lixGmFpmOEzcBErjH5D2CCZ2rQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705565084; c=relaxed/simple;
	bh=68d9CmU5eeaESHqJic1JKrZ9pX0+kwyDcb6eL/2eh2o=;
	h=Received:DKIM-Signature:Received:Received:Received:Received:
	 Received:Received:Received:From:To:Cc:Subject:Date:Message-Id:
	 X-Mailer:MIME-Version:Content-Transfer-Encoding:X-TM-AS-GCONF:
	 X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details; b=TTid7FPjuBVqQWJ7gh5n4kIfnry/NxtqRayoLGaxkqpqDfonJvTjJPR2+s7kcNr5Qdks1bqWcWFjh9MZjent3kwi6Lsg8lAjBRoVReiiT+W4b3DHSWjC/MmHt6N46i6wgAfKHdeh3wb7kDvISgM1h/p3IncTYSK58S5KiwxNWNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=OBK3Uu4x; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 40I7L5Br031729;
	Thu, 18 Jan 2024 08:04:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=dW6SN3AhL0Lcxi0KIl8tKzSobcAeQPzLd4TnKFmh2CA=;
 b=OBK3Uu4xnAqt0dl7fLOvpH/dqie3h3kpd8tLlyyaLATTVcXpH3tfbUk9+5Aa7G/SkG9K
 rGke8RGRKvHW/aFLsNURz+WoPhu6p4+ZAR4f7hRro7yFdqwJQoe3DUPPpYvvR26ZYt/R
 Qg925ljlJjVAh/KroqGlufbV/gNP5L1cKnfvqs2NlZ5GAecZzrlc27e2WIU8ZjhqpTQX
 SjPlEsa1eJyZFyPTHu4YK/Nk5lErAvcvnC8hHQzhtgzR3JmMv+/iKT6ycjNjUGi6helL
 Yw1phm/qMsyUNa1osixjIXNf705SlW8gt+qgt6G7PBP5QEubARkXtE1F/fv6+PJyoTXS mA== 
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3vpw6pvauv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 18 Jan 2024 08:04:03 +0000
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 40I7BDoX006508;
	Thu, 18 Jan 2024 08:04:03 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 3vm7j21nb2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 18 Jan 2024 08:04:02 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 40I841Q036045078
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 18 Jan 2024 08:04:01 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2FADC20043;
	Thu, 18 Jan 2024 08:04:01 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id F40FD20040;
	Thu, 18 Jan 2024 08:03:58 +0000 (GMT)
Received: from li-c1fdab4c-355a-11b2-a85c-ef242fe9efb4.in.ibm.com (unknown [9.109.201.126])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 18 Jan 2024 08:03:58 +0000 (GMT)
From: Shrikanth Hegde <sshegde@linux.ibm.com>
To: linux-kernel@vger.kernel.org, linux-ntfs-dev@lists.sourceforge.net,
        linux-xfs@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Cc: sshegde@linux.ibm.com, mpe@ellerman.id.au, mingo@kernel.org,
        peterz@infradead.org, chandan.babu@oracle.com, anton@tuxera.com
Subject: [RFC PATCH 0/3] remove duplicate ifdefs
Date: Thu, 18 Jan 2024 13:33:23 +0530
Message-Id: <20240118080326.13137-1-sshegde@linux.ibm.com>
X-Mailer: git-send-email 2.39.3
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: sHUTBHPs0bn-MPgVd2jK5MQVyP9-lhbG
X-Proofpoint-ORIG-GUID: sHUTBHPs0bn-MPgVd2jK5MQVyP9-lhbG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-18_04,2024-01-17_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 spamscore=0
 malwarescore=0 lowpriorityscore=0 mlxlogscore=696 priorityscore=1501
 phishscore=0 adultscore=0 clxscore=1011 mlxscore=0 impostorscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2401180056

When going through the code observed a case in scheduler,
where #ifdef CONFIG_SMP was used to inside an #ifdef CONFIG_SMP.
That didn't make sense since first one is good enough and second
one is a duplicate.

This could improve code readability. No functional change is intended.
Maybe this is not an issue these days as language servers can parse
the config and users can read the code without bothering about
whats true and whats not.

Does this change makes sense?

Since this might be present in other code areas wrote a very basic
python script which helps in finding these cases. It doesn't handle any
complicated #defines or space separated "# if". At some places the
log collected had to be manually corrected due to space separated ifdefs.
Thats why its not a treewide change.
There might be an opportunity for other files as well.

Logic is very simple. If there is #ifdef or #if or #ifndef add that
variable to list. Upon every subsequent #ifdef or #if or #ifndef
check if the same variable is in the list. If yes flag
an error. Verification was done manually later checking for any #undef
or any error due to script. These were the ones that flagged out and
made sense after going through code.

ifdefs were collected using grep in below way and that file was used as
the input to the script.
grep -rIwn --include="*.c*" --include="*.h"  -e "#if" -e "#ifndef" -e "#ifdef" -e "#else" -e "#endif" * > /tmp/input.txt

---------------------------------------------------------------------
script used:
---------------------------------------------------------------------
import os
import argparse

def parse_args():
    parser = argparse.ArgumentParser()
    parser.add_argument("--file",
                            help="file to input to script",
                            type=str)
    parser.add_argument("--verbose",
                            help="Print additional debugging info, 0 to disable ",
                            type=int)
    args = parser.parse_args()
    return args

def parseFiles(args):
    file_to_parse = open(args.file, "r")
    lines = file_to_parse.readlines()
    check_length = len(lines)
    ifdefs_list = []
    i=0

    while i < check_length:
        line = lines[i]
        last_word = line.strip().split(":")[2]
        last_word = last_word.split("/")[0]

        if (args.verbose):
            print(line)
        last_word_splits = last_word.split()
        if (args.verbose):
            print(last_word_splits)
        if last_word_splits[0] == "#ifdef" or last_word_splits[0] == "#ifndef" or last_word_splits[0] == "#if":
            if last_word_splits[1] in ifdefs_list:
                print("This is duplicate and may be fixed: %s, parent_list:\n" % (line))
                print(ifdefs_list)
            ifdefs_list.append(last_word_splits[1])
        if last_word_splits[0] == "#endif"":
            ifdefs_list.pop()

        i=i+1

if __name__ == "__main__":
    args = parse_args()
    parseFiles(args)
-------------------------------------------------------------------------


Shrikanth Hegde (3):
  sched: remove duplicate ifdefs
  fs: remove depulicate ifdefs
  arch/powerpc: remove duplicate ifdefs

 arch/powerpc/include/asm/paca.h           | 4 ----
 arch/powerpc/kernel/asm-offsets.c         | 2 --
 arch/powerpc/platforms/powermac/feature.c | 2 --
 arch/powerpc/xmon/xmon.c                  | 2 --
 fs/ntfs/inode.c                           | 2 --
 fs/xfs/xfs_sysfs.c                        | 4 ----
 kernel/sched/core.c                       | 4 +---
 kernel/sched/fair.c                       | 2 --
 8 files changed, 1 insertion(+), 21 deletions(-)

--
2.39.3


