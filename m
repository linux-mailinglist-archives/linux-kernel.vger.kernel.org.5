Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54A867E91F0
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Nov 2023 19:09:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231871AbjKLSIJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Nov 2023 13:08:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229738AbjKLSIH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Nov 2023 13:08:07 -0500
Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com [64.147.123.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4A6A2726;
        Sun, 12 Nov 2023 10:08:02 -0800 (PST)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id 8E1BE320085B;
        Sun, 12 Nov 2023 13:07:58 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Sun, 12 Nov 2023 13:08:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alyssa.is; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1699812478; x=1699898878; bh=dD
        uhcv1QYeJJwOpTS3JDJhN0uhtR6dQ7KzF3TyM4gRA=; b=MPQzx8xwFEKnzOCSkT
        kh1cgM8xGf/7ziZVT0XTVWGeUMzgt01pDLkGcp6lOwDiTO3h9+daPJYOi4Htm0gX
        JHoXFJbEOHJEBJnW0W8B0yGzgJ+MAKrmJhTr0qBNYJ9sSl6cUt2Pn1WO8rinmPu+
        QpeWw1iej73A9hBhgrwPozIiXlwVqrFtLPAfWsbqVrhsbjx7E2GevLScjsZPZpD3
        tMe2v9s8mouolaBv6Qv3VZOvKYm1n9gWt+jzFW1zkoxXP9+YeuZFXyFKWNQt0qPX
        VQA3zjTzRqBI72XVMAKDf1Oh2siyqPM5dOIvjUSpyAIKk+NWHzW5z6KnfUyFoe1z
        sZNQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; t=1699812478; x=1699898878; bh=dDuhcv1QYeJJw
        OpTS3JDJhN0uhtR6dQ7KzF3TyM4gRA=; b=p7qDAPRKnXnBrevizNRxhKLU4Ua8o
        qHc3nJg2FEP8MRyHq6Khnrk7yioOSlwz0kXuoi2LoIpqYxVG2ekbn6cCbPz8hK+7
        M7DBqcVjEs/6x1lifGfGG0g8wbfPjRsnWOBM42a/VbZrrUNKH3HoY48FPehKYtia
        MRoDusDMTYBTRj8FZB5ojrI1iWKacjYevS6XKecbEC0kS9GM4c9lEd2vrmXLlsAq
        mDec6Xojhz+cfjme1iby6jCQAfVacesBwOPAGosq6qlwapYZ4ZvQG+gWc34CXyoL
        G113vUAvKKKb3mbJ6DdAiFPUL9+GBYtzEqPXv+6YVok2cc6oj556uVn7g==
X-ME-Sender: <xms:fBRRZdn-PjLzyqpEzd_UjRQMy2jmoc3HrZaJU8bUMFYuOiHcgfnCpw>
    <xme:fBRRZY2Uy2NKuw7usHGToO9bjf_RGSyHHaJgcePl50sBXWaOk4lZYMios6PmnXiDI
    X_L2gWJR23Nv9yeXg>
X-ME-Received: <xmr:fBRRZTpGgZRZEjYh_VDGuQ-AacNM45zn3aKpFJaHmHRJ2sGKaF_JIMJClMikGiTC1ojWcFMY8jQqy-5Kxw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedruddvkedgudduudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehgtdfsredttddvnecuhfhrohhmpeetlhih
    shhsrgcutfhoshhsuceohhhisegrlhihshhsrgdrihhsqeenucggtffrrghtthgvrhhnpe
    dtjeeuteekheefueeluefgveeiffekhfetfeeivdefheeuhfejgedvieffiefhieenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehhihesrghlhi
    hsshgrrdhish
X-ME-Proxy: <xmx:fBRRZdlufq6OnU3oIGDpgJIqxDsliArdHJJ8d_uebhWMIsQukov7xQ>
    <xmx:fBRRZb3su33UxIHW2kjrhkClWddzjTIu-kV9JM1QYjWuaBPcvszajA>
    <xmx:fBRRZcs22ATr3A80AzUix0CDGtjJ_Ry4B9RZMEEQezYrE7wJy03RAQ>
    <xmx:fhRRZQ5CpDlZMmPW41rCcK7RcUtapaOVlHnqaMYSXRSoQ1Td4A7bmQ>
Feedback-ID: i12284293:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 12 Nov 2023 13:07:56 -0500 (EST)
Received: by mbp.qyliss.net (Postfix, from userid 1000)
        id BEEFA44AA; Sun, 12 Nov 2023 19:07:54 +0100 (CET)
Date:   Sun, 12 Nov 2023 19:07:54 +0100
From:   Alyssa Ross <hi@alyssa.is>
To:     Ross Philipson <ross.philipson@oracle.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        linux-integrity@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-crypto@vger.kernel.org, iommu@lists.linux-foundation.org,
        kexec@lists.infradead.org, linux-efi@vger.kernel.org,
        dpsmith@apertussolutions.com, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, hpa@zytor.com, ardb@kernel.org, mjg59@srcf.ucam.org,
        James.Bottomley@hansenpartnership.com, luto@amacapital.net,
        nivedita@alum.mit.edu, kanth.ghatraju@oracle.com,
        trenchboot-devel@googlegroups.com
Subject: Re: [PATCH v7 02/13] Documentation/x86: Secure Launch kernel
 documentation
Message-ID: <scpu273f2mprr2uvjlyk2xrjjtcduhse2eb45lmj7givn6jh4u@i2v4f2vbldu4>
References: <20231110222751.219836-1-ross.philipson@oracle.com>
 <20231110222751.219836-3-ross.philipson@oracle.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="yjlywfhxxmbqgjoq"
Content-Disposition: inline
In-Reply-To: <20231110222751.219836-3-ross.philipson@oracle.com>
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--yjlywfhxxmbqgjoq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

> +Load-time Integrity
> +-------------------
> +
> +It is critical to understand what load-time integrity establishes about a
> +system and what is assumed, i.e. what is being trusted. Load-time integrity is
> +when a trusted entity, i.e. an entity with an assumed integrity, takes an
> +action to assess an entity being loaded into memory before it is used. A
> +variety of mechanisms may be used to conduct the assessment, each with
> +different properties. A particular property is whether the mechanism creates an
> +evidence of the assessment. Often either cryptographic signature checking or
> +hashing are the common assessment operations used.
> +
> +A signature checking assessment functions by requiring a representation of the
> +accepted authorities and uses those representations to assess if the entity has
> +been signed by an accepted authority. The benefit to this process is that
> +assessment process includes an adjudication of the assessment. The drawbacks
> +are that 1) the adjudication is susceptible to tampering by the Trusted
> +Computing Base (TCB), 2) there is no evidence to assert that an untampered
> +adjudication was completed, and 3) the system must be an active participant in
> +the key management infrastructure.
> +
> +A cryptographic hashing assessment does not adjudicate the assessment but
> +instead, generates evidence of the assessment to be adjudicated independently.
> +The benefits to this approach is that the assessment may be simple such that it
> +may be implemented in an immutable mechanism, e.g. in hardware.  Additionally,
> +it is possible for the adjudication to be conducted where it cannot be tampered
> +with by the TCB. The drawback is that a compromised environment will be allowed
> +to execute until an adjudication can be completed.
> +
> +Ultimately, load-time integrity provides confidence that the correct entity was
> +loaded and in the absence of a run-time integrity mechanism assumes, i.e.
> +trusts, that the entity will never become corrupted.

