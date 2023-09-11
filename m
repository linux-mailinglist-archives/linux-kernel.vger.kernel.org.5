Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D1AB79C20B
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 03:58:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233285AbjILB6w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 21:58:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233980AbjILB6k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 21:58:40 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68FF11B5A9D;
        Mon, 11 Sep 2023 18:29:18 -0700 (PDT)
Received: from pps.filterd (m0353724.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38BMt0tG021187;
        Mon, 11 Sep 2023 23:08:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=9yANKZK3PeF72Ck5nYKGP3CLYCYiOXQukLLlpdLxsZk=;
 b=Sc/BgO92r3Nr0L9du0pIbS4ZYOwGmzhaiUTvu5Jz5WjeRk14Bc79S39nL9i0hm9XnJWc
 N8OE49rH0CPB1z9sELV+peSAalp7cR5OG2f2juihcrlUo99C09VSUA6ajRPSWJasoVpq
 IDPhiVG4NSmy/4b4Ifx95jBbsp4uG5lkwQvMC9qKhTQhDSYjeEYdIUzRpHtOQqasOlU5
 SzVkIloKaOUvdcjrEsHyGl19aqI1P/LyRzbrTjyI5CqFFTyQYi6tFLEu8vKEc73mgB2O
 ETyA2EVLXAnknYP/e1mIMOhLeS3qAOhPqqB1V5eKTUT+YUFlYCe8bTtuu0T6V1xf8PL2 pw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3t2c3t89j6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 11 Sep 2023 23:08:27 +0000
Received: from m0353724.ppops.net (m0353724.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 38BN7cfC024214;
        Mon, 11 Sep 2023 23:08:24 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3t2c3t892h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 11 Sep 2023 23:08:23 +0000
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
        by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 38BLBwJl012151;
        Mon, 11 Sep 2023 23:08:12 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
        by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3t13dyenca-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 11 Sep 2023 23:08:12 +0000
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com [10.241.53.103])
        by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 38BN8BJq21299608
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 11 Sep 2023 23:08:11 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 75A9D5806D;
        Mon, 11 Sep 2023 23:08:11 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 875EC58064;
        Mon, 11 Sep 2023 23:08:10 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.61.27.137])
        by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
        Mon, 11 Sep 2023 23:08:10 +0000 (GMT)
Message-ID: <ba2f5560800608541e81fbdd28efa9875b35e491.camel@linux.ibm.com>
Subject: Re: [PATCH] certs: Restrict blacklist updates to the secondary
 trusted keyring
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Eric Snowberg <eric.snowberg@oracle.com>,
        =?ISO-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>
Cc:     Jarkko Sakkinen <jarkko@kernel.org>,
        David Howells <dhowells@redhat.com>,
        David Woodhouse <dwmw2@infradead.org>,
        "mic@linux.microsoft.com" <mic@linux.microsoft.com>,
        Kanth Ghatraju <kanth.ghatraju@oracle.com>,
        Konrad Wilk <konrad.wilk@oracle.com>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        "keyrings@vger.kernel.org" <keyrings@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Paul Moore <paul@paul-moore.com>
Date:   Mon, 11 Sep 2023 19:08:10 -0400
In-Reply-To: <CEA476C1-4CE5-4FFC-91D7-6061C8605B18@oracle.com>
References: <20230908213428.731513-1-eric.snowberg@oracle.com>
         <097a0413b27ed9792dc598ff184730bcf6ae8fcf.camel@linux.ibm.com>
         <20230911.chaeghaeJ4ei@digikod.net>
         <CEA476C1-4CE5-4FFC-91D7-6061C8605B18@oracle.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-22.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: kkjBCp2-VPoL_2zflu0Z7U41ZsF6CM5T
