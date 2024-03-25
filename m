Return-Path: <linux-kernel+bounces-117157-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AA71888A7F9
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 17:00:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D8E0B1C618FE
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 16:00:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F075956757;
	Mon, 25 Mar 2024 13:39:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b="s+9yOuex"
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17ED91E48B;
	Mon, 25 Mar 2024 13:39:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.96.170.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711373997; cv=none; b=DBlhpLRPO+tfr3IFqi53YU3D+HL0nKiO5RRvXDW3VehN3aMrKrdVr/DCugbG2ddl/NViHJTZ/wsObFeULHqsUJdvpzT2uljMJvU+B4dTJdbd++Tp3INaXQX/ChTKic8GNI4pQc5QmzQ2f8/rhl42+xlz6ObnLAyIM8iWWVMWENI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711373997; c=relaxed/simple;
	bh=GGkkPKJZOQgHady8Q8BsE8Bd6pcJ/SxDxnNj+XHeUGI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PBJcRpelckrGRQ+XL2FSbZphUBbZEEgDJ1cjmsJ4fX3sKZqIa8CIX7FQqRrHrXr4gV4DJnH1/3sEZR0mQUpQVA/F9t2Y+njrsnFkfI/7M0h2WlLpE6JJaJBPH1FphPWOzH10529w/CxOU02b8Lsg/P172zKr1tLRszDfuuv5yoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net; spf=pass smtp.mailfrom=rjwysocki.net; dkim=fail (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b=s+9yOuex reason="signature verification failed"; arc=none smtp.client-ip=79.96.170.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 5.4.0)
 id 512e0bec2d2c89bd; Mon, 25 Mar 2024 14:39:52 +0100
Received: from kreacher.localnet (unknown [195.136.19.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id 6950B66BCC7;
	Mon, 25 Mar 2024 14:39:52 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rjwysocki.net;
	s=dkim; t=1711373992;
	bh=GGkkPKJZOQgHady8Q8BsE8Bd6pcJ/SxDxnNj+XHeUGI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=s+9yOuexQPBUoRaEQnGqmICEkfUjShMR6bh6xsZ2u8sJHbGCwuGnexVbhEvq2VvvQ
	 p8NtqeTRBDev97LjaXL8JGZCypAZ2hOf/SLcbk0Awy5dc2eiJn7jQTYpT5Pji2wKDV
	 7o7CpZr9Bo3naXssxJv1mQ6ywOwpJ3VeHPBSvlU/fmoWp9UB6YbNLqlSyGamxDB6sU
	 LaFOis4jFbhD38o/Qj8FBTVUAe7QF4eJULkfi7Pqp3hGb0eeXTm7IbbmRilwH2HKmH
	 8lAYFc8VDrs9tVZxDiImZfPsG2TrizcRAL0jlw2H2QVRMEjHYqFs4vaAKNqVU0/Rij
	 bC77DpClLiOVA==
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Linux PM <linux-pm@vger.kernel.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
 Stanislaw Gruszka <stanislaw.gruszka@linux.intel.com>,
 Lukasz Luba <lukasz.luba@arm.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Subject:
 Re: [PATCH v2 0/3] thermal: More separation between the core and drivers
Date: Mon, 25 Mar 2024 14:39:51 +0100
Message-ID: <2273843.iZASKD2KPV@kreacher>
In-Reply-To: <42ffcfb8-33fd-4ea5-bfac-fa8c78cd1cd4@linaro.org>
References:
 <2331888.ElGaqSPkdT@kreacher>
 <42ffcfb8-33fd-4ea5-bfac-fa8c78cd1cd4@linaro.org>
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
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvledruddutddgfedtucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecujffqoffgrffnpdggtffipffknecuuegrihhlohhuthemucduhedtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufffkfgjfhgggfgtsehtufertddttdejnecuhfhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqnecuggftrfgrthhtvghrnhepfeduudeutdeugfelffduieegiedtueefledvjeegffdttefhhffhtefhleejgfetnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucfkphepudelhedrudefiedrudelrdelgeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeduleehrddufeeirdduledrleegpdhhvghlohepkhhrvggrtghhvghrrdhlohgtrghlnhgvthdpmhgrihhlfhhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqpdhnsggprhgtphhtthhopeejpdhrtghpthhtoheplhhinhhugidqphhmsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepuggrnhhivghlrdhlvgiitggrnhhosehlihhnrghrohdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehsrhhinhhivhgrshdrphgr
 nhgurhhuvhgruggrsehlihhnuhigrdhinhhtvghlrdgtohhmpdhrtghpthhtohepshhtrghnihhslhgrfidrghhruhhsiihkrgeslhhinhhugidrihhnthgvlhdrtghomhdprhgtphhtthhopehluhhkrghsiidrlhhusggrsegrrhhmrdgtohhm
X-DCC--Metrics: v370.home.net.pl 1024; Body=7 Fuz1=7 Fuz2=7

Hi Daniel,

On Monday, March 25, 2024 2:33:27 PM CET Daniel Lezcano wrote:
> 
> Hi Rafael,
> 
> thank you for this series.
> 
> It has been reported a regression with commit cf3986f8c01d3. I'm 
> investigating and confirming it. If it is the case a revert may impact 
> this series.

Sure.

Can you please give me a pointer to a BZ or e-mail thread where this is
being handled?

Thank you!


> 
> On 25/03/2024 14:10, Rafael J. Wysocki wrote:
> > Hi Everyone,
> > 
> > This is an update of
> > 
> > https://lore.kernel.org/linux-pm/4558384.LvFx2qVVIh@kreacher/
> > 
> > which is a resend of the series with one extra patch added.  That extra patch
> > is related to
> > 
> > https://lore.kernel.org/linux-pm/20240306085428.88011-1-daniel.lezcano@linaro.org/
> > 
> > The original description of the first two patches still applies:
> > 
> >> Patch [1/2] is based on the observation that the threshold field in struct
> >> thermal_trip really should be core-internal and to make that happen it
> >> introduces a wrapper structure around struct thermal_trip for internal
> >> use in the core.
> >>
> >> Patch [2/2] moves the definition of the new structure and the struct
> >> thermal_zone_device one to a local header file in the core to enforce
> >> more separation between the core and drivers.
> >>
> >> The patches are not expected to introduce any observable differences in
> >> behavior, so please let me know if you see any of that.
> > 
> 
> 





