Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF65A803B18
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 18:05:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230283AbjLDRF0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 12:05:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229488AbjLDRFY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 12:05:24 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1BEDBB;
        Mon,  4 Dec 2023 09:05:30 -0800 (PST)
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3B4GlQeQ027506;
        Mon, 4 Dec 2023 17:05:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=2llLb1kIui/MWBK5f5v9qS/SbcOOe6s6AriAs60t8Ug=;
 b=fzLLvkQb1DM2gdh/LTi4hceHSy7WHxg/kahmGee1PjA4qUbbTB55PtXtrnNEXf/vFYE7
 7p6cmnTVpEvtd18li++iH/lCJltYEvh0EOdcMjVH0emYOkYei84mtqqCI/fbhRlXsP7a
 Ya6CcvP7cL41Sd8VUMz+Q5ww8hFkhgX8ttGaBml8cjVGOsaI6ATtqCkLDSD7j984j6wa
 her+WZZm+hBox1T8CUvDHBtpv0YJJiqRELYPntWzWI627Wrq9ictmEuPf6UflSCOxIra
 UuIjPruLRF9x9Q/FrfIUQveElaXueB8git7XZrbTwUh8mxQ6LQl/wl9qJ3HE4mXYL2rZ uQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3usjkm0xfw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 04 Dec 2023 17:05:28 +0000
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3B4Glf3s029337;
        Mon, 4 Dec 2023 17:05:28 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3usjkm0x63-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 04 Dec 2023 17:05:27 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
        by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3B4GwtZ1030022;
        Mon, 4 Dec 2023 17:05:23 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
        by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3urgdksdkr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 04 Dec 2023 17:05:23 +0000
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com [10.39.53.232])
        by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3B4H5LjY17957484
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 4 Dec 2023 17:05:21 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E659C58061;
        Mon,  4 Dec 2023 17:05:20 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B071358043;
        Mon,  4 Dec 2023 17:05:19 +0000 (GMT)
Received: from [9.61.175.104] (unknown [9.61.175.104])
        by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
        Mon,  4 Dec 2023 17:05:19 +0000 (GMT)
Message-ID: <a4b9079e-2175-44dc-b59f-13644b9ea6c3@linux.ibm.com>
Date:   Mon, 4 Dec 2023 12:05:19 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] s390/vfio-ap: handle response code 01 on queue reset
Content-Language: en-US
To:     Halil Pasic <pasic@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>
Cc:     linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, jjherne@linux.ibm.com,
        alex.williamson@redhat.com, kwankhede@nvidia.com,
        frankja@linux.ibm.com, imbrenda@linux.ibm.com, david@redhat.com,
        Reinhard Buendgen <BUENDGEN@de.ibm.com>
References: <20231129143529.260264-1-akrowiak@linux.ibm.com>
 <b43414ef-7aa4-9e5c-a706-41861f0d346c@linux.ibm.com>
 <1f4720d7-93f1-4e38-a3ad-abaf99596e7c@linux.ibm.com>
 <05cfc382-d01d-4370-b8bb-d3805e957f2e@linux.ibm.com>
 <20231204171506.42aa687f.pasic@linux.ibm.com>
From:   Tony Krowiak <akrowiak@linux.ibm.com>
Organization: IBM
In-Reply-To: <20231204171506.42aa687f.pasic@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: SXw2yfieEr_ilkyrdHoK7SZ5XNph7GGM
X-Proofpoint-ORIG-GUID: VHLfMhw46t83gHS96TO14pddBVkFGPeI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-04_16,2023-12-04_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 priorityscore=1501 phishscore=0 spamscore=0 adultscore=0 malwarescore=0
 impostorscore=0 lowpriorityscore=0 mlxlogscore=999 bulkscore=0
 suspectscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2312040130
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/4/23 11:15, Halil Pasic wrote:
> On Mon, 4 Dec 2023 16:16:31 +0100
> Christian Borntraeger <borntraeger@linux.ibm.com> wrote:
> 
>> Am 04.12.23 um 15:53 schrieb Tony Krowiak:
>>>
>>>
>>> On 11/29/23 12:12, Christian Borntraeger wrote:
>>>> Am 29.11.23 um 15:35 schrieb Tony Krowiak:
>>>>> In the current implementation, response code 01 (AP queue number not valid)
>>>>> is handled as a default case along with other response codes returned from
>>>>> a queue reset operation that are not handled specifically. Barring a bug,
>>>>> response code 01 will occur only when a queue has been externally removed
>>>>> from the host's AP configuration; nn this case, the queue must
>>>>> be reset by the machine in order to avoid leaking crypto data if/when the
>>>>> queue is returned to the host's configuration. The response code 01 case
>>>>> will be handled specifically by logging a WARN message followed by cleaning
>>>>> up the IRQ resources.
>>>>>   
>>>>
>>>> To me it looks like this can be triggered by the LPAR admin, correct? So it
>>>> is not desireable but possible.
>>>> In that case I prefer to not use WARN, maybe use dev_warn or dev_err instead.
>>>> WARN can be a disruptive event if panic_on_warn is set.
>>>
>>> Yes, it can be triggered by the LPAR admin. I can't use dev_warn here because we don't have a reference to any device, but I can use pr_warn if that suffices.
>>
>> Ok, please use pr_warn then.
> 
> Shouldn't we rather make this an 'info'. I mean we probably do not want
> people complaining about this condition. Yes it should be a best practice
> to coordinate such things with the guest, and ideally remove the resource
> from the guest first. But AFAIU our stack is supposed to be able to
> handle something like this. IMHO issuing a warning is excessive measure.
> I know Reinhard and Tony probably disagree with the last sentence
> though.

I don't feel strongly one way or the other. Anybody else?

> 
> Regards,
> Halil
