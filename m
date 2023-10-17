Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 300257CC983
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 19:09:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234917AbjJQRJI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 13:09:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbjJQRJF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 13:09:05 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D9BEAB;
        Tue, 17 Oct 2023 10:09:04 -0700 (PDT)
Received: from pps.filterd (m0353727.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39HGuQl2019540;
        Tue, 17 Oct 2023 17:08:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=aoAnkaLn3fr/Z6ZOkhZXbhM1+nisE2QLSLIiGkHt4Mc=;
 b=QE5lyLUMQ0GZ8zjMPB1Rz7PbUOWEVp5qc9dav+d4bwl+yCIzOq8liD5GIzyENtR6gzfm
 Jy9GyabRnKnKuHqaitJl/uWOBZX4N2H4GDwIUrUrjWB3ELxugjhy6vVho7lf1BihZyM5
 95izGDeF9TEturD1+fl3+lmE1NHpCT86N/nJGijdu0kjcSmqHJA+kMscs2AXLjGzLABH
 4KaQFuyH3eInujNh4T+Lj6/MrBn9plTOs9pNQL2BxxqX5MWVzfRINcuZS/LvW6/4muTn
 NuNQTFgDMVNhGmQU38U2tmX58W5YLJe9BfqElkw0lUbCbltpRa3brfew4fz0yWQxhBMO Ng== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3tsx16h0px-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 17 Oct 2023 17:08:51 +0000
Received: from m0353727.ppops.net (m0353727.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 39HH5cgh022088;
        Tue, 17 Oct 2023 17:08:50 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3tsx16h0ns-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 17 Oct 2023 17:08:50 +0000
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
        by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 39HFq26I019881;
        Tue, 17 Oct 2023 17:08:49 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
        by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 3tr811hxem-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 17 Oct 2023 17:08:49 +0000
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com [10.39.53.229])
        by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 39HH8mQ344892844
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 17 Oct 2023 17:08:49 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D19D958059;
        Tue, 17 Oct 2023 17:08:48 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A890258058;
        Tue, 17 Oct 2023 17:08:47 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.watson.ibm.com (unknown [9.31.99.90])
        by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
        Tue, 17 Oct 2023 17:08:47 +0000 (GMT)
Message-ID: <a851227aaa75ab16b0d6dd93433e1ee1679715f9.camel@linux.ibm.com>
Subject: Re: RFC: New LSM to control usage of x509 certificates
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Paul Moore <paul@paul-moore.com>
Cc:     =?ISO-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>,
        Eric Snowberg <eric.snowberg@oracle.com>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        David Howells <dhowells@redhat.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Kanth Ghatraju <kanth.ghatraju@oracle.com>,
        Konrad Wilk <konrad.wilk@oracle.com>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        "keyrings@vger.kernel.org" <keyrings@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        linux-security-module@vger.kernel.org
Date:   Tue, 17 Oct 2023 13:08:47 -0400
In-Reply-To: <CAHC9VhRdU1CZJpPSEdSmui-Xirr0j261K=+SM7KiDwiPG-JSrQ@mail.gmail.com>
References: <CEA476C1-4CE5-4FFC-91D7-6061C8605B18@oracle.com>
         <ba2f5560800608541e81fbdd28efa9875b35e491.camel@linux.ibm.com>
         <932231F5-8050-4436-84B8-D7708DC43845@oracle.com>
         <7335a4587233626a39ce9bc8a969957d7f43a34c.camel@linux.ibm.com>
         <FD6FB139-F901-4E55-9705-E7B0023BDBA8@oracle.com>
         <1149b6dbfdaabef3e48dc2852cc76aa11a6dd6b0.camel@linux.ibm.com>
         <4A0505D0-2933-43BD-BEEA-94350BB22AE7@oracle.com>
         <20230913.Ceifae7ievei@digikod.net>
         <D0F16BFD-72EB-4BE2-BA3D-BAE1BCCDCB6F@oracle.com>
         <20230914.shah5al9Kaib@digikod.net> <20231005.dajohf2peiBu@digikod.net>
         <d3b51f26c14fd273d41da3432895fdce9f4d047c.camel@linux.ibm.com>
         <CAHC9VhRdU1CZJpPSEdSmui-Xirr0j261K=+SM7KiDwiPG-JSrQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-22.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: e1icxz11YlBwrIQyurHk4V7wMJEqo_Fq
X-Proofpoint-GUID: AMtUE8wGLXqGpsSChHUXrHxLI8GPmJiS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-17_03,2023-10-17_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 lowpriorityscore=0 priorityscore=1501 malwarescore=0 impostorscore=0
 mlxscore=0 spamscore=0 mlxlogscore=999 phishscore=0 bulkscore=0
 adultscore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2309180000 definitions=main-2310170144
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2023-10-17 at 11:45 -0400, Paul Moore wrote:
> On Tue, Oct 17, 2023 at 9:48 AM Mimi Zohar <zohar@linux.ibm.com> wrote:
> > On Thu, 2023-10-05 at 12:32 +0200, Mickaël Salaün wrote:
> > > > > > A complementary approach would be to create an
> > > > > > LSM (or a dedicated interface) to tie certificate properties to a set of
> > > > > > kernel usages, while still letting users configure these constraints.
> > > > >
> > > > > That is an interesting idea.  Would the other security maintainers be in
> > > > > support of such an approach?  Would a LSM be the correct interface?
> > > > > Some of the recent work I have done with introducing key usage and CA
> > > > > enforcement is difficult for a distro to pick up, since these changes can be
> > > > > viewed as a regression.  Each end-user has different signing procedures
> > > > > and policies, so making something work for everyone is difficult.  Letting the
> > > > > user configure these constraints would solve this problem.
> >
> > Something definitely needs to be done about controlling the usage of
> > x509 certificates.  My concern is the level of granularity.  Would this
> > be at the LSM hook level or even finer granaularity?
> 
> You lost me, what do you mean by finer granularity than a LSM-based
> access control?  Can you give an existing example in the Linux kernel
> of access control granularity that is finer grained than what is
> provided by the LSMs?

The current x509 certificate access control granularity is at the
keyring level.  Any key on the keyring may be used to verify a
signature.  Finer granularity could associate a set of certificates on
a particular keyring with an LSM hook - kernel modules, BPRM, kexec,
firmware, etc.  Even finer granularity could somehow limit a key's
signature verification to files in particular software package(s) for
example.

Perhaps Mickaël and Eric were thinking about a new LSM to control usage
of x509 certificates from a totally different perspective.  I'd like to
hear what they're thinking.

I hope this addressed your questions.

-- 
thanks,

Mimi

