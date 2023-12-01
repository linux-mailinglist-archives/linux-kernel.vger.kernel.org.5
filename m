Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CE808004F2
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 08:45:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377728AbjLAHpX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 02:45:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbjLAHpV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 02:45:21 -0500
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE866A8;
        Thu, 30 Nov 2023 23:45:27 -0800 (PST)
Received: by mail-pf1-x431.google.com with SMTP id d2e1a72fcca58-6ce08e725daso35959b3a.3;
        Thu, 30 Nov 2023 23:45:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701416727; x=1702021527; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=eDJ4cB9b17D60NS3i4W24KM6eOnW8/ANZmRWtkw6NI4=;
        b=L7hlkeDJ7YeoWSF9so99Pl69IId3gcQPeePQBKYwdbpCMCvYPmntII+tKaIGEC558R
         675hA+97bc/A31LYXJ87+KdHt9W/L58jww/cqyWJfn7qFn1tA6ibBmC0nYACig6q2lGe
         3UE260ahgWCi0vIQtWZxu8WCqJyst0AOry38hvdc79AGS/zt1cTuZ4ZBl0tJJ+j64iqc
         Xym+JTNxnckCG5wP3MndUFXUv0aEumdL8gdcuukGw9iqbQlz3hAAgUT7IBQd/ZrQHY99
         L1eUnePXlp3ej0YbN8etVOfyvA4ECrXA/5YVWs7f8zvsjq6jj7KW4/Q1UsDnI0OZQ1X3
         ej0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701416727; x=1702021527;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eDJ4cB9b17D60NS3i4W24KM6eOnW8/ANZmRWtkw6NI4=;
        b=kLsjVOPDYHi6kb+VsXlpAOp4eBSEjaQZ5R1OtEle58xfV708euy3qfb68LYENBZwye
         iT3Uv4PCohjzRJ74m5m6AlJQXxf+NbvXXnAm2tptik3eA1gvf+u8LcDe5ILQ6qVWxwNE
         fVBF2kz3xD37l1Zv2S5J5LMhT24noeGSdvWAutwdOpkW5AmMHJCRAEmyQX1yWsOE/W31
         aaB+bfCVgBgwxiPVQTZUjem1HaaSZbiKj0ApQnGvuX8nrhjzu1ZJah4napHH4wKhY1/W
         RVw9lwzvYPlXavDpCOWJdc8P8WiCY2xbP/Gqo5jOQkQ78SGmTA9wPylPc31UoUzS2UNC
         /Wrg==
X-Gm-Message-State: AOJu0YxhKsp7RZsw4rAQ/XT0odQ7+qqAeSIeubnfGFc469RqnPG9RT2H
        dTGfKBL7t56QXrsPCyGC7VE=
X-Google-Smtp-Source: AGHT+IFzYSkI8g/hbiFO96VkccVdtebsdaqn9YOdotDchDlagBAc5iGbhChWPyZ0ScJ/ymgv0CghGA==
X-Received: by 2002:a05:6a00:3922:b0:6cb:4c84:43ce with SMTP id fh34-20020a056a00392200b006cb4c8443cemr29233633pfb.34.1701416727398;
        Thu, 30 Nov 2023 23:45:27 -0800 (PST)
Received: from archie.me ([103.131.18.64])
        by smtp.gmail.com with ESMTPSA id gx9-20020a056a001e0900b006cdc6b9f0ecsm2378778pfb.81.2023.11.30.23.45.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Nov 2023 23:45:27 -0800 (PST)
Received: by archie.me (Postfix, from userid 1000)
        id 313BE10D3BE13; Fri,  1 Dec 2023 14:45:24 +0700 (WIB)
Date:   Fri, 1 Dec 2023 14:45:23 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org
Cc:     patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org,
        allen.lkml@gmail.com
Subject: Re: [PATCH 6.6 000/112] 6.6.4-rc1 review
Message-ID: <ZWmPE5aEdrJTQrNy@archie.me>
References: <20231130162140.298098091@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="/neyvsSfP2VfL6Q6"
Content-Disposition: inline
In-Reply-To: <20231130162140.298098091@linuxfoundation.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--/neyvsSfP2VfL6Q6
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 30, 2023 at 04:20:47PM +0000, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.6.4 release.
> There are 112 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>=20

Successfully compiled and installed the kernel on my computer (Acer
Aspire E15, Intel Core i3 Haswell). No noticeable regressions.

Tested-by: Bagas Sanjaya <bagasdotme@gmail.com>

--=20
An old man doll... just what I always wanted! - Clara

--/neyvsSfP2VfL6Q6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZWmPEAAKCRD2uYlJVVFO
o+owAQDwWzG48MrAscfg1mDx+CaRxpbqUpZ2sueC8CRF3w/DdwD/S/demZYjR7g2
nXain6YspAMuXtXPHEVdkFfYlCq2nwA=
=MgtW
-----END PGP SIGNATURE-----

--/neyvsSfP2VfL6Q6--
