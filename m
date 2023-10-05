Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 533707BA889
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 19:58:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230281AbjJER6a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 13:58:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229889AbjJER6T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 13:58:19 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC3F89E;
        Thu,  5 Oct 2023 10:58:17 -0700 (PDT)
Received: from pps.filterd (m0353727.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 395HkZG9021848;
        Thu, 5 Oct 2023 17:58:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : reply-to : to : cc : date : in-reply-to : references : content-type
 : mime-version : content-transfer-encoding; s=pp1;
 bh=ASEJAjxy3u7tD8sitmRDsvClbC0Hi0/48ZyBhDlZwsA=;
 b=Wa0xEtIUW96WZKzYrGMOomwW/JKt/u/ozaDosxtKucXEjNakiX2JqjdBgd7LgTTT+aEw
 pmjhOC0q2esGtlH2HgZTL/LlMSuU//3HqYgRNOUxaxfmUbYPRhD1wRqjX487N53kte1O
 bmk47z48We/UO3tlmrJ8fV59bz97BSwhED1s+azKnK+X+2sb+RZLtiIs/P9P7bZFVYXr
 Idpn1orA2f6Xy9oMk5j5hs/kYFJdCgjobAHZzW5gBaLY6n2e7zqpHbUj05BEJtqXwEAl
 rQFIEzSfaFXVGVpwfdUMgl8k/9jrsMb9XkusZJ7uwurkTcAqPXX1jOPbE1/SAL+jJ8jq hg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3tj1ue0d4r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 05 Oct 2023 17:58:04 +0000
Received: from m0353727.ppops.net (m0353727.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 395HuO27014845;
        Thu, 5 Oct 2023 17:58:04 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3tj1ue0d3x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 05 Oct 2023 17:58:04 +0000
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
        by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 395HWu8C017644;
        Thu, 5 Oct 2023 17:58:03 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
        by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3tey0p0041-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 05 Oct 2023 17:58:03 +0000
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com [10.39.53.231])
        by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 395Hw2mt3473978
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 5 Oct 2023 17:58:02 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9904958052;
        Thu,  5 Oct 2023 17:58:02 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 300AB58050;
        Thu,  5 Oct 2023 17:58:02 +0000 (GMT)
Received: from rhel-laptop.austin.ibm.com (unknown [9.41.250.135])
        by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
        Thu,  5 Oct 2023 17:58:02 +0000 (GMT)
Message-ID: <53755a0fbd6318d4783078259f2d2f8ab5f2f0b7.camel@linux.vnet.ibm.com>
Subject: Re: [PATCH] block: Fix regression in sed-opal for a saved key.
From:   Greg Joyce <gjoyce@linux.vnet.ibm.com>
Reply-To: gjoyce@linux.vnet.ibm.com
To:     Milan Broz <gmazyland@gmail.com>, linux-block@vger.kernel.org
Cc:     jonathan.derrick@linux.dev, axboe@kernel.dk,
        linux-kernel@vger.kernel.org, Ondrej Kozina <okozina@redhat.com>
Date:   Thu, 05 Oct 2023 12:58:01 -0500
In-Reply-To: <59535b4b-9f07-44c5-a7da-e6b2fc1c67bb@gmail.com>
References: <20231003100209.380037-1-gmazyland@gmail.com>
         <5c4fbafb1daa45f2faf60c7d587cd23c53d9393c.camel@linux.vnet.ibm.com>
         <59535b4b-9f07-44c5-a7da-e6b2fc1c67bb@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-22.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: CM-NZeh0zeKWgvg_P7fJpDaPts_btYuJ
X-Proofpoint-GUID: gp0FVayYExu0W28rkxxq9L4mMuzyZu0c
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-05_12,2023-10-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 impostorscore=0 mlxlogscore=999 mlxscore=0 suspectscore=0 clxscore=1015
 spamscore=0 malwarescore=0 lowpriorityscore=0 phishscore=0 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2310050136
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2023-10-05 at 08:58 +0200, Milan Broz wrote:
> On 10/4/23 22:54, Greg Joyce wrote:
> > On Tue, 2023-10-03 at 12:02 +0200, Milan Broz wrote:
> > > The commit 3bfeb61256643281ac4be5b8a57e9d9da3db4335
> > > introduced the use of keyring for sed-opal.
> > > 
> > > Unfortunately, there is also a possibility to save
> > > the Opal key used in opal_lock_unlock().
> > > 
> > > This patch switches the order of operation, so the cached
> > > key is used instead of failure for opal_get_key.
> > > 
> > > The problem was found by the cryptsetup Opal test recently
> > > added to the cryptsetup tree.
> > > 
> > > Fixes: 3bfeb6125664 ("block: sed-opal: keyring support for SED
> > > keys")
> > > Tested-by: Ondrej Kozina <okozina@redhat.com>
> > > Signed-off-by: Milan Broz <gmazyland@gmail.com>
> > > ---
> > >   block/sed-opal.c | 7 +++----
> > >   1 file changed, 3 insertions(+), 4 deletions(-)
> > > 
> > > diff --git a/block/sed-opal.c b/block/sed-opal.c
> > > index 6d7f25d1711b..04f38a3f5d95 100644
> > > --- a/block/sed-opal.c
> > > +++ b/block/sed-opal.c
> > > @@ -2888,12 +2888,11 @@ static int opal_lock_unlock(struct
> > > opal_dev
> > > *dev,
> > >   	if (lk_unlk->session.who > OPAL_USER9)
> > >   		return -EINVAL;
> > > 
> > > -	ret = opal_get_key(dev, &lk_unlk->session.opal_key);
> > > -	if (ret)
> > > -		return ret;
> > >   	mutex_lock(&dev->dev_lock);
> > >   	opal_lock_check_for_saved_key(dev, lk_unlk);
> > > -	ret = __opal_lock_unlock(dev, lk_unlk);
> > > +	ret = opal_get_key(dev, &lk_unlk->session.opal_key);
> > > +	if (!ret)
> > > +		ret = __opal_lock_unlock(dev, lk_unlk);
> > 
> > This is relying on opal_get_key() returning 0 to decide if
> > __opal_lock_unlock() is called. Is this really what you want? It
> > seems
> > that you would want to unlock if the key is a LUKS key, even if
> > opal_get_key() returns non-zero.
> 
> I think it is ok. That was logic introduced in your keyring patch
> anyway.
> 
> I just fixed that if key is cached (stored in OPAL struct), that key
> is used
> and subsequent opal_get_key() does nothing, returning 0.
> 
> The story is here that both OPAL lock and unlock need key, while LUKS
> logic never required key for lock (deactivation), so we rely on the
> cached
> OPAL key here. We do not need any key stored for unlocking (that is
> always
> decrypted from a keyslot)
> (I think requiring key for locking range is a design mistake in OPAL
> but
> that's not relevant for now :-)

Okay, if the key is such that opal_get_key() always returns 0, then I
agree there isn't an issue.

Greg

> 
> Milan
> 
> > >   	mutex_unlock(&dev->dev_lock);
> > > 
> > >   	return ret;

