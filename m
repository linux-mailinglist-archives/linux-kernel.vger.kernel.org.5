Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C5A47CFA2A
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 15:01:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235451AbjJSNBM convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 19 Oct 2023 09:01:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345871AbjJSNAv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 09:00:51 -0400
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E2FCD61;
        Thu, 19 Oct 2023 06:00:18 -0700 (PDT)
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 39JAt1kL029094;
        Thu, 19 Oct 2023 08:58:19 -0400
Received: from nwd2mta3.analog.com ([137.71.173.56])
        by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 3ts56a6xn2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 19 Oct 2023 08:58:18 -0400 (EDT)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
        by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 39JCwHqf035654
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 19 Oct 2023 08:58:17 -0400
Received: from ASHBCASHYB5.ad.analog.com (10.64.17.133) by
 ASHBMBX8.ad.analog.com (10.64.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Thu, 19 Oct 2023 08:58:16 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by
 ASHBCASHYB5.ad.analog.com (10.64.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Thu, 19 Oct 2023 08:58:16 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Thu, 19 Oct 2023 08:58:16 -0400
Received: from ubuntu20.04.ad.analog.com ([10.32.226.241])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 39JCw2nS004952;
        Thu, 19 Oct 2023 08:58:05 -0400
From:   Eliza Balas <eliza.balas@analog.com>
To:     <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
CC:     Eliza Balas <eliza.balas@analog.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Derek Kiernan <derek.kiernan@amd.com>,
        Dragan Cvetic <dragan.cvetic@amd.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH v3 0/2] Add support for ADI TDD Engine
Date:   Thu, 19 Oct 2023 15:56:44 +0300
Message-ID: <20231019125646.14236-1-eliza.balas@analog.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-GUID: kVsjbM3ritvDNdrfYiitzuSz8kMQVgj6
X-Proofpoint-ORIG-GUID: kVsjbM3ritvDNdrfYiitzuSz8kMQVgj6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-19_11,2023-10-19_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 adultscore=0
 spamscore=0 phishscore=0 bulkscore=0 clxscore=1011 mlxscore=0
 lowpriorityscore=0 impostorscore=0 malwarescore=0 suspectscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2309180000 definitions=main-2310190111
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for Analog Devices TDD Engine.
This driver is created for a specific FPGA Core named
TDD Controller (Time-Division Duplex).
We choose the sysfs interface so that the users can access the device registers
directly, in an easy way, without using a complex interface. If there will be
other future revisions of the TDD FPGA Core, the register space will remain
compatible, so we don't break the current functionality of the driver.

Even though the device attributes might resamble a bit with the ones from
the iio subsystem, the device also contains a lot of attributes which are not
part of the iio subsystem.
We do not want to confuse this device with an IIO device, so we concluded that
the driver should reside in the misc subsystem.

V2 -> V3:
- change from dual-license to single license driver
- remove version number from the compatible string
- the driver should reside in the misc subsystem

Eliza Balas (2):
  dt-bindings: misc: adi,axi-tdd: Add device-tree binding for TDD engine
  drivers: misc: adi-axi-tdd: Add TDD engine

 .../sysfs-bus-platform-drivers-adi-axi-tdd    | 156 ++++
 .../devicetree/bindings/misc/adi,axi-tdd.yaml |  65 ++
 MAINTAINERS                                   |   9 +
 drivers/misc/Kconfig                          |  10 +
 drivers/misc/Makefile                         |   1 +
 drivers/misc/adi-axi-tdd.c                    | 780 ++++++++++++++++++
 6 files changed, 1021 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-bus-platform-drivers-adi-axi-tdd
 create mode 100644 Documentation/devicetree/bindings/misc/adi,axi-tdd.yaml
 create mode 100644 drivers/misc/adi-axi-tdd.c

-- 
2.25.1

