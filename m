Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EA997D19CB
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Oct 2023 02:05:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231837AbjJUAFH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Oct 2023 20:05:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229614AbjJUAFF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Oct 2023 20:05:05 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF3DA19E;
        Fri, 20 Oct 2023 17:05:03 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id d9443c01a7336-1c9fa869a63so10502905ad.0;
        Fri, 20 Oct 2023 17:05:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697846703; x=1698451503; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ga1FOoC9Yc7B4YlK6lQlPnzJO9llnYvW5Xv3ejARBD4=;
        b=i1XycS5ZF9BAztqXtGseYLveXeHonrfF2Rfhgz0mbOVzSc8yLGpqCDHLvQSZ+URVma
         dkXXxPByfUI739+igbzJWIiTBFru3h+lp1yFzWeM4eAcboXXeA5m7ypQPKhWiuDzebIt
         scqlxY4rfd1YbGuJnTKcPR8glLQJPOkt6qVR0Puonb9y3S4FMjJnYEfxB9w4xGdAruRo
         Vn5+or07JsONHbAsTQbvSLsusi/zFpNSrb8nP5kkhnqgVhqLb22NzCcRFYxr5awoHAc7
         6UgwquspRIDhNMeBPVhM6WaUQtKHlxn1SU1sUuQPftmz29333dnd64baT3WVxdRbuJUk
         V26g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697846703; x=1698451503;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ga1FOoC9Yc7B4YlK6lQlPnzJO9llnYvW5Xv3ejARBD4=;
        b=wiZqJWzfeYmZttvMNq13kDeHJyK/yHsDrC0UrRjiVm1cn3UCC83opP3AHD5sMvy3Sj
         3v2MkoCEKTYhhR9DGiHl2n2zMWK6NGxBmawbPXhtowgRwOT92/UF2J92gJmKinvit+4A
         M/fwcmmNSe3GfCQqh1aD469aRh8qPgaZWxkSOFvBWXG62/Edvilaq2Q74Fq5C1EujLfJ
         fytAOFejTL810rr6daOGrkaMHFlYSR41nQiNMBaoXdtvXszOSf3e/sMeglr48iOuMYId
         x20iIU6VlPXfPVUqNMSZEptA8knWI1SieXXTqiIuF4bIZg3exeMkkg0WBNBKbX/B2qyT
         xydw==
X-Gm-Message-State: AOJu0YxUGAYhFtbb/EwSaDXGTYzF/JEk6txslSna/sJJZ+YUCjMrZzIB
        fSUvuLN+JjD5Ez8jn39Ld/c=
X-Google-Smtp-Source: AGHT+IFNs7eNOiJsHL4J5Ff8SIc7smyimXcY7wYPzXuPknnX62oTKhZttze8Tf8rDrRzlzsbIFOVRg==
X-Received: by 2002:a17:902:f542:b0:1ca:8e43:765a with SMTP id h2-20020a170902f54200b001ca8e43765amr3795803plf.9.1697846703198;
        Fri, 20 Oct 2023 17:05:03 -0700 (PDT)
Received: from debian.me ([103.131.18.64])
        by smtp.gmail.com with ESMTPSA id jf11-20020a170903268b00b001c1f161949fsm2086367plb.96.2023.10.20.17.05.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Oct 2023 17:05:02 -0700 (PDT)
Received: by debian.me (Postfix, from userid 1000)
        id A19338925D93; Sat, 21 Oct 2023 07:04:59 +0700 (WIB)
Date:   Sat, 21 Oct 2023 07:04:59 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Jakub Kicinski <kuba@kernel.org>,
        Johannes Berg <johannes@sipsolutions.net>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Networking <netdev@vger.kernel.org>,
        Loic Poulain <loic.poulain@linaro.org>,
        Sergey Ryazanov <ryazanov.s.a@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
        Mat Martineau <martineau@kernel.org>,
        Nicolas Schier <nicolas@fjasle.eu>,
        "Srivatsa S. Bhat (VMware)" <srivatsa@csail.mit.edu>,
        Alan Stern <stern@rowland.harvard.edu>,
        Jesper Juhl <jesperjuhl76@gmail.com>
Subject: Re: [PATCH net 2/2] MAINTAINERS: Remove linuxwwan@intel.com mailing
 list
Message-ID: <ZTMVq21v9TXQW0Ad@debian.me>
References: <20231013014010.18338-1-bagasdotme@gmail.com>
 <20231013014010.18338-3-bagasdotme@gmail.com>
 <20231013174916.40707d19@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="veM77kCN94IQTSM1"
Content-Disposition: inline
In-Reply-To: <20231013174916.40707d19@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--veM77kCN94IQTSM1
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 13, 2023 at 05:49:16PM -0700, Jakub Kicinski wrote:
> On Fri, 13 Oct 2023 08:40:09 +0700 Bagas Sanjaya wrote:
> > Messages submitted to the ML bounce (address not found error). In
> > fact, the ML was mistagged as person maintainer instead of mailing
> > list.
>=20
> Johannes, no chance we can get someone to help with IOSM?

There's no response from Johannes for now, so I'm OK with orphaning IOSM.

--=20
An old man doll... just what I always wanted! - Clara

--veM77kCN94IQTSM1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZTMVpQAKCRD2uYlJVVFO
oypJAQC9/08DNjygKhluL7AwrLrq3R4VR/bfrKSX8F12o2Qj6gEArvPnHVTiixyz
XG+NYwRa8Eo7TxcSkgPmgTxpghZO5AU=
=999C
-----END PGP SIGNATURE-----

--veM77kCN94IQTSM1--
