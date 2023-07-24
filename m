Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C406575EB9B
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 08:35:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230192AbjGXGfp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 02:35:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230369AbjGXGf0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 02:35:26 -0400
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F04BDE66;
        Sun, 23 Jul 2023 23:34:52 -0700 (PDT)
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36O62Zob013753;
        Mon, 24 Jul 2023 02:34:43 -0400
Received: from nwd2mta3.analog.com ([137.71.173.56])
        by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 3s0c150xu9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 24 Jul 2023 02:34:42 -0400
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
        by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 36O6YfcG027279
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 24 Jul 2023 02:34:41 -0400
Received: from ASHBCASHYB5.ad.analog.com (10.64.17.133) by
 ASHBMBX9.ad.analog.com (10.64.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Mon, 24 Jul 2023 02:34:40 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by
 ASHBCASHYB5.ad.analog.com (10.64.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Mon, 24 Jul 2023 02:34:40 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Mon, 24 Jul 2023 02:34:40 -0400
Received: from okan.localdomain (IST-LT-43126.ad.analog.com [10.25.36.11])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 36O6YSOJ029336;
        Mon, 24 Jul 2023 02:34:31 -0400
From:   Okan Sahin <okan.sahin@analog.com>
To:     <okan.sahin@analog.com>
CC:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        <linux-gpio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v3 0/2] Add DS4520 GPIO Expander Support
Date:   Mon, 24 Jul 2023 09:34:12 +0300
Message-ID: <20230724063414.102805-1-okan.sahin@analog.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-ORIG-GUID: qiazPYt7LoV9UrPGkYunMf5WDOGHb81n
X-Proofpoint-GUID: qiazPYt7LoV9UrPGkYunMf5WDOGHb81n
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-24_04,2023-07-20_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 phishscore=0
 malwarescore=0 adultscore=0 spamscore=0 mlxlogscore=645 impostorscore=0
 clxscore=1011 priorityscore=1501 suspectscore=0 lowpriorityscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2307240060
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

GPIO expander driver and bindings for DS4520.
The patches are required to be applied in sequence.

Changes in v3:
* Patch 1: "dt-bindings: gpio: ds4520: Add ADI DS4520"
  * Add ngpios property.
* Patch 2: "gpio: ds4520: Add ADI DS4520 GPIO Expander Support"
  * Add namespace for MACROS
  * Read ngpios from dt
  * Add missing header file

Changes in v2:
* Patch 1: "dt-bindings: gpio: ds4520: Add ADI DS4520"
  * Drop label for gpio node
  * Use consistent quotes
  * Fix filename matching compatible.
* Patch 2: "gpio: ds4520: Add ADI DS4520 GPIO Expander Support"
  * Use regmap_gpio framework
  * Fix typo in Kconfig
  * Fix commit message

Okan Sahin (2):
  dt-bindings: gpio: ds4520: Add ADI DS4520
  gpio: ds4520: Add ADI DS4520 GPIO Expander Support

 .../bindings/gpio/adi,ds4520-gpio.yaml        | 51 +++++++++++
 drivers/gpio/Kconfig                          | 11 +++
 drivers/gpio/Makefile                         |  1 +
 drivers/gpio/gpio-ds4520.c                    | 89 +++++++++++++++++++
 4 files changed, 152 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/gpio/adi,ds4520-gpio.yaml
 create mode 100644 drivers/gpio/gpio-ds4520.c

-- 
2.30.2

