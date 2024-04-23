Return-Path: <linux-kernel+bounces-155776-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E64F8AF6FD
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 21:03:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A2D5C1C22607
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 19:03:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E1DE1411DF;
	Tue, 23 Apr 2024 19:03:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b="RgqrazB8"
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EB0E13FD8C;
	Tue, 23 Apr 2024 19:03:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.96.170.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713899001; cv=none; b=aGpO1JUjM2W6uiEw0x1z4wymy1Kr0IguOEVRkyRWfBeexrZHG13IjlwQsMO00FkcZajA4ESZV7gL7xpu55Hj6uZkZ43IUc7kTLPr2lEsA68lVV0N6v13LzVLXjIYZrYkBIOgwF/VnwgJfgNOvrT1veU3E1UOn8Oen+11K8TWmhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713899001; c=relaxed/simple;
	bh=Bv3kllpQAlF6/y8cUblx2UV+ugsq2CFF5/mk5tDG3sM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FqOK3+KHK3OqTvGcbv+CpaRc8uHPbIyNlKZuzs7aNq1T2JcJejFZZWq691CBHwLjmj/9s5WNFfwAGgB3dZ8wyH67iUrGTRQkNpQ/zja9arb2EGcLAZ3Nb8vWaY01P+Td64S09kUNX0aXoNWMtogUg13QnX6rdGISfga533t9HyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net; spf=pass smtp.mailfrom=rjwysocki.net; dkim=fail (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b=RgqrazB8 reason="signature verification failed"; arc=none smtp.client-ip=79.96.170.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 6.0.0)
 id 49a53ae6f26f328d; Tue, 23 Apr 2024 20:03:17 +0200