I'm somewhat familiar with this area, but not massively (so probably the
sort of person this documentation is aimed at!), and this was the only
section of the documentation I had trouble understanding.

The thing that confused me was that the first time I read this, I was
thinking that a hashing assessment would be comparing the generated hash
to a baked-in known good hash, simliar to how e.g. a verity root hash
might be specified on the kernel command line, baked in to the OS image.
This made me wonder why it wasn't considered to be adjudicated during
assessment.  Upon reading it a second time, I now understand that what
it's actually talking about is generating a hash, but not comparing it
automatically against anything, and making it available for external
adjudication somehow.

I don't know if the approach I first thought of is used in early boot
at all, but it might be worth contrasting the cryptographic hashing
assessment described here with it, because I imagine that I'm not going
to be the only reader who's more used to thinking about integrity
slightly later in the boot process where adjudicating based on a static
hash is common, and who's mind is going to go to that when they read
about a "cryptographic hashing assessment".

The rest of the documentation was easy to understand and very helpful to
understanding system launch integrity.  Thanks!

--yjlywfhxxmbqgjoq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEH9wgcxqlHM/ARR3h+dvtSFmyccAFAmVRFG8ACgkQ+dvtSFmy
ccCcEw/+Jw619NXwUMkOs9voraKryzuATed/FO89aG2LRZ7O7WtQMzA5jLC3xZfS
/u0g17dDX08kUpbik40gguX15sYYQNKyiJITvY+ANpIV/78NEQ8YpfG0deZnUq+8
CVdQ3uQvyJdvREyw4FTXnMrvxbWNVUMLczTER+VPETScMo8SEtqrZAiUFvaUb224
RuVBQ9E+Qt3UgQc0NPDKl0aM8zOBS4EKjI0R1+g8Z4M79Gxd42sWrUh3GFBD809g
QIr5wTKMfJ3t7gfP6mNEiFnnBUeJIv9ZTDZ6WSnvaOx1uM1Qi9N8hod2aSPCAzcS
AhWYdh/haC8kwlIcEnX4SloCPA73e5FGIY7VPcSfVMd7YayfXhKNoGRm6+ir9y4B
P2fl4wV5/X+29td/XPoMxpqHgk1ZP0SF8juRFUvsftYZGAs3DO/bNxJFrIpz/433
1v2j5JT+zUbA653b4FvC664C4vrbOvrJkVpLLtz7Nh1aIrUUwJ+CuDLkxzTlBSsK
Xy8gclV01t3S03wvcL2Utjb/xyc1yx7nzc1DgkctNxTDjd6DWn9qM3HJXOeFwW9h
N12uI6+F0FAlUcx8hsKpcmDgW6S1d6RsgDPT/rQoqOltSCPw++G3DKQhHuYkxcI5
/cmKv6oo0cx3rJ74AxL3QtcbqT4jqAYVgCDL1bYqh9gi280v2f0=
=I5Za
-----END PGP SIGNATURE-----

--yjlywfhxxmbqgjoq--
