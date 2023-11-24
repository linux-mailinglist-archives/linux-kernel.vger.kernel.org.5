Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C813A7F6FE9
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Nov 2023 10:33:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345165AbjKXJdY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Nov 2023 04:33:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229705AbjKXJdS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Nov 2023 04:33:18 -0500
Received: from mx0a-002bf204.pphosted.com (mx0a-002bf204.pphosted.com [205.220.160.90])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 152BFDD;
        Fri, 24 Nov 2023 01:33:24 -0800 (PST)
Received: from pps.filterd (m0207524.ppops.net [127.0.0.1])
        by mx0a-002bf204.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 3AO5Rqte003504;
        Fri, 24 Nov 2023 01:33:11 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        monolithicpower.com; h=from:to:cc:subject:date:message-id
        :mime-version:content-transfer-encoding:content-type; s=pps1;
         bh=nsvTRjQFGQh+dlqpD5h9CxmhKU5pU28P+F5FXBMlO94=; b=oHYStvcHKH+D
        ixTbFggEFzf7XBcEgyqmmAmkrK32zHOjphqd3C6rIauLSMLp0/96AQSwNPir1Lb/
        IzxP1QbdzJzcysmb6dUCiPBxGaj5oAPnF5w4/0x8Cw4zlfKVger0zNZjxkflvYNm
        njKUp6rTChaMUY9rPMhIlA27ylio9gSOnDwk3Fe/q6q9IJ6Ba47G0nIApTiGn479
        GKIbnVGgDoYA8cXT+LAixaL4ub3ifQuj6Xwsw113pczJ07Xcdn/sC8Exk/cwneQc
        l8uVGFRjyTIYqUUx6XvhGUD4Q14uFTcBwJtFTeJT0skMN0cLcaAJIX4DRja6Y0Rn
        0BoAWzSGMQ==
Received: from webmail.monolithicpower.com (mps-vpn.monolithicpower.com [12.33.0.20] (may be forged))
        by mx0a-002bf204.pphosted.com (PPS) with ESMTPS id 3uesjsb24d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 24 Nov 2023 01:33:11 -0800 (PST)
Received: from CD-MSH04.monolithicpower.com (10.10.70.213) by
 MPS-MSH03.monolithicpower.com (10.10.10.205) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Fri, 24 Nov 2023 01:33:04 -0800
Received: from smtp.gmail.com (10.10.86.78) by CD-MSH04.monolithicpower.com
 (10.10.70.213) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Fri, 24 Nov
 2023 17:33:02 +0800
From:   Yuxi Wang <Yuxi.Wang@monolithicpower.com>
To:     <pavel@ucw.cz>, <lee@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <Yuxi.Wang@monolithicpower.com>
CC:     <linux-kernel@vger.kernel.org>, <linux-leds@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <wyx137120466@gmail.com>
Subject: [PATCH 0/2] leds: Add a driver for MP3326
Date:   Fri, 24 Nov 2023 17:30:31 +0800
Message-ID: <20231124093034.951-1-Yuxi.Wang@monolithicpower.com>
X-Mailer: git-send-email 2.42.0.windows.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.10.86.78]
X-ClientProxiedBy: CD-MSLBN02.monolithicpower.com (192.168.86.32) To
 CD-MSH04.monolithicpower.com (10.10.70.213)
X-Proofpoint-ORIG-GUID: hrJb0W8-9Igr2b30eh8SQyczmyNJ3L3z
X-Proofpoint-GUID: hrJb0W8-9Igr2b30eh8SQyczmyNJ3L3z
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-23_15,2023-11-22_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 suspectscore=0
 adultscore=0 lowpriorityscore=0 malwarescore=0 phishscore=0
 priorityscore=1501 impostorscore=0 clxscore=1011 bulkscore=0
 mlxlogscore=641 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311060001 definitions=main-2311240074
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the binding description and the corresponding driver for
the MPS MP3326.

Signed-off-by: Yuxi Wang <Yuxi.Wang@monolithicpower.com>


Yuxi Wang (2):
  dt-bindings: leds: add mps mp3326 LED
  leds: add mp3326 driver

 .../devicetree/bindings/leds/mps,mp3326.yaml  | 143 ++++
 drivers/leds/Kconfig                          |   7 +
 drivers/leds/Makefile                         |   1 +
 drivers/leds/leds-mp3326.c                    | 622 ++++++++++++++++++
 4 files changed, 773 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/leds/mps,mp3326.yaml
 create mode 100644 drivers/leds/leds-mp3326.c

-- 
2.25.1

