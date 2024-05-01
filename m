Return-Path: <linux-kernel+bounces-165160-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E8318B88D3
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 12:55:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7F669B23016
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 10:55:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26FAA53E09;
	Wed,  1 May 2024 10:55:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rere.qmqm.pl header.i=@rere.qmqm.pl header.b="STxE3S9v"
Received: from rere.qmqm.pl (rere.qmqm.pl [91.227.64.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 196B150A9D
	for <linux-kernel@vger.kernel.org>; Wed,  1 May 2024 10:55:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.227.64.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714560938; cv=none; b=afjfZgr5jFYvmGB5IEYykp4Ag+ShUX8GIuK/M+QP+BXOsaCEInblPVupauKyuPO5GMh+njU01HR4Bnd1/swPvk9YCxMttGOmv1Vt3jxzV3cnC5cX6GgBNPTrAq+ZaRCOLAimmjyyS6D66g9uASBXayFq9M6/W87atuht6wUsnL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714560938; c=relaxed/simple;
	bh=qhf5AF1OezFa8YQN7goIJJBnh70oq/0z5QrJY3rdkTU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XVBb1MsqVoYzJ9ApZG5XP/5KSguXPzYSZ2iCOU+Ke9wL2mZVkmIcSrc++sARzku0XN/0djdB0N7gtUeBgqqKi76kW9OQBJPyiyqdgI4MEPHO1tPzwvt7JIYp3q4//hhc5F/wUHYe1VfC5GOCkGBfX0F5N78Reu1vUfpqB3xVAtA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=rere.qmqm.pl; spf=pass smtp.mailfrom=rere.qmqm.pl; dkim=pass (2048-bit key) header.d=rere.qmqm.pl header.i=@rere.qmqm.pl header.b=STxE3S9v; arc=none smtp.client-ip=91.227.64.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=rere.qmqm.pl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rere.qmqm.pl
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rere.qmqm.pl; s=1;
	t=1714560927; bh=qhf5AF1OezFa8YQN7goIJJBnh70oq/0z5QrJY3rdkTU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=STxE3S9vrugOsg8R52GCFheLHk0i559Wli/REbzGmQE6/a0fjnrZrR0e+TmTuDBnu
	 2c5Siu2TzcpvATIgY7N+rGdSoQxl+g3wn07X6FJXdQkTbc2B6pQR7PAWNBdf/cY+Zo
	 eslpW0ACR4X+0Hd5jyXvkC4VKL7Fj60ES2uevuVK4TLYl56Cos+kjmGsTr3kte7rxM
	 B9XPsXlUvgRExOc+ZCA9BnCOHRIagat9WrLnw3HMA81dO1A05CM0D4I8D0ODaZx1u4
	 KjyqVTiU4Vd55zhPc535OdtqBLKMdpcrjL43mT6hS1ejfsQiLxQ4wUjiCC16YF82Mu
	 8nYAkkoRuUFMg==
Received: from remote.user (localhost [127.0.0.1])
	by rere.qmqm.pl (Postfix) with ESMTPSA id 4VTv9W0V5szBL;
	Wed,  1 May 2024 12:55:26 +0200 (CEST)
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 1.0.5 at mail
Date: Wed, 1 May 2024 12:55:25 +0200
From: =?iso-8859-2?Q?Micha=B3_Miros=B3aw?= <mirq-linux@rere.qmqm.pl>
To: Mark Brown <broonie@kernel.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 04/12] regulator/core: regulator_bulk_get: remove
 redundant NULL stores
Message-ID: <ZjIfnYgCvA8tcchP@qmqm.qmqm.pl>
References: <cover.1714399603.git.mirq-linux@rere.qmqm.pl>
 <1ec1a8090c0e316ee005629c24f2779211e0aebf.1714399603.git.mirq-linux@rere.qmqm.pl>
 <Zi_EWBtMFISQJcHE@finisterre.sirena.org.uk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Zi_EWBtMFISQJcHE@finisterre.sirena.org.uk>

On Tue, Apr 30, 2024 at 01:01:28AM +0900, Mark Brown wrote:
> On Mon, Apr 29, 2024 at 04:45:28PM +0200, Micha³ Miros³aw wrote:
> > On error, callers of regulator_bulk_get() pass the error up and don't
> > use the pointers in consumers[]. The function is documented to release
> > all regulators if any request fails.
> 
> This doesn't seem good from a robustness point of view and should be
> nowhere near a fast path.

I take it you'd prefer to have the function fixed to clear the other
pointers? I'll do that in the v3 then.

Best Regards
Micha³ Miros³aw

