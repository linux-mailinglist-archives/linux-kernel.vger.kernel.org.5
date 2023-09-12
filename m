Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1544979DC25
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 00:47:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237896AbjILWrw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 18:47:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237949AbjILWrk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 18:47:40 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 958861730;
        Tue, 12 Sep 2023 15:47:24 -0700 (PDT)
Received: from pps.filterd (m0353728.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38CMeopp009198;
        Tue, 12 Sep 2023 22:47:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=y2qPjWMY36LKjb6S8CXggaomEk1wfL/rdztTlIBO6yA=;
 b=oDI7yrxwUZyHtWWa3dNV/thjisdzXhj5BBzPJJ8tJitHDJV2HH3ULpYmLJN7ZNURgyrP
 /ZWlfK0XHjWrJ0PubSzab6Do0od2QslxyO11m7awuDYi3s0hBgL5chDg+0cvDTVvHSIM
 nixxZ+WLWNY9CfyGLkBo+ooBayB48n8bwsjI7BOGqQeKux4SY/GgMSsuuqSukyXsbbiZ
 ueBjWJsOGZ70yP3aS93hNiE2UZRTXJIepivhIBvJftKHxt3yz4DkqSD70lfPOHToEIri
 bKGLrIVZrAAaN8ZicIiAiE8LbQwB5wsrZHtwQLgQ2DapVk05WuwvMVRMulEnH5yqT9y5 Mw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3t30nr8hc1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 12 Sep 2023 22:47:04 +0000
Received: from m0353728.ppops.net (m0353728.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 38CMi5WB019652;
        Tue, 12 Sep 2023 22:47:04 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3t30nr8hbe-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 12 Sep 2023 22:47:03 +0000
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
        by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 38CLde28002401;
        Tue, 12 Sep 2023 22:47:03 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
        by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 3t158k69xt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 12 Sep 2023 22:47:02 +0000
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com [10.241.53.103])
        by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 38CMl14v7799450
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 12 Sep 2023 22:47:02 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D67575805E;
        Tue, 12 Sep 2023 22:47:01 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3024158062;
        Tue, 12 Sep 2023 22:47:01 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.61.31.41])
        by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
        Tue, 12 Sep 2023 22:47:01 +0000 (GMT)
Message-ID: <1149b6dbfdaabef3e48dc2852cc76aa11a6dd6b0.camel@linux.ibm.com>
Subject: Re: [PATCH] certs: Restrict blacklist updates to the secondary
 trusted keyring
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Eric Snowberg <eric.snowberg@oracle.com>,
        Jarkko Sakkinen <jarkko@kernel.org>
Cc:     =?ISO-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>,
        David Howells <dhowells@redhat.com>,
        David Woodhouse <dwmw2@infradead.org>,
        "mic@linux.microsoft.com" <mic@linux.microsoft.com>,
        Kanth Ghatraju <kanth.ghatraju@oracle.com>,
        Konrad Wilk <konrad.wilk@oracle.com>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        "keyrings@vger.kernel.org" <keyrings@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Paul Moore <paul@paul-moore.com>
