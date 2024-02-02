Return-Path: <linux-kernel+bounces-50564-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 44AE3847ADA
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 21:58:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D76831F21CB1
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 20:58:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F05627F465;
	Fri,  2 Feb 2024 20:58:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bg2JeTkd"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31A537A723;
	Fri,  2 Feb 2024 20:58:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706907509; cv=none; b=hbMuTUyYjJf8XPfAR/ajxqA0XODpZ5AMHTY6FphclvOEaf0+kwBJxgo54J0CiUKJXFSAnb5oeRftryKQbOEItt1kttpXsNy5GPx9IbigjfXEVySjuf/eDbaKTPARcwsJXOnC6qJJfaEsexm15aJzniNbWQ9TSakvgwuzk/okSXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706907509; c=relaxed/simple;
	bh=9x9jh0bf3E4e6Yr18D930aQpdzCu9mfHJzKe/hPmPIM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rfKXbs27c6uBJuH+yCUq542T9U/JDpWIKYUBRJ16d/shhtRmD3HKMRkIR54pR729ejgR6xq/yOl9eySE4U7ZJTBp9klSsMMDRRaJZTz/Nb1W4W/smHWyz8eB1aPjSTERO4tezfJ9QGLNja6buQPPRxZK2ph/ip9Oa/jZ1hzd3X0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bg2JeTkd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 403ADC433C7;
	Fri,  2 Feb 2024 20:58:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706907508;
	bh=9x9jh0bf3E4e6Yr18D930aQpdzCu9mfHJzKe/hPmPIM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bg2JeTkdyPRyEibx304du7u0bSQMGo6JaxtP5kJSuCfPLZ0UMBdqoOXU1RBtycNCJ
	 9tjWj86bc5Q1Pdy/qFSpEHIsmgPshfo2e3X8r3PJ/0yD3dbIqwEPkJsZ8uU4RZ8WNV
	 A4bdvsT+6nV62G/PKvmC3MC4KA6l/Ia65sDF1uNOMLheqk+pPCRWhd9P70NYI4uXaX
	 w4sPHTh4QPv/tDgN+i7hTJ6D/r2t/OI7mn5CI47ymlJ2ia1L9PHE687aDIHCNgyxfJ
	 gYtDTbXn3P3xeeNCwTMjISv8LgJx1l2qMebJAjUlQb5YDuRnhApXQespZyOpZj4VKw
	 HHueSWbJQNduQ==
From: Namhyung Kim <namhyung@kernel.org>
To: weilin.wang@intel.com,
	Adrian Hunter <adrian.hunter@intel.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Kan Liang <kan.liang@linux.intel.com>,
	Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ian Rogers <irogers@google.com>
Cc: Perry Taylor <perry.taylor@intel.com>,
	linux-perf-users@vger.kernel.org,
	Samantha Alt <samantha.alt@intel.com>,
	linux-kernel@vger.kernel.org,
	Caleb Biggers <caleb.biggers@intel.com>,
	Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH v1 1/1] perf test: Simplify metric value validation test final report
Date: Fri,  2 Feb 2024 12:58:26 -0800
Message-ID: <170690725035.1264496.88768199134799939.b4-ty@kernel.org>
X-Mailer: git-send-email 2.43.0.594.gd9cf4e227d-goog
In-Reply-To: <20240130180907.639729-1-weilin.wang@intel.com>
References: <20240130180907.639729-1-weilin.wang@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Tue, 30 Jan 2024 10:09:07 -0800, weilin.wang@intel.com wrote:
> From: Weilin Wang <weilin.wang@intel.com>
> 
> The original test report was too complicated to read with information
> that not really useful. This new update simplify the report which should
> largely improve the readibility.
> 
> 
> [...]

Applied to perf-tools-next, thanks!

Best regards,
-- 
Namhyung Kim <namhyung@kernel.org>

