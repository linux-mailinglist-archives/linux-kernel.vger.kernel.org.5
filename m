Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DEB0C79D06D
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 13:55:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234869AbjILLzY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 07:55:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234886AbjILLzV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 07:55:21 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F03810DF;
        Tue, 12 Sep 2023 04:55:16 -0700 (PDT)
Received: from pps.filterd (m0353728.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38CBgddn027025;
        Tue, 12 Sep 2023 11:55:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=PCM26YtKHiMVe1f3wkXnoA7poj4mfUWua7B9nhEe9yI=;
 b=dP1SzG+9cdY+0guav+qgvL8ChL1MXPg2R3LEyn9EyG0heosXJ4U7mZLyY9pACGzxuXli
 pP1dVRkmn7pSDJrBZpE12uFIUT+lzKfmrHiWV9sKTlPQL5B0nR8ybgdFH8c+hhnGQ9oK
 ZfWBVz6d/0U47n10o0njL4sT39ALVEvk8qqA51hMwHJdI9FdN8SSbr9K9E60N6lJZ3sQ
 Fim//zxIQzsZrAMnGPJY7ASrcSCfzQ9XU1KwTXciiVxJLD2/d6Pm5Phkd/BANmRgVoS1
 hSWsTPs6RnG1b733AJzRfI81X/XOYE76ffHqrtvVVv9dIHOxSGs5UAUBvxCM8m1oCdXP fw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3t2p73jerk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 12 Sep 2023 11:55:02 +0000
Received: from m0353728.ppops.net (m0353728.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 38CB92cu015691;
        Tue, 12 Sep 2023 11:55:02 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3t2p73jer7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 12 Sep 2023 11:55:01 +0000
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
        by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 38C9rHXw024021;
        Tue, 12 Sep 2023 11:55:00 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
        by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 3t131t376q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 12 Sep 2023 11:55:00 +0000
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com [10.39.53.229])
        by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 38CBt0G966453926
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 12 Sep 2023 11:55:00 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 210B358058;
        Tue, 12 Sep 2023 11:55:00 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0ABE158061;
        Tue, 12 Sep 2023 11:54:59 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.61.150.173])
        by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
        Tue, 12 Sep 2023 11:54:58 +0000 (GMT)
Message-ID: <7335a4587233626a39ce9bc8a969957d7f43a34c.camel@linux.ibm.com>
Subject: Re: [PATCH] certs: Restrict blacklist updates to the secondary
 trusted keyring
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Eric Snowberg <eric.snowberg@oracle.com>
Cc:     =?ISO-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        David Howells <dhowells@redhat.com>,
        David Woodhouse <dwmw2@infradead.org>,
        "mic@linux.microsoft.com" <mic@linux.microsoft.com>,
        Kanth Ghatraju <kanth.ghatraju@oracle.com>,
        Konrad Wilk <konrad.wilk@oracle.com>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        "keyrings@vger.kernel.org" <keyrings@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Paul Moore <paul@paul-moore.com>
Date:   Tue, 12 Sep 2023 07:54:58 -0400
In-Reply-To: <932231F5-8050-4436-84B8-D7708DC43845@oracle.com>
References: <20230908213428.731513-1-eric.snowberg@oracle.com>
         <097a0413b27ed9792dc598ff184730bcf6ae8fcf.camel@linux.ibm.com>
         <20230911.chaeghaeJ4ei@digikod.net>
         <CEA476C1-4CE5-4FFC-91D7-6061C8605B18@oracle.com>
         <ba2f5560800608541e81fbdd28efa9875b35e491.camel@linux.ibm.com>
         <932231F5-8050-4436-84B8-D7708DC43845@oracle.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-22.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: Y7r9xd52tY3799dADkeyKPMg2wHxeGTe
