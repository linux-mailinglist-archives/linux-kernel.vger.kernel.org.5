Return-Path: <linux-kernel+bounces-54121-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D72984AB0E
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 01:18:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4EA6D1C241B5
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 00:18:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87FE5818;
	Tue,  6 Feb 2024 00:18:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BOV2/5L7"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A137E137E;
	Tue,  6 Feb 2024 00:18:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707178703; cv=none; b=ZH7J65FkjC6FVAa0417VY4qPC0rj1EfNapW29dSK5gAddemaMMG29yKyfZIozr7Xa7Z+oNjX9DZzj+/eYgD0tnMd9xmLqKLj6tn+FHee6ph2h8aU0cXNjB3mI/GiC/a3dMOEBd5+jL3m4I/7f6l7yK93n33olB6u/A/rolJGKJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707178703; c=relaxed/simple;
	bh=cXJEh87Xv5oSBW12pIQI2CIX03PW+7inmAuDSsgTT38=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cImJIELHHDjuFxg4+Z7/kMx5xqoXt0QaFa97rWYya7p9zXp3J0zOvEhEb1TcwZr/EZaPkKjYlb0VXkhZ2W+Lg81xGUd6p5OSAtiUPOAhcmoQq4t2BhCFrFLBfqO3CY/SBAJoqlbITNjQ1yZY8m+r0YK081Z5VLNxqRfEFsjd0Fk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BOV2/5L7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9819BC433F1;
	Tue,  6 Feb 2024 00:18:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707178703;
	bh=cXJEh87Xv5oSBW12pIQI2CIX03PW+7inmAuDSsgTT38=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=BOV2/5L7nQUaIYRS+30v0GbKmeczl40WzrjYzMFoTtcvu2jWWcvW4ALJJ34GKV4EA
	 wFV4SVxP4r6HhzvRaGE98k22f/7hpN9GFN0mcrpFTbgD05H1o2T2pW9dF30zyPLqHj
	 73waapod8T/qyUh1Iny7ncJgAVJguwFIW+L1LUonTX3ZOVxH6n6z09LLYvLEuedzMe
	 RB6u+jQjOfYDTC68v3HkN40IIxgpXH8UPEsoKE9YIfUVlllyE7kSP6ZjRaJXtPuLPh
	 iDq0EYpQBxo9ZXj/awdDGQ3fkuwf6ou32lYEVvrad/m9LIKIISXMihX/efdBXwDLkn
	 SWIh8XLYyD8Lg==
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Kan Liang <kan.liang@linux.intel.com>,
	linux-kernel@vger.kernel.org,
	Michael Petlan <mpetlan@redhat.com>,
	tchen168@asu.edu,
	Adrian Hunter <adrian.hunter@intel.com>,
	Ian Rogers <irogers@google.com>,
	James Clark <james.clark@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	linux-perf-users@vger.kernel.org,
	Jiri Olsa <jolsa@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>
Subject: Re: [PATCH v2 1/3] perf tsc: Add missing newlines to debug statements
Date: Mon,  5 Feb 2024 16:18:19 -0800
Message-ID: <170717858567.1700937.14873687194661225533.b4-ty@kernel.org>
X-Mailer: git-send-email 2.43.0.594.gd9cf4e227d-goog
In-Reply-To: <20240131134940.593788-1-irogers@google.com>
References: <20240131134940.593788-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Wed, 31 Jan 2024 05:49:38 -0800, Ian Rogers wrote:
> It is assumed that debug statements always print a newline, fix two
> missing ones.
> 
> 

Applied to perf-tools-next, thanks!

[1/3] perf tsc: Add missing newlines to debug statements
      commit: 2882358b8b83b417a9d82205ae6aae5be00bd989
[2/3] perf parse-events: Improve error location of terms cloned from an event
      commit: f5144ecad74101f87843aa08070df26a3937102a
[3/3] perf parse-events: Print all errors
      commit: fd7b8e8fb20f51d60dfee7792806548f3c6a4c2c

Best regards,
-- 
Namhyung Kim <namhyung@kernel.org>

