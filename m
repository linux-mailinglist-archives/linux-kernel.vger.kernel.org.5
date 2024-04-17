Return-Path: <linux-kernel+bounces-149292-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AE6D8A8EF2
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 00:48:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B12C41F22274
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 22:48:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AA1D81722;
	Wed, 17 Apr 2024 22:48:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S/t6XKrH"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46A583FB2C;
	Wed, 17 Apr 2024 22:48:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713394108; cv=none; b=oCkwqShZatewXiOcF/4Tl6n9FQ5wJJ6nyUFk62FlJW650yRm6s2FQTilhJ1+duARXNDm7G6ABlvwNAY7L567byQE3VZQ6GMKMo5O7PyglD+FYyOEhsZ8JOYK/KDTNLtdhYWg1TfhtkWBjotcuMm70zA+NxKxy6WY/iSnPU+/ktE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713394108; c=relaxed/simple;
	bh=o7dOVm2YqXK7IllOBDvzNWuweYQR21eggGOqifZb6Dw=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:Cc:Subject:From:
	 References:In-Reply-To; b=uYKwSC3xZpV6V59dX0U7jVco28Tpx+SQ1pyq7o8UB4jjvip05Kv2qYlCCGl7mPn6f7a+iU+E9DMVFlb0L28onphp7NrHo/QFd//0acibwJZWHhedNItEn2qH4sNhEZBdx2rJJ4OacvI2QWHATeVd/L10hgmePv7UmY8Qtw1p8Io=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S/t6XKrH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 738DDC072AA;
	Wed, 17 Apr 2024 22:48:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713394107;
	bh=o7dOVm2YqXK7IllOBDvzNWuweYQR21eggGOqifZb6Dw=;
	h=Date:To:Cc:Subject:From:References:In-Reply-To:From;
	b=S/t6XKrHtul1nc9DySSfVev28DgcyuGWpMsGsAKAILgCx6II9ImQfhIRTTx1RoOgB
	 uLAT9op2P4IKLo7r16DGBcRtbs6qYjZyTD9bzb+stHsaU1Fb734qY9syc02MOXgRuA
	 SpfcGDcQdzR3BK2EYxnO/m/apKn51irDO11QVazUlZXQWMjatvkEuOMQRdpAmxMT4/
	 ZeKLtmVycc8BXb7tseQ24NTetKTHEVpXW8kgh8TjhUeKrmQqsM5qg2oyOsYF/Q2MOR
	 QggSQDTWxv3YddVabgcppII8dYMJl+sjCHOS2R28XixBHZMqwTlCuwihG+yX8Stnn7
	 2Nsdy8xugXBow==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 18 Apr 2024 01:48:24 +0300
Message-Id: <D0MRIPCIFS8O.1G6VY45KFAMBE@kernel.org>
To: "Luck, Tony" <tony.luck@intel.com>, "Paul Menzel"
 <pmenzel@molgen.mpg.de>, "Peter Huewe" <peterhuewe@gmx.de>
Cc: "Jason Gunthorpe" <jgg@ziepe.ca>, "linux-integrity@vger.kernel.org"
 <linux-integrity@vger.kernel.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, "patches@lists.linux.dev"
 <patches@lists.linux.dev>
Subject: Re: [PATCH v3 42/74] x86/cpu/vfm: Update tpm files
From: "Jarkko Sakkinen" <jarkko@kernel.org>
X-Mailer: aerc 0.17.0
References: <20240416211941.9369-1-tony.luck@intel.com>
 <20240416212202.9452-1-tony.luck@intel.com>
 <23faa727-4b1e-4eb2-9e43-c10b8fadaa23@molgen.mpg.de>
 <SJ1PR11MB608327EBA734DB11B2DAFC84FC0F2@SJ1PR11MB6083.namprd11.prod.outlook.com>
In-Reply-To: <SJ1PR11MB608327EBA734DB11B2DAFC84FC0F2@SJ1PR11MB6083.namprd11.prod.outlook.com>

On Wed Apr 17, 2024 at 7:43 PM EEST, Luck, Tony wrote:
> > Thank you for your patch. It=E2=80=99d be great if you changed the comm=
it=20
> > message summary/title to be more specific. Currently, the short log,=20
> > `git log --oneline`, is not very meaningful. Maybe:
> >
> > tpm: Use new VFM macro INTEL_ATOM_AIRMONT
> >
> > or
> >
> > x86/cpu/vfm: Use macro INTEL_ATOM_AIRMONT in tpm
>
> Paul,
>
> With 74 patches in this series there was a lot of automation. I'll
> see about updating "Subject:" lines to match subsystem conventions
> before these are applied.
>
> Apart from that, are you OK with the contents of this patch?
>
> -Tony

For the possible subject-line change: please *do not* remove my reviewed-by=
 :-)

BR, Jarkko

