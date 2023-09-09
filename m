Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9069799679
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Sep 2023 07:36:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243690AbjIIFgZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Sep 2023 01:36:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229704AbjIIFgY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Sep 2023 01:36:24 -0400
Received: from mail-oa1-x2d.google.com (mail-oa1-x2d.google.com [IPv6:2001:4860:4864:20::2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D801FE
        for <linux-kernel@vger.kernel.org>; Fri,  8 Sep 2023 22:36:20 -0700 (PDT)
Received: by mail-oa1-x2d.google.com with SMTP id 586e51a60fabf-1d4e0c2901bso1880486fac.0
        for <linux-kernel@vger.kernel.org>; Fri, 08 Sep 2023 22:36:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694237779; x=1694842579; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=T9QdRpHmKF7Dl0phviBz7WSuqViIRbheRKqXILmxCEw=;
        b=kb28Zr7w27I9v/kcFPazE4xu8Vnm0LxwGXZ1QLRZAEO/wA1GNtn0s74d5VIwiav92A
         4/S9RDDaucckkue9kVDj9wbew1FQki1MQszBDrAtoGvvvqmGpkn4gUYeywFb910q3bOU
         K+ONoK18pRTDZ6ZJ/RYq3gOKHbBNFMJS4HwpXwOrBEsx8eunykeUWgk5Aj9mHefH79pS
         DE66f/VWVSCfASf5muM9dD7r0GY8KtP1j+QXcp/HbY4onLAFwfvl3vuBE7L3lQ7ar2yx
         Vqu6gcYpnnAGwChGbB8zwdI6sfPGsCNGuTswBvmwg2SI7q6O1MffD/65lXgYfGWpuPm5
         qNaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694237779; x=1694842579;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T9QdRpHmKF7Dl0phviBz7WSuqViIRbheRKqXILmxCEw=;
        b=RBPkZob6F7CRIxtXM/iPMRl/ksffYJkmnmquCCzEnuyXp0LcdqISgr5h4t85ZmkkbA
         jcG5caHvqYCC0qsSXUTHSEZBMEAEY79hMD7ocmsHQqF+DljmMGU9JxEJgp26vfWQUxkN
         aLmkUSfifhOnZOyqSaQiJFxFoI2oNbT3fl6vVCRJ8lpn3UFuFnzmL+t+oLVUpDnxv0kv
         wVy/Tt7iY1WHTYbCbJeydAHS+XI3gs2DokUcAruR8FZe6JmhKL0M+cTkRkwUQt3yEn7U
         0bTvqw4avqaR0k9mzFcnNhhee3jr5seLOPzqtj4n65ajbDwtdT5wxvfajA6VTVAmdU1l
         /CtQ==
X-Gm-Message-State: AOJu0YzGtQAVf0BMqkpSwENJcbaP3kLqsMxmFhn6p0QCcsuTtMfp6n3V
        Txp5wGK5ALVnlWEV563R+ew=
X-Google-Smtp-Source: AGHT+IFsBaaCIIBHfXy6K9EBhaseuwvlm/ZF7VeyFi6SRkSkOxHCXNBxcjku48ptQPAr+1Rdzbe1Sg==
X-Received: by 2002:a05:6870:fb8a:b0:1bb:6cca:3468 with SMTP id kv10-20020a056870fb8a00b001bb6cca3468mr4623544oab.47.1694237779496;
        Fri, 08 Sep 2023 22:36:19 -0700 (PDT)
Received: from debian.me ([103.124.138.83])
        by smtp.gmail.com with ESMTPSA id 25-20020a17090a01d900b0026b46ad94c9sm2312333pjd.24.2023.09.08.22.36.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Sep 2023 22:36:18 -0700 (PDT)
Received: by debian.me (Postfix, from userid 1000)
        id 165109A5D464; Sat,  9 Sep 2023 12:36:14 +0700 (WIB)
Date:   Sat, 9 Sep 2023 12:36:14 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Thorsten Leemhuis <regressions@leemhuis.info>,
        Keith Busch <kbusch@kernel.org>,
        Christoph Hellwig <hch@lst.de>, shenlinghai@163.com,
        Jens Axboe <axboe@fb.com>, Sagi Grimberg <sagi@grimberg.me>,
        dwmw2@infradead.org
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Regressions <regressions@lists.linux.dev>,
        Linux NVMe <linux-nvme@lists.infradead.org>
Subject: Re: Fwd: Ubuntu 22.04, "nvme list" will hang for 60 seconds after
 "nvme subsystem-reset"
Message-ID: <ZPwETorRO60QGen6@debian.me>
References: <8edde583-2b5f-2332-e59a-f1f4688b9e40@gmail.com>
 <d7290782-bf72-3a65-26fa-b58e75bcae2c@leemhuis.info>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="NwbKn5UmL+2AYyp/"
Content-Disposition: inline
In-Reply-To: <d7290782-bf72-3a65-26fa-b58e75bcae2c@leemhuis.info>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--NwbKn5UmL+2AYyp/
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 07, 2023 at 12:30:30PM +0200, Thorsten Leemhuis wrote:
> >> root:~# uname -a
> >> Linux dapu-Star-Lake 5.19.0-46-generic #47~22.04.1-Ubuntu SMP PREEMPT_=
DYNAMIC Wed Jun 21 15:35:31 UTC 2 x86_64 x86_64 x86_64 GNU/Linux
>=20
> Bagas, please don't forward reports to the developers (and also don't
> add them to the regression tracking) if the report is about a problem
> with a vendor kernel that is known or likely to be patched[1].
> Developers otherwise will just start to ignore your mails, as you are
> wasting their time.

OK, thanks!

--=20
An old man doll... just what I always wanted! - Clara

--NwbKn5UmL+2AYyp/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZPwETgAKCRD2uYlJVVFO
o2JTAQCJLs9Rku/9XRes2BQ/A134vw5Uq14Ob4IgfIZtAQclqQD+P+WKjV56tT5N
6XJnoVyWpHG3yHNHWtMHvwS0QKpfoAY=
=Pizn
-----END PGP SIGNATURE-----

--NwbKn5UmL+2AYyp/--
