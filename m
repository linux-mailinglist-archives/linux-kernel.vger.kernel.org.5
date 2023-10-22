Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2965C7D257D
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Oct 2023 20:53:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232747AbjJVSxn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Oct 2023 14:53:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232268AbjJVSxk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Oct 2023 14:53:40 -0400
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F224E5;
        Sun, 22 Oct 2023 11:53:38 -0700 (PDT)
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 39MGYTL9018112;
        Sun, 22 Oct 2023 14:53:22 -0400
Received: from nwd2mta4.analog.com ([137.71.173.58])
        by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 3tvusetvpd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 22 Oct 2023 14:53:22 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
        by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 39MIrLkL040327
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Sun, 22 Oct 2023 14:53:21 -0400
Received: from ASHBCASHYB4.ad.analog.com (10.64.17.132) by
 ASHBMBX9.ad.analog.com (10.64.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Sun, 22 Oct 2023 14:53:20 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by
 ASHBCASHYB4.ad.analog.com (10.64.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Sun, 22 Oct 2023 14:53:20 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Sun, 22 Oct 2023 14:53:20 -0400
Received: from HYB-a2JJhsYKAxD.ad.analog.com ([10.132.252.38])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 39MIr0UU003145;
        Sun, 22 Oct 2023 14:53:03 -0400
From:   Gokhan Celik <gokhan.celik@analog.com>
To:     <outreachy@lists.linux.dev>
CC:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        "Rob Herring" <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Gokhan Celik <Gokhan.Celik@analog.com>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        Gokhan Celik <gokhan.celik@analog.com>
Subject: [PATCH v4 0/2] Add ADI MAX77503 regulator driver and bindings
Date:   Sun, 22 Oct 2023 21:52:49 +0300
Message-ID: <cover.1698000185.git.gokhan.celik@analog.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-GUID: ZeXbsHfDaXQLIps1nxZcy39KPdgY7zfI
X-Proofpoint-ORIG-GUID: ZeXbsHfDaXQLIps1nxZcy39KPdgY7zfI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-22_16,2023-10-19_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 malwarescore=0
 phishscore=0 priorityscore=1501 impostorscore=0 bulkscore=0 mlxscore=0
 mlxlogscore=639 adultscore=0 lowpriorityscore=0 suspectscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2310170000
 definitions=main-2310220174
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add MAX77503 buck converter driver and devicetree bindings.
Apply patches in sequence.

Gokhan Celik (2):
  regulator: max77503: Add ADI MAX77503 support
  regulator: dt-bindings: Add ADI MAX77503 support

 .../regulator/adi,max77503-regulator.yaml     |  50 +++++++
 drivers/regulator/Kconfig                     |  10 ++
 drivers/regulator/Makefile                    |   1 +
 drivers/regulator/max77503-regulator.c        | 137 ++++++++++++++++++
 4 files changed, 198 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/regulator/adi,max77503-regulator.yaml
 create mode 100644 drivers/regulator/max77503-regulator.c

-- 
2.34.1

