Return-Path: <linux-kernel+bounces-158653-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 17F578B2379
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 16:06:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8A63E1F2509D
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 14:06:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33BD7149E0B;
	Thu, 25 Apr 2024 14:05:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b="LfmvS7J3"
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B89D149DEA;
	Thu, 25 Apr 2024 14:05:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.96.170.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714053952; cv=none; b=mkv0Mv0lSSX5sS674Evg7V1IGs/trTa5GXxLOKlelhsC47ce+bAqt9kOrji0N2S5de89cswIzbZKHV1zdUfXfawyvH7IKw5U2sIYF96W5Qd6rWccTzkPePFtfC7TiTAfb3t+6G1l849AgHsT+qNzze822lMGvgMQITVdt3y6jtQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714053952; c=relaxed/simple;
	bh=E81St3CiFeG7Vi2+eI0dzlqZd/MtmDsJUUDYL/ndgOo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DYaWqQBd47YBUnOl/JEbxXkuwK42/NXPBTghJ+bwjjKgzPaCnhSpFMfCVITTNzzJNQRSxXMBRjIM5j97io+4R+mN2T4uz9yZPGqkjyg6jMWlM+47J3cvVr9RL++rTuORBX2ZP+JvmX5XTc0aCRn4xrCmSt/NJ44VKPndz/2xqGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net; spf=pass smtp.mailfrom=rjwysocki.net; dkim=fail (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b=LfmvS7J3 reason="signature verification failed"; arc=none smtp.client-ip=79.96.170.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 6.0.0)
 id d6c488403c6a301b; Thu, 25 Apr 2024 16:05:48 +0200
Received: from kreacher.localnet (unknown [195.136.19.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id E1B3266DF23;
	Thu, 25 Apr 2024 16:05:47 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rjwysocki.net;
	s=dkim; t=1714053948;
	bh=E81St3CiFeG7Vi2+eI0dzlqZd/MtmDsJUUDYL/ndgOo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=LfmvS7J3ZqZG7nQk1LvGq5L+R2wzmbbHiJUshHya/d2okV3J1POEzdKNFQ+sRmPMU
	 L7RzY7xjfkdD6geBy+ztyN/pdOje1z1nPQBmCQvrHi/DZFIiH/QNbBWfI1zQ9XOPwh
	 YL1vevwEm9NoRfo3CfhgBQ32T5CRAoCROul/kbowQgKg3mTHtCwfCQjTTF4g3tLjk0
	 mMD2e0sHYgLNstFrngvuZnWQsG074SJiyc0h/QVw25ed7wH/xcMTK++PQWp9BhmL7u
	 F1Dfx5LoWHnJtqkO1Mtmt3VhXoHVZpQGIxl5g13Tnqy6KycCk8GJtiQskEAJmV1FhT
	 DD0oTOt+Eoidg==
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Lukasz Luba <lukasz.luba@arm.com>,
 Daniel Lezcano <daniel.lezcano@linaro.org>
Subject:
 [PATCH v2 3/3] thermal/debugfs: Avoid printing zero duration for mitigation
 events in progress
Date: Thu, 25 Apr 2024 16:05:38 +0200
Message-ID: <7659098.EvYhyI6sBW@kreacher>
In-Reply-To: <3297002.44csPzL39Z@kreacher>
References: <3297002.44csPzL39Z@kreacher>
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
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvledrudeljedgjedvucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecujffqoffgrffnpdggtffipffknecuuegrihhlohhuthemucduhedtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufffkfgjfhgggfgtsehtqhertddttdejnecuhfhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqnecuggftrfgrthhtvghrnheptddvfeegledvfedvveevhedvteeffeehvdeuiedukeeiledttefgvdeihffgteetnecukfhppeduleehrddufeeirdduledrleegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepudelhedrudefiedrudelrdelgedphhgvlhhopehkrhgvrggthhgvrhdrlhhotggrlhhnvghtpdhmrghilhhfrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqedpnhgspghrtghpthhtohephedprhgtphhtthhopehlihhnuhigqdhpmhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehrrghfrggvlheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhukhgrshiirdhluhgsrgesrghrmhdrtghomhdprhgtphhtthhopegurghnihgvlhdrlhgviigt
 rghnoheslhhinhgrrhhordhorhhg
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
@@ -552,6 +552,7 @@ static struct tz_episode *thermal_debugf
=20
 	INIT_LIST_HEAD(&tze->node);
 	tze->timestamp =3D now;
+	tze->duration =3D KTIME_MIN;
=20
 	for (i =3D 0; i < tz->num_trips; i++) {
 		tze->trip_stats[i].min =3D INT_MAX;
@@ -680,6 +681,9 @@ void thermal_debug_tz_trip_down(struct t
 	tze->trip_stats[trip_id].duration =3D
 		ktime_add(delta, tze->trip_stats[trip_id].duration);
=20
+	/* Mark the end of mitigation for this trip point. */
+	tze->trip_stats[trip_id].timestamp =3D KTIME_MAX;
+
 	/*
 	 * This event closes the mitigation as we are crossing the
 	 * last trip point the way down.
@@ -754,15 +758,25 @@ static int tze_seq_show(struct seq_file
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
@@ -794,12 +808,25 @@ static int tze_seq_show(struct seq_file
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




