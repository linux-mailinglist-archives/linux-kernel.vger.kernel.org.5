Return-Path: <linux-kernel+bounces-133127-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 44F7D899F43
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 16:16:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DE181283F60
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 14:16:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0142C16F820;
	Fri,  5 Apr 2024 14:15:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ajyTNn22"
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7967E16F290
	for <linux-kernel@vger.kernel.org>; Fri,  5 Apr 2024 14:15:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712326514; cv=none; b=hwJLuUVcvzGg8gsSyPwQlJGecM5kBOnkW74bwl/tJKJtW2L9Z3eid1TWluhsMVCz7mLeUkEYsfLfdzrPhihIHPxs3aff8OMbpP9/J8eSGLvGxqG5xgBUXJ/qNu3/vP/aJ5A8vvgzHqhcRCgUqrXQrEiDJEHVsjLQDqwpD/Dc5tg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712326514; c=relaxed/simple;
	bh=8aQ18Uj04YT2A+P3Oh2IhoxHUDUc0ZferNgCl6q/rqY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ecbc7V3u1JxFAGxL36PbIS16XjjZEOpMwmSH/OMTt18Gj6CEVaMofRvTZhP1A1/2CouOySMXDbpHXbqxM5L1oPy6EJ6QI9Foz9u5lqUIztvBL0yPEP6JZ8ZtOmJMLyaLESH5FYkM5BknNYj0ygs89pHkKUxwwY1b5E0VRw0btLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--panikiel.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ajyTNn22; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--panikiel.bounces.google.com
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-4155db7b58cso11187675e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 05 Apr 2024 07:15:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712326511; x=1712931311; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=My1wqn+atygHUN+jmKPzc06Fma5b+VEUv6s9yO8/Vks=;
        b=ajyTNn22yOMMVgwV2TyOxLo8XPjO/AleimyLqn3iEdvfaTrxp0IyjoFvhRbsmb7/Nq
         suiKWC4KGMWKgo+xmYdEol4ylR9gHLsYFATSbL8pIOgj3yh9KD3LNpEM33p6n8aDRQsA
         JpORTSKPYPySYOOTHcf0BsMWC6S/RUhQtgpCWVXGeegd7YWIG/WAZCoHrxx1gYEli50l
         GUFTsbssCb9Ef08p8BrdTlB6sI+ljnFgzTVIHDLGzPPLJDISeEkk2mjt4lhi/a0YtfPg
         a5FXNsEj5OpTVtVoUXm1IvU1J+QJ4t4pBjylUOJdO6+iKfv68rOCMbZSOV3BG/37S/YS
         NUZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712326511; x=1712931311;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=My1wqn+atygHUN+jmKPzc06Fma5b+VEUv6s9yO8/Vks=;
        b=D+cib0Yc/+5rT7Se2U5BT4jz1deXRaWm/boMT6M4vwR94g13wv33Mh6dYIHclt4CXk
         36SsbbW11AsMuJnTqKHY+HB0Wo4XfN5xgJeTDMHg9hbdMuqBhkprq2XW7Lk9zDGExaUa
         MwqJS++o5EyqYJi5BBWsKG/gGfvgBJZNlIs1SlP29COGLSnB5gxjEC2WJv344xwR7MqC
         rNMAIGDx9qXGGgWWHS9/2UfAmDwyFJhCsccE/SVinAYKu8NR7Oi1tPuMYBtNNrkUu232
         nH3FR/ZK3vTrwEqwoYinoJN4x8iCOeaHLT9HM/jyhSnALhYTB7mP9hKl2kf9v0X0TaeZ
         69xg==
X-Forwarded-Encrypted: i=1; AJvYcCVqkuKWoTjk1/Liik31IKX1PK/IHbkY/PC5BUi9mrTdlE94GtKqNsEnHrSFoOyjpbM6QSyeh3FLQ1PtwXtDwSAwTaxESNbTlQMg0jUB
X-Gm-Message-State: AOJu0YwsCgilv7Gm99ZT2z7LtAuaOjIyhe7JyuC8dQxruvsK85AeXzjo
	XXs8NRPFTBGHYBqYnX3jh9JCDFkwnVcAGuOqQ/KBHBd+gCwoycRi5WswPJk3dBhGk4NS2LHfVc+
	78dWwMKjz7Q==
X-Google-Smtp-Source: AGHT+IEdrMjCWzhSnkncvw6N1O1UZ1VCF1PMUEfzJPCR3jpkvdvdrcU6A9BajfE3olsmjFosqv9KN+QUA9LFZA==
X-Received: from szatan.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:2d83])
 (user=panikiel job=sendgmr) by 2002:a5d:5a98:0:b0:343:2ec2:e4e8 with SMTP id
 bp24-20020a5d5a98000000b003432ec2e4e8mr4389wrb.3.1712326511044; Fri, 05 Apr
 2024 07:15:11 -0700 (PDT)
Date: Fri,  5 Apr 2024 14:14:00 +0000
In-Reply-To: <20240405141411.1807189-1-panikiel@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240405141411.1807189-1-panikiel@google.com>
X-Mailer: git-send-email 2.44.0.478.gd926399ef9-goog
Message-ID: <20240405141411.1807189-6-panikiel@google.com>
Subject: [PATCH 05/16] media: i2c: adv7842: Switch dv timing callbacks to pad ops
From: "=?UTF-8?q?Pawe=C5=82=20Anikiel?=" <panikiel@google.com>
To: kieran.bingham@ideasonboard.com, mchehab@kernel.org, 
	hverkuil-cisco@xs4all.nl, tharvey@gateworks.com, 
	niklas.soderlund@ragnatech.se, prabhakar.csengg@gmail.com, 
	charles-antoine.couret@nexvision.fr, thierry.reding@gmail.com, 
	jonathanh@nvidia.com, skomatineni@nvidia.com, luca.ceresoli@bootlin.com
