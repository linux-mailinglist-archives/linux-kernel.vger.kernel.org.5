Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E33C751BAB
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 10:35:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234093AbjGMIfC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 04:35:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234589AbjGMIei (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 04:34:38 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE71C271F;
        Thu, 13 Jul 2023 01:26:28 -0700 (PDT)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36D4o2NW020738;
        Thu, 13 Jul 2023 08:26:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=7AQMTGyO2zsOJbvEzDinA3ALL0BmMkla/fnN7kpiqQA=;
 b=Y66XgLu6JgPUL1x5FX3jJlM9bEjBj4x71i802S6tDlg81OF9ZYiujRsLiAIZXT0AM3Fg
 gXALC5j09244bP8On5MmrTkB/tQykqnpNtYOGzmNsCa9/odlWNelAB89MIVP0g9Q9Lpt
 NfZHHeUxMWcDDY+7DvddTsKVTsq+7zufYTJ6TJQ6gzhWYDrqMbRM9IeLGo/QEnQ1+xBz
 GupjjVaxgxHauTHiM7YGYmTHIzbsItkFiWceSDAxUA35W2vJVdOCF0uvU6Kbror3YHvK
 OLfAOXyDmAuHfWciwKnW08SRS2i7zZjeDSu+FeUK0Ir5GBPKQTGEfDwxkZXjb4bjDDjv Fg== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3rsgarbe1w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 13 Jul 2023 08:26:15 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 36D8QEvD023680
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 13 Jul 2023 08:26:14 GMT
Received: from [10.50.29.227] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.30; Thu, 13 Jul
 2023 01:25:51 -0700
Message-ID: <d8987058-ee49-cdbd-0fc1-ed80829473b5@quicinc.com>
Date:   Thu, 13 Jul 2023 13:55:34 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH V1 0/3] Add notifier call chain to Embedded USB Debug(EUD)
 driver
To:     Greg KH <gregkh@linuxfoundation.org>
CC:     <linux-arm-msm@vger.kernel.org>, <linux-usb@vger.kernel.org>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        "Bjorn Andersson" <andersson@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Sibi Sankar <quic_sibis@quicinc.com>,
        Rajendra Nayak <quic_rjendra@quicinc.com>
References: <cover.1689148711.git.quic_schowdhu@quicinc.com>
 <2023071218-woven-oversleep-444f@gregkh>
Content-Language: en-US
From:   Souradeep Chowdhury <quic_schowdhu@quicinc.com>
In-Reply-To: <2023071218-woven-oversleep-444f@gregkh>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 6RRIxD0o7JU_AbIR57FemM4CBhxE00Nk
X-Proofpoint-ORIG-GUID: 6RRIxD0o7JU_AbIR57FemM4CBhxE00Nk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-13_04,2023-07-11_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 suspectscore=0
 mlxlogscore=360 spamscore=0 priorityscore=1501 impostorscore=0
 phishscore=0 clxscore=1015 adultscore=0 malwarescore=0 lowpriorityscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2307130072
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/12/2023 10:10 PM, Greg KH wrote:
> On Wed, Jul 12, 2023 at 01:52:37PM +0530, Souradeep Chowdhury wrote:
>> This patch series adds the notifier chain to the Embedded USB Debug(EUD) driver.
>> The notifier chain is used to check the role switch status of EUD. Since EUD can
>> function only in device mode, other modules trying to do role-switch on the same
>> port have to first check the EUD status by calling this notifier chain and based
>> on the status proceed or block their role-switching step. The modules can call
>> the notifier through the call eud_notifier_call_chain and pass their own
>> role switch state as the argument. This chain will also be able to handle the
>> scenario of multiple modules switching roles on the same port since this can
>> create a priority and ordering among them for conflict resolution.
> 
> You are adding a new api that no one is actually using, so why would we
> accept this at all?
> 
> And how can we actually review it without any real users?

Ack. The next version of this will be posted along with the usage
of these apis for ordering the role-switch.

> 
> thanks,
> 
> greg k-h
