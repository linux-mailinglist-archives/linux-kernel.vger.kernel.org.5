Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE5827F33F7
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 17:39:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234042AbjKUQj2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 11:39:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234001AbjKUQj0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 11:39:26 -0500
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CF241A2;
        Tue, 21 Nov 2023 08:39:22 -0800 (PST)
Received: from pps.filterd (m0353724.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3ALFcRdU004331;
        Tue, 21 Nov 2023 16:39:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=pp1; bh=KmKbwEJplODev9WCG+a3bZzneO7c5WCbVoBpxNQbPFg=;
 b=dI1JuA/s5eXZsBHO4ylYEOoViGAfRVKTvm7ZDwjI00DytALhK27B+jygls9RjLxHLlUE
 TqcD8GIAEA9DDqPfq/WQzZ0u8VxBFx+kzD/KtE7lLfNxNfg4j0+I1NiCW4hhV5+5KT7C
 W6P7GKUw2ZpXsfwoHUUmtuR9i9QdaB/tXY1ZRrHJNhpmlB0ouU1GjLWMGmcvu6oBZdln
 MN1PKna2HZ6ZMXf6PxuaeUYhhuB8fGe8+a0S6uNQj4UndhKVk4PWNQLVmjDp3LK+/ClT
 RxwL3NNd8hiBvFn49Zpo5Rgpbv4r9Fudh1gBJkhBDGkKISVfmK46zuK1+DOCUJQ43udC tw== 
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ugy44kpnq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 21 Nov 2023 16:39:18 +0000
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
        by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3ALGIu0O007851;
        Tue, 21 Nov 2023 16:39:17 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
        by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 3ufaa21d5s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 21 Nov 2023 16:39:17 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
        by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3ALGdEaK20775492
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 21 Nov 2023 16:39:14 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8881620040;
        Tue, 21 Nov 2023 16:39:14 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4B8982004D;
        Tue, 21 Nov 2023 16:39:14 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTPS;
        Tue, 21 Nov 2023 16:39:14 +0000 (GMT)
Date:   Tue, 21 Nov 2023 17:39:13 +0100
From:   Alexander Gordeev <agordeev@linux.ibm.com>
To:     "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
Cc:     gregkh@linuxfoundation.org, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, linux-s390@vger.kernel.org
Subject: Re: [PATCH 1/6] tty: con3215: drop raw3215_info::ubuffer
Message-ID: <ZVzdMWawUScUTUM3@tuxmaker.boeblingen.de.ibm.com>
References: <20231121103626.17772-1-jirislaby@kernel.org>
 <20231121103626.17772-2-jirislaby@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231121103626.17772-2-jirislaby@kernel.org>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: edxa4Ci-Wph6lN6y2f6gym2vAPhCG9Jj
X-Proofpoint-ORIG-GUID: edxa4Ci-Wph6lN6y2f6gym2vAPhCG9Jj
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-21_09,2023-11-21_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 spamscore=0 bulkscore=0 clxscore=1011 phishscore=0
 mlxscore=0 mlxlogscore=572 suspectscore=0 adultscore=0 lowpriorityscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311210129
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 21, 2023 at 11:36:21AM +0100, Jiri Slaby (SUSE) wrote:
> clang-struct [1] found raw3215_info::ubuffer unused.
> 
> It's actually not used since 2004 when we switched to kernel buffers.
> 
> [1] https://github.com/jirislaby/clang-struct
> 
> Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
> Cc: Heiko Carstens <hca@linux.ibm.com>
> Cc: Vasily Gorbik <gor@linux.ibm.com>
> Cc: Alexander Gordeev <agordeev@linux.ibm.com>
> Cc: Christian Borntraeger <borntraeger@linux.ibm.com>
> Cc: Sven Schnelle <svens@linux.ibm.com>
> Cc: linux-s390@vger.kernel.org
> ---
>  drivers/s390/char/con3215.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/s390/char/con3215.c b/drivers/s390/char/con3215.c
> index 99361618c31f..34bc343dcfcc 100644
> --- a/drivers/s390/char/con3215.c
> +++ b/drivers/s390/char/con3215.c
> @@ -89,7 +89,6 @@ struct raw3215_info {
>  	wait_queue_head_t empty_wait; /* wait queue for flushing */
>  	struct timer_list timer;      /* timer for delayed output */
>  	int line_pos;		      /* position on the line (for tabs) */
> -	char ubuffer[80];	      /* copy_from_user buffer */
>  };
>  
>  /* array of 3215 devices structures */

Acked-by: Alexander Gordeev <agordeev@linux.ibm.com>
