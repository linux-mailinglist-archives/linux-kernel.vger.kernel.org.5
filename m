Return-Path: <linux-kernel+bounces-79473-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CCB6B8622B8
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 06:25:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D7172B227F2
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 05:25:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 527DE17541;
	Sat, 24 Feb 2024 05:25:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="d8y47D9g"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C31DF1FAA
	for <linux-kernel@vger.kernel.org>; Sat, 24 Feb 2024 05:24:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708752319; cv=none; b=Omwn4/Y74FK87RVxfJT9bDNqO+NhkvwJXp7u/qSG63nn3FOcPRjFn096AqvDg+bhOQRnfMPf8eOR6ZICIkRqPe7vWcjAa9w783aJ9nadNokojfzaPPp09/xaSPOL8mW+IPpEDm8LMkcIm3ql2kbT1EVvk4xNzrRgVDFdBFUfZRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708752319; c=relaxed/simple;
	bh=QUVWQXF4RnbcTmcdlBVlHaewtgXiBHCNt2bTtC2kEk4=;
	h=Date:Message-Id:Mime-Version:Subject:From:To:Cc:Content-Type; b=l5Fbp1LJCVpG+f+d5jqi8BowB7gTsVvztUjuPj/1DYjFuTj4a+Xjp91v8TA8sygw6oTCziRCQrhCPFXHwt6p4yPWRfmgT0Y2n4AZXP6rV0F3V4HVYdNapWX78HyO3MnnElwAf1ZFgQjAooiZPiT3mOTTZxu3IlRBGXPpjbJprJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--saravanak.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=d8y47D9g; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--saravanak.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-5ee22efe5eeso27489517b3.3
        for <linux-kernel@vger.kernel.org>; Fri, 23 Feb 2024 21:24:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708752278; x=1709357078; darn=vger.kernel.org;
        h=cc:to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=NmM7cCBUfnsEzWOUWxpGwPzttTnkh5grF+m9vEmGQ0Y=;
        b=d8y47D9g19pxlwzf3UZp5qNEWdXp+nZZas5JoZkAfClrGXIGtrAYXV8pNLdm2nxAj3
         8IrVgVOoBUKWbvv8Vmd2al8w2TZZBOJiZtoX5LYY0hDn5JlcebyBGB2Kq8NAo8HFk3Ym
         S+7Zf4O5Y/xJv39jJ0eZg8IFxAniSKd5YsRHURy61xLKG6y0y0v/tHlM9+7J9w06Yb6F
         kz29u8V3udFhKs0A1NlvQXNltcPcj3ig+AMgpdd6iLozBLvxTIS5a4wlwj5cu0I9JJma
         jLCLa3zW18s/HmCvQb3jbpGCthe+sZ/OalBeFr0cWPu0vp5GoV0SArPTRXinJvFDGX2j
         +Ahg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708752278; x=1709357078;
        h=cc:to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NmM7cCBUfnsEzWOUWxpGwPzttTnkh5grF+m9vEmGQ0Y=;
        b=LVu8U00J4E6l5unVhg7JftD5Oj+Q/IMfgssH/h1tknpUYuqH/k86MfrGLR1cVweDRM
         XKv8I8er0tob3BfOmGKKOL+2iGTO7hx3IVS5nzdslYfmOckpmXs8zgZFxNMaCjIVrcyM
         F0Q4yIS9lyNDyzksuMGE62MLxiaux0YjpKoKJA03AUvkRCQZ98d73LJ5Ygw/krlbkA8M
         5Oi5MIez2mWHAd+umKxvBte5CIp4sHY+yek1cOXIiCTxajRKe2CB8gmR98jiCFZZ5avo
         UpqMf86hEGAfVStT7E9f2NYC24t5pa+VwB+nQ4wvo7xWKYEZnr1UU/RULT9LVtwtV1tw
         7z2w==
X-Forwarded-Encrypted: i=1; AJvYcCX4rq317mc3FIC0848Xc2f2RemqNBikbASZUpSNWa0HkccSNRwg2kZEtToNdQYJOQ3H0BDp+fTKKaVHp4lJkd0fbJrET7LqEJlqE+r4
X-Gm-Message-State: AOJu0Yypt6a7UulJFdzxGMlPrlnkaZRQzWby7RJGcU1AB6nDxS1TbG4e
	kTyZYFeNzqDUofc/Aq8peiR2yYvAo4X+nPqcR+UT/s4EDo0yzVqNKDv9OrYRP10klXRbj4t536n
	kmtMPnhJtjpSQUA==
X-Google-Smtp-Source: AGHT+IF/Tvc+aSFvYXsoNow2jwI9jQmjjkYlV+3vhEkPuK71n5NIXCH3E3EHqzGZ8X0dHGjMQaNQndcX2ubrEKE=
X-Received: from saravanak.san.corp.google.com ([2620:15c:2d:3:935f:fca4:5a22:7b7])
 (user=saravanak job=sendgmr) by 2002:a05:690c:338b:b0:608:c3f4:1fb9 with SMTP
 id fl11-20020a05690c338b00b00608c3f41fb9mr363187ywb.3.1708752278758; Fri, 23
 Feb 2024 21:24:38 -0800 (PST)
Date: Fri, 23 Feb 2024 21:24:35 -0800
Message-Id: <20240224052436.3552333-1-saravanak@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.44.0.rc0.258.g7320e95886-goog
Subject: [PATCH] of: property: fw_devlink: Fix stupid bug in remote-endpoint parsing
From: Saravana Kannan <saravanak@google.com>
To: Rob Herring <robh+dt@kernel.org>, Frank Rowand <frowand.list@gmail.com>, 
	Saravana Kannan <saravanak@google.com>
Cc: "=?UTF-8?q?Herv=C3=A9=20Codina?=" <herve.codina@bootlin.com>, Luca Ceresoli <luca.ceresoli@bootlin.com>, 
	kernel-team@android.com, Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Introduced a stupid bug in commit 782bfd03c3ae ("of: property: Improve
finding the supplier of a remote-endpoint property") due to a last minute
incorrect edit of "index !=0" into "!index". This patch fixes it to be
"index > 0" to match the comment right next to it.

Reported-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
Link: https://lore.kernel.org/lkml/20240223171849.10f9901d@booty/
Fixes: 782bfd03c3ae ("of: property: Improve finding the supplier of a remote-endpoint property")
Signed-off-by: Saravana Kannan <saravanak@google.com>
---
Using Link: instead of Closes: because Luca reported two separate issues.

Sorry about introducing a stupid bug in an -rcX Rob.

-Saravana

 drivers/of/property.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/of/property.c b/drivers/of/property.c
index b71267c6667c..fa8cd33be131 100644
--- a/drivers/of/property.c
+++ b/drivers/of/property.c
@@ -1304,7 +1304,7 @@ static struct device_node *parse_remote_endpoint(struct device_node *np,
 						 int index)
 {
 	/* Return NULL for index > 0 to signify end of remote-endpoints. */
-	if (!index || strcmp(prop_name, "remote-endpoint"))
+	if (index > 0 || strcmp(prop_name, "remote-endpoint"))
 		return NULL;
 
 	return of_graph_get_remote_port_parent(np);
-- 
2.44.0.rc0.258.g7320e95886-goog


