Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58D977A0FAC
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 23:18:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229550AbjINVSk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 17:18:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229495AbjINVSj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 17:18:39 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A92726B2;
        Thu, 14 Sep 2023 14:18:35 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C45AC433C8;
        Thu, 14 Sep 2023 21:18:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694726314;
        bh=V244jUJ626fxcH+y8O4nZ/YjqzjgoDPJ7WhHv1mLgLo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NAbQGF99ZFcedAWU9dq34WHR0IKjeV4PTJfJ5lqxQmNffICrZ2SDM95bde6VM1t4/
         hFLsdJKd1FtxZkmlRHDA2uEmUeuPUznNiDDg8gNJ6w1TOm4wSR1ni5UsKDO1Ft4hqy
         gTQtVosPW/M5UP11jnj5KnfeN73peJyc+rjH4HD75UPt1zt72YvU5RwcOQ5Vsw0uCE
         VXgNOQ6NL8lLE5EkUQbSHx3QhhZkaEqIMGfFOC+9M4j3AlXdprmBy9R4siyjJfEGCd
         sEt9rutAY3qJ46foaDXfny/n28+ZbZhB05audFP18O0/lShZnztHGNmn1HG3aHOyDL
         rAx2QT3fbbvkw==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Fri, 15 Sep 2023 00:18:31 +0300
Message-Id: <CVIYC7CUJOWH.FSY1TNPSHVX7@suppilovahvero>
From:   "Jarkko Sakkinen" <jarkko@kernel.org>
To:     "Justin Forbes" <jforbes@fedoraproject.org>,
        "Linus Torvalds" <torvalds@linux-foundation.org>
Cc:     "Peter Huewe" <peterhuewe@gmx.de>,
        "Jason Gunthorpe" <jgg@ziepe.ca>,
        "David Howells" <dhowells@redhat.com>,
        "Mimi Zohar" <zohar@linux.ibm.com>,
        <linux-integrity@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <keyrings@vger.kernel.org>
Subject: Re: [GIT PULL] tpmdd changes for v6.6-rc2
X-Mailer: aerc 0.14.0
References: <20230912201102.1012306-1-jarkko@kernel.org>
 <CAHk-=wgLB9_z5TcvRKVsSk3BWPfkDeWN0pDMdEv=-hnrnTgX1Q@mail.gmail.com>
 <CVI1GKA044I2.2A5GRO80ABMNN@suppilovahvero>
 <CAHk-=wiS2rHdPe9qQ4Ahzy6t6hbG18ihsOjBYxn3Nr88yen52A@mail.gmail.com>
 <CAFbkSA1vh+PS7HxhdZ2jLer4ZPQJWTsSU5NEAwJW2Rp8CZwzZQ@mail.gmail.com>
In-Reply-To: <CAFbkSA1vh+PS7HxhdZ2jLer4ZPQJWTsSU5NEAwJW2Rp8CZwzZQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri Sep 15, 2023 at 12:05 AM EEST, Justin Forbes wrote:
> On Thu, Sep 14, 2023 at 4:02=E2=80=AFPM Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
> >
> > On Wed, 13 Sept 2023 at 12:32, Jarkko Sakkinen <jarkko@kernel.org> wrot=
e:
> > >
> > > Ok, I'll make something more reasonable.
> >
> > Well, I took the pull already, just saying "tpm fix".
> >
> > I assume the only thing the typo actually causes is printk's with a
> > typo in it. Maybe some sysfs name will be wrong?
> >
> > That's the kind of information I would have _liked_ to see in the
> > merge message, but I didn't then delve into just where the class names
> > might actually be used.
>
> Sorry, I should have been more clear. The typo causes misnamed sysfs
> files, which breaks some userspace tools.

Ya, I got a bit confused because I assumed that the original change was
coming from my tree at first, and was wondering how could possibly my
QA process did not catch it. Should have checked in detail and wrote a
better description to the pull request. All in all, great that the issue
was catched before the release :-)

In future I suggest to run always the tpm2 test from kselftest's for any
TPM patch. It would have catched the bug early on.

BR, Jarkko
