Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 793947CFA66
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 15:09:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345777AbjJSNJq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 09:09:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235493AbjJSNJd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 09:09:33 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A182555BC
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 05:56:44 -0700 (PDT)
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39JClL9E009734;
        Thu, 19 Oct 2023 12:55:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : reply-to : references : mime-version : content-type
 : in-reply-to; s=pp1; bh=ZyTyEqjxXhJ2+P5EJDKRWQfGR1CIriFg+9zSkPJjKkg=;
 b=sCtq53AQlfM6ZtIMR68PGXJ0+Yzzim/sNqtOnnR4jD7s0Vuekeb72mBam8mX7R0LMmhc
 fJMZbM1v+8EkdLbmAD6LpTWr3Xqj7dShNkTQL4K+SD8AFog38D363x2SD481pPgHQENH
 MPlfKyKPd+0DpvBmyaoQM2XgBjr5cy8MfSQomelfvHXLk1fm2xVT5E0UK7n0kCfipgu2
 P/6mEQIbmXB51fznnNPSBjTze7mp+T9vscXeaxJ0ozhcUNTkhd26Gw2Xt+HCUA4/Piom
 Q6EEw4HSe4mLNxG4KMz1tfTpqfgg8c05YXkm6rZSNV7KotYzU+hdw6ljNQMypCBCHXk2 4g== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3tu4s38bge-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 19 Oct 2023 12:55:11 +0000
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 39JCmo0T017859;
        Thu, 19 Oct 2023 12:55:10 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3tu4s38b6e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 19 Oct 2023 12:55:10 +0000
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
        by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 39JA0XFD026885;
        Thu, 19 Oct 2023 12:55:04 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
        by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 3tr5ass4u3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 19 Oct 2023 12:55:04 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
        by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 39JCt2wU40894966
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 19 Oct 2023 12:55:02 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B0D9F20043;
        Thu, 19 Oct 2023 12:55:02 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9095520040;
        Thu, 19 Oct 2023 12:55:00 +0000 (GMT)
Received: from linux.vnet.ibm.com (unknown [9.126.150.29])
        by smtpav01.fra02v.mail.ibm.com (Postfix) with SMTP;
        Thu, 19 Oct 2023 12:55:00 +0000 (GMT)
Date:   Thu, 19 Oct 2023 18:24:59 +0530
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
Subject: Re: [PATCH v2 2/6] powerpc/smp: Enable Asym packing for cores on
 shared processor
Message-ID: <20231019125459.GG2194132@linux.vnet.ibm.com>
Reply-To: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
References: <20231018163751.2423181-1-srikar@linux.vnet.ibm.com>
 <20231018163751.2423181-3-srikar@linux.vnet.ibm.com>
 <87v8b35ir3.fsf@mail.lhotse>
 <20231019074828.GM33217@noisy.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20231019074828.GM33217@noisy.programming.kicks-ass.net>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: GMwsv4RQrWCOCQHjFaz6ZetskUR2dNHh
X-Proofpoint-GUID: TCOuYY8HizXlgRk3UK0VEd_N4sDLTwRN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-19_11,2023-10-19_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 clxscore=1015
 malwarescore=0 mlxlogscore=826 lowpriorityscore=0 phishscore=0
 adultscore=0 spamscore=0 impostorscore=0 bulkscore=0 mlxscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2310190110
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Peter Zijlstra <peterz@infradead.org> [2023-10-19 09:48:28]:

> On Thu, Oct 19, 2023 at 03:38:40PM +1100, Michael Ellerman wrote:
> > Srikar Dronamraju <srikar@linux.vnet.ibm.com> writes:
> > > If there are shared processor LPARs, underlying Hypervisor can have more
> > > virtual cores to handle than actual physical cores.
> > >
> > > Starting with Power 9, a core has 2 nearly independent thread groups.
> > 
> > You need to be clearer here that you're talking about "big cores", not
> > SMT4 cores as seen on bare metal systems.
> 
> What is a 'big core' ? I'm thinking big.LITTLE, but I didn't think Power
> went that route (yet?).. help?
> 

Each independent thread group acts as a SMT4 core or a small core. A set of
2 thread groups form a SMT8 core aka big core. PowerVM aka pHYp schedules
at a big core granularity

So if we have 2 LPARS, each spanning 2 big cores, aka 16 CPUs, and if at
somepoint, each LPAR has only 2 threads to run, we are exploring if we can
run both the threads on just one big core, so that PhyP can schedule both
LPARS at the same time and avoid having to switch/multiplex between these
two LPARS.

-- 
Thanks and Regards
Srikar Dronamraju
