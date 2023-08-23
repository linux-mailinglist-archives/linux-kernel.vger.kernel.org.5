Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 064657858CB
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 15:16:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235656AbjHWNQt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 09:16:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235646AbjHWNQf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 09:16:35 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 550B91725;
        Wed, 23 Aug 2023 06:16:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7B66E66166;
        Wed, 23 Aug 2023 13:16:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5EB12C433C8;
        Wed, 23 Aug 2023 13:16:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692796564;
        bh=WSfj7/+wS0WuFR/h+zkA9CBdRrEotaBU5asv8QGK0S0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CW5gZjyMZ8lON3FRU1vFb4jmeLtpn7xEpDL7Rve7qeujST6mlTLGglXVWUCMJ5FLD
         XPje++LNqhr4A27IH0ts17s8g9loZ+Dl7XmDtSyc7plNpNwwvxwbKUqngnGhoT5lFj
         UxsgrL518l8npfDMfvtnRltos7+862EvhTC2emhb1P/hADdYkILj6VkrRiFq5aN7Px
         6Ub7bze/WRjh5OH1j8xkyNY0jesE6VZOBu8fS77JZOlYw5eprmYrm8JlPzYEqdTKQB
         PJ6OIoPymhKACbvFwSr5ZY3HySOsTSaDuvAs3gkXe3Ua8vgpE9DUNVzEbjQpjXanHZ
         gsueOfDuJoJyQ==
Date:   Wed, 23 Aug 2023 15:16:02 +0200
From:   Maxime Ripard <mripard@kernel.org>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Rahul Rameshbabu <rrameshbabu@nvidia.com>,
        syzbot <syzbot+3a0ebe8a52b89c63739d@syzkaller.appspotmail.com>,
        davidgow@google.com, gregkh@linuxfoundation.org,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        rydberg@bitmath.org, syzkaller-bugs@googlegroups.com,
        benjamin.tissoires@redhat.com
Subject: Re: [syzbot] [input?] KASAN: slab-use-after-free Read in
 input_dev_uevent
Message-ID: <y3hfjc227wouzraa4hyltyfd4athig5rmna2uwjqy6v23yzkad@wdmzmochmsve>
References: <00000000000035beba060371a468@google.com>
 <ijh2qmdtj452nq3idu2tohkrmfwr2qhbhrnyqzxjkkw2lrby53@v2dffcqdohsx>
 <878ra3m5my.fsf@nvidia.com>
 <nqrdxdcvuhvcs2syjfhcp5fbk4ckgzibc3izxknvsrka3kres6@ae65hqx67c4u>
 <ZOYAtI5KttKQnLWs@google.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="fesvofqg4mtrcfjd"
Content-Disposition: inline
In-Reply-To: <ZOYAtI5KttKQnLWs@google.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--fesvofqg4mtrcfjd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Dmitry,

