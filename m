Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77C597A6FCE
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 02:17:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230510AbjITARp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 20:17:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230010AbjITARn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 20:17:43 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFF8CAF;
        Tue, 19 Sep 2023 17:17:36 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id d2e1a72fcca58-690bd8f89baso1553804b3a.2;
        Tue, 19 Sep 2023 17:17:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695169056; x=1695773856; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=5GxdpHi3q0CHa12EPny+xqE489Qgh1zELK2uRy2oNZ4=;
        b=kX2JAo3vHo80oj2FSmYCTv/mzmvD1X8NjGNAGgyWtuVb8LTw2XUGvcUGiwOQR9Tx0Y
         wk+9p7EbPF/C1LA2aW4nLZDjORWz8vdhxqB/yMCv33asBsnnnP+VPwwKa4cES6WntnxO
         2oLMbfnOj+/LPhWpQXaB9cP0tzE4BDmZ2HU4a8k+0e7rsIGdGVGlQVFac8aMAkch7+9J
         59mCgTguKBvBzCdv6ix1t7K57s+hcin5mVYF0Fp6itVXQPYvoGQsWKRm6Kn3b1yFuPiN
         7mmWJo4Z7lfZCKKDQPXkpdda8iVZSB1yyqARl3JeHNXhXapznB5Wn2S320IqwAGD9keT
         vbwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695169056; x=1695773856;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5GxdpHi3q0CHa12EPny+xqE489Qgh1zELK2uRy2oNZ4=;
        b=KooXdkpJMe0Swp9qiGM078T1Wh3YumWgTqQVQT9MKQ0ZRYoTyk7BG3TdCuEVQQWPIx
         QqoF9MOhiTXC/HaMti6EHZ/s5/PQ1ChwAfq7tcZ+cC7ex+D9Z2FCj+ed3cVv41mN6cQf
         fTEQAP2w7dyWL05ypdC6iXlfOL9I5ECrKlLMtAfWzUFUSVmZjICkSHvahdlMU8wcsWnF
         +R726zmhH0T7MELKZAikb1PXbU4urqyfoOh27skBWOYuEmGhyaXgUoPeXe42oDgWFOZF
         ai0XzUcx6Pmzgs3HJurM+MvtaWwBaKUUHCV3Ryniy1GsGwwUFGdKXbFIS+u3XlT/Bwms
         QiAw==
X-Gm-Message-State: AOJu0Yw0l6/yQx+Fbxd3eNeFBLQlRYAHwlDbJXwcPZEPYP1mZ+yArCDv
        B9qkoQk3o7ScLFE7l4HJCy4=
X-Google-Smtp-Source: AGHT+IGH8hEfdOhQEhyWIhoiv+3C1v4+rACphz7fI6edJm1RgY/m7G23pjshzuaWIBz4ZKb4jorJXA==
X-Received: by 2002:a05:6a00:2389:b0:68b:fb93:5b4e with SMTP id f9-20020a056a00238900b0068bfb935b4emr1330871pfc.26.1695169056076;
        Tue, 19 Sep 2023 17:17:36 -0700 (PDT)
Received: from debian.me ([103.124.138.83])
        by smtp.gmail.com with ESMTPSA id y4-20020a63ad44000000b005777a911342sm2571677pgo.59.2023.09.19.17.17.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Sep 2023 17:17:35 -0700 (PDT)
Received: by debian.me (Postfix, from userid 1000)
        id 4017281A82C8; Wed, 20 Sep 2023 07:17:32 +0700 (WIB)
Date:   Wed, 20 Sep 2023 07:17:31 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Charles Han <hanchunchao@inspur.com>, <corbet@lwn.net>,
        <djwong@kernel.org>, <dchinner@redhat.com>,
        <allison.henderson@oracle.com>, <bhelgaas@google.com>
Cc:     <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Documentation: xfs: Remove repeated word in comments
Message-ID: <ZQo6G5Z2v1Tk6ShQ@debian.me>
References: <20230918071905.296081-1-hanchunchao@inspur.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="kduWLGSWSb2kmx57"
Content-Disposition: inline
In-Reply-To: <20230918071905.296081-1-hanchunchao@inspur.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--kduWLGSWSb2kmx57
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 18, 2023 at 03:19:05PM +0800, Charles Han wrote:
> diff --git a/Documentation/filesystems/xfs-online-fsck-design.rst b/Docum=
entation/filesystems/xfs-online-fsck-design.rst
> index 1625d1131093..a0678101a7d0 100644
> --- a/Documentation/filesystems/xfs-online-fsck-design.rst
> +++ b/Documentation/filesystems/xfs-online-fsck-design.rst
> @@ -1585,7 +1585,7 @@ The transaction sequence looks like this:
>  2. The second transaction contains a physical update to the free space b=
trees
>     of AG 3 to release the former BMBT block and a second physical update=
 to the
>     free space btrees of AG 7 to release the unmapped file space.
> -   Observe that the the physical updates are resequenced in the correct =
order
> +   Observe that the physical updates are resequenced in the correct order
>     when possible.
>     Attached to the transaction is a an extent free done (EFD) log item.
>     The EFD contains a pointer to the EFI logged in transaction #1 so tha=
t log

I feel guilty here. Only considering the diff,

Reviewed-by: Bagas Sanjaya <bagasdotme@gmail.com>

Not sure if jon pick this or v2, though.

Sorry for inconvenience.

--=20
An old man doll... just what I always wanted! - Clara

--kduWLGSWSb2kmx57
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZQo6FAAKCRD2uYlJVVFO
o2jXAQDvbVwFBbhBP6n5B+AS5f2BFQ4jllPxTMyuSN+++PhfUAD/YNgagSNZbSoE
KJhXB/XMmdMhcLvXPW3T2I7oLiEl3AQ=
=j0q+
-----END PGP SIGNATURE-----

--kduWLGSWSb2kmx57--
