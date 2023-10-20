Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61F4D7D129B
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 17:26:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377693AbjJTP0t convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 20 Oct 2023 11:26:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377658AbjJTP0s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Oct 2023 11:26:48 -0400
Received: from frasgout12.his.huawei.com (frasgout12.his.huawei.com [14.137.139.154])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8DCFAB;
        Fri, 20 Oct 2023 08:26:45 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.18.147.228])
        by frasgout12.his.huawei.com (SkyGuard) with ESMTP id 4SBp1s1Hbgz9xGWp;
        Fri, 20 Oct 2023 23:10:57 +0800 (CST)
Received: from [127.0.0.1] (unknown [10.204.63.22])
        by APP1 (Coremail) with SMTP id LxC2BwAXb5AWnDJlJEWWAg--.51983S2;
        Fri, 20 Oct 2023 16:26:24 +0100 (CET)
Message-ID: <3c85eb60094b6a322cfaf262fb12f5949738dc93.camel@huaweicloud.com>
Subject: Re: RFC: New LSM to control usage of x509 certificates
From:   Roberto Sassu <roberto.sassu@huaweicloud.com>
To:     =?ISO-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>,
        Eric Snowberg <eric.snowberg@oracle.com>
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
Date:   Fri, 20 Oct 2023 17:26:11 +0200
In-Reply-To: <20231020.wae7johZae2i@digikod.net>
References: <CAHC9VhRdU1CZJpPSEdSmui-Xirr0j261K=+SM7KiDwiPG-JSrQ@mail.gmail.com>
         <a851227aaa75ab16b0d6dd93433e1ee1679715f9.camel@linux.ibm.com>
         <CAHC9VhS_Ttdy5ZB=jYdVfNyaJfn_7G1wztr5+g0g7uUDForXvA@mail.gmail.com>
         <5c795b4cf6d7460af205e85a36194fa188136c38.camel@linux.ibm.com>
         <CAHC9VhTug20M0ET=QojUPtjrGkeHfU=ADDNrKfXmLTQPG_i1vw@mail.gmail.com>
         <2512D2AE-4ACA-41B9-B9FB-C2B4802B9A10@oracle.com>
         <20231018.heiju2Shexai@digikod.net>
         <18FC67B7-7966-49B7-8C27-F815F1568781@oracle.com>
         <20231019.vair7OoRie7w@digikod.net>
         <0296DA27-7CAF-4605-AF67-3645F82BEE4D@oracle.com>
         <20231020.wae7johZae2i@digikod.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.44.4-0ubuntu2 
