Return-Path: <linux-kernel+bounces-91823-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DFE82871723
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 08:41:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6CA8A1F225DF
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 07:41:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E50CE7E786;
	Tue,  5 Mar 2024 07:41:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FxkU50Lg"
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DA057E59A;
	Tue,  5 Mar 2024 07:41:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709624490; cv=none; b=kIv/MOLEwvxbcrMFRa64weB4575EBGOxGpIjEFcJ/5tgn31ij8+mmGIhrbaGds4QCJtYfeduIEEqzlOuBdfLv4/R9ZXOArqZ7WUOpDWVgTXLlwg/NGXC/APKfd9pkV/v+96XYzO//zfR1U/uIS5Rtea3/SzftNKjahexA46hpUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709624490; c=relaxed/simple;
	bh=fHKIBMJO6+04Qzr1rbAIqhpOdxcrJuDSSuqFtTdx4t8=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=iSUnR1x2xnFsfP2WFN9JP8S+NV6caeEpaV8MRk1y0qTJEBO7hQVQuINMBEu9zLNCb5zAxwg/x4RGVQCm3rk8YqmqECxmW//v5kGW3wqHHwnF1nC3l1i/mGaSl1VJ9WCXJURHk/bMqcPD7bUw/4zTPlMxPuRt6CaHWV/uNaafaII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FxkU50Lg; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1dcafff3c50so45427645ad.0;
        Mon, 04 Mar 2024 23:41:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709624488; x=1710229288; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Rj6H16qrNOWw0BmwrUEhfXf67q1pzJuusXUTp9cqYaQ=;
        b=FxkU50LghjoOFkp6opbDrtatZe4SLvw6tgP/NSC3bGgzGXP3gjPZZDPKb68HOhDqyn
         4Nv06PdDB0Q5Q5UBw8N27WcZXYYeTAfpGROiVcB0sudWrv0wx/1enxVIutjry7Ncxpwq
         P+tHzBmo37QuD5L//M3PTzApAVoISDCwy89w4lMMXik8UQidoRdP/DKyqKbnr/pC4QL2
         YwNRJCUGt9MWQS494/PVAKa1tUTqNESBYpH3Yuuf0Nw8CDn8biPMySslgil5KhBt0Qxv
         5Gi5CJQ2XN0MMPh+sZ41wOTAUgWanQuT8U61UXnfKodAA0eeVy2znitjcB9zbKGB+ZIb
         qy0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709624488; x=1710229288;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Rj6H16qrNOWw0BmwrUEhfXf67q1pzJuusXUTp9cqYaQ=;
        b=czdkSV1Cr+sNBo67XuYh3rSFqj0VJL+o/VeOGksaEuqbKZeu4jFAZz97IUrevfBMT+
         dJxklvmcO+oSETpnDqqnDf4sjQ9STI6MTYWupV9N0wjQuqZkrkKhJHNrzFFvG48Qp5QA
         e6TRRNhVs7+mw9RJjmgfM5l3HKJlGPNYFfRqpzGMBnhYZuutpjpZe2w/xeMm5pzirMEa
         nTxfvVE6df9wuLE/c1Z3jZttB8v88zD190WF9PlYQoq3pyWybgy+mcm1GUa4SJOi2UcB
         Pg0NgHFid+FNcmH+Ou4c2637SOUeJapijtRaiBlgUShyJKZsKlcq/bLYLaIyZAEMZ1/o
         VavA==
X-Forwarded-Encrypted: i=1; AJvYcCVQJGjhK40byzN+N+PdNXGcQvkGmKWUeeI5QvDhcsb6zZ24zdNPWuZ56l0usrQk/eXqPTM8k9kdHrXwvM8j/auFMiRaBzazh4a8GPGf
X-Gm-Message-State: AOJu0Yzqf1otsVw9T7Fm1fafGSuTYCqLXNblqINjbzpiTBHrFQzaGocQ
	26hBwlXf18ecDJtlkYgc/rt+LweLTw8tIcbfZvyfIo0epr5mOpj2CwvZSSch
X-Google-Smtp-Source: AGHT+IEewqxAegsU0vq7eh5l5+spdyVUh5uaeeigpkLQhYbcbsLwkxfUywTOiTl31QEpyiMcfh8uIg==
X-Received: by 2002:a17:902:7806:b0:1dc:5d2e:c18c with SMTP id p6-20020a170902780600b001dc5d2ec18cmr1129291pll.67.1709624487707;
        Mon, 04 Mar 2024 23:41:27 -0800 (PST)
Received: from ?IPv6:::1? ([2601:647:5e00:4acd:9509:3d92:c4ae:bb92])
        by smtp.gmail.com with ESMTPSA id mm6-20020a1709030a0600b001db67377e8dsm9787009plb.248.2024.03.04.23.41.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Mar 2024 23:41:27 -0800 (PST)
Date: Mon, 04 Mar 2024 23:41:25 -0800
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Javier Carrasco <javier.carrasco.cruz@gmail.com>,
 Henrik Rydberg <rydberg@bitmath.org>
