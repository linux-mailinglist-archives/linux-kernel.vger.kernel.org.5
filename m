Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13AD277F341
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 11:28:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349586AbjHQJ2D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 05:28:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349671AbjHQJ1u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 05:27:50 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C78135A4;
        Thu, 17 Aug 2023 02:27:29 -0700 (PDT)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37H7R5i6003986;
        Thu, 17 Aug 2023 09:27:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=J6QMAny841RchvVIu8ddE4A/vgQ4wHS2MBRiVplP9P0=;
 b=jj1k8jvqsfGv+fvM6GOqnkSo5saq1aKNeZsmwwY9fG0GAqRfKtVTvBZKcR2djswIVR3d
 j0ZsKqHauCN+L8WTUd90IN+/M3UHuLZ2Gy3uR3nQCcUiG3bSyp7gvOw5DFxZtoc2OHZL
 WOQbvoBjpMbtzMBz8xGTzD/LrDPDbzOyuWVwWFaHOUnt9ifjQnxysH+mk4DNOfFC5ndc
 kyj9GcwLlLw0mlhA7V1rlcdCuUywYXzpfc9wBapyZqX4NtqL9XlsiOrPOKkGDLKxwhrl
 h8ulDE0o6iQf01X9s/IO9K90qSA2IigkviNpe0dN+optsESjSdQhKsBCMUTFVfB0Fdcc WA== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3sgvrgtk4h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 17 Aug 2023 09:27:10 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 37H9R9Na004953
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 17 Aug 2023 09:27:09 GMT
Received: from [10.201.206.238] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.36; Thu, 17 Aug
 2023 02:27:02 -0700
Message-ID: <72bf4ae4-c319-7726-f37a-532bfb83b726@quicinc.com>
Date:   Thu, 17 Aug 2023 14:56:59 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.2
Subject: Re: [PATCH v5 00/11] Add multipd remoteproc support
To:     <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <mathieu.poirier@linaro.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>, <mturquette@baylibre.com>,
        <sboyd@kernel.org>, <quic_eberman@quicinc.com>,
        <quic_gurus@quicinc.com>, <kvalo@kernel.org>,
        <loic.poulain@linaro.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-remoteproc@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-clk@vger.kernel.org>
CC:     <quic_srichara@quicinc.com>, <quic_sjaganat@quicinc.com>,
        <quic_kathirav@quicinc.com>, <quic_anusha@quicinc.com>,
        <quic_varada@quicinc.com>
References: <20230802140606.2041889-1-quic_mmanikan@quicinc.com>
Content-Language: en-US
From:   Manikanta Mylavarapu <quic_mmanikan@quicinc.com>
In-Reply-To: <20230802140606.2041889-1-quic_mmanikan@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 6gwqojkVw_BR6qG3HLNdBOOoQzarxd6X
X-Proofpoint-ORIG-GUID: 6gwqojkVw_BR6qG3HLNdBOOoQzarxd6X
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-17_03,2023-08-15_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 adultscore=0
 bulkscore=0 phishscore=0 impostorscore=0 malwarescore=0 mlxlogscore=912
 lowpriorityscore=0 clxscore=1011 priorityscore=1501 spamscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2308170084
