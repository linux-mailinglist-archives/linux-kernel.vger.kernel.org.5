Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5CB17C84C6
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 13:45:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231362AbjJMLpB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 07:45:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231293AbjJMLo7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 07:44:59 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19631C0;
        Fri, 13 Oct 2023 04:44:56 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id a640c23a62f3a-99c3d3c3db9so319464166b.3;
        Fri, 13 Oct 2023 04:44:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697197494; x=1697802294; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c2CKqBbzGYk1vjKKWgG5/SbRNur6HY5ENpJ9OzOCgWU=;
        b=D/YpAby22jTJQ7xWsnNekVruc5mK7A4vw8suTw5JNGdXPzSTt+lcFKLweM4n2fRZSx
         2bA6YG72tlYXIzMJIroDTuOLtu+t/1BAMFCnQcyW8K45IVuZ1hTZv+1RQwhVFygbBrUG
         YjBRfi0cCkXmLrt5QhT8YdDtRdInIKnxj9G4bhpSCkq07M/X7H87QDQek//kGDVKrzQd
         f7SVGrY+mR4J8VIC4GoFwGs9U5kMedixcpf67V8vm3bx36KhXWEOp3GpSfl5Apy1RzMa
         aQLXQRPPiilHOWZj4TKL26wlC/L/dHPWQ/GMEQ3qgHnj9gRwNodukFViUFT43xsRCG5D
         uNXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697197494; x=1697802294;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=c2CKqBbzGYk1vjKKWgG5/SbRNur6HY5ENpJ9OzOCgWU=;
        b=SK0OhoMxJchzOVjxHdLTnz8TToxD20Sk+fFEJM+NTtO3RYExaNXedcnV7eBm0n09Yv
         DVrS2WytOeRZvQIp5XAiHsrhp85KklF/f40Drmf57EKgM42lfs3gvafYXu45F9kkJr+n
         hcc/W/mE3Tv1tYmzuTQMJVT8WCbDCN3lbF9vM2ldVcPYihuKLu+ktSi/6uvUZLiMgHX5
         xmCRKbu3EweBA5okyldmhYgSJ9ucO+TlWHizwlTlRcMS1/T8EqSf/AWTHFM5HJ/ObzhJ
         ZS/3zyZ7/jCdJFs3LwJpo9s8rArml89JjvmZ9mivtLR+CnXJVT/UkAD5mcf6CTB2CvpH
         QGJw==
X-Gm-Message-State: AOJu0YxWW4Iq8ASIK917L1bprsVVKf+MZCtAao0X2xgDvq/ae9M8STzY
        95ZyG9gPXv0BtPmAzb+XStNRoTzlSL4=
X-Google-Smtp-Source: AGHT+IF/l5QftJFMUODSeRaCN6FCrkF7mi/vMFuUkEnt8LWOz0koDVJujSn6P+0FiDhHZ0A9cUeOfA==
X-Received: by 2002:a17:906:530c:b0:9ae:3d8e:b635 with SMTP id h12-20020a170906530c00b009ae3d8eb635mr22727580ejo.24.1697197494418;
        Fri, 13 Oct 2023 04:44:54 -0700 (PDT)
