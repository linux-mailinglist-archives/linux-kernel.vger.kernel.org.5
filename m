Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08E9B7CFAE6
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 15:23:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345641AbjJSNXo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 09:23:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345889AbjJSNXl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 09:23:41 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AE6E11B
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 06:23:39 -0700 (PDT)
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39JDEMdJ009849;
        Thu, 19 Oct 2023 13:23:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : reply-to : references : mime-version : content-type
 : in-reply-to; s=pp1; bh=V3R5JyX2URN3vvsTlZ+qMgwONoOCcsxqj/HWOwCZuC4=;
 b=XCYHjs7rHNGg15HN+3Wznj0uWOmEWivWcKyjrDy+iZAF6hzpJShu5HpRq+s5BAXHHhWe
 1HKS8Qzi6+p2sRVVr8SnxyFgQIIPz6jA/kAc3hA80QfhgWkVP+lTfou8+rGsqtQ57pf4
 PG3twKTUoqu63ElWJb9s1rOjbpc4esH8GfTUTk2WfVQ/67M0LQ85E7IuioE5SUng+emI
 gX5dNnx4pTLErUxkitR6R0+Wc42vRITVhtjlBL+o7perSy+hMmE+btmzPspga65KlkSf
 KzrOV2C4y4HhgYjwFpjfpvNlsmFhTgzAU6uwcf90ROIdVMwnSw6+P1+IDulVaply3sNn rA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3tu51a8tt6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 19 Oct 2023 13:23:23 +0000
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 39JDFMHK019375;
        Thu, 19 Oct 2023 13:23:23 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3tu51a8ts7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 19 Oct 2023 13:23:22 +0000
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
        by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 39JD56AT012871;
        Thu, 19 Oct 2023 13:23:21 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
        by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3tr5pys6ha-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 19 Oct 2023 13:23:21 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
        by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 39JDNJNE41812452
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 19 Oct 2023 13:23:19 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3A68520043;
        Thu, 19 Oct 2023 13:23:19 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E6D4820040;
        Thu, 19 Oct 2023 13:23:16 +0000 (GMT)
Received: from linux.vnet.ibm.com (unknown [9.126.150.29])
        by smtpav04.fra02v.mail.ibm.com (Postfix) with SMTP;
        Thu, 19 Oct 2023 13:23:16 +0000 (GMT)
Date:   Thu, 19 Oct 2023 18:53:16 +0530
From:   Srikar Dronamraju <srikar@linux.vnet.ibm.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Michael Ellerman <mpe@ellerman.id.au>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Nicholas Piggin <npiggin@gmail.com>,
        Rohan McLure <rmclure@linux.ibm.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 4/6] powerpc/smp: Disable MC domain for shared
 processor
Message-ID: <20231019132316.GK2194132@linux.vnet.ibm.com>
Reply-To: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
References: <20231018163751.2423181-1-srikar@linux.vnet.ibm.com>
 <20231018163751.2423181-5-srikar@linux.vnet.ibm.com>
 <87pm1b5ia7.fsf@mail.lhotse>
 <20231019075046.GN33217@noisy.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20231019075046.GN33217@noisy.programming.kicks-ass.net>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: hLt1dE7pvjhonyeBrPFQ5nky9dqm2vwL
X-Proofpoint-ORIG-GUID: pvByYJRCDeZOjht1kAm1jmhRx7JhH8ny
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-19_11,2023-10-19_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 priorityscore=1501 suspectscore=0 adultscore=0 mlxscore=0 bulkscore=0
 phishscore=0 spamscore=0 clxscore=1015 mlxlogscore=999 lowpriorityscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2310190114
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Peter Zijlstra <peterz@infradead.org> [2023-10-19 09:50:46]:

> On Thu, Oct 19, 2023 at 03:48:48PM +1100, Michael Ellerman wrote:
> > Srikar Dronamraju <srikar@linux.vnet.ibm.com> writes:
> > > Like L2-cache info, coregroup information which is used to determine MC
> > > sched domains is only present on dedicated LPARs. i.e PowerVM doesn't
> > > export coregroup information for shared processor LPARs. Hence disable
> > > creating MC domains on shared LPAR Systems.
> > >
> > > Signed-off-by: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
> > > ---
> > >  arch/powerpc/kernel/smp.c | 4 ++++
> > >  1 file changed, 4 insertions(+)
> > >
> > > diff --git a/arch/powerpc/kernel/smp.c b/arch/powerpc/kernel/smp.c
> > > index 498c2d51fc20..29da9262cb17 100644
> > > --- a/arch/powerpc/kernel/smp.c
> > > +++ b/arch/powerpc/kernel/smp.c
> > > @@ -1046,6 +1046,10 @@ static struct cpumask *cpu_coregroup_mask(int cpu)
> > >  
> > >  static bool has_coregroup_support(void)
> > >  {
> > > +	/* Coregroup identification not available on shared systems */
> > > +	if (is_shared_processor())
> > > +		return 0;
> > 
> > That will catch guests running under KVM too right? Do we want that?
> 
> Some KVM people use vcpu pinning and pass-through topology things,
> slice-of-hardware or something like that. In that scenario you actively
> do want this.
> 
> I'm fairly clueless on when this is_shared_processor() gets to be true,
> so that might already be dealt with.. 

Dedicated LPARs are like pinned VM instances. There is a one-to-one mapping
between the Physical core and the virtual core.

On Shared LPARs  are unlike regular unpinned VM instances. The Hypervisor
has the flexibility to schedule the virtual core on different Physical core
based on the availability. And like regular VMs, Shared LPARs also support
overcommiting i.e there can be more virtual cores than Physical cores. So
Hypervisor takes care of switching the cores based on its entitlement.

Hence On Shared LPARs, Hypervisors would like to keep the Hemisphere
locality of the cores transparent to the OS.

-- 
Thanks and Regards
Srikar Dronamraju