Cc: linux-media@vger.kernel.org, linux-kernel@vger.kernel.org, 
	chromeos-krk-upstreaming@google.com, 
	"=?UTF-8?q?Pawe=C5=82=20Anikiel?=" <panikiel@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Change all (s|g|query)_dv_timings subdev callbacks to include
a pad argument.

Signed-off-by: Pawe=C5=82 Anikiel <panikiel@google.com>
---
 drivers/media/i2c/adv7842.c | 25 +++++++++++++++++--------
 1 file changed, 17 insertions(+), 8 deletions(-)

diff --git a/drivers/media/i2c/adv7842.c b/drivers/media/i2c/adv7842.c
index 2ad0f9f5503d..f2d4217310e7 100644
--- a/drivers/media/i2c/adv7842.c
+++ b/drivers/media/i2c/adv7842.c
@@ -1518,7 +1518,7 @@ static void adv7842_fill_optional_dv_timings_fields(s=
truct v4l2_subdev *sd,
 	timings->bt.flags |=3D V4L2_DV_FL_CAN_DETECT_REDUCED_FPS;
 }
=20
-static int adv7842_query_dv_timings(struct v4l2_subdev *sd,
+static int adv7842_query_dv_timings(struct v4l2_subdev *sd, unsigned int p=
ad,
 				    struct v4l2_dv_timings *timings)
 {
 	struct adv7842_state *state =3D to_state(sd);
@@ -1527,6 +1527,9 @@ static int adv7842_query_dv_timings(struct v4l2_subde=
v *sd,
=20
 	v4l2_dbg(1, debug, sd, "%s:\n", __func__);
=20
+	if (pad !=3D 0)
+		return -EINVAL;
+
 	memset(timings, 0, sizeof(struct v4l2_dv_timings));
=20
 	/* SDP block */
@@ -1643,7 +1646,7 @@ static int adv7842_query_dv_timings(struct v4l2_subde=
v *sd,
 	return 0;
 }
=20
-static int adv7842_s_dv_timings(struct v4l2_subdev *sd,
+static int adv7842_s_dv_timings(struct v4l2_subdev *sd, unsigned int pad,
 				struct v4l2_dv_timings *timings)
 {
 	struct adv7842_state *state =3D to_state(sd);
@@ -1652,6 +1655,9 @@ static int adv7842_s_dv_timings(struct v4l2_subdev *s=
d,
=20
 	v4l2_dbg(1, debug, sd, "%s:\n", __func__);
=20
+	if (pad !=3D 0)
+		return -EINVAL;
+
 	if (state->mode =3D=3D ADV7842_MODE_SDP)
 		return -ENODATA;
=20
@@ -1689,11 +1695,14 @@ static int adv7842_s_dv_timings(struct v4l2_subdev =
*sd,
 	return 0;
 }
=20
-static int adv7842_g_dv_timings(struct v4l2_subdev *sd,
+static int adv7842_g_dv_timings(struct v4l2_subdev *sd, unsigned int pad,
 				struct v4l2_dv_timings *timings)
 {
 	struct adv7842_state *state =3D to_state(sd);
=20
+	if (pad !=3D 0)
+		return -EINVAL;
+
 	if (state->mode =3D=3D ADV7842_MODE_SDP)
 		return -ENODATA;
 	*timings =3D state->timings;
@@ -2780,7 +2789,7 @@ static int adv7842_cp_log_status(struct v4l2_subdev *=
sd)
 				"interlaced" : "progressive",
 			hs_pol, vs_pol);
 	}
-	if (adv7842_query_dv_timings(sd, &timings))
+	if (adv7842_query_dv_timings(sd, 0, &timings))
 		v4l2_info(sd, "No video detected\n");
 	else
 		v4l2_print_dv_timings(sd->name, "Detected format: ",
@@ -3226,7 +3235,7 @@ static int adv7842_command_ram_test(struct v4l2_subde=
v *sd)
=20
 	memset(&state->timings, 0, sizeof(struct v4l2_dv_timings));
=20
-	adv7842_s_dv_timings(sd, &timings);
+	adv7842_s_dv_timings(sd, 0, &timings);
=20
 	return ret;
 }
@@ -3298,9 +3307,6 @@ static const struct v4l2_subdev_video_ops adv7842_vid=
eo_ops =3D {
 	.s_routing =3D adv7842_s_routing,
 	.querystd =3D adv7842_querystd,
 	.g_input_status =3D adv7842_g_input_status,
-	.s_dv_timings =3D adv7842_s_dv_timings,
-	.g_dv_timings =3D adv7842_g_dv_timings,
-	.query_dv_timings =3D adv7842_query_dv_timings,
 };
=20
 static const struct v4l2_subdev_pad_ops adv7842_pad_ops =3D {
@@ -3309,6 +3315,9 @@ static const struct v4l2_subdev_pad_ops adv7842_pad_o=
ps =3D {
 	.set_fmt =3D adv7842_set_format,
 	.get_edid =3D adv7842_get_edid,
 	.set_edid =3D adv7842_set_edid,
+	.s_dv_timings =3D adv7842_s_dv_timings,
+	.g_dv_timings =3D adv7842_g_dv_timings,
+	.query_dv_timings =3D adv7842_query_dv_timings,
 	.enum_dv_timings =3D adv7842_enum_dv_timings,
 	.dv_timings_cap =3D adv7842_dv_timings_cap,
 };
--=20
2.44.0.478.gd926399ef9-goog


