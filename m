Return-Path: <linux-kernel+bounces-56150-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DAE6784C6AC
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 09:53:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 793B81F25745
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 08:53:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE358208D9;
	Wed,  7 Feb 2024 08:52:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PN2f31id"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFFD1208B9;
	Wed,  7 Feb 2024 08:52:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707295971; cv=none; b=kS5DZ10Fi3jApAnh7380HKfnfpqxpqJH1TMZZD9EgNLOGH2tOpBtzKBKJqvhIfNsKEwlfD/iHm1GHB3z7t8h80EmjjZlD5f6koM4k7eouSZb8Zkk5TfMpdVAiup892/BR2vS5/t9eatwGizaXPh7jrJbuFJeeH76nG8P1DiS2ew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707295971; c=relaxed/simple;
	bh=n16H6C7qD7/PvLAlbp7IuAkQRMQk1BEPXl8o0SoT2aY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=SdSdwZjkgZ+FJVtb/Qv3A9g/uiIdhV67SqhQxMm0B9Lem+cwQLXVFk/PwGdDGycKeRJtq6CBU9ZFym/Jur4enZZR1/Chh0/nLPu9uOUc3uSpr80Bs5BktRkFQXM+NJrifRdfiBWheK8quIFTgYgBSwX8bXwmZDkNz9nOLE8jAEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PN2f31id; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC9E1C433C7;
	Wed,  7 Feb 2024 08:52:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707295970;
	bh=n16H6C7qD7/PvLAlbp7IuAkQRMQk1BEPXl8o0SoT2aY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=PN2f31id9dC3HHooKnb5zlqeGbDCI0DBE4S4hu7tV02unUDSqAg0Ohg0zslx5qvR0
	 l8HSalsVwsUxb2B1kgKmdpGpDxvsPaQK05gkFQNCnl/j0DeXMVhQePES0H1Z89MaoC
	 IwDzDxUa52ebr8mvjj5tHBmpw5EHUEiavCEbuk6SlXytznQ1NwwkhBhn6h26wY81WE
	 TjnCSocstnvYsNdbLctmwfXhRCwlg3qWuQjvJhTC+eu20hnVxiiTWJAFExe940ODis
	 GufMk0ZBR8mMzFDsUE77hvYqn+yT6Ahn2mZjq5CFszZ72EpQ2V26zhLn+QY42hqxEH
	 1pjJCv7ZeFKZw==
From: Vinod Koul <vkoul@kernel.org>
To: Bard Liao <yung-chuan.liao@linux.intel.com>, 
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, 
 Sanyog Kale <sanyog.r.kale@intel.com>, alsa-devel@alsa-project.org, 
 Colin Ian King <colin.i.king@gmail.com>
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240205182436.1843447-1-colin.i.king@gmail.com>
References: <20240205182436.1843447-1-colin.i.king@gmail.com>
Subject: Re: [PATCH][next] soundwire: intel_auxdevice: remove redundant
 assignment to variable link_flags
Message-Id: <170729596857.94552.8333430107320887182.b4-ty@kernel.org>
Date: Wed, 07 Feb 2024 09:52:48 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.3


On Mon, 05 Feb 2024 18:24:36 +0000, Colin Ian King wrote:
> The variable link_flags is being initialized with a value that is never
> read, it is being re-assigned later on. The initialization is
> redundant and can be removed.
> 
> Cleans up clang scan build warning:
> drivers/soundwire/intel_auxdevice.c:624:2: warning: Value stored
> to 'link_flags' is never read [deadcode.DeadStores]
> 
> [...]

Applied, thanks!

[1/1] soundwire: intel_auxdevice: remove redundant assignment to variable link_flags
      commit: 9282cfa2eb080e3bbb95f488af35618b614cdf76

Best regards,
-- 
~Vinod



