Return-Path: <linux-kernel+bounces-12402-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 24B1E81F44A
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Dec 2023 04:12:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CFDB21F221D9
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Dec 2023 03:12:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C04793C00;
	Thu, 28 Dec 2023 03:12:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e1xoornL"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1873328F3;
	Thu, 28 Dec 2023 03:12:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68B95C433C8;
	Thu, 28 Dec 2023 03:12:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703733157;
	bh=fVTdWnjLmebCNA2sYZSqmo28sH1HWYsgYXc7oFuxyls=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=e1xoornL38jDwUfawSEZ8mm0c17QXXu4qoLcCjWGe5Bbgx80x9hHqQy8MDXrBH5hr
	 iJ8v73gHLVDzwYAz8wTmYBW4kLQiO6u88usM2BfKy2GSbGAI1bOnABoECroqusZBs7
	 1gGMtvgsyK4tgv9tstVB1LIU+LviFnIQ9V4NS7OU7/hPhjoHa4f8hTKa/iuOFAPb5+
	 +16pdvkdRKCYAYtmjTfrjOrsPu8rrikpZBsRDfGI13DYoNYZq2kTiGsVpP551hjeSp
	 83FCV6E7P/SqrfF6mpou31ONg2nwHCyMtBPqICU2nj+F9tFMR3dAnIvCLC9K/bhgSU
	 35rjt54KQyENQ==
Date: Thu, 28 Dec 2023 11:12:34 +0800
From: Tzung-Bi Shih <tzungbi@kernel.org>
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
Cc: kernel@pengutronix.de, Brian Norris <briannorris@chromium.org>,
	Julius Werner <jwerner@chromium.org>,
	chrome-platform@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 03/11] firmware: coreboot_table: Convert to platform
 remove callback returning void
Message-ID: <ZYznogPzbFM2XTCv@google.com>
References: <cover.1703693980.git.u.kleine-koenig@pengutronix.de>
 <d323e4f24bfab3ac1480933deb51e7c5cb025b09.1703693980.git.u.kleine-koenig@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d323e4f24bfab3ac1480933deb51e7c5cb025b09.1703693980.git.u.kleine-koenig@pengutronix.de>

On Wed, Dec 27, 2023 at 05:26:27PM +0100, Uwe Kleine-König wrote:
> The .remove() callback for a platform driver returns an int which makes
> many driver authors wrongly assume it's possible to do error handling by
> returning an error code. However the value returned is ignored (apart
> from emitting a warning) and this typically results in resource leaks.
> 
> To improve here there is a quest to make the remove callback return
> void. In the first step of this quest all drivers are converted to
> .remove_new(), which already returns void. Eventually after all drivers
> are converted, .remove_new() will be renamed to .remove().
> 
> [...]

Applied, thanks!

[03/11] firmware: coreboot: Convert to platform remove callback returning void
        commit: 09aeaabebdafbcf4afd1c481beaff37ecbc6b023

