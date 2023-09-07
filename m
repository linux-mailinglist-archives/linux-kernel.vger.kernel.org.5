Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46DF8796E17
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Sep 2023 02:41:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244451AbjIGAlU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Sep 2023 20:41:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229753AbjIGAlT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Sep 2023 20:41:19 -0400
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com [IPv6:2607:f8b0:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F787172E
        for <linux-kernel@vger.kernel.org>; Wed,  6 Sep 2023 17:41:15 -0700 (PDT)
Received: by mail-oi1-x232.google.com with SMTP id 5614622812f47-3a76d882052so303853b6e.0
        for <linux-kernel@vger.kernel.org>; Wed, 06 Sep 2023 17:41:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1694047275; x=1694652075; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=9gui8u4OOc3TOjdVaRcFaPR8y2wsF5YiQ4542hZu9v0=;
        b=s0bVjx9nCJp6RGWYdnzMpLCq4cURQ+MWnFQlgdQqmLLfMZqz18zwbntWXd8nyEPw2h
         wS7csqAHFtMPPmFcNRExyqaRROK+NsqYJvouMPgZWlcA1EqRBfr+pBINi4NQJU6p5ONJ
         pttIDFbb9fJcr4FE823MG1ka72V8fzbT1qrxWDvlYfZMkudnMgvqv/taCYn1h8Obw5Oy
         R0b9gLeUYIFMu17qeu6RcVWAGDjVm1VYAvskD9QtMxfMx4gRHdg/DDbV7F7l3O06jrYm
         b0A60CWGaM4n+fHbxD10ichzNRtpuDieITuJ/jbgpVHJnB/3wedwIW7l3BbqSyJrtds6
         6taQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1694047275; x=1694652075;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9gui8u4OOc3TOjdVaRcFaPR8y2wsF5YiQ4542hZu9v0=;
        b=K1Z/lllUNL57526qKSQ6oAx7UUhRcMDe4nQzSRO3mmggGxR1LsdZJIxr+CjFl/eh7G
         SB5E5/Cf5k/SbKo8PmUho4aaLkFk8Az+orgWzveYBL8vxhDmwIh1U3okVHwoIxUNKCnu
         g+GdDYTMb70dKk7zOU6QIcv9XtSn17zV8lmFld9lslUzGXhMye9nsZnGoSvp8DU23Zea
         hW2B1G/5tqIKHRXxt+uFPLXbVz5YqycBdMBQvjp4cgEj2B6Ywv4QnquRk8/3+v2IJ8QK
         2vmOlQOCQDUqMLsvPJf3lGfUHZiHJGn9R4m9XIiQZ226LI1PIMPLlIy80c3OI2lL0qIi
         KpLQ==
X-Gm-Message-State: AOJu0YzsQk8OuPEMHfRv8C3VsAjZQMMP5LYad2hHkA9xatJie+0hyre8
        PeCi4ypwZ6wZzBt4CJQ/QRMI/oF+jWArLsD57s+wA5ci
X-Google-Smtp-Source: AGHT+IGM6nHYPpEfTcNYMZnmvw2j0DKLzAXvBY88wDkKX6uLcU+yABNF/mLwGK2iM85G5QjuriGr1w==
X-Received: by 2002:a54:4607:0:b0:3a4:3072:e597 with SMTP id p7-20020a544607000000b003a43072e597mr15809319oip.54.1694047274858;
        Wed, 06 Sep 2023 17:41:14 -0700 (PDT)
Received: from winterfell.papolivre.org (winterfell.papolivre.org. [2600:3c00:e000:341::1])
        by smtp.gmail.com with ESMTPSA id bl39-20020a05680830a700b003a792121f47sm7463566oib.45.2023.09.06.17.41.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Sep 2023 17:41:13 -0700 (PDT)
Received: from localhost (unknown [IPv6:2804:14d:7224:8468:34c9:cf8b:3384:7414])
        by winterfell.papolivre.org (Postfix) with ESMTPSA id 54F541C3AB0;
        Wed,  6 Sep 2023 21:41:12 -0300 (-03)
Date:   Wed, 6 Sep 2023 21:41:05 -0300
From:   Antonio Terceiro <antonio.terceiro@linaro.org>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     Takashi Iwai <tiwai@suse.de>, Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: snd-cmipci oops during probe on arm64 (current mainline,
 pre-6.6-rc1)
Message-ID: <ZPkcIayHbYJopT6n@linaro.org>
References: <ZPelHaX/Lt++kkOm@linaro.org>
 <877cp3esse.wl-tiwai@suse.de>
 <4f335dd2-8043-c60e-cf84-c2b01c4fee12@arm.com>
 <ZPjGuCdmPgqznc5t@linaro.org>
 <43632d9d-722c-b14f-336a-eac402ef9362@arm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="89dZcb8j/67jPzQ0"
Content-Disposition: inline
In-Reply-To: <43632d9d-722c-b14f-336a-eac402ef9362@arm.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--89dZcb8j/67jPzQ0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 06, 2023 at 08:52:40PM +0100, Robin Murphy wrote:
> On 2023-09-06 19:36, Antonio Terceiro wrote:
> > I'm pretty sure I saw reports of people using PCI GPUs on this machine,
> > but I would need to confirm.
>=20
> GPUs and any other PCIe devices will be fine, since they will use memory
> BARs - I/O space is pretty much deprecated in PCIe, and as mentioned some
> systems don't even support it at all. I found a datasheet for CMI8738, and
> they seem to be right at the other end of the scale as legacy PCI chips w=
ith
> *only* an I/O BAR (and so I guess your card includes a PCIe-PCI bridge as
> well), so are definitely going to be hitting paths that are less
> well-exercised on arm64 in general.

OK, that makes sense. So If I'm able to find a card that is genuinely
PCIe=B9, then it should work?

=B9 this one has a connector that looks like a PCIe x1, but it's not
  really PCIe as the chipset was designed for legacy PCI?

> > What info would I need to gather from the machine in order to figure
> > this out?
>=20
> The first thing I'd try is rebuilding the kernel with CONFIG_INDIRECT_PIO
> disabled and see what difference that makes. I'm not too familiar with th=
at
> area of the code, so the finer details of how to debug broken I/O space
> beyond that would be more of a linux-pci question.

Tried that, didn't help.

--89dZcb8j/67jPzQ0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEst7mYDbECCn80PEM/A2xu81GC94FAmT5HBsACgkQ/A2xu81G
C94oLQ//cHO0I77mzhQzQ6aLJ+BhBiOK4X/p43WCNIpIidWSjRlwuU6SbryWIxfX
e95mFUOg85ikPQr7tsNiOZ+UFUfFlOrUQABk6opO3/eF/su9FrAWL3CXgwM/8iy/
4Nf+Ksh9HWrMMGoHIjJm+Ge4Mj5avdX3e65uD3lIYMKEfrGekfDUs/HTlY3U8yG9
EetU/O6JQKLShwmbLLeO940H0+BQaxikQkOZAx5HZiL5m6I1ZDjjj0B/w+mHbodt
gwOl+XxBzAzW1OuFAzm99OjN0NSWXnay/fWrgkJxrLKR/PrvLsjchPLsZ3dkKV+j
Y3OvxFsuy/qVVEY1LXdKd56vzHAmnnv2p5NZ/7nlepv9lqifFmokwpcEfXb5+sJO
6IxdPqvgfESrmfrEUbqq4WrrK1nKcpI8Dit9Ms6IpX0rJUJDPbNRFS1h2ghvhOH9
F6nPcLE9w3AL2cG1ksKHUoOPtDHv1kHFhxO2cOpY3rLvCRSBDuSPawt6jndaTXHb
ZpefrV2sBzHX24Qgg6iLB/6uMHxqTFbo+N9XCdZ+Byi+wIZ81hKsNFHb85fBJxjo
gSujiA3I2TSr7ZZWnGQxucreZqUm4G0JbUEPBQDgwfsNtUjpNf6PfhYDJnd0tQg3
iEhaU48CDtfCJDAJNcokz/Msn8Mwvp4zUBRHDwiKg/nYlDZyfLE=
=2YPK
-----END PGP SIGNATURE-----

--89dZcb8j/67jPzQ0--
