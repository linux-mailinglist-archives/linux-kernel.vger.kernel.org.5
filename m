Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67E4C80387E
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 16:18:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234058AbjLDPSD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 10:18:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231952AbjLDPSB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 10:18:01 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 124F9C4;
        Mon,  4 Dec 2023 07:18:08 -0800 (PST)
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3B4EaxpP007637;
        Mon, 4 Dec 2023 15:18:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=I/sXY+Kh8J75VSEyLVd7/w3trSvJ0f5d8SGIv6k2tGY=;
 b=D4VQrGKShWa1T6NTU+v+wd2oLYxN5OFh3AR60rpMQjhNU/y7EawGO/JqSPLsOmwm+y0h
 84SzaJXFuPwmwJkUOkMZmNS671q7Yrk5O3gp5rzdjsm/wLbmziLdO2EdHdkH3VOOzlsD
 4qSkr3IQOgSNPAwxAZWZ/zUK5z8to+gTvaTjmVZisHKxeU18m+GbKdjLNLh2Wxj6zsbJ
 7hwJKVH0Gb78yFsIl4BSq+LD4Z+5FWooiUHxeMUuRIsLtLh1Vnye9S3HlwFfXdPur+Xw
 Rw6lfDyZ79FUBK9Y8Qb4W0hP4EcN3lla1W17nxxZT05ndvJJtVPOz3mgMJfneqI+ITGr Bw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3usgpe9cbt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 04 Dec 2023 15:18:05 +0000
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3B4EjLqC007108;
        Mon, 4 Dec 2023 15:18:03 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3usgpe9bpu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 04 Dec 2023 15:18:00 +0000
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
        by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3B4EJb8F025411;
        Mon, 4 Dec 2023 15:16:35 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
        by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 3urewt92k1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 04 Dec 2023 15:16:35 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
        by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3B4FGW0v18678464
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 4 Dec 2023 15:16:32 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 45FCD2004E;
        Mon,  4 Dec 2023 15:16:32 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id EDCD520040;
        Mon,  4 Dec 2023 15:16:31 +0000 (GMT)
Received: from [9.152.224.41] (unknown [9.152.224.41])
        by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Mon,  4 Dec 2023 15:16:31 +0000 (GMT)
Message-ID: <05cfc382-d01d-4370-b8bb-d3805e957f2e@linux.ibm.com>
Date:   Mon, 4 Dec 2023 16:16:31 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] s390/vfio-ap: handle response code 01 on queue reset
To:     Tony Krowiak <akrowiak@linux.ibm.com>, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc:     jjherne@linux.ibm.com, pasic@linux.ibm.com,
        alex.williamson@redhat.com, kwankhede@nvidia.com,
        frankja@linux.ibm.com, imbrenda@linux.ibm.com, david@redhat.com
References: <20231129143529.260264-1-akrowiak@linux.ibm.com>
 <b43414ef-7aa4-9e5c-a706-41861f0d346c@linux.ibm.com>
 <1f4720d7-93f1-4e38-a3ad-abaf99596e7c@linux.ibm.com>
Content-Language: en-US
From:   Christian Borntraeger <borntraeger@linux.ibm.com>
In-Reply-To: <1f4720d7-93f1-4e38-a3ad-abaf99596e7c@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: T3irD9HktJgoSrzN99e6fLnpq2CfJSCz
X-Proofpoint-ORIG-GUID: Kdym7ofmItUL1hJKd0JqErUSUlB4IT5t
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-04_14,2023-12-04_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 mlxlogscore=999 priorityscore=1501 clxscore=1015 impostorscore=0
 suspectscore=0 spamscore=0 mlxscore=0 phishscore=0 malwarescore=0
 adultscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2312040115
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Am 04.12.23 um 15:53 schrieb Tony Krowiak:
> 
> 
> On 11/29/23 12:12, Christian Borntraeger wrote:
>> Am 29.11.23 um 15:35 schrieb Tony Krowiak:
>>> In the current implementation, response code 01 (AP queue number not valid)
>>> is handled as a default case along with other response codes returned from
>>> a queue reset operation that are not handled specifically. Barring a bug,
>>> response code 01 will occur only when a queue has been externally removed
>>> from the host's AP configuration; nn this case, the queue must
>>> be reset by the machine in order to avoid leaking crypto data if/when the
>>> queue is returned to the host's configuration. The response code 01 case
>>> will be handled specifically by logging a WARN message followed by cleaning
>>> up the IRQ resources.
>>>
>>
>> To me it looks like this can be triggered by the LPAR admin, correct? So it
>> is not desireable but possible.
>> In that case I prefer to not use WARN, maybe use dev_warn or dev_err instead.
>> WARN can be a disruptive event if panic_on_warn is set.
> 
> Yes, it can be triggered by the LPAR admin. I can't use dev_warn here because we don't have a reference to any device, but I can use pr_warn if that suffices.

Ok, please use pr_warn then.
