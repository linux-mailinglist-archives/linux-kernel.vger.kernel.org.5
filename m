Return-Path: <linux-kernel+bounces-120302-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D59BD88D589
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 05:48:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0B2F31C254CE
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 04:48:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61E1D524A;
	Wed, 27 Mar 2024 04:48:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hyZXtotP"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B3031849;
	Wed, 27 Mar 2024 04:48:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711514888; cv=none; b=J50XKCcXejKfgZNVXSXHFY8gz+xdjPw0yX5MXJd0vo0cBXxDjXbcUIsdR8P6ivJHShGe5w8y7QLveZe9T5Y6Lre/++KIH227r1OuhoXUwOi0DRsTFmviw7ur6IDWzju0v+LpaJTQvxyAlJJSM7qSpwVlKkpGyeGK9DFCFwEw2Vc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711514888; c=relaxed/simple;
	bh=amR80G+fWUvqxS+sCOmX8ddrgfYtW+7QXa6cvF1GKWo=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=jepGdNc/f/YLVlk+KD/i4zbS9da65hzsZzK53UJTbYzb5C7zrl+Ip9ffamOCn8eNOlk41CJxTW1YfXeGkLTpU7h6gz7Qe/voiEqwfGoH9V/gVQ6fsitDwEOEDJm8wS3nPwjtK7VndZsVC00nHGn4z7CmUJqZ2xGkMCIfv0e4PvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hyZXtotP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 232FEC433F1;
	Wed, 27 Mar 2024 04:48:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711514888;
	bh=amR80G+fWUvqxS+sCOmX8ddrgfYtW+7QXa6cvF1GKWo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=hyZXtotPoyQmlKERlSCQx+Xekly6BsW2qnLoz1TfiHfxRLir++wEx6hMthVQA7uDZ
	 XEqVTL22mHmJzP/8BTpe7ybD8xtFZfJr2hJIGX/OSiYMRWBwyTPKXzInXTMV9SY0o5
	 2T5/GcrzvwIvuvkM2LVhL7M2O3JkFLzjN3FiIispLtwm5ayC2f3BbBdhuWQkXkDs+T
	 GgfcjeM7XeAaS6ECGMonZKf8zA00/QtFfXR4u+OoicoIZurw0bOzN9iQsWzMutn9zt
	 vN47UxgxGsSuDM+NV/jj2kVyy20pBGENM3UFEKPrrmK/BYYIUxAMyeOKeWi5H3SdRP
	 FDpbFEjAs9J3A==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 11546D2D0EB;
	Wed, 27 Mar 2024 04:48:08 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH][next] platform/chrome: cros_ec_proto: avoid
 -Wflex-array-member-not-at-end warnings
From: patchwork-bot+chrome-platform@kernel.org
Message-Id: 
 <171151488806.812.14417613721582434618.git-patchwork-notify@kernel.org>
Date: Wed, 27 Mar 2024 04:48:08 +0000
References: <ZgMaDl/of8YC445S@neat>
In-Reply-To: <ZgMaDl/of8YC445S@neat>
To: Gustavo A. R. Silva <gustavoars@kernel.org>
Cc: bleung@chromium.org, tzungbi@kernel.org, groeck@chromium.org,
 chrome-platform@lists.linux.dev, linux-kernel@vger.kernel.org,
 linux-hardening@vger.kernel.org

Hello:

This patch was applied to chrome-platform/linux.git (for-kernelci)
by Tzung-Bi Shih <tzungbi@kernel.org>:

On Tue, 26 Mar 2024 12:55:10 -0600 you wrote:
> Use the `DEFINE_RAW_FLEX()` helper for an on-stack definition of
> a flexible structure where the size of the flexible-array member
> is known at compile-time, and refactor the rest of the code,
> accordingly.
> 
> So, with these changes, fix the following warning:
> drivers/platform/chrome/cros_ec_proto_test.c:1547:40: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
> drivers/platform/chrome/cros_ec_proto_test.c:1607:40: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
> drivers/platform/chrome/cros_ec_proto_test.c:1645:40: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
> drivers/platform/chrome/cros_ec_proto_test.c:1668:40: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
> 
> [...]

Here is the summary with links:
  - [next] platform/chrome: cros_ec_proto: avoid -Wflex-array-member-not-at-end warnings
    https://git.kernel.org/chrome-platform/c/6c85a13b133f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



