Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C18B07CF3AA
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 11:12:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345023AbjJSJMh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 05:12:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232952AbjJSJMd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 05:12:33 -0400
Received: from smtp-bc0f.mail.infomaniak.ch (smtp-bc0f.mail.infomaniak.ch [IPv6:2001:1600:3:17::bc0f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89A7812A
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 02:12:29 -0700 (PDT)
Received: from smtp-3-0000.mail.infomaniak.ch (unknown [10.4.36.107])
        by smtp-2-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4SB26Z2T9TzMpqsp;
        Thu, 19 Oct 2023 09:12:22 +0000 (UTC)
Received: from unknown by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4SB26Y3Mssz11q;
        Thu, 19 Oct 2023 11:12:21 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=digikod.net;
        s=20191114; t=1697706742;
        bh=yHQ4lbIXDIcyIod5pT5Nj5PJPKD0EcMy/UqYpm+iTjM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IAeo4fKsTgBIg+Ag9bTIkrGYryj3Ng6ge6EBe/PGutCVJWcoapcI11/m9Zya1iaXv
         pZUD6wSsmSigFo00aTVGmXnKQ7g6IjcbAn5IiMrwMEc/Zeq/jT+H8//oc9jCWb1CJX
         2o583mC8xfekrSVigHG1OZEv8dEM2KDO7XaC46yI=
Date:   Thu, 19 Oct 2023 11:12:18 +0200
From:   =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To:     Eric Snowberg <eric.snowberg@oracle.com>
Cc:     Paul Moore <paul@paul-moore.com>, Mimi Zohar <zohar@linux.ibm.com>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        David Howells <dhowells@redhat.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Kanth Ghatraju <kanth.ghatraju@oracle.com>,
        Konrad Wilk <konrad.wilk@oracle.com>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        "keyrings@vger.kernel.org" <keyrings@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        KP Singh <kpsingh@kernel.org>
Subject: Re: RFC: New LSM to control usage of x509 certificates
Message-ID: <20231019.vair7OoRie7w@digikod.net>
References: <20231005.dajohf2peiBu@digikod.net>
 <d3b51f26c14fd273d41da3432895fdce9f4d047c.camel@linux.ibm.com>
 <CAHC9VhRdU1CZJpPSEdSmui-Xirr0j261K=+SM7KiDwiPG-JSrQ@mail.gmail.com>
 <a851227aaa75ab16b0d6dd93433e1ee1679715f9.camel@linux.ibm.com>
 <CAHC9VhS_Ttdy5ZB=jYdVfNyaJfn_7G1wztr5+g0g7uUDForXvA@mail.gmail.com>
 <5c795b4cf6d7460af205e85a36194fa188136c38.camel@linux.ibm.com>
 <CAHC9VhTug20M0ET=QojUPtjrGkeHfU=ADDNrKfXmLTQPG_i1vw@mail.gmail.com>
 <2512D2AE-4ACA-41B9-B9FB-C2B4802B9A10@oracle.com>
 <20231018.heiju2Shexai@digikod.net>
 <18FC67B7-7966-49B7-8C27-F815F1568781@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <18FC67B7-7966-49B7-8C27-F815F1568781@oracle.com>
X-Infomaniak-Routing: alpha
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 18, 2023 at 11:12:45PM +0000, Eric Snowberg wrote:
> 
> 
> > On Oct 18, 2023, at 8:14 AM, Mickaël Salaün <mic@digikod.net> wrote:
> > 
> > On Tue, Oct 17, 2023 at 07:34:25PM +0000, Eric Snowberg wrote:
> >> 
> >> 
> >>> On Oct 17, 2023, at 12:51 PM, Paul Moore <paul@paul-moore.com> wrote:
> >>> 
> >>> On Tue, Oct 17, 2023 at 1:59 PM Mimi Zohar <zohar@linux.ibm.com> wrote:
> >>>> On Tue, 2023-10-17 at 13:29 -0400, Paul Moore wrote:
> >>>>> On Tue, Oct 17, 2023 at 1:09 PM Mimi Zohar <zohar@linux.ibm.com> wrote:
> >>>>>> On Tue, 2023-10-17 at 11:45 -0400, Paul Moore wrote:
> >>>>>>> On Tue, Oct 17, 2023 at 9:48 AM Mimi Zohar <zohar@linux.ibm.com> wrote:
> >>>>>>>> On Thu, 2023-10-05 at 12:32 +0200, Mickaël Salaün wrote:
> >>>>>>>>>>>> A complementary approach would be to create an
> >>>>>>>>>>>> LSM (or a dedicated interface) to tie certificate properties to a set of
> >>>>>>>>>>>> kernel usages, while still letting users configure these constraints.
> >>>>>>>>>>> 
> >>>>>>>>>>> That is an interesting idea.  Would the other security maintainers be in
> >>>>>>>>>>> support of such an approach?  Would a LSM be the correct interface?
> >>>>>>>>>>> Some of the recent work I have done with introducing key usage and CA
> >>>>>>>>>>> enforcement is difficult for a distro to pick up, since these changes can be
> >>>>>>>>>>> viewed as a regression.  Each end-user has different signing procedures
> >>>>>>>>>>> and policies, so making something work for everyone is difficult.  Letting the
> >>>>>>>>>>> user configure these constraints would solve this problem.
> >>>>>>>> 
> >>>>>>>> Something definitely needs to be done about controlling the usage of
> >>>>>>>> x509 certificates.  My concern is the level of granularity.  Would this
> >>>>>>>> be at the LSM hook level or even finer granaularity?
> >>>>>>> 
> >>>>>>> You lost me, what do you mean by finer granularity than a LSM-based
> >>>>>>> access control?  Can you give an existing example in the Linux kernel
> >>>>>>> of access control granularity that is finer grained than what is
> >>>>>>> provided by the LSMs?
> >>>>>> 
> >>>>>> The current x509 certificate access control granularity is at the
> >>>>>> keyring level.  Any key on the keyring may be used to verify a
> >>>>>> signature.  Finer granularity could associate a set of certificates on
> >>>>>> a particular keyring with an LSM hook - kernel modules, BPRM, kexec,
> >>>>>> firmware, etc.  Even finer granularity could somehow limit a key's
> >>>>>> signature verification to files in particular software package(s) for
> >>>>>> example.
> >>>>>> 
> >>>>>> Perhaps Mickaël and Eric were thinking about a new LSM to control usage
> >>>>>> of x509 certificates from a totally different perspective.  I'd like to
> >>>>>> hear what they're thinking.
> >>>>>> 
> >>>>>> I hope this addressed your questions.
> >>>>> 
> >>>>> Okay, so you were talking about finer granularity when compared to the
> >>>>> *current* LSM keyring hooks.  Gotcha.
> >>>>> 
> >>>>> If we need additional, or modified, hooks that shouldn't be a problem.
> >>>>> Although I'm guessing the answer is going to be moving towards
> >>>>> purpose/operation specific keyrings which might fit in well with the
> >>>>> current keyring level controls.
> >>>> 
> >>>> I don't believe defining per purpose/operation specific keyrings will
> >>>> resolve the underlying problem of granularity.
> >>> 
> >>> Perhaps not completely, but for in-kernel operations I believe it is
> >>> an attractive idea.
> >> 
> >> Could the X.509 Extended Key Usage (EKU) extension [1], be used here?  
> >> Various OIDs would need to be defined or assigned for each purpose.  
> >> Once assigned, the kernel could parse this information and do the
> >> enforcement.  Then all keys could continue to remain in the .builtin, 
> >> .secondary, and .machine keyrings.   Only a subset of each keyring 
> >> would be used for verification based on what is contained in the EKU.
> >> 
> >> 1. https://www.rfc-editor.org/rfc/rfc5280#section-4.2.1.12
> > 
> > I was also thinking about this kind of use cases. Because it might be
> > difficult in practice to control all certificate properties, we might
> > want to let sysadmins configure these subset of keyring according to
> > various certificate properties.
> 
> I agree, a configuration component for a sysadmin would be needed.
> 
> > There are currently LSM hooks to control
> > interactions with kernel keys by user space, and keys are already tied
> > to LSM blobs. New LSM hooks could be added to dynamically filter
> > keyrings according to kernel usages (e.g. kernel module verification, a
> > subset of an authentication mechanism according to the checked object).
> 
> If an LSM hook could dynamically filter keyrings, and the EKU was used, 
> is there an opinion on how flexible this should be?  Meaning, should there 
> be OIDs defined and carried in mainline code?  This would make it easier 
> to setup and use.  However who would be the initial OID owner?  Or would 
> predefined OIDs not be contained within mainline code, leaving it to the 
> sysadmin to create a policy that would be fed to the LSM to do the filtering.

The more flexible approach would be to not hardcode any policy in the
kernel but let sysadmins define their own, including OIDs. We "just"
need to find an adequate configuration scheme to define these
constraints. We already have an ASN.1 parser in the kernel, so we might
want to leverage that to match a certificate. Another option would be to
rely on an eBPF program to filter certificates but I'm not sure how
complex it could get. Maybe exposing the ASN.1 parser to eBPF? :)