CC: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
 regressions@lists.linux.dev, Jacopo Radice <jacopo.radice@outlook.com>
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_v2=5D_Revert_=22Input=3A_bcm5974_-_ch?= =?US-ASCII?Q?eck_endpoint_type_before_starting_traffic=22?=
User-Agent: K-9 Mail for Android
In-Reply-To: <20240305-revert_bcm5974_ep_check-v2-1-925ae9b188d9@gmail.com>
References: <20240305-revert_bcm5974_ep_check-v2-1-925ae9b188d9@gmail.com>
Message-ID: <04E6C7D8-395C-4DB3-B331-B79215DE6B40@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

On March 4, 2024 10:38:33 PM PST, Javier Carrasco <javier=2Ecarrasco=2Ecruz=
@gmail=2Ecom> wrote:
>This patch intended to fix an well-knonw issue in old drivers where the
>endpoint type is taken for granted, which is often triggered by fuzzers=
=2E
>
>That was the case for this driver [1], and although the fix seems to be
>correct, it uncovered another issue that leads to a regression [2], if
>the endpoints of the current interface are checked=2E
>
>The driver makes use of endpoints that belong to a different interface
>rather than the one it binds (it binds to the third interface, but also
>accesses an endpoint from a different one)=2E The driver should claim the
>interfaces it requires, but that is still not the case=2E
>
>Given that the regression is more severe than the issue found by
>syzkaller, the best approach is reverting the patch that causes the
>regression, and trying to fix the underlying problem before checking
>the endpoint types again=2E
>
>Note that reverting this patch will probably trigger the syzkaller bug
>at some point=2E
>
>This reverts commit 2b9c3eb32a699acdd4784d6b93743271b4970899=2E
>
>Link: https://syzkaller=2Eappspot=2Ecom/bug?extid=3D348331f63b034f89b622 =
[1]
>Link: https://lore=2Ekernel=2Eorg/linux-input/87sf161jjc=2Ewl-tiwai@suse=
=2Ede/ [2]
>
>Fixes: b516b1b0dfcc ("Revert "Input: bcm5974 - check endpoint type before=
 starting traffic"")


This "fixes" tag looks incorrect=2E The patch fixes itself?

>Reported-by: Jacopo Radice <jacopo=2Eradice@outlook=2Ecom>
>Closes: https://bugzilla=2Esuse=2Ecom/show_bug=2Ecgi?id=3D1220030
>Signed-off-by: Javier Carrasco <javier=2Ecarrasco=2Ecruz@gmail=2Ecom>
>---
>Changes in v2:
>- Add "Reported-by", "Closes" and "Link" tags=2E
>- Use shorter lore link=2E
>- Link to v1: https://lore=2Ekernel=2Eorg/r/20240305-revert_bcm5974_ep_ch=
eck-v1-1-db4f0422588f@gmail=2Ecom
>---
> drivers/input/mouse/bcm5974=2Ec | 20 --------------------
> 1 file changed, 20 deletions(-)
>
>diff --git a/drivers/input/mouse/bcm5974=2Ec b/drivers/input/mouse/bcm597=
4=2Ec
>index 953992b458e9=2E=2Eca150618d32f 100644
>--- a/drivers/input/mouse/bcm5974=2Ec
>+++ b/drivers/input/mouse/bcm5974=2Ec
>@@ -19,7 +19,6 @@
>  * Copyright (C) 2006	   Nicolas Boichat (nicolas@boichat=2Ech)
>  */
>=20
>-#include "linux/usb=2Eh"
> #include <linux/kernel=2Eh>
> #include <linux/errno=2Eh>
> #include <linux/slab=2Eh>
>@@ -194,8 +193,6 @@ enum tp_type {
>=20
> /* list of device capability bits */
> #define HAS_INTEGRATED_BUTTON	1
>-/* maximum number of supported endpoints (currently trackpad and button)=
 */
>-#define MAX_ENDPOINTS	2
>=20
> /* trackpad finger data block size */
> #define FSIZE_TYPE1		(14 * sizeof(__le16))
>@@ -894,18 +891,6 @@ static int bcm5974_resume(struct usb_interface *ifac=
e)
> 	return error;
> }
>=20
>-static bool bcm5974_check_endpoints(struct usb_interface *iface,
>-				    const struct bcm5974_config *cfg)
>-{
>-	u8 ep_addr[MAX_ENDPOINTS + 1] =3D {0};
>-
>-	ep_addr[0] =3D cfg->tp_ep;
>-	if (cfg->tp_type =3D=3D TYPE1)
>-		ep_addr[1] =3D cfg->bt_ep;
>-
>-	return usb_check_int_endpoints(iface, ep_addr);
>-}
>-
> static int bcm5974_probe(struct usb_interface *iface,
> 			 const struct usb_device_id *id)
> {
>@@ -918,11 +903,6 @@ static int bcm5974_probe(struct usb_interface *iface=
,
> 	/* find the product index */
> 	cfg =3D bcm5974_get_config(udev);
>=20
>-	if (!bcm5974_check_endpoints(iface, cfg)) {
>-		dev_err(&iface->dev, "Unexpected non-int endpoint\n");
>-		return -ENODEV;
>-	}
>-
> 	/* allocate memory for our device state and initialize it */
> 	dev =3D kzalloc(sizeof(struct bcm5974), GFP_KERNEL);
> 	input_dev =3D input_allocate_device();
>
>---
>base-commit: 90d35da658da8cff0d4ecbb5113f5fac9d00eb72
>change-id: 20240305-revert_bcm5974_ep_check-37f2a6ab2714
>
>Best regards,


--=20
Dmitry

