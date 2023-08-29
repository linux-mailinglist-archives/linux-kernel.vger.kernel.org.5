Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0748278BFCF
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 10:02:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233912AbjH2IBx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 04:01:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232958AbjH2IBZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 04:01:25 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 500C411B;
        Tue, 29 Aug 2023 01:01:22 -0700 (PDT)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37T7E1mQ022809;
        Tue, 29 Aug 2023 08:01:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=el8ddIIj/h5JdTa9/21J8cFJ29Iln5ST4fO3NIzqOu8=;
 b=NfDv0uzN7mQ0jJhLYKt4s3LyP4KwwIZ+rrOhcgIHAcTz4wyyIdcsp/VHc0pBAkqDuLl9
 k7uIFSilcrOKp3Np6OaLGVm8Gl/d7kAzQoTtkc+9ozpLLU5/VnU3AtHQPdl3M2azHufc
 EfNGOYX1LmDjpqcm2T2pBb8WT5xUj1Amw49MBnOdrEg82yILT4SJszdPAheiFUwDQlkc
 danf9iItpI5A8mxGGejT+sxLa7pw5cnHRjB6J8hbXhHO4bxeiv5kDNAc7gcxROTELtJv
 LFc/cKGspfhPj06vU//vR8TQOt+hpUiNWTeXj5s0uuJqWT1ThrxuMACrz/DbYRuyRW+z 1w== 
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ss4wq0sv3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 29 Aug 2023 08:01:16 +0000
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
        by NASANPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 37T815m7032348
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 29 Aug 2023 08:01:05 GMT
Received: from [10.50.3.213] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.36; Tue, 29 Aug
 2023 01:01:01 -0700
Message-ID: <9391ae4e-afbd-ef52-12dc-7f8875216c85@quicinc.com>
Date:   Tue, 29 Aug 2023 13:30:56 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v2 4/4] venus: hfi_parser: Add check to keep the number of
 codecs within range
To:     Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        <stanimir.k.varbanov@gmail.com>, <agross@kernel.org>,
        <andersson@kernel.org>, <konrad.dybcio@linaro.org>,
        <mchehab@kernel.org>, <hans.verkuil@cisco.com>,
        <tfiga@chromium.org>
CC:     <linux-media@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>
References: <1691634304-2158-1-git-send-email-quic_vgarodia@quicinc.com>
 <1691634304-2158-5-git-send-email-quic_vgarodia@quicinc.com>
 <fec4a8c7-206f-7af8-4ea9-c919a677bf7e@linaro.org>
 <2214c31b-eca2-012e-a100-21252a724e7c@quicinc.com>
 <8b72ce47-c338-2061-f11a-c0a608686d8c@linaro.org>
 <e880da07-ccd4-e427-ed34-20b284dc7838@quicinc.com>
 <8f1a4ca0-dde8-fa5d-bca3-d317886609de@linaro.org>
 <060f4dbe-63d6-1c60-14ca-553bf1536e5a@quicinc.com>
 <c5f912a9-cc08-1645-ad04-c7a58c1e47ce@linaro.org>
 <cd9da205-ccdb-dc71-16a4-83b22ca7fcae@quicinc.com>
 <ea587bb1-8ff2-7a92-f948-fd932f6b2769@linaro.org>
Content-Language: en-US
From:   Vikash Garodia <quic_vgarodia@quicinc.com>
In-Reply-To: <ea587bb1-8ff2-7a92-f948-fd932f6b2769@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: Rr2zTLgUK7ezY1KVBOncEpkr24FEZ5F-
X-Proofpoint-ORIG-GUID: Rr2zTLgUK7ezY1KVBOncEpkr24FEZ5F-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-29_05,2023-08-28_04,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 suspectscore=0 phishscore=0 lowpriorityscore=0 bulkscore=0 clxscore=1015
 spamscore=0 malwarescore=0 priorityscore=1501 mlxscore=0 adultscore=0
 mlxlogscore=553 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2308290068
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bryan,

On 8/14/2023 7:45 PM, Bryan O'Donoghue wrote:
> On 14/08/2023 07:34, Vikash Garodia wrote:
>>> We have two loops that check for up to 32 indexes per loop. Why not have a
>>> capabilities index that can accommodate all 64 bits ?
>> Max codecs supported can be 32, which is also a very high number. At max the
>> hardware supports 5-6 codecs, including both decoder and encoder. 64 indices is
>> would not be needed.
>>
> 
> But the bug you are fixing here is an overflow where we have received a full
> range 32 bit for each decode and encode.
> 
> How is the right fix not to extend the storage to the maximum possible 2 x 32 ?
> Or indeed why not constrain the input data to 32/2 for each encode/decode path ?
At this point, we agree that there is very less or no possibility to have this
as a real usecase i.e having 64 (or more than 32) codecs supported in video
hardware. There seem to be no value add if we are extending the cap array from
32 to 64, as anything beyond 32 itself indicates rogue firmware. The idea here
is to gracefully come out of such case when firmware is responding with such
data payload.
Again, lets think of constraining the data to 32/2. We have 2 32 bit masks for
decoder and encoder. Malfunctioning firmware could still send payload with all
bits enabled in those masks. Then the driver needs to add same check to avoid
the memcpy in such case.

> The bug here is that we can copy two arrays of size X into one array of size X.
> 
> Please consider expanding the size of the storage array to accommodate the full
> size the protocol supports 2 x 32.
I see this as an alternate implementation to existing handling. 64 index would
never exist practically, so accommodating it only implies to store the data for
invalid response and gracefully close the session.

Thanks,
Vikash
