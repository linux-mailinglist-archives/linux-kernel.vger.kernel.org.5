Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4AC777D49B
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 22:49:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239223AbjHOUtO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 16:49:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239818AbjHOUsx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 16:48:53 -0400
X-Greylist: delayed 1615 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 15 Aug 2023 13:48:26 PDT
Received: from mx0a-00000d04.pphosted.com (mx0a-00000d04.pphosted.com [148.163.149.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEEEEE5F;
        Tue, 15 Aug 2023 13:48:26 -0700 (PDT)
Received: from pps.filterd (m0102886.ppops.net [127.0.0.1])
        by mx0a-00000d04.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37FDUccO002918;
        Tue, 15 Aug 2023 13:21:18 -0700
Received: from mx0b-00000d06.pphosted.com (mx0b-00000d06.pphosted.com [148.163.139.119])
        by mx0a-00000d04.pphosted.com (PPS) with ESMTPS id 3sgaacu6hd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 15 Aug 2023 13:21:18 -0700
Received: from pps.filterd (m0167939.ppops.net [127.0.0.1])
        by mx0b-00000d06.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37FCUJDp018012;
        Tue, 15 Aug 2023 13:21:17 -0700
Received: from smtp.stanford.edu (smtp4.stanford.edu [171.67.219.72])
        by mx0b-00000d06.pphosted.com (PPS) with ESMTPS id 3se6cnv194-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 15 Aug 2023 13:21:17 -0700
Received: from cm-mail.stanford.edu (cm-mail.stanford.edu [171.64.197.135])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by smtp.stanford.edu (Postfix) with ESMTPS id 58D7B1C0681;
        Tue, 15 Aug 2023 13:21:16 -0700 (PDT)
Received: from DNa8006b2.SUNet ([10.128.6.178])
        (authenticated bits=0)
        by cm-mail.stanford.edu (8.14.4/8.14.4) with ESMTP id 37FKL9Mg019013
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 15 Aug 2023 13:21:15 -0700
From:   Nils Tonnaett <ntonnatt@ccrma.Stanford.EDU>
To:     Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Rahul Rameshbabu <sergeantsagara@protonmail.com>,
        Nils Tonnaett <ntonnatt@ccrma.Stanford.EDU>
Subject: [PATCH v2] HID: apple: Add "Hailuck" to the list of non-apple keyboards
Date:   Tue, 15 Aug 2023 13:19:59 -0700
Message-ID: <20230815201959.17569-1-ntonnatt@ccrma.stanford.edu>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230811202932.30413-1-ntonnatt@ccrma.stanford.edu>
References: <20230811202932.30413-1-ntonnatt@ccrma.stanford.edu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
x-proofpoint-stanford-dir: outbound
X-Proofpoint-ORIG-GUID: kBBnvN3AubxV08gmXtV-5E1YOo1ioMwt
X-Proofpoint-GUID: kBBnvN3AubxV08gmXtV-5E1YOo1ioMwt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-15_19,2023-08-15_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 phishscore=0 spamscore=0
 bulkscore=0 clxscore=1015 adultscore=100 mlxlogscore=991 impostorscore=0
 priorityscore=1501 lowpriorityscore=0 suspectscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2308150183
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Powzan keyboards KB750 and KB770 identify as
"Hailuck Co.,Ltd USB Keyboard". Adding "Hailuck" to the list
of non-apple keyboards fixes function keys for these models.

Signed-off-by: Nils Tonnaett <ntonnatt@ccrma.stanford.edu>
---
V1 -> V2:
	- Start commit message subject with HID: apple: instead of hid:
	- Comma terminate last member of array

 drivers/hid/hid-apple.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/hid/hid-apple.c b/drivers/hid/hid-apple.c
index d7b932925730..3ca45975c686 100644
--- a/drivers/hid/hid-apple.c
+++ b/drivers/hid/hid-apple.c
@@ -343,7 +343,8 @@ static const struct apple_non_apple_keyboard non_apple_keyboards[] = {
 	{ "SONiX USB DEVICE" },
 	{ "Keychron" },
 	{ "AONE" },
-	{ "GANSS" }
+	{ "GANSS" },
+	{ "Hailuck" },
 };
 
 static bool apple_is_non_apple_keyboard(struct hid_device *hdev)
-- 
2.41.0