X-Proofpoint-GUID: lnMviTOdAeqOlz24WYyt4frcndq9oSzZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-11_19,2023-09-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 malwarescore=0 clxscore=1011 suspectscore=0 mlxlogscore=999
 lowpriorityscore=0 priorityscore=1501 mlxscore=0 spamscore=0 bulkscore=0
 adultscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2309110212
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2023-09-11 at 22:17 +0000, Eric Snowberg wrote:
> 
> > On Sep 11, 2023, at 10:51 AM, Mickaël Salaün <mic@digikod.net> wrote:
> > 
> > On Mon, Sep 11, 2023 at 09:29:07AM -0400, Mimi Zohar wrote:
> >> Hi Eric,
> >> 
> >> On Fri, 2023-09-08 at 17:34 -0400, Eric Snowberg wrote:
> >>> Currently root can dynamically update the blacklist keyring if the hash
> >>> being added is signed and vouched for by the builtin trusted keyring.
> >>> Currently keys in the secondary trusted keyring can not be used.
> >>> 
> >>> Keys within the secondary trusted keyring carry the same capabilities as
> >>> the builtin trusted keyring.  Relax the current restriction for updating
> >>> the .blacklist keyring and allow the secondary to also be referenced as
> >>> a trust source.  Since the machine keyring is linked to the secondary
> >>> trusted keyring, any key within it may also be used.
> >>> 
> >>> An example use case for this is IMA appraisal.  Now that IMA both
> >>> references the blacklist keyring and allows the machine owner to add
> >>> custom IMA CA certs via the machine keyring, this adds the additional
> >>> capability for the machine owner to also do revocations on a running
> >>> system.
> >>> 
> >>> IMA appraisal usage example to add a revocation for /usr/foo:
> >>> 
> >>> sha256sum /bin/foo | awk '{printf "bin:" $1}' > hash.txt
> >>> 
> >>> openssl smime -sign -in hash.txt -inkey machine-private-key.pem \
> >>>       -signer machine-certificate.pem -noattr -binary -outform DER \
> >>>       -out hash.p7s
> >>> 
> >>> keyctl padd blacklist "$(< hash.txt)" %:.blacklist < hash.p7s
> >>> 
> >>> Signed-off-by: Eric Snowberg <eric.snowberg@oracle.com>
> >> 
> >> The secondary keyring may include both CA and code signing keys.  With
> >> this change any key loaded onto the secondary keyring may blacklist a
> >> hash.  Wouldn't it make more sense to limit blacklisting
> >> certificates/hashes to at least CA keys? 
> > 
> > Some operational constraints may limit what a CA can sign.
> 
> Agreed.  
> 
> Is there precedents for requiring this S/MIME to be signed by a CA? 
> 
> > This change is critical and should be tied to a dedicated kernel config
> > (disabled by default), otherwise existing systems using this feature
> > will have their threat model automatically changed without notice.
> 
> Today we have INTEGRITY_CA_MACHINE_KEYRING_MAX.  This can 
> be enabled to enforce CA restrictions on the machine keyring.  Mimi, would 
> this be a suitable solution for what you are after?

There needs to be some correlation between the file hashes being added
to the blacklist and the certificate that signed them.  Without that
correlation, any key on the secondary trusted keyring could add any
file hashes it wants to the blacklist.

Mimi

> 
> I suppose root could add another key to the secondary keyring if it was 
> signed by a key in the machine keyring.  But then we are getting into an 
> area of key usage enforcement which really only exists for things added 
> to the .ima keyring.
> 
> >>> ---
> >>> certs/Kconfig     | 2 +-
> >>> certs/blacklist.c | 4 ++--
> >>> 2 files changed, 3 insertions(+), 3 deletions(-)
> >>> 
> >>> diff --git a/certs/Kconfig b/certs/Kconfig
> >>> index 1f109b070877..23dc87c52aff 100644
> >>> --- a/certs/Kconfig
> >>> +++ b/certs/Kconfig
> >>> @@ -134,7 +134,7 @@ config SYSTEM_BLACKLIST_AUTH_UPDATE
> >>> 	depends on SYSTEM_DATA_VERIFICATION
> >>> 	help
> >>> 	  If set, provide the ability to load new blacklist keys at run time if
> >>> -	  they are signed and vouched by a certificate from the builtin trusted
> >>> +	  they are signed and vouched by a certificate from the secondary trusted
> >> 
> >> If CONFIG_SECONDARY_TRUSTED_KEYRING is not enabled, it falls back to
> >> the builtin keyring.  Please update the comment accordingly.
> 
> I’ll fix these in the next round, thanks.
> 


