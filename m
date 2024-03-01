Return-Path: <linux-kernel+bounces-88921-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 16AFE86E865
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 19:29:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 01EFE1C211E5
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 18:29:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CCFF27701;
	Fri,  1 Mar 2024 18:29:07 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB8C525622
	for <linux-kernel@vger.kernel.org>; Fri,  1 Mar 2024 18:29:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709317746; cv=none; b=sRmq1UDJLCvpQzkj5VQeD6tg6DdxwTK64xmuJC4o4S+AmC2r98+HerlgaiHvhEdcJngr1GrVgXurE1fyfj8j1HJ8EeuLq5+GqzZANtJSZBEmyg/DUvp+J0EEMa++6ky75xEcsYcVWIyJFhrhrHZu9vEl6hl4ecO7I72qsyG8l6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709317746; c=relaxed/simple;
	bh=2Fc9w7W50EpjKkS04MeZvcU0KjPGzmUrKJc5L1u6ahQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dSJ2bGJMWnL/9+NydpgbUKM9OD3rrjpC6AkM32tQLmpcep4Hi0eaaf0AXw5QV5YfeGZ2CBVtvzbKC5mJLdfXUqR/yqhIt3WjfWoFaflOXYF6kSpaeSXJir8bEHgvFtlITtl09EqaTZ6kQisWVGjYp08yyqdnU6Q8SiNGZt8f5PY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3560FC433F1;
	Fri,  1 Mar 2024 18:29:04 +0000 (UTC)
From: Catalin Marinas <catalin.marinas@arm.com>
To: will@kernel.org,
	broonie@kernel.org,
	mark.rutland@arm.com,
	maz@kernel.org,
	joey.gouly@arm.com,
	kristina.martsenko@arm.com,
	ryan.roberts@arm.com,
	jeremy.linton@arm.com,
	Liao Chang <liaochang1@huawei.com>
Cc: linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: cpufeatures: Clean up temporary variable to simplify code
Date: Fri,  1 Mar 2024 18:29:01 +0000
Message-Id: <170931771877.4170325.13489233775645685073.b4-ty@arm.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240229105208.456704-1-liaochang1@huawei.com>
References: <20240229105208.456704-1-liaochang1@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Thu, 29 Feb 2024 10:52:08 +0000, Liao Chang wrote:
> Clean up one temporary variable to simplifiy code in capability
> detection.
> 
> 

Applied to arm64 (for-next/misc), thanks!

[1/1] arm64: cpufeatures: Clean up temporary variable to simplify code
      https://git.kernel.org/arm64/c/622442666dcc

-- 
Catalin