Received: from orome.fritz.box (p200300e41f3f4900f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f3f:4900:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id t3-20020a1709064f0300b009b928eb8dd3sm12210200eju.163.2023.10.13.04.44.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Oct 2023 04:44:53 -0700 (PDT)
Date:   Fri, 13 Oct 2023 13:44:52 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: Signed-off-by missing for commits in the pwm tree
Message-ID: <ZSkttA6Yp2HVn_WZ@orome.fritz.box>
References: <20231013091451.170e4cb1@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="KoE5Wh/bC6rTB9cf"
Content-Disposition: inline
In-Reply-To: <20231013091451.170e4cb1@canb.auug.org.au>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--KoE5Wh/bC6rTB9cf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 13, 2023 at 09:14:51AM +1100, Stephen Rothwell wrote:
> Hi all,
>=20
> Commits
>=20
>   e83d065df879 ("pwm: cros-ec: Simplify using devm_pwmchip_add() and dev_=
err_probe()")
>   6bbb289ba9ef ("pwm: samsung: Consistently use the same name for driver =
data")
>   bca2b683e56b ("pwm: vt8500: Simplify using devm functions")
>   256d6ee2ad36 ("pwm: sprd: Simplify using devm_pwmchip_add() and dev_err=
_probe()")
>   4abf54cf7ecb ("pwm: sprd: Provide a helper to cast a chip to driver dat=
a")
>   aa60ddb3c334 ("pwm: spear: Simplify using devm functions")
>   4f9cbaf4a379 ("pwm: mtk-disp: Simplify using devm_pwmchip_add()")
>   41910bbd07a3 ("pwm: imx-tpm: Simplify using devm functions")
>   3097af23a2e5 ("pwm: brcmstb: Simplify using devm functions")
>   d5e2fc3956c3 ("pwm: bcm2835: Simplify using devm functions")
>   47ecc5a0f7a4 ("pwm: bcm-iproc: Simplify using devm functions")
>   a5e989881bfd ("pwm: Adapt sysfs API documentation to reality")
>   9caee567a7b1 ("pwm: dwc: add PWM bit unset in get_state call")
>   25c75f249c5e ("pwm: dwc: make timer clock configurable")
>   68ee440e9bbd ("pwm: dwc: split pci out of core driver")
>   e2218bde48d8 ("pwm: berlin: Simplify using devm functions")
>   a0754f8e01a0 ("pwm: Drop pwm_[sg]et_chip_data()")
>   04de4d9108c2 ("pwm: cros-ec: Put per-channel data into driver data")
>   8905e7d09c9f ("pwm: sti: Reduce number of allocations and drop usage of=
 chip_data")
>   8a4aa42059be ("pwm: renesas: Drop usage of pwm_[gs]et_chip_data()")
>   bfddd0080786 ("pwm: lp3943: Drop usage of pwm_[gs]et_chip_data()")
>   23d557785a11 ("pwm: jz4740: Put per-channel clk into driver data")
>   4c9548d24c0d ("pwm: samsung: Put per-channel data into driver data")
>   9db718b90b6c ("pwm: berlin: Put per-channel config into driver data")
>   4b672114771a ("pwm: crc: Allow compilation as module and with COMPILE_T=
EST")
>   4d7c6cfafb9d ("pwm: Manage owner assignment implicitly for drivers")
>   10cb8ce5af85 ("pwm: jz4740: Consistently name driver data "jz"")
>=20
> are missing a Signed-off-by from their committers.

Fixed now. I've also reenabled the local git hook that I used to have in
place to check for this.

Thanks,
Thierry

--KoE5Wh/bC6rTB9cf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmUpLbQACgkQ3SOs138+
s6E9Sw/9HrfNRaLxA//kiMsE0bse2QOiF7KOcWI88YvytLUqqBaShwH6CYgjF3NJ
PpEQRHXQXZx2x1QqR+7/TXgdwR4zPor9v500wQkUOSExK6Iku4Ry4UwG2yWIVuIn
s/H0IdNt4UNWFK55XoWBnMUzRe4mCYVsz6tgQVEuAM6qdvTk1xCbq2pRxnslLsOV
ewRrL81J7a6SHeDkwRONNQrskHwwZzFD5XLIjgRps6G8Bz2TDozT6v2UCKdFXcv1
xtMoaqXzmTnLV/7KvSmNQUI5U29VDhOC4bsmQGFO2aC2OZQg5u2o9HrI7GvuTojg
WzhJhPfeR0clMnoQroqV1sO3v03fn51KBTBJdTI+7MaAX8uGcP/h/AaNmasCLx9z
iYahUgoqFNYDzLfKnP6nAr0vIxtyTwpd0oir1HPeFKdibEGm4g7GM8zx8xFM+LAt
fUeh7yevJWe0vGf0QIipO+J5MjD7likmI189CVfdB17lKylieCnt4JAG32T1G4Ja
ZDOcf7YrTzD5VFXSF8or3lrtsrrnHxWy+JwMfNTrh/wx2DlfUl38QXPaB3hfmeO5
5j03MWoXWu6SrJfrMO+aPuv+vbNYrz9IF0cENlK1lkIuTYb9j+IzcRTh3Xtjr637
czrrP2zDIlFRPIzcGiGaI1FN1WNAinBcHjBaCVPT6fwFuwk4eH4=
=u1GF
-----END PGP SIGNATURE-----

--KoE5Wh/bC6rTB9cf--
