Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B95027B7584
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 01:58:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238468AbjJCX4o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 19:56:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237225AbjJCX4l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 19:56:41 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AD08A7;
        Tue,  3 Oct 2023 16:56:22 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id d9443c01a7336-1c874b43123so3000165ad.2;
        Tue, 03 Oct 2023 16:56:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696377381; x=1696982181; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZCCBj410ajq0re8t8s28xHlISeDJPhGS19VANz63K9o=;
        b=OSh2MQ4ANh1QwS1uiRujguNzfepjGkSNtKiBdh4Pve6XSeihn08PNH++WBIeyQOttR
         gxVQb53BQi7xYA6j402WfZa/LAvmFLDDOpB3jugvG7MoFgTyHd7tssjDoxLZk+XcGZfm
         aGgeh0S3WDhz23znU+XGwM+tR19u0iGNdi64DCMLbpZgOxG23xDo9hRDdX6OgpHNHuzB
         C7ev72xL4w5pZEqOOvL8uBFIC1uMN658i4fChWknbmGdxpbkw97VRYHmSqVhWj7IRPIO
         vCTWRsqKN3u3bV0EWRbBBSAA7T01tS7s8sMrrZXE8l9DHvhhduc0qUy5VyN57ZCRP3l9
         5Exw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696377381; x=1696982181;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZCCBj410ajq0re8t8s28xHlISeDJPhGS19VANz63K9o=;
        b=M+qVz3aHvmfkSpjm8W2LD6eKGCZ+d5m7ZfbDiqeRe79BcYJQlUP5In78FC7bhapoG+
         mCfKM5MrtzdZYMnqMmPfZnOxxeOOoJxqlKIkPPOp9GMfZZMmBPIyZ2lCS8iWTjUfkrpT
         x4W6Clu8QTmQkTaZzhRPuwd+Q3V7pY7FCq49xe3TgpjRHXvUcbFmg8cIRANa/1DNBBuF
         l4GYzTgo9kp6/EHmY1fDiCM3ch61V05BArrHzK3sMyu5gldwQSrbTuhntUZjiHxiwAbY
         Aty3zKlG4sgTZikKfAs6gGTWcgMzNdPUD0J6rl0fy3tPbpb/txMySiRO3Iy2dg1e+5VY
         Pawg==
X-Gm-Message-State: AOJu0YxPWTrpcf97VFGivFx3Z2Ubhi/+uyBVcLtfzVSzz01LomMz8PhI
        dEGZIfanYUIjVMr5Umc2IU4=
X-Google-Smtp-Source: AGHT+IEQ/w1Y8P4IJ6FMYu9I9SDAvd9lq2qE+CakE2eHWL6oVHapQH7nJH+ONsuq9pi4d0n04dR+CQ==
X-Received: by 2002:a17:902:9885:b0:1c6:117b:7086 with SMTP id s5-20020a170902988500b001c6117b7086mr935395plp.5.1696377381492;
        Tue, 03 Oct 2023 16:56:21 -0700 (PDT)
Received: from debian.me ([103.131.18.64])
        by smtp.gmail.com with ESMTPSA id m1-20020a170902db0100b001b8b45b177esm2179485plx.274.2023.10.03.16.56.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Oct 2023 16:56:20 -0700 (PDT)
Received: by debian.me (Postfix, from userid 1000)
        id A41D781A7EC5; Wed,  4 Oct 2023 06:56:18 +0700 (WIB)
Date:   Wed, 4 Oct 2023 06:56:18 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     "Kirill A. Shutemov" <kirill@shutemov.name>,
        Hilda Wu <hildawu@realtek.com>
Cc:     Alex Lu <alex_lu@realsil.com.cn>,
        Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
        Max Chou <max.chou@realtek.com>,
        Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Juerg Haefliger <juerg.haefliger@canonical.com>,
        Linux Bluetooth <linux-bluetooth@vger.kernel.org>,
        Thorsten Leemhuis <linux@leemhuis.info>,
        Linux Regressions <regressions@lists.linux.dev>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Regression: devcoredump patch broke Realtek usb bluetooth adapter
Message-ID: <ZRyqIn0_qqEFBPdy@debian.me>
References: <20231003182038.k57nirtt4sonvt7c@box.shutemov.name>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="lOp0O5Hmv9c8nMC0"
Content-Disposition: inline
In-Reply-To: <20231003182038.k57nirtt4sonvt7c@box.shutemov.name>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--lOp0O5Hmv9c8nMC0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 03, 2023 at 09:20:38PM +0300, Kirill A. Shutemov wrote:
> Hi,
>=20
> Commit 044014ce85a1 ("Bluetooth: btrtl: Add Realtek devcoredump support")
> broke Realtek-based ASUS USB-BT500, ID 0b05:190e.
>=20
> Devices failed to connect. hciconfig showed a controller with all-zero BD
> address.

What is its output then? And dmesg log?

>=20
> I reverted the commit as well as bd003fb338af that depends on the commit.
> It made the problem go away.
>=20
> I know virtually nothing about bluetooth. Let me know what info you need
> to debug the issue.
>=20

Hilda, it looks like this regression is caused by a commit of yours. Would
you like to take a look on it?

Regardless, thanks for the regression report. I'm adding it to regzbot:

#regzbot ^introduced: 044014ce85a17c

--=20
An old man doll... just what I always wanted! - Clara

--lOp0O5Hmv9c8nMC0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZRyqGwAKCRD2uYlJVVFO
o6UyAP9Slr9mZ+rRmtvUXh8WNdiIJEL1pcR6Ja0Bt3M/3Qr4qgEAnebbqTZM6ny7
9ZiB/gqtVQo7ARGVnp9hOJXS5BHafQQ=
=IV+/
-----END PGP SIGNATURE-----

--lOp0O5Hmv9c8nMC0--
