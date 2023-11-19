Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E5467F0630
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Nov 2023 13:39:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230470AbjKSMjN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Nov 2023 07:39:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbjKSMjM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Nov 2023 07:39:12 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0249C12D;
        Sun, 19 Nov 2023 04:39:06 -0800 (PST)
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AJAFYSJ027516;
        Sun, 19 Nov 2023 12:39:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=yOrnK/542Zoh3v/mcdS03rZ1TLbYIVoIRt2JO2cQx5s=;
 b=adUOiy626HavItD8J1a2aZZyWPKwNOv63ngUtRyDJTGHs9N4++11Iq0tKW6Z8DvBvQlg
 eM3hrucvled1CXAeXFm+pb0ec+IbkCBnNiWCFWRbI6TeMrMg7TapOTr9TWySDL6WfP4x
 U5ZRnhJ3TFFRwJbWz+5++nopKRA7KIR5UBrdxzyMEJGwOCvo0F2e8ueaU3E0t50f/T/r
 nyoapazQyV96+qbWuffjL6ozB+zUs2QA8DaBqf6HNJV9LAaRjUZSWrK8KD09lqkY/Fbd
 AqyB64HL1nL3fiKMfjVdd3VxJT8PKfpKj3J32NGKAKwuWpc2KJCF8Oikdfq8OWHqbUv3 wQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3uf7kh0dyd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 19 Nov 2023 12:39:05 +0000
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3AJCU5gS010116;
        Sun, 19 Nov 2023 12:39:05 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3uf7kh0dx7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 19 Nov 2023 12:39:04 +0000
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
        by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3AJBJMEn007569;
        Sun, 19 Nov 2023 12:39:03 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
        by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 3ufaa1jacq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 19 Nov 2023 12:39:03 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
        by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3AJCd0s514222034
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 19 Nov 2023 12:39:00 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id AAB3520043;
        Sun, 19 Nov 2023 12:39:00 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9A53620040;
        Sun, 19 Nov 2023 12:38:59 +0000 (GMT)
Received: from li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com (unknown [9.171.64.81])
        by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTPS;
        Sun, 19 Nov 2023 12:38:59 +0000 (GMT)
Date:   Sun, 19 Nov 2023 13:38:57 +0100
From:   Alexander Gordeev <agordeev@linux.ibm.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     Steffen Maier <maier@linux.ibm.com>,
        Benjamin Block <bblock@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Azeem Shaikh <azeemshaikh38@gmail.com>,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH] scsi: zfcp: Replace strlcpy() with strscpy()
Message-ID: <ZVoB4b2/X3jCPOdG@li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com>
References: <20231116191435.work.581-kees@kernel.org>
 <ZVeuwT1rhMT5UWGB@li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZVeuwT1rhMT5UWGB@li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: wNX5z6b6QR__cf8Wx-hUwx8zwubhvZl8
X-Proofpoint-GUID: 4jKpwIDzsMaxjwokS--qpWdF1dfYPime
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-19_11,2023-11-17_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 spamscore=0
 lowpriorityscore=0 malwarescore=0 phishscore=0 adultscore=0 mlxscore=0
 priorityscore=1501 clxscore=1015 bulkscore=0 impostorscore=0
 mlxlogscore=684 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311190095
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 17, 2023 at 07:19:48PM +0100, Alexander Gordeev wrote:
> > @@ -900,8 +900,15 @@ static void zfcp_fc_rspn(struct zfcp_adapter *adapter,
> >  	zfcp_fc_ct_ns_init(&rspn_req->ct_hdr, FC_NS_RSPN_ID,
> >  			   FC_SYMBOLIC_NAME_SIZE);
> >  	hton24(rspn_req->rspn.fr_fid.fp_fid, fc_host_port_id(shost));
> > -	len = strlcpy(rspn_req->rspn.fr_name, fc_host_symbolic_name(shost),
> > -		      FC_SYMBOLIC_NAME_SIZE);
> > +	len = strscpy(rspn_req->name, fc_host_symbolic_name(shost),
> > +		      sizeof(rspn_req->name));
> 
> Could you please explain why do you copy to rspn_req->name instead
> of rspn_req->rspn.fr_name?

Please, ignore this (stupid Friday evening) quesiton.

Although the use of sizeof() is right thing, FC_SYMBOLIC_NAME_SIZE
is so ubiquotous in this source that it probably makes sense to
address in a separate cleanup.

@Steffen, @Benjamin, could you please comment in this and below?

> > +	/*
> > +	 * It should be impossible for this to truncate, as
> > +	 * sizeof(rspn_req->name) is equal to max size of
> > +	 * fc_host_symbolic_name(shost), but check anyway.
> > +	 */
> > +	if (len < 0)
> > +		len = sizeof(rspn_req->name) - 1;

Not sure if this check is really needed. It could have been done
for strlcpy() also, but as you say - should not ever happen.

> >  	rspn_req->rspn.fr_name_len = len;
> >  
> >  	sg_init_one(&fc_req->sg_req, rspn_req, sizeof(*rspn_req));

Thanks!
