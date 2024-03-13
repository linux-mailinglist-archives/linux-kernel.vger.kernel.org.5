Return-Path: <linux-kernel+bounces-102333-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EDE6087B0D9
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 20:02:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2B9ED1C26A2C
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 19:02:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BB9E6A330;
	Wed, 13 Mar 2024 18:07:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MdeJFSNZ"
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 977EB6A325
	for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2024 18:07:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710353271; cv=none; b=huGJVK9oEmyEmn3lEPajgH8I8j09VyyRm9zydOLU8QcOz+5pQSnccJBApr0VsTYreZItTwtgCcjn3DjwNERLMwjOY9tvAvwW+vk1m9+PrMd9S5vHmm9zzAw1UZgQKidIPpjQBwdAjN3rAL7V2PrrOh66Vko+9sADWHEgBbBJGTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710353271; c=relaxed/simple;
	bh=Uuplj9eaDOr9flWRmzj0THPm4GMMx7dTi3+SYBcmALw=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=ipVEdO/fKkv0BX8qvoSwpI9llJYzHXzZe5EavzUVXcR8JhJFaxMvJhEkgL/ScoDz0661/5tR8XqD38NMBVlEE02s6tB5AWKn0NVYEM1hM0OceSBwh1GqDlih4h3jdDhhgSC/9CHRmb/zdTShCFPa0MDESSixQHSHaIgQqqWWanU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=MdeJFSNZ; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5687feeb1feso123503a12.2
        for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2024 11:07:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1710353268; x=1710958068; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oMXTFuaRy2/DahWa3k1XzhwntrhYB+tFZxVYLm3/Iu0=;
        b=MdeJFSNZpxAufGtM6jEzn4aQIRpm55UG2FKp1Jk9noQIGEfl1cm9+O23Wr7ZJT9oFf
         sCMlKstBTFPGfv3Q5FTpmT5W27Qhz0/qAncLWE3gCQTBEDVDyKBaDmIZs0eoS7iN5yJd
         9Xnu1qreJf8OuHvUofmtaXgA40vKfhXz6RVXCqRNcMDU4Bxx6OYyhiMjpaRlcJ29nmR/
         g414pfbMgaOLL6Fv5a4yQF4ykcRzPl8nzsThZCL8CGmrJsnQ1C7XwZF4YOXMzKl+i3xw
         ESYWqsgd5SXelyWOvc1sE+Gs2W9LXeWTeNq9FXwsmmYfTZhQ9s13MhqLToJmHI4Glvuy
         vHYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710353268; x=1710958068;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oMXTFuaRy2/DahWa3k1XzhwntrhYB+tFZxVYLm3/Iu0=;
        b=u2riYneU3jiasEdiboL6N9sPg9nPka3oDVjz9Z7KvC9QZT+TUio1hgREMqnIji3tSN
         A36kKQC2DfJHK58bET1TGWbOCHZHlQccggK2U6Uq1p7ETnNyc2MrUpsT9vROTlzD4vSO
         gx74dRD7iCbwjSv6fZbh1vDRcgeI9oQHgkLt/HGuHqaK+gbjmj7jlIQAVBiJOxPhO7k0
         U6d+wMVlKVefLV/FhuEXa3WLYTARxXoDkpk0sqGBJ4XfKladE5asBEfV6DuKKKK+I4BZ
         E1Jq/BqPBxj1mQEHDnqHIOyVh3BXgyUGmbLJ3L+Nw28MY4dL3YaRRRZX88MVe8frXcde
         m19A==
X-Forwarded-Encrypted: i=1; AJvYcCW1pc7cRGotD3GMq4OU7vyfFNCrew6v8MNOwxLRkvDH4IaUIrCJgn529MS5OeIR74M/iGxnqosF2KHYSXsXJJIHUkoq8z+fhqjs8anC
X-Gm-Message-State: AOJu0YyBFSfjr/FOxEPdW4JmWRjt1xIZhi+MEgngs2UubVy54gFJKN72
	kyB/0TwIAbL7tAp/bD9gDOFvl2XzKcwmTcd2NEsLnIUT0gk4zNXJpThdHzsw05Q=
X-Google-Smtp-Source: AGHT+IEiATRc7GICOzHn/pmaYtsR17HXLdNvPrWgb7fWYxoAe+7+fLoFXGr/dxWbtiPy38J6/6/nCQ==
X-Received: by 2002:a17:907:9918:b0:a45:d040:2a2f with SMTP id ka24-20020a170907991800b00a45d0402a2fmr7695229ejc.29.1710353267621;
        Wed, 13 Mar 2024 11:07:47 -0700 (PDT)
Received: from localhost ([102.222.70.76])
        by smtp.gmail.com with ESMTPSA id h27-20020a170906399b00b00a3ce60b003asm5124787eje.176.2024.03.13.11.07.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Mar 2024 11:07:47 -0700 (PDT)
Date: Wed, 13 Mar 2024 21:07:43 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Eric Anholt <eric@anholt.net>
Cc: Florian Fainelli <florian.fainelli@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Arnd Bergmann <arnd@arndb.de>, linux-rpi-kernel@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org, linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH] staging: vc04_services: fix information leak in
 create_component()
Message-ID: <2d972847-9ebd-481b-b6f9-af390f5aabd3@moroto.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

The m.u.component_create.pid field is for debugging and in the mainline
kernel it's not used anything.  However, it still needs to be set to
something to prevent disclosing uninitialized stack data.  Set it to
zero.

Fixes: 7b3ad5abf027 ("staging: Import the BCM2835 MMAL-based V4L2 camera driver.")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 drivers/staging/vc04_services/vchiq-mmal/mmal-vchiq.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/staging/vc04_services/vchiq-mmal/mmal-vchiq.c b/drivers/staging/vc04_services/vchiq-mmal/mmal-vchiq.c
index 6ca5797aeae5..4c3684dd902e 100644
--- a/drivers/staging/vc04_services/vchiq-mmal/mmal-vchiq.c
+++ b/drivers/staging/vc04_services/vchiq-mmal/mmal-vchiq.c
@@ -939,6 +939,7 @@ static int create_component(struct vchiq_mmal_instance *instance,
 	m.u.component_create.client_component = component->client_component;
 	strscpy_pad(m.u.component_create.name, name,
 		    sizeof(m.u.component_create.name));
+	m.u.component_create.pid = 0;
 
 	ret = send_synchronous_mmal_msg(instance, &m,
 					sizeof(m.u.component_create),
-- 
2.43.0


