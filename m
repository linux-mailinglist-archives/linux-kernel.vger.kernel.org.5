Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D7147E911C
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Nov 2023 15:12:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231644AbjKLOMy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Nov 2023 09:12:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229588AbjKLOMy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Nov 2023 09:12:54 -0500
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F36182D54;
        Sun, 12 Nov 2023 06:12:48 -0800 (PST)
Received: by mail-pf1-x42a.google.com with SMTP id d2e1a72fcca58-6c4ed8eef16so1907661b3a.0;
        Sun, 12 Nov 2023 06:12:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699798368; x=1700403168; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=TCvr0yTKicKszXc2n3f/nKPcI+6n8ysEnACBP1fLv1U=;
        b=LFkpAqT/Jy8BvxR5EeIsVYeVaB+FSJKWDu5KYt38gnVf5gEOnQIBut6GkTJhtqH1Pv
         a3KCTKDZ2JCcHF/WNnRRgsnskGq9PUloFonHI64OusCcViqub9LzcA02Q6yzpWksozVP
         jrXkFjpBq6xK5ZP08RTzlctRg4FiQowHDbUnmNEu050ojpDHXaEkihoNUyj48b/L4RcY
         MzDUc03JM/rEbpHFco8nD4WnGSFsqiJgADlDMHgBc6e31rW3Ab9KE0SQjiiy2qVOKWah
         uKU2LyFR4M6174ZfyhTv1kJnFSSHKfEAtaNrW1wGthUoENy1YUaSzx5vjZAFsBLYLEnA
         L8pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699798368; x=1700403168;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TCvr0yTKicKszXc2n3f/nKPcI+6n8ysEnACBP1fLv1U=;
        b=D3UeKLSZWvDvRqRSyH8lSuCw4upL9uE8UoS3JAcf54XErsI8i44CgRcqN2dkJ4B+cP
         JIGUjRmqlYVTE1k9LsQmG3BkTTY1+X5656D9xchdtpvNb9d1ai8Ufem1aQk3RKbpUH5w
         gxiUkrpUxuVaCVKaNUcGi4GCAJG9wErVksN//m+pEUZ1fDsjG+L4jNKRmDQ7XsjYDIyt
         Epsl3SGnCQeTtLhdXLVDHFxB8fnPrq2RcssOz7gP5b+NwsoeSO8aUYhoH1dlPK8UtZcw
         6LOngqKtDpHKI5Zn0tNoEWIwg7iZQatMJ0COnn+fs+QGw9fhvSNe8Hw6IC9eDtU3nl0+
         exuw==
X-Gm-Message-State: AOJu0Yx8Tn3+koyNe0rRrNB/n5paTrPdvnDPp+Rf1BAIU5FW+mWUTGo/
        DDxcIHrHZQOoE6Br89zjiCs=
X-Google-Smtp-Source: AGHT+IEa52UGrTINC8r6UcUtaKBz+bSttXiaWAm3fVRDA/TY1Uke7Cq5Lz+3rtpTF4RUVIlONVaGVw==
X-Received: by 2002:a05:6a00:408f:b0:6c6:9c3b:f0c5 with SMTP id bw15-20020a056a00408f00b006c69c3bf0c5mr4231803pfb.24.1699798368340;
        Sun, 12 Nov 2023 06:12:48 -0800 (PST)
Received: from archie.me ([103.131.18.64])
        by smtp.gmail.com with ESMTPSA id e20-20020aa78c54000000b006870ed427b2sm2618022pfd.94.2023.11.12.06.12.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Nov 2023 06:12:47 -0800 (PST)
Received: by archie.me (Postfix, from userid 1000)
        id 0DE0D10475DAF; Sun, 12 Nov 2023 21:12:45 +0700 (WIB)
Date:   Sun, 12 Nov 2023 21:12:45 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Regressions <regressions@lists.linux.dev>,
        Linux Wireless <linux-wireless@vger.kernel.org>
Cc:     Anjaneyulu <pagadala.yesu.anjaneyulu@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>,
        Johannes Berg <johannes.berg@intel.com>,
        =?utf-8?B?TmlrbMSBdnMgS2/EvGVzxYZpa292cw==?= 
        <pinkflames.linux@gmail.com>,
        Fabio Comolli <fabio.comolli@gmail.com>
Subject: Re: Fwd: iwlmvm: Linux 6.7 pre-rc1 prints stack trace of
 iwl_op_mode_mvm_start; caused by commit b6e3d1ba4fcf
Message-ID: <ZVDdXWNFSg48toP5@archie.me>
References: <2fa930bb-54dd-4942-a88d-05a47c8e9731@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="LtCOL7Zv4yuWkm+i"
Content-Disposition: inline
In-Reply-To: <2fa930bb-54dd-4942-a88d-05a47c8e9731@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--LtCOL7Zv4yuWkm+i
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 03, 2023 at 08:13:39PM +0700, Bagas Sanjaya wrote:
> #regzbot introduced: b6e3d1ba4fcf02 https://bugzilla.kernel.org/show_bug.=
cgi?id=3D218095
> #regzbot title: new iwlwifi firmware statistics API triggers stack trace
>=20

#regzbot monitor: https://lore.kernel.org/linux-wireless/CAHk-=3Dwix6kqQ5vH=
ZXjOPpZBfM7mMm9bBZxi2Jh7XnaKCqVf94w@mail.gmail.com/
#regzbot fix: wifi: iwlwifi: fix system commands group ordering

--=20
An old man doll... just what I always wanted! - Clara

--LtCOL7Zv4yuWkm+i
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZVDdXQAKCRD2uYlJVVFO
o8rvAPwJodW9tD6EUNvZDaoh3shGw2NQJrSPJOYTfTq6EqKdSgD/Xi0GqoReWa6B
Lj2q+AyyKAOS7/ovhlAW7/fFTNFx/Qw=
=vmFw
-----END PGP SIGNATURE-----

--LtCOL7Zv4yuWkm+i--
