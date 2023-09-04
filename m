Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B7AE7919E9
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Sep 2023 16:44:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350381AbjIDOop (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Sep 2023 10:44:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238076AbjIDOoo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Sep 2023 10:44:44 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1857E1707;
        Mon,  4 Sep 2023 07:44:38 -0700 (PDT)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 384Cvbwe026209;
        Mon, 4 Sep 2023 14:44:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=pEH8wCvB9G7cNPAhCZQR1sm1VmgCR+QbsrW7+My6K3c=;
 b=nvlD3k67C31Wor7cXNQXucllRjxnc5mnE7yrbYlzAlbnCnHDt0amPJKi9r1iP0ua/q7x
 OIRlnEQlvc0BkEdv9Dl+8SOdm/cLs09L9DwaXtdQa6YIRwnUmKaSS2/FqioBL1MspqxM
 1W8X/33q66OJVZD5oEYRtgQywEOfzDxdp4E4L+vE8hgQXgrAnsFu11Bpy07a/+YAWnAk
 gJzJKPplrY9dvEbS8b9/Eusl+Ryh0Vmtq2W6cnZv/XePIzqy/RU/Gek+DOKXFIwxvty/
 z3Cgi7Wp+hvG5ldKmW37OYzdg7kCmhTfh7P1FSQ4OhHyXvisMTVBSkE9KB7s0nOJgIkM zg== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3suvcrbn5s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 04 Sep 2023 14:44:31 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 384EiU3E025691
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 4 Sep 2023 14:44:30 GMT
Received: from [10.218.45.181] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.36; Mon, 4 Sep
 2023 07:44:26 -0700
Message-ID: <a352b67b-4da9-d477-b953-b8003d4de91c@quicinc.com>
Date:   Mon, 4 Sep 2023 20:14:23 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.2
Subject: Re: [PATCH V6 4/6] scsi: ufs: qcom: Align unipro clk attributes
 configuration as per HPG
Content-Language: en-US
To:     Bjorn Andersson <quic_bjorande@quicinc.com>
CC:     <mani@kernel.org>, <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <jejb@linux.ibm.com>,
        <martin.petersen@oracle.com>, <quic_cang@quicinc.com>,
        <quic_nguyenb@quicinc.com>, <linux-scsi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        "Naveen Kumar Goud Arepalli" <quic_narepall@quicinc.com>
References: <20230901114336.31339-1-quic_nitirawa@quicinc.com>
 <20230901114336.31339-5-quic_nitirawa@quicinc.com>
 <20230901154358.GU818859@hu-bjorande-lv.qualcomm.com>
From:   Nitin Rawat <quic_nitirawa@quicinc.com>
In-Reply-To: <20230901154358.GU818859@hu-bjorande-lv.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: f7Rc_J0VrKNtHAsNXXRGm9afeF3Dmo_1
X-Proofpoint-ORIG-GUID: f7Rc_J0VrKNtHAsNXXRGm9afeF3Dmo_1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-04_07,2023-08-31_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 malwarescore=0
 priorityscore=1501 mlxlogscore=999 impostorscore=0 suspectscore=0
 lowpriorityscore=0 mlxscore=0 spamscore=0 clxscore=1015 adultscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2309040131
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/1/2023 9:13 PM, Bjorn Andersson wrote:
> On Fri, Sep 01, 2023 at 05:13:34PM +0530, Nitin Rawat wrote:
>> Currently CORE_CLK_1US_CYCLES, PA_VS_CORE_CLK_40NS_CYCLES are configured
>> in clk scaling post change ops.
>>
>> Move this to clk scaling pre change ops to align completely with hardware
>> specification. This doesn't bring any functionality change.
>>
> 
> How can applying the clock scaling configuration, and "aligning with
> hardware specification" not "bring any functionality change"?
> 
> If the code is called in a way where there is no difference between pre
> and post callbacks, then state that - but it begs the question, why do
> we have this "flexible" (complex) callback scheme if it doesn't matter.
> 
> Regards,
> Bjorn

Hi Bjorn,

Here my intention is to align the sequence completely with HPG. 
Functionality w.r.t to clock scaling is not impacted here.
I'll update the commit text to capture more details in next patchset.

Thanks,
Nitin
