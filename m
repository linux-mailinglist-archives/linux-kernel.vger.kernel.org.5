Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47A897ABA0F
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 21:28:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231283AbjIVT2g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 15:28:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233461AbjIVT2f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 15:28:35 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34057A3;
        Fri, 22 Sep 2023 12:28:29 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2FF9AC433CB;
        Fri, 22 Sep 2023 19:28:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695410908;
        bh=R3/iDz5aT9T7hlpiaTK760UMgyWpl0oOdgc9iiOBRew=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=uGThn8drLb5fMKoylPOVqi74FJ7D22bCwupRq/TFRPjYPTcblR8kVYm8fPhkWDl73
         +AWaqXfnl5v7ob7ORs6vLWRitjm6bJ4XT+TOhue0wqcf6h14EKmv+z5X8D5YDCF6T2
         +b02c4G13j9zXJPhTzFB04quX8PU7hLLqSuxlZGP4/GkBPFwSjGTcTRAznGIohmIEQ
         Ai8HnPXfcCeeH7ngBkqZodllLrrvQEnPbeAu2ka01JVJn5lVFk642q/ruWoPRlZP6E
         VhVde+a62lyty58dpHsEL0apwStnjtHFzWRDRx8kKIvUAO/4ag9ZSH0KGrMYEI8tlp
         vbJ+SWc5K2hAQ==
Date:   Fri, 22 Sep 2023 20:28:21 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Rob Herring <robh+dt@kernel.org>
Cc:     Doug Anderson <dianders@chromium.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Chen-Yu Tsai <wenst@chromium.org>, linux-input@vger.kernel.org,
        Jiri Kosina <jikos@kernel.org>,
        Hsin-Yi Wang <hsinyi@chromium.org>, linux-gpio@vger.kernel.org,
        linus.walleij@linaro.org,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Johan Hovold <johan+linaro@kernel.org>,
        andriy.shevchenko@linux.intel.com, frowand.list@gmail.com,
        gregkh@linuxfoundation.org, hdegoede@redhat.com,
        james.clark@arm.com, james@equiv.tech, keescook@chromium.org,
        linux-kernel@vger.kernel.org, rafael@kernel.org, tglx@linutronix.de
Subject: Re: [RFC PATCH] of: device: Support 2nd sources of probeable but
 undiscoverable devices
Message-ID: <785c1e6e-8d6c-49fa-b9eb-a58e4e6cf435@sirena.org.uk>
References: <20230921102420.RFC.1.I9dddd99ccdca175e3ceb1b9fa1827df0928c5101@changeid>
 <CAL_Jsq+noP32-m5xdUCLFPFBXLxX9Ys1BNFM+9sga6KYTmDzqQ@mail.gmail.com>
 <CAD=FV=WXxGhX0Fw2nSS7PxYb1O-LUewAhoUVPn=2EpbSD2OeHQ@mail.gmail.com>
 <CAL_JsqKJyRJmwJzB1yew71Ld7BeMMat+rzhX9XtDtiFE8Dbvcw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="lkdtl8PHTFTeNLKo"
Content-Disposition: inline
In-Reply-To: <CAL_JsqKJyRJmwJzB1yew71Ld7BeMMat+rzhX9XtDtiFE8Dbvcw@mail.gmail.com>
X-Cookie: A day without sunshine is like night.
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--lkdtl8PHTFTeNLKo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Sep 22, 2023 at 02:08:08PM -0500, Rob Herring wrote:

> You could always make the driver probe smarter where if your supply
> was already powered on, then don't delay. Then something else could
> ensure that the supply is enabled. I'm not sure if regulators have the
> same issue as clocks where the clock might be on from the bootloader,
> then a failed probe which gets then puts the clock turns it off.

That'll happen.

--lkdtl8PHTFTeNLKo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmUN6tQACgkQJNaLcl1U
h9DhuQf/S8t/ZgUl/pNQE3JrluRneGilBmp/iuF8gMkmI3+0gY2UO/t6A4A/2GcS
9nZ9IcI1wx37gGjvNxESBCTl1b+2RI/mi9kBn/nbElSXmYerHHE/0HuENvwMspBD
0msxDtUYRUPc4CoLBf1xElQeB0Tiry1QTXB6cG1xdyrjnqxAZ6ySL1cz8G3V1QMB
aOwZPDuV2abhykK0hRVbWgy2lYt0pdNNUYVHDEHUn/imw7fTOd9qHQGqLCyaB+ob
JSWTGggCnu28CemwoJ0I+neqRK8IOd+KTY5uOJ2L7cHCVg5Zz1ureTQCIhnA1mIO
L6+2nIkz4SlUP7iQw+UiCUXLtXcY6A==
=JjEE
-----END PGP SIGNATURE-----

--lkdtl8PHTFTeNLKo--
