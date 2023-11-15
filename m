Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7704F7EC156
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 12:36:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343575AbjKOLgh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 06:36:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234923AbjKOLgg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 06:36:36 -0500
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8D83E9
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 03:36:32 -0800 (PST)
Received: from pps.filterd (m0353722.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AFAeqpS011410;
        Wed, 15 Nov 2023 11:36:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : reply-to : references : mime-version : content-type
 : in-reply-to; s=pp1; bh=QSxnLbodrlGlaJIs1YVycWKdunPA+USoopHxYutP7uc=;
 b=XvbGWEk2kOk9Em2h4JGYSaeguruGxOoH6lZsxiZtGGu+eSFv98mDucJ4Q80/nGnvzpPF
 J/eL07FgOJkyUXWsq/2JtNnDUbJmRAio7ZbRxAPWfKaWieFbIMTza+pYzSOittPLweL4
 lUbv//21iiq3+0cbl1K9G6yjvtMnDQCpSL1Pn9q6s4Mb/AszmTge0lu3K9OUsd14Gdyh
 2cCMyNT3AjefkI0esq0nyaAnPhuomD01lEJkC70CFBYQ27nJx/nXSianacSZvNF7nH/B
 U7Mjssd4/CxlhPcS+h8YtkRNP+XGueEKPXbB9K2PcU3WFAS07uHkcERYbkaAcvS4JtEe Kg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ucveh9mjy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 15 Nov 2023 11:36:09 +0000
Received: from m0353722.ppops.net (m0353722.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3AFAui03022971;
        Wed, 15 Nov 2023 11:36:06 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ucveh9kxv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 15 Nov 2023 11:36:05 +0000
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
        by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3AFAj6qf024379;
        Wed, 15 Nov 2023 11:35:53 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
        by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3uamxnet5w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 15 Nov 2023 11:35:53 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
        by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3AFBZoMc19858012
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 15 Nov 2023 11:35:50 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id AD1AC2004B;
        Wed, 15 Nov 2023 11:35:50 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3164D20040;
        Wed, 15 Nov 2023 11:35:48 +0000 (GMT)
Received: from linux.vnet.ibm.com (unknown [9.126.150.29])
        by smtpav03.fra02v.mail.ibm.com (Postfix) with SMTP;
        Wed, 15 Nov 2023 11:35:48 +0000 (GMT)
Date:   Wed, 15 Nov 2023 17:05:47 +0530
From:   Srikar Dronamraju <srikar@linux.vnet.ibm.com>
To:     "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Cc:     Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Mark Rutland <mark.rutland@arm.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        "ndesaulniers@google.com" <ndesaulniers@google.com>,
        linux-kernel@vger.kernel.org, Rohan McLure <rmclure@linux.ibm.com>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Josh Poimboeuf <jpoimboe@kernel.org>
Subject: Re: [PATCH v4 1/5] powerpc/smp: Enable Asym packing for cores on
 shared processor
Message-ID: <20231115113547.GV2194132@linux.vnet.ibm.com>
Reply-To: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
References: <20231109054938.26589-1-srikar@linux.vnet.ibm.com>
 <20231109054938.26589-2-srikar@linux.vnet.ibm.com>
 <87zfzf8qxh.fsf@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <87zfzf8qxh.fsf@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: aAolTWShpm28g2NYhfsRX6nSDBLLcI2V
X-Proofpoint-ORIG-GUID: 9vhNNcuj516DmmVnD9pofjL3nDEecxo2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-15_10,2023-11-15_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 priorityscore=1501 mlxscore=0 lowpriorityscore=0 malwarescore=0
 phishscore=0 adultscore=0 impostorscore=0 clxscore=1015 spamscore=0
 mlxlogscore=667 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2311060000 definitions=main-2311150088
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com> [2023-11-15 12:05:22]:

> Srikar Dronamraju <srikar@linux.vnet.ibm.com> writes:
> 
> >
> >  arch/powerpc/kernel/smp.c | 37 +++++++++++++++++++++++++++++--------
> >  1 file changed, 29 insertions(+), 8 deletions(-)
> >
> > diff --git a/arch/powerpc/kernel/smp.c b/arch/powerpc/kernel/smp.c
> > index ab691c89d787..69a3262024f1 100644
> > --- a/arch/powerpc/kernel/smp.c
> > +++ b/arch/powerpc/kernel/smp.c
> > @@ -993,16 +993,20 @@ static bool shared_caches;
> >  /* cpumask of CPUs with asymmetric SMT dependency */
> >  static int powerpc_smt_flags(void)
> >  {
> > -	int flags = SD_SHARE_CPUCAPACITY | SD_SHARE_PKG_RESOURCES;
> > +	if (!cpu_has_feature(CPU_FTR_ASYM_SMT))
> > +		return SD_SHARE_CPUCAPACITY | SD_SHARE_PKG_RESOURCES;
> >  
> > -	if (cpu_has_feature(CPU_FTR_ASYM_SMT)) {
> > -		printk_once(KERN_INFO "Enabling Asymmetric SMT scheduling\n");
> > -		flags |= SD_ASYM_PACKING;
> > -	}
> > -	return flags;
> > +	return SD_SHARE_CPUCAPACITY | SD_SHARE_PKG_RESOURCES | SD_ASYM_PACKING;
> >  }
> >  #endif
> >
> 
> Only relevant change there is dropping printk_once(). Rest of the
> changes are not needed?
> 
> -aneesh

If you are looking at just this hunk, then yes its moving the printk_once to
another function.

-- 
Thanks and Regards
Srikar Dronamraju
