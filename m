Return-Path: <linux-kernel+bounces-61186-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5440C850E8A
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 09:05:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 79B351C210B5
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 08:05:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68AD68BFE;
	Mon, 12 Feb 2024 08:05:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="TB15u+Cc"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B3FC79CB
	for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 08:05:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707725109; cv=none; b=iyQSsbwEvrYJ19EbtoMceE/aq4QYPSDlghK500WZIqTx3LQ2GosodegrYICF4TW9e19cnK+Cvdh1wNdqVmmOMKNldwbewzZndxhlCDAlx4lWL2+eHqhuPm2kJzOR1Fs74+F11yq1o1ZuXEMScdB4I+ZgkRF1OGfLR8sbdrumCB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707725109; c=relaxed/simple;
	bh=FAM38lwY80UommpGFNgcSxiYtAJjIUzEHyg8xALj4IU=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kTlFJeQdbcymyKhMJL3ytz+D55QLxXVzl3Q9ghsri5/7j1R2j8jXZpGpp2U2513F5GZ1mxQeR1sztXXjYVm9h1LiANFyTNWiyEnsx85GzInn+gkKPpyjg1iL6x7a8XGwDifxeG0loTXdKmXLHXDKZ0Wh3irEKFyVFXgR+h9MyXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=TB15u+Cc; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1707725107; x=1739261107;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=FAM38lwY80UommpGFNgcSxiYtAJjIUzEHyg8xALj4IU=;
  b=TB15u+CcSzi9ONZR3QxZoiXDXSNBBBRhA//kPr1hKJg4owPLJXEu8yCc
   4ur1Nifa8J33j+/HI9ffo1JGN7AjZBPC+rWCvyJ8HgPT5bzBTGN/M/M5/
   z9fNcZ7MUxwEfmO2izDD8AcBRGId2zlzUs2pWvOBcl0PAczJdZaaxJEml
   LeoDeZurx4asLU2RU2e9Tj7sIR93tU3zWRfi+Ohf5jE5q5beqY8vpnWaC
   BQy2OwpeeiP6YzK8VPgp7bdAVAzkdeHHtKvfe2iV0cQtOp6CXa40A/aEM
   9boxzRHQ2S4CDXj4DEOVrCpOdg80c+aKZpGxjQ2UQe25ztM7mOEu5dYmp
   g==;
X-CSE-ConnectionGUID: MFXfYCtzSm6hwR9MEXE18w==
X-CSE-MsgGUID: qduaQVHLTM6iRCPKeAs7Nw==
X-IronPort-AV: E=Sophos;i="6.05,262,1701154800"; 
   d="asc'?scan'208";a="16103485"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 12 Feb 2024 01:05:05 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 12 Feb 2024 01:04:25 -0700
Received: from wendy (10.10.85.11) by chn-vm-ex03.mchp-main.com (10.10.85.151)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35 via Frontend
 Transport; Mon, 12 Feb 2024 01:04:24 -0700
Date: Mon, 12 Feb 2024 08:03:44 +0000
From: Conor Dooley <conor.dooley@microchip.com>
To: Eric Chan <ericchancf@google.com>
CC: <paul.walmsley@sifive.com>, <palmer@dabbelt.com>, <aou@eecs.berkeley.edu>,
	<linux-riscv@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] riscv/fence: Consolidate fence definitions and define
 __{mb,rmb,wmb}
Message-ID: <20240212-projector-dangle-7815fa2f7415@wendy>
References: <20240209125048.4078639-1-ericchancf@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="ebJOijojLM2Tum/8"
Content-Disposition: inline
In-Reply-To: <20240209125048.4078639-1-ericchancf@google.com>

--ebJOijojLM2Tum/8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 09, 2024 at 12:50:48PM +0000, Eric Chan wrote:
> Disparate fence implementations are consolidated into fence.h.
>=20
> Introduce __{mb,rmb,wmb}, and rely on the generic definitions
> for {mb,rmb,wmb}. A first consequence is that __{mb,rmb,wmb}
> map to a compiler barrier on !SMP (while their definition remains
> unchanged on SMP).
>=20
> Introduce RISCV_FULL_BARRIER and use in arch_atomic* function.
> like RISCV_ACQUIRE_BARRIER and RISCV_RELEASE_BARRIER, The fence
> instruction can be eliminated When SMP is not in use.
>=20
> Also clean up the warning with scripts/checkpatch.pl.
>=20
> Signed-off-by: Eric Chan <ericchancf@google.com>

In all configs:
=2E./arch/riscv/include/asm/fence.h:7:10: error: expected expression before=
 '__asm__'
https://patchwork.kernel.org/project/linux-riscv/patch/20240209125048.40786=
39-1-ericchancf@google.com/

Cheers,
Conor.

--ebJOijojLM2Tum/8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZcnQ4AAKCRB4tDGHoIJi
0sdrAP43QWVvr0zKgeBa6w6Y/sgMo/4Pcvh3acMhUeUKhio0qAD9H+0DWZR1hpVa
voHkI4IVSQqkjJRiydpEv2XrMfDviA0=
=ib6c
-----END PGP SIGNATURE-----

--ebJOijojLM2Tum/8--

