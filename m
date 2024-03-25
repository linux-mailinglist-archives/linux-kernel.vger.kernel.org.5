Return-Path: <linux-kernel+bounces-117631-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D63888AD80
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 19:16:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AF7121C3EEBD
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 18:16:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1648259B52;
	Mon, 25 Mar 2024 17:44:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jOR+MgPN"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5901B59B61;
	Mon, 25 Mar 2024 17:44:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711388691; cv=none; b=a4jGRqMaXTnkhioKxp5HDgGdp3FFrCp46qumzciebJTKlfDOCnETR1g5bDgAmb795w66H6aSX3zx9A5UlRvawoO+Tq0H0W8GMMbiLAtjRUgDJiyqmJORS8polwnc1E4qKsdZ5tv61moeS3IdhRkL7eVZ6cBV9pi18zaJd1MyVZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711388691; c=relaxed/simple;
	bh=vrzdapfTi0QWEvTbUNO21le5/X7ZUgL1lrdO+CKr7U8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=etAvID6tX4twNbBLUsRy+tru2To6lEL4E2355gC2VRdEg0tdU/0WVa3xhodLACFExGF63oTT54e2pyFlYimHFmCSN+DbTWQS2UhjpZhPw3O47feGpV7ydx1yZ086TF8oZQycp2i1PbGlN22KJKS6obQW7ZBpU2LaUR867XNTxws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jOR+MgPN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DFEC3C433C7;
	Mon, 25 Mar 2024 17:44:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711388691;
	bh=vrzdapfTi0QWEvTbUNO21le5/X7ZUgL1lrdO+CKr7U8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=jOR+MgPNGs+t32Qw6dbHyuiRbL3scRwRFhXCgWzXvZrWsOnhhKFpDM+KVYSvdjzVl
	 2llPz4kHkozIB7OFyUtpw6hHej67gAECl2+5D94uUuS4RQUP+uhGND3N6qSPZognKB
	 DIGiDbCZI/s5LL1nQ5EdVFB7REcSDw2N9IqcsZjbsxAAZZbo0dfMkhDOfzrNGubgj6
	 WOT2HJWJyJ8WeGDTHmzdVG+H653cYkxVKwoJ/iKy2/SF07zgqNQ8jJ9+JxuS2m6TZ9
	 kO0Jumlo8V7uqf3ZWlPhvNkE5Nj+3ktHu4Zcd5YDneo7heYzNtFvQZJK1cCnh/964Y
	 1t5eCo3fGKvDQ==
From: Mark Brown <broonie@kernel.org>
To: Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Justin Swartz <justin.swartz@risingedge.co.za>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org
In-Reply-To: <20240316010302.20776-1-justin.swartz@risingedge.co.za>
References: <71533474-eb08-438c-b7ec-5f3277c195fc@sirena.org.uk>
 <20240316010302.20776-1-justin.swartz@risingedge.co.za>
Subject: Re: [PATCH v2] spi: mt7621: allow GPIO chip select lines
Message-Id: <171138868965.327330.16954587667720708033.b4-ty@kernel.org>
Date: Mon, 25 Mar 2024 17:44:49 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14-dev

On Sat, 16 Mar 2024 03:03:01 +0200, Justin Swartz wrote:
> Extract a magic number, from mt7621_spi_probe(), used to
> declare the number of chip select lines (which co-incides
> with the native chip select count of 2) to a macro.
> 
> Use the newly defined MT7621_NATIVE_CS_COUNT macro to
> instead populate both the spi_controller's max_native_cs
> and num_chipselect members.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: mt7621: allow GPIO chip select lines
      commit: 2a741cd6ec5899cec054ae27120f490ad57bc6bb

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


