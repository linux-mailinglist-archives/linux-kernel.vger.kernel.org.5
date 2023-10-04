Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 574017B8E59
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 22:54:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233732AbjJDUyT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 16:54:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233286AbjJDUyS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 16:54:18 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BE6890;
        Wed,  4 Oct 2023 13:54:15 -0700 (PDT)
Received: from pps.filterd (m0353722.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 394KluRs000693;
        Wed, 4 Oct 2023 20:54:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : reply-to : to : cc : date : in-reply-to : references : content-type
 : mime-version : content-transfer-encoding; s=pp1;
 bh=4wXsC4kQ2MjcLpSQnJhDuNbJAFFxhtX/zbBwQY744jc=;
 b=am1AIUMY4KQwVRb7EUCDCVWHrZyh8f3ndXQ564z07qo2U7bGREnGllNdIIXdHaAX6lLU
 AgkU8D+re9aQNe/5s3pJl2/7YHvjSyDo+Qlw4YMiTKzpwqhweFOk1PgpBvfZelgnFZ4T
 tD1SAp1IKB1QbwtOoU/XHZxlp0S+9Bw8/QbBgSG8smb9d/HaJsizwJAGbP03sXGtYPhZ
 heNO4uhesMOaB/9qmFZwvVPiXxLsv87nhAtooZna9ILPKdab332kgIrW6yXIdsL0oJBf
 eQWaiKjqHc/yPk60wEmyj62g7xzShnC4RoM3hVUY8Ck7bgXMwgw3PLF02HPA+C2QHjeX 5w== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3thfd28474-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 04 Oct 2023 20:54:11 +0000
Received: from m0353722.ppops.net (m0353722.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 394Kpe0q011935;
        Wed, 4 Oct 2023 20:54:11 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3thfd2846t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 04 Oct 2023 20:54:11 +0000
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
        by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 394KNhr8010870;
        Wed, 4 Oct 2023 20:54:10 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
        by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 3tf0q23g2n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 04 Oct 2023 20:54:10 +0000
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com [10.39.53.229])
        by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 394Ks9oP32375542
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 4 Oct 2023 20:54:10 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DEBD95805C;
        Wed,  4 Oct 2023 20:54:09 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 88D2B58058;
        Wed,  4 Oct 2023 20:54:09 +0000 (GMT)
Received: from rhel-laptop.ibm.com (unknown [9.61.54.52])
        by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
        Wed,  4 Oct 2023 20:54:09 +0000 (GMT)
Message-ID: <5c4fbafb1daa45f2faf60c7d587cd23c53d9393c.camel@linux.vnet.ibm.com>
Subject: Re: [PATCH] block: Fix regression in sed-opal for a saved key.
From:   Greg Joyce <gjoyce@linux.vnet.ibm.com>
Reply-To: gjoyce@linux.vnet.ibm.com
To:     Milan Broz <gmazyland@gmail.com>, linux-block@vger.kernel.org
Cc:     jonathan.derrick@linux.dev, axboe@kernel.dk,
        linux-kernel@vger.kernel.org, Ondrej Kozina <okozina@redhat.com>
Date:   Wed, 04 Oct 2023 15:54:09 -0500
In-Reply-To: <20231003100209.380037-1-gmazyland@gmail.com>
References: <20231003100209.380037-1-gmazyland@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-22.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: j_OwV0zcFa8P948osUz78Jb7a7YCNLoE
X-Proofpoint-ORIG-GUID: DMzlJaRQlf7xew3OpV9Kpc86CTQTBvLP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-04_11,2023-10-02_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 adultscore=0
 bulkscore=0 spamscore=0 impostorscore=0 mlxlogscore=999 clxscore=1011
 priorityscore=1501 malwarescore=0 lowpriorityscore=0 mlxscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2310040153
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2023-10-03 at 12:02 +0200, Milan Broz wrote:
> The commit 3bfeb61256643281ac4be5b8a57e9d9da3db4335
> introduced the use of keyring for sed-opal.
> 
> Unfortunately, there is also a possibility to save
> the Opal key used in opal_lock_unlock().
> 
> This patch switches the order of operation, so the cached
> key is used instead of failure for opal_get_key.
> 
> The problem was found by the cryptsetup Opal test recently
> added to the cryptsetup tree.
> 
> Fixes: 3bfeb6125664 ("block: sed-opal: keyring support for SED keys")
> Tested-by: Ondrej Kozina <okozina@redhat.com>
> Signed-off-by: Milan Broz <gmazyland@gmail.com>
> ---
>  block/sed-opal.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
> 
> diff --git a/block/sed-opal.c b/block/sed-opal.c
> index 6d7f25d1711b..04f38a3f5d95 100644
> --- a/block/sed-opal.c
> +++ b/block/sed-opal.c
> @@ -2888,12 +2888,11 @@ static int opal_lock_unlock(struct opal_dev
> *dev,
>  	if (lk_unlk->session.who > OPAL_USER9)
>  		return -EINVAL;
> 
> -	ret = opal_get_key(dev, &lk_unlk->session.opal_key);
> -	if (ret)
> -		return ret;
>  	mutex_lock(&dev->dev_lock);
>  	opal_lock_check_for_saved_key(dev, lk_unlk);
> -	ret = __opal_lock_unlock(dev, lk_unlk);
> +	ret = opal_get_key(dev, &lk_unlk->session.opal_key);
> +	if (!ret)
> +		ret = __opal_lock_unlock(dev, lk_unlk);

This is relying on opal_get_key() returning 0 to decide if
__opal_lock_unlock() is called. Is this really what you want? It seems
that you would want to unlock if the key is a LUKS key, even if
opal_get_key() returns non-zero.

>  	mutex_unlock(&dev->dev_lock);
> 
>  	return ret;

