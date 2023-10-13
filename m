Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F1A67C88B9
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 17:34:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232372AbjJMPem (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 11:34:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232270AbjJMPek (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 11:34:40 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1EA8C2;
        Fri, 13 Oct 2023 08:34:38 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id a640c23a62f3a-99c3d3c3db9so360742066b.3;
        Fri, 13 Oct 2023 08:34:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697211277; x=1697816077; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MtdRkIZK5hHrlpXS/ZIWSh5VkSojbqviipLwF16ZY9M=;
        b=A4Q3TNH9Qh72Je23izE6FDa16/mP11JH0ChdTNyeS4TZyfW8y/dSzm7/c8hLCclJ7u
         cuNrXh/zREZGIhYWHrpxsQ8DxueE//g+BgHtiVDdpJNmT6jbZoQ59LMVc/181ehjQm5i
         6MpItzwZr+T6fuCZwKmqNiHREEVWmN6+9ZK5tG6esuaVp6Bpd9GULUZu1JJePNcwlo5o
         EhiLR56QKc8JuAqlcyT+fwTuOTST8en9pRDKV5EvM9EGUQD4wtEoGASn0cVGlPoS/nhA
         Ib9sChSulPBz+LtBoG/RuOcArxbn+mhfqEznNE/46QOXvJmogfcgVJ9MtjaXEnsNGomQ
         3Hhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697211277; x=1697816077;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MtdRkIZK5hHrlpXS/ZIWSh5VkSojbqviipLwF16ZY9M=;
        b=PeRqSaKYRhpGeIcwhTVQjZxJl61UXBOejGdjL38QqxjXaMbJISLoyUAhjPZbdoT76X
         4255AqKoYVD9AoitxTz3LZKX/Zg3wKvzmzeB8ZLVlXubYY2zWv7HEp647DArxkpcyJWM
         u+5gGW/KKaxQ+JypaN6oxvmjtbaFXC+eLlXcFIoqCZ/EflnzKk6VHDVQnI98F9oZ6YG9
         7iiQYgae7S96F7HaEYnBRuG70pVKe+k6glffQKdAOUI4mpDU4PCARPG4JUXoloCvKV5B
         d5iVf0LsiYdHMXil8rmPZy5S5d5UxZrroQpR0uoKVGzSFaJO0KnklvKMHR+kz4uzNiVk
         rpNQ==
X-Gm-Message-State: AOJu0YwQnD1CieKfwPmwgy3NB0xNjAgOWPy0Fw2hPQjJklzRYbSBcjNL
        9M32Bn/IXFNJV91VNyCCncNggvGcdY8=
X-Google-Smtp-Source: AGHT+IEGdty9JXrHw66fcbnu8L6kNZ1KwI8BI5crgu+PJm6ebLcTwgOsdNMsBnmCry90mlSRAzwpcw==
X-Received: by 2002:a17:907:774c:b0:9ae:7433:aec6 with SMTP id kx12-20020a170907774c00b009ae7433aec6mr21814530ejc.60.1697211276712;
        Fri, 13 Oct 2023 08:34:36 -0700 (PDT)
Received: from orome.fritz.box (p200300e41f3f4900f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f3f:4900:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id ce24-20020a170906b25800b0098669cc16b2sm12420244ejb.83.2023.10.13.08.34.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Oct 2023 08:34:36 -0700 (PDT)
Date:   Fri, 13 Oct 2023 17:34:34 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Sean Young <sean@mess.org>
Cc:     linux-media@vger.kernel.org,
        Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>,
        Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-pwm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/3] pwm: make it possible to apply pwm changes in
 atomic context
Message-ID: <ZSljioc2OfPfxVeB@orome.fritz.box>
References: <cover.1697193646.git.sean@mess.org>
 <9c0f1616fca5b218336b9321bfefe7abb7e1749f.1697193646.git.sean@mess.org>
 <ZSkvTKr42sUZImiM@orome.fritz.box>
 <ZSlbFukZKGNpR5PM@gofer.mess.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="CWXLyOubpdFDIsRG"
Content-Disposition: inline
In-Reply-To: <ZSlbFukZKGNpR5PM@gofer.mess.org>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--CWXLyOubpdFDIsRG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 13, 2023 at 03:58:30PM +0100, Sean Young wrote:
> On Fri, Oct 13, 2023 at 01:51:40PM +0200, Thierry Reding wrote:
> > On Fri, Oct 13, 2023 at 11:46:14AM +0100, Sean Young wrote:
> > [...]
> > > diff --git a/include/linux/pwm.h b/include/linux/pwm.h
> > > index d2f9f690a9c1..93f166ab03c1 100644
> > > --- a/include/linux/pwm.h
> > > +++ b/include/linux/pwm.h
> > > @@ -267,6 +267,7 @@ struct pwm_capture {
> > >   * @get_state: get the current PWM state. This function is only
> > >   *	       called once per PWM device when the PWM chip is
> > >   *	       registered.
> > > + * @atomic: can the driver execute pwm_apply_state in atomic context
> > >   * @owner: helps prevent removal of modules exporting active PWMs
> > >   */
> > >  struct pwm_ops {
> > > @@ -278,6 +279,7 @@ struct pwm_ops {
> > >  		     const struct pwm_state *state);
> > >  	int (*get_state)(struct pwm_chip *chip, struct pwm_device *pwm,
> > >  			 struct pwm_state *state);
> > > +	bool atomic;
> > >  	struct module *owner;
> > >  };
> >=20
> > As I mentioned earlier, this really belongs in struct pwm_chip rather
> > than struct pwm_ops. I know that Uwe said this is unlikely to happen,
> > and that may be true, but at the same time it's not like I'm asking
> > much. Whether you put this in struct pwm_ops or struct pwm_chip is
> > about the same amount of code, and putting it into pwm_chip is much
> > more flexible, so it's really a no-brainer.
>=20
> Happy to change this of course. I changed it and then changed it back aft=
er
> Uwe's comment, I'll fix this in the next version.
>=20
> One tiny advantage is that pwm_ops is static const while pwm_chip is
> allocated per-pwm, so will need instructions for setting the value. Having
> said that, the difference is tiny, it's a single bool.

Yeah, it's typically a single assignment, so from a code point of view
it should be pretty much the same. I suppose from an instruction level
point of view, yes, this might add a teeny-tiny bit of overhead.

On the other hand it lets us do interesting things like initialize
chip->atomic =3D !regmap_might_sleep() for those drivers that use regmap
and then not worry about it any longer.

Given that, I'm also wondering if we should try to keep the terminology
a bit more consistent. "Atomic" is somewhat overloaded because ->apply()
and ->get_state() are part of the "atomic" PWM API (in the sense that
applying changes are done as a single, atomic operation, rather than in
the sense of "non-sleeping" operation).

So pwm_apply_state_atomic() is then doubly atomic, which is a bit weird.
On the other hand it's a bit tedious to convert all existing users to
pwm_apply_state_might_sleep().

Perhaps as a compromise we can add pwm_apply_state_might_sleep() and
make pwm_apply_state() a (deprecated) alias for that, so that existing
drivers can be converted one by one.

Eventually we would then end up with both pwm_apply_state_might_sleep()
and pwm_apply_state_atomic(), which has the nice side-effect of these
being unambiguous.

That doesn't get rid of the ambiguity of that _atomic() suffix, but I
can probably live with that one. It's used for this same meaning in
other contexts and if we add a _might_sleep() variant it becomes clearer
how the two are different.

Anyway, the bottom line is that I'd prefer the "atomic" field to be
renamed "might_sleep". It'd also be nice to add the new _might_sleep()
variant since you're already changing all of this anyway. No need to
mass-convert all the drivers to the _might_sleep() variant yet, though,
since we can have a transitional alias for that.

Of course feel free to give it a shot if you feel like it.

Thierry

--CWXLyOubpdFDIsRG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmUpY4gACgkQ3SOs138+
s6EcohAAmqR8BaUCEq4M2fULKVc3jM4fH11BgxQmWSUTG7VM/2njf82xVrCZypAT
jT3iU4TSfzfQVvLLE2tAgE2vT0655H13LWMF94t9TSyyxUjlxV/KzecUYaeoDMMj
ZoOrfTMzoqm0OVKTFr/PtP5hX7DLU8WKdT5CReNyR4sFL3Pz/uc3CqHnbS0vHHy3
mHVFB0TrbSWRkxDxPmvrXdLH6QfCRzq2MTcxMF9g4UtCahEJDsWhCG1s6aLwB/Qr
DOzVvOTZpzW017/15S4beJWUwwC4Publi+2dvLZ9xWkWXLfSqXqSJWtq4qxlCllN
By+99obtZC5u0xBS1adLGmSHsJsG09xBhncoMk34vy0XWwf+7mctDTA7HXpdl1KH
fYepF20ZPVdUI2ri0BBkYBonw2/ptEVgs14Foo2la3bVmZ8Z25ZNDkmAUCnIOtPo
v4lBVaOhX88pkuiTlzUOQ7h2fg0ERId8mu7nC3kctHnhN8vrTZ7Da4ebBGI6pGnE
g93KAF4yE//WQ9AMFv0tlpOuWoqCKhNZRmmyLrllEWlD5Wa0nsb9YL3FxB1Tbooh
4UJXGn9Kdq2gqR52qfyniJRDR8KsE8wWEy4nQwzjMDvl6mK6p294h6HY4QJr4DE5
unsbDnhtmjD946MFD1xtrb5MMmUcLnoSQcMjQQnzYDU3WLjLipk=
=lrij
-----END PGP SIGNATURE-----

--CWXLyOubpdFDIsRG--
