Return-Path: <linux-kernel+bounces-151967-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3064F8AB654
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 23:17:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DBC46281DE4
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 21:17:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA48512BE93;
	Fri, 19 Apr 2024 21:17:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Mjhy+zI4"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD8D5376F1
	for <linux-kernel@vger.kernel.org>; Fri, 19 Apr 2024 21:17:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713561446; cv=none; b=joKkYhUNcp6uUg6JTqG9Z4gA8iGwnMDR8dr2htcNvDrX0KIzrK5BFzCGm+Z4Cw+tbOXkU+hlXX9Ip3aVpO7G/cQJbFfD5VxCf9S0MNKmfddHSvYPYFXqvch8FE/Ty/HKwrom+qooLZe02kggFaRWntPiMoK/v9QxDOoeobbGexc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713561446; c=relaxed/simple;
	bh=mDPHK69wYhyI1FfUABhwE1NgNhFXTJrMPiHHx9d6gvg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ifbo2D/5rbR0b8vGHngMb7F7Vkm6NmwSRF6K0lmMfu9btXhr6jOVRo0m4PYa4Ea1knwdFLRR2OnzEQWJXKp+9bAp79dJC4KKhSiXNZKhzM0GMR+iIbNFHZgOnHWOWj2aCb7TvfgzU5S9Gkb5jMw6XDKwwKp9heWYw8CBRBCuiw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jthies.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Mjhy+zI4; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jthies.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6150e36ca0dso44186537b3.1
        for <linux-kernel@vger.kernel.org>; Fri, 19 Apr 2024 14:17:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713561444; x=1714166244; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=yBGw6IRcjqsdbe4TcZZGUlH3L2LlDwYUaWDl/kHQI0E=;
        b=Mjhy+zI4n+5UHQVACxUUQEfizihQpF8CIH5v6Yp7TqdsNItAinR81bXl2SKwuh6AAS
         ahsKzxJjCQjk5OVd+lLs1fS85OL8Wet+C8QVfZ850H/29ZmhQOMDo9mjZJclezF/P4ZJ
         76VOgZtA4KgUV5OtU31YIySuD2ShlkWB5cZTK9Z3Q0vKabxehBudAkIqy42IAYU9sNzf
         Yo/AMNnh5hwCwwV8LUe3ag//Hwmw5etuKEeaZIy50A9OgqkTukvx3CHCPPqs+miHaaHL
         88kbHDqatNcqVJgIcrv7CGXkdh9/y8O6Ws1h0XoJxYyLgDa/vdmK7fwgFKhFX5xKK09G
         3qUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713561444; x=1714166244;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yBGw6IRcjqsdbe4TcZZGUlH3L2LlDwYUaWDl/kHQI0E=;
        b=CRpGL0NQugX04kHIja7Vewy1WayMIlKIl7OkPgM8gok/EFT3nCbQcRQzCkwPpnoSGm
         +hmn+duveCDkEUj3buykbg8cSOHTZUQdwc9Y3HEuAcz5wP9flNBMn+MhI+IU6pE4edEJ
         ZwHy0v0GnwllIrrQx7qgIfkSzMVBSKT82c9K8xFdNkfLP1NLxVcCfd/RWg1PYVdJqMb4
         EJsFO7Q0ZYPkh+SkRwgt7tKd3V9Km+BySz3wIxrP+lYg3McNwpbvdl6j1AB6bSShshm6
         avzl2V5o2g0p3uKLCQJn7/0F5Mk3v1P3G7Y/wnjn2qbd2CqeHWC0a1tTTveblswJlWZU
         3JAA==
X-Forwarded-Encrypted: i=1; AJvYcCUWirVSmZYuxwfChPR6UvaMwNhFrAN18WpUTR6lj64WjhjwDWTa84JJ41/lF4Ste+DbYrxlAzL2EuAUQ/Y/TfWBm7CmXyhHlmkJ5ykD
X-Gm-Message-State: AOJu0Yw6P4i/H4ngjtXJozm+EGBFbLRKASEoenwxB/EUS/ajD5glTUEc
	JlIkA8e4rHbdINLkbg0wIwzMkCayyc3kOARt9oTnk3LlEcAPfb+8YyrsJRjIj/LTcZ7CSrRvYFQ
	wmw==
X-Google-Smtp-Source: AGHT+IHa/iUoYwwQNUd/ge6xGKK/Ez6VGJcdqFLzOtFRhJjk1L3/bnWCMW/ccXo73fFLE030j4quwTpOTK0=
X-Received: from jthies.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:23db])
 (user=jthies job=sendgmr) by 2002:a0d:dac3:0:b0:61b:4d3:2dd6 with SMTP id
 c186-20020a0ddac3000000b0061b04d32dd6mr503421ywe.6.1713561443742; Fri, 19 Apr
 2024 14:17:23 -0700 (PDT)
Date: Fri, 19 Apr 2024 21:16:47 +0000
In-Reply-To: <20240419211650.2657096-1-jthies@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240419211650.2657096-1-jthies@google.com>
X-Mailer: git-send-email 2.44.0.769.g3c40516874-goog
Message-ID: <20240419211650.2657096-2-jthies@google.com>
Subject: [PATCH v1 1/4] usb: typec: ucsi: Fix null deref in trace
From: Jameson Thies <jthies@google.com>
To: heikki.krogerus@linux.intel.com, linux-usb@vger.kernel.org
Cc: jthies@google.com, pmalani@chromium.org, bleung@google.com, 
	abhishekpandit@chromium.org, andersson@kernel.org, 
	dmitry.baryshkov@linaro.org, fabrice.gasnier@foss.st.com, 
	gregkh@linuxfoundation.org, hdegoede@redhat.com, neil.armstrong@linaro.org, 
	rajaram.regupathy@intel.com, saranya.gopal@intel.com, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

From: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>

ucsi_register_altmode checks IS_ERR on returned pointer and treats
NULL as valid. This results in a null deref when
trace_ucsi_register_altmode is called.

Signed-off-by: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
---
 drivers/usb/typec/ucsi/ucsi.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/typec/ucsi/ucsi.h b/drivers/usb/typec/ucsi/ucsi.h
index c4d103db9d0f8..c663dce0659ee 100644
--- a/drivers/usb/typec/ucsi/ucsi.h
+++ b/drivers/usb/typec/ucsi/ucsi.h
@@ -496,7 +496,7 @@ ucsi_register_displayport(struct ucsi_connector *con,
 			  bool override, int offset,
 			  struct typec_altmode_desc *desc)
 {
-	return NULL;
+	return ERR_PTR(-EOPNOTSUPP);
 }
 
 static inline void
-- 
2.44.0.769.g3c40516874-goog


