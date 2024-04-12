Return-Path: <linux-kernel+bounces-143340-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 339648A3765
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 22:58:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 451BAB21C80
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 20:57:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1309614EC4E;
	Fri, 12 Apr 2024 20:57:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YVigdaAq"
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDCC83D0B8;
	Fri, 12 Apr 2024 20:57:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712955461; cv=none; b=NITQQoADDtNOSnAxlEjCaFvlAK4uv9yvY7v1KwlnWC3c+j8OC9vCIBbyg8UyhBrpAMoUEQFfbjlcAvQP+p8kDDKClQmGVAv12OpdGQBFDBxLw4G4OEstWOguxrL3W+UeTkgFYgwIwAhdeuH6uPusCUGAePLacnn7PqGTheEBk5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712955461; c=relaxed/simple;
	bh=BVzVqp8trzkV4ZG9KOZgQC6TrXg1L740OrPWMBaBgXI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=OJpj8owj3QrkLU+OmIeN1HhSVyHrEk75SKMLmnKLKgRh73GrgHs8wakMKd8Z5+5q8Xkj4ZKeB8jC+3euRAxG0YSRsg9RqtENmUHPxjfLwBafqSy/Rs5meyyM3jOtt4cyBZzLBGHEVMsZbL3glplaF5Jehj2dtkm3fDO5LiAzMg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YVigdaAq; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-346f4266e59so951430f8f.3;
        Fri, 12 Apr 2024 13:57:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712955458; x=1713560258; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FCkHkDQ/J68KHhz/dTMPvVvcbRSRcKWJMB2HWO4YtQw=;
        b=YVigdaAq/g36pPt666tgFMPxBOZfCoPlRZKNYP51yaQI19VMc7ymugrL5scdf3Om1s
         iSsF9RUYTcEMEKEQtJ6RBNB0BQShEv+GVXZ976ZLaaWkHpxd1QxEWfk3xBT25BHWR37c
         h6C8vdSfyadOdlZcfND/KLzQTQwOcJUtYlZAnJ9Jr3IFyO/5EG/1n6DQPdv9UpUHCHqz
         8QrRmFW64LLGOPtKZxt4MCzME0HzRJp+ce6tsEZfLOny8E1GpRpBJ70SBTK89o19OzK6
         pTogzdPIvswYNYZ7QExC/cOH4t4MMH2takafohrQqo2+LNwf7pkC82E2MeW4Uau9L68y
         uClg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712955458; x=1713560258;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FCkHkDQ/J68KHhz/dTMPvVvcbRSRcKWJMB2HWO4YtQw=;
        b=lDx8sKuRGM6PxW9epm3uO3C6co9p1xwiQ6Ixb+i3wW7B4aFou3ADTbgr+H4DMINhca
         txg8rcwzMQzWNjJhVMbiDdVSOKHpGVRhJLYEYlM/bHEgfbO7slk9j1bjcejKHp7aZG+c
         ryCZSEcUZSJYmP7uv/P2rngAw1Iy96TahhXcOGbjddjiDuCcs84k7yrl1WWIxmxxk/sb
         u3OgvkNWOsVd+qn5TG13w7gdu1PYzFQwtuuhF17hMk61R+C+R5WGvyJM6wA9lpfP0ctD
         vUxnt5edZ1TpIhxVtR+Fzez/fbGY/C/y+gsolho7NTxecQyH1iiQ3WGG751QE7zLY1cH
         cCcw==
X-Forwarded-Encrypted: i=1; AJvYcCU1NLNoufZzQQVH7J6H9ldEeud21htbRmH4Uvua8qrZuURFaaB5zUDXG9exBJ8PZfV5v9h45ADs1SrBFpQe5quY89wQxJZWECYniwvP
X-Gm-Message-State: AOJu0YxEt7Vt3tu0r4hQPjDxhPoGQaVW0szM2o/p3u6Ga5/rAdIfgptN
	wrGQyxu0EufoLpfPJ/dwBMP7AlKe6Px8CQGU8L6R7S6216XBrR2x7P3/W54Y
