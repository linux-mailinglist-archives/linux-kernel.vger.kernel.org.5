Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD36879D5D2
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 18:09:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232199AbjILQJP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 12:09:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236619AbjILQIj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 12:08:39 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1486210EF;
        Tue, 12 Sep 2023 09:08:25 -0700 (PDT)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38CBetvv018629;
        Tue, 12 Sep 2023 16:08:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=Aqahmc+bVHOGCDFIrrRq/ENM69VGlp2R1Md1o2dov3I=;
 b=ILAEis0/NXcbjSXKVAp06HbwxEj3iq4SYhV6V2fwJe/t3cX2UvH4HP4hSB8IFVzkbFHw
 tl/CRHADjDp7VKACZCCBs1IZICoo7F03qg10dwwIgeOQahWzvbPDFlBrWxKWuHwCCEg8
 OlvZVHNgVlLdzit5lK2ePBVxdRpn/T7o8Xw2rjpk9ajJHyHb75x3Fch5S6Ugbm/fKc5a
 UhBmL8voQj9HR6LqpDT3MSiR5PxN+MQNhi+60/Wlu2XZBcqnj4KpPhxKu5/au+uDQijJ
 C5m2oXPKi6eTUHjyejzAYS1PQBDXDDPZfzZ0LLaTN016QTEupmQSJrl3fzLGQQtCyaHl XA== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3t29b0jpu0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 12 Sep 2023 16:08:19 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 38CG8ILA029750
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 12 Sep 2023 16:08:18 GMT
Received: from car-linux11.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Tue, 12 Sep 2023 09:08:16 -0700
From:   Nikunj Kela <quic_nkela@quicinc.com>
To:     <quic_tsoni@quicinc.com>
CC:     <agross@kernel.org>, <andersson@kernel.org>, <kernel@quicinc.com>,
        <konrad.dybcio@linaro.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <psodagud@quicinc.com>,
        <quic_aneelaka@quicinc.com>, <quic_kprasan@quicinc.com>,
        <quic_ninanaik@quicinc.com>, <quic_ppareek@quicinc.com>,
        Nikunj Kela <quic_nkela@quicinc.com>
Subject: Re: [RFC PATCH 0/1] Add driver to read secondary bootloader (XBL) log
Date:   Tue, 12 Sep 2023 09:08:00 -0700
Message-ID: <20230912160800.39412-1-quic_nkela@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <0abc0e3b-077c-d7b9-e561-2c2e01d46540@quicinc.com>
References: <0abc0e3b-077c-d7b9-e561-2c2e01d46540@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: kPYhFezR5uobgSaJqBFsct2vTTKS1VdV
X-Proofpoint-ORIG-GUID: kPYhFezR5uobgSaJqBFsct2vTTKS1VdV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-12_15,2023-09-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 phishscore=0
 adultscore=0 impostorscore=0 priorityscore=1501 mlxscore=0 mlxlogscore=430
 lowpriorityscore=0 bulkscore=0 spamscore=0 suspectscore=0 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2308100000
 definitions=main-2309120134
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nikunj Kela <quic_nkela@quicinc.com

I was planning something similar for dumping firmware VM's logs. These are in
ascii format too hence doesn't require any parsing/post processing. Can this
be little generic so I can use this driver?
