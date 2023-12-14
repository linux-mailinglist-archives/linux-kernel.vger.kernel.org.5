Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D941E812BD0
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 10:38:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443453AbjLNJiq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 04:38:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229693AbjLNJin (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 04:38:43 -0500
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B457BB7
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 01:38:49 -0800 (PST)
Received: by mail-pf1-x42b.google.com with SMTP id d2e1a72fcca58-6ce939ecfc2so7435803b3a.2
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 01:38:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702546729; x=1703151529; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GrXRlh1VZhf9ENLY+kgcCVCKL2qb4843BzZsjQawZy4=;
        b=gOqUjBssCol75AL2Syx0ZtURBFo4QA7Uq0HbDDMwXo0Wa7uAzy+XHVk5brVPmqBT6z
         tC4a0ZyKeJRrDMI/qGV3ZjW+mSWaGh7BZEtUoT6PaTKjOSrne00Kh70jFPsFuJ0Ymj1B
         sf2tHEfoA4oAnBZpFdhvrke7HZv2P0YYTZxqJ9a1Z3WBNGLL6hXGU6NJEU4x9ELvgWN6
         a3JpkABEJeucfVzLQOhe1m39gGrNBCNXVhaPYNro+fPT2Efu9GKtQgTtk/lonXnKsgPk
         zR8pjhSh8oSPGMf3rBry681z+eaSA2/XCdxKpnjCijsa2XjRPHUS1HBigdLymlIybXxm
         ZdJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702546729; x=1703151529;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GrXRlh1VZhf9ENLY+kgcCVCKL2qb4843BzZsjQawZy4=;
        b=N0lo6tH0mnHdjEFTnsc8CMWnK5XnrmvjOU2mQ+Lrix7sPe+6ShXpHNvCtMA6LVs7aA
         V3rUexm3e5kR6g/rw6tZGXwFXUVdpPCx0p+5wtsQDs0LpcpjgH1BgspytA1qKHK0GTY/
         +SGo335ZigJWr+4DO79dFBDGUrXWc5l8B1j1fHm6F+qCzckS4pfBqd6+4RPg/ZZYj4Lq
         wUiBavvlU5W0AgCiFstA4F4jQTuXHf/pkUesipL+W4KNNegiihFVnnV8E7EUv4ShB8HP
         4qpJddILWg76JHcdL5ibE/BHWajU6JnM5hdXgco0/6WI+Pk44D5RiAioXDMEEAYRujZj
         nFCw==
X-Gm-Message-State: AOJu0Yz0rrxXpFpGWnv1G9ksIj/Lc++c0wDrduIJL8e+t5N/BoFMM/Ye
        tcj32TtqufWDCSx1k8VlRXM=
X-Google-Smtp-Source: AGHT+IHQvwYZ1F7UuD3mjZKeIBdejzgLsccSVS8RgzZZLH9u8JxDHTD7CJmYWspvH8e0pq00nFDI3A==
X-Received: by 2002:a05:6a00:9397:b0:6d2:430b:1cb0 with SMTP id ka23-20020a056a00939700b006d2430b1cb0mr704360pfb.23.1702546729141;
        Thu, 14 Dec 2023 01:38:49 -0800 (PST)
Received: from archie.me ([103.131.18.64])
        by smtp.gmail.com with ESMTPSA id b9-20020a056a0002c900b006cee656cb3fsm10253158pft.132.2023.12.14.01.38.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Dec 2023 01:38:48 -0800 (PST)
Received: by archie.me (Postfix, from userid 1000)
        id C19A410207011; Thu, 14 Dec 2023 16:38:43 +0700 (WIB)
Date:   Thu, 14 Dec 2023 16:38:43 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux DRI Development <dri-devel@lists.freedesktop.org>
Cc:     Helen Koike <helen.koike@collabora.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Heidelberg <david.heidelberg@collabora.com>,
        Dorine Tipo <dorine.a.tipo@gmail.com>
Subject: Automatically update drm CI dependencies?
Message-ID: <ZXrNI9Pqln9HVYVc@archie.me>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="kRMQUWEv/5erBWGx"
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--kRMQUWEv/5erBWGx
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi all,

I'm referring to dependabot PR on torvalds.git GitHub mirror [1]. I know=20
that PRs submitted there are not accepted (the repo is essentially read-only
mirror), hence this mail question.

In summary, dependabot submitted automated PR that bumps package versions
in `drivers/gpu/drm/ci/xfails/requirements.txt`. In this case, pip was
upgraded to 23.3.

=46rom my experience, such automated PRs can pollute commit history (in
some GitHub projects these PR kind can contribute up to half of total
commits since the beginning of project). And in some projects, dependabot
PRs are automatically merged without any maintainer intervention.

Does such PRs (when submitted to LKML these will be patches) make sense
for DRM subsystem?

Thanks.

[1]: https://github.com/torvalds/linux/pull/807

--=20
An old man doll... just what I always wanted! - Clara

--kRMQUWEv/5erBWGx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZXrNIAAKCRD2uYlJVVFO
ozC2AQCxS3kryVSn5JLfUNWPaW/p4POxIllR4iEovVHReky5+QEA/T/ckSdfe5G7
kUszFFqdFyATRQq4Dlz2X8R0DsN1kwM=
=N1zN
-----END PGP SIGNATURE-----

--kRMQUWEv/5erBWGx--
