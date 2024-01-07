Return-Path: <linux-kernel+bounces-18992-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 01A2D826622
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Jan 2024 22:30:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 869B31F214C2
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Jan 2024 21:30:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFD97125C1;
	Sun,  7 Jan 2024 21:30:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RiNY1B/u"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08789125A1;
	Sun,  7 Jan 2024 21:30:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2AF37C433C8;
	Sun,  7 Jan 2024 21:30:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704663016;
	bh=ykxaWQ1TgY2ChEJ+Tu65j6PVIzhmf7Uz5Tw6mV2kMT0=;
	h=From:To:Cc:Subject:Date:From;
	b=RiNY1B/uSBLNiQiwm8jTYRG72CIzzmX67QTpn0TbuexvI8SFAK1qELFNDrY5C+dqg
	 MojqYgbsjvE1PsFvUtZbfO/Oj6beoUr0XQZn0iY8+TuO4mrZlcIltExk6lPIaeevBf
	 6iEpc4Q9mRDTNSrE+DxDaA0XWCdH8VFD59V/BgZo+PkuT1fnMuIosQfAr1Yd7qyqY6
	 u+IP3LVygTq5gtZqBrNTgTwnXxD18TTmmKqU+vsLUxg4knQoHJY+2ZzfQT0opU0bu1
	 WOEMlQxSm48vht9rUWeoOejcLefUW3yVz+ax3leqgx6xAHqhE6z6OHO6+hq0uroz+n
	 +gd1puvFepI2A==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: damon@lists.linux.dev,
	piyushs@linux.vnet.ibm.com,
	aneesh.kumar@linux.ibm.com,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: DAMON daily performance test results since 2022-06 are uploaded
Date: Sun,  7 Jan 2024 13:30:14 -0800
Message-Id: <20240107213014.66831-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello,


We're running DAMON performance tests nearly every day[1].  The results were
occasionally shared for major DAMON code change, but it has been a while since
the last update.  I just uploaded all the results of the runs to the DAMON
project website[2].  I will try to continue uploading future results, too.
Hopefully that would help someone get better insights or find regressions that
we overlooked.

The results could be better formatted for easier review, and I was delaying
upload of the results to do the formatting first.  But I just realized that I'm
too lazy, so ended up uploading the suboptimal format results first.  Hopefully
this will motivate us to prioritize the formatting.

As always, please feel free to aks questions or help :)

[1] https://github.com/awslabs/damon-tests/tree/next/perf
[2] https://damonitor.github.io/test/result/perf/index.html


Thanks,
SJ

