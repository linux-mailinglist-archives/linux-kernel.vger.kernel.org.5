Return-Path: <linux-kernel+bounces-35629-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BF6283945A
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 17:11:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6E4BA1C26E1F
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 16:11:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAB66664C6;
	Tue, 23 Jan 2024 16:10:05 +0000 (UTC)
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B04763511;
	Tue, 23 Jan 2024 16:10:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.126.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706026205; cv=none; b=T0lC3V8FWvE7kuSlwJG7/ki+EuFt/L1YL9j9NmYQV0iJExpvZJOVa6aLlsxBc0ds6OAQNAfBGS4++pE2NLHtQr03dx5uzTQ6pkmrIcmRe4VF8lK0TDoGblYfTAV6yOqfs25gKzqbVBQiQIgWG1qQpmhX8QZ6eXVt7G8m4qiE8/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706026205; c=relaxed/simple;
	bh=vqGse0J/VzdCW0jsSamCryiiEi2OKG6PX8sSBlLVGaU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SoPp86GDmYKjaCbYDHVR1yO7rUCX4T1LVw2pgFi/NlfYYVl+oS1aR/ey7zXjGjvv4mYBizGaAXh9C35MewR3uRV/Gzsr78o6DKOSKmJ0XDwQvl4jK0YOUoIdk3xpNp/RWuTcCCxU+NuKhcBYj9H5zT3yd6yJLpcWcdpDoPS9Lho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=valentinobst.de; spf=pass smtp.mailfrom=valentinobst.de; arc=none smtp.client-ip=212.227.126.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=valentinobst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valentinobst.de
Received: from localhost.localdomain ([95.223.130.98]) by
 mrelayeu.kundenserver.de (mreue010 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1Md6hP-1qs9aB0OwN-00aD4z; Tue, 23 Jan 2024 17:09:56 +0100
From: Valentin Obst <kernel@valentinobst.de>
To: Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Wedson Almeida Filho <wedsonaf@gmail.com>
Cc: rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 09/12] rust: kernel: add blank lines in front of code blocks
Date: Tue, 23 Jan 2024 17:09:55 +0100
Message-ID: <20240123160955.125365-1-kernel@valentinobst.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240123150112.124084-1-kernel@valentinobst.de>
References: <20240123150112.124084-1-kernel@valentinobst.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:NnxvmERd/P/mfjrEmRtmikwaiBnqYIQP8fv4hY0wnbrU2U6aaJ2
 XeVs6Jra1qtnsUF9guX0jtVD4tCz0lZtJkauGQKHisA/Kv5YUMxatR3hpPcXGIaE2WjIBLH
 SEuP9gTIvXhPJBG2Zdbb4hDJJndQjFgoc1cY/XlIbBP8q7EH1jZC1XCjjyLCJ5hQ66FzRy7
 VCyqMIm4heY1WaLDx7Viw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:uPLII7ESCc0=;r6j2HXtUl2O7ze2zRdnyNNvBgeh
 bD/f+S5Ve3pvxPJqztr0eq9eiZOBdnUl70OM5aGuH8eN0Pk1GPSPssBthqfzxVboqQWDGpM1K
 kxeErRQRHAtJKT4PDnLqfRPkVeztkon7pi3bes1wsMyPb9i+8XxHu4PZ45+p8p+jIXAxT+kBt
 2U/+GsisnVNK0uYruAiIRn3SveTj/DEQP0qJ5OSBKbHmXmYqPA2rJOqxf0VbsPZ21LCG1facU
 XtnfmPkOgOSr1HYNADJviH4d/3FA/0tq6LMaFEWdxD30ODTr/PnPY0ulCl9Oyl9+znTIE16+H
 y53QgZAeoYsmaiQzcFeKCVlrPfEHio6LrL9gw6zsWYtL4DQjfFGV9rAbrMF8r9j8DLiK7DZ+1
 OvZk8nPv7/Nmn02SZq5WEVp1o4hsjF7nW5g6OKMjSobySqrkeiqyRVNYsrYxilzURONxeG9nd
 i6D4jCX3R/Qw1XrMPTudc6zLSDVxA84FpmxmZSivuVCDEUY3hMub9Ln5eZuRrrefXcYANMdRs
 HNgKxgtl+hcG5Irgn0k5xQIKfaAXMpbXmQ7/jZiCc7PRc7DYaTAAGwcycJk3EOCKUIPKRDGdO
 3osoFu/qC87qNpZMXKNf8MNnVTTCpbmyY1kIb9G4Vx+qIt5B1Xntw3o95BtNeHOQTFaUx0H65
 cAU4XzZjNAjKOL8DyA8DpGB0wHeUvMeIAlaDiqeoIvNvNpLI90RRfGSz8FQ62Q+sZwK7wd/nh
 2klyLU4mrlsabdvC+h8YnCANKZZ8/3N1BuEk8nSOoKfxtjRY0DiEyDLAY8BG17VSBPCaIviyM
 KfThMfH52bON5lrs5WHkJnEWlnaAWxZXmLebAC855Fd+5mOhKQ/KOxkiSzcqesHRRSOaa2Z/F
 ifn72iHbHP1BSUA==

Throughout the code base, blank lines are used before starting a code
block. Adapt outliers to improve consistency within the kernel crate.

Signed-off-by: Valentin Obst <kernel@valentinobst.de>
Reviewed-by: Trevor Gross <tmgross@umich.edu>
Reviewed-by: Martin Rodriguez Reboredo <yakoyoku@gmail.com>
---
 rust/kernel/types.rs | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/rust/kernel/types.rs b/rust/kernel/types.rs
index fdb778e65d79..8aabe348b194 100644
--- a/rust/kernel/types.rs
+++ b/rust/kernel/types.rs
@@ -90,6 +90,7 @@ unsafe fn from_foreign(_: *const core::ffi::c_void) -> Self {}
 ///
 /// In the example below, we have multiple exit paths and we want to log regardless of which one is
 /// taken:
+///
 /// ```
 /// # use kernel::types::ScopeGuard;
 /// fn example1(arg: bool) {
@@ -108,6 +109,7 @@ unsafe fn from_foreign(_: *const core::ffi::c_void) -> Self {}
 ///
 /// In the example below, we want to log the same message on all early exits but a different one on
 /// the main exit path:
+///
 /// ```
 /// # use kernel::types::ScopeGuard;
 /// fn example2(arg: bool) {
@@ -129,6 +131,7 @@ unsafe fn from_foreign(_: *const core::ffi::c_void) -> Self {}
 ///
 /// In the example below, we need a mutable object (the vector) to be accessible within the log
 /// function, so we wrap it in the [`ScopeGuard`]:
+///
 /// ```
 /// # use kernel::types::ScopeGuard;
 /// fn example3(arg: bool) -> Result {
-- 
2.43.0


