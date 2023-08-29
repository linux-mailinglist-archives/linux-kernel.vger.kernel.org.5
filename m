Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04A8378CD6F
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 22:18:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239958AbjH2US0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 16:18:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231453AbjH2USC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 16:18:02 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB32FE9;
        Tue, 29 Aug 2023 13:17:59 -0700 (PDT)
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37TKH4iA004471;
        Tue, 29 Aug 2023 20:17:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : content-type : content-transfer-encoding :
 mime-version; s=pp1; bh=bmDTpNd8sZn5R6klGMzI09si+fkfHNgAcl5K6WouPNI=;
 b=B73z0HoyGYZyiSEzNe/Lz2g7NIrfC8WAGDyGHOR340jxbPHRwL3uqoH1gtPB3lMI1LEB
 G6MA1lABES5/AGrmvdXOf3Z7FFI7cLPrfc/3/VM8ahuwMsGLDypdfB/jzMSmf8YmtQXB
 FosE+vn0zr8+06BPkajKOqIuk0r3NF+7ky3qBg0ZSF+31USEp3NLam6zyAsylkYoVSb1
 m2QLzIZaL6zMbyFLB+ZuhCRxvmAV5SJkz24mEcTPe3OzTcuyb4KHRLiZ9KtuFJ9b5aSa
 HF7+5jeAQdScTB/V1xM5nt+Vui3cvuI3kzf0MUJZfSaDHsNTTk6d7/2BDiJDxzHF2GJl 0A== 
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ssq9w8bqk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 29 Aug 2023 20:17:58 +0000
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
        by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 37TJDs0R014392;
        Tue, 29 Aug 2023 20:17:57 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
        by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3sqvqn696r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 29 Aug 2023 20:17:57 +0000
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com [10.241.53.102])
        by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 37TKHuBo66650432
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 29 Aug 2023 20:17:56 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8A2435803F;
        Tue, 29 Aug 2023 20:17:56 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4D33358056;
        Tue, 29 Aug 2023 20:17:56 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.61.191.86])
        by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
        Tue, 29 Aug 2023 20:17:56 +0000 (GMT)
Message-ID: <154c360fb6a21849e89ec003cf2be9ef96599393.camel@linux.ibm.com>
Subject: [GIT PULL] integrity: susbystem updates for v6.6 (take 2)
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-integrity <linux-integrity@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Date:   Tue, 29 Aug 2023 16:17:55 -0400
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-22.el8) 
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: vHkczqKrcYuaMkxO4aL7v8DgBKi5EmH5
X-Proofpoint-ORIG-GUID: vHkczqKrcYuaMkxO4aL7v8DgBKi5EmH5
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-29_13,2023-08-29_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 mlxlogscore=988 mlxscore=0 clxscore=1015 impostorscore=0 phishscore=0
 spamscore=0 malwarescore=0 lowpriorityscore=0 adultscore=0 suspectscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2308290174
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Two IMA changes, a code cleanup, and a kernel-doc update.

- With commit 099f26f22f58 ("integrity: machine keyring CA
configuration") certificates may be loaded onto the IMA keyring,
directly or indirectly signed by keys on either the "builtin" or the
"machine" keyrings. With the ability for the system/machine owner to
sign the IMA policy itself without needing to recompile the kernel,
update the IMA architecture specific policy rules to require the IMA
policy itself be signed.

[As commit 099f26f22f58 was upstreamed in linux-6.4, updating the IMA
architecture specific policy now to require signed IMA policies may
break userspace expectations.]

- IMA only checked the file data hash was not on the system blacklist
keyring for files with an appended signature (e.g. kernel modules,
Power kernel image). Check all file data hashes regardless of how it
was signed.

thanks,

Mimi


The following changes since commit 5d0c230f1de8c7515b6567d9afba1f196fb4e2f4:

  Linux 6.5-rc4 (2023-07-30 13:23:47 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/zohar/linux-integrity.git tags/integrity-v6.6

for you to fetch changes up to 55e2b69649be38f1788b38755070875b96111d2f:

  kexec_lock: Replace kexec_mutex() by kexec_lock() in two comments (2023-08-07 09:55:42 -0400)

----------------------------------------------------------------
integrity-v6.6

----------------------------------------------------------------
Coiby Xu (1):
      ima: require signed IMA policy when UEFI secure boot is enabled

Eric Snowberg (1):
      integrity: Always reference the blacklist keyring with appraisal

Nayna Jain (1):
      ima: Remove deprecated IMA_TRUSTED_KEYRING Kconfig

Wenyu Liu (1):
      kexec_lock: Replace kexec_mutex() by kexec_lock() in two comments

 Documentation/ABI/testing/ima_policy  |  6 +++---
 arch/powerpc/kernel/ima_arch.c        |  8 ++++----
 kernel/kexec_file.c                   |  2 +-
 security/integrity/ima/Kconfig        | 12 ------------
 security/integrity/ima/ima_appraise.c | 12 +++++++-----
 security/integrity/ima/ima_efi.c      |  3 +++
 security/integrity/ima/ima_kexec.c    |  2 +-
 security/integrity/ima/ima_policy.c   | 17 +++++------------
 8 files changed, 24 insertions(+), 38 deletions(-)hh

