Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 918237F2BFC
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 12:45:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230239AbjKULpf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 06:45:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229561AbjKULpc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 06:45:32 -0500
Received: from mail-il1-x12a.google.com (mail-il1-x12a.google.com [IPv6:2607:f8b0:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25E57110;
        Tue, 21 Nov 2023 03:45:29 -0800 (PST)
Received: by mail-il1-x12a.google.com with SMTP id e9e14a558f8ab-35b03e9c08eso6686725ab.1;
        Tue, 21 Nov 2023 03:45:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700567128; x=1701171928; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=5TsncJnkHHhH5aFZnD34nAuzJ0Am/ijvmcDHG7xzyko=;
        b=M2wTXvVP+PBdSD+xHMocJLk6Ez8tcK5oRdgKqROBzIl9RTu5+6hQBVfAiI1BCh1TKY
         0vkgd/0ygrqZXap1vtPeIkJE04Apj8qAUVKWUN5TGJP+dbDAwuboIfCX8U9cikdqh/M1
         +6kF+6Z3hlQiqyTVlkosK8y17FZUWgldh4zRx32TkWxLZXrCRfSy/KzBbjCZrIMvedeA
         BdI/St4pbiNmAJbSqlddnLvoq5D6VnY4xcXgOrBSfeoXM0QX/ZAl4qG4vV7eMFxAENNb
         4pWkXJzkQrmPDaaSfKuIScq8bo0hzcnqjd9SCehavhTGgtbPGpM3QlIW3MlbLR5cHCjf
         tUKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700567128; x=1701171928;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5TsncJnkHHhH5aFZnD34nAuzJ0Am/ijvmcDHG7xzyko=;
        b=RTV4ULRTQkQ9AqMKAtMRO8J01jbDfkUBWPfk7mnBTdqL4hQX9U6I7wbXOASr3BjjTC
         7LE9DakQXg1Wxg0L1+1MyXm7CpmcZr5IBECh7ySO23DPjPpRlttfRwjJWzyjllMYo3Nw
         k1BqmLc+E9BFQSVIwsMt66+/hqSI+7tfmPHCfQKsfXod0zWPzTta9QPAI+BZWaGZ8nTv
         7qhlYOa4YfGzMRJCGbiZJcjLMH/91WJCkQRniWmB1S33x7tT8wxe7iVFdG8Sv2GLg5Tn
         awbKZPMCKxNKga67goYO4SAzjtx/UcHnS0duhs4p+Ifuc+k8iJerWWZXK6hmlijVftc4
         gdyQ==
X-Gm-Message-State: AOJu0Yx5Y8CjjXq5sFTe6VselNIvYCDkJB8AyAzHnjd3nVR9UEJ+frWc
        ulRZEi1wrtn78ceT9ogy9jM=
X-Google-Smtp-Source: AGHT+IHh6WF5sUIVPSxYQng6yUeCz/frSIZ9ZH+napgzf9fV7M9fughcq0JwTN6BGi9YZaXbzZco0g==
X-Received: by 2002:a05:6e02:13ee:b0:35b:2f7:514f with SMTP id w14-20020a056e0213ee00b0035b02f7514fmr5981800ilj.32.1700567128408;
        Tue, 21 Nov 2023 03:45:28 -0800 (PST)
Received: from archie.me ([103.131.18.64])
        by smtp.gmail.com with ESMTPSA id h7-20020a056a00170700b006cb574445efsm5722770pfc.88.2023.11.21.03.45.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Nov 2023 03:45:27 -0800 (PST)
Received: by archie.me (Postfix, from userid 1000)
        id 0CE3F102106CB; Tue, 21 Nov 2023 18:45:20 +0700 (WIB)
Date:   Tue, 21 Nov 2023 18:45:20 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Takashi Iwai <tiwai@suse.de>, Hans de Goede <hdegoede@redhat.com>
Cc:     Thorsten Leemhuis <regressions@leemhuis.info>,
        Jean-Jacques Hiblot <jjhiblot@traphandler.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Regressions <regressions@lists.linux.dev>,
        Linux LEDs <linux-leds@vger.kernel.org>,
        Tim Crawford <tcrawford@system76.com>,
        Jeremy Soller <jeremy@system76.com>,
        System76 Product Development <productdev@system76.com>,
        Lee Jones <lee@kernel.org>, Pavel Machek <pavel@ucw.cz>,
        Johannes =?utf-8?Q?Pen=C3=9Fel?= <johannes.penssel@gmail.com>
Subject: Re: Fwd: sysfs: cannot create duplicate filename
 .../system76_acpi::kbd_backlight/color
Message-ID: <ZVyYUPei6_YP-g94@archie.me>
References: <b5646db3-acff-45aa-baef-df3f660486fb@gmail.com>
 <ZT25-gUmLl8MPk93@debian.me>
 <dc6264c4-d551-4913-a51b-72c22217f15a@traphandler.com>
 <ZUjnzB2RL2iLzIQG@debian.me>
 <87sf50pm34.wl-tiwai@suse.de>
 <b9d4ab02-fe49-48ab-bf74-0c7a578e891a@leemhuis.info>
 <87edgjo2kr.wl-tiwai@suse.de>
 <ae77198c-ae7b-4988-8b5b-824260b28e84@redhat.com>
 <874jhfo0oc.wl-tiwai@suse.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="avoRCUQPSyjgJdcP"
Content-Disposition: inline
In-Reply-To: <874jhfo0oc.wl-tiwai@suse.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--avoRCUQPSyjgJdcP
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 21, 2023 at 11:33:55AM +0100, Takashi Iwai wrote:
> On Tue, 21 Nov 2023 11:21:53 +0100,
> Hans de Goede wrote:
> >=20
> > Hi,
> >=20
> > On 11/21/23 10:52, Takashi Iwai wrote:
> > > On Tue, 21 Nov 2023 10:19:03 +0100,
> > > Thorsten Leemhuis wrote:
> > >>
> > >> Takashi, Jean-Jacques Hiblot, Lee,
> > >>
> > >> On 20.11.23 14:53, Takashi Iwai wrote:
> > >>> On Mon, 06 Nov 2023 14:19:08 +0100,
> > >>> Bagas Sanjaya wrote:
> > >>>> On Sat, Nov 04, 2023 at 01:01:56PM +0100, Jean-Jacques Hiblot wrot=
e:
> > >>>>> On 29/10/2023 02:48, Bagas Sanjaya wrote:
> > >>>>>> On Thu, Oct 26, 2023 at 02:55:06PM +0700, Bagas Sanjaya wrote:
> > >>>>>>> The culprit seems to be commit c7d80059b086c4986cd994a1973ec7a5=
d75f8eea, which introduces a new 'color' attribute for led sysfs class devi=
ces. The problem is that the system76-acpi platform driver tries to create =
the exact same sysfs attribute itself for the system76_acpi::kbd_backlight =
device, leading to the conflict. For testing purposes, I've just rebuilt th=
e kernel with the system76-apci color attribute renamed to kb_color, and th=
at fixes the issue.
> > >>>>>>
> > >>>>>> Jean-Jacques Hiblot, would you like to take a look on this regre=
ssion,
> > >>>>>> since you authored the culprit?
> > >>>
> > >>>>> The offending commit stores the color in struct led_classdev and =
exposes it
> > >>>>> via sysfs. It was part of a series that create a RGB leds from mu=
ltiple
> > >>>>> single-color LEDs. for this series, we need the color information=
 but we
> > >>>>> don't really need to expose it it via sysfs. In order to fix the =
issue, we
> > >>>>> can remove the 'color' attribute from the sysfs.
> > >>>>
> > >>>> OK, see you in the patch!
> > >>>
> > >>> Is there a patch available?
> > >>
> > >> Not that I know of. Could not find anything on lore either.
> > >>
> > >>> This bug hits for a few Logitech keyboard models, too, and it makes
> > >>> 6.6 kernel unsable for them, as hid-lg-g15 driver probe fails due to
> > >>> this bug:
> > >>>   https://bugzilla.kernel.org/show_bug.cgi?id=3D218155
> > >>>
> > >>> We need a quick fix for 6.6.x.
> > >>
> > >> Given that Jean-Jacques Hiblot (the author of the culprit) and Lee (=
who
> > >> committed it and sent it to Linus) know about this for a while alrea=
dy
> > >> without doing anything about it, I wonder if someone should just sen=
d a
> > >> revert to Linus (unless of course that is likely to introduce a
> > >> regression on its own).
> > >>
> > >> Takashi, could you maybe do this, unless a fix shows up real soon?
> > >=20
> > > I can, but we need to decide which way to go.
> > > There are several options:
> > >=20
> > > 1. Revert the commit c7d80059b086;
> > >    this drops led class color sysfs entries.  Also the store of
> > >    led_cdev->color from fwnode is dropped, too.
> > >=20
> > > 2. Drop only led class color sysfs entries;
> > >    a partial revert of c7d80059b086 above
> >=20
> > AFAIK further up in the thread (or a related thread) there
> > already was consensus to do this. Someone just needs to
> > write the patch.
>=20
> Well, is there any user of this new led_classdev.color field?
> The value read from fwnode is stored there, but as far as I see, there
> seems no real user, so far.  If it's still unused, we can do the whole
> revert -- which is cleaner.

ACK for the revert. The original commit should have been designed to
not have sysfs conflict like this, though.

Thanks.

--=20
An old man doll... just what I always wanted! - Clara

--avoRCUQPSyjgJdcP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZVyYUAAKCRD2uYlJVVFO
o5mNAP4u3Wc1/hr5E+vWPaq6O28ZmZ+BHGpDfTiZ4BWEye6Q4AD9G0LmUN2jwGtd
k30vUK6fk2DQWsvCfuimjR905DD7GQo=
=sj55
-----END PGP SIGNATURE-----

--avoRCUQPSyjgJdcP--
