Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BD7880FB5F
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 00:27:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232490AbjLLX11 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 18:27:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231664AbjLLX1X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 18:27:23 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAFF9FD;
        Tue, 12 Dec 2023 15:27:27 -0800 (PST)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 3BCH5n9c013622;
        Tue, 12 Dec 2023 23:27:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
        message-id:date:mime-version:subject:from:to:cc:references
        :in-reply-to:content-type:content-transfer-encoding; s=
        qcppdkim1; bh=SWhMvNaoYsP+58utWELVB8tF6xTUlOKZmRPgNdYB/MM=; b=Cd
        w8Bx7J27a3PIgZ4Ea88ItRJ5WCvxIj5nSccJKHeTsVu4XmD3MOPJ2LjaZriSb7yV
        iQ6ryUW/I4N+6jBRCzS5IX9hGhh5+IeJJ9WVsMsEKrJwOt8/sn8QB/v4T8Kpggqx
        fwIrYC9fWCmdTCMvryB2DbEsdj32GN4aOy5L4b6UZJmsXlvgocCcANbP2pvfuxNR
        9EY/5yCH6msj43h9w9RlrfRpWSnn0D8NUwCpRrKunzPa+x87wU3/09sk66XfEDM8
        iAHpQ3LmiDMRyIc2siukc+zOfCuFAUf0J7Tby33lSgbBJUOSKggOID8TORraEC4J
        FUI+epEv7MhrcDQCOqsw==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3uxctatx5g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 12 Dec 2023 23:27:02 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3BCNR1VO024896
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 12 Dec 2023 23:27:01 GMT
Received: from [10.110.106.103] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Tue, 12 Dec
 2023 15:27:00 -0800
Message-ID: <ada88ef1-d290-441a-b6f1-97d7f478cccc@quicinc.com>
Date:   Tue, 12 Dec 2023 15:26:59 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC - is this a bug?] wifi: ath10k: Asking for some light on
 this, please :)
Content-Language: en-US
From:   Jeff Johnson <quic_jjohnson@quicinc.com>
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        Kalle Valo <kvalo@kernel.org>
CC:     <ath10k@lists.infradead.org>, <linux-wireless@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        <linux-hardening@vger.kernel.org>
References: <626ae2e7-66f8-423b-b17f-e75c1a6d29b3@embeddedor.com>
 <26b15f4702cef17fe70b496a62f03735874bd16a.camel@sipsolutions.net>
 <07e9bb04-f9fc-46d5-bfb9-a00a63a707c0@embeddedor.com>
 <f8daa53ee8a8019e4fd2b823c1fcb85a6cc4d806.camel@sipsolutions.net>
 <8219c79e-0359-4136-afa4-fba76fde191a@embeddedor.com>
 <afaadf5e-556c-4fd6-bfd3-9c486a35a08f@quicinc.com>
In-Reply-To: <afaadf5e-556c-4fd6-bfd3-9c486a35a08f@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 5ea7PuvC2gPKd5hS6zoaxzmbgueU3cQu
X-Proofpoint-ORIG-GUID: 5ea7PuvC2gPKd5hS6zoaxzmbgueU3cQu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_01,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 malwarescore=0
 lowpriorityscore=0 phishscore=0 impostorscore=0 bulkscore=0 mlxscore=0
 adultscore=0 suspectscore=0 priorityscore=1501 clxscore=1011
 mlxlogscore=789 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2312120183
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/25/2023 8:52 AM, Jeff Johnson wrote:
> On 10/24/2023 7:37 PM, Gustavo A. R. Silva wrote:
>>
>>
>> On 10/24/23 14:49, Johannes Berg wrote:
>>> On Tue, 2023-10-24 at 14:41 -0600, Gustavo A. R. Silva wrote:
>>>>
>>>> It seems we run into the same issue in the function below, even in the
>>>> case this `memset()` is unnecessary (which it seems it's not):
>>>>
>>>>     8920         memset(skb->data, 0, sizeof(*cmd));
>>>>
>>>> Notice that if `cap->peer_chan_len == 0` or `cap->peer_chan_len == 1`,
>>>> in the original code, we have `len == sizeof(*cmd) == 128`:
>>>
>>> Right.
>>>
>>>> -       /* tdls peer update cmd has place holder for one channel*/
>>>> -       chan_len = cap->peer_chan_len ? (cap->peer_chan_len - 1) : 0;
>>>> -
>>>> -       len = sizeof(*cmd) + chan_len * sizeof(*chan);
>>>> +       len = struct_size(cmd, peer_capab.peer_chan_list, 
>>>> cap->peer_chan_len);
>>>>
>>>>           skb = ath10k_wmi_alloc_skb(ar, len);
>>>>           if (!skb)
>>>>
>>>> which makes `round_len == roundup(len, 4) == struct_size(cmd,...,...) 
>>>> == 104`
>>>> when `cap->peer_chan_len == 0`
>>>
>>> And yeah, that's really the issue, it only matters for ==0. For a moment
>>> there I thought that doesn't even make sense, but it looks like it never
>>> even becomes non-zero.
>>>
>>> No idea then, sorry. You'd hope firmware doesn't care about the actual
>>> message size if the inner data says "0 entries", but who knows? And how
>>> many firmware versions are there? :)
>>>
>>> So I guess you'd want to stay compatible, even if it means having a
>>>
>>>     chan_len = min(cap->peer_chan_len, 1);
>>>
>>> for the struct_size()?
>>
>> Yeah, that's an alternative.
>>
>> I'll wait for the maintainers to chime in and see if they have a different
>> opinion.
> 
> I'm seeing clarification from the development team.
> 
> /jeff
> 

I was not able to get a response from the firmware team.

I have gone ahead and created a series of patches to fix the remaining
flexible array issues in ath10k including the one discussed here. I
should be able to post those sometime this week.

/jeff
