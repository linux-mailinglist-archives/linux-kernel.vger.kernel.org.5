Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 486C97BA6F5
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 18:43:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231974AbjJEQni (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 12:43:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234381AbjJEQlZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 12:41:25 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1139C9E;
        Thu,  5 Oct 2023 09:29:52 -0700 (PDT)
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 395GQ3Kl008480;
        Thu, 5 Oct 2023 16:29:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : content-type : content-transfer-encoding :
 mime-version; s=pp1; bh=e/uxUGgKiTmqQdW2f3YDwweeYv/YTjo50AJHu3QIs4g=;
 b=QD+regq6d+lND1misANH50l7ZSdJy134tf+kl2571l8wf57mO5vm5xRCDmSSzBW4El/U
 /tniRGr0RUVMrv1pSDEK8qZ5jiiXYZb7blwEEjXMw0sjB0r0pm+pnpRIco96pKa0boF4
 fhPOxUk3wwzNIaOCB9FbD0rwtzZJ615Im3Y0Rv0c4/FXBovsec9YcajG1wMsqeqOfocV
 b9hnqo9mWW6aZUUTl0DoxI7GIGKV/FQEdnxc/X+5TZCfBLHzCVVRWPhMKuxKhNKU8SGg
 iU3oExdtThsel/3bXvS7ZadhFY4GplMMPz0kxCXss1O1kfgOEKXU/3WtfHX3LtRaXH+2 rA== 
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3tj0ner3xu-32
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 05 Oct 2023 16:29:16 +0000
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
        by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 395FEwlK025087;
        Thu, 5 Oct 2023 15:53:32 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
        by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3texcywjaj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 05 Oct 2023 15:53:32 +0000
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com [10.241.53.102])
        by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 395FrVes7275070
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 5 Oct 2023 15:53:31 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8774458056;
        Thu,  5 Oct 2023 15:53:31 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 087865803F;
        Thu,  5 Oct 2023 15:53:31 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.61.90.188])
        by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
        Thu,  5 Oct 2023 15:53:30 +0000 (GMT)
Message-ID: <d213722924c7942bc60fc6b7acf934c8bf6f74e0.camel@linux.ibm.com>
Subject: [GIT PULL] integrity: susbystem fixes for v6.6 (take 2)
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-integrity <linux-integrity@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Date:   Thu, 05 Oct 2023 11:53:30 -0400
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-22.el8) 
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: dJbaJMpTfBtZ0TFEo7FBGFZitGqLzd_r
X-Proofpoint-ORIG-GUID: dJbaJMpTfBtZ0TFEo7FBGFZitGqLzd_r
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-05_11,2023-10-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0
 priorityscore=1501 malwarescore=0 mlxlogscore=942 impostorscore=0
 suspectscore=0 clxscore=1015 mlxscore=0 spamscore=0 bulkscore=0
 lowpriorityscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2309180000 definitions=main-2310050128
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Two additional patches to fix the removal of the deprecated
IMA_TRUSTED_KEYRING Kconfig.

thanks,

Mimi

The following changes since commit 6465e260f48790807eef06b583b38ca9789b6072:

  Linux 6.6-rc3 (2023-09-24 14:31:13 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/zohar/linux-integrity.git tags/integrity-v6.6-fix

for you to fetch changes up to 91e326563ee34509c35267808a4b1b3ea3db62a8:

  ima: rework CONFIG_IMA dependency block (2023-09-27 11:52:12 -0400)

----------------------------------------------------------------
integrity-v6.6-fix

----------------------------------------------------------------
Arnd Bergmann (1):
      ima: rework CONFIG_IMA dependency block

Oleksandr Tymoshenko (1):
      ima: Finish deprecation of IMA_TRUSTED_KEYRING Kconfig

 security/integrity/ima/Kconfig | 22 ++++++++--------------
 1 file changed, 8 insertions(+), 14 deletions(-)

