Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E285E7D22E2
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Oct 2023 13:23:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231552AbjJVLXA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Oct 2023 07:23:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbjJVLW6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Oct 2023 07:22:58 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56C10E5
        for <linux-kernel@vger.kernel.org>; Sun, 22 Oct 2023 04:22:53 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id 41be03b00d2f7-578b4997decso1717303a12.0
        for <linux-kernel@vger.kernel.org>; Sun, 22 Oct 2023 04:22:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697973773; x=1698578573; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ulBXB4g0u/4o36czfwsbZfHHbnOlys/12sePaGgmkm0=;
        b=RTOZ6CdAqRDfR+hv+br1L+veusPCt753NJq+h5j14XdIt9awNoXGahL1tGR4sHge/6
         7s8EVokzdBeOxg6GZUxUxyV+w2xALaq/bcf9I6qZsZqLcjsZi9QnGPCSy6WUaz0ZW7O6
         R7NlIQlGxfDo2Qdy8HorJEyIBN8TCBJQT0SLUAgABepbPwtYZ21QgxUfODIUHBJ2evj9
         /oHhDU/ukohY23cXwa1lLAMnPaLLhGDVaBxW2b+HGF/zdS7ASWWO+c5IvuxGTKY9PMTI
         AMLEQ5kvhtslCIkSFU9PMPt3t7C4wvvgKzKzM0ETzRp4IXdCC58AtpD3f7pWFGrYVROe
         wN+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697973773; x=1698578573;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ulBXB4g0u/4o36czfwsbZfHHbnOlys/12sePaGgmkm0=;
        b=Vqb9nLFrbE9qUjdqaF1NutmeNUB1P7oF5VXnX5GBEjUfjdQDhXebAd5/ic8014s/7q
         kJO8eVLjxA2vDmogh34zvPfoEdF1+5NDB+lnSztDzi6A/rESoQDSs7oKgLr61uTaCawD
         Q4+qnYZegEZmJ8A23YsZQODHZD0SW6G/i4hA6/+sK+g3gguX9VHQTqHYRzK+v7H8BGI3
         6HXFJatqxjum+SurGvczUceUQaaatAQbMX+l/1SyLLihke59CsWFkarfonCBrNAGfTrr
         IF93EPH1ZvQUoNb/xItENXNnLvTiV9WeAhGvfvRwhERvZjTRuC8rVN6Fj+L5F0PszL+A
         W16w==
X-Gm-Message-State: AOJu0Yx+q1uK/ETqpgh+O3o1UFe5h38CHVrn113Ut6kblYLmHaLIH1ch
        QRGesPOpILK0ssPXwgjNKiG6b27eq1k=
X-Google-Smtp-Source: AGHT+IFsi5p5RkQMp/QAh/9jJFCqQWzUONaGe15JF+YP2DKoobowM2vTvGiqa9ecIRLvjzWMON+MHw==
X-Received: by 2002:a17:90b:3c0d:b0:27d:29f6:79e0 with SMTP id pb13-20020a17090b3c0d00b0027d29f679e0mr6770611pjb.17.1697973772700;
        Sun, 22 Oct 2023 04:22:52 -0700 (PDT)
Received: from debian.me ([103.131.18.64])
        by smtp.gmail.com with ESMTPSA id ik21-20020a170902ab1500b001c73f3a9b88sm4437069plb.110.2023.10.22.04.22.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Oct 2023 04:22:52 -0700 (PDT)
Received: by debian.me (Postfix, from userid 1000)
        id C680981B3D42; Sun, 22 Oct 2023 18:22:49 +0700 (WIB)
Date:   Sun, 22 Oct 2023 18:22:49 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     gmssixty gmssixty <gmssixty@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: How can I get/check all the kernel boot messages?
Message-ID: <ZTUGCWr0EgAf4I4C@debian.me>
References: <CAOx-CDV52DRTmrZ7WEYxngCTpO-X7-H4PGXS86xC9vDJU9U94A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="PRKyf5t0/Z+jPHC+"
Content-Disposition: inline
In-Reply-To: <CAOx-CDV52DRTmrZ7WEYxngCTpO-X7-H4PGXS86xC9vDJU9U94A@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--PRKyf5t0/Z+jPHC+
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 22, 2023 at 02:48:37PM +0600, gmssixty gmssixty wrote:
> How can I get/check all the kernel boot messages? After booting, I can
> not do SHIFT+PAGEUP to scroll up to see messages. Also, how can I know
> there is no problem with kernel booting?

Run dmesg as root.

--=20
An old man doll... just what I always wanted! - Clara

--PRKyf5t0/Z+jPHC+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZTUGBQAKCRD2uYlJVVFO
oypvAP9XFYle/Y2/0/s8CwAK65CAXUAz3YS+nQ+rTzCiIbU1wQEAw5XvZeZBhbzz
zZcnEnKE+l2no5Xs9cRswyoq69Xm9AU=
=Qe/m
-----END PGP SIGNATURE-----

--PRKyf5t0/Z+jPHC+--
