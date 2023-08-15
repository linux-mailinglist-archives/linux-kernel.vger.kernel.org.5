Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28CC577C769
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 08:05:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234873AbjHOGEx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 02:04:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234918AbjHOGEL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 02:04:11 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8F4E19AD;
        Mon, 14 Aug 2023 23:04:09 -0700 (PDT)
Received: from pps.filterd (m0353727.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37F5vFfm015807;
        Tue, 15 Aug 2023 06:04:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=pp1; bh=Ekj719LWKN0wyPqfYBSToTLp5aoKdb+W6oRGPj7i/Mk=;
 b=PxKC7URHud/vwKyCEl03xut2r5dU96UQjVXE/XDKhdP6TrEbTtxjC4POR6axajfaH24B
 7fhMIWdZJvAfzz765Gv34Xmmo1/LpzIXhtSRa3/woJv9RNZPsfC6aDoYi25eM0RyN/4S
 4aqFxzLFAN4jF8msyQltQOC2nuucGue3ta4Yw4AWhQqD56hregN6wrW4jOhuJgH+LkNv
 LPYuBxGbC3LL+2MxFujYLlb3m69YjvUYVtL9K/oQujdF65heCgADMgyajvgUkAvbliUP
 s+Me9QSgwrkPrdeW6PuyveQ15r2bR+vfj/OT5/9nZqLIw51nGgkCSxU+rtaI071zU25A lw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3sg3nqg52r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 15 Aug 2023 06:04:05 +0000
Received: from m0353727.ppops.net (m0353727.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 37F5waNx018326;
        Tue, 15 Aug 2023 06:04:04 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3sg3nqg51j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 15 Aug 2023 06:04:04 +0000
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
        by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 37F4lg0P002465;
        Tue, 15 Aug 2023 06:04:03 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
        by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3sendn2u0r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 15 Aug 2023 06:04:02 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
        by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 37F63xhp23462586
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 15 Aug 2023 06:03:59 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id AB51320049;
        Tue, 15 Aug 2023 06:03:59 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7376E20040;
        Tue, 15 Aug 2023 06:03:59 +0000 (GMT)
Received: from osiris (unknown [9.152.212.60])
        by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTPS;
        Tue, 15 Aug 2023 06:03:59 +0000 (GMT)
Date:   Tue, 15 Aug 2023 08:03:57 +0200
From:   Heiko Carstens <hca@linux.ibm.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     Justin Stitt <justinstitt@google.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH] s390/ipl: refactor deprecated strncpy
Message-ID: <20230815060357.6414-B-hca@linux.ibm.com>
References: <20230811-arch-s390-kernel-v1-1-7edbeeab3809@google.com>
 <202308141626.3F82919BFD@keescook>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202308141626.3F82919BFD@keescook>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: RXT7uMFcO16kfrVK6WEQnyIYhgeSo48f
X-Proofpoint-ORIG-GUID: e4y6zSqo27BauUc_Fchn_0NX9-cjLulj
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-15_04,2023-08-10_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 lowpriorityscore=0 spamscore=0 impostorscore=0 mlxlogscore=776
 clxscore=1011 phishscore=0 bulkscore=0 priorityscore=1501 mlxscore=0
 adultscore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2306200000 definitions=main-2308150055
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 14, 2023 at 04:32:11PM -0700, Kees Cook wrote:
> On Fri, Aug 11, 2023 at 09:56:15PM +0000, Justin Stitt wrote:
> > `strncpy` is deprecated for use on NUL-terminated destination strings [1].
> > 
> > Use `strscpy_pad` which has the same behavior as `strncpy` here with the
> > extra safeguard of guaranteeing NUL-termination of destination strings.
> > In it's current form, this may result in silent truncation if the src
> > string has the same size as the destination string.
> > 
> > Link: www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings[1]
> > Link: https://github.com/KSPP/linux/issues/90
> > Cc: linux-hardening@vger.kernel.org
> > Signed-off-by: Justin Stitt <justinstitt@google.com>
> > ---
> >  arch/s390/kernel/ipl.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
...
> > -	strncpy(_value, buf, sizeof(_value) - 1);			\
> > +	strscpy_pad(_value, buf, sizeof(_value));			\
> 
> Padding isn't needed here -- the string are consumed by __cpcmd(), which
> explicitly uses strlen() and a memcpy to pass them off.
> 
> >  	strim(_value);							\
> 
> This existing code line is buggy, though -- it will not trim leading
> whitespace in the buffer. (It _returns_ a string that has been
> forward-adjusted.)

I'm quite sure that was intentional, so only whitespace at the end of
the string, in particular '\n', will be stripped.
But then again this code is 15 years old...

> I think this is an API mistake -- strim() should either do in-place
> changes for both ends or be defined with __much_check so the return
> value doesn't get lost. (But this is a separate issue.)

For __must_check see strstrip() which was actively avoided with commit
1d802e24774c ("[S390] Use strim instead of strstrip to avoid false
warnings.") many years ago.

For all converted usages of strstrip() by that commit it was indeed
intended to remove only trailing whitespace, where the above code snipped
is the only piece of code which is questionable, since it is user space
provided input; however I don't think this should be changed now.