X-Spam-Status: No, score=-6.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 8/2/2023 7:35 PM, Manikanta Mylavarapu wrote:
> APSS brings Q6 out of reset and then Q6 brings
> WCSS block (wifi radio's) out of reset.
> 
> 				   ---------------
> 			      -->  |WiFi 2G radio|
> 			      |	   --------------
> 			      |
> --------	-------	      |
> | APSS | --->   |QDSP6|  -----|
> ---------	-------       |
>                                |
>        			      |
> 			      |   --------------
> 			      --> |WiFi 5G radio|
> 				  --------------
> 
> Problem here is if any radio crashes, subsequently other
> radio also should crash because Q6 crashed. Let's say
> 2G radio crashed, Q6 should pass this info to APSS. Only
> Q6 processor interrupts registered with APSS. Obviously
> Q6 should crash and raise fatal interrupt to APSS. Due
> to this 5G radio also crashed. But no issue in 5G radio,
> because of 2G radio crash 5G radio also impacted.
> 
> In multi pd model, this problem is resolved. Here WCSS
> functionality (WiFi radio's) moved out from Q6 root pd
> to a separate user pd. Due to this, radio's independently
> pass their status info to APPS with out crashing Q6. So
> other radio's won't be impacted.
> 
> Pd means protection domain. It's similar to process in Linux.
> Here QDSP6 processor runs each wifi radio functionality on a
> separate process. One process can't access other process
> resources, so this is termed as PD i.e protection domain.
> 
>   APPS				QDSP6
> -------                      -------------
> |     |	 Crash notification  |		|	----------
> |     |<---------------------|----------|-------|WiFi    |
> |     |			     |		|    |->|2G radio|
> |     |			     |	-------	|    | 	----------
> |     |	     		     |	|     |	|    |
> |Root |	 Start/stop  Q6	     |	|  R  | |    |
> |PD   |<---------------------|->|     | |    |
> |rproc|  Crash notification  |	|  O  | |    |
> |     |			     |	|     |	|    |
> |User |Start/stop UserPD1(2G)|  |  O  | |    |
> |PD1  |----------------------|->|     |-|----|
> |rproc|			     |	|  T  |	|    |
> |     |			     |	|     | |    |
> |User |Start/stop UserPD2(5G)|	|  P  | |    |
> |PD2  |----------------------|->|     |-|----|
> |rproc|			     |	|  D  |	|    |
> |     |			     |	-------	|    |	-----------
> |     |	Crash notification   |		|    |->|WiFi	  |
> |     |<---------------------|----------|-------|5G radio |
> -------			     |		|	-----------
>                               ------------
> According to linux terminology, here consider Q6 as root
> i.e it provide all services, WCSS (wifi radio's) as user
> i.e it uses services provided by root.
> 
> Since Q6 root & WCSS user pd's able to communicate with
> APSS individually, multipd remoteproc driver registers
> each PD with rproc framework. Here clients (Wifi host drivers)
> intrested on WCSS PD rproc, so multipd driver start's root
> pd in the context of WCSS user pd rproc start. Similarly
> on down path, root pd will be stopped after wcss user pd
> stopped.
> 
> Here WCSS(user) PD is dependent on Q6(root) PD, so first
> q6 pd should be up before wcss pd. After wcss pd goes down,
> q6 pd should be turned off.
> 
> IPQ5332, IPQ9574 supports multipd remoteproc driver.
> 
> Manikanta Mylavarapu (11):
>    dt-bindings: remoteproc: qcom: Add support for multipd model
>    clk: qcom: ipq5332: remove q6 bring up clocks
>    clk: qcom: ipq9574: remove q6 bring up clocks
>    dt-bindings: clock: qcom: gcc-ipq5332: remove q6 bring up clock macros
>    dt-bindings: clock: qcom: gcc-ipq9574: remove q6 bring up clock macros
>    firmware: qcom_scm: ipq5332: add support to pass metadata size
>    firmware: qcom_scm: ipq5332: add msa lock/unlock support
>    remoteproc: qcom: q6v5: Add multipd interrupts support
>    remoteproc: qcom: Add Hexagon based multipd rproc driver
>    arm64: dts: qcom: ipq5332: Add nodes to bringup multipd
>    arm64: dts: qcom: ipq9574: Add nodes to bring up multipd
> 
>   .../bindings/remoteproc/qcom,multipd-pil.yaml | 189 +++++
>   arch/arm64/boot/dts/qcom/ipq5332-rdp441.dts   |  21 +
>   arch/arm64/boot/dts/qcom/ipq5332.dtsi         |  60 ++
>   arch/arm64/boot/dts/qcom/ipq9574.dtsi         |  59 ++
>   drivers/clk/qcom/gcc-ipq5332.c                | 380 ---------
>   drivers/clk/qcom/gcc-ipq9574.c                | 326 -------
>   drivers/firmware/qcom_scm.c                   |  86 ++
>   drivers/firmware/qcom_scm.h                   |   3 +
>   drivers/remoteproc/Kconfig                    |  19 +
>   drivers/remoteproc/Makefile                   |   1 +
>   drivers/remoteproc/qcom_q6v5.c                |  41 +-
>   drivers/remoteproc/qcom_q6v5.h                |  11 +
>   drivers/remoteproc/qcom_q6v5_mpd.c            | 802 ++++++++++++++++++
>   include/dt-bindings/clock/qcom,ipq5332-gcc.h  |  20 -
>   include/dt-bindings/clock/qcom,ipq9574-gcc.h  |  18 -
>   include/linux/firmware/qcom/qcom_scm.h        |   2 +
>   16 files changed, 1291 insertions(+), 747 deletions(-)
>   create mode 100644 Documentation/devicetree/bindings/remoteproc/qcom,multipd-pil.yaml
>   create mode 100644 drivers/remoteproc/qcom_q6v5_mpd.c

Gentle reminder for review!

Thanks & Regards,
Manikanta.
