Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 304E779F273
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 21:54:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232663AbjIMTyx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 15:54:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232646AbjIMTys (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 15:54:48 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DBEC1FD7;
        Wed, 13 Sep 2023 12:54:39 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56210C433CB;
        Wed, 13 Sep 2023 19:54:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694634879;
        bh=R4NyGPjqTOJdveL4q6k73GTVhLrDaw0wxAJyW09foX4=;
        h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
        b=OqouiPKUjT9AstBjsUBIOpRKceRHw08413u8/UAysGbyg6TikZyOhX8D6SZG8Im3i
         tyVr3CX4TuXpKYh9Dzj7A7/6wnZM3XcHU4mz+glQvIRwOQntKPD5zZfk4GsCwgQC+y
         vYtvoLrjs6TeYTkvZ/qou4SU3f7LvYqfKKWbYDIzc2vmaKbktwB846NY5MN40A5ory
         WuUJMaSyr6I4pVkqz+eUHcIgKO/HaWXcd3C8oen7LEfqulB8Pzq1c6E+d7tZ0waVMI
         lbfwN0GSgrpyCXj1yxqGSUcarGZ4x8aRr/mqqhlqalbE7YdBMIEtmIIs4v425EQGTQ
         BS/aG2aVFEkOw==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Wed, 13 Sep 2023 22:54:35 +0300
Message-Id: <CVI1XE98FLQN.1S24GU1DJ89WY@suppilovahvero>
Cc:     "Peter Huewe" <peterhuewe@gmx.de>,
        "Jason Gunthorpe" <jgg@ziepe.ca>,
        "David Howells" <dhowells@redhat.com>,
        "Mimi Zohar" <zohar@linux.ibm.com>,
        "Justin M . Forbes" <jforbes@fedoraproject.org>,
        <linux-integrity@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <keyrings@vger.kernel.org>
Subject: Re: [GIT PULL] tpmdd changes for v6.6-rc2
From:   "Jarkko Sakkinen" <jarkko@kernel.org>
To:     "Linus Torvalds" <torvalds@linux-foundation.org>
X-Mailer: aerc 0.14.0
References: <20230912201102.1012306-1-jarkko@kernel.org>
 <CAHk-=wgLB9_z5TcvRKVsSk3BWPfkDeWN0pDMdEv=-hnrnTgX1Q@mail.gmail.com>
 <CVI1GKA044I2.2A5GRO80ABMNN@suppilovahvero>
 <CAHk-=wiS2rHdPe9qQ4Ahzy6t6hbG18ihsOjBYxn3Nr88yen52A@mail.gmail.com>
In-Reply-To: <CAHk-=wiS2rHdPe9qQ4Ahzy6t6hbG18ihsOjBYxn3Nr88yen52A@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed Sep 13, 2023 at 10:45 PM EEST, Linus Torvalds wrote:
> On Wed, 13 Sept 2023 at 12:32, Jarkko Sakkinen <jarkko@kernel.org> wrote:
> >
> > Ok, I'll make something more reasonable.
>
> Well, I took the pull already, just saying "tpm fix".
>
> I assume the only thing the typo actually causes is printk's with a
> typo in it. Maybe some sysfs name will be wrong?
>
> That's the kind of information I would have _liked_ to see in the
> merge message, but I didn't then delve into just where the class names
> might actually be used.
>
>                Linus

Thanks for pointing this out because I also overlooked the whole fix,
and based my conclusions just "git describe --contains", which pointed
to my previous signed tag.

I actually do QA (both x86 and aarch64 and slowly setting up also riscv)
to my tree, and I did not understand how this could have leaked into a
PR since TPM2 kselftest would have catched that.

The original commit must have gone through some other maintainer tree
since I do not see in any of my PR's. Anyway, I'll document next time
better my PR because apparently not doing that can lead to toally false
conclusions :-)

Thanks for picking it up anyway.

BR, Jarkko
