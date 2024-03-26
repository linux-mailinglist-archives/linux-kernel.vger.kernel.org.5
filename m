Return-Path: <linux-kernel+bounces-118992-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AFC288C25B
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 13:39:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CD4DE1C3FA8A
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 12:39:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDBB16EB52;
	Tue, 26 Mar 2024 12:39:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pT3dMlaH"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F1E86FE16
	for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 12:39:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711456751; cv=none; b=UCYf7o3bmqEHSA8cVzwGpt+q0MHdKCC5VcbRhF38pEwcIcJz0YnY92riYjfjhiwnV/AzJ7IMOpKG2+nHVYPOhj69TEIRfEYvWfw47Pnxdywr/I4TibAY5XXIBUPyMqPi4e7EzNUi1cmHC6tWl6kJZEYYyCkiW+q7Mmmm14s27sY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711456751; c=relaxed/simple;
	bh=gKYXKXmKzztmCCngPFAyJ7ePQbPTHg+Ija1pFAqB7/M=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=ZVChO0r88qKbCiX3w40Vmcb9iaxA3QUNPFx0K9Wf4CxvhwZQEECz7HPLsyJFlZlFFrt1CxJ4nq3BNJ0jldkoLt8g7DLJSi95PU7dZh1Q9NpZWqildeFJYOWjMpmxRlSCt3QcJYJuMZrFnT1rAFhmA+r28PlYWlFfPS87E/WKShk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pT3dMlaH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8EDEC43390;
	Tue, 26 Mar 2024 12:39:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711456749;
	bh=gKYXKXmKzztmCCngPFAyJ7ePQbPTHg+Ija1pFAqB7/M=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=pT3dMlaHShISK0CPdxdAGTtvreEU8aXwdrtIRJzIxyvtHd6+dBhO1ue7jZMmc9doG
	 LnlFG8dn3FQvH2f5nmCBjRwxqudKfaKZFf0QZy5ghV8OYYqmvY514WziS1hgaF/cUY
	 JIDdj0nPveGCJmIyD3qxHlnjMiXbKCfi84vStrofpho8pvYars1G28PeVL2iwm153/
	 CXMFjiUZNIjUOTHysWKHZO7f5eV3Wtc9EEYSWwZnF+CNPOontRuk39HdsEbl243c00
	 s18iIRCWjtNaJd1ZURWrHeyhGA3Aw0I81D0mTn6/sqPFRg+pKHyP8mI9SUCCXcVBQy
	 yuwj0UrcaiNBQ==
From: Mark Brown <broonie@kernel.org>
To: Liam Girdwood <lgirdwood@gmail.com>, 
 =?utf-8?q?Andr=C3=A9_Apitzsch?= <git@apitzsch.eu>
Cc: linux-kernel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht
In-Reply-To: <20240325-of_tps65132-v1-1-86a5f7ef4ede@apitzsch.eu>
References: <20240325-of_tps65132-v1-1-86a5f7ef4ede@apitzsch.eu>
Subject: Re: [PATCH] regulator: tps65132: Add of_match table
Message-Id: <171145674862.65165.10597428092841481583.b4-ty@kernel.org>
Date: Tue, 26 Mar 2024 12:39:08 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.14-dev

On Mon, 25 Mar 2024 19:05:09 +0100, André Apitzsch wrote:
> Add of_match table for "ti,tps65132" compatible string.
> This fixes automatic driver loading when using device-tree,
> and if built as a module like major linux distributions do.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next

Thanks!

[1/1] regulator: tps65132: Add of_match table
      commit: a469158eaf8f4b10263b417856d923dfa38ae96d

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark


