Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B77B5753E64
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 17:05:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236015AbjGNPFv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 11:05:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235588AbjGNPFu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 11:05:50 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62F8B26A5;
        Fri, 14 Jul 2023 08:05:49 -0700 (PDT)
Received: from pps.filterd (m0353722.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36EEnpxX016550;
        Fri, 14 Jul 2023 15:03:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=kD78eAiZbI+U+lLMlmDJuy16dER8zA3nusAxpW3+onI=;
 b=DalYv+HFnLPywzn3AeU0+iwdQgrKSEdvAPCOme31X21rhBvu02rtxk52heH0oPCiASSX
 6P/NwcGIh78t9jWdC+yNku+9Sen3EL18L4FTMloOhebxJCLBwtguYIaOjkokmllmrgrR
 Y7y0MxVSOkcLLpmn9hDpAwK7smOJHUJ8wAsxtXDwR0akN4gDOeup4lukYzqpNJuGE9wq
 glf9eOSoKAA3ox1UdhMPj1pHYkR8ufyRotwPpCApI8q25yb8NZptl3vX5q2Seulrzg/k
 nzzhgejehiTmSJeQbf4ldn3LFaZ3SRxaiTBIf7u0XplY6XfvE+chaExLj4UP4EUISiZz zA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ru8fa8ast-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 14 Jul 2023 15:03:00 +0000
Received: from m0353722.ppops.net (m0353722.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 36EEoUoO018275;
        Fri, 14 Jul 2023 15:02:59 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ru8fa8as0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 14 Jul 2023 15:02:59 +0000
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
        by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 36EDaQXx007313;
        Fri, 14 Jul 2023 15:02:58 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
        by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 3rtpvs1y88-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 14 Jul 2023 15:02:58 +0000
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com [10.241.53.102])
        by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 36EF2vxI36438462
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 14 Jul 2023 15:02:57 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8E0A258060;
        Fri, 14 Jul 2023 15:02:57 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 268F85803F;
        Fri, 14 Jul 2023 15:02:57 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.61.79.213])
        by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
        Fri, 14 Jul 2023 15:02:57 +0000 (GMT)
Message-ID: <42179df523b4ab1d9a804f948bd6b0ab6dc69721.camel@linux.ibm.com>
Subject: Re: [PATCH] kexec_file: ima: allow loading a kernel with its IMA
 signature verified
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Coiby Xu <coxu@redhat.com>, Paul Moore <paul@paul-moore.com>
Cc:     linux-integrity@vger.kernel.org,
        linux-security-module <linux-security-module@vger.kernel.org>,
        Eric Biederman <ebiederm@xmission.com>,
        "open list:KEXEC" <kexec@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>
Date:   Fri, 14 Jul 2023 11:02:56 -0400
In-Reply-To: <dsiyhyusai6yvet3dd44c6ptumw3fq4j3xfvi5qy6ebwkoyk43@g3anjnbhzvqk>
References: <20230711031604.717124-1-coxu@redhat.com>
         <eaa1f1901abbceb2edc0aadaa94d9d959413c984.camel@linux.ibm.com>
         <dsiyhyusai6yvet3dd44c6ptumw3fq4j3xfvi5qy6ebwkoyk43@g3anjnbhzvqk>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-22.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: ZXHV7T5PxH3AaQTXs50RujDQ6K_FLHoV
X-Proofpoint-ORIG-GUID: 0cE8LG-qs0YFGQJ7wbqTOM7g7qaB8X_U
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-14_06,2023-07-13_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 phishscore=0
 lowpriorityscore=0 adultscore=0 priorityscore=1501 impostorscore=0
 malwarescore=0 mlxlogscore=999 bulkscore=0 mlxscore=0 spamscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2307140132
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[CC'ing Paul Moore]

On Fri, 2023-07-14 at 09:46 +0800, Coiby Xu wrote:
> On Wed, Jul 12, 2023 at 02:31:43PM -0400, Mimi Zohar wrote:
> >[Cc'ing the LSM mailing list.]
> >
> >On Tue, 2023-07-11 at 11:16 +0800, Coiby Xu wrote:
> >> When IMA has verified the signature of the kernel image, kexec'ing this
> >> kernel should be allowed.
> >>
> >> Fixes: af16df54b89d ("ima: force signature verification when CONFIG_KEXEC_SIG is configured")
> >> Signed-off-by: Coiby Xu <coxu@redhat.com>
> >
> >The original commit  29d3c1c8dfe7 ("kexec: Allow kexec_file() with
> >appropriate IMA policy when locked down") was not in lieu of the PE-
> >COFF signature, but allowed using the IMA signature on other
> >architectures.
> >
> >Currently on systems with both PE-COFF and IMA signatures, both
> >signatures are verified, assuming the file is in the IMA policy.  If
> >either signature verification fails, the kexec fails.
> >
> >With this patch, only the IMA signature would be verified.
> 
> Thanks for correcting me! I thought it's already a consensus that we could use
> either signature to verify a kernel image because that's what the code of
> commit 29d3c1c8dfe7 has done and the code comment seems to confirm it.  But if
> we just read the commit message, it indeed didn't give an answer on whether x86
> and ARM are only allowed to use PE-COFF signature.

I'm not aware of any consensus one way or the other.  Commit
29d3c1c8dfe7 continued to fail the kexec on failure, when
CONFIG_KEXEC_SIG_FORCE was enabled.

As there isn't a lockdown maintainer, Paul are you ok with this change?

> 
> >
> >> ---
> >>  kernel/kexec_file.c | 14 +++++++++-----
> >>  1 file changed, 9 insertions(+), 5 deletions(-)
> >>
> >> diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
> >> index 881ba0d1714c..96fce001fbc0 100644
> >> --- a/kernel/kexec_file.c
> >> +++ b/kernel/kexec_file.c
> >> @@ -162,6 +162,13 @@ kimage_validate_signature(struct kimage *image)
> >>  	ret = kexec_image_verify_sig(image, image->kernel_buf,
> >>  				     image->kernel_buf_len);
> >>  	if (ret) {
> >> +		/*
> >> +		 * If the kernel image already has its IMA signature verified, permit it.
> >> +		 */
> >> +		if (ima_appraise_signature(READING_KEXEC_IMAGE)) {
> >> +			pr_notice("The kernel image already has its IMA signature verified.\n");
> >> +			return 0;
> >> +		}
> >>
> >>  		if (sig_enforce) {
> >>  			pr_notice("Enforced kernel signature verification failed (%d).\n", ret);
> >> @@ -169,12 +176,9 @@ kimage_validate_signature(struct kimage *image)
> >>  		}
> >>
> >>  		/*
> >> -		 * If IMA is guaranteed to appraise a signature on the kexec
> >> -		 * image, permit it even if the kernel is otherwise locked
> >> -		 * down.
> >> +		 * When both IMA and KEXEC_SIG fail in lockdown mode, reject it.
> >>  		 */
> >> -		if (!ima_appraise_signature(READING_KEXEC_IMAGE) &&
> >> -		    security_locked_down(LOCKDOWN_KEXEC))
> >> +		if (security_locked_down(LOCKDOWN_KEXEC))
> >>  			return -EPERM;
> >>
> >>  		pr_debug("kernel signature verification failed (%d).\n", ret);
> >
> >
> 

