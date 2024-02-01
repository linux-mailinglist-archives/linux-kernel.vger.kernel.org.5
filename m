Return-Path: <linux-kernel+bounces-48661-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 59936845F7D
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 19:11:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0C97A1F2BF8B
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 18:11:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CDC38526D;
	Thu,  1 Feb 2024 18:07:16 +0000 (UTC)
Received: from mail.someserver.de (mail.someserver.de [116.202.193.223])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D46912FB00;
	Thu,  1 Feb 2024 18:07:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.202.193.223
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706810836; cv=none; b=GfGJR0SVnMIRHOBHljEuY/0e/FH3cfcqsqHDgho4yK8ufc3vP/2gWEdsMz+Zg6OHpggLlfNCaEv4cTRzvnAOeix7E9Sb6OO/5s/BoMeI3i6ZD7/6XdFblSnbISD6u8xZvoyRqFfuVceg97nIQd0rnYhFmw6kKXL0FyyDcXGDfFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706810836; c=relaxed/simple;
	bh=jWA5iTRD69ucDNwkpZwR5jCH+P2otKImG+J2kWpMQs8=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=ckf0wEhSkc25Chs4CfzO8gMYwLo3J0H0Rtc59yMtST9u95saXZdYCCSzEFMirLk/m9dWD2ekBvNspWAg+WT+ZrnGmtuqbA+DV6WvC4+HGT2xlO+/DJm0cy6vXvrexD8jYvmmaCTgqkSqS0fPmJLuQAggdwhRxulk+AlenrDd50A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=christina-quast.de; spf=pass smtp.mailfrom=christina-quast.de; arc=none smtp.client-ip=116.202.193.223
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=christina-quast.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=christina-quast.de
Received: from localhost (unknown [195.162.191.218])
	by mail.someserver.de (Postfix) with ESMTPSA id 80FA2A211E;
	Thu,  1 Feb 2024 19:07:10 +0100 (CET)
From: Christina Quast <contact@christina-quast.de>
Subject: [PATCH v2 0/3] Add Rust Rockchip PHY driver
Date: Thu, 01 Feb 2024 19:06:57 +0100
Message-Id: <20240201-rockchip-rust-phy_depend-v2-0-c5fa4faab924@christina-quast.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAMHdu2UC/0XMQQ7CIBCF4asY1o4BWtvqynsYYyhMZWKkONBG0
 /TuEl34dt/i/YtIyIRJHDeLYJwp0RgK9HYjrDfhhkCuWGipa6mlAh7t3XqKwFPKEP376jBicNB
 0yvV1K9syUe6RcaDXN32+FA88PiB7RvMPqkr+Oj1lmBUoQKfRNVV3MPvuZD1TyhQMPCeT8s6hW
 NcPdt7myrMAAAA=
To: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
 Wedson Almeida Filho <wedsonaf@gmail.com>, 
 Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <benno.lossin@proton.me>, 
 Andreas Hindborg <a.hindborg@samsung.com>, 
 Alice Ryhl <aliceryhl@google.com>, 
 FUJITA Tomonori <fujita.tomonori@gmail.com>, 
 Trevor Gross <tmgross@umich.edu>, Andrew Lunn <andrew@lunn.ch>, 
 Heiner Kallweit <hkallweit1@gmail.com>, 
 Russell King <linux@armlinux.org.uk>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Heiko Stuebner <heiko@sntech.de>
Cc: rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
 netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-rockchip@lists.infradead.org, 
 Christina Quast <contact@christina-quast.de>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1706810819; l=1206;
 i=contact@christina-quast.de; s=20240130; h=from:subject:message-id;
 bh=jWA5iTRD69ucDNwkpZwR5jCH+P2otKImG+J2kWpMQs8=;
 b=x2+WW6v6zLMM6XjRuSZYbZ89dx3Cl5LmXdahaHthccc/4Gh8+ZzNrEDkpGaplAm9LUlUMptAJ
 DRo0OfTS6bQB4JaHE1iLovyZ7EjwiZi42bBiADhExh0vY5oYleM7WbV
X-Developer-Key: i=contact@christina-quast.de; a=ed25519;
 pk=aoQfinjbnr265vCkIZdYteLDcmIqLBhY1m74WfFUU9E=

Based on the example shown in drivers/net/phy/ax88796b_rust.rs, I ported
the rockchip phy driver to Rust. The code in drivers/net/phy/rockchip.c
was basically rewritten in Rust.  The patchset includes changes to
phy.rs, adding more struct driver functions for the abstraction with
Rust.

The driver was not tested on real hardware, because I do not have a
board with this phy, and I would appreciate it if somebody could try
out the driver on their board.

Signed-off-by: Christina Quast <contact@christina-quast.de>
---
Christina Quast (3):
      DONOTMERGE: rust: prelude: add bit function
      rust: phy: add some phy_driver and genphy_ functions
      net: phy: add Rust Rockchip PHY driver

 drivers/net/phy/Kconfig          |   8 +++
 drivers/net/phy/Makefile         |   4 ++
 drivers/net/phy/rockchip_rust.rs | 131 +++++++++++++++++++++++++++++++++++++++
 rust/kernel/net/phy.rs           |  31 +++++++++
 rust/kernel/prelude.rs           |  16 +++++
 5 files changed, 190 insertions(+)
---
base-commit: 6613476e225e090cc9aad49be7fa504e290dd33d
change-id: 20240201-rockchip-rust-phy_depend-681db4707777

Best regards,
-- 
Christina Quast <contact@christina-quast.de>


