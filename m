Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7053A762DBE
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 09:33:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229520AbjGZHdV convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 26 Jul 2023 03:33:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229968AbjGZHc3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 03:32:29 -0400
Received: from frasgout11.his.huawei.com (unknown [14.137.139.23])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2049C49DE;
        Wed, 26 Jul 2023 00:30:05 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.18.147.228])
        by frasgout11.his.huawei.com (SkyGuard) with ESMTP id 4R9lcd45scz9v7Vl;
        Wed, 26 Jul 2023 15:18:41 +0800 (CST)
Received: from [127.0.0.1] (unknown [10.204.63.22])
        by APP1 (Coremail) with SMTP id LxC2BwBn7glpy8BkKDwSBQ--.33041S2;
        Wed, 26 Jul 2023 08:29:52 +0100 (CET)
Message-ID: <3dc4fd2a452d1c0e33d27731de626d2791577274.camel@huaweicloud.com>
Subject: Re: [PATCH] security: Fix ret values doc for
 security_inode_init_security()
From:   Roberto Sassu <roberto.sassu@huaweicloud.com>
To:     Paul Moore <paul@paul-moore.com>
Cc:     jmorris@namei.org, serge@hallyn.com,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Roberto Sassu <roberto.sassu@huawei.com>
Date:   Wed, 26 Jul 2023 09:29:42 +0200
In-Reply-To: <CAHC9VhSbya3Q-VM8v43qkQDWCuYWFqQ801j9_HfdwWJ9RLzkjw@mail.gmail.com>
References: <20230724145204.534703-1-roberto.sassu@huaweicloud.com>
         <CAHC9VhQcVSX+kZ3PMJGJ3i-qxv9g3iP_Y4At5VCV8qSoJYj8Cg@mail.gmail.com>
         <a582bac4f709fe28dc17d9023ac78b53a2a1ac64.camel@huaweicloud.com>
         <CAHC9VhSbya3Q-VM8v43qkQDWCuYWFqQ801j9_HfdwWJ9RLzkjw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.44.4-0ubuntu1 
MIME-Version: 1.0
X-CM-TRANSID: LxC2BwBn7glpy8BkKDwSBQ--.33041S2
X-Coremail-Antispam: 1UD129KBjvJXoWxAF18KryxJryrtw13uryxGrg_yoW5Ww13pF
        WUK3Wj9rn8tFW7G3sayF17W3WSk3yfGr4DWrs0vr17Za1q9wn3Kr1FkF45ury7Gr48Aw10
        vw429F43Cr1DArJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUgmb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
        vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7Cj
        xVAFwI0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVWUJVW8JwA2z4x0Y4vEx4A2jsIEc7CjxV
        AFwI0_Gr0_Gr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
        x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
        0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_
        Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1V
        AY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAI
        cVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWrZr1j6s0DMI
        IF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2
        KfnxnUUI43ZEXa7IU1zuWJUUUUU==
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAgAKBF1jj4z07gABsq
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,KHOP_HELO_FCRDNS,
        MAY_BE_FORGED,RCVD_IN_MSPIKE_BL,RCVD_IN_MSPIKE_L3,RDNS_DYNAMIC,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2023-07-25 at 14:38 -0400, Paul Moore wrote:
> On Tue, Jul 25, 2023 at 3:02 AM Roberto Sassu
> <roberto.sassu@huaweicloud.com> wrote:
> > On Mon, 2023-07-24 at 17:54 -0400, Paul Moore wrote:
> > > On Mon, Jul 24, 2023 at 10:52 AM Roberto Sassu
> > > <roberto.sassu@huaweicloud.com> wrote:
> > > > 
> > > > From: Roberto Sassu <roberto.sassu@huawei.com>
> > > > 
> > > > Commit 6bcdfd2cac55 ("security: Allow all LSMs to provide xattrs for
> > > > inode_init_security hook") unified the !initxattrs and initxattrs cases. By
> > > > doing that, security_inode_init_security() cannot return -EOPNOTSUPP
> > > > anymore, as it is always replaced with zero at the end of the function.
> > > > 
> > > > Also, mentioning -ENOMEM as the only possible error is not correct. For
> > > > example, evm_inode_init_security() could return -ENOKEY.
> > > > 
> > > > Fix these issues in the documentation of security_inode_init_security().
> > > > 
> > > > Fixes: 6bcdfd2cac55 ("security: Allow all LSMs to provide xattrs for inode_init_security hook")
> > > > Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
> > > > ---
> > > >  security/security.c | 4 ++--
> > > >  1 file changed, 2 insertions(+), 2 deletions(-)
> > > > 
> > > > diff --git a/security/security.c b/security/security.c
> > > > index cfdd0cbbcb9..5aa9cb91f0f 100644
> > > > --- a/security/security.c
> > > > +++ b/security/security.c
> > > > @@ -1604,8 +1604,8 @@ EXPORT_SYMBOL(security_dentry_create_files_as);
> > > >   * a security attribute on this particular inode, then it should return
> > > >   * -EOPNOTSUPP to skip this processing.
> > > >   *
> > > > - * Return: Returns 0 on success, -EOPNOTSUPP if no security attribute is
> > > > - * needed, or -ENOMEM on memory allocation failure.
> > > > + * Return: Returns 0 on success or on -EOPNOTSUPP error, a negative value other
> > > > + *         than -EOPNOTSUPP otherwise.
> > > 
> > > How about "Returns 0 if the LSM successfully initialized all of the
> > > inode security attributes that are required, negative values
> > > otherwise."?  The caller doesn't need to worry about the individual
> > > LSMs returning -EOPNOTSUPP in the case of no security attributes, and
> > > if they really care, they are likely reading the description above (or
> > > the code) which explains it in much better detail.
> > 
> > Maybe this could be better:
> > 
> > Return 0 if security attributes initialization is successful or not
> > necessary, a negative value otherwise.
> 
> Well, I'm trying to avoid differentiating between the non-zero, but
> successful attribute initialization and the zero attribute case; from
> a caller's perspective it doesn't matter (and why we don't
> differentiate between the two with different error codes).  If the
> distinction between the two states is important from a caller's
> perspective, there should be different return codes.

Ok, fine for me. I take your suggestion.

Thanks

Roberto

