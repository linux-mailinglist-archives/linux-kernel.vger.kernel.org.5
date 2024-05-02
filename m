Return-Path: <linux-kernel+bounces-166754-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D2EE8B9F0C
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 18:56:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 10EC028911D
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 16:56:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07C6B16D9D4;
	Thu,  2 May 2024 16:56:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mrPS97wP"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49BE31E894
	for <linux-kernel@vger.kernel.org>; Thu,  2 May 2024 16:56:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714668966; cv=none; b=TsaDxEtRmT+5ZF5mHfGZAwDTyInFgTJ678BfYG9j7Ce5u2pQLEJuu/OdWZN3McMc7ZLCELHUfcqGqE1jthsqrWSFq7nuRs0vjHmh+SuE5TjkDu1F8zECVctpB1awRDZd7ZJ8m3xNuiIzaaLg4nUxT8FHU89ZonEI0A/b9GQ4DI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714668966; c=relaxed/simple;
	bh=CCE+p8QPFzPjKxcbKudSLOdb5kuut2ZESRmGtopMcE0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=CO7OxxX22fZLhpVrjvq4vf7bADRBVnIMcD5k36GEQL0p7j5SXbVX0dEeBgZ34cpliIC1m7lGQLISYFiw5MZ06AQE4O8OtCjzLWZy5ISDxzkr7GErIG1F2uJk2NPByLF0+rYSESL31wV6wPtAInpB/vm60EKuuK25Wwf0oCDcyys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mrPS97wP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5A68C113CC;
	Thu,  2 May 2024 16:56:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714668965;
	bh=CCE+p8QPFzPjKxcbKudSLOdb5kuut2ZESRmGtopMcE0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=mrPS97wP7w0fOp5WLOBUtGbXE2vJI1NwDaH7q72ZM1gvbRQpqyyzFdVWCJgkTmsTM
	 5xD5+9vTMLL5nQezjEU+OWSqGHY2LK5cpSSFpG6TkujNDay+8ugA034J2DLZuZk0se
	 Yc1AmLAPBXmvwlIzaDvwAWBRkhu6lqGznKBqc4B0By3xFgqq8DzZygH+CkNFVFLzkl
	 CyNPg7zbvtjKJHvgrN+ZQBvFYG+pEgU1fmGIbr7qlv9ht5/dFUg+UMCqsFbdN8kDYa
	 pXU0X9G+6fTY/O/jfnfJ9bAECvr0ubpFx4Dwxvy+v7Pc6XXeuhf6qYtI4IjrJPyXE+
	 +SWucAE5ye8oA==
From: Lee Jones <lee@kernel.org>
To: lee@kernel.org, Charles Keepax <ckeepax@opensource.cirrus.com>
Cc: linux-kernel@vger.kernel.org, patches@opensource.cirrus.com
In-Reply-To: <20240423102339.2363400-1-ckeepax@opensource.cirrus.com>
References: <20240423102339.2363400-1-ckeepax@opensource.cirrus.com>
Subject: Re: (subset) [PATCH] mfd: cs42l43: Update patching revision check
Message-Id: <171466896468.1210371.3867323121604554888.b4-ty@kernel.org>
Date: Thu, 02 May 2024 17:56:04 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.12.4

On Tue, 23 Apr 2024 11:23:39 +0100, Charles Keepax wrote:
> The firmware can only be patched once. The current code checks if the
> firmware supports the features required by the driver and then patches
> if it does not. This could lead to the device being patched twice if
> the device was patched before the driver took control, but with a
> firmware that doesn't support the features the driver requires. This
> would fail but potentially in unpredictable ways.
> 
> [...]

Applied, thanks!

[1/1] mfd: cs42l43: Update patching revision check
      commit: 4dd91a9a49825e727e93aca8483eb90e6a9894e5

--
Lee Jones [李琼斯]


