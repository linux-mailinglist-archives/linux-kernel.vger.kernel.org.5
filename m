Return-Path: <linux-kernel+bounces-110598-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 63CF188611B
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 20:35:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0180E1F227C1
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 19:35:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 551BA135A57;
	Thu, 21 Mar 2024 19:34:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b="yOHiMWbG"
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B167134CF8;
	Thu, 21 Mar 2024 19:34:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.96.170.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711049668; cv=none; b=EMl5ZzFV0ge2tumEu1L93QF0DUcJRSCB8jqqxJakQ6hNx9Yc5Jacnr5SjQthe8VabP0idBPms4vaARLCzdoIQo1uKQ2CQWbhHSUkz/3dFcZEv9r85nCoOFRFC9FJZCRABLiUX/0CEqjlihPaIugwJlqKNRv3kKz7NxvpiVHA8mk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711049668; c=relaxed/simple;
	bh=dajy9VeGkzIBNNyZuqE7nHLnEax7VwLxo6Ui7Z7eK+4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gSC2PjfYwvGDW39uWx4bKrn+6DqOQ/b+hAyMu0OdCISX407BT+KaVTjB1zzap39d2bvUtNmL0AmxloxbuaserR0hCJWXcrNVMV8Q45C8q4JCEk4GURmA5cHk8sZbdPkRDgKEeEdTBW969ICeIch+Acs9mYh7+6PXjPokWf0c4pg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net; spf=pass smtp.mailfrom=rjwysocki.net; dkim=fail (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b=yOHiMWbG reason="signature verification failed"; arc=none smtp.client-ip=79.96.170.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 5.4.0)
 id 41bccc16fb59eeda; Thu, 21 Mar 2024 20:34:17 +0100
Received: from kreacher.localnet (unknown [195.136.19.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id 502CD66B8D7;
	Thu, 21 Mar 2024 20:34:17 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rjwysocki.net;
	s=dkim; t=1711049657;
	bh=dajy9VeGkzIBNNyZuqE7nHLnEax7VwLxo6Ui7Z7eK+4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=yOHiMWbGEeOTcyRRar3EgXhJGZekiFI9WlePT0N7/1twJWhiwfoMTDA98XBzF6LJv
	 nxhgy2toePTdywnux0iyTCwzo8DNw1AnmSSbe4uuyBUzbS+9tveFrUsSd2RI0adUZ6
	 OBBwg4+JYmq6K2+oHTOaoT86Ku24nQugypASB6ShZN/RwmTOMFJeg/w3OJseNm6vGp
	 D12W/UCNK3O/Ph7u5p5XX0tQC/ZfgWdmoFCIgBNEG7rrZ0paNdfmkTCzQbzr6h/5VN
	 QrH3dVlPA5nhAmKk2N0vL/B5pO62SopkRT+ofavZvktUwwezxylzRs6aIecjxNQw6C
	 AfnTk78t9mwmg==
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject:
 [PATCH v1 1/5] cpufreq: intel_pstate: Drop redundant locking from
 intel_pstate_driver_cleanup()
Date: Thu, 21 Mar 2024 20:29:43 +0100
Message-ID: <6035571.lOV4Wx5bFT@kreacher>
In-Reply-To: <12409658.O9o76ZdvQC@kreacher>
References: <12409658.O9o76ZdvQC@kreacher>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"
X-CLIENT-IP: 195.136.19.94
X-CLIENT-HOSTNAME: 195.136.19.94
X-VADE-SPAMSTATE: clean
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvledrleejgdeihecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfjqffogffrnfdpggftiffpkfenuceurghilhhouhhtmecuudehtdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvvefufffkjghfggfgtgesthfuredttddtjeenucfhrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqeenucggtffrrghtthgvrhhnpedvffeuiedtgfdvtddugeeujedtffetteegfeekffdvfedttddtuefhgeefvdejhfenucfkphepudelhedrudefiedrudelrdelgeenucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhepihhnvghtpeduleehrddufeeirdduledrleegpdhhvghlohepkhhrvggrtghhvghrrdhlohgtrghlnhgvthdpmhgrihhlfhhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqpdhnsggprhgtphhtthhopeefpdhrtghpthhtoheplhhinhhugidqphhmsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepshhrihhnihhvrghsrdhprghnughruhhvrggurgeslhhinhhugidrihhnthgvlhdrtghomh
X-DCC--Metrics: v370.home.net.pl 1024; Body=3 Fuz1=3 Fuz2=3

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Remove the spinlock locking from intel_pstate_driver_cleanup() as it is
not necessary because no other code accessing all_cpu_data[] can run in
parallel with that function.

Had the locking been necessary, though, it would have been incorrect
because the lock in question is acquired from a hardirq handler and
it cannot be acquired from thread context without disabling interrupts.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/cpufreq/intel_pstate.c |    2 --
 1 file changed, 2 deletions(-)

Index: linux-pm/drivers/cpufreq/intel_pstate.c
===================================================================
--- linux-pm.orig/drivers/cpufreq/intel_pstate.c
+++ linux-pm/drivers/cpufreq/intel_pstate.c
@@ -3135,10 +3135,8 @@ static void intel_pstate_driver_cleanup(
 			if (intel_pstate_driver == &intel_pstate)
 				intel_pstate_clear_update_util_hook(cpu);
 
-			spin_lock(&hwp_notify_lock);
 			kfree(all_cpu_data[cpu]);
 			WRITE_ONCE(all_cpu_data[cpu], NULL);
-			spin_unlock(&hwp_notify_lock);
 		}
 	}
 	cpus_read_unlock();




