Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4EDD7CFAB5
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 15:17:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345838AbjJSNR0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 09:17:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233202AbjJSNRX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 09:17:23 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C5159F
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 06:17:22 -0700 (PDT)
Received: from pps.filterd (m0353722.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39JDFKRw031740;
        Thu, 19 Oct 2023 13:17:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : reply-to : references : mime-version : content-type
 : in-reply-to; s=pp1; bh=EOgzvUQafFoswcAE2D3pCuOjLCzcXDLuWGtEGqOfXfI=;
 b=gd0mdJLseoT1YebgyINWi1IHUnXeGIwDzvyfySu/O+vBAgiKIBZed5aeDI+Q3DB6zD3+
 bd3cWyqBHVMNV6JBYeE8gSLSe86GAT3O6evmwbeDaK9LsnQVv8j1tmu4L/NXA+6HrR8Y
 3M4bePQwTxRiOeir7PPXiEB+EhisCdbhyfRRJDV/KfCqnJBeAITUQwYxgVkV+sgVPgti
 EbkNRHcYne68ahHehkeyomy8tZH7yv6RanVLsuukqC7WE4sp5tG41kUieyh/9kAGeHdR
 5vJjcc8WyyXsAucxKFZQ6dBcKTNi8foSHz1mKlap2c5fCSZ2MBg+GzMtXu8cVHMmBF4V zw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3tu56003af-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 19 Oct 2023 13:17:04 +0000
Received: from m0353722.ppops.net (m0353722.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 39JDFlMx001441;
        Thu, 19 Oct 2023 13:17:03 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3tu5600375-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 19 Oct 2023 13:17:03 +0000
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
        by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 39JBDErr020105;
        Thu, 19 Oct 2023 13:17:01 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
        by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3tr6angxs8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 19 Oct 2023 13:17:01 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
        by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 39JDGxcC15401710
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 19 Oct 2023 13:16:59 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0B47820043;
        Thu, 19 Oct 2023 13:16:59 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9D60320040;
        Thu, 19 Oct 2023 13:16:56 +0000 (GMT)
Received: from linux.vnet.ibm.com (unknown [9.126.150.29])
        by smtpav07.fra02v.mail.ibm.com (Postfix) with SMTP;
        Thu, 19 Oct 2023 13:16:56 +0000 (GMT)
Date:   Thu, 19 Oct 2023 18:46:55 +0530
From:   Srikar Dronamraju <srikar@linux.vnet.ibm.com>
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Nicholas Piggin <npiggin@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Rohan McLure <rmclure@linux.ibm.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 4/6] powerpc/smp: Disable MC domain for shared
 processor
Message-ID: <20231019131655.GJ2194132@linux.vnet.ibm.com>
Reply-To: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
References: <20231018163751.2423181-1-srikar@linux.vnet.ibm.com>
 <20231018163751.2423181-5-srikar@linux.vnet.ibm.com>
 <87pm1b5ia7.fsf@mail.lhotse>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <87pm1b5ia7.fsf@mail.lhotse>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: -dcD9fF8egfTbF7mBqOUvkJVRQPDE2J_
X-Proofpoint-GUID: 3bJV3pVYuW0ZlhfUtqPrhT849ube8twE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-19_11,2023-10-19_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 adultscore=0
 impostorscore=0 phishscore=0 priorityscore=1501 mlxlogscore=999
 bulkscore=0 malwarescore=0 mlxscore=0 spamscore=0 suspectscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2310190114
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Michael Ellerman <mpe@ellerman.id.au> [2023-10-19 15:48:48]:

> Srikar Dronamraju <srikar@linux.vnet.ibm.com> writes:
> > Like L2-cache info, coregroup information which is used to determine MC
> > sched domains is only present on dedicated LPARs. i.e PowerVM doesn't
> > export coregroup information for shared processor LPARs. Hence disable
> > creating MC domains on shared LPAR Systems.
> >
> > Signed-off-by: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
> > ---
> >  arch/powerpc/kernel/smp.c | 4 ++++
> >  1 file changed, 4 insertions(+)
> >
> > diff --git a/arch/powerpc/kernel/smp.c b/arch/powerpc/kernel/smp.c
> > index 498c2d51fc20..29da9262cb17 100644
> > --- a/arch/powerpc/kernel/smp.c
> > +++ b/arch/powerpc/kernel/smp.c
> > @@ -1046,6 +1046,10 @@ static struct cpumask *cpu_coregroup_mask(int cpu)
> >  
> >  static bool has_coregroup_support(void)
> >  {
> > +	/* Coregroup identification not available on shared systems */
> > +	if (is_shared_processor())
> > +		return 0;
> 
> That will catch guests running under KVM too right? Do we want that?
> 

Only dedicated LPARS on PowerVM expose coregroup or Hemisphere information.
Currently other systems including KVMs don't expose this information to the
OS.

> >  	return coregroup_enabled;
> 
> What does coregroup_enabled mean now?
> 
> I'd rather this was actually checking the presence of something, rather
> than just hard coding that shared processor means no coregroup support.
> 

On a shared LPAR, the Hypervisors would like to have the flexibility to
schedule LPAR on any core within the DIE without having to further think
about the Hemisphere locality of the core.

> cheers

-- 
Thanks and Regards
Srikar Dronamraju
