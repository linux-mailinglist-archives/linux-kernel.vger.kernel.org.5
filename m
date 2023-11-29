Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3190F7FDC52
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 17:14:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230337AbjK2QOf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 11:14:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229887AbjK2QOd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 11:14:33 -0500
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72622D69;
        Wed, 29 Nov 2023 08:14:39 -0800 (PST)
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3ATGE5GO022031;
        Wed, 29 Nov 2023 16:14:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : reply-to : to : cc : date : in-reply-to : references : content-type
 : mime-version : content-transfer-encoding; s=pp1;
 bh=orzbsyYc+22SoXDoqw2ebK3y4KFZaFz5xvaffogBFu0=;
 b=MZwnqYOPX7LnHRqC70tCh1aL9Bx8JdIHKcb2Wy6m5ZNojozYyvqYdEg7EjdlOtjPeu2h
 nhEl6HC23hnXOSfv9dCx+pILYjNsHs3PdqTKTu0QDl3OKLJGSIw3TkJ36rHpoU/q9Kft
 5kHvj6Zcus/CgH6r2BiozRouvxfYpmgChEwM+LjjBtXs4Z5Td/aZB32AlFgmw7UHpAdG
 QbvrW54hoZXOWGmqOlIkKzKlcJHqgqUJI92dP107186KroX2H6aiXqiLEmWo64cc8wkV
 bb16lA2zqwZbXW50mCPveXv5Oeqcvn7wx4QlgPLKBzKFKc8Wj8kCqlaU54b8zK47mt3Q sQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3up8mw81j7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 29 Nov 2023 16:14:35 +0000
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3ATGEVoT024555;
        Wed, 29 Nov 2023 16:14:31 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3up8mw81bk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 29 Nov 2023 16:14:30 +0000
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
        by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3ATE6QJP004403;
        Wed, 29 Nov 2023 16:14:28 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
        by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 3ukwy1yrr5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 29 Nov 2023 16:14:28 +0000
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com [10.241.53.100])
        by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3ATGERaJ46269124
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 29 Nov 2023 16:14:27 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 74AE35805D;
        Wed, 29 Nov 2023 16:14:27 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7170858058;
        Wed, 29 Nov 2023 16:14:26 +0000 (GMT)
Received: from lingrow.int.hansenpartnership.com (unknown [9.67.129.184])
        by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
        Wed, 29 Nov 2023 16:14:26 +0000 (GMT)
Message-ID: <fe077251fea010af59214049eea9681b8008852a.camel@linux.ibm.com>
Subject: Re: [PATCH] [scsi] lasi700: Add error handling in lasi700_probe
From:   James Bottomley <jejb@linux.ibm.com>
Reply-To: jejb@linux.ibm.com
To:     Haoran Liu <liuhaoran14@163.com>
Cc:     martin.petersen@oracle.com, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Wed, 29 Nov 2023 11:14:24 -0500
In-Reply-To: <20231129145200.34596-1-liuhaoran14@163.com>
References: <20231129145200.34596-1-liuhaoran14@163.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: IM1anRz5JwQFzhidCrx6Rsg9M2enZcXE
X-Proofpoint-ORIG-GUID: V3aNp1G5ZhCENU3RYpeY5njxywsC3WIe
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-29_14,2023-11-29_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 adultscore=0
 spamscore=0 mlxscore=0 malwarescore=0 phishscore=0 lowpriorityscore=0
 clxscore=1011 impostorscore=0 priorityscore=1501 mlxlogscore=823
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311290123
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2023-11-29 at 06:52 -0800, Haoran Liu wrote:
> This patch introduces improved error handling for the dma_set_mask
> and ioremap calls in the lasi700_probe function within
> drivers/scsi/lasi700.c. Previously, the function did not properly
> handle the potential failure of these calls, which could lead to
> improper device initialization and unpredictable behavior.

I have to ask what the point of this is?  There was once an
architecture that couldn't support 32 bit DMA masks (the altix), but
it's long gone.  The structural assumption is that a 32 bit DMA mask
can always be set, so drivers with simple DMA requirements (32 or 64
bit) usually only check 64 and assume they can fallback to 32.

> Although the error addressed by this patch may not occur in the
> current environment, I still suggest implementing these error
> handling routines if the function is not highly time-sensitive. As
> the environment evolves or the code gets reused in different
> contexts, there's a possibility that these errors might occur.
> Addressing them now can prevent potential debugging efforts in the
> future, which could be quite resource-intensive.

This particular operation can never fail on the PA-RISC GSC device,
which is the only one this driver supports, so the driver currently has
no error handling because this is something that can't happen.

James

