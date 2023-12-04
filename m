Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C59EB8033A1
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 13:58:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234886AbjLDM6F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 07:58:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233080AbjLDM6D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 07:58:03 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37EC8AB;
        Mon,  4 Dec 2023 04:58:09 -0800 (PST)
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3B4Bl5j7005004;
        Mon, 4 Dec 2023 12:58:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=q4URhR+r27RnDPPO5D6bRhaD2i+Lple6nHcQvk9E+a0=;
 b=dCIme22qv2WcynLkilELoqBDX8YZAYiZlHpemAEWRpDYZLqsv9TNHYJWVz+FMWFUFf+Z
 HmtH50NL/tYLmKFb8NAIZ51bh35IwlIpLwuVDF11v/mxCdMKgAkIjvhSf4qyeYM/r3RV
 b++eZJistfN8+G+w14BPYk1mFFTu8wM9Xa5PgIj5aEjkzbJLV+VvVKv3zhmC41e6hA2c
 EhGQC/gYAnCnYu5+z0oYJHCWzjGG7uP13U1xbUGgPn5eVk/q3r0VJdjR6Ih9RqWZAgJr
 RHX72nO+FVsw98ROKOXdQYSdovt7I4FKK9EHG85JrjV0L+Vrt32+Wlqr5wx1PYP3bWPC Aw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3use6wtgqv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 04 Dec 2023 12:58:05 +0000
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3B4Bn759015265;
        Mon, 4 Dec 2023 12:58:05 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3use6wtgq6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 04 Dec 2023 12:58:05 +0000
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
        by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3B4An3U1005119;
        Mon, 4 Dec 2023 12:58:04 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
        by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 3urhm1ykac-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 04 Dec 2023 12:58:04 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
        by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3B4Cw1OT11076298
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 4 Dec 2023 12:58:01 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3D8352004E;
        Mon,  4 Dec 2023 12:58:01 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1C53B20040;
        Mon,  4 Dec 2023 12:58:00 +0000 (GMT)
Received: from [9.179.21.199] (unknown [9.179.21.199])
        by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Mon,  4 Dec 2023 12:58:00 +0000 (GMT)
Message-ID: <f61e8e26-47d7-4970-84b4-a57bd06df235@linux.ibm.com>
Date:   Mon, 4 Dec 2023 13:57:59 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3 7/7] net/smc: manage system EID in SMC stack
 instead of ISM driver
Content-Language: en-US
To:     Wen Gu <guwen@linux.alibaba.com>, wenjia@linux.ibm.com,
        hca@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, kgraul@linux.ibm.com, jaka@linux.ibm.com
Cc:     borntraeger@linux.ibm.com, svens@linux.ibm.com,
        alibuda@linux.alibaba.com, tonylu@linux.alibaba.com,
        raspl@linux.ibm.com, schnelle@linux.ibm.com,
        linux-s390@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <1701343695-122657-1-git-send-email-guwen@linux.alibaba.com>
 <1701343695-122657-8-git-send-email-guwen@linux.alibaba.com>
 <aab0905a-b77f-4504-a510-83c98f79b2b7@linux.ibm.com>
 <8efa4f88-4ab1-bdd9-5705-93d62909bfa9@linux.alibaba.com>
From:   Alexandra Winter <wintera@linux.ibm.com>
In-Reply-To: <8efa4f88-4ab1-bdd9-5705-93d62909bfa9@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 018Lg9gMNUViD-hU27xCDQ3WDSysOva0
X-Proofpoint-ORIG-GUID: rQ1Pl3Ug0i3RM7vmqNFQHoUq3SawYH6d
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-04_11,2023-12-04_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 phishscore=0 clxscore=1015 bulkscore=0 impostorscore=0 adultscore=0
 spamscore=0 suspectscore=0 mlxscore=0 mlxlogscore=820 malwarescore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2312040097
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 04.12.23 13:36, Wen Gu wrote:
>> Here we only check the first smcd device to determine whether we support v2.
>> Which is ok, for today's platform firmware ISM devices, as they are always the same version.
>>
>> When you add virtual ISM devices (loopback-ism, virtio-ism) then this needs to be changed.
>> IMO the logic then needs to be "if all smcd devices support v2,
>> then smc_ism_v2_capable = true;
>> else smc_ism_v2_capable = false;"
>>
> 
> Thank you. I will change this in the loopback-ism patch set.
> 
> But I am wondering if loopback-ism coexists with s390 ISMv1, why smc_ism_v2_capable shouldn't be set?
> Is it because the SEID generated in this way is not correct if the s390 ISMv2 does not exist?

I think you're right: 'At least one IMSv2 device' is sufficient for smc_ism_v2_capable.

Actually, we could even always do smc_ism_v2_capable=true, and append an empty ISMv2 device list.
(I am not sure that would be a good idea...)

Interesting sceanrios to consider for ism-loopback:
e.g.: 2 ISMv1 device and 1 ism-loopback...