MIME-Version: 1.0
X-CM-TRANSID: LxC2BwAXb5AWnDJlJEWWAg--.51983S2
X-Coremail-Antispam: 1UD129KBjvJXoW3Ar45Zw4fWr1DJr4xJr13urg_yoW3JryDpF
        WUtF1UtF4DJr15Aw1Dtw1rWw17tryxJr1UXrn8Kr18A3Z0qry8Gr4UKF1akFW7ur1xJw1j
        qr1jqr9rXF1UAFJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUk0b4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
        vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7Cj
        xVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxV
        AFwI0_Gr0_Gr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
        x7xfMcIj6xIIjxv20xvE14v26r1Y6r17McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
        0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1l42xK82IYc2Ij
        64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x
        8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE
        2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42
        xK8VAvwI8IcIk0rVWrJr0_WFyUJwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv
        6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUrcTmDUUUU
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAgAQBF1jj5FJ-AADsA
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2023-10-20 at 17:05 +0200, Mickaël Salaün wrote:
> On Thu, Oct 19, 2023 at 11:08:38PM +0000, Eric Snowberg wrote:
> > 
> > 
> > > On Oct 19, 2023, at 3:12 AM, Mickaël Salaün <mic@digikod.net> wrote:
> > > 
> > > On Wed, Oct 18, 2023 at 11:12:45PM +0000, Eric Snowberg wrote:
> > > > 
> > > > 
> > > > > On Oct 18, 2023, at 8:14 AM, Mickaël Salaün <mic@digikod.net> wrote:
> > > > > 
> > > > > On Tue, Oct 17, 2023 at 07:34:25PM +0000, Eric Snowberg wrote:
> > > > > > 
> > > > > > 
> > > > > > > On Oct 17, 2023, at 12:51 PM, Paul Moore <paul@paul-moore.com> wrote:
> > > > > > > 
> > > > > > > On Tue, Oct 17, 2023 at 1:59 PM Mimi Zohar <zohar@linux.ibm.com> wrote:
> > > > > > > > On Tue, 2023-10-17 at 13:29 -0400, Paul Moore wrote:
> > > > > > > > > On Tue, Oct 17, 2023 at 1:09 PM Mimi Zohar <zohar@linux.ibm.com> wrote:
> > > > > > > > > > On Tue, 2023-10-17 at 11:45 -0400, Paul Moore wrote:
> > > > > > > > > > > On Tue, Oct 17, 2023 at 9:48 AM Mimi Zohar <zohar@linux.ibm.com> wrote:
> > > > > > > > > > > > On Thu, 2023-10-05 at 12:32 +0200, Mickaël Salaün wrote:
> > > > > > > > > > > > > > > > A complementary approach would be to create an
> > > > > > > > > > > > > > > > LSM (or a dedicated interface) to tie certificate properties to a set of
> > > > > > > > > > > > > > > > kernel usages, while still letting users configure these constraints.
> > > > > > > > > > > > > > > 
> > > > > > > > > > > > > > > That is an interesting idea.  Would the other security maintainers be in
> > > > > > > > > > > > > > > support of such an approach?  Would a LSM be the correct interface?
> > > > > > > > > > > > > > > Some of the recent work I have done with introducing key usage and CA
> > > > > > > > > > > > > > > enforcement is difficult for a distro to pick up, since these changes can be
> > > > > > > > > > > > > > > viewed as a regression.  Each end-user has different signing procedures
> > > > > > > > > > > > > > > and policies, so making something work for everyone is difficult.  Letting the
> > > > > > > > > > > > > > > user configure these constraints would solve this problem.
> > > > > > > > > > > > 
> > > > > > > > > > > > Something definitely needs to be done about controlling the usage of
> > > > > > > > > > > > x509 certificates.  My concern is the level of granularity.  Would this
> > > > > > > > > > > > be at the LSM hook level or even finer granaularity?
> > > > > > > > > > > 
> > > > > > > > > > > You lost me, what do you mean by finer granularity than a LSM-based
> > > > > > > > > > > access control?  Can you give an existing example in the Linux kernel
> > > > > > > > > > > of access control granularity that is finer grained than what is
> > > > > > > > > > > provided by the LSMs?
> > > > > > > > > > 
> > > > > > > > > > The current x509 certificate access control granularity is at the
> > > > > > > > > > keyring level.  Any key on the keyring may be used to verify a
> > > > > > > > > > signature.  Finer granularity could associate a set of certificates on
> > > > > > > > > > a particular keyring with an LSM hook - kernel modules, BPRM, kexec,
> > > > > > > > > > firmware, etc.  Even finer granularity could somehow limit a key's
> > > > > > > > > > signature verification to files in particular software package(s) for
> > > > > > > > > > example.
> > > > > > > > > > 
> > > > > > > > > > Perhaps Mickaël and Eric were thinking about a new LSM to control usage
> > > > > > > > > > of x509 certificates from a totally different perspective.  I'd like to
> > > > > > > > > > hear what they're thinking.
> > > > > > > > > > 
> > > > > > > > > > I hope this addressed your questions.
> > > > > > > > > 
> > > > > > > > > Okay, so you were talking about finer granularity when compared to the
> > > > > > > > > *current* LSM keyring hooks.  Gotcha.
> > > > > > > > > 
> > > > > > > > > If we need additional, or modified, hooks that shouldn't be a problem.
> > > > > > > > > Although I'm guessing the answer is going to be moving towards
> > > > > > > > > purpose/operation specific keyrings which might fit in well with the
> > > > > > > > > current keyring level controls.
> > > > > > > > 
> > > > > > > > I don't believe defining per purpose/operation specific keyrings will
> > > > > > > > resolve the underlying problem of granularity.
> > > > > > > 
> > > > > > > Perhaps not completely, but for in-kernel operations I believe it is
> > > > > > > an attractive idea.
> > > > > > 
> > > > > > Could the X.509 Extended Key Usage (EKU) extension [1], be used here?  
> > > > > > Various OIDs would need to be defined or assigned for each purpose.  
> > > > > > Once assigned, the kernel could parse this information and do the
> > > > > > enforcement.  Then all keys could continue to remain in the .builtin, 
> > > > > > .secondary, and .machine keyrings.   Only a subset of each keyring 
> > > > > > would be used for verification based on what is contained in the EKU.
> > > > > > 
> > > > > > 1. https://www.rfc-editor.org/rfc/rfc5280#section-4.2.1.12
> > > > > 
> > > > > I was also thinking about this kind of use cases. Because it might be
> > > > > difficult in practice to control all certificate properties, we might
> > > > > want to let sysadmins configure these subset of keyring according to
> > > > > various certificate properties.
> > > > 
> > > > I agree, a configuration component for a sysadmin would be needed.
> > > > 
> > > > > There are currently LSM hooks to control
> > > > > interactions with kernel keys by user space, and keys are already tied
> > > > > to LSM blobs. New LSM hooks could be added to dynamically filter
> > > > > keyrings according to kernel usages (e.g. kernel module verification, a
> > > > > subset of an authentication mechanism according to the checked object).
> > > > 
> > > > If an LSM hook could dynamically filter keyrings, and the EKU was used, 
> > > > is there an opinion on how flexible this should be?  Meaning, should there 
> > > > be OIDs defined and carried in mainline code?  This would make it easier 
> > > > to setup and use.  However who would be the initial OID owner?  Or would 
> > > > predefined OIDs not be contained within mainline code, leaving it to the 
> > > > sysadmin to create a policy that would be fed to the LSM to do the filtering.
> > > 
> > > The more flexible approach would be to not hardcode any policy in the
> > > kernel but let sysadmins define their own, including OIDs. We "just"
> > > need to find an adequate configuration scheme to define these
> > > constraints.
> > 
> > Also, with the flexible approach, the policy would need to be given to the 
> > kernel before any kernel module loads, fs-verity starts, or anything dealing 
> > with digital signature based IMA runs, etc.  With hardcoded policies this 
> > could be setup from the kernel command line or be set from a Kconfig.  
> > I assume with a flexible approach, this would need to come in early within 
> > the initram?
> 
> Yes, either the cmdline and/or the initramfs.

If SELinux was enabled in the initramfs, I would have thought to extend
the 'key' class with a sig_verify permission, and you pass the label of
the key used for signature verification and of the data to verify (from
the file it was read from?).

Just an idea.

Roberto

> > > We already have an ASN.1 parser in the kernel, so we might
> > > want to leverage that to match a certificate.
> > 
> > We have the parser, however after parsing the certificate we do not 
> > retain all the information within it.  Some of the recent changes I have 
> > done required modifications to the public_key struct.  If there isn’t any 
> > type of hard coded policy, what would be the reception of retaining the 
> > entire cert within the kernel? 
> 
> I think it would make sense to have a default policy loaded at boot
> time, then load and take into account new pieces of policies at run
> time, but only parse/tag/assign a role to certificates/keys when they
> are loaded.

