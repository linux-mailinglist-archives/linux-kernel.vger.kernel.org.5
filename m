Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6849879967A
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Sep 2023 07:37:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244815AbjIIFh3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Sep 2023 01:37:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229704AbjIIFh2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Sep 2023 01:37:28 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 753B2FE
        for <linux-kernel@vger.kernel.org>; Fri,  8 Sep 2023 22:37:25 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id d2e1a72fcca58-68a3e271491so2170840b3a.0
        for <linux-kernel@vger.kernel.org>; Fri, 08 Sep 2023 22:37:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694237845; x=1694842645; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=bFQ0t0uD6xgDoywgg3aN4cVqH93hmn9yTMWxAqceJW8=;
        b=Hh9ylbtZlTGVPBMuoseUQfHXiUbfZxD6dFvTELNoZIAwQ+ppUxGA3V8EtDPb1G+++z
         1NxkLdwRauFNRd/mqZFGb5h/imXJ0KX8qBL1tK4DwqPkPAy+StsoptlntpMcy4+3niou
         spfXPqjWUP8LJPPpgHitTaNqpYSPmiYoEmskKeo9mZWUghZj9JQ5y35SLaPoL4tEZbKh
         Xth1WAJAhSKeztGwaj+s/usT98pIk5/iG43fSkbOz0i4xEKnRGE98Qg9XGULasox49/D
         bgehSrSq6Nbf0mR0nv+H3cLorxynttBB3bdDQBb18fDTsS37dbqPn0RMD+qN1VQ3nLze
         NhSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694237845; x=1694842645;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bFQ0t0uD6xgDoywgg3aN4cVqH93hmn9yTMWxAqceJW8=;
        b=R+9u22hhCzNlpR5J+mCmT1HTTpzjvy8ENgl2Akl/k8Jdv040chvHwwMAItPvtGf4Nx
         GbaZxyG2hxAA+F+/+5XVKPQkr1kXHjF3kwWA5lmO0Sh4h+wyaXvpyqg9oeQ04Vhv8c8z
         s7zf7cFmWaAdjSmw9HMBPjBi/hyIjSey3aqeMyZK56gDGbmSbjhuRPyCgheNFMSUJe7O
         l/RyKXWsJS8ZhA5n+LDqm+7jLBY9oGzzjduhyN9leXMctuAeQvaOQ1u8H7wpFhTTcNDs
         J7GOYyoydkYHfvm4zXTsUdqPmbXK/bIwdQxAWy1FjpaGkylZopt+BcBQHmFAaXnNrJuG
         PJHg==
X-Gm-Message-State: AOJu0YwT61eeNgh61glYcgUqb4RHGYCMZ3K4bvEoY9ZvlkK5kyFAc4Lu
        d2H7gFkNHrpyV+ZG8LxBHzA=
X-Google-Smtp-Source: AGHT+IHNFDByETjzv4HPnQxVupj6RSk7YkzviBjkYMWjW45k+/RS05dM1OIhmQeWqnE91WNyi4a92g==
X-Received: by 2002:a05:6a21:61c:b0:14c:e089:94a8 with SMTP id ll28-20020a056a21061c00b0014ce08994a8mr3788602pzb.27.1694237844670;
        Fri, 08 Sep 2023 22:37:24 -0700 (PDT)
Received: from debian.me ([103.124.138.83])
        by smtp.gmail.com with ESMTPSA id jj18-20020a170903049200b001b9d95945afsm2456479plb.155.2023.09.08.22.37.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Sep 2023 22:37:24 -0700 (PDT)
Received: by debian.me (Postfix, from userid 1000)
        id 5F1519A5D462; Sat,  9 Sep 2023 12:37:21 +0700 (WIB)
Date:   Sat, 9 Sep 2023 12:37:21 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>,
        shenlinghai@163.com, Jens Axboe <axboe@fb.com>,
        Sagi Grimberg <sagi@grimberg.me>, dwmw2@infradead.org
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Regressions <regressions@lists.linux.dev>,
        Linux NVMe <linux-nvme@lists.infradead.org>
Subject: Re: Fwd: Ubuntu 22.04, "nvme list" will hang for 60 seconds after
 "nvme subsystem-reset"
Message-ID: <ZPwEkVraLm9WIkYK@debian.me>
References: <8edde583-2b5f-2332-e59a-f1f4688b9e40@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="MPojfPQaeXRUiCUh"
Content-Disposition: inline
In-Reply-To: <8edde583-2b5f-2332-e59a-f1f4688b9e40@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--MPojfPQaeXRUiCUh
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 02, 2023 at 06:41:01PM +0700, Bagas Sanjaya wrote:
> #regzbot introduced: 1e866afd4bcdd0 https://bugzilla.kernel.org/show_bug.=
cgi?id=3D217745
> #regzbot title: listing nvme devices hangs after subsystem reset
>=20

#regzbot invalid: regression reported using downstream kernel

--=20
An old man doll... just what I always wanted! - Clara

--MPojfPQaeXRUiCUh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZPwEkQAKCRD2uYlJVVFO
o5XAAP9HgtdqEDXnbtYY8DMvg7aMO62dgHjsURSMH2FST36TvQD+IMVvnH2iXslb
028fbd/9PzCQCfhZLz5BrPf2TWQ5WQk=
=G5rm
-----END PGP SIGNATURE-----

--MPojfPQaeXRUiCUh--
