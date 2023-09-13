Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 482CF79F20E
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 21:31:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232318AbjIMTbV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 15:31:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231172AbjIMTbT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 15:31:19 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CE671998;
        Wed, 13 Sep 2023 12:31:15 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A853AC433C7;
        Wed, 13 Sep 2023 19:31:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694633475;
        bh=C5MM0pQBeJTV7oKReAH8MdIvNB44HPHwyKyQ454VPuw=;
        h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
        b=XhvgIIM3My7ZToxpu2qpNFYsq/knw6btBfJOWmShiLr0GeXvJBCc2Ua5wgCwnE4v7
         Ba+JxSN7CiQxFb4FRBp/BftSNy9fpCmvii1YHnFFlvr1o/V1OGCWaYdX4XBGZkiSr4
         T7/uAcXdjqNsJVyBLWMKGa+ebxAcPsMMuXUajy129VAZgyhOD3RfbMvElx4OB8V8La
         Nh8Qa+x9ZWqXlj7ofYldnmTzrbei+Mm3YFXhqq+TE/Fr2P4cv66KtVA0lkAzlijvFw
         e9hytBimSMcVesk1l2sibvY9WE8CdzhqBfHxKstWxPa0xQOjUmyhQMNfl9ovTEnVQt
         v909QacM7+32Q==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Wed, 13 Sep 2023 22:31:11 +0300
Message-Id: <CVI1FHKRSG47.2CV547I19B9ZT@suppilovahvero>
Cc:     "Yue Haibing" <yuehaibing@huawei.com>, <jmorris@namei.org>,
        <serge@hallyn.com>, <keyrings@vger.kernel.org>,
        <linux-security-module@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 -next] keys: Remove unused extern declarations
From:   "Jarkko Sakkinen" <jarkko@kernel.org>
To:     "Paul Moore" <paul@paul-moore.com>, <dhowells@redhat.com>
X-Mailer: aerc 0.14.0
References: <20230729024026.32228-1-yuehaibing@huawei.com>
 <CAHC9VhRW0Jt0pitVx1cw-zJGWfTmvTU4RSmOFKANYJA7CeEF7g@mail.gmail.com>
 <CAHC9VhSisEfQd0KCu7f8yKBwnrduFOPhP2SzWDfXiuvGh2g13A@mail.gmail.com>
In-Reply-To: <CAHC9VhSisEfQd0KCu7f8yKBwnrduFOPhP2SzWDfXiuvGh2g13A@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed Sep 13, 2023 at 9:00 PM EEST, Paul Moore wrote:
> On Mon, Aug 7, 2023 at 5:46=E2=80=AFPM Paul Moore <paul@paul-moore.com> w=
rote:
> > On Fri, Jul 28, 2023 at 10:40=E2=80=AFPM Yue Haibing <yuehaibing@huawei=
.com> wrote:
> > >
> > > From: YueHaibing <yuehaibing@huawei.com>
> > >
> > > Since commit b2a4df200d57 ("KEYS: Expand the capacity of a keyring")
> > > iterate_over_keyring() is never used, so can be removed.
> > >
> > > And commit b5f545c880a2 ("[PATCH] keys: Permit running process to ins=
tantiate keys")
> > > left behind keyring_search_instkey().
> > >
> > > Fixes: b2a4df200d57 ("KEYS: Expand the capacity of a keyring")
> > > Fixes: b5f545c880a2 ("[PATCH] keys: Permit running process to instant=
iate keys")
> > > Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> > > ---
> > > v3: Add Fixes tag
> > > v2: Also remove keyring_search_instkey()
> > > ---
> > >  security/keys/internal.h | 7 -------
> > >  1 file changed, 7 deletions(-)
> >
> > Reviewed-by: Paul Moore <paul@paul-moore.com>
>
> Jarkko or David, please merge this or explain what is wrong with this pat=
ch.

Sorry, I was aiming to pick this, and thanks for reminding.

Applied.

BR, Jarkko
