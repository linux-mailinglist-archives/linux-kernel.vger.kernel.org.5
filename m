Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D51C57B594D
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Oct 2023 19:42:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231926AbjJBRcI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 13:32:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231610AbjJBRcG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 13:32:06 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACDB494;
        Mon,  2 Oct 2023 10:32:03 -0700 (PDT)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 392GmiMl029262;
        Mon, 2 Oct 2023 17:31:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=p2VU07VW0j7CLsz+/d+8HTh3nDeofti/dtnqmepD624=;
 b=jfV+RugfkH84cHiPJdaXdgCPgL6TiqUDKjDfaPnkOD5nb7Av39LC6oHq6fz0Tv51u+3j
 WuoqjuWK+rv8wclBEk4jjsJmkrDe8SkCgIDazTX5Uqtb9JXyAWaCMD1wr/53mJJf+JG3
 xdiTvcsFWELXD6CeZPKEF9AY9HVcdBDwkHeJLIjyCn2eFuSEMvsgrb9Ly4dQH8THyBiW
 NamzEP13l0uKlPfI10Jawdm4naD/tXIBQYprO/expXErmd2g05uGjP+qDdLzW4aVkOS0
 7BcxyaEik5JloYUIJ1W/Q3s7HC4JpqYGpYVNAkJk6yTrOhMm3vREBzkNX+nFkLoPPfpC XA== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3te9cmmgwj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 02 Oct 2023 17:31:45 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 392HVjYt014078
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 2 Oct 2023 17:31:45 GMT
Received: from [10.110.71.113] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.30; Mon, 2 Oct
 2023 10:31:44 -0700
Message-ID: <74725381-bb13-2550-efd3-224e51af49d2@quicinc.com>
Date:   Mon, 2 Oct 2023 10:31:27 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v4 0/4] Add qcom hvc/shmem transport support
To:     Sudeep Holla <sudeep.holla@arm.com>,
        Brian Masney <bmasney@redhat.com>
CC:     "cristian.marussi@arm.com" <cristian.marussi@arm.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "conor+dt@kernel.org" <conor+dt@kernel.org>,
        "andersson@kernel.org" <andersson@kernel.org>,
        "konrad.dybcio@linaro.org" <konrad.dybcio@linaro.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>
References: <20230718160833.36397-1-quic_nkela@quicinc.com>
 <20230911194359.27547-1-quic_nkela@quicinc.com>
 <0efe305e-031b-bdf5-0268-ca1c6d562653@quicinc.com>
 <20230918151552.n3jvw2qqi5tmyfbb@bogus> <ZQhysWhFtR68iVMa@brian-x1>
 <20230919085612.gdmpze6c6stvammg@bogus>
Content-Language: en-US
From:   Nikunj Kela <quic_nkela@quicinc.com>
In-Reply-To: <20230919085612.gdmpze6c6stvammg@bogus>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: S5wDj1sQVnzaFZDD8F1Yurru0f_aDLQk
X-Proofpoint-ORIG-GUID: S5wDj1sQVnzaFZDD8F1Yurru0f_aDLQk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-02_12,2023-10-02_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0
 lowpriorityscore=0 adultscore=0 suspectscore=0 bulkscore=0 impostorscore=0
 mlxlogscore=698 priorityscore=1501 mlxscore=0 malwarescore=0 clxscore=1011
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2310020136
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 9/19/2023 1:56 AM, Sudeep Holla wrote:
> On Mon, Sep 18, 2023 at 11:54:25AM -0400, Brian Masney wrote:
>> On Mon, Sep 18, 2023 at 04:15:52PM +0100, Sudeep Holla wrote:
>>> On Mon, Sep 18, 2023 at 08:01:26AM -0700, Nikunj Kela wrote:
>>>> Gentle Ping!
>>>>
>>> I will take a look at this later this week. That said, I am unable be
>>> gauge the urgency based on you ping here. You have shown the same urgency
>>> last time for a feature that I queued promptly just to know that it was
>>> abandon within couple of days. So I don't want to rush here simply based
>>> on the number of pings here. I need to understand that it is really that
>>> important. For now, I am thinking of skipping even v6.7 just to allow
>>> some time for Qcom to make up its mind and be absolutely sure this is what
>>> they *really* want this time.
>> Hi Sudeep,
>>
>> Red Hat is interested in this patch set. Qualcomm is moving one of their
>> automotive platforms over to use SCMI and this will appear in that
>> product.
>>
> Thanks Brian, I trust Redhat over Qcom 😄. I will try to review and enable
> progress later this week. We can try to target next merge window.
>
> --
> Regards,
> Sudeep
Gentle Ping...
