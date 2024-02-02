Return-Path: <linux-kernel+bounces-49773-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DCCF3846F37
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 12:42:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EA7301C244F5
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 11:42:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB77C13E23B;
	Fri,  2 Feb 2024 11:40:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EzAeTxxf"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC0D41353E6;
	Fri,  2 Feb 2024 11:40:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706874018; cv=none; b=L/a6/4ex9PcwXWmA93yhdkpneF/pHxWcz8Nw3jsn8pI1j4Dz90c0Drb1MpCgYqG4WMfUG1yYvF0Xh9Vfd1nHDW+jNl+K5HK8KOqjWU2D5kvjrX9bUY7fd5TNR/ijdMm0Rpz0qDw66s3fed1pLcnuJKiQTYcPxpSXRBA+NxRVr6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706874018; c=relaxed/simple;
	bh=pmXNxJih0SLNrS6yznEg0TwMHpWWCdklmhtMMEiE/70=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=tpb6UwDG/5KBJDHK3grfG91DzkiWBEu0tr8erKOXOLc9pUddoZkSQ3TVq1PBwNsVv094Hc0W4+aa4+D+1zrzzC/GmbqiIagaFaasVDr8hplaXsLtWln+FXIL9Cn3hL/QRQrqUJRnR7pLg1NOwYCEOl9QCOy7VP7ZRHv/keeayes=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EzAeTxxf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D26AC433C7;
	Fri,  2 Feb 2024 11:40:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706874017;
	bh=pmXNxJih0SLNrS6yznEg0TwMHpWWCdklmhtMMEiE/70=;
	h=From:Subject:Date:To:Cc:From;
	b=EzAeTxxfbwnmZ5ABAlgmUUZC87P7Vmrh4XiRlDuffR968ew01pt+gwyAoyWTncIU2
	 GnU99K0wCA4v7tTNMR3RAnF5YyNL0njlVQx2GnamWv6bvyShxcWE74NIdaIwqgxudh
	 bfm2aEmPcQrKpeJKIacrgEbcmlBMSyUHfRpTpsWuEHoofNhS3hZaRQETIdgxSPC7S2
	 lsJZIoDpvgE0sX/Lsn6u79LhWYz4Jidzbditge2K1vxaEGgLp3PeSG162O8oJ5M1PJ
	 1Ax8oFhGLz+AhJD08aVT+offXiqVZ587AwVPwDCl7mjv3WUgzEIztKuQ++xzPTWMRt
	 n3C8jdb3DqOiA==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Subject: [PATCH net-next 0/5] mptcp: annotate lockless access
Date: Fri, 02 Feb 2024 12:40:06 +0100
Message-Id: <20240202-upstream-net-next-20240202-mptcp-annotate-lockless-access-v1-0-031d6680afdc@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAJbUvGUC/z2NwQrCMBBEf6Xs2YVYDKK/Ih6WzbYG2yRkVymU/
 rupoIeZ4TEws4JKjaJw7Vao8o4ac2pwPHTAD0qjYAyNoXf9yTXDV1GrQjMmsabF8F/NxbggpZS
 NTHDK/JxEFYl5j+HMwV28D+QZ2n6pMsTl+32D3xrct+0DPt7CLZUAAAA=
To: mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>, 
 Geliang Tang <geliang.tang@linux.dev>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=1729; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=pmXNxJih0SLNrS6yznEg0TwMHpWWCdklmhtMMEiE/70=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBlvNSeZXfgyaBrW3yctwOh+35j3mF6YJ4r0oL7H
 PBmlFPoFkOJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZbzUngAKCRD2t4JPQmmg
 c0MnEAC6AM4hqiBA6uPXs/5xZo1rjIe9ZfGq2zXplEhmjNr6h7BaRVr/UF/PbaXtbegsIdHaP7P
 gqUlHlt3OoFVUHwOCQhfOWVN9DGHrpRl7IBbI5QgOhExnQutKOlKstHuHmV/C/Q3sFHwklQnCZ9
 MJP1FI68TacA88KKBJyMeHxxWgFHhfEv2OUhOgP6T/tFBDF9393f6eDpZr41vZlluK47GC1I389
 0pMr+Utab9GUPDwi/hOfjj5ohdU94wkDNWVPhJCtB9qA10NpvGn7fbSalTmclYjlzVyORXFzfq+
 a9aBW1YWtKwwHg1EB41r80fnDQq4bS3du3HwC9InPLEmBzZRLqmkYiPjBQFxWCuUWDKV+0d33EJ
 hJ1Ur/nopGt2/z4LYXfb+SSUfp04N2PTQbF6PEGOPNWhbszE/4/swfdn3w0JflKz7/Jok2OV+tf
 I3+bj3h2xn8GtSABjVll1TTzGDqckjVFE68+6QU+M0UAkIF3KlO+NOj9tNmGthTeeBBJZtpZdWg
 5m8OsqUu19OfM+G8NCiWco7TNUTqyTix3srvs+8RuIaY12ygMNuEPciWCWCDPOfS/3loe4dCRAq
 dbhrlxhcoWRPLvZ5EEXORfysvoP5UM3bQkFEnBxne/fwOwNUKE0SRu1/dMuvnWjZTftcsysemzg
 sl152w8rYtOSKPg==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

This is a series of 5 patches from Paolo to annotate lockless access.

The MPTCP locking schema is already quite complex. We need to clarify it
and make the lockless access already there consistent, or later changes
will be even harder to follow and understand.

This series goes through all the msk fields accessed in the RX and TX
path and makes the lockless annotation consistent with the in-use
locking schema.

As a bonus, this should fix data races eventually found by fuzzers --
even if we haven't seen many such reports so far.

Patch 1/5 hints we could remove "local_key" and "remote_key" from the
subflow context, and always use the ones from the msk socket, possibly
reducing the context memory usage. That change is left over as a
possible follow-up.

Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
Paolo Abeni (5):
      mptcp: annotate access for msk keys
      mptcp: annotate lockless access for the tx path
      mptcp: annotate lockless access for RX path fields
      mptcp: annotate lockless access for token
      mptcp: annotate lockless accesses around read-mostly fields

 net/mptcp/options.c    | 20 +++++++++----------
 net/mptcp/pm.c         |  2 +-
 net/mptcp/pm_netlink.c | 10 +++++-----
 net/mptcp/protocol.c   | 52 ++++++++++++++++++++++++++------------------------
 net/mptcp/protocol.h   |  8 +++++---
 net/mptcp/sockopt.c    |  2 +-
 net/mptcp/subflow.c    | 10 ++++++----
 7 files changed, 55 insertions(+), 49 deletions(-)
---
base-commit: 747056a9a954d694dac91d1da6cfff5e6f0e3fc6
change-id: 20240202-upstream-net-next-20240202-mptcp-annotate-lockless-access-f7cd0955da5c

Best regards,
-- 
Matthieu Baerts (NGI0) <matttbe@kernel.org>


