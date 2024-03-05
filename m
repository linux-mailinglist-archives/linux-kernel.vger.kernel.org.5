Return-Path: <linux-kernel+bounces-92212-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 54836871CD9
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 12:05:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8633C1C22853
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 11:05:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2EB65490D;
	Tue,  5 Mar 2024 11:04:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OVrDyMAz"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E083D5B5A5;
	Tue,  5 Mar 2024 11:04:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709636680; cv=none; b=E0+vjinZkyeh1NRLtASY9huQ60pfxf/gqfh+SHXrO9LxEcWrHJsk92ww8g5SUH3MAxpjT3Tc6uevUquniVMoozuSfxln3l5+6G/1PEOtGuNZ8nObbOBlAQnB88PuuxQszIEu2vUWFIJy7kTGWNVOOnwpDbI67MZ5kuT093Vc6cs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709636680; c=relaxed/simple;
	bh=aKmI+W1f1KopupyDZ900tVuISdnIElNXqW6osHOWD+Q=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=ECnTHk+Q1qTHvp3GokXlfooYttcjTFI5AkAlhAoEPI/PF/EwfDBtRd8FAgJdbCcORs5vflq3RRJxd6axqHWGaVrwRAP1JFsZFXGzgOrBP85En6UJ3R3RI76rfVk0l0+CaKj0Hq6Z28cnAUH0x5lumvG4yP3vz1lXim43Q3NZ5ao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OVrDyMAz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7C67C433C7;
	Tue,  5 Mar 2024 11:04:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709636679;
	bh=aKmI+W1f1KopupyDZ900tVuISdnIElNXqW6osHOWD+Q=;
	h=From:Subject:Date:To:Cc:From;
	b=OVrDyMAz8Hkx/q4ZDdCZ+zwlGNDwxrdWQ4au4LwFVTt0MskDkdb0SQh8wyiCMmJ+k
	 0P9gFhstbekIdzm3LY0JsSgfx0ajUfAuNfMaaszEgoOdNQ98g3uAQ4gkY1T25Le/KQ
	 +xT/XFi6XZoO1audkiH60R/2gMlr/mJpL6P/wZMOqd0sKWSo+7zKTlYSw6eNiyaFED
	 Zb/DpCeYnNDthBe7/NjwjfTpXLjLbrJ1nIfJXV2Hn5iQwM2krjsrzZ4PrjupCY903Y
	 rOSXngzRDDV2DUef5ZFg02qwH0mGHVLxIVAOsC9hVpVKEinLyt7NdEjFqk5Av2Zud4
	 kXICzeyigyC6A==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Subject: [PATCH net-next 0/4] mptcp: some clean-up patches
Date: Tue, 05 Mar 2024 12:04:29 +0100
Message-Id: <20240305-upstream-net-next-20240304-mptcp-misc-cleanup-v1-0-c436ba5e569b@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAD385mUC/z2NQQrCMBBFr1Jm7UDSNoheRVyk6UQHTBwyaSmU3
 t0g6OIvHh/e20GpMClcux0Kraz8zg3sqYPw9PlByHNj6E0/msGMuIjWQj5hptq2VfxfSWoQTKw
 Bw4t8XgTtZY4u+vNknYPmlEKRt2/vBj8D3I/jA6gDI5SJAAAA
To: mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>, 
 Geliang Tang <geliang@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>
Cc: Geliang Tang <tanggeliang@kylinos.cn>, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1337; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=aKmI+W1f1KopupyDZ900tVuISdnIElNXqW6osHOWD+Q=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBl5vxDgH6Oh0C4/wsnEzq7FnApRlcboeVNm0Bas
 Bx7+Cv/54eJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZeb8QwAKCRD2t4JPQmmg
 cyDuEADKoTN39Jvuz2XxiXa/ch01AetVgiX4fbl+jEIlzbFTFd8p5EvWhVmHyj5by8MXAnlzuZT
 0cHFbSRmWoiO2j3ZXaZKRNFlhHa81s4vog7ouxArVRESpNCj24jZGUrUXBJ+JziLzAfOfipZJGR
 wrYOZ9y0M4Yd5CBpBoDWimnklAC2APPbrFCp5C0RJCribydklxk+KfEijDNCyEHaMy/86pbB8ro
 q8H3osWITapoieuey4Qh7sV0PIQh6uJ2JGhuEjOAYwcdaPZQXRW8DjUD62qFdhNGT/CPJyl5P8o
 XrvvpZjHfEPajxbxROc4kGVDp/ykpc4MzvkcmsegXPPrHktDlQdmVUaBByxnr91Ekjuvb4Ou2ho
 wWEdfIQNY9mO+FtxilTH6Q01d0H3uUdHZHcuH1OU1dVSaCJT0n3DLl+ueVIw02ORlUqEWaScV5i
 QDvKUmTXdvr3hI0bnUl3tb0tCWJGOea9d3zuRR7uLe2dja4kfVePik0IAvoVJYopU1s2mYh/FX/
 VDUp/LrPt+RuPqMcfQn3XMjk18MU6C22LvT8PLUggyybr1/NbSedYvjwppgq5dE6AvOs6lV3hZm
 ec9HpJeoJcERSvTWoN1PcYmq8B/eKkDHD5/AifGAfigBSHKDmPjAXek5GTlQ2xNTspcVoim9tnj
 HFK3tvGa6TM+gxA==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

Here are some clean-up patches for MPTCP:

- Patch 1 drops duplicated header inclusions.

- Patch 2 updates PM 'set_flags' interface, to make it more similar to
  others.

- Patch 3 adds some error messages for the PM 'set_flags' command to
  help the userspace understanding what's wrong in case of error.

- Patch 4 simplifies __lookup_addr() function from pm_netlink.c.

Except for the 3rd patch, the behaviour is not supposed to be modified.

Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
Geliang Tang (4):
      mptcp: drop duplicate header inclusions
      mptcp: update set_flags interfaces
      mptcp: set error messages for set_flags
      mptcp: drop lookup_by_id in lookup_addr

 net/mptcp/diag.c         |  1 -
 net/mptcp/mptcp_diag.c   |  1 -
 net/mptcp/pm.c           | 11 ++----
 net/mptcp/pm_netlink.c   | 97 ++++++++++++++++++++++--------------------------
 net/mptcp/pm_userspace.c | 41 ++++++++++++++++----
 net/mptcp/protocol.c     |  1 -
 net/mptcp/protocol.h     | 10 ++---
 net/mptcp/subflow.c      |  2 -
 8 files changed, 84 insertions(+), 80 deletions(-)
---
base-commit: 09fcde54776180a76e99cae7f6d51b33c4a06525
change-id: 20240304-upstream-net-next-20240304-mptcp-misc-cleanup-19df5fa7b155

Best regards,
-- 
Matthieu Baerts (NGI0) <matttbe@kernel.org>


