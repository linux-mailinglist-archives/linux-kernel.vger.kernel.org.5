Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72C047FF0D0
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 14:53:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345834AbjK3Nxm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 08:53:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345740AbjK3Nxa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 08:53:30 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8829B170B;
        Thu, 30 Nov 2023 05:53:36 -0800 (PST)
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AUDd9qW001806;
        Thu, 30 Nov 2023 13:53:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=dNu5Klycj9CTH42YxtPoVOXxFekkC+Q8QRK1Zv71CMw=;
 b=W0R0ufQRr1h7eO4seILCjiyHBmegJXEd3o0i7/eDhacv8GcD2fbLv8GZ0g1UYQJJ9UU/
 SqVvLD9B2uWEwauDzYdCGx+XzbpewXtPkOoawpAgiG+fv2BmEcsZiw/o8h/QfkPWAPfH
 7ItIEWKhqQ9vywNO8WVn8YLjIQMVha2NMRKJek3QyyucUjbI3pWyAeNffYTzIETGPR0r
 PZLfYsKd2XwygwzGxCby/bs+kXWhEj4fWaEl2ny9eH/f0razqAIAiysd4YXov+tmmdCQ
 Kvfwm14HKXRwMwiqAhbUXwZGNbme7EZosoV4A4Nf6nKWB2EUwsdlyCXbotAMYtVi2Tq5 QQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3upuc30mkr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 30 Nov 2023 13:53:30 +0000
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3AUDea4V004643;
        Thu, 30 Nov 2023 13:53:29 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3upuc30mkb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 30 Nov 2023 13:53:29 +0000
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
        by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3AUDn9ju029475;
        Thu, 30 Nov 2023 13:53:28 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
        by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 3ukwfke1r8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 30 Nov 2023 13:53:27 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
        by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3AUDrOku42139910
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 30 Nov 2023 13:53:25 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DDDAB2004B;
        Thu, 30 Nov 2023 13:53:24 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 45D4D20043;
        Thu, 30 Nov 2023 13:53:22 +0000 (GMT)
Received: from li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com.com (unknown [9.43.76.38])
        by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Thu, 30 Nov 2023 13:53:22 +0000 (GMT)
From:   Ojaswin Mujoo <ojaswin@linux.ibm.com>
To:     linux-ext4@vger.kernel.org, "Theodore Ts'o" <tytso@mit.edu>
Cc:     Ritesh Harjani <ritesh.list@gmail.com>,
        linux-kernel@vger.kernel.org,
        "Darrick J . Wong" <djwong@kernel.org>,
        linux-block@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        John Garry <john.g.garry@oracle.com>, dchinner@redhat.com
Subject: [RFC 1/7] iomap: Don't fall back to buffered write if the write is atomic
Date:   Thu, 30 Nov 2023 19:23:09 +0530
Message-Id: <09ec4c88b565c85dee91eccf6e894a0c047d9e69.1701339358.git.ojaswin@linux.ibm.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <cover.1701339358.git.ojaswin@linux.ibm.com>
References: <cover.1701339358.git.ojaswin@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: s7Ig9mp1nPeU4UDRadYI1W8VOuasZx2S
X-Proofpoint-ORIG-GUID: -9Q93Ol6p1bj0dK9orlZJjs2_NSBq4RL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-30_12,2023-11-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 suspectscore=0 adultscore=0 clxscore=1015 impostorscore=0 phishscore=0
 priorityscore=1501 bulkscore=0 mlxlogscore=822 spamscore=0 malwarescore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311300102
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, iomap only supports atomic writes for direct IOs and there is
no guarantees that a buffered IO will be atomic. Hence, if the user has
explicitly requested the direct write to be atomic and there's a
failure, return -EIO instead of falling back to buffered IO.

Signed-off-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
---
 fs/iomap/direct-io.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/fs/iomap/direct-io.c b/fs/iomap/direct-io.c
index 6ef25e26f1a1..3e7cd9bc8f4d 100644
--- a/fs/iomap/direct-io.c
+++ b/fs/iomap/direct-io.c
@@ -662,7 +662,13 @@ __iomap_dio_rw(struct kiocb *iocb, struct iov_iter *iter,
 			if (ret != -EAGAIN) {
 				trace_iomap_dio_invalidate_fail(inode, iomi.pos,
 								iomi.len);
-				ret = -ENOTBLK;
+				/*
+				 * if this write was supposed to be atomic,
+				 * return the err rather than trying to fall
+				 * back to buffered IO.
+				 */
+				if (!atomic_write)
+					ret = -ENOTBLK;
 			}
 			goto out_free_dio;
 		}
-- 
2.39.3

