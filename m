Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D0397627AF
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 02:17:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230375AbjGZARy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 20:17:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbjGZARw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 20:17:52 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE2D1B6;
        Tue, 25 Jul 2023 17:17:50 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id d2e1a72fcca58-666edfc50deso293206b3a.0;
        Tue, 25 Jul 2023 17:17:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690330669; x=1690935469;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=j5s1WW7GBp5hZQUYvFU5iJnQ79RzOTTzDA0You2FrxI=;
        b=m3dA9UqpMGsh3BufRTfuATdCid3ZCUIOOHSY9SM9mjVZngSgv595qlwyOT/WIyyoOr
         XD8oW9CKnDvOoyOUeBtiWWKuAqIwDgH9hn4DfppdWl6To6WtMwQW7im0UELCnSJmlMpj
         IedI2Brkv7yoY5YDv28yciU9vimr6u1wY+6fj6jiCBH6f5vxXw0RAGxuw/WtkZ6JP5oI
         WRlRRM463jT8tcTDFD7bhredVNd0VeIx1+ROWcVsJhFlQAYmLcBF2gDVuSoUYHQ9uUoj
         fC0DogAareUscAFyKOnRDRRJHqlusfPdUmwGJCZoYGveQwdlDwT2xgkvOgUvy7ChFsAI
         vlrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690330669; x=1690935469;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j5s1WW7GBp5hZQUYvFU5iJnQ79RzOTTzDA0You2FrxI=;
        b=WiSO/NKwLFKLgU2tPYigK/rKpmnVjnxv/yZT85dCR+S8vXrPcoOOxir/H5rcwxsONd
         cW/fJoY8yaR+HqkZCjwgpr22xECKh8JV7rdbLzHfftKy/brgo+WdEfPfzj54k/XhwTCP
         WJl3GpPCNnfJeFDjvEDIqY6cPxdBUmWT3sGVs2VU4/6Av6PkFTKHPdtl6tIZ8d3/8maG
         PWP7cdrZCZi7XQ8JpIDXRL+xQ6L1OZTpBsMbkst1ayQHK+C5h83ERMtmCHf7UuVvF7/u
         aSFhgRE9obOnanf9zyRFv5RNxyzfjMmYUG3iGkELsBi7FZenAHnHEqSBjZ7spFs71gDy
         qqJg==
X-Gm-Message-State: ABy/qLYyM6ZqshKSqxrYT2mGMY7GBufP78D4Ye7Wz1BVgiB28pfbPRfP
        bNRALG0QGJGo7Wm+YtRRBrs=
X-Google-Smtp-Source: APBJJlEzgNq1qcmEyjAC3bX3gMoZIwcMY2lamqr8ZXmSQJCk1+FSEIYiAIbDTcyHCWkc9v5RLHLZwQ==
X-Received: by 2002:a05:6a20:7347:b0:12f:d350:8a12 with SMTP id v7-20020a056a20734700b0012fd3508a12mr761426pzc.21.1690330669279;
        Tue, 25 Jul 2023 17:17:49 -0700 (PDT)
Received: from debian.me ([103.131.18.64])
        by smtp.gmail.com with ESMTPSA id s3-20020a62e703000000b00686bf824b3bsm243837pfh.136.2023.07.25.17.17.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jul 2023 17:17:48 -0700 (PDT)
Received: by debian.me (Postfix, from userid 1000)
        id C64578061A54; Wed, 26 Jul 2023 07:17:44 +0700 (WIB)
Date:   Wed, 26 Jul 2023 07:17:43 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Greg KH <gregkh@linuxfoundation.org>, wuyonggang001@208suo.com
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] usb: gadget: f_serial: Modify sizeof format and Variable
 type
Message-ID: <ZMBmJ/n1/Q1/86Mx@debian.me>
References: <20230710030457.18806-1-zhanglibing@cdjrlc.com>
 <2e20d91d90ef6ba7557a465d67634db5@208suo.com>
 <2023072534-frosting-phrasing-e2be@gregkh>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ciq6RU9qO3srzCMa"
Content-Disposition: inline
In-Reply-To: <2023072534-frosting-phrasing-e2be@gregkh>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ciq6RU9qO3srzCMa
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 25, 2023 at 05:34:59PM +0200, Greg KH wrote:
> You are receiving this message because of the following common error(s)
> as indicated below:
>=20
> - Your patch is malformed (tabs converted to spaces, linewrapped, etc.)
>   and can not be applied.  Please read the file,
>   Documentation/process/email-clients.rst in order to fix this.

Hi Greg,

208suo.com people still ignore review comments which ask them to change
their tooling. I guess they have issues on their mail infra that ML
traffic doesn't get through their inbox, or they deliberately ignore
the review. The EXACT same situation happened last year with cdjrlc.com
people. In fact, these latter developers now use the same infra and tooling
as 208suo.com (and the former people also sometimes forward patches from
the latter).

Not to mention that they keep doing `checkpatch -f` fixes despite Steven's
warning [1].

Thanks.

[1]: https://lore.kernel.org/all/20230720134501.01f9f1de@gandalf.local.home/

--=20
An old man doll... just what I always wanted! - Clara

--ciq6RU9qO3srzCMa
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZMBmIgAKCRD2uYlJVVFO
oxF+APwK12EmvWBIHy2wAnuXSVoxEbwnsQ/v5GCZTuEfXH1y9QD+LVSAfe7Ab91Y
/lv+bnggjdqogm9GG3kMvfJM1L1Fmgo=
=jZ3/
-----END PGP SIGNATURE-----

--ciq6RU9qO3srzCMa--
