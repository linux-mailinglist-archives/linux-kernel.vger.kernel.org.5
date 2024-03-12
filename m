Return-Path: <linux-kernel+bounces-100774-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A4F8879D18
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 21:51:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5FAE5B22EE8
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 20:51:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A42A14291E;
	Tue, 12 Mar 2024 20:51:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p60KF39Y"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD070382;
	Tue, 12 Mar 2024 20:51:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710276689; cv=none; b=A5lVcqB+bQ5QPIUz2uPYcpPZF6vQluB4Cw9bdcM5eArPAoDX4VXmrpChdqeIpY+Uq+4Ovi8Yrz3J5s7vs9S3BhFe/tZFWGSGmuoqCohbv0CuI6AsNahErKF1kduvu+Tx/65onDxZ9Vjjy8K8sNatNcplE3AcLbk4C/jFqM5Cc60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710276689; c=relaxed/simple;
	bh=UF3BR9cP/8EFmHQ9N2uFh6SQvuijqiPqWC24undZuj8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EXEXQhxkAvPL8qtgcnE5HSa469LZexGeUNuKgfkTO4jyeK36Drm6ispKuqvQKl5zotLAwZvQkBevVgT7W9n6PoAK3mnup8NrXeKrTFw4CCvYUEdGtrdulYNxk/EghQ5CZPdOeK6WeNvVnCPB8PKuTKPXFrFfnOful1gVw1NWSxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p60KF39Y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9EBBC433C7;
	Tue, 12 Mar 2024 20:51:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710276688;
	bh=UF3BR9cP/8EFmHQ9N2uFh6SQvuijqiPqWC24undZuj8=;
	h=From:To:Cc:Subject:Date:From;
	b=p60KF39YytFlozmRyxCw1kyC7LJrQBn0kyb2vO3b94jS04+2phn/81RCJkwnEZWMk
	 jSrTzcvfaf1YB+vK6cJ9TPrJfSkLmyDE55ydw0vBisWCQn+AveHywmiG5RUJcVEPNA
	 mAoXsxOp1pJPHFjPH/JG4AqeFJbnbpAoFKFOIu39PEKTAYKPV3+rRsBhoVet4Aig2X
	 1EQKZe7DaD6hxmjkaIFgzd8WUFUxfDNYtk3/SynGX0TBP//ZW+L9QzS1sf0ezGWE5L
	 /AMztrHMSAMuD44euVs6VWwS9282Oqr26Filfh7Lc6x4t9SjlWT2+50Nm5lBQDRb57
	 dqWODdCii5N0A==
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Jiri Olsa <jolsa@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 0/2] Move more stuff to tools/perf/trace/beauty/include
Date: Tue, 12 Mar 2024 17:51:10 -0300
Message-ID: <20240312205112.688776-1-acme@kernel.org>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

	Move one more file that is used by multiple scrappers.

- Arnaldo

Arnaldo Carvalho de Melo (2):
  perf beauty: Don't include uapi/linux/mount.h, use sys/mount.h instead
  perf beauty: Move uapi/linux/mount.h copy out of the directory used to
    build perf

 tools/perf/Makefile.perf                      | 21 +++++++++----------
 tools/perf/check-headers.sh                   |  2 +-
 tools/perf/trace/beauty/fsconfig.sh           |  6 +++---
 tools/perf/trace/beauty/fsmount.c             |  9 +++++++-
 tools/perf/trace/beauty/fsmount.sh            |  6 +++---
 tools/perf/trace/beauty/fspick.sh             |  6 +++---
 .../trace/beauty}/include/uapi/linux/mount.h  |  0
 tools/perf/trace/beauty/mount_flags.sh        |  6 +++---
 tools/perf/trace/beauty/move_mount_flags.sh   |  6 +++---
 9 files changed, 34 insertions(+), 28 deletions(-)
 rename tools/{ => perf/trace/beauty}/include/uapi/linux/mount.h (100%)

-- 
2.43.0


