Return-Path: <linux-kernel+bounces-168425-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A34D8BB86F
	for <lists+linux-kernel@lfdr.de>; Sat,  4 May 2024 01:45:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6B72C1C20FB0
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 23:45:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97BF884FDA;
	Fri,  3 May 2024 23:45:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BZoQANMu"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC5B550297;
	Fri,  3 May 2024 23:45:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714779915; cv=none; b=oSTMq9GG4h37BMi1NRTULlqt77jTZBITzTPmFXc8x33/Zw7J6WOVFpiWstHD2srIBan/GKY3tnnROY/Oj5oCuZHP5Yhjn2OeVOMlI7YneNZKpz44W+Cjim0jVB/3moRS0PI4DhcA+9D+B2ImwJNeLNdrrgrwwiF1e4y0Nuvlqiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714779915; c=relaxed/simple;
	bh=DlRlFVsHUqhvPdkfip9DnPPB8Y/bNEuxfZL0IMIFLYk=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=IK2dpdmna/eH20gp4kR7W/eFBiJlHaCnkgIzOhkq+NmzuTz2HPTNTkm++MB85lh9SE6dVoaQ+TIPCOMegadBRVf1VdzgpVIhodFR5/+Kf2synHhoTG6jegBj7VIzNVlD3DVpGkivinLfytkJweWMPI0XtN5sfv3TtsKSLQR5s/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BZoQANMu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF2F4C116B1;
	Fri,  3 May 2024 23:45:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714779915;
	bh=DlRlFVsHUqhvPdkfip9DnPPB8Y/bNEuxfZL0IMIFLYk=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=BZoQANMu5xxuHXX714j4tlKziMZOQFhvYDjQLmlnL6HneFF17oZkflc23OPLrUjm6
	 l96OiS8KxIKEs5kczliHGVnsn10tT68fYsWkcfAYPWXZ1XvmzGoHvUkp1ZxmKrWpDC
	 s7td0SjDAOIEg2AzAYplNdCnrGMHYph1oVDt7Xqi8J5CfL0NaerWmmjCQ7oBTxZkFN
	 hi9mYVwSgjD715rrjl4RTDFa7RFivlIKP+ftuX65ggz1X4tvvvHVoGTWJAtpHvh7Rc
	 WVqUjjU2Mp8QltWKiPa2PEtJQ3MsGF6I9PdUxd++kH3e/soRIgYBMoF7CMkgpxB3MJ
	 71FCga1RH5W5w==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sat, 04 May 2024 02:45:05 +0300
Message-Id: <D10EQTNQXQYO.1QBNX5LMFU8NK@kernel.org>
Cc: "Mimi Zohar" <zohar@linux.ibm.com>, "James Bottomley"
 <jejb@linux.ibm.com>, "Herbert Xu" <herbert@gondor.apana.org.au>, "David S.
 Miller" <davem@davemloft.net>, "Kshitiz Varshney"
 <kshitiz.varshney@nxp.com>, "Shawn Guo" <shawnguo@kernel.org>, "Jonathan
 Corbet" <corbet@lwn.net>, "Sascha Hauer" <s.hauer@pengutronix.de>,
 "kernel@pengutronix.de" <kernel@pengutronix.de>, "Fabio Estevam"
 <festevam@gmail.com>, "dl-linux-imx" <linux-imx@nxp.com>, "Ahmad Fatoum"
 <a.fatoum@pengutronix.de>, "sigma star Kernel Team"
 <upstream+dcp@sigma-star.at>, "David Howells" <dhowells@redhat.com>, "Li
 Yang" <leoyang.li@nxp.com>, "Paul Moore" <paul@paul-moore.com>, "James
 Morris" <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, "Paul E.
 McKenney" <paulmck@kernel.org>, "Randy Dunlap" <rdunlap@infradead.org>,
 "Catalin Marinas" <catalin.marinas@arm.com>, "Rafael J. Wysocki"
 <rafael.j.wysocki@intel.com>, "Tejun Heo" <tj@kernel.org>, "Steven Rostedt
 (Google)" <rostedt@goodmis.org>, "linux-doc@vger.kernel.org"
 <linux-doc@vger.kernel.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, "linux-integrity@vger.kernel.org"
 <linux-integrity@vger.kernel.org>, "keyrings@vger.kernel.org"
 <keyrings@vger.kernel.org>, "linux-crypto@vger.kernel.org"
 <linux-crypto@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>, "linuxppc-dev@lists.ozlabs.org"
 <linuxppc-dev@lists.ozlabs.org>, "linux-security-module@vger.kernel.org"
 <linux-security-module@vger.kernel.org>, "Richard Weinberger"
 <richard@nod.at>, "David Oberhollenzer"
 <david.oberhollenzer@sigma-star.at>, "Varun Sethi" <V.Sethi@nxp.com>,
 "Gaurav Jain" <gaurav.jain@nxp.com>, "Pankaj Gupta" <pankaj.gupta@nxp.com>
Subject: Re: [EXT] [PATCH v8 6/6] docs: trusted-encrypted: add DCP as new
 trust source
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "David Gstir" <david@sigma-star.at>
X-Mailer: aerc 0.17.0
References: <20240403072131.54935-1-david@sigma-star.at>
 <20240403072131.54935-7-david@sigma-star.at>
 <D0ALT2QCUIYB.8NFTE7Z18JKN@kernel.org>
 <DB6PR04MB3190F6B78FF3760EBCC14E758F072@DB6PR04MB3190.eurprd04.prod.outlook.com> <7783BAE9-87DA-4DD5-ADFA-15A9B55EEF39@sigma-star.at> <DB6PR04MB319062F2A19A250BA22C12D48F1A2@DB6PR04MB3190.eurprd04.prod.outlook.com> <DB9357A7-0B20-4E57-AF66-3DD0F55ED538@sigma-star.at>
In-Reply-To: <DB9357A7-0B20-4E57-AF66-3DD0F55ED538@sigma-star.at>

On Tue Apr 30, 2024 at 3:03 PM EEST, David Gstir wrote:
> Hi Jarkko,
>
> > On 30.04.2024, at 13:48, Kshitiz Varshney <kshitiz.varshney@nxp.com> wr=
ote:
> >=20
> > Hi David,
> >=20
> >> -----Original Message-----
> >> From: David Gstir <david@sigma-star.at>
> >> Sent: Monday, April 29, 2024 5:05 PM
> >> To: Kshitiz Varshney <kshitiz.varshney@nxp.com>
>
>
> >>=20
> >> Did you get around to testing this?
> >> I=E2=80=99d greatly appreciate a Tested-by for this. :-)
> >>=20
> >> Thanks!
> >> BR, David
> >=20
> > Currently, I am bit busy with other priority activities. It will take t=
ime to test this patch set.
>
> How should we proceed here?
> Do we have to miss another release cycle, because of a Tested-by?
>
> If any bugs pop up I=E2=80=99ll happily fix them, but at the moment it ap=
pears to be more of a formality.
> IMHO the patch set itself is rather small and has been thoroughly reviewe=
d to ensure that any huge
> issues would already have been caught by now.

I don't mind picking this actually since unless you consume it,
it should not get in the way. I'll pick it during the weekend.
Thanks for reminding.

BR, Jarkko

