Return-Path: <linux-kernel+bounces-49624-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DCF1E846D17
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 10:57:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8CE751F21F8E
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 09:57:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B203E182B5;
	Fri,  2 Feb 2024 09:56:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UCHawdzG"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9539377F3E
	for <linux-kernel@vger.kernel.org>; Fri,  2 Feb 2024 09:56:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706867805; cv=none; b=Dng3jsrFqI2YXG7kJ+yr3nvkjfYHdDy3ZgltdxOpMKWK9qDeEi4dGYJByzb/UCfLvngngloB2MBfzOM6uHJO5w2P7H1opNVLc4c5NGNk3jg3RBm0GDC9bdqnUuoVfsZKIwLAwJNMRnmlUYqkH0Nqv2l10T8v1Ew4+d/Qoh259Kk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706867805; c=relaxed/simple;
	bh=DPOMrDg4rKNH1QTC6aQIG7HRKerQiIwxkdnyzWqM6hg=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Cc:Content-Type; b=cnwo6EYcZ7tvbGLQE7EIpKX5KtQdtLWP5ri4SuNWit48UNXZORt07/1ycZdyYtOWoDhubg3I060DxDyWnK0n8BVUvA6oNmM5h0V/nG15UQABoNWhh7SGJK0yFumKeOE1vq3jU/ixXXHxu7PvBO2OiyOaT3H0xlVpgzY8DjwNe2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--saravanak.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=UCHawdzG; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--saravanak.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6040f058d3fso41224887b3.3
        for <linux-kernel@vger.kernel.org>; Fri, 02 Feb 2024 01:56:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706867802; x=1707472602; darn=vger.kernel.org;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=in2Ntwtloha/e+ZMm1Ao4y84QzaZLhLUFFn+wIIPR3U=;
        b=UCHawdzGbDfYJi+G5OUFfFOrGC4H4lD3CsT4/RiN1VY/my2gkK4crhCtHFCgTcNTCe
         iJ08cEkzyAqF4p97AAVxjeP2kNcLLge6Jl3m0IMtlM0/DO2oCM2ayjj94D3oacTqxmUH
         LUZJWnRMu9eRVeCaRvZYqHUf6o+weWeFerjFzOVoFLAE3cki+/HcAjhUu8vpBlcu/sHk
         GsSn2DejuJLgPfb7M6T7Ugqb+C+kDDsUt4vLnCEvwvsoM+5Ujzbi0SizfAUySOx2emch
         0+8pkrkUTw+XTF8y1lD5T4iP4QmwlQ09bbl65prOh2GvpS9aOE+GT5LXJRTZi4kuKnQU
         TmPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706867802; x=1707472602;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=in2Ntwtloha/e+ZMm1Ao4y84QzaZLhLUFFn+wIIPR3U=;
        b=qdySg4vAlznN1eNmmZ7T9gBv7HEk/WVo3K5DRSyawPdeTM9EfWdnLbyLfMEyfFzD4b
         oWuzGvhFYyzWlYayPVeQvMv6jLMcKe3OpY1ElblUugkFkYmsYun9gf5+37hWwHQet9Z4
         hEYimk88vhb+XnktftGjl1ABZYG89eptNJvfR+bLePGVoWrMytsPUVjcHM59s49gRw0E
         kedmUeSh/3lneOhg1QR2PXO6DpOKvZdT0JC/HqbuzjmkWAS9KR6UnePa64BACGUl/nNl
         k++UxX+Oe220HbXIEWVMsRry8Uq+Z6ZlrMMj3z9/N8pEdPKXGOlrOzgsUaSh7DN7j4Fj
         H4kg==
X-Gm-Message-State: AOJu0YyIPtk+Ze6zANvt6e7jlxhj1eDvAMBl3j+PVHioWWGqVLjp/En0
	fSvjzrO+/U6DTmy1uG2Nu8q5ccBg3+Enq1txdiARSQ0Yv9VpaTKzhWgD2dqp8nYHU7GxrQTy1OJ
	unkjVO2qwy+ZdDw==
X-Google-Smtp-Source: AGHT+IG2Yr1fmynQ8skS5upEg1x4dQZBACVStuyBP2QmiiCIh04vCsL4RY9kO3lof59k+OJcrmny6kk+NthYQIY=
X-Received: from saravanak.san.corp.google.com ([2620:15c:2d:3:6f0:da10:9cb3:5b3])
 (user=saravanak job=sendgmr) by 2002:a05:6902:218f:b0:dc6:1a1c:6a12 with SMTP
 id dl15-20020a056902218f00b00dc61a1c6a12mr460305ybb.5.1706867802529; Fri, 02
 Feb 2024 01:56:42 -0800 (PST)
Date: Fri,  2 Feb 2024 01:56:33 -0800
In-Reply-To: <20240202095636.868578-1-saravanak@google.com>
Message-Id: <20240202095636.868578-2-saravanak@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240202095636.868578-1-saravanak@google.com>
X-Mailer: git-send-email 2.43.0.594.gd9cf4e227d-goog
Subject: [PATCH v2 1/3] driver core: Fix device_link_flag_is_sync_state_only()
From: Saravana Kannan <saravanak@google.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Saravana Kannan <saravanak@google.com>
Cc: Xu Yang <xu.yang_2@nxp.com>, kernel-team@android.com, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

device_link_flag_is_sync_state_only() correctly returns true on the flags
of an existing device link that only implements sync_state() functionality.
However, it incorrectly and confusingly returns false if it's called with
DL_FLAG_SYNC_STATE_ONLY.

This bug doesn't manifest in any of the existing calls to this function,
but fix this confusing behavior to avoid future bugs.

Fixes: 67cad5c67019 ("driver core: fw_devlink: Add DL_FLAG_CYCLE support to device links")
Signed-off-by: Saravana Kannan <saravanak@google.com>
---
 drivers/base/core.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/base/core.c b/drivers/base/core.c
index 14d46af40f9a..52215c4c7209 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -284,10 +284,12 @@ static bool device_is_ancestor(struct device *dev, struct device *target)
 	return false;
 }
 
+#define DL_MARKER_FLAGS		(DL_FLAG_INFERRED | \
+				 DL_FLAG_CYCLE | \
+				 DL_FLAG_MANAGED)
 static inline bool device_link_flag_is_sync_state_only(u32 flags)
 {
-	return (flags & ~(DL_FLAG_INFERRED | DL_FLAG_CYCLE)) ==
-		(DL_FLAG_SYNC_STATE_ONLY | DL_FLAG_MANAGED);
+	return (flags & ~DL_MARKER_FLAGS) == DL_FLAG_SYNC_STATE_ONLY;
 }
 
 /**
-- 
2.43.0.594.gd9cf4e227d-goog


