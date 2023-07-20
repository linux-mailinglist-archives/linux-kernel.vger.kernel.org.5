Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 563DB75AB7C
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 11:55:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229652AbjGTJzG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 05:55:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229503AbjGTJzE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 05:55:04 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E203EA2;
        Thu, 20 Jul 2023 02:55:02 -0700 (PDT)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36K7SYIg023406;
        Thu, 20 Jul 2023 09:54:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=cJY51DTALiME3j4X6NH/CagxAQEjwHwyhncEMLUCyT0=;
 b=I9qofbxOyk4gpFKL7ulZRgyHo5FUt3ONFmR5xAm7iDh9C4JFU0+4aDvlQt64ZtVoaZKq
 zz2AoiwgJLbdDNIGpqRKeB1S00TtGvf12aQZ3gdhAPXYjEfbASPSsP/I+j/l+Wby0D/2
 0IeM8AfOcdk6xTetQIOkEjWNB4YOYIl0e4beKsYHdM/CFhyRts5LJNww5drvTT6LvfYY
 DkGrBfhXegKDi71sNlW1qhVIt65tX44ix7wuERk7vki8YlgsWrTEiTHQhSWHsOo3a0sX
 I3bcgqA4LtsXeFsZGOk1NE9a5XG43QaUdB2hlKCC/2N/HkMFTivQ4kYkYYGRIP5jkgd0 oQ== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3rxg3va6tc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 20 Jul 2023 09:54:57 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 36K9susA002462
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 20 Jul 2023 09:54:56 GMT
Received: from [10.50.14.220] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.30; Thu, 20 Jul
 2023 02:54:52 -0700
Message-ID: <304f3664-d04b-db74-24bb-a16c3982651a@quicinc.com>
Date:   Thu, 20 Jul 2023 15:24:49 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] pinctrl: qcom: Add intr_target_width field to support
 increased number of interrupt targets
Content-Language: en-US
To:     Bjorn Andersson <andersson@kernel.org>
CC:     <agross@kernel.org>, <konrad.dybcio@linaro.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-gpio@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <quic_ppareek@quicinc.com>,
        <psodagud@quicinc.com>, <quic_kprasan@quicinc.com>,
        <quic_ymg@quicinc.com>, Andrew Halaney <ahalaney@redhat.com>,
        Bjorn Andersson <quic_bjorande@quicinc.com>
References: <20230718064246.12429-1-quic_ninanaik@quicinc.com>
 <fskuol2q4wbfilrz3x3dcmikhjgfsajgnuqjnp4petxr2ne6at@zfnonisxnjh3>
From:   Ninad Naik <quic_ninanaik@quicinc.com>
In-Reply-To: <fskuol2q4wbfilrz3x3dcmikhjgfsajgnuqjnp4petxr2ne6at@zfnonisxnjh3>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: c1HiPTXAGjSrHTC3JqmvboXz4zMooUyX
X-Proofpoint-ORIG-GUID: c1HiPTXAGjSrHTC3JqmvboXz4zMooUyX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-20_03,2023-07-19_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 malwarescore=0 spamscore=0 bulkscore=0 adultscore=0 mlxscore=0
 suspectscore=0 clxscore=1015 lowpriorityscore=0 priorityscore=1501
 mlxlogscore=999 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2306200000 definitions=main-2307200083
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bjorn,

On 7/18/2023 9:02 PM, Bjorn Andersson wrote:
> On Tue, Jul 18, 2023 at 12:12:46PM +0530, Ninad Naik wrote:
>> SA8775 and newer target have added support for an increased number of
>> interrupt targets. To implement this change, the intr_target field, which
>> is used to configure the interrupt target in the interrupt configuration
>> register is increased from 3 bits to 4 bits.
>>
>> In accordance to these updates, a new intr_target_width member is
>> introduced in msm_pingroup structure. This member stores the value of
>> width of intr_target field in the interrupt configuration register. This
>> value is used to dynamically calculate and generate mask for setting the
>> intr_target field. By default, this mask is set to 3 bit wide, to ensure
>> backward compatibility with the older targets.
>>
>> Changes in v2 :
>> -----------------
>> - Changed initial definition of intr_target_mask variable to use GENMASK().
>> - Update commit subject appropiately.
>> - Add Fixes tag.
>> - v1 : https://lore.kernel.org/all/20230714061010.15817-1-quic_ninanaik@quicinc.com/
> 
> Thanks for adding a good changelog, very much appreciated. The changelog
> should be added below the '---' line though, as it typically don't add
> value to the git history (except drivers/gpu/* which wants it here...).
> 
Apologies for the mistake. I will make a note of this and correct going 
forward.
> Perhaps Linus can drop it as he applies the patch, no need to resubmit
> unless he ask you to.
> 
> Thanks,
> Bjorn

Thanks,
Ninad
