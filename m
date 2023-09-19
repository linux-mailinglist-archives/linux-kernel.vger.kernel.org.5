Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 815537A68B1
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 18:16:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231225AbjISQQO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 12:16:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229772AbjISQQM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 12:16:12 -0400
Received: from mail-4323.proton.ch (mail-4323.proton.ch [185.70.43.23])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A530BA9;
        Tue, 19 Sep 2023 09:16:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=n8pjl.ca;
        s=protonmail2; t=1695140160; x=1695399360;
        bh=k2QmhXn3FHpsD31Ag66sjWvY57vLi94vGdI9Jg32c2Q=;
        h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
         Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
         Message-ID:BIMI-Selector;
        b=VjPOUfr+BDKot6jNtzfiNQUBn+0rrhZJiA59iRWy30aLqarcEfUbJl13WNuPnXIoW
         NywHiVkOkN0sAhAj5HVCpUg5MCHPnoVtVm3uKwvnlLQz2bUOxdLprD9u+w4LbKTPgA
         bnBfsyBEq3NfeW6N9NlCpqkwDvrEgdVVXns49DKnopvogQCzzy0NJzr2/B+6TZ37p2
         pBG3Imgo+IjObhl+GtscMyMDCDfzeNnzpCBmxFsxt25WKmx+xpxmqyJ0hqsjVZLW+n
         JXFusuE18XA6ozPVKnAkxmiePcriJHUHal7GefK+IYNNYtydrpkBO7Z/E7Jw9j+Yfj
         +4CaTlaacEEcQ==
Date:   Tue, 19 Sep 2023 16:15:41 +0000
To:     geert@linux-m68k.org
From:   Peter Lafreniere <peter@n8pjl.ca>
Cc:     anton.ivanov@cambridgegreys.com, ink@jurassic.park.msu.ru,
        jack@suse.cz, johannes@sipsolutions.net,
        linux-alpha@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-m68k@vger.kernel.org,
        linux-mips@vger.kernel.org, linux-sh@vger.kernel.org,
        linux-um@lists.infradead.org, linux@armlinux.org.uk,
        linuxppc-dev@lists.ozlabs.org, peter@n8pjl.ca,
        reiserfs-devel@vger.kernel.org, richard.henderson@linaro.org,
        richard@nod.at, segher@kernel.crashing.org,
        tsbogend@alpha.franken.de
Subject: Re: [PATCH 0/7] arch/*: config: Remove ReiserFS from defconfig
Message-ID: <20230919161535.4774-1-peter@n8pjl.ca>
In-Reply-To: <CAMuHMdXQ=xpeY3tmLXe1kgJbRtmVAn62rEhvzO+VB7GCgy4F8w@mail.gmail.com>
References: <20230918175529.19011-1-peter@n8pjl.ca> <20230918234108.GN19790@gate.crashing.org> <20230919000026.7409-1-peter@n8pjl.ca> <20230919151630.GO19790@gate.crashing.org> <20230919155832.4179-1-peter@n8pjl.ca> <CAMuHMdXQ=xpeY3tmLXe1kgJbRtmVAn62rEhvzO+VB7GCgy4F8w@mail.gmail.com>
Feedback-ID: 53133685:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Geert,

On Tue, Sep 19, 2023 at 12:02, Geert Uytterhoeven <geert@linux-m68k.org> wr=
ote:
>=20
> Hi Peter,
>=20
> On Tue, Sep 19, 2023 at 5:58=E2=80=AFPM Peter Lafreniere peter@n8pjl.ca w=
rote:
>=20
> > 2) Stops building an obsolete and largely-unused filesystem unnecessari=
ly.
> > Some hobbyist targets like m68k and alpha may prefer to keep all filesy=
stems
> > available until total removal, but others like arm and UML have no need=
 for
> > ReiserFS to be built unless specifically configured.
>=20
>=20
> As UML is used a lot for testing, isn't it actually counter-productive
> to remove ReiserFS from the UML defconfig? The less testing it
> receives, the higher the chance of introducing regressions.

UML is used for testing, but in my view that makes the inclusion of
ReiserFS in its defconfig even worse. Users of UML are trying to test a
particular function, and so tend to use ext[2-4], as those are included in
the defconfig and are well tested and stable. So there is no extra testing
being done on ReiserFS due to its inclusion in the defconfig.

Keeping UML's defconfig as slim as possible improves build times, which is
particularly important for kernel testing and development.

>=20
> Gr{oetje,eeting}s,
>=20
> Geert
>

Cheers,
Peter Lafreniere=20

