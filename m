Return-Path: <linux-kernel+bounces-69603-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D682858C3F
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 02:02:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 08CD928247F
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 01:02:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D19B41B59D;
	Sat, 17 Feb 2024 00:58:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tAtziyMr"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6C0822324;
	Sat, 17 Feb 2024 00:58:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708131527; cv=none; b=oxKrwtZK5CpiAV7ps/aJXd5Q16syT6yCPYtXqM6MoRUNHHX8sRQOT+EfcGkgK8PAjByBDeLMf00kWenS1vViD0988hHVn/RGCNocK7ywmgl4xbfv4hdDl0oGBuz8XHcXKryoyefzsQjDFjPv2XjftekFmSFUFhIKAwLAdkl4yH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708131527; c=relaxed/simple;
	bh=8h4idkcZ9/velcicL8yw70oYm4VFVe3u7WuORG7lR/U=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=FwP/FLCUQjhPvcKaVm/1SzTGJlJmDX+LBcLoSheecD0NUlSq1olpeo2ibBlAdvLAKblrCW0J1i1aNPkwfsz/y9AMr5RHQhYph9Y7cjiBdX1U5xPX+HOT3m7L+5HxdvUHROwd5MFr2uk5W9Bi1/8pXw0wCTZoIh115Z1rVqxfKIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tAtziyMr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1F96C43390;
	Sat, 17 Feb 2024 00:58:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708131526;
	bh=8h4idkcZ9/velcicL8yw70oYm4VFVe3u7WuORG7lR/U=;
	h=From:To:Cc:Subject:Date:From;
	b=tAtziyMrc7FCbaofVYCTw1A3vCMjt0XX3cQIF6jFmHJqY/oalZ2Q7valmatDwSYue
	 LlUjvwgPjnC/l/0STKV4suYFupObrmuTRLTK+9r72Cvt4Q0ElFJVtR6XaY1ez5MyYW
	 w1XM+7WYtLUfc2wY6iW4KBhz9CNVasJk0aSZt55HfMAbgk9pnhmwjo113Jmk8fNxd/
	 Kg5nYEozsNADjvRJkNdU7VeaCSXhfc6WL2FVl3TS5gcuYJX8/mZ5RnSNw3IjoY/gO5
	 b7Ta7LVOgwhq+Hko4SZJWpzJU+vBwzlqYnqR6weeViGMT6muD8QqCiLcZmiYkn/sY9
	 Ha4v5JtbRavbw==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/5] Docs/mm/damon: misc readability improvements
Date: Fri, 16 Feb 2024 16:58:37 -0800
Message-Id: <20240217005842.87348-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix trivial mistakes and improve layout of information on different
documents for DAMON.

SeongJae Park (5):
  Docs/mm/damon/maintainer-profile: fix reference links for
    mm-[un]stable tree
  Docs/mm/damon: move the list of DAMOS actions to design doc
  Docs/mm/damon: move DAMON operation sets list from the usage to the
    design document
  Docs/mm/damon: move monitoring target regions setup detail from the
    usage to the design document
  Docs/admin-guide/mm/damon/usage: fix wrong quotas diabling condition

 Documentation/admin-guide/mm/damon/usage.rst  | 85 ++++++-------------
 Documentation/mm/damon/design.rst             | 50 +++++++++--
 Documentation/mm/damon/maintainer-profile.rst |  8 +-
 3 files changed, 73 insertions(+), 70 deletions(-)


base-commit: 1a09812aed136b8caa4b976c78135b1e99d16412
-- 
2.39.2


