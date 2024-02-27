Return-Path: <linux-kernel+bounces-83720-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE185869E4C
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 18:52:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 54968B3189F
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 17:31:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B32974F213;
	Tue, 27 Feb 2024 17:27:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oIHL2wze"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED8FC14EFE5;
	Tue, 27 Feb 2024 17:27:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709054830; cv=none; b=qyPetvoHI9F6YlQL4qYVuJsWQ6Zhjj6SyKA6YWM5E2evrVDE0sKPpPdtxnRw+bprYgvmZJc3cLRo3Pwli9EQUiUjAtFXTppphb0GTMqsE5W6vRqaKvfRYirPrp+4jNnU73fosx/5BZstAwlfV0LmWbWj3HFdQVPANJfZSU9o+W8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709054830; c=relaxed/simple;
	bh=CA+h9PvCJJ1SvNkwYoH0URKv+5hUUT/zar0bsEzqYkQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JxwpucqiKkorX5lcSEWyk3HY/IxYUEGRFJWvAVUeXPvjSqEKqBs2G7EcEG5XoQR7qAt25Zl9ruV1SsNp6jnZ3HCHbHajnKWqATXvy3KQyIgTnTJTV3ouBAppumHLFjyeu/KTArcReQ+f0WzpqHuILRgyxNDdiUpn6Fyyy0NoYI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oIHL2wze; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3405CC433C7;
	Tue, 27 Feb 2024 17:27:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709054829;
	bh=CA+h9PvCJJ1SvNkwYoH0URKv+5hUUT/zar0bsEzqYkQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=oIHL2wze5S9qXqEOhHqOs2CEpg3pFy4FZH6d9QAUBPkI74y0mUm07ToPVVeGq1LBO
	 1WIoPzbtMr3FUdbiWrEkvNUXqgAU5b8C/staF6vUNRDbp7YF34v89/Xw3yvff9IlUg
	 aErcPFAAk4RyAjdttAGHfXrc+940lqugJAovcALwi56ACAyKf4idblS4FwKWBYpxgG
	 JzUw+CZQJofdttt9V75KCXI2AM0TQd70YSg0SWIs1P1E3nv3JVZfzMj0TM8krIUqvP
	 2G67e3nVNsVYK/fz9o2ppnGzY5ySPRHvscj6lGn9Vx2s1oiaX+t0wBhpdOYrWyOk9k
	 hbbhGJUFwMe5g==
From: Namhyung Kim <namhyung@kernel.org>
To: Mark Rutland <mark.rutland@arm.com>,
	linux-perf-users@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Ian Rogers <irogers@google.com>,
	Colin Ian King <colin.i.king@gmail.com>
Cc: linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: Re: [PATCH][next] perf test: Fix spelling mistake "curent" -> "current"
Date: Tue, 27 Feb 2024 09:27:07 -0800
Message-ID: <170905469227.501091.5015652825552459151.b4-ty@kernel.org>
X-Mailer: git-send-email 2.44.0.rc1.240.g4c46232300-goog
In-Reply-To: <20240226105326.3944887-1-colin.i.king@gmail.com>
References: <20240226105326.3944887-1-colin.i.king@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Mon, 26 Feb 2024 10:53:26 +0000, Colin Ian King wrote:
> There is a spelling mistake in a pr_debug message. Fix it.
> 
> 

Applied to perf-tools-next, thanks!

Best regards,
-- 
Namhyung Kim <namhyung@kernel.org>

