Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55E007C71BE
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 17:41:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379197AbjJLPlk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 11:41:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347307AbjJLPli (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 11:41:38 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:242:246e::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A66C7B8;
        Thu, 12 Oct 2023 08:41:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=1AUZ4kSi2AEEEv3nuAS4HldMWbbuyLi811omII/FRFQ=;
        t=1697125296; x=1698334896; b=uMMpgm+03zIjdiuVAoc5NUM2xNDauYkoRpA5AvUdLOO6YDx
        zyFyedf7xylZ6Jn64e9B+4GKwA1jVOw8l8Ky21YItTtTdWL72AzMkWCPIaKU+AvOOfgRsa4Gr/41r
        TnSU+xUTC6ouMEvIdY94EVFTKMi8garyHJBZfj5F61cVFj9ZkZ/MBmnVSOW5PYgP9RSlrYpyS0H6A
        haIvID0MkUIr5pnC6tOH6TgnDnwpzE/UQvnvzyxkzOac4ej0BNRZRGvJhD/56P9m8zeCTFu56R9+k
        GToZw3eEA/vCvxePBzvgwlkzvcLHu84Dr+NVOnXCaxcvhJcLumjw89fV8vBN/ySA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.97-RC1)
        (envelope-from <johannes@sipsolutions.net>)
        id 1qqxoW-00000003T2i-3J0o;
        Thu, 12 Oct 2023 17:41:29 +0200
Message-ID: <d336126d58e12e8e67078c8142a524c667cc5639.camel@sipsolutions.net>
Subject: Re: [PATCH] [RFC] wireless: move obsolete drivers to staging
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, Kalle Valo <kvalo@kernel.org>,
        Jakub Kicinski <kuba@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@kernel.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Claudiu Beznea <claudiu.beznea@tuxon.dev>,
        Pavel Machek <pavel@ucw.cz>,
        "David S . Miller" <davem@davemloft.net>,
        Larry Finger <Larry.Finger@lwfinger.net>,
        linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-staging@lists.linux.dev, Geoff Levand <geoff@infradead.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Date:   Thu, 12 Oct 2023 17:41:27 +0200
In-Reply-To: <CAMuHMdX3F9rvD3Fzbc1dwm7Vm73VW1x5ETbxkk-jJm3Bpr5i+A@mail.gmail.com>
References: <20231010155444.858483-1-arnd@kernel.org>
         <2023101051-unmasked-cleaver-79b3@gregkh> <87y1g94szz.fsf@kernel.org>
         <2023101139-pyromania-game-2237@gregkh> <87r0m1fwg9.fsf@kernel.org>
         <20231011080955.1beeb010@kernel.org> <87sf6g2hc8.fsf@kernel.org>
         <63e57ef8-c9f2-489a-8df8-51dcffd437c6@app.fastmail.com>
         <b1c87f71abef5aba6b39893a417466bf9f65c2d5.camel@sipsolutions.net>
         <CAMuHMdX3F9rvD3Fzbc1dwm7Vm73VW1x5ETbxkk-jJm3Bpr5i+A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2023-10-12 at 17:39 +0200, Geert Uytterhoeven wrote:
> Hi Johannes,
>=20
> On Thu, Oct 12, 2023 at 5:28=E2=80=AFPM Johannes Berg <johannes@sipsoluti=
ons.net> wrote:
> > On Thu, 2023-10-12 at 16:36 +0200, Arnd Bergmann wrote:
> > >=20
> > > ps3-gelic-wireless
> >=20
> > Didn't Sony disable Linux on PS3 eventually? Though maybe someone still
> > has some devices with old software.
>=20
> If you didn't update the firmware, you could keep on using Linux.
>=20
> And people may have found a vulnerability in more recent firmware
> versions that allows them to run custom software.

Yeah, fair.

> I don't know, it's been +10 years ago I touched a PS3 ;-)

I never had one :-)

But seriously - is it worth to try to keep a wireless driver for it if
we don't even know anyone using a PS3 at all?

But maybe we'll find someone :-)

johannes