X-Proofpoint-GUID: 8bfjbYg2Do2G7ApmisuEcI6wSh8MLZnx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-12_09,2023-09-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0
 lowpriorityscore=0 malwarescore=0 bulkscore=0 spamscore=0 suspectscore=0
 mlxscore=0 clxscore=1015 phishscore=0 priorityscore=1501 impostorscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2309120095
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2023-09-12 at 02:00 +0000, Eric Snowberg wrote:
> 
> > On Sep 11, 2023, at 5:08 PM, Mimi Zohar <zohar@linux.ibm.com> wrote:
> > 
> > On Mon, 2023-09-11 at 22:17 +0000, Eric Snowberg wrote:
> >> 
> >>> On Sep 11, 2023, at 10:51 AM, Mickaël Salaün <mic@digikod.net> wrote:
> >>> 
> >>> On Mon, Sep 11, 2023 at 09:29:07AM -0400, Mimi Zohar wrote:
> >>>> Hi Eric,
> >>>> 
> >>>> On Fri, 2023-09-08 at 17:34 -0400, Eric Snowberg wrote:
> >>>>> Currently root can dynamically update the blacklist keyring if the hash
> >>>>> being added is signed and vouched for by the builtin trusted keyring.
> >>>>> Currently keys in the secondary trusted keyring can not be used.
> >>>>> 
> >>>>> Keys within the secondary trusted keyring carry the same capabilities as
> >>>>> the builtin trusted keyring.  Relax the current restriction for updating
> >>>>> the .blacklist keyring and allow the secondary to also be referenced as
> >>>>> a trust source.  Since the machine keyring is linked to the secondary
> >>>>> trusted keyring, any key within it may also be used.
> >>>>> 
> >>>>> An example use case for this is IMA appraisal.  Now that IMA both
> >>>>> references the blacklist keyring and allows the machine owner to add
> >>>>> custom IMA CA certs via the machine keyring, this adds the additional
> >>>>> capability for the machine owner to also do revocations on a running
> >>>>> system.
> >>>>> 
> >>>>> IMA appraisal usage example to add a revocation for /usr/foo:
> >>>>> 
> >>>>> sha256sum /bin/foo | awk '{printf "bin:" $1}' > hash.txt
> >>>>> 
> >>>>> openssl smime -sign -in hash.txt -inkey machine-private-key.pem \
> >>>>>      -signer machine-certificate.pem -noattr -binary -outform DER \
> >>>>>      -out hash.p7s
> >>>>> 
> >>>>> keyctl padd blacklist "$(< hash.txt)" %:.blacklist < hash.p7s
> >>>>> 
> >>>>> Signed-off-by: Eric Snowberg <eric.snowberg@oracle.com>
> >>>> 
> >>>> The secondary keyring may include both CA and code signing keys.  With
> >>>> this change any key loaded onto the secondary keyring may blacklist a
> >>>> hash.  Wouldn't it make more sense to limit blacklisting
> >>>> certificates/hashes to at least CA keys? 
> >>> 
> >>> Some operational constraints may limit what a CA can sign.
> >> 
> >> Agreed.  
> >> 
> >> Is there precedents for requiring this S/MIME to be signed by a CA? 
> >> 
> >>> This change is critical and should be tied to a dedicated kernel config
> >>> (disabled by default), otherwise existing systems using this feature
> >>> will have their threat model automatically changed without notice.
> >> 
> >> Today we have INTEGRITY_CA_MACHINE_KEYRING_MAX.  This can 
> >> be enabled to enforce CA restrictions on the machine keyring.  Mimi, would 
> >> this be a suitable solution for what you are after?
> > 
> > There needs to be some correlation between the file hashes being added
> > to the blacklist and the certificate that signed them.  Without that
> > correlation, any key on the secondary trusted keyring could add any
> > file hashes it wants to the blacklist.
> 
> Today any key in the secondary trusted keyring can be used to validate a 
> signed kernel module.  At a later time, if a new hash is added to the blacklist 
> keyring to revoke loading a signed kernel module,  the ability to do the 
> revocation with this additional change would be more restrictive than loading 
> the original module.

A public key on the secondary keyring is used to verify code that it
signed, but does not impact any other code. Allowing any public key on
the secondary keyring to blacklist any file hash is giving it more
privileges than it originally had.

This requirement isn't different than how Certificate Revocation List
(CRL) work.  Not any CA can revoke a certificate.

> 
> But, if you think it would be appropriate, I could add a new Kconfig (disabled 
> by default) that validates the key being used to vouch the S/MIME encoded 
> hash is a CA.  That would certainly make this more complicated.   With this 
> addition, would  the key usage field need to be referenced too?
> 
> Another idea I had was changing this patch to reference only the builtin and 
> the machine keyring (if configured), not the secondary keyring.   Then with
> INTEGRITY_CA_MACHINE_KEYRING_MAX, only CA keys could be 
> used. Let me know your thoughts on this approach.  Thanks.

Better, but it doesn't address the underlying problem.

-- 
thanks,

Mimi

