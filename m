Return-Path: <linux-kernel+bounces-151282-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE9618AAC60
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 12:04:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6158EB21BE1
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 10:04:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AE857D416;
	Fri, 19 Apr 2024 10:03:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g98+0TD+"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B8063D961;
	Fri, 19 Apr 2024 10:03:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713521029; cv=none; b=by0860LnQ5kjegKhl0nLhlnRDRW51kQpWlaRyyutQqd2/7uOci6EWqC68UZLTqk+MOvSgDdVA692F7fvQIGbS/4xLKY56uw/7FSW/wflLLRmAC24fXCA7Qn0An1jAqhAkQRXg/6ZfhtB3ATmL4+TdZPXztQYmv7uiyAc2yJlU+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713521029; c=relaxed/simple;
	bh=LZ8j7/DAFq2z05bW7r9GYgMXjNxvmbu0CIMhbcQqQiY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=sf5GLGZCC3p5wMg8R93EWnCaZrGe3XoDyYZdHtXreaMudZTfCbRBM/JoSHHXyabztqhirYmvatGwNfFaJm2YlVxa982hI8cvTPXzNHa/RkL62dtzdVv3Egf2bMjWOTfk05XbVIuBpnwmcxjIEwrhKkCuCJIdkkWxUKy7C6Ayb/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g98+0TD+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4CEBC116B1;
	Fri, 19 Apr 2024 10:03:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713521028;
	bh=LZ8j7/DAFq2z05bW7r9GYgMXjNxvmbu0CIMhbcQqQiY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=g98+0TD+/HxT7CXg/LLA5YzVNNafZurzBeoXHBYkCtNcBNrvfXotZ82/KHJX6KlM2
	 ap6wQ9VlSK0I1O2XVwmQcDzKfs415b1oTkzNdw5n8WF5ZUywRoLtMg8qrGz2nspnqm
	 C7Eazf1H/ZBFJwsfZbH7kTqtcXxIoMVEvl96zxxx/NzNUiT8JBe9toADTaTuMRs7f5
	 R7s+IgpllAXC3zIwSNLQul/oWhosDOPOUXpKf01eNUt6H4kiT8jUfNNr40xQyLFye6
	 gz7Sphiqs0TZLTUDM6by4pwe1czFcG0LYUqP+29jVjHKl53B5KEsduW3cKxUg+L/jV
	 QV31Fb3TN4xew==
From: Mark Brown <broonie@kernel.org>
To: Maciej Strozek <mstrozek@opensource.cirrus.com>
Cc: patches@opensource.cirrus.com, alsa-devel@alsa-project.org, 
 linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240418103315.1487267-1-mstrozek@opensource.cirrus.com>
References: <20240418103315.1487267-1-mstrozek@opensource.cirrus.com>
Subject: Re: [PATCH v2] spi: cs42l43: Correct name of ACPI property
Message-Id: <171352102742.1723864.2404098054563161997.b4-ty@kernel.org>
Date: Fri, 19 Apr 2024 19:03:47 +0900
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14-dev

On Thu, 18 Apr 2024 11:33:15 +0100, Maciej Strozek wrote:
> Fixes: 439fbc97502a ("spi: cs42l43: Add bridged cs35l56 amplifiers")
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: cs42l43: Correct name of ACPI property
      commit: e4f23c4c4dd0aa9bb3a70a873d3fc32a41f64007

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


