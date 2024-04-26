Return-Path: <linux-kernel+bounces-160755-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 14CB48B4267
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Apr 2024 00:58:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3C9FBB21F39
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 22:58:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D0753AC01;
	Fri, 26 Apr 2024 22:57:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kl.wtf header.i=@kl.wtf header.b="KJ8NL22f"
Received: from out-172.mta0.migadu.com (out-172.mta0.migadu.com [91.218.175.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7259438396
	for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2024 22:57:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714172278; cv=none; b=haHQSjPYL2BH3+anjliB97paQY67JzcNXeoI9J1gKFxTVTsZRPsFa0u+mapqzXpKnNP6MuUvHG5rKpMVfWJGH3qXe5zeN7GdTOxkEDL+Wcgl8lZlqcX78qTonK5xKg+7uqZ7e3ylkkQKVVv1v45Mr9IjgpPkKioWZ29Du4dNIFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714172278; c=relaxed/simple;
	bh=n5M6hS5g6y3ojVoJvmxqMM1bsyrtPVnjINp3YLX9H2U=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=VW/xlEKjCcreeT0cqrT6YfaWe26hJRZXFbZhxzRPMun9NVdpyyqVqfi6GS0wEtZhlft+nElXBQ8/+QjW90b0QgSniXqPt8S/fNYyFgVCQzTaZVMHwH57iqyvfj/oYfbpPlNjx6LI8KIbEIxh/5rc9k6A3Zn8y83yjHmC4Cjqs18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kl.wtf; spf=pass smtp.mailfrom=kl.wtf; dkim=pass (2048-bit key) header.d=kl.wtf header.i=@kl.wtf header.b=KJ8NL22f; arc=none smtp.client-ip=91.218.175.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kl.wtf
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kl.wtf
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kl.wtf; s=key1;
	t=1714172274;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=n5M6hS5g6y3ojVoJvmxqMM1bsyrtPVnjINp3YLX9H2U=;
	b=KJ8NL22fEE6M3mwOxelkjA4BVjJ/3jHnBZPP/dcyoAS2c1ho05tKVZmuhcp7CC01uZHqjm
	5RB7uQMTiv7+dqKgzgr//HjodurVgOM+BNkAeOr1a8fhD9BXt0SFhv1zzzju0oHNnj3jrE
	iLlW1hqIoleCSBUmIY8aO8eAs6AZq3wEHugwgyCWGbkI+CdzTAbA5Piyz7nKtuPzGNLfO6
	6NeHMKV0bLr6pyy2tOzMfHNGCrWP5uoo3JUxQDReG2oR3ZWDmTjwDq5hrPYLUqb6csBaMc
	Z6WeiAQnZaSx2xC9fLENf1SjnHjzRodvbkHLiDaSRC2TbZ20ovP7YyXEZBFPUA==
From: Kenny Levinsen <kl@kl.wtf>
To: Jiri Kosina <jikos@kernel.org>,
	Dmitry Torokhov <dtor@chromium.org>,
	Benjamin Tissoires <benjamin.tissoires@redhat.com>,
	Douglas Anderson <dianders@chromium.org>,
	Hans de Goede <hdegoede@redhat.com>,
	Maxime Ripard <mripard@kernel.org>,
	Kai-Heng Feng <kai.heng.feng@canonical.com>,
	Johan Hovold <johan+linaro@kernel.org>,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Radoslaw Biernacki <rad@chromium.org>,
	Lukasz Majczak <lma@chromium.org>
Subject: [PATCH v3 0/3] HID: i2c-hid: Probe and wake device with HID descriptor fetch
Date: Sat, 27 Apr 2024 00:47:06 +0200
Message-ID: <20240426225739.2166-1-kl@kl.wtf>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

The previous iteration of this was a bit naïve about bus error code
consistency from i2c drivers. Instead of trying to differentiate between
them, we now handle all bus errors during HID descriptor fetch the same
with a single debug log, as suggested by Doug[0].

As the change is relatively minor, I have carried over Łukasz' Tested-by
and Reviewed-by tags.

Third time's the charm?

[1] https://lore.kernel.org/all/CAD=FV=Xr6NsW085Sc+NhVmGDOn-zCCQ65CMNce_DsHxtXUgm9w@mail.gmail.com/


