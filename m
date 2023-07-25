Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 754AB7604B2
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 03:30:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229793AbjGYBaF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 21:30:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229789AbjGYBaC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 21:30:02 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0861171E;
        Mon, 24 Jul 2023 18:30:00 -0700 (PDT)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36P0SEvQ015570;
        Tue, 25 Jul 2023 01:29:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=qcppdkim1;
 bh=ztbvg3qh8DW7iS5BTHKyWdT0sUVJKcxg7qK55pHzNm0=;
 b=HQufatnWrMRfRA7YhSGNA8VZATgI8hMrqBkJ7VQ2J2l+P/u3PkLazPJfACCALEwDMs4p
 LIPYr9gGtfYOnPyu+25KcjOWAStKtNFCCvTHHSvcuC1PCnXJHYGQhhBuxMy7IeHpR7OS
 DT//nrzLe0Ji1SMqKzofYxhfRVbhP8H967M167xDv+GvtCkDRxIwY5NTe2bkmBUXbYFS
 Pn3YNGs8NGnFc+QtOoSomXPvlcq8eia9PmfzVg1Osz/xqyAT3ZJLgy9gl0xh+Rb00T5S
 PcwOQ8UpdNeiUU7UyZNGdtONBQO197NlLFD3QiN6S/08yLrcC9FSfunrrgF/73foXT15 CQ== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3s1vh8h1m5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 25 Jul 2023 01:29:55 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 36P1TsTX002637
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 25 Jul 2023 01:29:54 GMT
Received: from hu-mdtipton-lv.qualcomm.com (10.49.16.6) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Mon, 24 Jul 2023 18:29:54 -0700
From:   Mike Tipton <quic_mdtipton@quicinc.com>
To:     <djakov@kernel.org>, <gregkh@linuxfoundation.org>,
        <rafael@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        <quic_okukatla@quicinc.com>, <quic_viveka@quicinc.com>,
        Mike Tipton <quic_mdtipton@quicinc.com>
Subject: [PATCH 0/3] Add interconnect debugfs client
Date:   Mon, 24 Jul 2023 18:28:56 -0700
Message-ID: <20230725012859.18474-1-quic_mdtipton@quicinc.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: oCkJ4Uc-i-7VghjLGoJaBL_izLaf0LoZ
X-Proofpoint-GUID: oCkJ4Uc-i-7VghjLGoJaBL_izLaf0LoZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-24_18,2023-07-24_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 bulkscore=0
 impostorscore=0 mlxscore=0 spamscore=0 lowpriorityscore=0 suspectscore=0
 mlxlogscore=665 priorityscore=1501 adultscore=0 phishscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2307250010
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series introduces interconnect debugfs files that support voting
for any path the framework supports.

We've historically relied on an out-of-tree module for this, which used
the old icc_get() that was recently removed in [0]. The old icc_get()
took integer endpoint IDs, which made identifying paths in our old
implementation non-intuitive. The logical node names typically don't
change much chip-to-chip, but the raw integer IDs do. Take this
opportunity to introduce an icc_get() that uses string names instead,
which allows for a more intuitive and generic debugfs interface.

We rely on this support for debug, test, and verification. Hopefully
it'll be useful for other vendors as well.

[0] commit 7dcdad6f32c9 ("interconnect: drop unused icc_get() interface")

Mike Tipton (3):
  debugfs: Add write support to debugfs_create_str()
  interconnect: Reintroduce icc_get()
  interconnect: Add debugfs test client

 drivers/interconnect/Makefile         |   2 +-
 drivers/interconnect/core.c           |  67 +++++++++++
 drivers/interconnect/debugfs-client.c | 156 ++++++++++++++++++++++++++
 drivers/interconnect/internal.h       |   2 +
 fs/debugfs/file.c                     |  48 +++++++-
 include/linux/interconnect.h          |   6 +
 6 files changed, 278 insertions(+), 3 deletions(-)
 create mode 100644 drivers/interconnect/debugfs-client.c

-- 
2.17.1

