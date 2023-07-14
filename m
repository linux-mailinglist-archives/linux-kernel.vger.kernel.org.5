Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13821753968
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 13:19:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235442AbjGNLT0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 07:19:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234954AbjGNLTX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 07:19:23 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13DBE30C8
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jul 2023 04:19:22 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id d9443c01a7336-1b8a44ee159so10673095ad.3
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jul 2023 04:19:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689333561; x=1691925561;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=nUTuhMaDrSiRcPnXk8P8ZOacIizK0ZULRB/535ud0vE=;
        b=ZUYCSWEkO2ru97nyEgNoTSPwlSHcSGPPfjDhuLemmy+Ztw0FbKmKRMJ29H0taW3eNq
         vg7im92XoJ3u7vi47g3v1WlJ5aP/Dm1U/62KCUPFpW7N8H89dPOd0K3dYqxyfAgqJQvH
         vql6i2TnHteJe8Pap2a7Ok+3yiulZcPf1FZ5DCIB76mEeiUw6lr9GxjPrKWmE1ZDLOAg
         qVDTgf+HyQM2SQyZ3aEh95JukYs/THN8gcr+w3eh3NZbXgS6s62820Y1jdoLTOmH7pqf
         FghBwwcWAl/TNApAhkre2Z2n+pZmKNYSVlJem4oHdUeV4Ezb247S+1nxwdLuR48RHUMR
         8pLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689333561; x=1691925561;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nUTuhMaDrSiRcPnXk8P8ZOacIizK0ZULRB/535ud0vE=;
        b=i66cbBDfdbyQfut5OElUe0jOroBHCUvdBzXATPekb7tgFRTfwAdVylUAV6M3LAf8N8
         Dhg6MKOYaR2dmAiCXbcIEj3ip+qba4CqLiH1kJmDER2LV3+hh4fOK3bYbGc29dPCKwAJ
         WlqA1t1mMJpUL23CVZAPZld985wcJGH7sCiLHZ3iG72VLQKGjOqxBEQIl0w8gbxbA3ES
         4bzDSYCcG+aZ0WtkTOskudwRs49LeWsCM68A+QiLAdUkV5U8mbUXyOgTxlozH4xS8ddU
         F0CJenpLWxN8BQVAwkrkgU7Wxi4iZS477K/6oHID0fs20N1HtZKa9zMSVnb588K4Qj3N
         8mzA==
X-Gm-Message-State: ABy/qLbDfcHN3npUg8GYvLHbmHeHwU5PD7hLge4QK00lYa0aDxICg29C
        ChAjHtHHfO6TQWXVGMtOYE++RA==
X-Google-Smtp-Source: APBJJlGxhNZibj2NW5DcS0sSNj5usvsOzyhoPClMGObRmr68VhlxTZlN02DT2GT6lj9dYBuJv5T0ew==
X-Received: by 2002:a17:902:6b44:b0:1b8:b2a2:e47d with SMTP id g4-20020a1709026b4400b001b8b2a2e47dmr3208355plt.46.1689333561313;
        Fri, 14 Jul 2023 04:19:21 -0700 (PDT)
Received: from fedora (61-114-134-192.ppp.bbiq.jp. [61.114.134.192])
        by smtp.gmail.com with ESMTPSA id y24-20020a1709029b9800b001ac5896e96esm7499012plp.207.2023.07.14.04.19.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Jul 2023 04:19:20 -0700 (PDT)
Date:   Fri, 14 Jul 2023 07:19:15 -0400
From:   William Breathitt Gray <william.gray@linaro.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Alexander Potapenko <glider@google.com>, catalin.marinas@arm.com,
        will@kernel.org, pcc@google.com, andreyknvl@gmail.com,
        linux@rasmusvillemoes.dk, yury.norov@gmail.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        eugenis@google.com
Subject: Re: [v2 1/5] lib/bitmap: add bitmap_{set,get}_value_unaligned()
Message-ID: <ZLEvM1s65L1k0PTx@fedora>
References: <20230713125706.2884502-1-glider@google.com>
 <20230713125706.2884502-2-glider@google.com>
 <ZLA0TwHZOgAGCgKX@smile.fi.intel.com>
 <CAG_fn=WsPC_qMZfbVQHbXq_cGXP4ZfYkyGyJPzaAKSqurxoibw@mail.gmail.com>
 <ZLEBgGSsmOPs4Zu5@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="QqltRdriNPO1hJJp"
Content-Disposition: inline
In-Reply-To: <ZLEBgGSsmOPs4Zu5@smile.fi.intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--QqltRdriNPO1hJJp
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 14, 2023 at 11:04:16AM +0300, Andy Shevchenko wrote:
> On Thu, Jul 13, 2023 at 08:05:34PM +0200, Alexander Potapenko wrote:
> > On Thu, Jul 13, 2023 at 7:29=E2=80=AFPM Andy Shevchenko
> > <andriy.shevchenko@linux.intel.com> wrote:
> > >
> > > +Cc: William
> > >
> > > On Thu, Jul 13, 2023 at 02:57:01PM +0200, Alexander Potapenko wrote:
> > > > The two new functions allow setting/getting values of length up to
> > > > BITS_PER_LONG bits at arbitrary position in the bitmap.
> > >
> > > A couple of years (?) ago it was a series to achieve something like t=
his with
> > > better (?) code. Why not resurrect that one?
> > >
> > > https://www.mail-archive.com/linux-kernel@vger.kernel.org/msg2195426.=
html
> >=20
> > It looks more compact thanks to GENMASK, I can cook something based on
> > the proposed bitmap_{set,get}_value (and change the names if you
> > prefer the shorter ones).
> > But I'd better avoid pulling in the rest of that series without a stron=
g need.
>=20
> William, what do you think on this?
>=20
> I'm personally prefer William's version as not only it was published first
> it was carefully designed and got a lot of review already. We just hadn't=
 had
> the user for it that time.
>=20
> --=20
> With Best Regards,
> Andy Shevchenko

Yes, that version went through several revisions so it's been well
tested and known to work -- as you pointed out it just lacked the users
to warrant merging it into the tree. If it statisfies the use-case
required here now, then I think we should it pick it up rather than
reinvent the solution again.

Also, we probably don't need the "clump" code in there, so perhaps
splitting it out to just the bitmap_{set,get}_value relevant code is
fine.

William Breathitt Gray

--QqltRdriNPO1hJJp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQSNN83d4NIlKPjon7a1SFbKvhIjKwUCZLEvMwAKCRC1SFbKvhIj
K1C/AP9Y2Gn10YIykdJfEqxpdfzFksGZcfpQYKpZC6UNgLrQQQEAzncJcIE6MfAu
PxdEwp3fRjicZb83Ofwn5u4FXRebeQ8=
=6ng2
-----END PGP SIGNATURE-----

--QqltRdriNPO1hJJp--
