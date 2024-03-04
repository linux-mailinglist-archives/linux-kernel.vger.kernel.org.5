Return-Path: <linux-kernel+bounces-91381-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 71C1B871067
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 23:51:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 26633286A8A
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 22:51:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DE827C090;
	Mon,  4 Mar 2024 22:51:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qH7ghQWU"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73BDB482DA;
	Mon,  4 Mar 2024 22:51:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709592701; cv=none; b=a36yWANtnKKRftqdLZuu+CJzfnbTZRUAiuFHBEtuRDOiNCnz172Jm7S7MAuk9t472o8BK+ZNvX7LRrXDRuZyh2Siu1O0HHMO5OSDJPoeF4KRXci7JsbYmrxc6sma9Hqz5XzB9O/HtUs+8c2Z+uARQquL0W4eICqExwzLT//JM5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709592701; c=relaxed/simple;
	bh=YhKdEjJYfUK5PGnDdyu7Ox1LTeRZMNbyU1Aoe9uCC1k=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:To:Cc:Subject:
	 References:In-Reply-To; b=fGa1E4wzttQZDHWcN03J8Uv0Kw2GEv39ImjkrIvIihMDEiHb+0Qq/9eRuEPxRy8oVBZoY4kr7Sk/eVhtgAfTFHssQ7NvCmTJKesvQHU9vT8Lo0MyTtCFoLkUn1TRsCqtpDGubdWVwHj+T3yTysmp4G84R3fJtXk+lWW/DgJt138=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qH7ghQWU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD380C433C7;
	Mon,  4 Mar 2024 22:51:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709592701;
	bh=YhKdEjJYfUK5PGnDdyu7Ox1LTeRZMNbyU1Aoe9uCC1k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qH7ghQWUmWQSFGS9dlXBIbNWYEOOV2jZSCJ5jRYtKU+tKXVwRV3OzXUDwdQCSfBcu
	 ILXJufnw4gwvdFpU28/Ac0v+55ZUgCnLN5hWfIViC8GuEbcJHk+1n1WNQH1F9ozfck
	 eOYFpNFCdzT4p8oxHi08FIGAODLqPl/HQsDxr51Apj5rdpBtdjjRXT6esVMAVPcbJC
	 N2Mv+13ROf8vZNFvpecIxb3OxpBw7iuSSafDNlQVCRvmBjMlNu9DQ2/ucT98HNiR5g
	 yDDWTIMc4cPTIFkdL1o9fRuyQiBDkdEhahBQtZRB8OyaQAb2z8VmXTSy4DkvZFnuTu
	 aBWa4hCcB5ErA==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 05 Mar 2024 00:51:33 +0200
Message-Id: <CZLC14YSOYS5.XWHWWQYZCFZ3@suppilovahvero>
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "Paul Moore" <paul@paul-moore.com>, "David Gstir" <david@sigma-star.at>,
 "Mimi Zohar" <zohar@linux.ibm.com>, "David Howells" <dhowells@redhat.com>
Cc: "James Bottomley" <jejb@linux.ibm.com>, "Herbert Xu"
 <herbert@gondor.apana.org.au>, "David S. Miller" <davem@davemloft.net>,
 "Shawn Guo" <shawnguo@kernel.org>, "Jonathan Corbet" <corbet@lwn.net>,
 "Sascha Hauer" <s.hauer@pengutronix.de>, "Pengutronix Kernel Team"
 <kernel@pengutronix.de>, "Fabio Estevam" <festevam@gmail.com>, "NXP Linux
 Team" <linux-imx@nxp.com>, "Ahmad Fatoum" <a.fatoum@pengutronix.de>, "sigma
 star Kernel Team" <upstream+dcp@sigma-star.at>, "Li Yang"
 <leoyang.li@nxp.com>, "James Morris" <jmorris@namei.org>, "Serge E. Hallyn"
 <serge@hallyn.com>, "Paul E. McKenney" <paulmck@kernel.org>, "Randy Dunlap"
 <rdunlap@infradead.org>, "Catalin Marinas" <catalin.marinas@arm.com>,
 "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, "Tejun Heo"
 <tj@kernel.org>, "Steven Rostedt (Google)" <rostedt@goodmis.org>,
 <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <linux-integrity@vger.kernel.org>, <keyrings@vger.kernel.org>,
 <linux-crypto@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
 <linuxppc-dev@lists.ozlabs.org>, <linux-security-module@vger.kernel.org>
Subject: Re: [PATCH v5 0/6] DCP as trusted keys backend
X-Mailer: aerc 0.15.2
References: <20231215110639.45522-1-david@sigma-star.at>
 <CAHC9VhSRjwN=a9=V--m46_xh4fQNwZ9781YBCDpAmAV1mofhQg@mail.gmail.com>
In-Reply-To: <CAHC9VhSRjwN=a9=V--m46_xh4fQNwZ9781YBCDpAmAV1mofhQg@mail.gmail.com>