On Wed, Aug 23, 2023 at 05:51:00AM -0700, Dmitry Torokhov wrote:
> On Wed, Aug 23, 2023 at 09:44:22AM +0200, Maxime Ripard wrote:
> > On Tue, Aug 22, 2023 at 08:57:41AM -0700, Rahul Rameshbabu wrote:
> > > On Tue, 22 Aug, 2023 11:12:28 +0200 Maxime Ripard <mripard@kernel.org=
> wrote:
> > > > Hi,
> > > >
> > > > So, we discussed it this morning with Benjamin, and I think the cul=
prit
> > > > is that the uclogic driver will allocate a char array with devm_kza=
lloc
> > > > in uclogic_input_configured()
> > > > (https://elixir.bootlin.com/linux/latest/source/drivers/hid/hid-ucl=
ogic-core.c#L149),
> > > > and will assign input_dev->name to that pointer.
> > > >
> > > > When the device is removed, the devm-allocated array is freed, and =
the
> > > > input framework will send a uevent in input_dev_uevent() using the
> > > > input_dev->name field:
> > > >
> > > > https://elixir.bootlin.com/linux/latest/source/drivers/input/input.=
c#L1688
> > > >
> > > > So it's a classic dangling pointer situation.
> > > >
> > > > And even though it was revealed by that patch, I think the issue is
> > > > unrelated. The fundamental issue seems to be that the usage of devm=
 in
> > > > that situation is wrong.
> > > >
> > > > input_dev->name is accessed by input_dev_uevent, which for KOBJ_UNB=
IND
> > > > and KOBJ_REMOVE will be called after remove.
> > > >
> > > > For example, in __device_release_driver() (with the driver remove h=
ook
> > > > being called in device_remove() and devres_release_all() being call=
ed in
> > > > device_unbind_cleanup()):
> > > > https://elixir.bootlin.com/linux/latest/source/drivers/base/dd.c#L1=
278
> > > >
> > > > So, it looks to me that, with or without the patch we merged recent=
ly,
> > > > the core has always sent uevent after device-managed resources were
> > > > freed. Thus, the uclogic (and any other input driver) was wrong in
> > > > allocating its input_dev name with devm_kzalloc (or the phys and un=
iq
> > > > fields in that struct).
> > > >
> > > > Note that freeing input_dev->name in remove would have been just as=
 bad.
> > > >
> > > > Looking at the code quickly, at least hid-playstation,
> > > > hid-nvidia-shield, hid-logitech-hidpp, mms114 and tsc200x seem to be
> > > > affected by the same issue.
> > >=20
> > > I agree with this analysis overall. At least in hid-nvidia-shield, I =
can
> > > not use devm for allocating the input name string and explicitly free=
 it
> > > after calling input_unregister_device. In this scenario, the name str=
ing
> > > would have been freed explicitly after input_put_device was called
> > > (since the input device is not devres managed). input_put_device would
> > > drop the reference count to zero and the device would be cleaned up at
> > > that point triggering KOBJ_REMOVE and firing off that final
> > > input_dev_uevent.
> > >=20
> > > I think this can be done for a number of the drivers as a workaround
> > > till this issue is properly resolved. If this seems appropriate, I can
> > > send out a series later in the day. This is just a workaround till the
> > > discussion below converges (which I am interested in).
> >=20
> > I'm sorry, I don't know the input framework well enough to understand
> > what you had in mind exactly. Could you send a patch with your
> > suggestion for the hid-nvidia-shield so we can discuss this further?
> >=20
> > That being said, I think that the current design around name, phys and
> > uniq is fairly treacherous to drivers and we should aim for a solution
> > that prevents that issue from being possible at all.
> >=20
> > I was inclined to go for a char array for each to get rid of the pointer
> > entirely, but Benjamin raised some concerns over the structure size so
> > it's probably not a great solution.
>=20
> I think everything is much simpler, with uclogic driver being in the
> wrong here: devm resource needs to be attached to the right device
> (instance of HID) rather than to the input device itself (which should
> never have any driver resources attached since it never has a driver).
> Something like this:
>=20
> diff --git a/drivers/hid/hid-uclogic-core.c b/drivers/hid/hid-uclogic-cor=
e.c
> index f67835f9ed4c..f234a7c97360 100644
> --- a/drivers/hid/hid-uclogic-core.c
> +++ b/drivers/hid/hid-uclogic-core.c
> @@ -148,7 +148,7 @@ static int uclogic_input_configured(struct hid_device=
 *hdev,
> =20
>  	if (suffix) {
>  		len =3D strlen(hdev->name) + 2 + strlen(suffix);
> -		name =3D devm_kzalloc(&hi->input->dev, len, GFP_KERNEL);
> +		name =3D devm_kzalloc(&hdev->dev, len, GFP_KERNEL);
>  		if (name) {
>  			snprintf(name, len, "%s %s", hdev->name, suffix);
>  			hi->input->name =3D name;
>=20
> In general, drivers should attach devm resources they allocate to the
> instance of device they are binding to, and nothing else.

I'm not sure that's enough unfortunately. The fundamental issue here
seems to be that input_dev_uevent follows a pointer that can be
allocated by the driver, and will be free'd before the last call to
input_dev_uevent.

And I think that's true for both devices here

Maxime

--fesvofqg4mtrcfjd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCZOYGjQAKCRDj7w1vZxhR
xY0kAQDDufdm0rCPjr7R5v1KwfviXaH0Yk7OBZZKHQMJRjzLQAEA80nTsnKu6rLm
0IQSf98Lt4EnRnMjYGlBM3RxFz6dJws=
=fCrs
-----END PGP SIGNATURE-----

--fesvofqg4mtrcfjd--
