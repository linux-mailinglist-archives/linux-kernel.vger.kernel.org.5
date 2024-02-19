Return-Path: <linux-kernel+bounces-71564-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 82A8885A71E
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 16:13:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3F5A9281A96
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 15:13:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23ADB381C4;
	Mon, 19 Feb 2024 15:13:19 +0000 (UTC)
Received: from mail-out.aladdin-rd.ru (mail-out.aladdin-rd.ru [91.199.251.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 104EF1EA71
	for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 15:13:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.199.251.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708355598; cv=none; b=DMNzdctjgNHWIdDtOzynbI/H7h2dmRImU5RYZ2v8HZlx6T2oyvbkJYdDLGBfbWa3Nuh31NvbefBhVsMirodd/JUWrbacyM1lughBB04NTVgByryhfFMn3Aro5SqFZB7Sv0uAJEyqk81+oedeDakIH1yHxmajHmMGkR+mHHRQs88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708355598; c=relaxed/simple;
	bh=TVSESAyFaGTL23/oyX3q2EZFs2U2rQaW2gTJ4oRS36A=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=VkBhj9+ctzH0a3ngOhF+ulGujE2kG41EzAoy8tgFhRIVRtPb7x8zrhjafn6jNqbiQgIeG2F7VS0k+0YB4fmROVs8RA4vXgcviHzZZPPnrtpoTN63tQ27J1j0OP5YuTZ7AXzlwY2FiQyPl8LCVBcRWenkvOxDtwDAUClYoZTmdqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=aladdin.ru; spf=pass smtp.mailfrom=aladdin.ru; arc=none smtp.client-ip=91.199.251.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=aladdin.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aladdin.ru
From: Daniil Dulov <D.Dulov@aladdin.ru>
To: David Howells <dhowells@redhat.com>
CC: Jeffrey E Altman <jaltman@auristor.com>, "linux-afs@lists.infradead.org"
	<linux-afs@lists.infradead.org>, Marc Dionne <marc.dionne@auristor.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"lvc-project@linuxtesting.org" <lvc-project@linuxtesting.org>
Subject: RE: [PATCH v2] afs: Increase buffer size in
 afs_update_volume_status()
Thread-Topic: [PATCH v2] afs: Increase buffer size in
 afs_update_volume_status()
Thread-Index: AQHaXY42ktMjs5Z/0kKi/kDcfp2GrLERUMYAgABCobA=
Date: Mon, 19 Feb 2024 15:07:59 +0000
Message-ID: <208066d6326a428499fa68c5984da62c@aladdin.ru>
References: <20240212083347.10742-1-d.dulov@aladdin.ru>
 <125563.1708338814@warthog.procyon.org.uk>
In-Reply-To: <125563.1708338814@warthog.procyon.org.uk>
Accept-Language: ru-RU, en-US
Content-Language: ru-RU
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hello!

Thank you for your feedback. I agree with the suggested improvement. I will=
 send v3 a bit later today.

-----Original Message-----
From: David Howells [mailto:dhowells@redhat.com]=20
Sent: Monday, February 19, 2024 1:34 PM
To: Daniil Dulov <D.Dulov@aladdin.ru>
Cc: dhowells@redhat.com; Jeffrey E Altman <jaltman@auristor.com>; linux-afs=
@lists.infradead.org; Marc Dionne <marc.dionne@auristor.com>; linux-kernel@=
vger.kernel.org; lvc-project@linuxtesting.org
Subject: Re: [PATCH v2] afs: Increase buffer size in afs_update_volume_stat=
us()

I suggest the attached instead.

David
---
diff --git a/fs/afs/volume.c b/fs/afs/volume.c index 020ecd45e476..af3a3f57=
c1b3 100644
--- a/fs/afs/volume.c
+++ b/fs/afs/volume.c
@@ -353,7 +353,7 @@ static int afs_update_volume_status(struct afs_volume *=
volume, struct key *key)  {
 	struct afs_server_list *new, *old, *discard;
 	struct afs_vldb_entry *vldb;
-	char idbuf[16];
+	char idbuf[24];
 	int ret, idsz;
=20
 	_enter("");
@@ -361,7 +361,7 @@ static int afs_update_volume_status(struct afs_volume *=
volume, struct key *key)
 	/* We look up an ID by passing it as a decimal string in the
 	 * operation's name parameter.
 	 */
-	idsz =3D sprintf(idbuf, "%llu", volume->vid);
+	idsz =3D snprintf(idbuf, sizeof(idbuf), "%llu", volume->vid);
=20
 	vldb =3D afs_vl_lookup_vldb(volume->cell, key, idbuf, idsz);
 	if (IS_ERR(vldb)) {