On Tue Dec 19, 2023 at 2:45 AM EET, Paul Moore wrote:
> On Fri, Dec 15, 2023 at 6:07=E2=80=AFAM David Gstir <david@sigma-star.at>=
 wrote:
> >
> > This is a revival of the previous patch set submitted by Richard Weinbe=
rger:
> > https://lore.kernel.org/linux-integrity/20210614201620.30451-1-richard@=
nod.at/
> >
> > v4 is here:
> > https://lore.kernel.org/keyrings/20231024162024.51260-1-david@sigma-sta=
r.at/
> >
> > v4 -> v5:
> > - Make Kconfig for trust source check scalable as suggested by Jarkko S=
akkinen
> > - Add Acked-By from Herbert Xu to patch #1 - thanks!
> > v3 -> v4:
> > - Split changes on MAINTAINERS and documentation into dedicated patches
> > - Use more concise wording in commit messages as suggested by Jarkko Sa=
kkinen
> > v2 -> v3:
> > - Addressed review comments from Jarkko Sakkinen
> > v1 -> v2:
> > - Revive and rebase to latest version
> > - Include review comments from Ahmad Fatoum
> >
> > The Data CoProcessor (DCP) is an IP core built into many NXP SoCs such
> > as i.mx6ull.
> >
> > Similar to the CAAM engine used in more powerful SoCs, DCP can AES-
> > encrypt/decrypt user data using a unique, never-disclosed,
> > device-specific key. Unlike CAAM though, it cannot directly wrap and
> > unwrap blobs in hardware. As DCP offers only the bare minimum feature
> > set and a blob mechanism needs aid from software. A blob in this case
> > is a piece of sensitive data (e.g. a key) that is encrypted and
> > authenticated using the device-specific key so that unwrapping can only
> > be done on the hardware where the blob was wrapped.
> >
> > This patch series adds a DCP based, trusted-key backend and is similar
> > in spirit to the one by Ahmad Fatoum [0] that does the same for CAAM.
> > It is of interest for similar use cases as the CAAM patch set, but for
> > lower end devices, where CAAM is not available.
> >
> > Because constructing and parsing the blob has to happen in software,
> > we needed to decide on a blob format and chose the following:
> >
> > struct dcp_blob_fmt {
> >         __u8 fmt_version;
> >         __u8 blob_key[AES_KEYSIZE_128];
> >         __u8 nonce[AES_KEYSIZE_128];
> >         __le32 payload_len;
> >         __u8 payload[];
> > } __packed;
> >
> > The `fmt_version` is currently 1.
> >
> > The encrypted key is stored in the payload area. It is AES-128-GCM
> > encrypted using `blob_key` and `nonce`, GCM auth tag is attached at
> > the end of the payload (`payload_len` does not include the size of
> > the auth tag).
> >
> > The `blob_key` itself is encrypted in AES-128-ECB mode by DCP using
> > the OTP or UNIQUE device key. A new `blob_key` and `nonce` are generate=
d
> > randomly, when sealing/exporting the DCP blob.
> >
> > This patchset was tested with dm-crypt on an i.MX6ULL board.
> >
> > [0] https://lore.kernel.org/keyrings/20220513145705.2080323-1-a.fatoum@=
pengutronix.de/
> >
> > David Gstir (6):
> >   crypto: mxs-dcp: Add support for hardware-bound keys
> >   KEYS: trusted: improve scalability of trust source config
> >   KEYS: trusted: Introduce NXP DCP-backed trusted keys
> >   MAINTAINERS: add entry for DCP-based trusted keys
> >   docs: document DCP-backed trusted keys kernel params
> >   docs: trusted-encrypted: add DCP as new trust source
> >
> >  .../admin-guide/kernel-parameters.txt         |  13 +
> >  .../security/keys/trusted-encrypted.rst       |  85 +++++
> >  MAINTAINERS                                   |   9 +
> >  drivers/crypto/mxs-dcp.c                      | 104 +++++-
> >  include/keys/trusted_dcp.h                    |  11 +
> >  include/soc/fsl/dcp.h                         |  17 +
> >  security/keys/trusted-keys/Kconfig            |  18 +-
> >  security/keys/trusted-keys/Makefile           |   2 +
> >  security/keys/trusted-keys/trusted_core.c     |   6 +-
> >  security/keys/trusted-keys/trusted_dcp.c      | 311 ++++++++++++++++++
> >  10 files changed, 562 insertions(+), 14 deletions(-)
> >  create mode 100644 include/keys/trusted_dcp.h
> >  create mode 100644 include/soc/fsl/dcp.h
> >  create mode 100644 security/keys/trusted-keys/trusted_dcp.c
>
> Jarkko, Mimi, David - if this patchset isn't already in your review
> queue, can you take a look at it from a security/keys perspective?
>
> Thanks.

I gave my 5 cents. I had no intention not to review it, somehow just
slipped. I try to do my best but sometimes this still does happen :-) So
please ping me if there is radio silence.=20

BR, Jarkko

