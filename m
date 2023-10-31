Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2ECE7DCCBD
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 13:14:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344141AbjJaMEK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Oct 2023 08:04:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344182AbjJaMEA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 08:04:00 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 294235585;
        Tue, 31 Oct 2023 05:03:58 -0700 (PDT)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39VAAe1l025386;
        Tue, 31 Oct 2023 12:03:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding;
 s=qcppdkim1; bh=llA1mruceqzWtsjBtNGzppf1koFXpqBRTnaDNw4knRg=;
 b=GhrB0fHEC/PZ/L8bqR8tq8xVgkueOy0nhxBuy4KPHqGicHPplHyQe3pycNYhpTADvHSH
 Gond4VZiym8qJIhmGODCQprETjWkMJDK90PlPj/hIsoNEQomDFgPv01InUwUlrO8FbCO
 L5k6Ch4w6vwgwqIs/cpjpSowQyW5yLafJ7pdw+hxwYtyrBtf3q+fWuvvyDv7G+1O6348
 230SRviKRXHvL+401d5rYj7hBBE1DsUzFoKcvejxL0kICMo1NK3d5dJG/tEVTMIT3p19
 2cHkEubJ0BjHOcEBB837bnreA2/OWa5AH/xhFM5ryZ6aOhhU+GqUyqsEudH1jhmCH6UP Ew== 
Received: from apblrppmta02.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3u2fuvjc1m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 31 Oct 2023 12:03:13 +0000
Received: from pps.filterd (APBLRPPMTA02.qualcomm.com [127.0.0.1])
        by APBLRPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 39VC395s005243;
        Tue, 31 Oct 2023 12:03:09 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by APBLRPPMTA02.qualcomm.com (PPS) with ESMTPS id 3u0uckvvnw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 31 Oct 2023 12:03:09 +0000
Received: from APBLRPPMTA02.qualcomm.com (APBLRPPMTA02.qualcomm.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 39VC39uW005238;
        Tue, 31 Oct 2023 12:03:09 GMT
Received: from hu-devc-blr-u22-a.qualcomm.com (hu-mdalam-blr.qualcomm.com [10.131.36.157])
        by APBLRPPMTA02.qualcomm.com (PPS) with ESMTPS id 39VC39iF005237
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 31 Oct 2023 12:03:09 +0000
Received: by hu-devc-blr-u22-a.qualcomm.com (Postfix, from userid 466583)
        id D1F82414B1; Tue, 31 Oct 2023 17:33:08 +0530 (+0530)
From:   Md Sadre Alam <quic_mdalam@quicinc.com>
To:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        robh+dt@kernel.org, conor+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, miquel.raynal@bootlin.com,
        richard@nod.at, vigneshr@ti.com, broonie@kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org,
        linux-spi@vger.kernel.org, quic_srichara@quicinc.com,
        qpic_varada@quicinc.com
Cc:     quic_mdalam@quicinc.com
Subject: [RFC PATCH 0/5] Add QPIC SPI NAND driver support
Date:   Tue, 31 Oct 2023 17:33:02 +0530
Message-Id: <20231031120307.1600689-1-quic_mdalam@quicinc.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 7JBJdyffZDxCCJL6xqn39Pao-CvL2emj
X-Proofpoint-GUID: 7JBJdyffZDxCCJL6xqn39Pao-CvL2emj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-31_01,2023-10-31_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 bulkscore=0
 spamscore=0 suspectscore=0 lowpriorityscore=0 clxscore=1011 mlxscore=0
 priorityscore=1501 phishscore=0 mlxlogscore=607 adultscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2310240000 definitions=main-2310310094
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Miquel,

This series is RFC for QPIC NAND driver design for
both SPI NAND and RAW NAND.

We have already discuss this design in the below link

https://patchwork.kernel.org/project/linux-arm-msm/patch/1602307902-16761-3-git-send-email-mdalam@codeaurora.org/#25270814

Since QPIC controller support both raw and as wel as
serial nand, In these patch series I am trying to write
these driver as per above discussion.

As per this design we are having new drivrs for:

1) SPI-NAND Driver
2) RAW-NAND Driver
3) QPIC-COMMON-API Driver
4) ECC ENGINE Driver

Could you plese review these RFC patches and let me know
if i am doing as per design and my code are proper so that
i can proceed further.

I have testd SPI NAND enumeration with this new design.

Command supported currently by spi nand driver
1) RESET
2) READ ID
3) GET FEATURE
4) SET FEATURE

Currently READ_PAGE, WRITE_PAGE are dummy API. Will write
this later on after your review.

One more thisng wanted to add here Since for QPIC ECC engine
its not a separte HW IP, and only one register is there to control ECC
enable/disable. So for just for one register writing a separte driver
is fine or not?
In dt I have added like as below 

 bch: qpic_ecc {
                      compatible = "qcom,ipq9574-ecc";
                      status = "ok";
              };

Is this ok ?

Thanks,
Alam.

Md Sadre Alam (5):
  mtd: nand: ecc-qcom: Add support for ECC Engine Driver
  arm64: dts: qcom: ipq9574: Add ecc engine support
  mtd: nand: qpic_common: Add support for qpic common API
  spi: qpic: Add support for qpic spi nand driver
  arm64: dts: qcom: ipq9574: Add support for SPI nand

 arch/arm64/boot/dts/qcom/ipq9574-rdp433.dts |  56 +-
 arch/arm64/boot/dts/qcom/ipq9574.dtsi       |  33 +
 drivers/mtd/nand/Kconfig                    |   7 +
 drivers/mtd/nand/Makefile                   |   1 +
 drivers/mtd/nand/ecc-qcom.c                 | 198 +++++
 drivers/mtd/nand/qpic_common.c              | 840 ++++++++++++++++++++
 drivers/spi/Kconfig                         |   7 +
 drivers/spi/Makefile                        |   1 +
 drivers/spi/spi-qpic-snand.c                | 604 ++++++++++++++
 include/linux/mtd/nand-qpic-common.h        | 641 +++++++++++++++
 10 files changed, 2360 insertions(+), 28 deletions(-)
 create mode 100644 drivers/mtd/nand/ecc-qcom.c
 create mode 100644 drivers/mtd/nand/qpic_common.c
 create mode 100644 drivers/spi/spi-qpic-snand.c
 create mode 100644 include/linux/mtd/nand-qpic-common.h

-- 
2.34.1

