Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAD587A43B2
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Sep 2023 09:57:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240459AbjIRH5U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 03:57:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240568AbjIRH4v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 03:56:51 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17ACBE6E;
        Mon, 18 Sep 2023 00:56:31 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id d2e1a72fcca58-68fb898ab3bso3144028b3a.3;
        Mon, 18 Sep 2023 00:56:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695023780; x=1695628580; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Xqxu9XqJgrwv9dQeN2TLGjQoXj5OVfZLMHNwc4EUVI4=;
        b=fri4usmzfsSAKW2/JSUKtvomJJfQ1I8O+rJMeaQ2Eu3DtFOTsMHXrScAyyzOWY5bdK
         3USxc32fhvX09jfbBmp3PTUA52kmq/xwjthFGxwx3JoloS2AsVSxR7PzeJ802QECmeR1
         g6Ae/uwpFyiTbn4rVzRD9B9VodIXg6SNhJm6x+iYpSpbbbM+nJoJikJFfF8u46+GUAZQ
         C/QGLBvSMc0hSEbj9bRe9SIBwp2p6NI6YxQxr5EIMXErnDFchcSJa5v5crTLvMcIDFQb
         2mRs3P9Pd/ST/gkrT2fu1Pb10y5uJXo+CFJOGE/GXbOoA6BUw0aDCxBcXmp5w4SeEXqs
         bCiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695023780; x=1695628580;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Xqxu9XqJgrwv9dQeN2TLGjQoXj5OVfZLMHNwc4EUVI4=;
        b=Hp7Tt+HNejyXvR1nNp35mrs7+YuwxqgeuTB9/YfZnixqBJpQpBRGVbFh95zDZnjwXH
         4x3s5mI9f9kh5cRzYKVEmTst3HwDiXz1EppZ8kb7bb/iQEFaeNISAnZQs61AwKDeNa4V
         mfWxhFZjA1YzEvZzCa+eGJLvIxjzG7Vlw5TxsT3WeN4JAVcvGGFUZMyyKLk2WW4GMro8
         2K2eMhWLqOMflX5eCMHSZ/N/wfVnWn+vUaeBG5GUzRfvmn5lxBFPbiko5dA3yOiSvlpg
         Yy88pGyNy72H16tDh+LmGDKwI05v6jbqJV1zCwFyAGLNXDGqlTI/xKu8ad4kSbNNhHSj
         OMlg==
X-Gm-Message-State: AOJu0Yxx4ZYEmCieA8tz7/RDZ4DNrglxOiwtF/wzxXRbYmBBfpXkBHjY
        jY8+oxRssLTHYA3VoTy4eNc=
X-Google-Smtp-Source: AGHT+IH/qxcDfX7UFoxk/ogaqzsqV1A4Qsvo/qqLJzoiAwIwKRGOhAmWzzeFeLJSkwIVnH5SmhaxVA==
X-Received: by 2002:a05:6a00:181c:b0:68e:351b:15b8 with SMTP id y28-20020a056a00181c00b0068e351b15b8mr8287951pfa.12.1695023779938;
        Mon, 18 Sep 2023 00:56:19 -0700 (PDT)
Received: from debian.me ([103.124.138.83])
        by smtp.gmail.com with ESMTPSA id k10-20020a637b4a000000b00573f958f6a3sm6503830pgn.5.2023.09.18.00.56.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Sep 2023 00:56:19 -0700 (PDT)
Received: by debian.me (Postfix, from userid 1000)
        id 361B2978D56F; Mon, 18 Sep 2023 14:56:17 +0700 (WIB)
Date:   Mon, 18 Sep 2023 14:56:16 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Niklas Cassel <Niklas.Cassel@wdc.com>
Cc:     "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Damien Le Moal <dlemoal@kernel.org>,
        Song Liu <song@kernel.org>, Timo Gurr <timo.gurr@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Regressions <regressions@lists.linux.dev>,
        Linux SCSI <linux-scsi@vger.kernel.org>,
        Linux IDE and libata <linux-ide@vger.kernel.org>,
        Linux RAID <linux-raid@vger.kernel.org>
Subject: Re: Fwd: Marvell RAID Controller issues since 6.5.x
Message-ID: <ZQgCoJ17UioOtdOJ@debian.me>
References: <224f10a4-7a6a-48bb-88be-491faf8ecff7@gmail.com>
 <ZQf9mh3v5qfN5Tm0@x1-carbon>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="kc+WLW1HFUSqWTkE"
Content-Disposition: inline
In-Reply-To: <ZQf9mh3v5qfN5Tm0@x1-carbon>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--kc+WLW1HFUSqWTkE
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 18, 2023 at 07:34:50AM +0000, Niklas Cassel wrote:
> On Mon, Sep 18, 2023 at 07:18:28AM +0700, Bagas Sanjaya wrote:
> > Hi,
> >=20
> > I notice a regression report on Bugzilla [1]. Quoting from it:
> >=20
> > Anyway, I'm adding this regression to be tracked by regzbot:
> >=20
> > #regzbot introduced: v6.4..v6.5 https://bugzilla.kernel.org/show_bug.cg=
i?id=3D217920
> > #regzbot title: UDMA configured spam on Marvell RAID controller
> >=20
> > Thanks.
> >=20
> > [1]: https://bugzilla.kernel.org/show_bug.cgi?id=3D217920
>=20
> Hello Bagas,
>=20
> This is a duplicate of:
> https://bugzilla.kernel.org/show_bug.cgi?id=3D217902
>=20
> Problem is solved by:
> https://lore.kernel.org/linux-scsi/20230915022034.678121-1-dlemoal@kernel=
=2Eorg/
>=20
>=20

I have asked the reporter on Bugzilla to check the fix above. When he
reports back successfully, I'll mark this report as fixed.

Thanks.

--=20
An old man doll... just what I always wanted! - Clara

--kc+WLW1HFUSqWTkE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZQgCoAAKCRD2uYlJVVFO
o55MAP9OtvCLRaHNTrxGJhOPpui1xIREaJ0wkOwmLE+BjudivQD9ETPSmeIq6maO
Zk4SipJureLWv7qF9uJiIx2qzKDqbQg=
=w8vJ
-----END PGP SIGNATURE-----

--kc+WLW1HFUSqWTkE--
