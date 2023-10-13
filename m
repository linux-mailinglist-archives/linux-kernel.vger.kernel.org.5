Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 817FA7C8CB5
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 20:03:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231316AbjJMSDJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 14:03:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230260AbjJMSDH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 14:03:07 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:242:246e::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7EAFD6;
        Fri, 13 Oct 2023 11:03:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=+YCPIF7bIuvSFdfYLoHL+t68NvW/EnMItKeS5kyuoaw=;
        t=1697220186; x=1698429786; b=xjUWAVCIMPx6GnpMdib8tUsdaaVSUjHjavnGPJ5x3v/8cPj
        MHM+Jy3RvA8xJp33+XD4WbWPX4w0xUE5AQkAKn6KfxwOGJ7P0yprCscqaLH5DFmMtfIdXBzkSy3Sg
        DLc18rG/WsuHxZmPO+PAjJNSK6FpH7OSjKQSLBv6Sf1np4xfir+7KJXpxhk3C4NAi9gPE1WvCEpMZ
        fGHZPebuhq9j9NI998GiyrYDjf1gEzv50E2HJqjRUdgw6yp4cfdRGFNTy53T98a5cNgW3uDdm4QmK
        4SADaia4+cMxjQuArGCpsLDwhfBhYKQjpXNyIJQXOHHprFy3dIDb3C8EouXg2D2w==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.97-RC1)
        (envelope-from <johannes@sipsolutions.net>)
        id 1qrMUs-00000004lf0-44Ty;
        Fri, 13 Oct 2023 20:02:51 +0200
Message-ID: <789449f63ff6175ff46951507c03753f4430aa85.camel@sipsolutions.net>
Subject: Re: [PATCH] [RFC] wireless: move obsolete drivers to staging
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Arnd Bergmann <arnd@arndb.de>, Geoff Levand <geoff@infradead.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Kalle Valo <kvalo@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
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
        linux-staging@lists.linux.dev,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Date:   Fri, 13 Oct 2023 20:02:49 +0200
In-Reply-To: <2fb4f151-9146-4cce-a3e6-ca80a95cf590@app.fastmail.com>
References: <20231010155444.858483-1-arnd@kernel.org>
         <2023101051-unmasked-cleaver-79b3@gregkh> <87y1g94szz.fsf@kernel.org>
         <2023101139-pyromania-game-2237@gregkh> <87r0m1fwg9.fsf@kernel.org>
         <20231011080955.1beeb010@kernel.org> <87sf6g2hc8.fsf@kernel.org>
         <63e57ef8-c9f2-489a-8df8-51dcffd437c6@app.fastmail.com>
         <b1c87f71abef5aba6b39893a417466bf9f65c2d5.camel@sipsolutions.net>
         <CAMuHMdX3F9rvD3Fzbc1dwm7Vm73VW1x5ETbxkk-jJm3Bpr5i+A@mail.gmail.com>
         <d336126d58e12e8e67078c8142a524c667cc5639.camel@sipsolutions.net>
         <39719eae-f166-4059-a70d-c6b74ecd46e2@infradead.org>
         <2fb4f151-9146-4cce-a3e6-ca80a95cf590@app.fastmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2023-10-13 at 17:44 +0200, Arnd Bergmann wrote:
> On Thu, Oct 12, 2023, at 18:36, Geoff Levand wrote:
> > On 10/12/23 17:41, Johannes Berg wrote:
> > > But seriously - is it worth to try to keep a wireless driver for it i=
f
> > > we don't even know anyone using a PS3 at all?
> >=20
> > There is still a considerable user base for the PS3, so we
> > must keep the ps3-gelic-wireless driver.
>=20
> Do you know if anyone has tried changing this driver over to the
> cfg80211 interface from the wireless extensions?

I looked at that yesterday, and sadly I _think_ it's not even possible,
there are some corner cases in it like "no WPA2" that don't seem to be
fully covered in cfg80211/nl80211, at least not with the APIs today and
with current versions of wpa_supplicant.

It might still be doable because things like
WPA_DRIVER_CAPA_KEY_MGMT_WPA2_PSK don't really seem to be used much in
wpa_supplicant, but we'd have to carefully test that I guess.

Also, it depends on the PS3 firmware version whether or not that's
supported.

Then again, arguably wifi without WPA2 is pretty much useless these
days?

johannes
