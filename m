Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2EFE75B0ED
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 16:13:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230422AbjGTONT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 10:13:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229592AbjGTONQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 10:13:16 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC3052115;
        Thu, 20 Jul 2023 07:13:15 -0700 (PDT)
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36KE7pnL000536;
        Thu, 20 Jul 2023 14:13:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=JHHpENURdf5rB7etiqoKe/V/ViYThscFn9W/0Kvtu+w=;
 b=h0leQb4uAKWvBTcKBAms8xFVhrv+9FV7SWULIAlP0jJeF1F8EC9A5DXohPlWAkGQptq2
 JZ/gNC7NvBbA9fjbQMwDDSlugJf9cq9UW4a6CQKDkJ5AXxqItUJcdVVUsiG9xuh/Ivju
 ViMqBqlbXPuC+CLr/1nBKyk0oze0rQUQ8Zg5CpuBtgVjYrHKJHSuaPWC8ZRrgPIDWiSu
 F0wbTBRG/iYletcdDpNxrH75cIGLX0aMBO0SvgE0MpOATxQjjuzqoviAY2ZXmzlDE7/l
 GLMEdhUXGjAdsx8oijxpLZyXVgruYsuD935oDfjfn/60pIej/4ZjRyynddE6N6rjdsqy pA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3rxwcgw4hu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 20 Jul 2023 14:13:02 +0000
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 36KDqgD6030761;
        Thu, 20 Jul 2023 14:12:54 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3rxwcgw496-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 20 Jul 2023 14:12:53 +0000
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
        by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 36KDoCJT016862;
        Thu, 20 Jul 2023 14:12:37 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
        by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 3rv5sryvqx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 20 Jul 2023 14:12:37 +0000
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com [10.39.53.228])
        by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 36KECaL124838768
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 20 Jul 2023 14:12:37 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B89E45804B;
        Thu, 20 Jul 2023 14:12:36 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D35AB58059;
        Thu, 20 Jul 2023 14:12:35 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.61.191.187])
        by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
        Thu, 20 Jul 2023 14:12:35 +0000 (GMT)
Message-ID: <b6a0475c67e975cf564e4b78830ae0e598c584ac.camel@linux.ibm.com>
Subject: Re: [PATCH] ima: require signed IMA policy when UEFI secure boot is
 enabled
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Coiby Xu <coxu@redhat.com>
Cc:     linux-integrity@vger.kernel.org,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        Paul Moore <paul@paul-moore.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        "open list:SECURITY SUBSYSTEM" 
        <linux-security-module@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Date:   Thu, 20 Jul 2023 10:12:35 -0400
In-Reply-To: <kglacif5fwh3byrjkmlzygpnaecdb2zxh6hbglnvdbsfu7hbxm@gc3mjr37mnpb>
References: <20230703115442.129725-1-coxu@redhat.com>
         <b61fedf214cbe72de063a3bf516dd72f80595219.camel@linux.ibm.com>
         <kglacif5fwh3byrjkmlzygpnaecdb2zxh6hbglnvdbsfu7hbxm@gc3mjr37mnpb>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-22.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 6nk1TxvYqy4j526hl-FRjEE0_qfBbqzg
X-Proofpoint-ORIG-GUID: wb_rzvVwE4dwTN7r0uqQdOR67Pxyhg2y
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-20_07,2023-07-20_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 bulkscore=0
 phishscore=0 mlxlogscore=999 suspectscore=0 impostorscore=0 adultscore=0
 spamscore=0 lowpriorityscore=0 mlxscore=0 priorityscore=1501 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2307200118
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2023-07-14 at 09:29 +0800, Coiby Xu wrote:
> On Tue, Jul 04, 2023 at 08:57:10AM -0400, Mimi Zohar wrote:
> >On Mon, 2023-07-03 at 19:54 +0800, Coiby Xu wrote:
> >> With the introduction of the .machine keyring for UEFI-based systems,
> >> users are able to add custom CAs keys via MOK. This allow users to sign
> >> their own IMA polices. For the sake of security, mandate signed IMA
> >> policy when UEFI secure boot is enabled.
> >>
> >> Suggested-by: Mimi Zohar <zohar@linux.ibm.com>
> >> Signed-off-by: Coiby Xu <coxu@redhat.com>

With commit 099f26f22f58 ("integrity: machine keyring CA
configuration") it is now possible to require signed IMA policies
without having to recompile the kernel.  Please note this change might
affect existing users/tests.

> >> ---
> >>  security/integrity/ima/ima_efi.c | 3 +++
> >>  1 file changed, 3 insertions(+)
> >>
> >> diff --git a/security/integrity/ima/ima_efi.c b/security/integrity/ima/ima_efi.c
> >> index 9db66fe310d4..bb2881759505 100644
> >> --- a/security/integrity/ima/ima_efi.c
> >> +++ b/security/integrity/ima/ima_efi.c
> >> @@ -58,6 +58,9 @@ static const char * const sb_arch_rules[] = {
> >>  #if !IS_ENABLED(CONFIG_MODULE_SIG)
> >>  	"appraise func=MODULE_CHECK appraise_type=imasig",
> >>  #endif
> >> +#if IS_ENABLED(CONFIG_INTEGRITY_MACHINE_KEYRING) && IS_ENABLED(CONFIG_IMA_KEYRINGS_PERMIT_SIGNED_BY_BUILTIN_OR_SECONDARY)
> >> +	"appraise func=POLICY_CHECK appraise_type=imasig",
> >> +#endif /* CONFIG_INTEGRITY_MACHINE_KEYRING && IMA_KEYRINGS_PERMIT_SIGNED_BY_BUILTIN_OR_SECONDARY */
> >>  	"measure func=MODULE_CHECK",
> >>  	NULL
> >>  };
> >
> >Thanks, Coiby.
> 
> You are welcome!
> 
> >
> >Using IS_ENABLED() is not wrong, but unnecessary.  IS_BUILTIN()
> >suffices.
> 
> Thanks for the reminding! When I was going to apply this suggestion, I
> noticed ima_efi.c uses IS_ENABLED for all configuration items i.e.
> CONFIG_MODULE_SIG and CONFIG_KEXEC_SIG which are all of bool type. Would
> you like me to switch all IS_ENABLEs to IS_BUILTIN or still use
> IS_ENABLED? While IS_BUILTIN is exclusively for bool type, it's not as
> intuitive as IS_ENABLED. So it's not easy for me to make a choice.

Sure, for consistency with the other rules IS_ENABLED is fine.

thanks,

Mimi

