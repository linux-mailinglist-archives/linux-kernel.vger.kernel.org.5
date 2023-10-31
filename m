Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4DC07DCFD9
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 16:03:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344598AbjJaPDB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Oct 2023 11:03:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344514AbjJaPC7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 11:02:59 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C2CFF4;
        Tue, 31 Oct 2023 08:02:57 -0700 (PDT)
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39VEfALq016568;
        Tue, 31 Oct 2023 15:02:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : content-type : content-transfer-encoding :
 mime-version; s=pp1; bh=2tbIlbBGkV8H+VczWHUMrMJUEEk60Ju+xhks0XVtC/4=;
 b=AZuGXzrUM66OGl+aFX5Q1IymItUMXniTmozvxROmXIhes3W+fPLY5Y3uPjl0Lt6yERV6
 59jMWqG2/HTXZSOTUKIYIiMgs9mv5ZdtB16ZyWxPIaS9pM8UZyUHAIh6xnUR1Qs8e70d
 CijD8eZMKZAh/XFQTwRHoObg2UE5TVRUSRhx4HEZVoNdz1tZmRAxGrxOLShjwpbtNmYO
 FexzIcgZg/p2I9N3gQ37Ti5oBp4wMu7LRRpRxF0z44TlezOiVLoF4UoC55W1jHsn1RbY
 UD0WSkHm8UZx+hwU6CaSOu9dtAjCn7U5oMVIz7zBtmbM6hRLEbaKam/L/KzpupAemZHs Dg== 
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3u33ja0u12-4
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 31 Oct 2023 15:02:54 +0000
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
        by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 39VCmT82000588;
        Tue, 31 Oct 2023 14:38:48 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
        by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 3u1cmt1f8h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 31 Oct 2023 14:38:48 +0000
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com [10.39.53.232])
        by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 39VEclav50332022
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 31 Oct 2023 14:38:47 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4940058053;
        Tue, 31 Oct 2023 14:38:47 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8F7805805F;
        Tue, 31 Oct 2023 14:38:46 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.61.171.194])
        by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
        Tue, 31 Oct 2023 14:38:46 +0000 (GMT)
Message-ID: <205e07e901e695f4986bf0e4071168302fbf59bc.camel@linux.ibm.com>
Subject: [GIT PULL] integrity: susbystem updates for v6.7
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-integrity <linux-integrity@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Date:   Tue, 31 Oct 2023 10:38:46 -0400
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-22.el8) 
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: AgJKGVJF-OiysT9ZObk7vi84KBtEcGmb
X-Proofpoint-ORIG-GUID: AgJKGVJF-OiysT9ZObk7vi84KBtEcGmb
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-31_01,2023-10-31_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 spamscore=0 mlxscore=0 bulkscore=0 mlxlogscore=689 lowpriorityscore=0
 suspectscore=0 adultscore=0 clxscore=1015 malwarescore=0 phishscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2310240000 definitions=main-2310310118
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Four integrity changes: two IMA-overlay updates, an integrity Kconfig
cleanup, and a secondary keyring update.

Stephen Rothwell is carrying an overlay merge conflict resolution:
https://lore.kernel.org/linux-next/20231027131137.3051da98@canb.auug.org.au/

thanks,

Mimi

The following changes since commit 94f6f0550c625fab1f373bb86a6669b45e9748b3:

  Linux 6.6-rc5 (2023-10-08 13:49:43 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/zohar/linux-integrity.git tags/integrity-v6.7

for you to fetch changes up to b836c4d29f2744200b2af41e14bf50758dddc818:

  ima: detect changes to the backing overlay file (2023-10-31 08:22:36 -0400)

----------------------------------------------------------------
integrity-v6.7

----------------------------------------------------------------
Amir Goldstein (1):
      ima: annotate iint mutex to avoid lockdep false positive warnings

Mimi Zohar (2):
      certs: Only allow certs signed by keys on the builtin keyring
      ima: detect changes to the backing overlay file

Prasad Pandit (1):
      integrity: fix indentation of config attributes

 certs/Kconfig                     | 16 ++++++++++++-
 crypto/asymmetric_keys/restrict.c |  4 ++++
 fs/overlayfs/super.c              |  2 +-
 security/integrity/Kconfig        | 44 +++++++++++++++++------------------
 security/integrity/iint.c         | 48 ++++++++++++++++++++++++++++++---------
 security/integrity/ima/ima_api.c  |  5 ++++
 security/integrity/ima/ima_main.c | 16 ++++++++++++-
 security/integrity/integrity.h    |  2 ++
 8 files changed, 101 insertions(+), 36 deletions(-)

