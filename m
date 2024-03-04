Return-Path: <linux-kernel+bounces-90105-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 63DE186FA6E
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 08:05:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1EBDC2823BD
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 07:05:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE63F134AE;
	Mon,  4 Mar 2024 07:04:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QqgxkHIn"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBFBD1170A
	for <linux-kernel@vger.kernel.org>; Mon,  4 Mar 2024 07:04:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709535895; cv=none; b=Pcde8Cbl60Tym18AlUIEdefeeIdWpA4XpBF965MKGG6SroviixH4AZmkLk1D1DSwG+HM2Gk5bGKOm99fQW8E27Q3LXx2octf1v1XPKFidyDJYqQJV/AVKNEgwdaJVtO7m6Zo+4+aa6yYOKka5tMYaUdSISQmvCtpq+IeH2pQoLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709535895; c=relaxed/simple;
	bh=fOzF9T+7+v6nbIr6JpI2D3fB/kcAd613CX/CdSkUuJg=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=FOxZTBlcMwNbUOsir4aVld+uobiOUQ0DuwoBwGoQ5FfVwUla11CfOXvwA9LpUhNVqF9Q3cWLB/VGmYTSkmCavIpdiJQNSUWukfy8jhLgcoB/dluzK2Z9gVNXhxglNO7xSEhOataSMh/awtIIMfjP74HcfyZSnBjQ64NZYeIRFrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=QqgxkHIn; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-412e22315d8so4889235e9.1
        for <linux-kernel@vger.kernel.org>; Sun, 03 Mar 2024 23:04:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709535891; x=1710140691; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/RTu2QOOVQbOweB1LGR/BRbdQUT3nXvJVjgo89rA8a4=;
        b=QqgxkHInV4+gl4HHNp17XXNyik/Bcn8YA+vnUVHB2DLacIH2Gwt2E8Oe5Q4zouwm6+
         C5WexYBrTa6PQ/E49dwt2JzHQ7n90zKCsshi0WG6JhiMtvF53EYTLYAaBK0PXlYbjrr5
         haP3oJNHMlFC0HeQAVchgCmV+pTL2HAYvVCYmOAw9egIPE7bZg4yCY1hANdokMsbpZPn
         d9+BsM0pxdwB/Q58Fj9UT7YOUjyL1fStrbeLEpYVs64XEgGzRcmRASN+aPnzfAGBU4tg
         0wr6yj6TjGQ54DWlDFcw2Dl5IOgpidxYzUPqq195CVNevcL0riPNHmF8BR+qzSLBnN6V
         TXHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709535891; x=1710140691;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/RTu2QOOVQbOweB1LGR/BRbdQUT3nXvJVjgo89rA8a4=;
        b=OXLqdUz8D+4GalbIL3slnyxyPOtnaRfrSJOX+0LeRvIadcWvIb9rS9ODWYt3vRIqJY
         1DywOWMyDNSUR6FdIJWLcwOUSkW5Xnn+1G/Q5vPvB96kpBLE+YhAJx3QnK4EN6l3LNwh
         5eQhzk4D6GHBkG7FFGbxRMt9aGmc3urR0JnUSHQIpaDHt3SkNMceInl3IRMsqrnVPZa5
         pJQ7jbWe0+UzOo5EdvF5Rz9ZB9sVkSr4Z2QR8lC4Boa0rFJw2GePwdnSCH6m13HZPF+c
         9BIof9YQk2+m/MUiVjpGV+jGeXok/3Dhm1iv9uggc2vkh1TExjNgAnDqzc+PDkRLV8Rs
         fu6w==
X-Forwarded-Encrypted: i=1; AJvYcCW16z5ubh7UKA4iZj/KzUMb0fQtaqK6ZSl+rgo53AD8HRzI979c2GioOlWddpg0QKUmEs8XJQy9GB0liEHdqTHYYvFkgPzfvgfNigtz
X-Gm-Message-State: AOJu0YxCeLTrEAWKTtvMaw7iuq7yoCDTB0myBaeB6YZP8axFbW17vWhb
	1OHhuNA0cF0gJaTCLunFbHMj47wrfVZIg33SUBJIS9FTnVhWI4KDWKn9ln3ejoE=
X-Google-Smtp-Source: AGHT+IFc4xUICRVVStYlfPV57gzFOOaMSvfieW4xk8n3smggrfWI5KpXmkdHe/qcd3sZ3tLX4YTRXQ==
X-Received: by 2002:adf:9c8b:0:b0:33d:47d6:c159 with SMTP id d11-20020adf9c8b000000b0033d47d6c159mr5733432wre.12.1709535891433;
        Sun, 03 Mar 2024 23:04:51 -0800 (PST)
Received: from localhost ([102.222.70.76])
        by smtp.gmail.com with ESMTPSA id r18-20020adfca92000000b0033dcc0d1399sm11375456wrh.25.2024.03.03.23.04.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Mar 2024 23:04:51 -0800 (PST)
Date: Mon, 4 Mar 2024 10:04:48 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Rui Miguel Silva <rmfrfs@gmail.com>
Cc: Johan Hovold <johan@kernel.org>, Alex Elder <elder@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	greybus-dev@lists.linaro.org, linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH] staging: greybus: fix get_channel_from_mode() failure path
Message-ID: <379c0cb4-39e0-4293-8a18-c7b1298e5420@moroto.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

The get_channel_from_mode() function is supposed to return the channel
which matches the mode.  But it has a bug where if it doesn't find a
matching channel then it returns the last channel.  It should return
NULL instead.

Also remove an unnecessary NULL check on "channel".

Fixes: 2870b52bae4c ("greybus: lights: add lights implementation")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 drivers/staging/greybus/light.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/greybus/light.c b/drivers/staging/greybus/light.c
index d62f97249aca..a5c2fe963866 100644
--- a/drivers/staging/greybus/light.c
+++ b/drivers/staging/greybus/light.c
@@ -95,15 +95,15 @@ static struct led_classdev *get_channel_cdev(struct gb_channel *channel)
 static struct gb_channel *get_channel_from_mode(struct gb_light *light,
 						u32 mode)
 {
-	struct gb_channel *channel = NULL;
+	struct gb_channel *channel;
 	int i;
 
 	for (i = 0; i < light->channels_count; i++) {
 		channel = &light->channels[i];
-		if (channel && channel->mode == mode)
-			break;
+		if (channel->mode == mode)
+			return channel;
 	}
-	return channel;
+	return NULL;
 }
 
 static int __gb_lights_flash_intensity_set(struct gb_channel *channel,
-- 
2.43.0


