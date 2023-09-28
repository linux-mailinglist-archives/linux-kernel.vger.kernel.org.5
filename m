Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E68DA7B18D5
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 13:01:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231363AbjI1LBX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 07:01:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231246AbjI1LBU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 07:01:20 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B8DF180
        for <linux-kernel@vger.kernel.org>; Thu, 28 Sep 2023 04:01:16 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id 98e67ed59e1d1-27758c8f579so6222620a91.0
        for <linux-kernel@vger.kernel.org>; Thu, 28 Sep 2023 04:01:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695898876; x=1696503676; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=pYKgXq+vaQtmifoFDQlFohY9tqK1T0ZxxWc8ChkHqI8=;
        b=VKJaIoo3f+J2KKwt4+zkY6b5vb2zo3hs8eiPzGy/CNYe4gkZoQFYz5ZYvA1AmxSdE8
         RoW4+4phHBUuWyGeOvJjnfRxuXWnehboXkuLmUFlHOKt9Ohj+IwAcTWgWGgg64CPaJIP
         eCVtKZstpYdjQCOpzDE/Z4MAUz67AQPO3X21wHIU8nPXwkD6VsNQW/r/rdP8AU/SHri0
         3Nv45rgIZsdKNlyqPRJuOQwpaLKueF68gNqg8gVdWhLkcUU2ueGvNdFGVRtMNiLKZV3s
         We3QHe3/Y7ulRjKthgRAe02x0AH4t0anehiegqgQ6PnKn3vevTxbfDO0m/jxClh9+UlT
         dERQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695898876; x=1696503676;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pYKgXq+vaQtmifoFDQlFohY9tqK1T0ZxxWc8ChkHqI8=;
        b=YlcKXo0bec8isOQ8NxkZRwtYrAnVHA+JOTx/j6QOa/Q6y3a3dEtHj6bExynw6Us1SI
         2JjUV+mzS9cQ5u+5rywadbdh8Sve3+lwoZxDv23D+RN42xx6F3IyEWSGRSkTos+ovcCC
         QzYnb92Hnvr82TWsuIAPDS+uAB/G0qqxAEjk8Dkr7VFBXEgmv6frotzKrZkpzUPQlC08
         Jpckf6VwZQooYKIAiS6dGN+7gQLJuRFLqWX3uuHJqZA2i+zvwcfs4iidnF9tZ3a25Aj7
         MflgoNX0se8+ZhBLoIgKcOYXvQ64Ld/gJXtYPHgHy9xFcsvLhUekzpbNLrlruNr+BOXq
         nUzw==
X-Gm-Message-State: AOJu0YwV/pjtTktcjFcp/ykOE9ToTniUw0NNmdMnSEeIVNrYAoGTjR0E
        FzLFdORnoPC69CNcnEUlwec=
X-Google-Smtp-Source: AGHT+IGKmFLibatR4FFYGrusi8XPJ90Q0s0r/+1WccPyk/ovA3NHe2CD/0pMaNvfcLvXft2FoVz+Yw==
X-Received: by 2002:a17:90a:e2c9:b0:271:9237:a07f with SMTP id fr9-20020a17090ae2c900b002719237a07fmr771526pjb.32.1695898875805;
        Thu, 28 Sep 2023 04:01:15 -0700 (PDT)
Received: from debian.me ([103.124.138.83])
        by smtp.gmail.com with ESMTPSA id jg19-20020a17090326d300b001b3bf8001a9sm10961499plb.48.2023.09.28.04.01.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Sep 2023 04:01:15 -0700 (PDT)
Received: by debian.me (Postfix, from userid 1000)
        id 3074E8222029; Thu, 28 Sep 2023 18:01:11 +0700 (WIB)
Date:   Thu, 28 Sep 2023 18:01:11 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Victor Fries985 <freeze0985@gmail.com>
Cc:     Kees Cook <keescook@chromium.org>,
        Daniel Micay <danielmicay@gmail.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Regressions <regressions@lists.linux.dev>,
        Linux Memory Management List <linux-mm@kvack.org>
Subject: Re: kmalloc memory leak over time.
Message-ID: <ZRVc9tjrED_2mWe0@debian.me>
References: <4f01f302-9d59-4146-b7ff-0478c4bd94b1@gmail.com>
 <CAAU1TwEFpEMkWMN3kJj-uOJtEK1X0kvBX7NjQ1djduZaP+AR-g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="GeqDmjNMxRAUW/Iq"
Content-Disposition: inline
In-Reply-To: <CAAU1TwEFpEMkWMN3kJj-uOJtEK1X0kvBX7NjQ1djduZaP+AR-g@mail.gmail.com>
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--GeqDmjNMxRAUW/Iq
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 28, 2023 at 03:09:05PM +0530, Victor Fries985 wrote:
> Hi, the regression started from 6.5.3, i failed to mention it in bugzilla.
>=20
> Original I made ticket on linux-zen, thinking it was their problem. But it
> turned out to be problem from normal linux itself.
>=20

Please don't top-post; reply inline with appropriate context instead. This
allows readers to easily follow conversation flow.

Anyway, does v6.5 mainline tag (not the stable tree) also have this
regression?

--=20
An old man doll... just what I always wanted! - Clara

--GeqDmjNMxRAUW/Iq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZRVc9gAKCRD2uYlJVVFO
o0Y+AP9DW2gKFs6akR5UINM1DXr27W2z/r7K8GlADHMEfUofAAD+I6eEJaTRo247
Qyz7yHo5jba27NQN5/U3+OMLhOI8XAE=
=pRi+
-----END PGP SIGNATURE-----

--GeqDmjNMxRAUW/Iq--