Received: from kreacher.localnet (unknown [195.136.19.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id 14FA466DB86;
	Tue, 23 Apr 2024 20:03:17 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rjwysocki.net;
	s=dkim; t=1713895397;
	bh=Bv3kllpQAlF6/y8cUblx2UV+ugsq2CFF5/mk5tDG3sM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=RgqrazB8H4YffU3uZ1a/E7XDvYFy3CfPZIdF9BDc6LBUtY2N+n1NBvSLafrDD74Uz
	 xTHmrcUAytZhLBf+ulCBNNYMR32U2PKF16iZ3iv06d6JuwQ8G1Wm4WfliLfOoralHn
	 mijTmEaxYlIc3wDLc1PCvBRFcabgpy4ZppPFQPa3F7K9Z67mFMdqm3xuiT4uJgxZaw
	 P9/DnehWPuVCJqwnGvftwNFNwgeBA6R860CdIMhn4UNthN0o9UwNy6OZiKlLh6CJFu
	 LN2ft37U+8ji6XIbfDfilq7nnxl9E5fVAPR63WU4Ya5/3bpMlAKdbiV/hsoA/Hg+ON
	 o/KAfCJm+Z/0Q==
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Lukasz Luba <lukasz.luba@arm.com>,
 Daniel Lezcano <daniel.lezcano@linaro.org>
Subject:
 [PATCH v1 3/3] thermal/debugfs: Avoid printing zero duration for mitigation
 episodes in progress
Date: Tue, 23 Apr 2024 20:02:16 +0200
Message-ID: <2933330.e9J7NaK4W3@kreacher>
In-Reply-To: <5774279.DvuYhMxLoT@kreacher>
References: <5774279.DvuYhMxLoT@kreacher>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
X-CLIENT-IP: 195.136.19.94
X-CLIENT-HOSTNAME: 195.136.19.94
X-VADE-SPAMSTATE: clean
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvledrudeluddguddvudcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfjqffogffrnfdpggftiffpkfenuceurghilhhouhhtmecuudehtdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvvefufffkjghfggfgtgesthhqredttddtjeenucfhrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqeenucggtffrrghtthgvrhhnpedtvdefgeelvdefvdevveehvdetfeefhedvueeiudekieeltdetgfdviefhgfetteenucfkphepudelhedrudefiedrudelrdelgeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeduleehrddufeeirdduledrleegpdhhvghlohepkhhrvggrtghhvghrrdhlohgtrghlnhgvthdpmhgrihhlfhhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqpdhnsggprhgtphhtthhopeehpdhrtghpthhtoheplhhinhhugidqphhmsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprhgrfhgrvghlsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehluhhkrghsiidrlhhusggrsegrrhhmrdgtohhmpdhrtghpthhtohepuggrnhhivghlrdhlvgii
 tggrnhhosehlihhnrghrohdrohhrgh
X-DCC--Metrics: v370.home.net.pl 1024; Body=5 Fuz1=5 Fuz2=5

=46rom: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

If a thermal mitigation event is in progress, its duration value has
not been updated yet, so 0 will be printed as the event duration by
tze_seq_show() which is confusing.

Avoid doing that by marking the beginning of the event with the
KTIME_MIN duration value and making tze_seq_show() compute the current
event duration on the fly, in which case '>' will be printed instead of
'=3D' in the event duration value field.

Similarly, for trip points that have been crossed on the down, mark
the end of mitigation with the KTIME_MAX timestamp value and make
tze_seq_show() compute the current duration on the fly for the trip
points still involved in the mitigation, in which cases the duration
value printed by it will be prepended with a '>' character.

=46ixes: 7ef01f228c9f ("thermal/debugfs: Add thermal debugfs information fo=
r mitigation episodes")
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
=2D--
 drivers/thermal/thermal_debugfs.c |   39 ++++++++++++++++++++++++++++++++-=
=2D----
 1 file changed, 33 insertions(+), 6 deletions(-)

Index: linux-pm/drivers/thermal/thermal_debugfs.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=2D-- linux-pm.orig/drivers/thermal/thermal_debugfs.c
+++ linux-pm/drivers/thermal/thermal_debugfs.c
@@ -530,6 +530,7 @@ static struct tz_episode *thermal_debugf
=20
 	INIT_LIST_HEAD(&tze->node);
 	tze->timestamp =3D now;
+	tze->duration =3D KTIME_MIN;
=20
 	for (i =3D 0; i < tz->num_trips; i++) {
 		tze->trip_stats[i].min =3D INT_MAX;
@@ -665,6 +666,9 @@ void thermal_debug_tz_trip_down(struct t
 	tze->trip_stats[trip_id].duration =3D
 		ktime_add(delta, tze->trip_stats[trip_id].duration);
=20
+	/* Mark the end of mitigation for this trip point. */
+	tze->trip_stats[trip_id].timestamp =3D KTIME_MAX;
+
 	/*
 	 * This event closes the mitigation as we are crossing the
 	 * last trip point the way down.
@@ -742,15 +746,25 @@ static int tze_seq_show(struct seq_file
 	struct thermal_trip_desc *td;
 	struct tz_episode *tze;
 	const char *type;
+	u64 duration_ms;
 	int trip_id;
+	char c;
=20
 	tze =3D list_entry((struct list_head *)v, struct tz_episode, node);
=20
=2D	seq_printf(s, ",-Mitigation at %lluus, duration=3D%llums\n",
=2D		   ktime_to_us(tze->timestamp),
=2D		   ktime_to_ms(tze->duration));
+	if (tze->duration =3D=3D KTIME_MIN) {
+		/* Mitigation in progress. */
+		duration_ms =3D ktime_to_ms(ktime_sub(ktime_get(), tze->timestamp));
+		c =3D '>';
+	} else {
+		duration_ms =3D ktime_to_ms(tze->duration);
+		c =3D '=3D';
+	}
+
+	seq_printf(s, ",-Mitigation at %lluus, duration%c%llums\n",
+		   ktime_to_us(tze->timestamp), c, duration_ms);
=20
=2D	seq_printf(s, "| trip |     type | temp(=C2=B0mC) | hyst(=C2=B0mC) |  d=
uration  |  avg(=C2=B0mC) |  min(=C2=B0mC) |  max(=C2=B0mC) |\n");
+	seq_printf(s, "| trip |     type | temp(=C2=B0mC) | hyst(=C2=B0mC) |  dur=
ation   |  avg(=C2=B0mC) |  min(=C2=B0mC) |  max(=C2=B0mC) |\n");
=20
 	for_each_trip_desc(tz, td) {
 		const struct thermal_trip *trip =3D &td->trip;
@@ -782,12 +796,25 @@ static int tze_seq_show(struct seq_file
 		else
 			type =3D "hot";
=20
=2D		seq_printf(s, "| %*d | %*s | %*d | %*d | %*lld | %*d | %*d | %*d |\n",
+		if (trip_stats->timestamp !=3D KTIME_MAX) {
+			/* Mitigation in progress. */
+			ktime_t delta =3D ktime_sub(ktime_get(),
+						  trip_stats->timestamp);
+
+			delta =3D ktime_add(delta, trip_stats->duration);
+			duration_ms =3D ktime_to_ms(delta);
+			c =3D '>';
+		} else {
+			duration_ms =3D ktime_to_ms(trip_stats->duration);
+			c =3D ' ';
+		}
+
+		seq_printf(s, "| %*d | %*s | %*d | %*d | %c%*lld | %*d | %*d | %*d |\n",
 			   4 , trip_id,
 			   8, type,
 			   9, trip->temperature,
 			   9, trip->hysteresis,
=2D			   10, ktime_to_ms(trip_stats->duration),
+			   c, 10, duration_ms,
 			   9, trip_stats->avg,
 			   9, trip_stats->min,
 			   9, trip_stats->max);




