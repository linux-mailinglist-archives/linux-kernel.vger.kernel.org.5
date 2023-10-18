Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 251BD7CE927
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 22:38:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232029AbjJRUid (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 16:38:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229721AbjJRUic (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 16:38:32 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF7C69B;
        Wed, 18 Oct 2023 13:38:30 -0700 (PDT)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39IKTOAG022689;
        Wed, 18 Oct 2023 20:37:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=e2EOl1tPILygjSh/0CYYTdKsXdjPmmVF/tri/fxozYM=;
 b=ROagZD8LnpTkHqP3kQT6vKcBml8ZoysU4p06A/YSExAhOnCMZYGQntaRhqfQe2yP1TT/
 uZdwyCiWEPcRJRlmB6nGwEpZTvB5Gfn2rredS6sR2IgZsGplB0I3A8ZRc6X9p6JJ3RHU
 buOk3aCbWiV1cM9Wfi6UGLMxg2lv8NNn5exEtaOB2o7UOt6lB3yDR7tdoK/r3lorp4Ew
 XbqwL1MPtIFicBZiKYdUVosCjX5AcMc/YLB/RuDV17GbcyUDfyeGQ53zLSaeHsJAfI+d
 ML5BzD/fGXHK5UhjUoyNMfFd5KifypxZzIqkiXdorCWTQQ4VDMnjFVh3h0G/4CO+mfiF 8w== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3tt905a35e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 18 Oct 2023 20:37:46 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 39IKbjG7003326
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 18 Oct 2023 20:37:45 GMT
Received: from [10.227.110.203] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.39; Wed, 18 Oct
 2023 13:37:44 -0700
Message-ID: <7e18fb84-b9ff-4f95-b94a-7459ab6154e1@quicinc.com>
Date:   Wed, 18 Oct 2023 13:37:43 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] [RFC] wireless: move obsolete drivers to staging
Content-Language: en-US
To:     Johannes Berg <johannes@sipsolutions.net>,
        Arnd Bergmann <arnd@arndb.de>,
        Geoff Levand <geoff@infradead.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>
CC:     Kalle Valo <kvalo@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@kernel.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Claudiu Beznea <claudiu.beznea@tuxon.dev>,
        Pavel Machek <pavel@ucw.cz>,
        "David S . Miller" <davem@davemloft.net>,
        Larry Finger <Larry.Finger@lwfinger.net>,
        <linux-kernel@vger.kernel.org>, <linux-wireless@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-staging@lists.linux.dev>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
References: <20231010155444.858483-1-arnd@kernel.org>
 <2023101051-unmasked-cleaver-79b3@gregkh> <87y1g94szz.fsf@kernel.org>
 <2023101139-pyromania-game-2237@gregkh> <87r0m1fwg9.fsf@kernel.org>
 <20231011080955.1beeb010@kernel.org> <87sf6g2hc8.fsf@kernel.org>
 <63e57ef8-c9f2-489a-8df8-51dcffd437c6@app.fastmail.com>
 <b1c87f71abef5aba6b39893a417466bf9f65c2d5.camel@sipsolutions.net>
 <CAMuHMdX3F9rvD3Fzbc1dwm7Vm73VW1x5ETbxkk-jJm3Bpr5i+A@mail.gmail.com>
 <d336126d58e12e8e67078c8142a524c667cc5639.camel@sipsolutions.net>
 <39719eae-f166-4059-a70d-c6b74ecd46e2@infradead.org>
 <2fb4f151-9146-4cce-a3e6-ca80a95cf590@app.fastmail.com>
 <789449f63ff6175ff46951507c03753f4430aa85.camel@sipsolutions.net>
From:   Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <789449f63ff6175ff46951507c03753f4430aa85.camel@sipsolutions.net>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: fiO2b6PTY8GstS0iygVw6A7oxrwtgyNF
X-Proofpoint-ORIG-GUID: fiO2b6PTY8GstS0iygVw6A7oxrwtgyNF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-18_18,2023-10-18_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 mlxscore=0
 phishscore=0 mlxlogscore=972 lowpriorityscore=0 suspectscore=0
 clxscore=1011 priorityscore=1501 impostorscore=0 adultscore=0
 malwarescore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2310180169
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/13/2023 11:02 AM, Johannes Berg wrote:
> On Fri, 2023-10-13 at 17:44 +0200, Arnd Bergmann wrote:
>> On Thu, Oct 12, 2023, at 18:36, Geoff Levand wrote:
>>> On 10/12/23 17:41, Johannes Berg wrote:
>>>> But seriously - is it worth to try to keep a wireless driver for it if
>>>> we don't even know anyone using a PS3 at all?
>>>
>>> There is still a considerable user base for the PS3, so we
>>> must keep the ps3-gelic-wireless driver.
>>
>> Do you know if anyone has tried changing this driver over to the
>> cfg80211 interface from the wireless extensions?
> 
> I looked at that yesterday, and sadly I _think_ it's not even possible,
> there are some corner cases in it like "no WPA2" that don't seem to be
> fully covered in cfg80211/nl80211, at least not with the APIs today and
> with current versions of wpa_supplicant.
> 
> It might still be doable because things like
> WPA_DRIVER_CAPA_KEY_MGMT_WPA2_PSK don't really seem to be used much in
> wpa_supplicant, but we'd have to carefully test that I guess.
> 
> Also, it depends on the PS3 firmware version whether or not that's
> supported.
> 
> Then again, arguably wifi without WPA2 is pretty much useless these
> days?

This is a good point. It doesn't matter if the clients work if there are 
no Access Points to connect to. And if you do have an old one you can 
connect to, it will be an insecure connection. Wardriving, anyone?

/jeff

