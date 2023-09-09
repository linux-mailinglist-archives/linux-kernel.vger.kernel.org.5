Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1840D799675
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Sep 2023 07:28:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244116AbjIIF2c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Sep 2023 01:28:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229925AbjIIF2a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Sep 2023 01:28:30 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C14B11BD3;
        Fri,  8 Sep 2023 22:28:26 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id d2e1a72fcca58-68a529e1974so2328132b3a.3;
        Fri, 08 Sep 2023 22:28:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694237306; x=1694842106; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=AhGcYIVxPZwLXUPMQ7arLtBywPpQ4z3xctSy6TWk6XU=;
        b=qzkiSbkk044CfPpNTsN4hI8HDDas2kRjLqqMQzopziv/4dbduQAGTjcbzAvMbt6Iqu
         /dGSBOwG6FBBBaz/xz2cDsH4kvT/AyYmyhglWwXhQ52opY0ZOJk9XPpMQSMMjaUQrr37
         qMQlIiZvnBm1y93+P4rFRWL2CRmqdBmiRqa7QJW1fJQUKntVpWlR145arqdRYuHqkF5/
         leACPU0cf5WS2+kORfjx1J8Ne1tHPoxTjgT2NNME8WU+luGfDrwlysJCYj+3pSePLtxn
         n0T3qnrPnVMbkleIw3hvwcVtw750eRz/ZhK7i3suk6PFIIXeynP9h0ZHAC8Qc8H3KgBS
         /1DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694237306; x=1694842106;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AhGcYIVxPZwLXUPMQ7arLtBywPpQ4z3xctSy6TWk6XU=;
        b=j8Hk0jHMnImoTIBWrNq08mycoXelz/3GpB02NFd/wkwcM01b7UJ63lBeAV4xgAP991
         5zLQoURigmg2lK5u0nnvQUsV+rOAqir4bu2qiLvx7TiJ3DGakbkuGfzddh1c/AxwsMqd
         Q8E5bxUzbyclnET6wEtIiOb68cXu0CFgL8zB9PvUAuzIGhzmtAA3bWYoeoFlIYKwdT5q
         zq0Yt0cNDu/6mibpC7wv61TFRVGqtEGZ6vTGgmaBhhrr2M3QNSjpIAeEbbm0sPMUO3e4
         Yd+7Jy8fpODvU3QKMUcfaC3V1P5Kehg7FNDJI/Z3fpK/za02veQTCpshQ/xXWL6Dlqd9
         /FzQ==
X-Gm-Message-State: AOJu0YzMBTYCBrnSoEqq8Tn6iZKJg7sDA3upgKIzQyvM/SvjO7qbSXej
        +48tzxAh5muosGHmRtDZAms=
X-Google-Smtp-Source: AGHT+IGw0ulupui94qNdMz252mwrFm6dOVwPF7ntkmtDhRPf3eauIShtH1mkNSqQIgh2r194qOvtMA==
X-Received: by 2002:a05:6a00:15ca:b0:68a:4dfa:ea63 with SMTP id o10-20020a056a0015ca00b0068a4dfaea63mr4581797pfu.19.1694237306156;
        Fri, 08 Sep 2023 22:28:26 -0700 (PDT)
Received: from debian.me ([103.124.138.83])
        by smtp.gmail.com with ESMTPSA id n26-20020aa78a5a000000b006828e49c04csm2088013pfa.75.2023.09.08.22.28.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Sep 2023 22:28:25 -0700 (PDT)
Received: by debian.me (Postfix, from userid 1000)
        id 89ED6803A58F; Sat,  9 Sep 2023 12:28:21 +0700 (WIB)
Date:   Sat, 9 Sep 2023 12:28:21 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        TatriX <tatrics@gmail.com>,
        Masahiro Yamada <masahiroy@kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Regressions <regressions@lists.linux.dev>,
        Linux Bluetooth <linux-bluetooth@vger.kernel.org>,
        Linux Kernel Build System <linux-kbuild@vger.kernel.org>
Subject: Re: Fwd: Bluetooth LE scan doesn't show device name
Message-ID: <ZPwCdd6lnOTbcDS0@debian.me>
References: <97224321-c839-c0a7-52dd-3fb6e52fc15e@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="yHJYS4swNGsW/wbV"
Content-Disposition: inline
In-Reply-To: <97224321-c839-c0a7-52dd-3fb6e52fc15e@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--yHJYS4swNGsW/wbV
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 08, 2023 at 08:44:36PM +0700, Bagas Sanjaya wrote:
> #regzbot introduced: v5.9..v6.4 https://bugzilla.kernel.org/show_bug.cgi?=
id=3D217773
>=20

#regzbot fix: 52bf4fd43f759a

--=20
An old man doll... just what I always wanted! - Clara

--yHJYS4swNGsW/wbV
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZPwCbwAKCRD2uYlJVVFO
o3YPAQCu8g+OeR/FT4e0bLiH5epWupufFcZnNZzU0y5VYqsNqQD/Zy1WqYyTeb3n
nOxfRLCWsV9IJ3KNPiTfR0i2jHbzKwU=
=TM2y
-----END PGP SIGNATURE-----

--yHJYS4swNGsW/wbV--
