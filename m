Return-Path: <linux-kernel+bounces-99499-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B5F1878948
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 21:07:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 325161F21844
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 20:07:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CDAF56777;
	Mon, 11 Mar 2024 20:07:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qpKTJnaU"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8BAB52F82;
	Mon, 11 Mar 2024 20:07:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710187648; cv=none; b=A5w1up8yzpky1u/PEFT8k6dnT6lHOVUmvkFEMgn+mOL5Pl03S4XRIoE+gVMxtD5Jcf2Cl1bOt/ScmOHJdARO/XLXceZFo/trIwv7IKVFVntnni+JKfLMzGtdGSWzbFgQwDi+q9vehOiyGdaxeOH7owDlIXyd6txnBSUs9UQDy9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710187648; c=relaxed/simple;
	bh=WBtBCCMn2JMwUS5VVGHL+yTt7qkPpG1ZJQA8yWr+M5w=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=bG6w2vd26Z3a9bPZd5Yu5/LbJz2G/MAXsAP21Sk5WRQrcYLPnk+seuRBTlaseyTIhE12Pi7Hn83Llf/p2S47pB6NkbeTrHANpPuFkxKyQP2rJfjrV5neu4W8eT8Vp+cHS9n7Tl1JUWl1JgIqFI+IofAwvqx+hSQdOIQWbbn2Zro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qpKTJnaU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8DBBCC433F1;
	Mon, 11 Mar 2024 20:07:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710187648;
	bh=WBtBCCMn2JMwUS5VVGHL+yTt7qkPpG1ZJQA8yWr+M5w=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=qpKTJnaURjnr9qyMxxS06UflehxFUN6v0OqYQKl6DqRi1nweRVVV/ivK1D5TMqyUe
	 Go3Ar0AuaK6I7kVk1CdNT9w1bSz26h92HPVVGtPkpGcCqw3VXKlZSK1lxVU3tFP1hu
	 CBoQTBN7JDL2FRIWrHHc8Gu09GGXq5pYvbFPRFJBNc3GXeL54y441hKHV+TmCLqTo+
	 ViEDNTStK3tlBuz3EG/eoeOvj52RkgMZD13LEiA/dOCeFD8J3qagtJUO2vFm6a2XWp
	 ZugulwiUUCbthW5vQ8oE9hwGR+oRtQY9o46qnBscOszPbc5RGMAMEMqkv54kJKxdHs
	 17b+JtrrT6lWg==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 11 Mar 2024 22:07:19 +0200
Message-Id: <CZR6X7KLX6NC.1BH2NHDTNL3C@kernel.org>
Cc: "Mimi Zohar" <zohar@linux.ibm.com>, "James Bottomley"
 <jejb@linux.ibm.com>, "Herbert Xu" <herbert@gondor.apana.org.au>, "David S.
 Miller" <davem@davemloft.net>, "Shawn Guo" <shawnguo@kernel.org>, "Jonathan
 Corbet" <corbet@lwn.net>, "Sascha Hauer" <s.hauer@pengutronix.de>,
 "kernel@pengutronix.de" <kernel@pengutronix.de>, "Fabio Estevam"
 <festevam@gmail.com>, "NXP Linux Team" <linux-imx@nxp.com>, "Ahmad Fatoum"
 <a.fatoum@pengutronix.de>, "sigma star Kernel Team"
 <upstream+dcp@sigma-star.at>, "David Howells" <dhowells@redhat.com>, "Li
 Yang" <leoyang.li@nxp.com>, "Paul Moore" <paul@paul-moore.com>, "James
 Morris" <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, "Paul E.
 McKenney" <paulmck@kernel.org>, "Randy Dunlap" <rdunlap@infradead.org>,
 "Catalin Marinas" <catalin.marinas@arm.com>, "Rafael J. Wysocki"
 <rafael.j.wysocki@intel.com>, "Tejun Heo" <tj@kernel.org>, "Steven Rostedt
 (Google)" <rostedt@goodmis.org>, <linux-doc@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
 "keyrings@vger.kernel.org" <keyrings@vger.kernel.org>,
 "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
 <linux-arm-kernel@lists.infradead.org>, <linuxppc-dev@lists.ozlabs.org>,
 "linux-security-module@vger.kernel.org"
 <linux-security-module@vger.kernel.org>, "Richard Weinberger"
 <richard@nod.at>, "David Oberhollenzer" <david.oberhollenzer@sigma-star.at>
Subject: Re: [PATCH v6 3/6] KEYS: trusted: Introduce NXP DCP-backed trusted
 keys
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "David Gstir" <david@sigma-star.at>
X-Mailer: aerc 0.17.0
References: <20240307153842.80033-1-david@sigma-star.at>
 <20240307153842.80033-4-david@sigma-star.at>
 <CZNRMR5YZPQO.1QBLW62A6S840@kernel.org>
 <655221B7-634C-4493-A781-CF014DFFC8BF@sigma-star.at>
In-Reply-To: <655221B7-634C-4493-A781-CF014DFFC8BF@sigma-star.at>

On Fri Mar 8, 2024 at 9:17 AM EET, David Gstir wrote:
> Hi Jarkko,
>
> > On 07.03.2024, at 20:30, Jarkko Sakkinen <jarkko@kernel.org> wrote:
>
> [...]
>
> >> +
> >> +static int trusted_dcp_init(void)
> >> +{
> >> + int ret;
> >> +
> >> + if (use_otp_key)
> >> + pr_info("Using DCP OTP key\n");
> >> +
> >> + ret =3D test_for_zero_key();
> >> + if (ret) {
> >> + pr_err("Test for zero'ed keys failed: %i\n", ret);
> >=20
> > I'm not sure whether this should err or warn.
> >=20
> > What sort of situations can cause the test the fail (e.g.
> > adversary/interposer, bad configuration etc.).
>
> This occurs when the hardware is not in "secure mode". I.e. it=E2=80=99s =
a bad configuration issue.
> Once the board is properly configured, this will never trigger again.
> Do you think a warning is better for this then?

Bad configuration is not unexpected configuration so it cannot possibly
be an error situation as far as Linux is considered. So warning is=20
appropriate here I'd figure.

BR, Jarkko

