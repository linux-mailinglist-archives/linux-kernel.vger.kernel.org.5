Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4290E78304F
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 20:36:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229699AbjHUSf6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 14:35:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbjHUSf5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 14:35:57 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A56D468B5
        for <linux-kernel@vger.kernel.org>; Mon, 21 Aug 2023 11:35:56 -0700 (PDT)
Received: from pps.filterd (m0353723.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37LIWlVF031023;
        Mon, 21 Aug 2023 18:35:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=SKY0eyk28r2lUWEjJCCWE2+4XvvrRT8bG+uYRHFusfk=;
 b=kqrw4sI9obPH9l56pPkaSt8UhR7WCIdCmbtpXxFu36tOhdcnXzXioQUZxyM3n2d8BlXQ
 0RvOI78/Rdkx+0QE29CZ79EZDfoRi4Vffj92ojEtWju8KaAz04UUR4cNeHbraMBSgwzI
 dG+Rf3zzEIqM6J7bgIKCNoSEzmJ9/XzUzjfBZdO7g1LSd+RiTeJhAQqCNSiulKdCoZu8
 4SlFSD3hg11PE07IAjxGXS8pgwZq+VGpRkF+7Ij11KfMUF7iyhcZgisVqCse4HgcN1lS
 zVLcczOA5rMIXqb3LR/AHx//icl6/9DiQXespBbdOrX2XngZneNknjhC8kWgprTjcVZ7 Zg== 
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3smd9vr3gx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 21 Aug 2023 18:35:39 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
        by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 37LGHL9h020705;
        Mon, 21 Aug 2023 18:35:38 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
        by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3sk9jkd6yf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 21 Aug 2023 18:35:38 +0000
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com [10.39.53.233])
        by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 37LIZbgC31064594
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 21 Aug 2023 18:35:38 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E87335803F;
        Mon, 21 Aug 2023 18:35:37 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6C97C5804E;
        Mon, 21 Aug 2023 18:35:37 +0000 (GMT)
Received: from gfwa153.aus.stglabs.ibm.com (unknown [9.3.84.127])
        by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
        Mon, 21 Aug 2023 18:35:37 +0000 (GMT)
From:   Ninad Palsule <ninad@linux.ibm.com>
To:     joel@jms.id.au, andrew@aj.id.au, eajames@linux.ibm.com
Cc:     Ninad Palsule <ninad@linux.ibm.com>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org
Subject: [PATCH v1 0/1] Host side BMC device driver
Date:   Mon, 21 Aug 2023 13:35:24 -0500
Message-Id: <20230821183525.3427144-1-ninad@linux.ibm.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: -wIrhtgGanzxXvQ6xYbrk8DA4HGfUitE
X-Proofpoint-GUID: -wIrhtgGanzxXvQ6xYbrk8DA4HGfUitE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-21_07,2023-08-18_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501 mlxscore=0
 bulkscore=0 phishscore=0 adultscore=0 impostorscore=0 clxscore=1011
 suspectscore=0 malwarescore=0 lowpriorityscore=0 spamscore=0
 mlxlogscore=510 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2308210173
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,
This patch includes support for host side BMC device driver.

Ninad Palsule (1):
  soc/aspeed: Add host side BMC device driver

 drivers/soc/aspeed/Kconfig               |   9 +
 drivers/soc/aspeed/Makefile              |   1 +
 drivers/soc/aspeed/aspeed-host-bmc-dev.c | 251 +++++++++++++++++++++++
 3 files changed, 261 insertions(+)
 create mode 100644 drivers/soc/aspeed/aspeed-host-bmc-dev.c

-- 
2.39.2

