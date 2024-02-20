Return-Path: <linux-kernel+bounces-73571-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 881AD85C45A
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 20:10:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3E0151F25061
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 19:10:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 860A514A0B7;
	Tue, 20 Feb 2024 19:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q8OIZO8j"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC1B113474E;
	Tue, 20 Feb 2024 19:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708456229; cv=none; b=eA//JFwG/Z+nm0MDe1knvOtIbBoz+fQvPrQ+nraNvPV6V37CLlD86HBisx6QSmhTom7RwpbEHS7DYehL/Up4ZXgQlE+S0CMvlzkdyv8pKdNuwY/uoGZaaL9wjZC4qKcf7u2VXIwRhru+KCRaLG1NtOcPq1XEK1hOeDdb7eWJZFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708456229; c=relaxed/simple;
	bh=vn5ABJYgQ7M+dIKSsVpDNA6SZwCuqt0TGeFxPC2AjMI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=LKv0ol/afNmcf9DrD2eoggCjlQJ3LtULT2bYaroYdCPoD0J7XZI/j8R+RmkR0PSl9/EkL4Wn0wAq4YaTQxDq4WTcK1ppK499qKKZo1DlgScNaW28evALoiiGNX6m0vFS8B+KfBZfUYpbffHDpkbeciP2kbAMeqn0HU8fErq0Xa0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q8OIZO8j; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 50AC0C433F1;
	Tue, 20 Feb 2024 19:10:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708456229;
	bh=vn5ABJYgQ7M+dIKSsVpDNA6SZwCuqt0TGeFxPC2AjMI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Q8OIZO8jGnpPmTohtXP8Y/g1a5gTJ33vKNF6Ut0fG5F4e0yeqSPSkYBwHotX6XaWW
	 4pLa7NyBH1ULztBCs/4Ev+H2+4zTAr5fv0gOAosWipveXdOg9P4cFpvnOui4iuWVbT
	 9OIzJoV0CbF+/hFg2Fd6inzSVYN1qdKs/ApDtnc7+vr3aanBVFh9+CyQN4MA9nvBMn
	 vLP8Xz0t5/vBpTremtKSpuSjV221LVlvss1aOZMPRFz2gYU7LY8VMzG4VJwPOqvdF3
	 jiN3sLFYZRc6IhY8lXCb2yyKjOgbIKNKIkoOSRGLF8dERAmuEiFk29uq+/jbBl38Qk
	 FyGeomj0/AqdQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 3860DD84BBB;
	Tue, 20 Feb 2024 19:10:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 1/2] Bluetooth: btbcm: Use strreplace()
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <170845622922.2554.15489490730262371162.git-patchwork-notify@kernel.org>
Date: Tue, 20 Feb 2024 19:10:29 +0000
References: <79b9c9d9f86b4c573f0d3f2dac0a6fc9e6024058.1708154999.git.christophe.jaillet@wanadoo.fr>
In-Reply-To: <79b9c9d9f86b4c573f0d3f2dac0a6fc9e6024058.1708154999.git.christophe.jaillet@wanadoo.fr>
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: marcel@holtmann.org, luiz.dentz@gmail.com, linux-kernel@vger.kernel.org,
 kernel-janitors@vger.kernel.org, linux-bluetooth@vger.kernel.org

Hello:

This series was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Sat, 17 Feb 2024 08:30:41 +0100 you wrote:
> Use strreplace() instead of hand-writing it.
> It is less verbose.
> 
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
>  drivers/bluetooth/btbcm.c | 7 ++-----
>  1 file changed, 2 insertions(+), 5 deletions(-)

Here is the summary with links:
  - [1/2] Bluetooth: btbcm: Use strreplace()
    https://git.kernel.org/bluetooth/bluetooth-next/c/76912dcbabc6
  - [2/2] Bluetooth: btbcm: Use devm_kstrdup()
    https://git.kernel.org/bluetooth/bluetooth-next/c/d095e06a1569

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



