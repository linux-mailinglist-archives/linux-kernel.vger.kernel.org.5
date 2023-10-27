Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7483E7D8D6F
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 05:31:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345210AbjJ0DbL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Oct 2023 23:31:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233035AbjJ0DbJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 23:31:09 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C8D9FA;
        Thu, 26 Oct 2023 20:31:06 -0700 (PDT)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39R2m0oh018108;
        Fri, 27 Oct 2023 03:30:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=eA+4m9BmAzgsT7qVo/Hpcl7NxxBTDV/IxifAscaxspg=;
 b=AVgA+Ky2T2NXZCP+Mw7ceRu+RaWr+qnjvBKKXWeoMU71AvH4kG6ioZ8B46FNkv6+kBfi
 /crr3ljvtFVc1NkrFgSxSZ6kvyYMAc8mF0oAp/x5KWaf8K+mX+fCuDwQu4aJifQqnjaL
 +B0N80AFHzFaOpRFS0FClk5GGlTSSUVGqNePT1Lud1GA+bO/HJaucB8BIh8qBk9MeYXs
 KDiDE2aLsFbUbFyeo3IL1i2ln79l9cqmdAhD0w02CGeIee02FqCTJIJfyEH3lSfr4GH6
 uK8xh4x7MzBe7NPdLEk07KPZAZM9ihEe9Rw2kStyGMPEFgyPRPNktT5qHh+3N86fxOfz ow== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3tyx3u8wy3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 27 Oct 2023 03:30:55 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 39R3Us0q022324
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 27 Oct 2023 03:30:55 GMT
Received: from [10.249.29.6] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.39; Thu, 26 Oct
 2023 20:30:49 -0700
Message-ID: <75890f37-6d71-45b3-a68a-86d64fe1649a@quicinc.com>
Date:   Fri, 27 Oct 2023 09:00:46 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 6/8] arm: dts: qcom: Add pmic glink support for sm8450-qrd
Content-Language: en-US
To:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>
CC:     <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Andy Gross <agross@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Rob Herring <robh+dt@kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <quic_ppratap@quicinc.com>, <quic_jackp@quicinc.com>,
        <quic_wcheng@quicinc.com>, Conor Dooley <conor+dt@kernel.org>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>
References: <20231017131851.8299-1-quic_kriskura@quicinc.com>
 <20231017131851.8299-6-quic_kriskura@quicinc.com>
 <c1929d63-93a4-4425-bdd1-d76a696b528e@linaro.org>
From:   Krishna Kurapati PSSNV <quic_kriskura@quicinc.com>
In-Reply-To: <c1929d63-93a4-4425-bdd1-d76a696b528e@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 2SUW2Ob2UFprIsV8INYpVMJYB6t3tRb1
X-Proofpoint-GUID: 2SUW2Ob2UFprIsV8INYpVMJYB6t3tRb1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-26_22,2023-10-26_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 bulkscore=0
 mlxlogscore=498 suspectscore=0 spamscore=0 mlxscore=0 phishscore=0
 priorityscore=1501 malwarescore=0 impostorscore=0 clxscore=1015
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2310240000 definitions=main-2310270029
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/27/2023 1:11 AM, Konrad Dybcio wrote:
> 
> 
> On 10/17/23 15:18, Krishna Kurapati wrote:
>> Add Pmic Glink support for sm8450-qrd to facilitate passing
>> of roe switch notifications generated by ADSP to dwc3 core
>> via ucsi and pmic glink's.
>>
>> Signed-off-by: Krishna Kurapati <quic_kriskura@quicinc.com>
>> ---
> No phy+redriver+dp configuration?
> 
Hi Konrad,

  Did you mean adding the following node:

         typec-mux@42 {
                 compatible = "fcs,fsa4480";
                 reg = <0x42>;

                 interrupts-extended = <&tlmm 2 IRQ_TYPE_LEVEL_LOW>;

                 vcc-supply = <&vreg_bob>;
                 mode-switch;
                 orientation-switch;

                 port {
                         fsa4480_sbu_mux: endpoint {
                                 remote-endpoint = <&pmic_glink_sbu>;
                         };
                 };
         };


and then adding port-2 for pmic_glink ?

Usually for role-switch the port-0/1 defined in this patch are 
sufficient. Also if I added it, I don't have a way to currently test it. 
So skipped this node. I will try and see if I can test it and add it if 
possible.

Regards,
Krishna,
