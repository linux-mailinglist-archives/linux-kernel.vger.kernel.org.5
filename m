Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 799357AF6B5
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 01:23:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229808AbjIZXX6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Sep 2023 19:23:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232524AbjIZXV4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Sep 2023 19:21:56 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 836145274;
        Tue, 26 Sep 2023 15:23:57 -0700 (PDT)
Received: from pps.filterd (m0353723.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38QLJDwm008181;
        Tue, 26 Sep 2023 21:36:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=HdYo7IF3hvnNdrc0T8ThUqLB1fvlrLKGIPhITVuMjN8=;
 b=NTKpIytOOZuX/yP+0E+Jkq6/im6xcHz8j2qloyPZ0kRf7vo8yxJvy7unQIYWcUgu3L+3
 YuRtJCYXIsgV9YdYXIvf9zITmfijhh5r8ArKf/thA21jr9aOd4uu06Fh/0434HcGIVlr
 wM55xURNC7dBgx5Fc1eVA9sqyYLk4DHB0+3k6vrI5GZ/73O9wbljhS2A0aaShWFKrWFl
 LDQ725wwWU9l0Df7D2nYYIqlsCorC8SiJE6IVchR3JfPGj2CJmZKP3iuYeOn9G7uarv6
 3ArmMjS5GSJ2kl0YRs96+nrjDGzGbCyfigeSlG8rQBY4YiEY+B8aHFF/7cpEdyVOIVqx UQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3tc6me1k2c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 26 Sep 2023 21:36:16 +0000
Received: from m0353723.ppops.net (m0353723.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 38QLaDVX009478;
        Tue, 26 Sep 2023 21:36:13 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3tc6me1jkd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 26 Sep 2023 21:36:12 +0000
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
        by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 38QJPrWT008250;
        Tue, 26 Sep 2023 21:32:49 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
        by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3tabbn6h33-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 26 Sep 2023 21:32:49 +0000
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com [10.241.53.105])
        by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 38QLWmZF7537308
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 26 Sep 2023 21:32:48 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 80F1358055;
        Tue, 26 Sep 2023 21:32:48 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D95EC58063;
        Tue, 26 Sep 2023 21:32:47 +0000 (GMT)
Received: from [9.61.144.60] (unknown [9.61.144.60])
        by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
        Tue, 26 Sep 2023 21:32:47 +0000 (GMT)
Message-ID: <ed95040b-2368-473b-1dda-5d8c0eaa3259@linux.vnet.ibm.com>
Date:   Tue, 26 Sep 2023 17:32:47 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH] ima: Finish deprecation of IMA_TRUSTED_KEYRING Kconfig
Content-Language: en-US
To:     Oleksandr Tymoshenko <ovt@google.com>,
        Mimi Zohar <zohar@linux.ibm.com>
Cc:     rnv@google.com, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Nayna Jain <nayna@linux.ibm.com>,
        Paul Moore <paul@paul-moore.com>
References: <20230921064506.3420402-1-ovt@google.com>
From:   Nayna <nayna@linux.vnet.ibm.com>
In-Reply-To: <20230921064506.3420402-1-ovt@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: fwjYmKAlxZvFNdVeaJ5d8wlks2OY9nkT
X-Proofpoint-GUID: JOJkSSU5U-SAKUyZv7E0aYNsAI5y13bt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-09-26_15,2023-09-26_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 adultscore=0
 mlxlogscore=395 spamscore=0 clxscore=1015 priorityscore=1501
 impostorscore=0 suspectscore=0 phishscore=0 bulkscore=0 lowpriorityscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2309260184
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 9/21/23 02:45, Oleksandr Tymoshenko wrote:
> The removal of IMA_TRUSTED_KEYRING made IMA_LOAD_X509
> and IMA_BLACKLIST_KEYRING unavailable because the latter
> two depend on the former. Since IMA_TRUSTED_KEYRING was
> deprecated in favor of INTEGRITY_TRUSTED_KEYRING use it
> as a dependency for the two Kconfigs affected by the
> deprecation.
>
> Fixes: 5087fd9e80e5 ("ima: Remove deprecated IMA_TRUSTED_KEYRING Kconfig")
> Signed-off-by: Oleksandr Tymoshenko <ovt@google.com>

Thanks for doing this.

Reviewed-by: Nayna Jain <nayna@linux.ibm.com>

