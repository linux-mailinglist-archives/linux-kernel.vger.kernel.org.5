Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A5E380BF99
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 04:08:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229802AbjLKC5j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Dec 2023 21:57:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229578AbjLKC5h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Dec 2023 21:57:37 -0500
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B188ACE
        for <linux-kernel@vger.kernel.org>; Sun, 10 Dec 2023 18:57:43 -0800 (PST)
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3BB16IEW021040;
        Mon, 11 Dec 2023 02:57:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : reply-to : references : mime-version : content-type
 : in-reply-to; s=pp1; bh=dr8gU8++GxT7rgNWzmumIkySC9bpPsiBe5AMEblpACw=;
 b=djmUufqGfrvvD57MoqHOlBoBOKhNdR8XH7PuOZNu51HO0Rm+bjQZsmcFsWYj/iJsOCs4
 1CHw2egx89G2R2mw5pRtOLe071vJ2+D0yeVZ8m8g01POT43QVQktTDf6KWZoAsv4d+Wj
 wdy50sLcHwrfFXndR2jede5yx8fuiaFynrEcvhcPTyC+X4xsvcK8aVcfmQkDpaxhGR8n
 0H7t0p3kQf+1ufEFSYgve4NrMzgOPByiLUCXbol1wra9hRN4mb19CZQ2lOCySXZCucsS
 Q8GRuGZfKFYOC0qVUy37RvIQ+AaS79UjoEG9okBIZqM7+hqM9zReVlimIH2ObfnBM3ql Gg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3uvsxqdd0v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 11 Dec 2023 02:57:02 +0000
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3BB2b24h010379;
        Mon, 11 Dec 2023 02:57:01 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3uvsxqdd0p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 11 Dec 2023 02:57:01 +0000
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
        by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3BB0HpfC008491;
        Mon, 11 Dec 2023 02:57:00 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
        by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 3uw2jsxuqg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 11 Dec 2023 02:57:00 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
        by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3BB2uxCV66060562
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 11 Dec 2023 02:56:59 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E556C20043;
        Mon, 11 Dec 2023 02:56:58 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id ABB4B20040;
        Mon, 11 Dec 2023 02:56:56 +0000 (GMT)
Received: from linux.vnet.ibm.com (unknown [9.126.150.29])
        by smtpav05.fra02v.mail.ibm.com (Postfix) with SMTP;
        Mon, 11 Dec 2023 02:56:56 +0000 (GMT)
Date:   Mon, 11 Dec 2023 08:26:56 +0530
From:   Srikar Dronamraju <srikar@linux.vnet.ibm.com>
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        linux-kernel@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Rohan McLure <rmclure@linux.ibm.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>
Subject: Re: [PATCH v4 0/5] powerpc/smp: Topology and shared processor
 optimizations
Message-ID: <20231211025656.4lqrhnic5gynkuzq@linux.vnet.ibm.com>
Reply-To: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
References: <20231109054938.26589-1-srikar@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20231109054938.26589-1-srikar@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: LYXjbyr98WFucn1BQhRSeoqh01OvLUPT
X-Proofpoint-ORIG-GUID: 1J9UCUVbdZc1J2KwtCKtXxmwvl0rTsh3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-10_16,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=461
 suspectscore=0 impostorscore=0 bulkscore=0 malwarescore=0
 lowpriorityscore=0 mlxscore=0 priorityscore=1501 clxscore=1011
 adultscore=0 phishscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2311290000 definitions=main-2312110023
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Srikar Dronamraju <srikar@linux.vnet.ibm.com> [2023-11-09 11:19:28]:

Hi Michael,

> PowerVM systems configured in shared processors mode have some unique
> challenges. Some device-tree properties will be missing on a shared
> processor. Hence some sched domains may not make sense for shared processor
> systems.
> 
> 

Did you get a chance to look at this patchset?
Do you see this getting pulled into your merge branch?
I havent seen any comments that requires a change from the current patchset.

-- 
Thanks and Regards
Srikar Dronamraju
