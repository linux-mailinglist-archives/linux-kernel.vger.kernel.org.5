Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95EA07FCE15
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 05:54:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376920AbjK2Exy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 23:53:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229722AbjK2Exw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 23:53:52 -0500
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EF0710E7;
        Tue, 28 Nov 2023 20:53:58 -0800 (PST)
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AT3jmWc006444;
        Tue, 28 Nov 2023 20:53:53 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=pfpt0220; bh=opgqyZX6LMVrmkQX5DCOWm0LZevDwASGJmt2zGyiYfA=;
 b=cf7pphZ0DfoQv1234ijBTwjtKhRvMlsQd1cb0+TjAAdIE7re0SBi94+9sh4Glhj1EtwX
 vDf7mcXm2Yjfe+EWhJr3uiBJoyb4ZVX5Ap/0FZ94o6ERg67Ls19SIgm7jtjVRjjyrsWZ
 HoE1DJtLkpsjGAiI8w8Yosgo1J+zOe33k2+jDfonjRQoSNnuxnM9Z3rn5Pnzmprb4wek
 SPqg55Ju8FcmCljqkbwzLZjv9unWkZzNZVnV9eQJNEuhwmAO1rbEXVT71MODUZmg+Ott
 vvadVSjwvQhe5UqXybNHIH1tWg84okkr9SaSIeu/tKorwfiTKnFUVFObvgCRAsJrQD3S 9w== 
Received: from dc5-exch02.marvell.com ([199.233.59.182])
        by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 3una4dmdra-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Tue, 28 Nov 2023 20:53:53 -0800
Received: from DC5-EXCH02.marvell.com (10.69.176.39) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Tue, 28 Nov
 2023 20:53:51 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server id 15.0.1497.48 via Frontend
 Transport; Tue, 28 Nov 2023 20:53:51 -0800
Received: from ubuntu-PowerEdge-T110-II.sclab.marvell.com (unknown [10.106.27.86])
        by maili.marvell.com (Postfix) with ESMTP id 85EE63F7043;
        Tue, 28 Nov 2023 20:53:50 -0800 (PST)
From:   Shinas Rasheed <srasheed@marvell.com>
To:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <hgani@marvell.com>, <vimleshk@marvell.com>, <egallen@redhat.com>,
        <mschmidt@redhat.com>, <pabeni@redhat.com>, <horms@kernel.org>,
        <kuba@kernel.org>, <davem@davemloft.net>, <wizhao@redhat.com>,
        <konguyen@redhat.com>, Shinas Rasheed <srasheed@marvell.com>
Subject: [PATCH net-next v2 0/2] support OCTEON CN98 devices
Date:   Tue, 28 Nov 2023 20:53:46 -0800
Message-ID: <20231129045348.2538843-1-srasheed@marvell.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: X_1OoNhzm7c87nwF5OHdvZsYAuJtKUFG
X-Proofpoint-ORIG-GUID: X_1OoNhzm7c87nwF5OHdvZsYAuJtKUFG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-29_01,2023-11-27_01,2023-05-22_02
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Implement device unload control net API required for CN98
devices and add support in driver for the same.

Changes:
V2:
  - Changed dev_info print to dev_dbg in device_remove API

V1: https://lore.kernel.org/all/20231127162135.2529363-1-srasheed@marvell.com/

Shinas Rasheed (2):
  octeon_ep: implement device unload control net API
  octeon_ep: support OCTEON CN98 devices

 .../ethernet/marvell/octeon_ep.rst            |  1 +
 .../marvell/octeon_ep/octep_cn9k_pf.c         | 24 +++++++++++++++----
 .../marvell/octeon_ep/octep_ctrl_net.c        | 16 ++++++++++++-
 .../marvell/octeon_ep/octep_ctrl_net.h        | 11 +++++++++
 .../ethernet/marvell/octeon_ep/octep_main.c   |  4 ++++
 .../ethernet/marvell/octeon_ep/octep_main.h   |  1 +
 .../marvell/octeon_ep/octep_regs_cn9k_pf.h    |  4 ++++
 7 files changed, 56 insertions(+), 5 deletions(-)

-- 
2.25.1

