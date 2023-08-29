Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FE5678BF9E
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 09:50:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233792AbjH2Htg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 03:49:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233969AbjH2HtX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 03:49:23 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 995D4194;
        Tue, 29 Aug 2023 00:49:19 -0700 (PDT)
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37T74kMu013266;
        Tue, 29 Aug 2023 07:49:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=pp1; bh=ckVtaW3Av7rhPz61zCIjVcwCeNTazlrt+S3eW9iMvO8=;
 b=ALdS1y2FAlsYwkcJfa4Eew9RWLm0727iXBapjEs4EJV1ElsFwrXE74L+Bt+xJnyriKwd
 7OMpsHcS/dv0W9FUHdYu0JWs1+IJxFNrqW5xl2jstCfaL2LeTcN7NNusjqGzoIammQ51
 xcjJhQle4RZnimVnPQMzHLWXrirtiX48Rcbkd4IYg/4AiNBDjLXw3VDmRXIHL+ia9ChW
 Rl0v3Ksz8PJhpkg8ztABEAVxlCWPzmMR4og65FirdJAXnZjyQYBzDHCSK4LkORe34qLe
 KY2xxj3EjG0SeAghsrz3WhdXHrwkUPFH7aIfAbtcneVjRcb2RGl3W79dkk+Cz3SGZTrN Zg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3sr7eq55k0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 29 Aug 2023 07:49:03 +0000
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 37T7bHo2010923;
        Tue, 29 Aug 2023 07:49:02 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3sr7eq55jf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 29 Aug 2023 07:49:02 +0000
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
        by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 37T7BNlu014392;
        Tue, 29 Aug 2023 07:49:01 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
        by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3sqvqn1q93-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 29 Aug 2023 07:49:01 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
        by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 37T7mvrn24314488
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 29 Aug 2023 07:48:58 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DA3A32004D;
        Tue, 29 Aug 2023 07:48:57 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 92E6520043;
        Tue, 29 Aug 2023 07:48:57 +0000 (GMT)
Received: from osiris (unknown [9.152.212.148])
        by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTPS;
        Tue, 29 Aug 2023 07:48:57 +0000 (GMT)
Date:   Tue, 29 Aug 2023 09:48:54 +0200
From:   Heiko Carstens <hca@linux.ibm.com>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     David Laight <David.Laight@aculab.com>,
        Jens Axboe <axboe@kernel.dk>,
        Stefan Haberland <sth@linux.ibm.com>,
        Jan =?iso-8859-1?Q?H=F6ppner?= <hoeppner@linux.ibm.com>,
        Peter Oberparleiter <oberpar@linux.ibm.com>,
        "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        llvm@lists.linux.dev
Subject: Re: [PATCH 1/1] s390/dasd: fix string length handling
Message-ID: <20230829074854.7031-A-hca@linux.ibm.com>
References: <20230828153142.2843753-1-hca@linux.ibm.com>
 <20230828153142.2843753-2-hca@linux.ibm.com>
 <f0419f6428ad404386ebca813dc1ec03@AcuMS.aculab.com>
 <ZO0k1Par4i4FBCWF@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZO0k1Par4i4FBCWF@google.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: y46bi7daQElJu--EkUjZczd_-Y4Td4G0
X-Proofpoint-GUID: 7QC5Ip_ZajZ5JM4o_i4KsZT-el29xkT-
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-29_04,2023-08-28_04,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 bulkscore=0 mlxscore=0 phishscore=0 suspectscore=0 clxscore=1011
 spamscore=0 impostorscore=0 mlxlogscore=394 malwarescore=0
 priorityscore=1501 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2308100000 definitions=main-2308290064
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 28, 2023 at 03:51:00PM -0700, Nick Desaulniers wrote:
> On Mon, Aug 28, 2023 at 05:18:37PM +0000, David Laight wrote:
> > From: Heiko Carstens
> > > Sent: 28 August 2023 16:32
> > >  	if (strlen(uid.vduit) > 0)
> > 
> > Does the compiler know enough to optimise that brain-dead test?
> > 
> 
> For the purposes of skipping diagnostics, no; clang performs semantic
> analysis BEFORE optimization (which is handled by LLVM). As such, clang
> will produce diagnostics on dead code.
> 
> Partly because LLVM isn't very ergonomic at emitting diagnostics from
> the backend, partly because Clang code owner and developers don't want
> clang to emit diagnostics dependent on optimization level.
> 
> I disagree with my compatriots, and you can read more thoughts here:
> https://discourse.llvm.org/t/rfc-improving-clangs-middle-and-back-end-diagnostics/69261?u=nickdesaulniers

Maybe I misunderstand what you write above, however clang (latest+greatest)
does indeed optimize the strlen() away and generates code which only tests
if uid.vduit[0] is zero or not.

Unlike gcc, which does not optimize this away and which uses the strlen()
inline assembly provided via string.h...
