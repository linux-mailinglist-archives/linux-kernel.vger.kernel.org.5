Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BCE57A707F
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 04:29:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232279AbjITC3v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 22:29:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232415AbjITC3i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 22:29:38 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4115F12B;
        Tue, 19 Sep 2023 19:29:15 -0700 (PDT)
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38K2S8Rf003320;
        Wed, 20 Sep 2023 02:29:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=ZeuHGNNQIYn6AC2Wgt8zBkj72vfNGJb+GzJ8E/p0r0k=;
 b=LlfYsStlF53VM6wLLOzrFGtVQHJU6TUR6bSaDg1Z/gvyShhfNrm4YAQyDpowG0OWVU9G
 THNVu/YwaA2NoS8oApqqxgPDo21rNwiEtu9Sr/jFxOYXli5tEbdaqDO9yM0xJ7fDa2xs
 n2nrDd4DEBii6ExIkSNoiydv9+t/rL4q0vONIIF5iBgBhnwTpt/tZAzIOv34j1gQrT1m
 1KUq1nSTLj1m8HdYfVINkk2sKfvuchfxBQz/qD5f48NNwNoZwVevBMVdL089YUjTNEAl
 Rhzv+ckQjD6IM+uQogF5OdbdgmYCrYG1COUTqDmyzJprjyg/Gl8gEV754kAx8Cs6VuzR OA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3t7pea22uj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 20 Sep 2023 02:29:14 +0000
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 38K2KFNv013186;
        Wed, 20 Sep 2023 02:29:13 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3t7pea22ud-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 20 Sep 2023 02:29:13 +0000
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
        by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 38K27b6R010460;
        Wed, 20 Sep 2023 02:29:12 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
        by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 3t5rwk9gb0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 20 Sep 2023 02:29:12 +0000
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com [10.241.53.101])
        by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 38K2TCfR20447800
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 20 Sep 2023 02:29:12 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4F35858051;
        Wed, 20 Sep 2023 02:29:12 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E7F3B5805E;
        Wed, 20 Sep 2023 02:29:11 +0000 (GMT)
Received: from [9.61.135.7] (unknown [9.61.135.7])
        by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
        Wed, 20 Sep 2023 02:29:11 +0000 (GMT)
Message-ID: <eaa7c485-ce72-9caf-57de-3ab29cb815e1@linux.vnet.ibm.com>
Date:   Tue, 19 Sep 2023 22:29:11 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH] ima: Remove deprecated IMA_TRUSTED_KEYRING Kconfig
To:     Oleksandr Tymoshenko <ovt@google.com>, nayna@linux.ibm.com
Cc:     linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org, zohar@linux.ibm.com
References: <20230711164447.714035-1-nayna@linux.ibm.com>
 <20230919073238.2476335-1-ovt@google.com>
Content-Language: en-US
From:   Nayna <nayna@linux.vnet.ibm.com>
In-Reply-To: <20230919073238.2476335-1-ovt@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: LKMt1k38ux8P_HK3BAcqQMQducq5pOm7
X-Proofpoint-ORIG-GUID: tQMETAueg5Y_ecMbVcBKz9nNzHLPx5jA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-20_02,2023-09-19_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 phishscore=0
 mlxlogscore=526 bulkscore=0 mlxscore=0 lowpriorityscore=0 adultscore=0
 priorityscore=1501 spamscore=0 impostorscore=0 suspectscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2309200014
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 9/19/23 03:32, Oleksandr Tymoshenko wrote:
> Hello,
>
> There are two Kconfigs that depend on IMA_TRUSTED_KEYRING:
> IMA_LOAD_X509 and IMA_BLACKLIST_KEYRING. Removing IMA_TRUSTED_KEYRING
> makes them unreachable. Should they be removed too or should
> the dependency clauses be removed?
>
>
Thanks Oleksandr for noticing this. Since IMA_TRUSTED_KEYRING is 
deprecated in favor of INTEGRITY_TRUSTED_KEYRING, I think the dependency 
clause should be updated to use INTEGRITY_TRUSTED_KEYRING.

Thanks & Regards,

    - Nayna

