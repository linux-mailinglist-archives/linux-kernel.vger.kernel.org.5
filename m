Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF57C785A1E
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 16:13:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236090AbjHWONP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 10:13:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231654AbjHWONO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 10:13:14 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3206E50;
        Wed, 23 Aug 2023 07:13:12 -0700 (PDT)
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37NE2nhE002964;
        Wed, 23 Aug 2023 14:13:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=pp1; bh=foeDKteUjQLMeOPzPno5EYJrFO3Wneqr2OxPwpvdRKI=;
 b=KSzdHpnkq40hKMtDk2FlQcfRPgqs1gIX7U2fv0rFw/SZeGwKgCwZvLeCOmddeueeChpa
 BfQFvjcBH8eUtJxCKh0fU9sa+FqxWDwaQSt6GjOy/lkyQ8ebJsH4WfxpdToUT/POquAW
 /lIPsZhSxTmHctisObPWBSFRMl0QWmb8ygZ9WEcoR1kzifT0MlSgGtYi+bmWA3ce5b9h
 4ImvJZ1eugMSCVcIWc5nslcMZYYfRJCKX8N62cZp9/5oEBl6uequdPXd4Y+JThOsj/LT
 2U+ZHGcbTYezTGdjvN2TN634sNc6WHQMwR+g+wri/lrpHLm2ci3hsXf+XXcY+dk2LOqf 4Q== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3snjxr1e7j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 23 Aug 2023 14:13:11 +0000
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 37NDuBGF005839;
        Wed, 23 Aug 2023 14:13:10 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3snjxr1e78-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 23 Aug 2023 14:13:10 +0000
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
        by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 37NC970j018278;
        Wed, 23 Aug 2023 14:13:09 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
        by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 3sn21sew9p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 23 Aug 2023 14:13:09 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
        by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 37NED6Ns63635908
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 23 Aug 2023 14:13:07 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DB21D2004D;
        Wed, 23 Aug 2023 14:13:06 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3CACC20040;
        Wed, 23 Aug 2023 14:13:06 +0000 (GMT)
Received: from osiris (unknown [9.171.11.14])
        by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTPS;
        Wed, 23 Aug 2023 14:13:06 +0000 (GMT)
Date:   Wed, 23 Aug 2023 16:13:04 +0200
From:   Heiko Carstens <hca@linux.ibm.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Justin Stitt <justinstitt@google.com>,
        Peter Oberparleiter <oberpar@linux.ibm.com>,
        Stefan Haberland <sth@linux.ibm.com>,
        Jan Hoeppner <hoeppner@linux.ibm.com>,
        linux-s390@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
        Viktor Mihajlovski <mihajlov@linux.ibm.com>
Subject: Re: [PATCH] partitions/ibm: refactor deprecated strncpy
Message-ID: <20230823141304.14378-F-hca@linux.ibm.com>
References: <20230822-strncpy-block-partitions-cmdline-ibm-v1-1-154dea8f755c@google.com>
 <20230823134936.14378-E-hca@linux.ibm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230823134936.14378-E-hca@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: BXCbZVuf1ktMPBGyieHVyeWOk_nXdQEa
X-Proofpoint-ORIG-GUID: HFOC52etbveNLs7L90fh8BoqKBqRZDUa
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-23_08,2023-08-22_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 adultscore=0
 malwarescore=0 phishscore=0 spamscore=0 clxscore=1015 lowpriorityscore=0
 suspectscore=0 impostorscore=0 mlxscore=0 priorityscore=1501 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2308100000
 definitions=main-2308230124
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 23, 2023 at 03:49:36PM +0200, Heiko Carstens wrote:
> On Tue, Aug 22, 2023 at 11:59:26PM +0000, Justin Stitt wrote:
> > `strncpy` is deprecated for use on NUL-terminated destination strings [1].
> > 
> > A suitable replacement is `strscpy` [2] due to the fact that it
> > guarantees NUL-termination on its destination buffer argument which is
> > _not_ the case for `strncpy`!
> > 
> > Link: www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings[1]
> > Link: https://manpages.debian.org/testing/linux-manual-4.8/strscpy.9.en.html [2]
> > Link: https://github.com/KSPP/linux/issues/90
> > Cc: linux-hardening@vger.kernel.org
> > Signed-off-by: Justin Stitt <justinstitt@google.com>
> > ---
> >  block/partitions/ibm.c | 8 ++++----
> >  1 file changed, 4 insertions(+), 4 deletions(-)
> > 
> > diff --git a/block/partitions/ibm.c b/block/partitions/ibm.c
> > index 403756dbd50d..e5893cf71b57 100644
> > --- a/block/partitions/ibm.c
> > +++ b/block/partitions/ibm.c
> > @@ -111,11 +111,11 @@ static int find_label(struct parsed_partitions *state,
> >  		    !strcmp(temp, "LNX1") ||
> >  		    !strcmp(temp, "CMS1")) {
> >  			if (!strcmp(temp, "VOL1")) {
> > -				strncpy(type, label->vol.vollbl, 4);
> > -				strncpy(name, label->vol.volid, 6);
> > +				strscpy(type, label->vol.vollbl, 4);
> > +				strscpy(name, label->vol.volid, 6);
> >  			} else {
> > -				strncpy(type, label->lnx.vollbl, 4);
> > -				strncpy(name, label->lnx.volid, 6);
> > +				strscpy(type, label->lnx.vollbl, 4);
> > +				strscpy(name, label->lnx.volid, 6);
> >  			}
> >  			EBCASC(type, 4);
> >  			EBCASC(name, 6);
> 
> I'm quite sure this is not correct, since both type and name are not
> necessarily NUL-terminated, and this code operates on purpose on such
> strings.
> 
> Since currently Stefan and Jan are both not available, I added Peter
> Oberparleiter to Cc who hopefully knows better than me.

I was just made aware of that this patch is already in linux-next. And
indeed: partition detection does not work anymore for DASDs. With this
patch reverted it works again.

Jens, can you remove or revert this patch again, please?