Date:   Tue, 12 Sep 2023 18:47:00 -0400
In-Reply-To: <FD6FB139-F901-4E55-9705-E7B0023BDBA8@oracle.com>
References: <20230908213428.731513-1-eric.snowberg@oracle.com>
         <097a0413b27ed9792dc598ff184730bcf6ae8fcf.camel@linux.ibm.com>
         <20230911.chaeghaeJ4ei@digikod.net>
         <CEA476C1-4CE5-4FFC-91D7-6061C8605B18@oracle.com>
         <ba2f5560800608541e81fbdd28efa9875b35e491.camel@linux.ibm.com>
         <932231F5-8050-4436-84B8-D7708DC43845@oracle.com>
         <7335a4587233626a39ce9bc8a969957d7f43a34c.camel@linux.ibm.com>
         <FD6FB139-F901-4E55-9705-E7B0023BDBA8@oracle.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-22.el8) 
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: MZRiFXrKlieEwYsiJ89wVG2QXq-5ABiv
X-Proofpoint-GUID: YMf5EbE4yz09to3OdXlyR0mTPhtoqtAa
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-12_22,2023-09-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 priorityscore=1501 lowpriorityscore=0 suspectscore=0 spamscore=0
 bulkscore=0 mlxlogscore=999 phishscore=0 adultscore=0 malwarescore=0
 impostorscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2309120192
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2023-09-12 at 17:11 +0000, Eric Snowberg wrote:
> 
> > On Sep 12, 2023, at 5:54 AM, Mimi Zohar <zohar@linux.ibm.com> wrote:
> > 
> > On Tue, 2023-09-12 at 02:00 +0000, Eric Snowberg wrote:
> >> 
> >>> On Sep 11, 2023, at 5:08 PM, Mimi Zohar <zohar@linux.ibm.com> wrote:
> >>> 
> >>> On Mon, 2023-09-11 at 22:17 +0000, Eric Snowberg wrote:
> >>>> 
> >>>>> On Sep 11, 2023, at 10:51 AM, Mickaël Salaün <mic@digikod.net> wrote:
> >>>>> 
> >>>>> On Mon, Sep 11, 2023 at 09:29:07AM -0400, Mimi Zohar wrote:
> >>>>>> Hi Eric,
> >>>>>> 
> >>>>>> On Fri, 2023-09-08 at 17:34 -0400, Eric Snowberg wrote:
> >>>>>>> Currently root can dynamically update the blacklist keyring if the hash
> >>>>>>> being added is signed and vouched for by the builtin trusted keyring.
> >>>>>>> Currently keys in the secondary trusted keyring can not be used.
> >>>>>>> 
> >>>>>>> Keys within the secondary trusted keyring carry the same capabilities as
> >>>>>>> the builtin trusted keyring.  Relax the current restriction for updating
> >>>>>>> the .blacklist keyring and allow the secondary to also be referenced as
> >>>>>>> a trust source.  Since the machine keyring is linked to the secondary
> >>>>>>> trusted keyring, any key within it may also be used.
> >>>>>>> 
> >>>>>>> An example use case for this is IMA appraisal.  Now that IMA both
> >>>>>>> references the blacklist keyring and allows the machine owner to add
> >>>>>>> custom IMA CA certs via the machine keyring, this adds the additional
> >>>>>>> capability for the machine owner to also do revocations on a running
> >>>>>>> system.
> >>>>>>> 
> >>>>>>> IMA appraisal usage example to add a revocation for /usr/foo:
> >>>>>>> 
> >>>>>>> sha256sum /bin/foo | awk '{printf "bin:" $1}' > hash.txt
> >>>>>>> 
> >>>>>>> openssl smime -sign -in hash.txt -inkey machine-private-key.pem \
> >>>>>>>     -signer machine-certificate.pem -noattr -binary -outform DER \
> >>>>>>>     -out hash.p7s
> >>>>>>> 
> >>>>>>> keyctl padd blacklist "$(< hash.txt)" %:.blacklist < hash.p7s
> >>>>>>> 
> >>>>>>> Signed-off-by: Eric Snowberg <eric.snowberg@oracle.com>
> >>>>>> 
> >>>>>> The secondary keyring may include both CA and code signing keys.  With
> >>>>>> this change any key loaded onto the secondary keyring may blacklist a
> >>>>>> hash.  Wouldn't it make more sense to limit blacklisting
> >>>>>> certificates/hashes to at least CA keys? 
> >>>>> 
> >>>>> Some operational constraints may limit what a CA can sign.
> >>>> 
> >>>> Agreed.  
> >>>> 
> >>>> Is there precedents for requiring this S/MIME to be signed by a CA? 
> >>>> 
> >>>>> This change is critical and should be tied to a dedicated kernel config
> >>>>> (disabled by default), otherwise existing systems using this feature
> >>>>> will have their threat model automatically changed without notice.
> >>>> 
> >>>> Today we have INTEGRITY_CA_MACHINE_KEYRING_MAX.  This can 
> >>>> be enabled to enforce CA restrictions on the machine keyring.  Mimi, would 
> >>>> this be a suitable solution for what you are after?
> >>> 
> >>> There needs to be some correlation between the file hashes being added
> >>> to the blacklist and the certificate that signed them.  Without that
> >>> correlation, any key on the secondary trusted keyring could add any
> >>> file hashes it wants to the blacklist.
> >> 
> >> Today any key in the secondary trusted keyring can be used to validate a 
> >> signed kernel module.  At a later time, if a new hash is added to the blacklist 
> >> keyring to revoke loading a signed kernel module,  the ability to do the 
> >> revocation with this additional change would be more restrictive than loading 
> >> the original module.
> > 
> > A public key on the secondary keyring is used to verify code that it
> > signed, but does not impact any other code. Allowing any public key on
> > the secondary keyring to blacklist any file hash is giving it more
> > privileges than it originally had.
> > 
> > This requirement isn't different than how Certificate Revocation List
> > (CRL) work.  Not any CA can revoke a certificate.
> 
> In UEFI Secure Boot we have the Forbidden Signature Database (DBX).  
> Root can update the DBX on a host.  The requirement placed on updating 
> it is the new DBX entry must be signed by any key contained within the 
> KEK.  Following a reboot, all DBX entries load into the .blacklist keyring.  
> There is not a requirement similar to how CRL’s work here, any KEK key 
> can be used.
> 
> With architectures booted through a shim there is the MOKX.  Similar to 
> DBX, MOKX have the same capabilities, however they do not need to be 
> signed by any key, the machine owner must show they have physical 
> presence (and potentially a MOK password) for inclusion.  Again there 
> is not a requirement similar to how CRL’s work here either.  The machine 
> owner can decide what is included.
> 
> Today when a kernel is built, any number of keys may be included within 
> the builtin trusted keyring.  The keys included in the kernel may not have 
> a single usage field set or the CA bit set.  There are no requirements on 
> how these keys get used later on.  Any key in the builtin trusted keyring 
> can be used to sign a revocation that can be added to the blacklist keyring.  
> Additionally, any key in the MOK can be used to sign this kernel and it will 
> boot.  Before booting the kernel, MOK keys have more privileges than 
> after the kernel is booted in some instances.
> 
> Today MOK keys can be loaded into the machine keyring.  These keys get 
> linked to the secondary trusted keyring.  Currently key usage enforcement
> is being applied to these keys behind some Kconfig options.  By default 
> anything in the secondary has the same capabilities as the builtin trusted 
> keyring.  What is challenging here with this request is the inconsistency 
> between how everything else currently works. 
> 
> Root can not arbitrarily add things to the secondary trusted keyring.  These 
> keys must be signed by something in either the machine or the builtin.  In 
> this thread [1], Jarkko is saying CA based infrastructure should be a policy 
> decision not to be enforced by the kernel. Wouldn’t this apply here as well?
> 
> 1. https://lore.kernel.org/lkml/CVGUFUEQVCHS.37OA20PNG9EVB@suppilovahvero/

Mickaël said, "This change is critical and should be tied to a
dedicated kernel config
(disabled by default), otherwise existing systems using this feature
will have their threat model automatically changed without notice."

As a possible alternative I suggested limiting which file hashes the
certs on the secondary (or machine) keyring could blacklist.
-- 
thanks,

Mimi

