Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B81B17D3499
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 13:41:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234277AbjJWLlO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 07:41:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234268AbjJWLlM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 07:41:12 -0400
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com [IPv6:2607:f8b0:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B08810C
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 04:41:10 -0700 (PDT)
Received: by mail-oi1-x22f.google.com with SMTP id 5614622812f47-3af604c3f8fso2395827b6e.1
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 04:41:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698061269; x=1698666069; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=qviGzaXqF4YA7dDIHn+n8LWE1pgGuPrmv3bgL2LB7nM=;
        b=RcPNSFVccnTIq+xHEn0B77VhOxCo/sYQ5/vbFD73pbYYx/ayswK9fF/p7ZDeqJwcGp
         gt3J+hYriYjIn6lRqdbOvElm/V5ZBLiBqj7dSGQ0QGu+6FWxfVD2Kxez8tKRdYpGlWSf
         NBlPoKTsUj3SD+7awf5BNyPVNq6m3jDBKZ7/dzj7xQCfzX1lkiv8TnRazfI6neGPN859
         qttLp6TlgVlFguBl04em0nVcsnL4ILJrgkovBYI0w/zYaLbOWQutxBTjsyUn7cfvDevs
         5l0uEGWuAlnOuFroKf5J0IMg1xRtonX1FAdLGBguqLujveEzpUWN4/EVml/WlNN26rBr
         GdAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698061269; x=1698666069;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qviGzaXqF4YA7dDIHn+n8LWE1pgGuPrmv3bgL2LB7nM=;
        b=JeCELmSMjQoRfiAkfIEtkzmRf0R8wq2ifCL4qXSU+DIyDk/Ayq6LvuY3B8sK+y6wpp
         CMSbSupLDIOQ2u3AoI03+U++8cfDWJF2MBe4mi+9jMXTPpsTKnLNjN59WybZJ8ZXcB7R
         j/hAaZzImriOWNRMBQHGesiwwm4MAhSH/dfr4dS+js2o5PtNKwLJIPYXIbYsbtr64F0I
         t/mObmg9l+0oUbPzabNRSTVFiahWf6XjmQmfvyddmgeSXhNhjdF/pCLQhiHJBODlU7Qe
         Jof7Hs720mr3IRBy5JuL+tULyvAzlY+MB0LLDSGPKCgkETwLf3rNGfe6Qva9QJw+Hn0n
         hk/g==
X-Gm-Message-State: AOJu0YxNyQTtLB0zfIkTCjVZLF87eM8MUceQj1dMEKFboRy5SEiFU60U
        M2MIyfUJoqDNGBs2W2e32AM=
X-Google-Smtp-Source: AGHT+IEANqJcAXFHiNRNbHta3k4ItUnytNMmvQraCBNSdGog8EKJqfUWoMcNT+NOHKClIacufoaQeA==
X-Received: by 2002:a05:6358:858c:b0:168:dbac:b94e with SMTP id l12-20020a056358858c00b00168dbacb94emr3644931rwk.32.1698061269367;
        Mon, 23 Oct 2023 04:41:09 -0700 (PDT)
Received: from debian.me ([103.131.18.64])
        by smtp.gmail.com with ESMTPSA id q25-20020a656859000000b005898df17ea4sm4749520pgt.27.2023.10.23.04.41.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Oct 2023 04:41:08 -0700 (PDT)
Received: by debian.me (Postfix, from userid 1000)
        id 9025B818DF16; Mon, 23 Oct 2023 18:41:04 +0700 (WIB)
Date:   Mon, 23 Oct 2023 18:41:04 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     gmssixty gmssixty <gmssixty@gmail.com>,
        Randy Dunlap <rdunlap@infradead.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: How can I add "busybox sh" as init during boot of the custom
 kernel?
Message-ID: <ZTZb0AndJBwnAOYT@debian.me>
References: <CAOx-CDUwV0d0+2UdZW+vdUcjwAg2+Hanf1-iNSYFRWOW2yQugg@mail.gmail.com>
 <6675c47a-d258-41ae-b506-88d7ae74b551@infradead.org>
 <CAOx-CDVn7Ub31yiRpoZh4RhJBCvgZhb8Ca=cH9b0xWPjk5FNQA@mail.gmail.com>
 <89f666dc-e7b3-44ad-846c-b1f1ee278940@infradead.org>
 <CAOx-CDWzJWqYGhoJ4HPhio5-5zE025jYrmVpocryyxMfwfwsxw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="2kOlPG+NQPwYahhM"
Content-Disposition: inline
In-Reply-To: <CAOx-CDWzJWqYGhoJ4HPhio5-5zE025jYrmVpocryyxMfwfwsxw@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--2kOlPG+NQPwYahhM
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 23, 2023 at 05:06:38PM +0600, gmssixty gmssixty wrote:
>=20
> What would I write in /sbin/init? I mean, what will be the content of
> /sbin/init? Should I write: "exec /bin/busybox sh" in /sbin/init? Or
> should I write "/bin/busybox sh" in /sbin/init?

Since you have Busybox system, /sbin/init should be a symlink to
/bin/busybox.

>=20
> BTW, what is top-post?

A: http://en.wikipedia.org/wiki/Top_post
Q: Were do I find info about this thing called top-posting?
A: Because it messes up the order in which people normally read text.
Q: Why is top-posting such a bad thing?
A: Top-posting.
Q: What is the most annoying thing in e-mail?

A: No.
Q: Should I include quotations after my reply?

http://daringfireball.net/2007/07/on_top

Thanks.

--=20
An old man doll... just what I always wanted! - Clara

--2kOlPG+NQPwYahhM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZTZbzAAKCRD2uYlJVVFO
o3HLAQDv43/Z/D8tvVkDxO3HwcD74XH+OKLNrK6wvxwy97DPtAEAkczK1m7AJOVk
5z+yFWnNNbreq6qannQ6kh16uA9sfgg=
=xtF6
-----END PGP SIGNATURE-----

--2kOlPG+NQPwYahhM--
