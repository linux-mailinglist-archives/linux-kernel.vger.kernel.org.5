Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8EC47A6538
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 15:33:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232440AbjISNdC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 09:33:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232438AbjISNdA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 09:33:00 -0400
Received: from mail-4022.proton.ch (mail-4022.proton.ch [185.70.40.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6890E128
        for <linux-kernel@vger.kernel.org>; Tue, 19 Sep 2023 06:32:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=n8pjl.ca;
        s=protonmail2; t=1695130371; x=1695389571;
        bh=dDMUxu8xdJRGaY5VRYNxHnseAs3vdrFdlwDlLav2wbg=;
        h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
         Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
         Message-ID:BIMI-Selector;
        b=LzsTdFtGLQAwW+llY1Dr9BYJpxyqO6voiqQddF0oGd6ND77zWF7xxOl9q2pQA2UIQ
         ENpsVsXXRaGP0T3YoA+Cd4KiL1N6zq9Pwn+ChNxoVYgeF14SqKy8fEx486oNKtTcu9
         xv+vMFuzJi9wrRbOmlSc00H59502hGN0tgmfS1UaZRLUHzb+xhQRnXKdjPR6mJ20W5
         xd3+jvozi7TlW5CoADthJeV7hpRCeLk6DuMoLdpTkGYlYqJ4yNLAiAxfb6csec8qa5
         jar+TrgUNZipUSyahX8m2PLn4dfwd/ZxGsb4/Etup+Y8g0FFVWAHq3M+2+P8DQ1MuR
         E8hUbEUUg4v2g==
Date:   Tue, 19 Sep 2023 13:32:33 +0000
To:     geert@linux-m68k.org
From:   Peter Lafreniere <peter@n8pjl.ca>
Cc:     jack@suse.cz, linux-kernel@vger.kernel.org,
        linux-m68k@lists.linux-m68k.org, peter@n8pjl.ca,
        reiserfs-devel@vger.kernel.org
Subject: Re: [PATCH 5/7] arch: m68k: remove ReiserFS from defconfig
Message-ID: <20230919133227.6448-1-peter@n8pjl.ca>
In-Reply-To: <CAMuHMdVQaBBZgSsgZyNR2HxMsck2fWNjG6fK93eBFFeyDz0Hkw@mail.gmail.com>
References: <20230918175529.19011-1-peter@n8pjl.ca> <20230918175529.19011-6-peter@n8pjl.ca> <CAMuHMdVQaBBZgSsgZyNR2HxMsck2fWNjG6fK93eBFFeyDz0Hkw@mail.gmail.com>
Feedback-ID: 53133685:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 19, 2023 at 03:19, Geert Uytterhoeven <geert@linux-m68k.org> wr=
ote:
> Hi Peter,
>=20
> On Mon, Sep 18, 2023 at 7:57=E2=80=AFPM Peter Lafreniere peter@n8pjl.ca w=
rote:
>=20
> > ReiserFS has been deprecated for a year and a half, yet is still built
> > as part of a defconfig kernel.
> >=20
> > According to commit eb103a51640e ("reiserfs: Deprecate reiserfs"), the
> > filesystem is slated to be removed in 2025. Remove it from the defconfi=
g
> > profiles now, as part of its deprecation process.
> >=20
> > Signed-off-by: Peter Lafreniere peter@n8pjl.ca
>=20
>=20
> Thanks for your patch!
>=20
> Given these defconfigs enable ReiserFS as a module (not built-in),
> and that ReiserFS is still available upstream, and enabled by distros
> like Debian, I would like to keep it that way.
> The m68k defconfigs will be updated after the removal of ReiserFS,
> as part of the regular defconfig resync.

I still think that since ReiserFS is being removed soon enough and that the=
re
are a negligible number of users, it should be left out of defconfig builds=
.
allmodconfig and custom configs (like Debian's) exist for a reason.

But yours is a reasonable approach anyhow. Especially for an arch that is i=
n
the same position as some of the more exotic filesystems that you build as
modules. Thanks for taking a look.

Cheers,

Peter Lafreniere
<peter@n8pjl.ca>

