Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 563AF7EBCF4
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 07:16:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234527AbjKOGQq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 01:16:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229551AbjKOGQo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 01:16:44 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EC7291
        for <linux-kernel@vger.kernel.org>; Tue, 14 Nov 2023 22:16:41 -0800 (PST)
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AF5u5M2029714;
        Wed, 15 Nov 2023 06:16:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : reply-to : references : mime-version : content-type
 : in-reply-to; s=pp1; bh=xFVnnJMTMBmVSpnPgUmA2cq4J7my1IiGxMtUahWzQjA=;
 b=q973J3jAC/FlW0IHRY9FPaESMMaj8QfkvWXO/2W4CqWzN25dUEKS/9Bfev484Yv0xC60
 YlKjrqiG8VaWHakLrw1mSr1Er6EmA4DRiKJq84k8WZoB65unIIMQhl6oiHK4o8amUS0Z
 qd4dTY7ccp8lOQZVUmwdI1PRZB5VoNU6/MbgGRkFCC3Otv5ZtHE5ToDVbo0SYxcrF1pi
 Z7FBPFCyJupdBlNDsiWesNt2mC5cqpCLKSBMKI9CfmBUTeFhHJRl2kCalBFqDfzjZsA+
 H1jCwziNlLaFAXknfLwEPzl2RoJlFBadwXnBk6QqH30V+0TA0bS3sIlQsqRh/u6bPxDA hg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ucr0hgsw1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 15 Nov 2023 06:16:23 +0000
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3AF5u9jx030159;
        Wed, 15 Nov 2023 06:16:23 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ucr0hgsvt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 15 Nov 2023 06:16:22 +0000
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
        by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3AF4Yu5K015498;
        Wed, 15 Nov 2023 06:16:21 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
        by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 3uakxswnhc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 15 Nov 2023 06:16:21 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
        by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3AF6GIIE66584852
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 15 Nov 2023 06:16:19 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D9D3F2004D;
        Wed, 15 Nov 2023 06:16:18 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id AE6BF20043;
        Wed, 15 Nov 2023 06:16:16 +0000 (GMT)
Received: from linux.vnet.ibm.com (unknown [9.126.150.29])
        by smtpav04.fra02v.mail.ibm.com (Postfix) with SMTP;
        Wed, 15 Nov 2023 06:16:16 +0000 (GMT)
Date:   Wed, 15 Nov 2023 11:46:16 +0530
From:   Srikar Dronamraju <srikar@linux.vnet.ibm.com>
To:     "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Cc:     Michael Ellerman <mpe@ellerman.id.au>,
        Mark Rutland <mark.rutland@arm.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, Rohan McLure <rmclure@linux.ibm.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Josh Poimboeuf <jpoimboe@kernel.org>
Subject: Re: [PATCH v4 0/5] powerpc/smp: Topology and shared processor
 optimizations
Message-ID: <20231115061616.dp5id27xip5j3ovl@linux.vnet.ibm.com>
Reply-To: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
References: <20231109054938.26589-1-srikar@linux.vnet.ibm.com>
 <87v8a3zhl8.fsf@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <87v8a3zhl8.fsf@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: DSSAV-iQ-3SVHXm6L-w9TZNu66cVgEyZ
X-Proofpoint-ORIG-GUID: z_IZwuVAVLgHDS3lQOTvEUUGU-0vSFZX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-15_04,2023-11-14_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 spamscore=0 suspectscore=0 phishscore=0 impostorscore=0 malwarescore=0
 lowpriorityscore=0 mlxlogscore=968 mlxscore=0 adultscore=0 bulkscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311150046
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com> [2023-11-15 11:24:59]:

> Srikar Dronamraju <srikar@linux.vnet.ibm.com> writes:
> 
> > PowerVM systems configured in shared processors mode have some unique
> > challenges. Some device-tree properties will be missing on a shared
> > processor. Hence some sched domains may not make sense for shared processor
> > systems.
> >
> > Most shared processor systems are over-provisioned. Underlying PowerVM
> > Hypervisor would schedule at a Big Core granularity. The most recent power
> > processors support two almost independent cores. In a lightly loaded
> > condition, it helps the overall system performance if we pack to lesser
> > number of Big Cores.
> >
> 
> Is this good to do if the systems are not over-provisioned? What will be
> the performance impact in that case with and without the change?
> 

We are consolidating 1 thread per thread group (aka SMT domain).
Since each thread-group is suppose to be independent including having a
private L1/L2/L3 cache, we expect minimal impact in non over provisioned
scenario.

In Over utilization scenario, the changes in this patchset will not even kick in.

-- 
Thanks and Regards
Srikar Dronamraju
