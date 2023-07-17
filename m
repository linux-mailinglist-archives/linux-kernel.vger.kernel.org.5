Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 223FB75681C
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 17:38:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230284AbjGQPig (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 11:38:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229670AbjGQPie (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 11:38:34 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DAF0EC
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 08:38:33 -0700 (PDT)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36HEvBZu021228;
        Mon, 17 Jul 2023 15:38:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=qcppdkim1;
 bh=0fbSLUsHk5+aAh1Bv430lalQz/DMhxbQhNWIGzN5ChM=;
 b=ESkd9kzvGSuTqZ81PwWUsT6N6EovrxswZxPl8rDcOvxJbfg9OtpMAcR+8U3//feT4pPH
 iQNwf05KuJ43nFY04ZvVjnYYmjtByn7kLpVT/wlJSmJidcP29qXovBFHxJWbPEtOahWS
 piyEkCTpTPVOTOnuxc+VOTVL0eUFyxNwBL9l4Z7+XeoSKv+RjSLdAZ3mgSQ6HnYdlKgx
 QTQIAELBG7ioePzu3+BA1dESv6i4gANkma5u4hwLae7/HPYA3zJ2KJ7/I997CuwWXsKX
 XqxKVH7K5yhyO1BM1WLbKNEDAl7Un5XtNKY0l5IDrRJxlYMCzKlDthCqnTFHPNXwL+sz dA== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3rw33mgv4k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 17 Jul 2023 15:38:16 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 36HFcFXb008341
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 17 Jul 2023 15:38:15 GMT
Received: from sridsn-linux.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Mon, 17 Jul 2023 08:38:12 -0700
From:   Sridharan S N <quic_sridsn@quicinc.com>
To:     <tudor.ambarus@linaro.org>, <pratyush@kernel.org>,
        <michael@walle.cc>, <miquel.raynal@bootlin.com>, <richard@nod.at>,
        <vigneshr@ti.com>, <linux-mtd@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
CC:     Sridharan S N <quic_sridsn@quicinc.com>
Subject: [PATCH 0/2] Add support for gigadevice and macronix SPI-NOR
Date:   Mon, 17 Jul 2023 21:05:34 +0530
Message-ID: <20230717153536.25700-1-quic_sridsn@quicinc.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: Q0f8jo4xFOLTs7NE7mmZQSNV-J3rJt3p
X-Proofpoint-ORIG-GUID: Q0f8jo4xFOLTs7NE7mmZQSNV-J3rJt3p
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-17_12,2023-07-13_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 priorityscore=1501 clxscore=1011 lowpriorityscore=0 bulkscore=0
 adultscore=0 phishscore=0 spamscore=0 mlxlogscore=819 suspectscore=0
 malwarescore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2307170142
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series add support for SPI NOR devices mentioned below:

gigadevice:
gd25lb256e   - This supports quad read and uniform 4K-byte erase.
gd25d{2,4}0c - These supports dual read and uniform 4K-byte erase.

macronix:
mx66u1g45g - This chip supports stateless 4-byte opcodes, dual and quad
             read and uniform 4K-byte erase.
Sridharan S N (2):
  mtd: spi-nor: gigadevice: Add support for gd25lb256e and gd25d{2,4}0c
  mtd: spi-nor: macronix: Add support for mx66u1g45g

 drivers/mtd/spi-nor/gigadevice.c | 6 ++++++
 drivers/mtd/spi-nor/macronix.c   | 3 +++
 2 files changed, 9 insertions(+)

-- 
2.17.1

