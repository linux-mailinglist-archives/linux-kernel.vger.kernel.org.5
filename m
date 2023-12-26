Return-Path: <linux-kernel+bounces-11447-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 110CE81E67E
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Dec 2023 10:41:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A2F941F21DCC
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Dec 2023 09:41:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E026E4D12A;
	Tue, 26 Dec 2023 09:41:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="TQpM5jWj"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.17.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 683DB4D109;
	Tue, 26 Dec 2023 09:41:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1703583650; x=1704188450; i=markus.elfring@web.de;
	bh=QEIlNohXQKR5iUvYT2jHXT8Fr7MmOczXQbaPuHwZhWk=;
	h=X-UI-Sender-Class:Date:Subject:From:To:Cc:References:
	 In-Reply-To;
	b=TQpM5jWjeEjOy3EjSwtf1SAHvSY3/EKkaMgeqyAojcHix+Ol95Df2AZHbxQ67cUY
	 WEwVgigF7WIPC0+asLsREnOO3Yp9O8mo7fbqhW0GHNIw/gXSVHZOXlsuVQqlTw9m4
	 rIQU21eOoGO7JotN4tDcRbL5rol/Q+q74MjIAyl+OQ2sDH/LEH+HQ0tE7aDyhBu4d
	 /7F3JsUBS+cN1gx7bkUxzWLpjk5I3ffK2UQTnnGyXtWxkrGZc/kJamCwra3L3JtDd
	 4IqvIRPs4mcehGPxF5OB/YFc+rPE0EtcYcua+Z14c4k7H54nu5H3SNxM3AlhUnKMS
	 xUXXL6/2u3/nv38PLQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.85.95]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MIc7b-1rWeFb0x1B-00EoEL; Tue, 26
 Dec 2023 10:40:50 +0100
Message-ID: <7c6a919c-3757-42af-aee4-3d48721d1959@web.de>
Date: Tue, 26 Dec 2023 10:40:48 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH 2/3] drm: property: Delete an unnecessary initialisation in
 drm_property_create()
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
To: dri-devel@lists.freedesktop.org, kernel-janitors@vger.kernel.org,
 Daniel Vetter <daniel@ffwll.ch>, David Airlie <airlied@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>
Cc: LKML <linux-kernel@vger.kernel.org>, cocci@inria.fr
References: <ff7ce5d0-59fa-470c-8dd6-68dbe65c18e5@web.de>
In-Reply-To: <ff7ce5d0-59fa-470c-8dd6-68dbe65c18e5@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:gHRM60fhbiROJai12btJyLRtTcOd7dO9E0nCoV0k4kI2NBX1xi4
 7CaFJ2MqRCS3EHB4tsGMJ4lf3o0qYjBCYPC9yunWXgxZ3RwuHNqmmHStQSXiziC5JQgrldI
 ntssKn3BLAuw3gvZFt3VmkSKemER4GRqnCxY9LZAJ8nLgChA9FZg7Mxxa09u5/yszpHqJzr
 JakSRCxwcYASditzdkqtA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:BkjCJZF6hJY=;YAGeEr5yQNWL/I6B32iev/AXTMY
 K70iLvRHsrFwc94MoYkBd111HXgaWlwQbe7Maud0HScN0G8gRhYzuflF7rGfJIrgdBmn+XpC1
 wJzhCuMZ+euroE94eqQYF5mNcoYbto0ATvt/fMg1HOl8UtIlCT1AOMEzeoCjHaO83ecnJjmuT
 yIkILu/nISKhnNR6TxzHeuqDTABwBTx+HbHRj4JWHcH59hcX18wGmdXTnemGEodCsb2aMedxC
 O2RfXbT7FJX87MtivoxNg6oaLr+O/8FvB2XNcIOfDgwU+l3ocDrZe3miH8+ManMOddsyI05eF
 SEwMpOt1r1kW9sVuMDaTGHx8b0RMPbeQzteLJTodTRFfuCgYzr8EDdLpCPvhNP5Gu5pKJCEVW
 Z98J6+x4WuHGpTDxLQWrtSFuP63X+MtpxCB9hV0WrkaWaVHedwANc0uYB2GC0QWWE1IySScxY
 +qFFiGbn4RW+Eq0hAMXqSr6OJbOwoAZu67AZfHyY2B/mf4EBvdG07ff/JS1s9vpKK2WkuiZo5
 veF9ZS29RoNMXGLyYsC6LfSUgiu8NT7O8UYmGMnnV8K2ADAJ9C3WL+ysCw2HIA2Z0ZuAKuB3X
 fCdlZxJfw5o25nqFaIbhAIMpzDHjR8HcYc3wyxHi7J7YKufp5kP6Fx/lWdH6LDeLPfz6B3I5s
 OAh41DanF4BYpDVmoyUlSf/+aRjY/2sJVJ6V7uoBTq5rHje7fJlJSK9bFL/F0+hM2uIN68Fun
 uxjotAQKT0AmdZ1NxzmF83m5H1pjTNEtogtCicNDMbOkXOPX+qBQanFcK+STR82JfOnz1dcaF
 0sddd3RBHB9yHk6NvGIbajTzmJGG+0cQ0DvnTgUMkUTQRbDfxflmH3zt8pg9TEspM+ugVv78b
 9MTXXdiyv6iCyJiIAAuZtPqUREbZolL5vQlITAgXv82mHaVAnodo4ZCBNEKJcA/zpDuwne3Bg
 qiEUGA==

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Tue, 26 Dec 2023 08:46:12 +0100

The variable =E2=80=9Cproperty=E2=80=9D will eventually be set to an appro=
priate pointer
a bit later. Thus omit the explicit initialisation at the beginning.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
 drivers/gpu/drm/drm_property.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/drm_property.c b/drivers/gpu/drm/drm_property=
.c
index 3440f4560e6e..ea365f00e890 100644
=2D-- a/drivers/gpu/drm/drm_property.c
+++ b/drivers/gpu/drm/drm_property.c
@@ -98,7 +98,7 @@ struct drm_property *drm_property_create(struct drm_devi=
ce *dev,
 					 u32 flags, const char *name,
 					 int num_values)
 {
-	struct drm_property *property =3D NULL;
+	struct drm_property *property;
 	int ret;

 	if (WARN_ON(!drm_property_flags_valid(flags)))
=2D-
2.43.0


