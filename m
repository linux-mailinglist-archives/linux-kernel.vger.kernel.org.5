Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70D9B76DEBD
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 05:09:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232192AbjHCDJq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 23:09:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229864AbjHCDJo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 23:09:44 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3C5AED;
        Wed,  2 Aug 2023 20:09:43 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id 41be03b00d2f7-56433b1b12dso276679a12.1;
        Wed, 02 Aug 2023 20:09:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691032183; x=1691636983;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/o2xH0SMI9wj02qiyV0SeKOt4eYb/PVCj7JROi66d+Q=;
        b=IhPIjIhNJ4sKUHPP2mn7ryx8BygQ8fWliRwWpmAc5/oG8qBC1gpgTAZS2QkevXQN63
         ub7H3A4gn39yOE44b5dBdnHJYf8cTsdkiXbsliodnuufLMJ2QiRuNtW36a7ukYhq9eMn
         5G2QuIR4N8HBSf17nrqqh0ksd6V24NVpAWD9jRvb01Np7c3NmQnQQOJEQU8rhBzVsoDO
         A5KncZbP/adTtWPrhJb7dZ1TZHWp2yVRqk+P+r5R2f2OpYagE3xk4BVDdjuKVGodLbNZ
         AjbHuKMGiKVTxJDUY3I5rOg2Iwnp4y3tCUprMw9KPgPgAbRyB/902NHZX3MevRLuYnyY
         9+PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691032183; x=1691636983;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/o2xH0SMI9wj02qiyV0SeKOt4eYb/PVCj7JROi66d+Q=;
        b=VEaR+cDnJ6qy2YT77kua8hh9bkSwkEz7ig8xMAZ9n6JvBZWr2XIOxcUhICgwccsT2z
         /vaYj/hbBpJZ0lNIaOTJdtfHEoXzVvWfmXhJJWvjvHyJ3iahP4GtPPmWPUbwt+0wc7mj
         VqUoHwNScd6ckXzr4lmqdnT82gwkL4CcZJ/OVELVGuvfxHX0XZ4o8Dv8h8PUjEh7qgy0
         eqtSyHCZ5dy4lY3tQSLkbDwEXUR4Q9lo2Z9O5EAkZvfZWspr1osRcuxC3cAOETTuobvX
         tHrmFDrp/UJuPfeirY2LC0CA4djH1V+go2No6cTa6LJkBCeqTtpSbtfiN+nzBl/sJapg
         nIgw==
X-Gm-Message-State: ABy/qLb6faTqcxMY6CtmnJj+oJZs83LPU6rJ6S4TluhclEhupUoKRsQf
        9DvZL/Bty0B4HK5mG1Cpb6o=
X-Google-Smtp-Source: APBJJlGNedMlkcwQjveehRQINb00jbeB6Oa+VFRAIl9Hc2QAqFcUv1um2QD0HOwjkPqsIobF8v7lTA==
X-Received: by 2002:a17:90a:c20b:b0:268:414c:ff3 with SMTP id e11-20020a17090ac20b00b00268414c0ff3mr15364402pjt.23.1691032183078;
        Wed, 02 Aug 2023 20:09:43 -0700 (PDT)
Received: from debian.me ([103.131.18.64])
        by smtp.gmail.com with ESMTPSA id l19-20020a17090add9300b0026596b8f33asm1676347pjv.40.2023.08.02.20.09.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Aug 2023 20:09:42 -0700 (PDT)
Received: by debian.me (Postfix, from userid 1000)
        id E52698BF2795; Thu,  3 Aug 2023 10:09:38 +0700 (WIB)
Date:   Thu, 3 Aug 2023 10:09:38 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org
Cc:     patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org
Subject: Re: [PATCH 6.4 000/235] 6.4.8-rc2 review
Message-ID: <ZMsacoioD9hfjnR/@debian.me>
References: <20230802065501.780725463@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="SjOz5lqmqKFzFT+Q"
Content-Disposition: inline
In-Reply-To: <20230802065501.780725463@linuxfoundation.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--SjOz5lqmqKFzFT+Q
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 02, 2023 at 09:42:04AM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.4.8 release.
> There are 235 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>=20

Successfully compiled and installed bindeb-pkgs on my computer (Acer
Aspire E15, Intel Core i3 Haswell). No noticeable regressions.

Tested-by: Bagas Sanjaya <bagasdotme@gmail.com>

--=20
An old man doll... just what I always wanted! - Clara

--SjOz5lqmqKFzFT+Q
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZMsabAAKCRD2uYlJVVFO
o13EAP9kBqu3giVm9gdHHMj/npNwioRP3Np9N/2Pwyho/EyHqAEAqEuxbaxZXwrY
Nn10xesdPoEs+lLEnkXJrVc2zn7MjQs=
=WGCp
-----END PGP SIGNATURE-----

--SjOz5lqmqKFzFT+Q--
