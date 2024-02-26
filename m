Return-Path: <linux-kernel+bounces-81888-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A5394867B9B
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 17:21:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 456831F2E0B0
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 16:21:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C60E12C7F2;
	Mon, 26 Feb 2024 16:20:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UfF1ejIn"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 798C21D531;
	Mon, 26 Feb 2024 16:20:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708964452; cv=none; b=B+0jr28mRa3mAI+L9/d5eo6hbQ6Qazvyuo8qEbuQE9DqNnuWBHz6ZZA43C68Q/H2kEiMq74zByn5c2v0Ji6ahXfErEiFGS6uRmnub/iaLQ1RIS+6uFsgtHemAZIOL7Z+CtCmZo3ysCgnNCCEjKyB89iAiCRebSLs8KRq0Ez5nwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708964452; c=relaxed/simple;
	bh=gArGAXVnpE5wCkOHveh26QKEoX9Yp10b+7qwd6t/iag=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pQzRaE7jZXYgcbwDoGLsi+ptB/xkkYRUvR40Y9B40KPrdPXmdxmGNLJGqomIvHPED5JAUPzGpJT398gBytesziHikZ/BSQJwk7Z28/ECStiilabZEAsPTL9YEyTA/iEIvsgYm4I7zYHU63Lcig+OsuJltr6w+Ondsgz/hre9cxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UfF1ejIn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4E68C433F1;
	Mon, 26 Feb 2024 16:20:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708964452;
	bh=gArGAXVnpE5wCkOHveh26QKEoX9Yp10b+7qwd6t/iag=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UfF1ejInB0H1Dxv8QbMqP7Pev4bJJtNkrpaEQB3D89R3e89let86tLiuENwQvdtHP
	 qO1owpg2d9XJL3gGbgB6b8RZc0wnm5NgUj+8ICIY14TvFPEwikT1fcs50W90hR6mN2
	 VeUALXgYRRGypIUApdvip2+ZaTk4vrItNOA/3HeTUE7i3H0F2xZdwDlZJrYVEMMIs1
	 yY21q4570mUBIidnyf2I93LWmHTKpT7x+DlPoN8GUR4B5sICLcIdIvd9J0V+uQor5V
	 0A8plbBOHCPkJjzBxkfkIlmfwdYnJMHscMa3xInrpF6JUIRTIzaH5MtJiFDG6BEMW3
	 JC/7tA2OUmiZg==
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Masahiro Yamada <masahiroy@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	linux-perf-users@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Jiri Olsa <jolsa@kernel.org>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Mark Rutland <mark.rutland@arm.com>,
	linux-kbuild@vger.kernel.org,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH] treewide: remove meaningless assignments in Makefiles
Date: Mon, 26 Feb 2024 08:20:50 -0800
Message-ID: <170896440863.1919080.13935215273444154098.b4-ty@kernel.org>
X-Mailer: git-send-email 2.44.0.rc1.240.g4c46232300-goog
In-Reply-To: <20240221134201.2656908-1-masahiroy@kernel.org>
References: <20240221134201.2656908-1-masahiroy@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Wed, 21 Feb 2024 22:42:01 +0900, Masahiro Yamada wrote:
> In Makefiles, $(error ), $(warning ), and $(info ) expand to the empty
> string, as explained in the GNU Make manual [1]:
>  "The result of the expansion of this function is the empty string."
> 
> Therefore, they are no-op except for logging purposes.
> 
> $(shell ...) expands to the output of the command. It expands to the
> empty string when the command does not print anything to stdout.
> Hence, $(shell mkdir ...) is no-op except for creating the directory.
> 
> [...]

Applied to perf-tools-next, thanks!

Best regards,
-- 
Namhyung Kim <namhyung@kernel.org>

