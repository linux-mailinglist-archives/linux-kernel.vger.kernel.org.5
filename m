Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8F9477C4D4
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 03:00:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233795AbjHOA7r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 20:59:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233794AbjHOA7k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 20:59:40 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A9099C
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 17:59:40 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id d2e1a72fcca58-687ca37628eso4705133b3a.1
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 17:59:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692061180; x=1692665980;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZT+RCWolURR+UFTkO97wfxiLB5DQ+RvYBf0dwd1JNoY=;
        b=rkYK/lTmY9xyg5SXG1+BLIusOxIpgZQMi1qwrpdOVV9F0/6szSE2JWGPd9LBctU6ww
         sVWxZdG1g1ugnrq7LzN1ZXu0xF2LZEdkAit/x2W/w70CZfM7lMlESGvlQWgXYG/FGqxT
         Mdx4CVPieF7fHQGeNXEbfNYOpbQUOK/WVySX2+V4NZgVpyJTeqA1h7/CwjBJCvoD4c11
         R+tHIF9myke4NwCn+HlMVeoAgrT/Ff6hCfCaPN7UoWuXxxmIaQzMt7aw4d3A84oZuwnx
         ZQf/rVI/+zrocv6d85mnFJfNeM6HflPNCEwA2nVvwhFKv9M3Qkmc9MTws1MDkyPZiIIC
         VVNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692061180; x=1692665980;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZT+RCWolURR+UFTkO97wfxiLB5DQ+RvYBf0dwd1JNoY=;
        b=a/lsrvwhnmjGWlLyaUh86PN0atN1oaumzRsOKtcjVdZTThTVU3yKys2+BYIp2BgzmI
         8xLemNRAfeCXWNLoGt6JeVlSfUDMpvaKVsJDhV2ZWj02SHMx+dm1Mhq2V2l9DuLnifds
         fMHDZ3XfZ3MeLxIFUncJhzt2M1OcSPLnJsbzzCdgG8/n3DzYZdi9O4Ef98iLOoDOKpzk
         A6LUNsnoD/aDbHXACS/aFFsklTiz4L63e0Evc+mBvTBLCF5Xb7exzfcbGvwxLc5UIowM
         CqL2g8/QjvXjhrv6sSwMcj95H/ouZf/QlFF5xT7gmQModmOeBk18EAs1x87cZTFq9+JL
         bxvw==
X-Gm-Message-State: AOJu0YyVELuw9eyiEOPG0442TFVpoud7LtlCc1QtJQNueoHoHhSkuvyA
        uwimtWY4aNKwLNRoXTR+CIBT/Vi4/cg=
X-Google-Smtp-Source: AGHT+IGKp6xnNCOtv8mnYQcD5jOjPzvihHkuVphYIiAl02ZLtyFW3yRs8Sju0LW+T9H8AJaok7NHYg==
X-Received: by 2002:a05:6a20:8e15:b0:133:5f6a:fb6 with SMTP id y21-20020a056a208e1500b001335f6a0fb6mr16749973pzj.1.1692061179666;
        Mon, 14 Aug 2023 17:59:39 -0700 (PDT)
Received: from debian.me ([103.124.138.83])
        by smtp.gmail.com with ESMTPSA id j12-20020aa783cc000000b0064398fe3451sm8459093pfn.217.2023.08.14.17.59.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Aug 2023 17:59:39 -0700 (PDT)
Received: by debian.me (Postfix, from userid 1000)
        id 81E5C81A2F0C; Tue, 15 Aug 2023 07:59:36 +0700 (WIB)
Date:   Tue, 15 Aug 2023 07:59:35 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Joseph Vance Reilly <Joseph.Reilly@uga.edu>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: AF_XDP bug
Message-ID: <ZNrN95kPtAiwhGO0@debian.me>
References: <CH2PR02MB701415DEC996810D20D2EB60F117A@CH2PR02MB7014.namprd02.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="9u7jwr+vSvuPCleY"
Content-Disposition: inline
In-Reply-To: <CH2PR02MB701415DEC996810D20D2EB60F117A@CH2PR02MB7014.namprd02.prod.outlook.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--9u7jwr+vSvuPCleY
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 14, 2023 at 12:45:57PM +0000, Joseph Vance Reilly wrote:
> Hello,
>=20
> My name is Joseph Reilly and I recently created a bug report on the bugzi=
lla page for the linux kernel. This is a bug that causes an IO_PAGEFAULT wh=
en receiving high amounts=C2=A0of traffic on an interface running an XDP pr=
ogram. This problem has been observed with a Mellanox networking card and A=
MD CPU but may also be present in more configurations. The bugzilla report =
is here:=C2=A0https://bugzilla.kernel.org/show_bug.cgi?id=3D217712
>=20
> For reference, the bug is #217712 in the networking product listed under =
the component "other"
>=20

If you'd like to forward your BZ report to the mailing lists:

* Quote the whole starting thread and on the forward mail, add pointer to
  your attached files on BZ
* Add relevant subsystems and maintainers to recipient list. See MAINTAINERS
  on the root of kernel tree or run `scripts/get_maintainer.pl` script.
  This is important; otherwise you won't get any helpful responses.

I had forwarded your report on [1] as an example.

Thanks.

[1]: https://lore.kernel.org/bpf/e75b57d9-9093-0a22-d53d-e510fd422279@gmail=
=2Ecom/

--=20
An old man doll... just what I always wanted! - Clara

--9u7jwr+vSvuPCleY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZNrN8gAKCRD2uYlJVVFO
o7fwAQDCEmvlG1mS/u2G/Pn7/y+7cTsn0h5vrVzT4dHHa9ALYQD+LZhKL4o0b4Su
/r7y42g+ltSjsglw0OuPKpQDHo76LgQ=
=Cevz
-----END PGP SIGNATURE-----

--9u7jwr+vSvuPCleY--
