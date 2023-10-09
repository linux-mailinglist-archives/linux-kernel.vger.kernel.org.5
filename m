Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 837587BE221
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 16:10:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343891AbjJIOKW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 10:10:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234028AbjJIOKU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 10:10:20 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D70D39D;
        Mon,  9 Oct 2023 07:10:15 -0700 (PDT)
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 399DlNlA004709;
        Mon, 9 Oct 2023 14:10:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=9xqLLC4x8Q2GXkrs6tRZbK+3gvPAlMhn7DAPvI0YOvM=;
 b=emw8h5IDqGY+9el13ppGWqBQVSqd5fQ4CNgZ8njKNq7ozkL4T2xSEAlnge9l6997toyi
 DvWD6qbCNjqLWFFnlAY1zWWom7WXLgwHa80UVBiqAwdGvyQBGfj4PoBajlDARUNDIhyj
 HtVVhA1/U2kk1l0sgY7TfAb7JgdLFCrt98w7+rlUbrN7x7zi3qKXnGjz/3qfNeqXYQpD
 y0v6PM50X6AvUpOePLC4oVHROWDzt1Z5lIFGwI9oADBx57VoTU9G+P238hOjlw5HpQMK
 SX+fWWNTi2EYbWp0mFfEcLgE0EH74BS0bxNzS0vUml4WlglgZc2oaszVJJzdWAJeDB7L FA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3tmjq88y7v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 09 Oct 2023 14:10:04 +0000
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 399Dn8RE013177;
        Mon, 9 Oct 2023 14:10:03 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3tmjq88y6q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 09 Oct 2023 14:10:03 +0000
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
        by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 399DThoV001170;
        Mon, 9 Oct 2023 14:10:02 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
        by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 3tkkvjh1r5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 09 Oct 2023 14:10:02 +0000
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com [10.241.53.101])
        by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 399EA1GZ6750840
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 9 Oct 2023 14:10:02 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A0C705805F;
        Mon,  9 Oct 2023 14:10:01 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2A0425805C;
        Mon,  9 Oct 2023 14:10:01 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.61.60.67])
        by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
        Mon,  9 Oct 2023 14:10:01 +0000 (GMT)
Message-ID: <34b8d71f240db5dc342ae70b1a30810ceb2dc6b2.camel@linux.ibm.com>
Subject: Re: [PATCH v3] certs: Add option to disallow non-CA certificates in
 secondary trusted keying
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Jarkko Sakkinen <jarkko@kernel.org>,
        Denis Glazkov <d.glazkov@omp.ru>
Cc:     "dhowells@redhat.com" <dhowells@redhat.com>,
        "dwmw2@infradead.org" <dwmw2@infradead.org>,
        "keyrings@vger.kernel.org" <keyrings@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Sergey Shtylyov <s.shtylyov@omp.ru>
Date:   Mon, 09 Oct 2023 10:10:00 -0400
In-Reply-To: <CVYCTWRQAXDF.2HY5028ZT9FEC@seitikki>
References: <CVS5MB3X82Q8.8KDB4346ROR5@suppilovahvero>
         <20231002104525.7631-1-d.glazkov@omp.ru>
         <CVYCTWRQAXDF.2HY5028ZT9FEC@seitikki>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-22.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: uhpjCBuMYgng9DOxkoEtP7V-OQvJ-4rp
