Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0400978BFD9
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 10:03:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233983AbjH2IC6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 04:02:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233971AbjH2IC1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 04:02:27 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A61D113;
        Tue, 29 Aug 2023 01:02:24 -0700 (PDT)
Received: from pps.filterd (m0353723.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37T7cFbI012948;
        Tue, 29 Aug 2023 08:02:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=pp1; bh=cn9NV29aqxy8rCeQ939fkpQKBjrL9TcklKlwn/V539E=;
 b=SnDaPmqPcZdC6nBpqSUNT9o9W3iGJmK7PiesGJwZyYkWh6KBvaXkst54TEqSzLEvpgcR
 PyUxp4NinMnca/NY39wx0oY5hYudeIczHjf2xeDf17uEtSZqa+8zuhRCDz9SqNkXGXAa
 JFx2Uyaa46co2wD+Cw2Rr42/CxQb1NZiNg/wUeXO2IOimSK//srm/rE9tDMrGt00Nusu
 JETqyOKCYmbyb3+CSGMJsySxJA36xaczRWwlgZprtJLBJnR8YFaYRWGS58+/z96DjTgF
 714irIz/3FEhHrEPIrreF1nyCwmxqjZ22fEfqx8r/Scyu56kdC0a7bNvOP06gRuVYKx5 jg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3sr87hnrb1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 29 Aug 2023 08:02:09 +0000
Received: from m0353723.ppops.net (m0353723.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 37T80ohf000302;
        Tue, 29 Aug 2023 08:02:09 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3sr87hnrak-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 29 Aug 2023 08:02:09 +0000
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
        by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 37T6ZT7V004891;
        Tue, 29 Aug 2023 08:02:08 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
        by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 3squqsj3xn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 29 Aug 2023 08:02:08 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
        by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 37T8252Z44499284
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 29 Aug 2023 08:02:05 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4072B20043;
        Tue, 29 Aug 2023 08:02:05 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 05ED020040;
        Tue, 29 Aug 2023 08:02:05 +0000 (GMT)
Received: from osiris (unknown [9.152.212.148])
        by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS;
        Tue, 29 Aug 2023 08:02:04 +0000 (GMT)
Date:   Tue, 29 Aug 2023 10:02:02 +0200
From:   Heiko Carstens <hca@linux.ibm.com>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Jens Axboe <axboe@kernel.dk>, Stefan Haberland <sth@linux.ibm.com>,
        Jan =?iso-8859-1?Q?H=F6ppner?= <hoeppner@linux.ibm.com>,
        Peter Oberparleiter <oberpar@linux.ibm.com>,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-block@vger.kernel.org, nathan@kernel.org,
        llvm@lists.linux.dev, David Laight <David.Laight@aculab.com>
Subject: Re: [PATCH 1/1] s390/dasd: fix string length handling
Message-ID: <20230829080202.7031-B-hca@linux.ibm.com>
References: <20230828153142.2843753-1-hca@linux.ibm.com>
 <20230828153142.2843753-2-hca@linux.ibm.com>
 <ZO0j3M8KFWeEznXy@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZO0j3M8KFWeEznXy@google.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: CrzYG7I7CQWlUL5LRJ7yoU_EOCjjHrPy
X-Proofpoint-GUID: ArBgXdNqSPFzG8FatX2Jiz2AEZtsDvcl
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-29_04,2023-08-28_04,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=983
 priorityscore=1501 clxscore=1015 impostorscore=0 suspectscore=0
 adultscore=0 mlxscore=0 malwarescore=0 phishscore=0 bulkscore=0
 lowpriorityscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx
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

On Mon, Aug 28, 2023 at 03:46:52PM -0700, Nick Desaulniers wrote:
> On Mon, Aug 28, 2023 at 05:31:42PM +0200, Heiko Carstens wrote:
> > Building dasd_eckd.o with latest clang reveals this bug:
> > 
> >     CC      drivers/s390/block/dasd_eckd.o
> >       drivers/s390/block/dasd_eckd.c:1082:3: warning: 'snprintf' will always be truncated;
> >       specified size is 1, but format string expands to at least 11 [-Wfortify-source]
> >        1082 |                 snprintf(print_uid, sizeof(*print_uid),
> >             |                 ^
> >       drivers/s390/block/dasd_eckd.c:1087:3: warning: 'snprintf' will always be truncated;
> >       specified size is 1, but format string expands to at least 10 [-Wfortify-source]
> >        1087 |                 snprintf(print_uid, sizeof(*print_uid),
> >             |                 ^
> > 
> > Fix this by moving and using the existing UID_STRLEN for the arrays
> > that are being written to. Also rename UID_STRLEN to DASD_UID_STRLEN
> > to clarify its scope.
> > 
> > Fixes: 23596961b437 ("s390/dasd: split up dasd_eckd_read_conf")
> > Reviewed-by: Peter Oberparleiter <oberpar@linux.ibm.com>
> > Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
> 
> Thanks for the patch! Nathan just reported a bunch of these. I took a
> look at these two and thought "yeah that's clearly a bug in the kernel
> sources." Fix LGTM.
> 
> Reported-by: Nathan Chancellor <nathan@kernel.org>
> Closes: https://github.com/ClangBuiltLinux/linux/issues/1923
> Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
> 
> I also like David's idea of passing `char ident [DASD_UID_STRLEN]`, too,
> but I don't feel strongly either way.

Well, this is supposed to be the "minimal" fix. I consider everything else
additional cleanup work, which can and should be done by Stefan and Jan who
maintain this device driver.

For example there is more or less identical code within dasd_devmap.c
(dasd_uid_show()), where it would make sense to de-deduplicate the
code. And then of course there is the already mentioned rather pointless
strlen() invocation; plus there are many other string operations / format
strings, which also should be addressed.
E.g. there are quite a couple of "%p" printk format specifiers which are
pointless, since pointer values get hashed since years - so a more or less
random value will be printed, etc.

However all of this is up to Stefan and Jan.

So I consider this current fix as good enough and final.
