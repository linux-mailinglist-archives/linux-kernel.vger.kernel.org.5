Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2663E7D4360
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 01:41:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231946AbjJWXlq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 19:41:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231952AbjJWXlf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 19:41:35 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 430BB173B;
        Mon, 23 Oct 2023 16:41:06 -0700 (PDT)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39NMOBLW023733;
        Mon, 23 Oct 2023 23:40:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=j7FVUJkCTJZmDebRwT+dehweCjUOAjdNji6l4GnsWBs=;
 b=brAceV1jasEnCZMlO88OAGAE6lmAwNH6WI1nNWOkE2ZhhJs2QLPIB9qdl5zOEbXsNr/s
 hUTHy+QWbkfgYY+sIb662LY+dWdSqEYE7ESScv1zhiJ5q59ug0PbD5b7tU5vDbFXrM7h
 46Av9r7FSgjC8nFFlLWDXXyTK6Mj8iTdEX/02EjUKvVWN7P84N1S5jYtN2OZ32iD1dfb
 Ae4f+3wMInLJT/Q2SFjLMGOPO9ka031g+dRJR7w4O6z8lQ4JuzBj14A4MjcBUOJCywhl
 PuoFCRlJvWf6qYgQPkteDnLwYdwXs/yZ7oYcwLALClGkO45f+z6hqiaLFgbWFDnEwZU3 /w== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3twxa0ghns-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 23 Oct 2023 23:40:56 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 39NNetaK006422
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 23 Oct 2023 23:40:55 GMT
Received: from [10.48.243.236] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.39; Mon, 23 Oct
 2023 16:40:55 -0700
Message-ID: <2f407e7c-9bc7-4915-a043-5a7cec2cb2b1@quicinc.com>
Date:   Mon, 23 Oct 2023 16:40:54 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ath10k: replace deprecated strncpy with strtomem_pad
Content-Language: en-US
To:     Kees Cook <keescook@chromium.org>
CC:     Justin Stitt <justinstitt@google.com>,
        Kalle Valo <kvalo@kernel.org>, <ath10k@lists.infradead.org>,
        <linux-wireless@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-hardening@vger.kernel.org>
References: <20231013-strncpy-drivers-net-wireless-ath-ath10k-mac-c-v1-1-24e40201afa3@google.com>
 <1cfc7c64-439c-437e-af82-7fce1202242d@quicinc.com>
 <202310181626.C5BE0C21F@keescook>
From:   Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <202310181626.C5BE0C21F@keescook>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: izofka88cARvIfp8FMQHlje-5qAtYmxL
X-Proofpoint-ORIG-GUID: izofka88cARvIfp8FMQHlje-5qAtYmxL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-23_21,2023-10-19_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 malwarescore=0
 mlxscore=0 phishscore=0 mlxlogscore=477 impostorscore=0 clxscore=1015
 bulkscore=0 adultscore=0 spamscore=0 priorityscore=1501 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2310170001
 definitions=main-2310230208
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/18/2023 4:35 PM, Kees Cook wrote:
> On Fri, Oct 13, 2023 at 05:58:03PM -0700, Jeff Johnson wrote:
>>> Let's also mark ath10k_vif.u.ap.ssid as __nonstring.
>>
>> what criteria is used to determine whether or not to use __nonstring?
>> doesn't the use of u8 vs char already communicate that distinction?
>> just want to know what other u8 arrays might require this.
>> FWIW the documentation referenced by the __nonstring macro explicitly refers
>> to "type array of char, signed char, or unsigned char"
> 
> The use of __nonstring is for byte arrays that are _not_ expected to be
> %NUL terminated. Unfortunately "char" vs "u8" isn't distinguished by the
> compiler. All byte arrays are treated as C strings unless __nonstring is
> used.

So is the plan to annotate every single binary blob array in the kernel 
as __nonstring? I suspect those outnumber string arrays.

