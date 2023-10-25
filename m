Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71BB17D6858
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 12:23:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234759AbjJYKXf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 06:23:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234721AbjJYKXd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 06:23:33 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E17CB181;
        Wed, 25 Oct 2023 03:23:29 -0700 (PDT)
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39PALWd2000532;
        Wed, 25 Oct 2023 10:23:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=pp1; bh=avlWrltZO0CuUWblDeg1QvRCCsEXeaH57k5OV9KiXxw=;
 b=X5lJAs7NbW78QPOZMh7lG6YrE8p+X49kN4+wG33a1mDa+nlh72oF7ygCWEZSjRa1ah6P
 /b8Bg4aTItos3uKxT99vVLYMQIPJDY1qXxhE2w3GSZZplTAjYBlGrOrWuQSrZBMh10tY
 4KPvBaGMpHJMck532PtNh/cUSxHEyq/j/cCNQProAkLxynN+RbyLCXnIGjpOhDQ2VAgi
 z9+oJDPdHtnajV+8cfoExOUxOgKGM9chuDvY7E5YBaCMIRB5J/vr20quFkDTRJn6YQ94
 uJCM5lX9J1tB7QHKHoNFuJYYhBSNxa2VFUhM9IgHuHdOgnZERpqbigI+gQucZwUC5oN6 lA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ty16eg1q1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 25 Oct 2023 10:23:29 +0000
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 39PANFAF008047;
        Wed, 25 Oct 2023 10:23:28 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ty16eg1pq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 25 Oct 2023 10:23:28 +0000
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
        by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 39P8bwtZ012344;
        Wed, 25 Oct 2023 10:23:27 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
        by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 3tvup1wcyr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 25 Oct 2023 10:23:27 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
        by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 39PANOsB39125670
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 25 Oct 2023 10:23:24 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BE3AE2004D;
        Wed, 25 Oct 2023 10:23:24 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 26E952004B;
        Wed, 25 Oct 2023 10:23:24 +0000 (GMT)
Received: from localhost (unknown [9.171.93.15])
        by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTPS;
        Wed, 25 Oct 2023 10:23:24 +0000 (GMT)
Date:   Wed, 25 Oct 2023 12:23:22 +0200
From:   Vasily Gorbik <gor@linux.ibm.com>
To:     Justin Stitt <justinstitt@google.com>
Cc:     Heiko Carstens <hca@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH] s390/sclp: replace deprecated strncpy with strtomem
Message-ID: <your-ad-here.call-01698229402-ext-6422@work.hours>
References: <20231023-strncpy-drivers-s390-char-sclp-c-v1-1-eaeef80522bb@google.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231023-strncpy-drivers-s390-char-sclp-c-v1-1-eaeef80522bb@google.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: x8P8agS-hJQXnec20Z0XlYGOuYtPPzmD
X-Proofpoint-ORIG-GUID: tNau09rVp_RbVxAnyWKrmpxJa8HwOGiR
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-25_01,2023-10-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 malwarescore=0
 suspectscore=0 spamscore=0 priorityscore=1501 adultscore=0 bulkscore=0
 lowpriorityscore=0 impostorscore=0 mlxlogscore=503 phishscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2310170001
 definitions=main-2310250089
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 23, 2023 at 07:14:49PM +0000, Justin Stitt wrote:
> Let's move away from using strncpy() as it is deprecated [1].
> 
> Instead use strtomem() as `e.id` is already marked as nonstring:
> |       char id[4] __nonstring;
> 
> We don't need strtomem_pad() because `e` is already memset to 0 --
> rendering any additional NUL-padding useless.
> 
> Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings [1]
> Link: https://github.com/KSPP/linux/issues/90
> Cc: linux-hardening@vger.kernel.org
> Signed-off-by: Justin Stitt <justinstitt@google.com>
> ---
> Note: build-tested only.
> 
> Found with: $ rg "strncpy\("
> ---
>  drivers/s390/char/sclp.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied, thank you!
