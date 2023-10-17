Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 939EE7CCA3B
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 19:59:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344035AbjJQR7H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 13:59:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232380AbjJQR7G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 13:59:06 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E917183;
        Tue, 17 Oct 2023 10:59:04 -0700 (PDT)
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39HHdXgS001103;
        Tue, 17 Oct 2023 17:58:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=mIiiX48jXcI+ggkjVD3XIoTCMcDHfU0m83MXsFV2PMo=;
 b=dKs0XWCqoHWOYpcqFgYrhYpCaIiOIsIz646f/0cF993dVkNzjTgdYAEDMX9NcVgIc84h
 dqWMwukQbi+I7Nk3vC4f5VcOrXCSN6RK3GlPrksnh4sIAh9Y14/WUZiEjLCfI9LdhHCm
 AEuv9SeLmJ9wNkyNEdsA/bW6PN9d1R8R80YDIsV+QVI1YW/vbzxpcz8F4xGFHD1M8+0o
 ic6W8U1jdFAcFK6N63tDyd8ya+93P3omOAL3JubFJAceC4zcg8ROSTXpTcWRDal5ATM9
 U0V9kKzNqjHxR/lY14KOCG4EdNBtJeexrEFe4TH+GoAhxidsNET8eJYFQ3FbBuXrJOtX pw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3tsxv20kyh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 17 Oct 2023 17:58:42 +0000
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 39HHsAPi030062;
        Tue, 17 Oct 2023 17:58:41 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3tsxv20kvg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 17 Oct 2023 17:58:41 +0000
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
        by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 39HFfOio019700;
        Tue, 17 Oct 2023 17:58:29 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
        by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 3tr811j7ad-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 17 Oct 2023 17:58:29 +0000
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com [10.241.53.105])
        by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 39HHwSXq28705464
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 17 Oct 2023 17:58:29 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D267158043;
        Tue, 17 Oct 2023 17:58:28 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1DD4258055;
        Tue, 17 Oct 2023 17:58:28 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.watson.ibm.com (unknown [9.31.99.90])
        by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
        Tue, 17 Oct 2023 17:58:28 +0000 (GMT)
Message-ID: <5c795b4cf6d7460af205e85a36194fa188136c38.camel@linux.ibm.com>
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
Date:   Tue, 17 Oct 2023 13:58:27 -0400
In-Reply-To: <CAHC9VhS_Ttdy5ZB=jYdVfNyaJfn_7G1wztr5+g0g7uUDForXvA@mail.gmail.com>
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
         <a851227aaa75ab16b0d6dd93433e1ee1679715f9.camel@linux.ibm.com>
         <CAHC9VhS_Ttdy5ZB=jYdVfNyaJfn_7G1wztr5+g0g7uUDForXvA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-22.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: xhU62rCo7Z1G441wmbcp9hX6le7Dx3nJ
X-Proofpoint-GUID: m1tCyNGrSf7TNB1ZbSRFtfORm9m6AEs8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-17_03,2023-10-17_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 impostorscore=0
 adultscore=0 malwarescore=0 bulkscore=0 mlxlogscore=999 phishscore=0
 priorityscore=1501 lowpriorityscore=0 spamscore=0 suspectscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2310170152
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2023-10-17 at 13:29 -0400, Paul Moore wrote:
> On Tue, Oct 17, 2023 at 1:09 PM Mimi Zohar <zohar@linux.ibm.com> wrote:
> > On Tue, 2023-10-17 at 11:45 -0400, Paul Moore wrote:
> > > On Tue, Oct 17, 2023 at 9:48 AM Mimi Zohar <zohar@linux.ibm.com> wrote:
> > > > On Thu, 2023-10-05 at 12:32 +0200, Mickaël Salaün wrote:
> > > > > > > > A complementary approach would be to create an
> > > > > > > > LSM (or a dedicated interface) to tie certificate properties to a set of
> > > > > > > > kernel usages, while still letting users configure these constraints.
> > > > > > >
> > > > > > > That is an interesting idea.  Would the other security maintainers be in
> > > > > > > support of such an approach?  Would a LSM be the correct interface?
> > > > > > > Some of the recent work I have done with introducing key usage and CA
> > > > > > > enforcement is difficult for a distro to pick up, since these changes can be
> > > > > > > viewed as a regression.  Each end-user has different signing procedures
> > > > > > > and policies, so making something work for everyone is difficult.  Letting the
> > > > > > > user configure these constraints would solve this problem.
> > > >
> > > > Something definitely needs to be done about controlling the usage of
> > > > x509 certificates.  My concern is the level of granularity.  Would this
> > > > be at the LSM hook level or even finer granaularity?
> > >
> > > You lost me, what do you mean by finer granularity than a LSM-based
> > > access control?  Can you give an existing example in the Linux kernel
> > > of access control granularity that is finer grained than what is
> > > provided by the LSMs?
> >
> > The current x509 certificate access control granularity is at the
> > keyring level.  Any key on the keyring may be used to verify a
> > signature.  Finer granularity could associate a set of certificates on
> > a particular keyring with an LSM hook - kernel modules, BPRM, kexec,
> > firmware, etc.  Even finer granularity could somehow limit a key's
> > signature verification to files in particular software package(s) for
> > example.
> >
> > Perhaps Mickaël and Eric were thinking about a new LSM to control usage
> > of x509 certificates from a totally different perspective.  I'd like to
> > hear what they're thinking.
> >
> > I hope this addressed your questions.
> 
> Okay, so you were talking about finer granularity when compared to the
> *current* LSM keyring hooks.  Gotcha.
> 
> If we need additional, or modified, hooks that shouldn't be a problem.
> Although I'm guessing the answer is going to be moving towards
> purpose/operation specific keyrings which might fit in well with the
> current keyring level controls.

I don't believe defining per purpose/operation specific keyrings will
resolve the underlying problem of granularity.  For example, different
applications could be signed with different keys and should only be
verified with the specific key.

-- 
thanks,

Mimi

