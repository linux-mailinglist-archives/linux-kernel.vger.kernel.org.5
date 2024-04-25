Return-Path: <linux-kernel+bounces-159059-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BA99A8B28C1
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 21:06:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 013CBB245D6
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 19:06:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F26D115252B;
	Thu, 25 Apr 2024 19:06:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b="CmOp+Lqg"
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C32D1509B1;
	Thu, 25 Apr 2024 19:06:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.96.170.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714071985; cv=none; b=KzQELSMhSBTMZ49hgMLmg9hUTYKyoyj/vfkf1aN7thNYOuKK6SJF0xTIA/x5OerIJ3ZrWXr6HpIpaoKFVOWB8OsQRScA3ZUal6b0xMBoQiXake0oA8fxXD6xfSYAE+p1YprzoJn/aSo0Io/LESrUIWtslliWvLX/aQ2kdV5zkbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714071985; c=relaxed/simple;
	bh=2Sb71T+xYEBOgO6OWGpiIk60zH773QV7/5n9WrUs7/s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=kTsZAprh/7eZ/PMu0rGjtpxteX52cITcWa5sBUmOUkRkQdzgXbEzTuQHXJG1t/jDRtUb/7lTl0uwULVGiDaZ+7sYOhiVaUfMj/goi/NvTdaV44EA2MbFSy+krbQq3amZfqABp4Dj6QA0cjkJSkt+ElhNJsUucu2RJ1+GSWzsXc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net; spf=pass smtp.mailfrom=rjwysocki.net; dkim=fail (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b=CmOp+Lqg reason="signature verification failed"; arc=none smtp.client-ip=79.96.170.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 6.0.0)
 id 521fcd625bb25de9; Thu, 25 Apr 2024 21:06:21 +0200
Received: from kreacher.localnet (unknown [195.136.19.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id A7BE766DF24;
	Thu, 25 Apr 2024 21:06:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rjwysocki.net;
	s=dkim; t=1714071981;
	bh=2Sb71T+xYEBOgO6OWGpiIk60zH773QV7/5n9WrUs7/s=;
	h=From:To:Cc:Subject:Date;
	b=CmOp+LqgZo0qzXZJpaY0bkJjuuztK1RHKCi5MNNbQKaraU13J63gUf+6RjbcAYsC0
	 mzqPBBRDqMZbJKv/nUaXBH7tJbZO2L741U8sGHM4FXuJlBEl7wEeRwk16bYz4VfvF5
	 /1UFY78DNBQ5neNOjPU7Ubmw8o9kNbY8GEuVe38RIycThkEAJw5W2t5DHMJI5GomV3
	 xDS7HLfVrENzwA7+6mOUz1ne9bKy8B3GELgeSigF/bxj5hfoRetW12iJvJptE8/kOv
	 u9WAqEajEAhLX0oQxWUwhpdG1NfAUBV50wQ97zPXk+GvuOLCfB08fQ735g+8ukS8xA
	 TQCnSVzcsdImQ==
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: x86 Maintainers <x86@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>, Peter Zijlstra <peterz@infradead.org>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Ricardo Neri <ricardo.neri@intel.com>, Tim Chen <tim.c.chen@intel.com>
Subject:
 [RFC][PATCH v1 0/3] x86 / intel_pstate: Set asymmetric CPU capacity on hybrid
 systems
Date: Thu, 25 Apr 2024 21:03:03 +0200
Message-ID: <7663799.EvYhyI6sBW@kreacher>
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
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvledrudeljedgudefgecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfjqffogffrnfdpggftiffpkfenuceurghilhhouhhtmecuudehtdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvvefufffkggfgtgesthfuredttddtjeenucfhrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqeenucggtffrrghtthgvrhhnpeffffffkefgheehffelteeiveeffeevhfelteejvddvieejjeelvdeiheeuveeuffenucfkphepudelhedrudefiedrudelrdelgeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeduleehrddufeeirdduledrleegpdhhvghlohepkhhrvggrtghhvghrrdhlohgtrghlnhgvthdpmhgrihhlfhhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqpdhnsggprhgtphhtthhopedutddprhgtphhtthhopeigkeeisehkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhpmhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehtghhlgieslhhinhhuthhrohhnihigrdguvgdprhgtphhtthhopehpvghtvghriiesihhnfhhrrgguvggr
 ugdrohhrghdprhgtphhtthhopehsrhhinhhivhgrshdrphgrnhgurhhuvhgruggrsehlihhnuhigrdhinhhtvghlrdgtohhm
X-DCC--Metrics: v370.home.net.pl 1024; Body=10 Fuz1=10 Fuz2=10

Hi Everyone,

The purpose of this series is to provide the scheduler with asymmetric CPU
capacity information on x86 hybrid systems based on Intel hardware.

The asymmetric CPU capacity information is important on hybrid systems as it
allows utilization to be computed for tasks in a consistent way across all
CPUs in the system, regardless of their capacity.  This, in turn, allows
the schedutil cpufreq governor to set CPU performance levels consistently
in the cases when tasks migrate between CPUs of different capacities.  It
should also help to improve task placement and load balancing decisions on
hybrid systems and it is key for anything along the lines of EAS.

The information in question comes from the MSR_HWP_CAPABILITIES register and
is provided to the scheduler by the intel_pstate driver, as per the changelog
of patch [3/3].  Patch [2/3] introduces the arch infrastructure needed for
that (in the form of a per-CPU capacity variable) and patch [1/3] is a
preliminary code adjustment.

The changes made by patch [2/3] are very simple, which is why this series is
being sent as an RFC.  Namely, it increases overhead on non-hybrid as well as
on hybrid systems which may be regarded as objectionable, even though the
overhead increase is arguably not significant.  The memory overhead is an
unsigned long variable per CPU which is not a lot IMV and there is also
additional memory access overhead at each arch_scale_cpu_capacity() call site
which I'm not expecting to be noticeable, however.  In any case, the extra
overhead can be avoided at the cost of making the code a bit more complex
(for example, the additional per-CPU memory can be allocated dynamically
on hybrid systems only and a static branch can be used for enabling access
to it when necessary).  I'm just not sure if the extra complexity is really
worth it, so I'd like to know the x86 maintainers' take on this.  If you'd
prefer the overhead to be avoided, please let me know.

Of course, any other feedback on the patches is welcome as well.

Thank you!




