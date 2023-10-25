Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02AB47D6C5C
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 14:51:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343719AbjJYMvK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 08:51:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234913AbjJYMvH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 08:51:07 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41A31116;
        Wed, 25 Oct 2023 05:51:04 -0700 (PDT)
Received: from pps.filterd (m0353727.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39PClMf6030661;
        Wed, 25 Oct 2023 12:48:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=ULQ4YxdcX8D9cI1DIKnQIgJzU19KsvPJwigu81r9uA8=;
 b=eR86F/EbsAqLayHx+tBDE+qRqQBbFKHhivarsyNquDAIiqbow7KfyBkPnKzYcbVvskAV
 9N1HQoljX8OIuS35mKs5P9CADTmUBWsvF6ys/ELKUTtqXiuHpek8e6mMyVFoYV/CZFrZ
 dsFgA+SZWSZ2wEkjKYlXxx2V7y5DmYDKKxsILpK5zYW5vyjMVQFH9t3UfamKbbJy9Iu5
 a4/G4kqpJw+r+kqPwzq98NzQyZA1/w9dpRoIXXT4RIHC2a4OVlBNQ9PSXiNM4dgmCFn7
 V76zbb5q+eIxjI+E20s59H4DjQ+Eto+SzNWbRn8JKs7JQNUPyDSx2O+qfSGqQzkLwHj/ zw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ty3b202j4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 25 Oct 2023 12:48:51 +0000
Received: from m0353727.ppops.net (m0353727.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 39PClQrd030781;
        Wed, 25 Oct 2023 12:48:47 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ty3b202ch-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 25 Oct 2023 12:48:47 +0000
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
        by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 39PBi2k4012344;
        Wed, 25 Oct 2023 12:48:44 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
        by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 3tvup1x4mh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 25 Oct 2023 12:48:44 +0000
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com [10.39.53.228])
        by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 39PCmhSm28705464
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 25 Oct 2023 12:48:43 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 63E7658065;
        Wed, 25 Oct 2023 12:48:43 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A572758055;
        Wed, 25 Oct 2023 12:48:42 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.61.173.216])
        by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
        Wed, 25 Oct 2023 12:48:42 +0000 (GMT)
Message-ID: <ed4e9e491c381ea201c1ac37501c6582fba6334d.camel@linux.ibm.com>
Subject: Re: [RFC PATCH] certs: Only allow certs signed by keys on the
 builtin keyring
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Jarkko Sakkinen <jarkko@kernel.org>,
        Denis Glazkov <d.glazkov@omp.ru>
Cc:     David Howells <dhowells@redhat.com>,
        David Woodhouse <dwmw2@infradead.org>,
        "David S . Miller" <davem@davemloft.net>, keyrings@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org
Date:   Wed, 25 Oct 2023 08:48:42 -0400
In-Reply-To: <CWG7J7N7NE6L.3MHDW81QMPYRY@suppilovahvero>
References: <20231017122507.185896-1-zohar@linux.ibm.com>
         <CWG7J7N7NE6L.3MHDW81QMPYRY@suppilovahvero>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-22.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: CldYim4D4jzZ8ofLEelVGGlHu_e3dx_m
X-Proofpoint-GUID: vjUz4cSy6JV3TOQao940HKm-E3urhV7O
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-25_01,2023-10-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 mlxlogscore=999 spamscore=0 suspectscore=0 malwarescore=0 impostorscore=0
 phishscore=0 clxscore=1015 mlxscore=0 lowpriorityscore=0 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2310170001 definitions=main-2310250111
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2023-10-24 at 02:28 +0300, Jarkko Sakkinen wrote:
> On Tue Oct 17, 2023 at 3:25 PM EEST, Mimi Zohar wrote:
> > Originally the secondary trusted keyring provided a keyring to which extra
> > keys may be added, provided those keys were not blacklisted and were
> > vouched for by a key built into the kernel or already in the secondary
> > trusted keyring.
> >
> > On systems with the machine keyring configured, additional keys may also
> > be vouched for by a key on the machine keyring.
> >
> > Prevent loading additional certificates directly onto the secondary
> > keyring, vouched for by keys on the machine keyring, yet allow these
> > certificates to be loaded onto other trusted keyrings.
> >
> > Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>
> > ---
> >  certs/Kconfig                     | 16 +++++++++++++++-
> >  crypto/asymmetric_keys/restrict.c |  4 ++++
> >  2 files changed, 19 insertions(+), 1 deletion(-)
> >
> > diff --git a/certs/Kconfig b/certs/Kconfig
> > index 4a4dc8aab892..2e621963d260 100644
> > --- a/certs/Kconfig
> > +++ b/certs/Kconfig
> > @@ -88,7 +88,21 @@ config SECONDARY_TRUSTED_KEYRING
> >  	help
> >  	  If set, provide a keyring to which extra keys may be added, provided
> >  	  those keys are not blacklisted and are vouched for by a key built
> > -	  into the kernel or already in the secondary trusted keyring.
> > +	  into the kernel, machine keyring (if configured), or already in the
> > +	  secondary trusted keyring.
> > +
> > +config SECONDARY_TRUSTED_KEYRING_SIGNED_BY_BUILTIN
> > +	bool "Only allow additional certs signed by keys on the builtin trusted keyring"
> > +	depends on SECONDARY_TRUSTED_KEYRING
> > +	help
> > +	  If set, only certificates signed by keys on the builtin trusted
> > +	  keyring may be loaded onto the secondary trusted keyring.
> > +
> > +	  Note: The machine keyring, if configured, will be linked to the
> > +	  secondary keyring.  When enabling this option, it is recommended
> > +	  to also configure INTEGRITY_CA_MACHINE_KEYRING_MAX to prevent
> > +	  linking code signing keys with imputed trust to the secondary
> > +	  trusted keyring.
> >  
> >  config SECONDARY_TRUSTED_KEYRING_FOR_CA_CERTIFICATES_ONLY
> >  	bool "Allow only CA certificates to be added to the secondary trusted keyring"
> > diff --git a/crypto/asymmetric_keys/restrict.c b/crypto/asymmetric_keys/restrict.c
> > index 6b69ea40da23..afcd4d101ac5 100644
> > --- a/crypto/asymmetric_keys/restrict.c
> > +++ b/crypto/asymmetric_keys/restrict.c
> > @@ -102,6 +102,10 @@ int restrict_link_by_signature(struct key *dest_keyring,
> >  
> >  	if (use_builtin_keys && !test_bit(KEY_FLAG_BUILTIN, &key->flags))
> >  		ret = -ENOKEY;
> > +	else if (IS_BUILTIN(CONFIG_SECONDARY_TRUSTED_KEYRING_SIGNED_BY_BUILTIN) &&
> > +		 !strcmp(dest_keyring->description, ".secondary_trusted_keys") &&
> > +		 !test_bit(KEY_FLAG_BUILTIN, &key->flags))
> > +		ret = -ENOKEY;
> >  	else
> >  		ret = verify_signature(key, sig);
> >  	key_put(key);
> 
> Plese pick this to your tree.
> 
> Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>

Thanks, Jarkko.   Applied.

-- 
thanks,

Mimi