X-Proofpoint-ORIG-GUID: VrSuf-jS2vejitvjWl6aHSMPSVQyetWG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-09_11,2023-10-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 adultscore=0 spamscore=0 bulkscore=0 clxscore=1011 phishscore=0
 mlxlogscore=999 malwarescore=0 suspectscore=0 lowpriorityscore=0
 impostorscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2310090117
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2023-10-03 at 02:49 +0300, Jarkko Sakkinen wrote:
> On Mon Oct 2, 2023 at 1:46 PM EEST, Denis Glazkov wrote:
> > The Linux kernel has an IMA (Integrity Measurement Architecture)
> > subsystem to check the integrity of the file system based on digital
> > signatures. IMA uses certificates in `.ima` keying to check integrity.
> >
> > Only certificates issued by one of the trusted CA (Certificate Authority)
> > certificates can be added to the `.ima` keying.
> >
> > The Linux kernel now has a secondary trusted keying to which trusted
> > certificates from user space can be added if you have superuser
> > privileges. Previously, all trusted certificates were in the built-in
> > trusted keying, which could not be modified from user space.
> > Trusted certificates were placed in the built-in trusted keying at
> > kernel compile time.
> >
> > The secondary trusted keying is designed so that any certificates that
> > are signed by one of the trusted CA certificates in the built-in or
> > secondary trusted keyring can be added to it.
> >
> > Let's imagine that we have the following certificate trust chain:
> >
> >              ┌───────────────────────────┬─────────────────────┐
> >              │                           │     ┌───────┐       │
> >              │                           │     │       │       │
> > ┌────────────▼────────┐    ┌─────────────▼─────▼────┐  │ ┌─────┴─────┐
> > │.builtin_trusted_keys│◄───┤.secondary_trusted_keys ├──┘ │   .ima    │
> > ├─────────────────────┤    ├────────────────────────┤    ├───────────┤
> > │     Root CA Cert    │-----► Intermediate CA Cert  │-----► IMA Cert │
> > └─────────────────────┘    └────────────────────────┘    └───────────┘
> >
> >                 Issues                  Restricted by
> >             -------------►             ──────────────►
> >
> > Since the IMA certificate is signed by a CA certificate from a secondary
> > trusted keying, an attacker with superuser privileges will be able to
> > add the IMA certificate to the secondary trusted keying. That is, the IMA
> > certificate will become trusted.
> >
> > Since, with `CONFIG_MODULE_SIG` option enabled, modules can only be
> > loaded into kernel space if they are signed with one of the trusted
> > certificates, an attacker could sign untrusted kernel modules with
> > the private key corresponding to the IMA certificate and successfully
> > load the untrusted modules into kernel space.
> >
> > This patch was created not to solve only the problem of loading
> > untrusted kernel modules, but to make it possible to use a secondary
> > trusted keying only as a part of a chain of trust containing only
> > CA certificates with no digital signature capability. This will
> > help avoid similar problems when new features appear in the linux
> > kernel that are similar to kernel modules in terms of their impact
> > on system security, which will also use trusted certificates for
> > signature verification.
> >
> > This patch adds the configuration that once enabled, only
> > certificates that meet the following requirements can be added
> > to the secondary trusted keying:
> >
> > 1. The certificate is a CA (Certificate Authority)
> > 2. The certificate must be used for verifying a CA's signatures
> > 3. The certificate must not be used for digital signatures
> >
> > Signed-off-by: Denis Glazkov <d.glazkov@omp.ru>
> > ---
> > v1 -> v2:
> >  - Rebase the patch from `linux-next` to the main `linux` repo master branch
> >  - Make the commit message more detailed
> >  - Move the variable declaration to the `if` block
> >  - Replace `#ifdef` with `IS_ENABLED` macro
> >
> > v2 -> v3:
> >  - Add the purpose and goal of the patch to the commit message
> > ---
> >  certs/Kconfig          |  9 +++++++++
> >  certs/system_keyring.c | 16 ++++++++++++++++
> >  2 files changed, 25 insertions(+)
> >
> > diff --git a/certs/Kconfig b/certs/Kconfig
> > index 1f109b070877..4a4dc8aab892 100644
> > --- a/certs/Kconfig
> > +++ b/certs/Kconfig
> > @@ -90,6 +90,15 @@ config SECONDARY_TRUSTED_KEYRING
> >  	  those keys are not blacklisted and are vouched for by a key built
> >  	  into the kernel or already in the secondary trusted keyring.
> >  
> > +config SECONDARY_TRUSTED_KEYRING_FOR_CA_CERTIFICATES_ONLY
> > +	bool "Allow only CA certificates to be added to the secondary trusted keyring"
> > +	depends on SECONDARY_TRUSTED_KEYRING
> > +	help
> > +	  If set, only CA certificates can be added to the secondary trusted keyring.
> > +	  An acceptable CA certificate must include the `keyCertSign` value in
> > +	  the `keyUsage` field. CA certificates that include the `digitalSignature`
> > +	  value in the `keyUsage` field will not be accepted.
> > +
> >  config SYSTEM_BLACKLIST_KEYRING
> >  	bool "Provide system-wide ring of blacklisted keys"
> >  	depends on KEYS
> > diff --git a/certs/system_keyring.c b/certs/system_keyring.c
> > index 9de610bf1f4b..ee14447374e7 100644
> > --- a/certs/system_keyring.c
> > +++ b/certs/system_keyring.c
> > @@ -99,6 +99,22 @@ int restrict_link_by_builtin_and_secondary_trusted(
> >  		/* Allow the builtin keyring to be added to the secondary */
> >  		return 0;
> >  
> > +	if (IS_ENABLED(CONFIG_SECONDARY_TRUSTED_KEYRING_FOR_CA_CERTIFICATES_ONLY) &&
> > +	    dest_keyring == secondary_trusted_keys) {
> > +		const struct public_key *pub = payload->data[asym_crypto];
> > +
> > +		if (type != &key_type_asymmetric)
> > +			return -EOPNOTSUPP;
> > +		if (!pub)
> > +			return -ENOPKG;
> > +		if (!test_bit(KEY_EFLAG_CA, &pub->key_eflags))
> > +			return -EPERM;
> > +		if (!test_bit(KEY_EFLAG_KEYCERTSIGN, &pub->key_eflags))
> > +			return -EPERM;
> > +		if (test_bit(KEY_EFLAG_DIGITALSIG, &pub->key_eflags))
> > +			return -EPERM;
> > +	}
> > +
> >  	return restrict_link_by_signature(dest_keyring, type, payload,
> >  					  secondary_trusted_keys);
> >  }
> > -- 
> > 2.34.1
> 
> I don't think this does any harm. What do you think Mimi?

I really like the idea of only allowing CA keys to be loaded onto the
secondary trusted keyring.  However, the secondary trusted keyring has
been around a long time with the ability of loading non CA keys.  Is
the real concern here about loading non CA keys signed by keys on the
builtin keyring or the new machine keyring?

It would make sense for the new Kconfig to somehow require
INTEGRITY_CA_MACHINE_KEYRING_MAX, if INTEGRITY_MACHINE_KEYRING is
configured.

-- 
thanks,

Mimi

