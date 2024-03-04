Return-Path: <linux-kernel+bounces-91137-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E7728709F5
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 19:56:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6099A1C20491
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 18:56:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2692578B4D;
	Mon,  4 Mar 2024 18:56:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ok477O0O"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6998A6166A;
	Mon,  4 Mar 2024 18:56:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709578589; cv=none; b=EBPB8BA5yOtO96f2grmX04KoMZtE7s5tMjmzzKLE+2FYPxZkgPR3k+aBEo4sjeMP28M1xJQcqN3iAGLS5UAXHXmqYSBXaZoCoIOrSBofmAmSnFK0LrF+Z6PvkYQVYZx/j+LCrcUpHUdn+1+7yQnNx6jd6CNozQKRlae2cODi3W0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709578589; c=relaxed/simple;
	bh=AGakVKBVHKZFUX1HC/uvSeswhvXnYisvQIbiyGd2BIw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pysNdeDm8PhYoyvqxm4pXtp11JdEeK1XaR3vLlhP07AypD74RNsY00aeQAkH6UA+8PRfOYa/KDkvUJOx1Z2sSSEGBrd8Q4bbaPFUlUM3TUIdtLBvFsoIUYCzVyUiNtfC3UtlekmEi5V3b4snrloD59wGLOyTzKovnvVXCm4bK88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ok477O0O; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B34DC433C7;
	Mon,  4 Mar 2024 18:56:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709578589;
	bh=AGakVKBVHKZFUX1HC/uvSeswhvXnYisvQIbiyGd2BIw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ok477O0OMniidJJ8lhthcFOsCei3t2AVKOmnRsMr6F2geD53c3okMIh4ojy7S5DCs
	 ZmApql6tI/DntjIDKvjkzy5+KFI72T3wpOpINZtk2A8xU0vS7U4IMYev8r6SKGaaLv
	 6Kg2Xv7qK7wxDqSjf52gY39witHyX3EZvjI77w/Lu5nFagodq4Bj2z8Zm0IDQ9nN20
	 oMfp0lBoWlblBepHIvQn+Xkuh/zRov8to6pERz/Z8jUa6DAMG8zGaA0LPoQvXALzOP
	 s2eHsVu+ZBaL2wj5QNN5OIVLRoV/ulIuEet1MWrVRt6/pA62aj7CyW8pqqdfhyqCgA
	 r4T84yWq7lfEg==
From: Namhyung Kim <namhyung@kernel.org>
To: linux-perf-users@vger.kernel.org,
	James Clark <james.clark@arm.com>
Cc: Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	al.grant@arm.com,
	Peter Zijlstra <peterz@infradead.org>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	linux-kernel@vger.kernel.org,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>
Subject: Re: [PATCH] perf version: Display availability of OpenCSD support
Date: Mon,  4 Mar 2024 10:56:25 -0800
Message-ID: <170957856861.1606352.735199628659445730.b4-ty@kernel.org>
X-Mailer: git-send-email 2.44.0.rc1.240.g4c46232300-goog
In-Reply-To: <20240301133829.346286-1-james.clark@arm.com>
References: <20240301133829.346286-1-james.clark@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Fri, 1 Mar 2024 13:38:29 +0000, James Clark wrote:
> This is useful for scripts that work with Perf and ETM trace. Rather
> than them trying to parse Perf's error output at runtime to see if it
> was linked or not.
> 
> 

Applied to perf-tools-next, thanks!

Best regards,
-- 
Namhyung Kim <namhyung@kernel.org>