X-Google-Smtp-Source: AGHT+IEQuY+GRVK7Mx2y0/jxPH/4rPt5kCgpEIOi6/M/lI6EsXKAEZhr2FgGd04JdKqS9jN2leaM9A==
X-Received: by 2002:a05:6000:1846:b0:345:84c8:35ec with SMTP id c6-20020a056000184600b0034584c835ecmr3148644wri.61.1712955457657;
        Fri, 12 Apr 2024 13:57:37 -0700 (PDT)
Received: from [127.0.1.1] (84-115-213-64.cable.dynamic.surfer.at. [84.115.213.64])
        by smtp.gmail.com with ESMTPSA id l8-20020a5d4808000000b0034599eca6c9sm4989203wrq.41.2024.04.12.13.57.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Apr 2024 13:57:36 -0700 (PDT)
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Date: Fri, 12 Apr 2024 22:57:30 +0200
Subject: [PATCH 1/6] input: iqs269a: use
 device_for_each_child_node_scoped()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240412-input_device_for_each_child_node_scoped-v1-1-dbad1bc7ea84@gmail.com>
References: <20240412-input_device_for_each_child_node_scoped-v1-0-dbad1bc7ea84@gmail.com>
In-Reply-To: <20240412-input_device_for_each_child_node_scoped-v1-0-dbad1bc7ea84@gmail.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Javier Carrasco <javier.carrasco.cruz@gmail.com>
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1712955454; l=1319;
 i=javier.carrasco.cruz@gmail.com; s=20240312; h=from:subject:message-id;
 bh=BVzVqp8trzkV4ZG9KOZgQC6TrXg1L740OrPWMBaBgXI=;
 b=OWZxFFVeMFbp30HoGyKbQFkZWG0nZLw2JOlLptiD8lPNzuuxYLdMYhN1UgLJdSPazE0fMQKYg
 XKjSvQEShV7AyK34k/bkzVlgM8b99ZaDo0BKWMMRJX/2ant8yoojTpX
X-Developer-Key: i=javier.carrasco.cruz@gmail.com; a=ed25519;
 pk=lzSIvIzMz0JhJrzLXI0HAdPwsNPSSmEn6RbS+PTS9aQ=

Switch to the _scoped() version introduced in commit 365130fd47af
("device property: Introduce device_for_each_child_node_scoped()")
to remove the need for manual calling of fwnode_handle_put() in the
paths where the code exits the loop early.

Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
---
 drivers/input/misc/iqs269a.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/input/misc/iqs269a.c b/drivers/input/misc/iqs269a.c
index cd14ff9f57cf..843f8a3f3410 100644
--- a/drivers/input/misc/iqs269a.c
+++ b/drivers/input/misc/iqs269a.c
@@ -811,7 +811,6 @@ static int iqs269_parse_prop(struct iqs269_private *iqs269)
 {
 	struct iqs269_sys_reg *sys_reg = &iqs269->sys_reg;
 	struct i2c_client *client = iqs269->client;
-	struct fwnode_handle *ch_node;
 	u16 general, misc_a, misc_b;
 	unsigned int val;
 	int error;
@@ -1049,12 +1048,10 @@ static int iqs269_parse_prop(struct iqs269_private *iqs269)
 
 	sys_reg->event_mask = ~((u8)IQS269_EVENT_MASK_SYS);
 
-	device_for_each_child_node(&client->dev, ch_node) {
+	device_for_each_child_node_scoped(&client->dev, ch_node) {
 		error = iqs269_parse_chan(iqs269, ch_node);
-		if (error) {
-			fwnode_handle_put(ch_node);
+		if (error)
 			return error;
-		}
 	}
 
 	/*

-- 
2.40.1


