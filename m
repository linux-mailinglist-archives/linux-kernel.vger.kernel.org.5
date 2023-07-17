Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E30C755AC1
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 07:08:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230435AbjGQFI2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 01:08:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbjGQFIZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 01:08:25 -0400
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1ECFE4;
        Sun, 16 Jul 2023 22:08:24 -0700 (PDT)
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36H2N63N019915;
        Mon, 17 Jul 2023 01:08:14 -0400
Received: from nwd2mta4.analog.com ([137.71.173.58])
        by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 3rutmpg0qy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 17 Jul 2023 01:08:13 -0400
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
        by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 36H58Cic017921
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 17 Jul 2023 01:08:12 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.14; Mon, 17 Jul
 2023 01:08:11 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Mon, 17 Jul 2023 01:08:11 -0400
Received: from okan.localdomain (IST-LT-43126.ad.analog.com [10.25.36.12])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 36H57loY008003;
        Mon, 17 Jul 2023 01:07:50 -0400
From:   Okan Sahin <okan.sahin@analog.com>
To:     <okan.sahin@analog.com>
CC:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Ibrahim Tilki <Ibrahim.Tilki@analog.com>,
        Okan Sahin <Okan.Sahin@analog.com>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
Subject: [PATCH v3 0/2] Add MAX77857/59/MAX77831 Regulator Support
Date:   Mon, 17 Jul 2023 08:07:33 +0300
Message-ID: <20230717050736.10075-1-okan.sahin@analog.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-ORIG-GUID: i1qDupAZlNYYK0Fs344YsDNrROKoNE7V
X-Proofpoint-GUID: i1qDupAZlNYYK0Fs344YsDNrROKoNE7V
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-17_03,2023-07-13_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=457 spamscore=0
 clxscore=1015 impostorscore=0 mlxscore=0 suspectscore=0 bulkscore=0
 lowpriorityscore=0 malwarescore=0 priorityscore=1501 adultscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2307170046
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

High efficiency buck-boost regulator driver and bindings for
MAX77857/59/MAX77831. The patches are required to be applied
in sequence.

Changes in v3:
* Patch 1: "dt-bindings: regulator: max77857: Add ADI MAX77857/59/MAX77831
    Regulator"
  * Add second maintainer
* Patch 2: "regulator: max77857: Add ADI MAX77857/59/MAX77831 Regulator Support"
  * Change regmap cache_type

Changes in v2:
* Patch 1: "dt-bindings: regulator: max77857: Add ADI MAX77857/59/MAX77831
    Regulator"
  * Add max77859 support
* Patch 2: "regulator: max77857: Add ADI MAX77857/59/MAX77831 Regulator Support"
  * Add max77859 support
  * Drop interrupt support
  * Change regmap cache_type

Okan Sahin (2):
  dt-bindings: regulator: max77857: Add ADI MAX77857/59/MAX77831
    Regulator
  regulator: max77857: Add ADI MAX77857/59/MAX77831 Regulator Support

 .../bindings/regulator/adi,max77857.yaml      |  86 ++++
 drivers/regulator/Kconfig                     |  10 +
 drivers/regulator/Makefile                    |   1 +
 drivers/regulator/max77857-regulator.c        | 459 ++++++++++++++++++
 4 files changed, 556 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/regulator/adi,max77857.yaml
 create mode 100644 drivers/regulator/max77857-regulator.c

-- 
2.30.2

