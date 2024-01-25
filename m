Return-Path: <linux-kernel+bounces-38665-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC91683C3DB
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 14:39:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 74494B215FB
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 13:39:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9FB156478;
	Thu, 25 Jan 2024 13:38:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iRXUQfJW"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A2D655C3A;
	Thu, 25 Jan 2024 13:38:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706189938; cv=none; b=utOfNPFOKvTNyX1ttwm7gTwfAg91UQoUfaSfUi10QwPS6GZE0VeA9yv2AG938RFWiNZF7e/+QfhPh1rZrD7SFBB8i99AsXr0nU07c29VRxKYKqFsTJvEnD/L742WQ9k6N5EHA67IVRoIDA02lW5KuozhitcCKCDhU8vaYcNVnYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706189938; c=relaxed/simple;
	bh=X4EhEnTx2yshyJvskE+TkZSnYGz9JoEdM3ONmeCjR6M=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=kdMUsUYvPKnklZ0e6pPy7zzRzINyJNolkWp4d/qm0NU/hMtA7FlQi1YLMTa+Wfniv7G+H5vBoWduAcAdC4gxsx6o6zUSQ24L6Lhj6vanNJyjpjk+07tMPaf2Lo4i49WYlz7iu0+wVkzklNzTOMUVLwXsqGKhZ6Tj8FrSmJBvOwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iRXUQfJW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 690D7C433F1;
	Thu, 25 Jan 2024 13:38:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706189938;
	bh=X4EhEnTx2yshyJvskE+TkZSnYGz9JoEdM3ONmeCjR6M=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=iRXUQfJWBmOMFX3NTxCERxRsdQCI9n9efJjo9hDb/z8XJblrw+eoqZKTzhm5ksWI7
	 P4dBsRagliJHZpUpuydxjLav9vPb1BFhmXqf2616sfiautODNvuCFat4iH/tw3BKYr
	 bmhatN0FbUpBjt+cNBTiBMRHtWvUYIpiFwmLj455BjDZWbF/mHsbPvbzQnnIh3kuyt
	 jqm/odzzwj38wP8hkmpH2YXkkBCc4CTK84drL3anSfkUBAOG0E+1gh/5Fzj0+1Vc4b
	 mHug3zthaG1YXpXsdZRGlRWBXIR7lW7rFKQq+teCrhQQ9taPdvrlhpoMnEOLLt/B3d
	 0ilj3SJOgq5XQ==
From: Lee Jones <lee@kernel.org>
To: Lee Jones <lee@kernel.org>, Simon Horman <horms@kernel.org>
Cc: Nathan Chancellor <nathan@kernel.org>, 
 Nick Desaulniers <ndesaulniers@google.com>, 
 Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, 
 linux-kernel@vger.kernel.org, llvm@lists.linux.dev
In-Reply-To: <20240123-rave-sp-comma-v1-1-84e9b15ba205@kernel.org>
References: <20240123-rave-sp-comma-v1-1-84e9b15ba205@kernel.org>
Subject: Re: (subset) [PATCH] mfd: rave-sp: Avoid unnecessary use of comma
 operator
Message-Id: <170618993615.1469954.11714590210797016268.b4-ty@kernel.org>
Date: Thu, 25 Jan 2024 13:38:56 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.12.3

On Tue, 23 Jan 2024 09:59:48 +0000, Simon Horman wrote:
> Although it does not seem to have any untoward side-effects,
> the use of ';' to separate to assignments seems more appropriate than ','.
> 
> Flagged by clang-17 -Wcomma
> 
> No functional change intended.
> Compile tested only.
> 
> [...]

Applied, thanks!

[1/1] mfd: rave-sp: Avoid unnecessary use of comma operator
      commit: 67421634ade0979dafd3e3f21c9b63bc93ef4760

--
Lee Jones [李琼斯]


