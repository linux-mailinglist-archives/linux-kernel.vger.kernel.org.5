Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 855AE7DC74B
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 08:29:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343684AbjJaH3l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Oct 2023 03:29:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343614AbjJaH3j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 03:29:39 -0400
Received: from mx0b-002bf204.pphosted.com (mx0b-002bf204.pphosted.com [205.220.172.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88902C0;
        Tue, 31 Oct 2023 00:29:37 -0700 (PDT)
Received: from pps.filterd (m0207525.ppops.net [127.0.0.1])
        by mx0a-002bf204.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 39V3LBVR014430;
        Mon, 30 Oct 2023 23:58:57 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        monolithicpower.com; h=from:to:cc:subject:date:message-id
        :content-type:content-transfer-encoding:mime-version; s=pps1;
         bh=8AjB/JwrB69XBwDF9L++gF7xwO/o6qmFV/TAXkdYvA8=; b=l1hUwc+MJ3Le
        SwG981NWfmlN5+T3PuZpDHmFwoxMErgRZkYyTiKCfAUK2ttTbjLL5O6gJyWAWacT
        JQFc/a+55adTVRKD6JrRcDtVkANWtVoihlnxvn37akpyE5Ygt2p4kQcqgFMRTO62
        xHbx/NEySRtLrdzABp6h0BPWIdj2Dv40o83YDWr971/20F1hAUw2L3Yz63mlljax
        a+sCOgzwbVEh74lCvsSrw1DlCpfq34lG5UoASELjRPkOCiSSsPkyjFqhRPWR9x8U
        vc1Vl0xvfFqI4c5tdCGuSxbYH0blfMg9y3NzXaPrFbpqRleRGFbsSpKygkVDSJxB
        URO3nE8mhQ==
Received: from webmail.monolithicpower.com (mps-vpn.monolithicpower.com [12.33.0.20] (may be forged))
        by mx0a-002bf204.pphosted.com (PPS) with ESMTPS id 3u0xyyunyx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 30 Oct 2023 23:58:57 -0700 (PDT)
Received: from CD-MSH02.monolithicpower.com (10.10.70.19) by
 MPS-MSH04.monolithicpower.com (10.10.10.206) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Mon, 30 Oct 2023 23:58:55 -0700
Received: from CD-MSH04.monolithicpower.com (10.10.70.213) by
 CD-MSH02.monolithicpower.com (10.10.70.19) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Tue, 31 Oct 2023 14:58:53 +0800
Received: from CD-MSH04.monolithicpower.com ([fe80::69c9:32c5:3392:58d]) by
 CD-MSH04.monolithicpower.com ([fe80::69c9:32c5:3392:58d%2]) with mapi id
 15.01.2242.004; Tue, 31 Oct 2023 14:58:53 +0800
From:   "Yuxi (Yuxi) Wang" <Yuxi.Wang@monolithicpower.com>
To:     "pavel@ucw.cz" <pavel@ucw.cz>, "lee@kernel.org" <lee@kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "conor+dt@kernel.org" <conor+dt@kernel.org>
CC:     "linux-leds@vger.kernel.org" <linux-leds@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "wyx137120466@gmail.com" <wyx137120466@gmail.com>,
        "Yuxi (Yuxi) Wang" <Yuxi.Wang@monolithicpower.com>
Subject: [PATCH 0/2] leds: Add a driver for mp3326
Thread-Topic: [PATCH 0/2] leds: Add a driver for mp3326
Thread-Index: AdoLm4lJaIN3HyCNRxGHUTFD6lwVZg==
Date:   Tue, 31 Oct 2023 06:58:52 +0000
Message-ID: <b2a603bac3aa47e2bfbcbcd7154a4166@monolithicpower.com>
Accept-Language: en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.10.84.127]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Proofpoint-GUID: bxKeg3u0HYuvGmPBF0_9-VtJ6dx0ryBm
X-Proofpoint-ORIG-GUID: bxKeg3u0HYuvGmPBF0_9-VtJ6dx0ryBm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-30_13,2023-10-31_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 mlxlogscore=645
 spamscore=0 mlxscore=0 priorityscore=1501 bulkscore=0 lowpriorityscore=0
 malwarescore=0 impostorscore=0 phishscore=0 suspectscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2310240000
 definitions=main-2310310053
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the binding description and the corresponding driver for
the mps mp3326.

Signed-off-by: Yuxi Wang <Yuxi.Wang@monolithicpower.com>
Yuxi Wang (2):
  dt-bindings: leds: add mps mp3326 LED
  leds: add mp3326 driver

 .../devicetree/bindings/leds/leds-mp3326.yaml | 184 +++++
 drivers/leds/Kconfig                          |   7 +
 drivers/leds/Makefile                         |   1 +
 drivers/leds/leds-mp3326.c                    | 632 ++++++++++++++++++
 4 files changed, 824 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/leds/leds-mp3326.yaml
 create mode 100644 drivers/leds/leds-mp3326.c

--=20
2.25.1
