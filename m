Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77F627F0BD7
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 07:30:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231948AbjKTGay (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 01:30:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbjKTGaw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 01:30:52 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CEDBDB;
        Sun, 19 Nov 2023 22:30:49 -0800 (PST)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AK4gZOn006619;
        Mon, 20 Nov 2023 06:30:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=CGZmw3ytOPVedqQx5ULJZHM7lrN+SXFMFSXmJ04MZbM=;
 b=NP2pJE1O1x35xsRQ3EFCgBukE9fADn/yrxwXXbr/nMbT8lR5J7jWfJk42OyrDsxq2Ymn
 Valz7bbK+/whb9CJ/+cy9vIO59wy3IfZfY5eNExeMV/iyntvvlEBZjMU9YQ4tgoiUjZD
 smjqPI7cfABEve8ULgeUOJ2WJJiVNHFWH6wtM+eJPZq2QmcpBgJFoBHvs/hAm5Rc8yiA
 hTF1O884+uimnJREcDg6BkxgHCTtfPWPSnAhMEr+berE6qZFrGbl9d3rN8iNQwR+i0j3
 vRosMmIMDY9H2Cycy0cIxtXlE3Bp1YDFxTN2DfJn21es17pYQnsG04DkcagTjPGJRsN0 KQ== 
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3uem80k75k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 20 Nov 2023 06:30:17 +0000
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
        by NASANPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3AK6UG2f028003
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 20 Nov 2023 06:30:16 GMT
Received: from [10.216.31.13] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Sun, 19 Nov
 2023 22:30:10 -0800
Message-ID: <f1a1084f-ecf3-35dd-7822-a6b5931132a3@quicinc.com>
Date:   Mon, 20 Nov 2023 12:00:06 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [RFC PATCH 1/5] mtd: nand: ecc-qcom: Add support for ECC Engine
 Driver
To:     Miquel Raynal <miquel.raynal@bootlin.com>
CC:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <robh+dt@kernel.org>,
        <conor+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <richard@nod.at>, <vigneshr@ti.com>, <broonie@kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-mtd@lists.infradead.org>,
        <linux-spi@vger.kernel.org>, <quic_srichara@quicinc.com>,
        <qpic_varada@quicinc.com>
References: <20231031120307.1600689-1-quic_mdalam@quicinc.com>
 <20231031120307.1600689-2-quic_mdalam@quicinc.com>
 <b9af01d2-1a86-4b41-9bd6-3bf7a0dde1c0@linaro.org>
 <553c1373-c9a0-b2af-2286-058824e31bad@quicinc.com>
 <CAA8EJpp-xsP1x==a5DH8pKpy7XH75UF-L8ewKWmeL8ePtxUq-A@mail.gmail.com>
 <4b911907-44b9-c164-9648-3d399e557672@quicinc.com>
 <20231103144639.6ff40ae2@xps-13>
Content-Language: en-US
From:   Md Sadre Alam <quic_mdalam@quicinc.com>
In-Reply-To: <20231103144639.6ff40ae2@xps-13>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: qZd_ZsaCS1A1-fsxbZp9ZkFvA2ac1FxR
X-Proofpoint-ORIG-GUID: qZd_ZsaCS1A1-fsxbZp9ZkFvA2ac1FxR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-20_03,2023-11-17_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 mlxlogscore=999
 adultscore=0 priorityscore=1501 phishscore=0 malwarescore=0
 impostorscore=0 lowpriorityscore=0 mlxscore=0 spamscore=0 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311200039
X-Spam-Status: No, score=-6.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/3/2023 7:16 PM, Miquel Raynal wrote:
> Hello,
> 
>> Based on below feedback [1] and NAK on the device node patch
>> got idea of having separate device node for ECC is not acceptable.
>> Could you please help to clarify that.
> 
> If I may try to compare with the Macronix situation, the ECC engine
> was an independent hardware block, with its own mapping and its own
> registers, so it was described as an independent node in the DT. The
> type of ECC controller (pipelined or external) is described by the
> nand-ecc-engine property which either points at the parent node
> (pipelined) or an external node (external). The SPI host would itself
> point at the external ECC engine node with its own nand-ecc-engine
> property (see mtd/mxicy,nand-ecc-engine.yaml in the bindings).

Sorry for late reply.

Since QPIC controller ECC engine is not a separate HW block. To control ECC
functionality there is only one register 4-bytes long.As you suggested above,
ECC controller described by the property nand-ecc-engine.I have checked
mtd/mxicy,nand-ecc-engine.yaml file and got to know I can use like
nand-ecc-engine = <&qpic_nand>; in dts.Now additional ECC node not needed
in DTS. Will clean up everything in next patch.

> 
>> Since ECC block is inlined with QPIC controller so is the below
>> device node acceptable ?
>>
>>      bch: qpic_ecc {
>>                             compatible = "qcom,ipq9574-ecc";
>>                             status = "ok";
>>                     };
> 
> If it does not has its own mapping and if you access the ECC engine
> through the host registers then the controller should be part of the
> host node, but I am not sure it really needs to be described
> explicitly, most of them are not for historical reasons. Conceptually
> there is a problem with subnodes of each of these controllers having
> a signification already: SPI devices or NAND chips.

New device node for spi nand looks like as below.

&qpic_nand {
          status = "okay";
          pinctrl-0 = <&qspi_nand_pins>;
          pinctrl-names = "default";
          spi_nand: spi_nand@0 {
                  compatible = "spi-nand";
                  reg = <0>;
                  #address-cells = <1>;
                  #size-cells = <1>;
                  nand-ecc-engine = <&qpic_nand>;
                  nand-ecc-strength = <4>;
                  nand-ecc-step-size = <512>;
                  spi-max-frequency = <8000000>;
          };
};

With the above device node I have tested the spi nand device enumeration
its working fine. Will cleanup everything and post in next patch.


> 
> Thanks,
> Miquèl
