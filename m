Return-Path: <linux-kernel+bounces-60092-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E8C0484FFBB
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 23:21:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 888CDB27C61
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 22:21:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7890C374F7;
	Fri,  9 Feb 2024 22:17:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iEKY7yR4"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B13E522619;
	Fri,  9 Feb 2024 22:17:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707517061; cv=none; b=ErRmctfX39Xgus3vKWIbxP5OlBIB6d99OxASTx1wC+7g633gZ9T0bUx0YxzFV2ZiLuvd0BclqX9e4D0mX4Z+7zXRvDd4jYrCvS8GCjcTPxNcR2WUIII0MMMdb2Q37Mkz6Z56bNoFIzojml4Syk7CfWXR5Qaz3MM5kCahVI+Dcnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707517061; c=relaxed/simple;
	bh=Iz6tL87VfkkwktmTLoAZ+RdQsI17JGzt82jYvE/pd+E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iQQ1h/pMhzH/nE+6jOKsolxvEhdgTpFRNqW3nr6pKG4Gjy8aGnXXieG+LRGWvz2cRvW05dfLkd8K0lxcABFjWW28pbBdB9UgYazEUgrDl0kUk6gZ4RYZ/BxgUsApvUagXsdIQ/hV6i6bRpA5eqgA0XmPXJx5TqBoWdataIimUeA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iEKY7yR4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA783C433F1;
	Fri,  9 Feb 2024 22:17:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707517061;
	bh=Iz6tL87VfkkwktmTLoAZ+RdQsI17JGzt82jYvE/pd+E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=iEKY7yR4IHvTzY3pdx7NIRVR/hV7jb/9X3Ks1jUePFbodb55PT09aalgo+b9vpdyX
	 N7TU1Z1HK9YCxfb2P9elOi3hZDofJqWrPMyaPkEwUpX9pPx1zfQNiuESiHutNXDUww
	 ln5XtGakohG4scFZk+UGcMc9koceb3zcAY7VEYsEUEUhevGB9EOhnTZoANScs4jlVL
	 Q8IORqu/qDW1VlgXg32MMRj4iSF7GX1eorBQyov8J4ItyBF2mb/kMie+Nz1i5/C4+H
	 91fEotq9lxk12lLRtWwxhvfo1bcyRG039E7EzNJxOxdOlMImXLLOc9m9++g17koDzA
	 yy6tljp4Vi+5Q==
From: Namhyung Kim <namhyung@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Ian Rogers <irogers@google.com>
Cc: Ingo Molnar <mingo@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Jiri Olsa <jolsa@kernel.org>,
	linux-perf-users@vger.kernel.org
Subject: Re: [PATCH] perf tools: Remove misleading comments on map functions
Date: Fri,  9 Feb 2024 14:17:38 -0800
Message-ID: <170751693777.1169242.17057350354505601179.b4-ty@kernel.org>
X-Mailer: git-send-email 2.43.0.687.g38aa6559b0-goog
In-Reply-To: <20240208181025.1329645-1-namhyung@kernel.org>
References: <20240208181025.1329645-1-namhyung@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Thu, 8 Feb 2024 10:10:25 -0800, Namhyung Kim wrote:
> When it converts sample IP to or from objdump-capable one, there's a
> comment saying that kernel modules have DSO_SPACE__USER.  But commit
> 02213cec64bb ("perf maps: Mark module DSOs with kernel type") changed
> it and makes the comment confusing.  Let's get rid of it.
> 
> 

Applied perf-tools-next, thanks!

Best regards,
-- 
Namhyung Kim <namhyung@kernel.org>

