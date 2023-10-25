Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50B957D6D06
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 15:22:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343844AbjJYNWK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 09:22:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233953AbjJYNWJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 09:22:09 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3FD5116;
        Wed, 25 Oct 2023 06:22:07 -0700 (PDT)
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39PD6lX4004426;
        Wed, 25 Oct 2023 13:22:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=buXHtXxmivbJEdS9h1J93aPaDy39QdlVwWR4uC0gIOQ=;
 b=MlQkPZajgNopFucrzaL3RyWzvdG5p/JpXIKsNvIS84ryRN8q274eCMK75rd1PP3W77O/
 aWWp1TOX+O3y8vj6xxi42Z+dMU40Imd2JuvyimfLUdMWB0eLmhkM8M4vJDk6ptm4iAd7
 ls/DmdX2Je7qAkgcLQWO02Ae7NIQIr7oo6a/h+jJyxQ/3S/Y+LyVmE0rAZVB4gwYMIT6
 xVOL7r1BNDx3BeWRIGDv30N6sVP8R0Feqd6thk3sqQH0CgF6GwML7A29KDX9WS/Skr5T
 Om27A+jkNXyQoNL2ge4VkL1aFQxVs3Mgtt04GYb8xAPvyke9A9dum/6PVBNZOYJEyql0 EA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ty3dfgw06-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 25 Oct 2023 13:22:06 +0000
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 39PDKksU029602;
        Wed, 25 Oct 2023 13:21:03 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ty3dfgtv1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 25 Oct 2023 13:21:03 +0000
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
        by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 39PD1Lqc010231;
        Wed, 25 Oct 2023 13:20:20 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
        by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3tvsbypyw5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 25 Oct 2023 13:20:20 +0000
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com [10.241.53.102])
        by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 39PDKKna53608948
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 25 Oct 2023 13:20:20 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 11FA758056;
        Wed, 25 Oct 2023 13:20:20 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 464445805A;
        Wed, 25 Oct 2023 13:20:19 +0000 (GMT)
Received: from [9.171.58.254] (unknown [9.171.58.254])
        by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
        Wed, 25 Oct 2023 13:20:19 +0000 (GMT)
Message-ID: <4fbae6da-4dbd-9901-2d5b-d17cfb240223@linux.ibm.com>
Date:   Wed, 25 Oct 2023 15:20:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH] drivers: s390: dasd_int.h: resolved spelling mistake
To:     Muhammad Muzammil <m.muzzammilashraf@gmail.com>,
        hoeppner@linux.ibm.com
Cc:     linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20231010043140.28416-1-m.muzzammilashraf@gmail.com>
Content-Language: en-US
From:   Stefan Haberland <sth@linux.ibm.com>
In-Reply-To: <20231010043140.28416-1-m.muzzammilashraf@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: HQDYs-_FIKY4a9_MMDa4DiRPZqoBFow8
X-Proofpoint-GUID: tfzM6o2-xT2sE8A8yZenjYkzk7PBNAVZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-25_02,2023-10-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=653 adultscore=0
 suspectscore=0 spamscore=0 bulkscore=0 priorityscore=1501 mlxscore=0
 malwarescore=0 impostorscore=0 clxscore=1011 phishscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2310170001 definitions=main-2310250116
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H4,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 10.10.23 um 06:31 schrieb Muhammad Muzammil:
> resolved typing mistake from pimary to primary
>
> Signed-off-by: Muhammad Muzammil <m.muzzammilashraf@gmail.com>
> ---

applied, thanks


