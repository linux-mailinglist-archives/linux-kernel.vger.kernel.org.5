Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDA1575ACED
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 13:25:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231255AbjGTLZy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 07:25:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229550AbjGTLZw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 07:25:52 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C069BB;
        Thu, 20 Jul 2023 04:25:51 -0700 (PDT)
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36KB99bc021727;
        Thu, 20 Jul 2023 11:23:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : reply-to : to : cc : date : in-reply-to : references : content-type
 : mime-version : content-transfer-encoding; s=pp1;
 bh=Cx4MzwNtsC+bsfR0nq5uuxwIMnP1+eOH1wUrpU+w1fU=;
 b=mdjxXkIVh8KtF4gVJUvwDf2ppAAku8lfK/SLQCYPabGjnV99WbGtAGZMPaLfnjOh0R57
 ZE46vXy5g6HXux0ILLal5HWCJD2mAqUC28iTzelfz1RpHf1B3r32GJB5RIVwh6Ar6qLP
 FzXh3YlhbpHs6u8qRiG5LMjcr1NxH348dPjuhiMdbXvAz/RKGRbDT3MlHPMB23OrokjE
 Z8EtA/052mgnio1kbOJu005/quyrzzs1cPR6Dbr2XIQO8bvBOrlqO+KlVHf0PevYf36B
 Pb9BIqKSoOLN6Ses+1yI6nvMth6kQS+AGDC3jzMZnKX+PUO7lEM1QXtZtXR4J1XwwpAQ TQ== 
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ry26wjeaw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 20 Jul 2023 11:23:31 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
        by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 36K8hV1H030570;
        Thu, 20 Jul 2023 11:23:31 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
        by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3rv79juyqs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 20 Jul 2023 11:23:31 +0000
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com [10.241.53.100])
        by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 36KBNUo431982272
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 20 Jul 2023 11:23:30 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 909AB58057;
        Thu, 20 Jul 2023 11:23:30 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B927258058;
        Thu, 20 Jul 2023 11:23:29 +0000 (GMT)
Received: from [IPv6:2601:5c4:4302:c21::a774] (unknown [9.61.93.39])
        by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
        Thu, 20 Jul 2023 11:23:29 +0000 (GMT)
Message-ID: <564d19fcd79afb957f301ef50ab5601280488798.camel@linux.ibm.com>
Subject: Re: [PATCH] scsi: aic7xxx: avoid checkpatch error
From:   James Bottomley <jejb@linux.ibm.com>
Reply-To: jejb@linux.ibm.com
To:     sunran001@208suo.com, hare@suse.com, martin.petersen@oracle.co
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Thu, 20 Jul 2023 07:23:27 -0400
In-Reply-To: <4d48377ca4e62a71f89e4de6f80e6725@208suo.com>
References: <20230720095619.3954-1-xujianghui@cdjrlc.com>
         <4d48377ca4e62a71f89e4de6f80e6725@208suo.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: bTRPbajjtwuaDo-xa664eKh5aH27MiMe
X-Proofpoint-ORIG-GUID: bTRPbajjtwuaDo-xa664eKh5aH27MiMe
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-20_04,2023-07-20_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 adultscore=0
 clxscore=1011 priorityscore=1501 bulkscore=0 spamscore=0 phishscore=0
 mlxscore=0 mlxlogscore=354 suspectscore=0 impostorscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2307200093
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2023-07-20 at 17:57 +0800, sunran001@208suo.com wrote:
> ERROR: do not initialise statics to NULL

We don't accept checkpatch fixes on drivers, particularly not old ones.
The reason is very simple: checkpatch keeps updating, so they would
cause endless churn and a vastly increased risk of introducing bugs
into older drivers.  Checkpatch.pl as the name implies is for checking
patches only.

James

