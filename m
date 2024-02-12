Return-Path: <linux-kernel+bounces-61916-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A6E885185B
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 16:44:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EA902283252
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 15:44:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2B193CF52;
	Mon, 12 Feb 2024 15:44:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="gvwzSIiJ"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F157E3C47A
	for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 15:44:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707752660; cv=none; b=fkxCiTUMXAblPxoRO9IDyMZgjEwsMUtfRd/gWlZc+uxsYyGpilP4TcfCXw/R6PFF5DPnqg+kYu1NJ32tr71wZuuC7wIWWQvszvdt7CA0qvaVuunovOLvUaHQnqp32/vXYyzqO2PS67PbYXdGkUxY9newzDGZu6Mt0O9TfGEtxCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707752660; c=relaxed/simple;
	bh=DuWooxehG51sbKHAsZKz8zHToDeDrbn0yGOhEGQd2J0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Jk52eyXGZs170XslQG5BKwlEd4irz4XneRds8JdGI63L39KxTByagRgqHkIhFi4j1sCIjTtII+/V0fuf3iaEzm5FD3uCOsxSJ/gtEGqEQx4jK5/87U01lwBZwSkBEQ1TXxQF0Kq8ME9NtocJaTZ++eE6Lw0N3I99rz4M2QLXFDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=gvwzSIiJ; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 61AA840E01F7;
	Mon, 12 Feb 2024 15:44:14 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id iFjZJW1ukjzr; Mon, 12 Feb 2024 15:44:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1707752651; bh=rmax0uP6wSuCXxCVo1h3x5JspaS3UGIbE3m2gh3bdQg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gvwzSIiJbbQAOwvcNM48q7fgcJQDHw563+As1ZJMdxQVpfW7/u7sAKU1OBy7iiDBK
	 WkmlotLZQ7+X4rJSniTjWYpJNjW80XAgSYs7fDU4Of6oi5cn42legBEpK99EbGiZ7x
	 kET0iGZIjJ3gXtv5WDJXP8C/CnXGdUE4DNE/ZHneCgGP1e1P7OsVFAlY8ujmpo4ex7
	 nZs+9hVh+2sQMaqG46Uh+UjUiGIVRjmU8yTiRsf9dSM5iIBwDfTCE7GpHICz/D8/dp
	 +XQ/rktupMmvPbja10Y+ERE6qxjEv3qh8E2hGmGc/pOumDGsu76iJwyzs31BefFysU
	 fq+LQDwRsEjQYG3ZnROSmijVrQbCJEwF48zy2Ywd4DHaFGRYtdsFWsGuOSeZHfv+ky
	 fgXgbMMx08oUeZkijHjjIBsuvvXZh4QopE9k+MlN7jvIez391id11kMKvEKkXWEDXZ
	 sM2vklGr7pKTYhMWh7KRTBMZG2vHAH2tp4/56DGg+3yoIdqG24zE5pLgHY2OKuFgDV
	 HG08Y7EqpGR8Qvd4Ac1msMQcBXX70GLsi37ojpJnxFtUv8taGo7V3CnOk9UYjK5jeI
	 3/1QlhW+Se/99LYLCyeoNlp7s0dtBcS6A2oJLq5+tKjReR37Wfx70GYVTO4SqTAyDP
	 qGDe8k3I7UX4OngjBZuP6JsA=
Received: from zn.tnic (pd953021b.dip0.t-ipconnect.de [217.83.2.27])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 02E1340E01A9;
	Mon, 12 Feb 2024 15:43:52 +0000 (UTC)
Date: Mon, 12 Feb 2024 16:43:47 +0100
From: Borislav Petkov <bp@alien8.de>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
	Tom Lendacky <thomas.lendacky@amd.com>,
	Andrew Cooper <andrew.cooper3@citrix.com>,
	Arjan van de Ven <arjan@linux.intel.com>,
	Huang Rui <ray.huang@amd.com>, Juergen Gross <jgross@suse.com>,
	Dimitri Sivanich <dimitri.sivanich@hpe.com>,
	Sohil Mehta <sohil.mehta@intel.com>,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	Zhang Rui <rui.zhang@intel.com>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Feng Tang <feng.tang@intel.com>,
	Andy Shevchenko <andy@infradead.org>,
	Michael Kelley <mhklinux@outlook.com>,
	"Peter Zijlstra (Intel)" <peterz@infradead.org>
Subject: Re: [patch v5 06/19] x86/cpu: Provide a sane leaf 0xb/0x1f parser
Message-ID: <20240212154347.GHZco8s27sOmg4neu-@fat_crate.local>
References: <20240117115752.863482697@linutronix.de>
 <20240117115908.674834306@linutronix.de>
 <20240130193102.GEZblOdor_bzoVhT0f@fat_crate.local>
 <87il2tlqba.ffs@tglx>
 <20240212150053.GEZcoypaBQPB1IcZGY@fat_crate.local>
 <877cj9lnyo.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <877cj9lnyo.ffs@tglx>

On Mon, Feb 12, 2024 at 04:08:31PM +0100, Thomas Gleixner wrote:
> This really makes my eyes bleed.

From: Borislav Petkov (AMD) <bp@alien8.de>
Date:   Mon Feb 12 16:41:42 2024 +0100

Documentation/maintainer-tip: Add C++ tail comments exception

Document when C++-style, tail comments should be used.

Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>

diff --git a/Documentation/process/maintainer-tip.rst b/Documentation/process/maintainer-tip.rst
index 799359231b7f..497bb39727c8 100644
--- a/Documentation/process/maintainer-tip.rst
+++ b/Documentation/process/maintainer-tip.rst
@@ -480,7 +480,7 @@ Multi-line comments::
 	 * Larger multi-line comments should be split into paragraphs.
 	 */
 
-No tail comments:
+No tail comments (see below):
 
   Please refrain from using tail comments. Tail comments disturb the
   reading flow in almost all contexts, but especially in code::
@@ -501,6 +501,34 @@ No tail comments:
 	/* This magic initialization needs a comment. Maybe not? */
 	seed = MAGIC_CONSTANT;
 
+  Use C++ style, tail comments when documenting structs in headers to
+  achieve a more compact layout and better readability::
+
+        // eax
+        u32     x2apic_shift    :  5, // Number of bits to shift APIC ID right
+                                      // for the topology ID at the next level
+                                : 27; // Reserved
+        // ebx
+        u32     num_processors  : 16, // Number of processors at current level
+                                : 16; // Reserved
+
+  versus::
+
+	/* eax */
+	        /*
+	         * Number of bits to shift APIC ID right for the topology ID
+	         * at the next level
+	         */
+         u32     x2apic_shift    :  5,
+		 /* Reserved */
+				 : 27;
+
+	/* ebx */
+		/* Number of processors at current level */
+	u32     num_processors  : 16,
+		/* Reserved */
+				: 16;
+
 Comment the important things:
 
   Comments should be added where the operation is not obvious. Documenting



-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

