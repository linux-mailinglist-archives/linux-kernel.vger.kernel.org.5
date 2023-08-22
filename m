Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E7F8783870
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 05:19:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231346AbjHVDTq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 23:19:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231262AbjHVDTp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 23:19:45 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DC6A189;
        Mon, 21 Aug 2023 20:19:35 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id 41be03b00d2f7-56b2e689968so982235a12.0;
        Mon, 21 Aug 2023 20:19:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692674374; x=1693279174;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=QVaw4tiSyySSYVra+1OgfCW3zHmTwq5IUAn9t1HVRdk=;
        b=Fpq7Y1q+oBNXqPvgCaJhcGskS8L4ei/pGFeyFFYomGrlBqWDktl2gLAreGcdNTJlOh
         TWXbN1P57z7arZZGeH2pAsjU1rgj0kl4bbwvJwxI71SDnvsZBRW3JYeNbrUnDUeAf+73
         4P90KTHOwqkQhJAzNiAGiBT0OCMcGroUia7aty6eiy0PHY5K20ANnOhfVlkMRjA7AB5b
         PKr/NN+7rvCHkY9zj1WU+lUzoh6hfnQJHzHLz2vaA2HQzN+w4Hvk/OEwShD25tGB/jeV
         MXrTSjbRSFkEcdBHnv4elJbkoBHaR/2SxAo5Tsq/WWj3Z9tCCZ8sVMFDXZJ5J82mQioU
         fUXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692674374; x=1693279174;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QVaw4tiSyySSYVra+1OgfCW3zHmTwq5IUAn9t1HVRdk=;
        b=a5XdJdXh1Ku2/r+Puhibh+M+LZHsxIMahLQzTRtOyrOWFeWuQuAPVCAoM4VlmAd8pt
         mtWXWGWhGmhFL9TlIgoSF3uEevqC+jVXxVuov9LrVgho/4ud+7WOVncKxAkEu+gCUCr3
         fPogXWNddvN8GlA93BOByZ7N2+DcKRo33GuqhDlsDOk2Zmc/DMZBOqc1eOssK3twnvL8
         OS1cZZBsegNDWIkfdIAAOC7U/lOVFAQPkFb/jqW9EENvcQfuLXzQ+kNEHjN/p8FTaLI5
         bftdXqnMRUb0mvDNocJ+ZbR8ELfmLyMStXmJTs0A6xEGVG/NvD0Q05hjI6MWSnCGevON
         o+Vw==
X-Gm-Message-State: AOJu0YynpXPcrr4CBn2TtH/Q8H5or6LGt9c/tqiRzzJijO7cznl5CMZL
        I8I6VRnPAm3CZ89rftbPUvw=
X-Google-Smtp-Source: AGHT+IFVaiYgPWbU5gb20xizv8xMU3ToF01RakEjSE9TDjJA72zl+lMGcxy4KhDTstAN7q5X+hkb2Q==
X-Received: by 2002:a05:6a21:6da6:b0:148:6a9e:143f with SMTP id wl38-20020a056a216da600b001486a9e143fmr6175549pzb.21.1692674374378;
        Mon, 21 Aug 2023 20:19:34 -0700 (PDT)
Received: from debian.me ([103.124.138.83])
        by smtp.gmail.com with ESMTPSA id a16-20020a170902b59000b001bba3650448sm7798614pls.258.2023.08.21.20.19.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Aug 2023 20:19:33 -0700 (PDT)
Received: by debian.me (Postfix, from userid 1000)
        id 7AFE68BAEED1; Tue, 22 Aug 2023 10:19:31 +0700 (WIB)
Date:   Tue, 22 Aug 2023 10:19:31 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org
Cc:     patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org
Subject: Re: [PATCH 6.4 000/234] 6.4.12-rc1 review
Message-ID: <ZOQpQ873V3bfS4Vo@debian.me>
References: <20230821194128.754601642@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="5akErifBNQ1KWG90"
Content-Disposition: inline
In-Reply-To: <20230821194128.754601642@linuxfoundation.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--5akErifBNQ1KWG90
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 21, 2023 at 09:39:23PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.4.12 release.
> There are 234 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>=20

Successfully compiled and installed bindeb-pkgs on my computer (Acer
Aspire E15, Intel Core i3 Haswell). No noticeable regressions.

Tested-by: Bagas Sanjaya <bagasdotme@gmail.com>

--=20
An old man doll... just what I always wanted! - Clara

--5akErifBNQ1KWG90
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZOQpPgAKCRD2uYlJVVFO
ozfoAQCmIpWl7OnaJSk2tWGfyHKJDKnfedmzdG2d+IFR087qFgD/R6Fqpk08fYro
1baG0megf+allZjl55cDYbZiUi70CAE=
=gi4j
-----END PGP SIGNATURE-----

--5akErifBNQ1KWG90--
