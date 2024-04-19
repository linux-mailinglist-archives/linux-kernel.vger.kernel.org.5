Return-Path: <linux-kernel+bounces-151969-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F7848AB659
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 23:18:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0B3DC2813B9
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 21:18:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D364913D270;
	Fri, 19 Apr 2024 21:17:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sHjgkPNT"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D820983A0B
	for <linux-kernel@vger.kernel.org>; Fri, 19 Apr 2024 21:17:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713561457; cv=none; b=uScRZN08AiCfIbHZFngUdY/WsYsxowh0yJSxaWEnNTyAZdyQ2zMe4Fn1ROHVaN8Du8bctdJGbb6uEfx6gLkmJXoSrJVv54j0JSVfF9g5AQbPhdcvcYVol+66jQ7su68H50Cs63G7SaSBnXzI/3yAdiQR3Fq4WMS8LJEkRQXR0Uk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713561457; c=relaxed/simple;
	bh=P0P2LNQRmDYCC/aEgFub9LeFI6oVcHO/6OlaFAuYLpc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=qc6zIcnz2pIWrLFmarmIrzQT8W9QWtIQSu3e5e//rS3MurH5AyM0oG0SSeNKKfSTulByBFoLs5yh7kQ2q9tEFSM6pEiRdvUIJ0mssIK6h/85s4KL+gU0HyoYlMQtXpVACSIAAYqKNDl4T1T7Bk7poGXDFtWCFpHMz5YlrTqBPD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jthies.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=sHjgkPNT; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jthies.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-61b36187e6bso12891027b3.0
        for <linux-kernel@vger.kernel.org>; Fri, 19 Apr 2024 14:17:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713561455; x=1714166255; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=g+Cg+N/7bN9qoM+g/2vlu/SplO5LfLDY99wfjzIBp0k=;
        b=sHjgkPNTFSThpZGRNlrZv7HSNMBZWV9nErVh3B/UFixB1yfiiXryY8EbpAPNgqM/uL
         HO6FDxRPrXufZQ727IkEB/zjIU+PdYcnagxuXrufZQsahfRex8cAqN69qCoQw1zbq/64
         kRIco2ZdCXtFrOgvoSI5UpHwJP7acKEIc+e9eoWY1ESp5Gm2CfSUEp4Lx/mVZH94m52/
         dkZ3on5QC3qxBpIZydiLR2aOndLUV0ls8hyysrQPG0v6sjKo9ADAme/xzF78gqKbIXmE
         QwKfP6oB1N3owMuju1v4Qe2Kxi/SqCsFN3GrYgNu4+8F+9S00n0c+uYReueCbLDIwTWV
         sHBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713561455; x=1714166255;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=g+Cg+N/7bN9qoM+g/2vlu/SplO5LfLDY99wfjzIBp0k=;
        b=VENk223IPPzNvW03zCWsLVWZyc5O+bwyVkco8hDQQaPZYiM0s8wlHS11SJmNvyAxpk
         URTDxfKaRTK2yQIxeyhif8lXpRdBncX5pWQpAnYX2SdXwoNZIhIHPI3t7Kb70IebtBMN
         cAPovzqeCv2aomzxeoPUeDCq8alhnY0BsaJLCZf/xJYkKZ9qCgcZND0zL/kpCKG21wug
         /KuT8IgvqSd98vYkqFjO4ddtedazbZD5zqb40xhixq4JO7L4reQ+PZVnJbdpZqexXbJm
         Zrw6Qr759usJNO68V9IzBuFgk6ed7p2Tdy4x6CHAy3nPPzQrVYR83jT0HvNIv8PsisLn
         slBg==
X-Forwarded-Encrypted: i=1; AJvYcCWOilOajRvjvpSDzoGdkLtabA2kHH65X4CYdFYd2y7sOsKIGmKoiB02keEtFoqiRdwVgSE/Ii1jg+EUK08v52FFdrLh8rmgaX4aXIqN
X-Gm-Message-State: AOJu0YxTV8FxAMWgCwna782Xbm7Lxm9TQTXfbaQlq48hBx2a3gDRFCAl
	I2zZ6seRJLxclyk041LXgQe6gA8Qf/ks8SkitvM5U6hN3InNsd+xz7BKIAhB8fzkuORMPcG74EH
	ntg==
X-Google-Smtp-Source: AGHT+IEvG80FpBSTMrUyNa+jaRsdc9P1PtKc0Ymjy1JxePfxLENwQ1kn1BBI/itnoi5SmdtePMi9pOy1jYo=
X-Received: from jthies.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:23db])
 (user=jthies job=sendgmr) by 2002:a81:6e57:0:b0:61a:d420:3b57 with SMTP id
 j84-20020a816e57000000b0061ad4203b57mr873351ywc.0.1713561454867; Fri, 19 Apr
 2024 14:17:34 -0700 (PDT)
Date: Fri, 19 Apr 2024 21:16:49 +0000
In-Reply-To: <20240419211650.2657096-1-jthies@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240419211650.2657096-1-jthies@google.com>
X-Mailer: git-send-email 2.44.0.769.g3c40516874-goog
Message-ID: <20240419211650.2657096-4-jthies@google.com>
Subject: [PATCH v1 3/4] usb: typec: ucsi: Delay alternate mode discovery
From: Jameson Thies <jthies@google.com>
To: heikki.krogerus@linux.intel.com, linux-usb@vger.kernel.org
Cc: jthies@google.com, pmalani@chromium.org, bleung@google.com, 
	abhishekpandit@chromium.org, andersson@kernel.org, 
	dmitry.baryshkov@linaro.org, fabrice.gasnier@foss.st.com, 
	gregkh@linuxfoundation.org, hdegoede@redhat.com, neil.armstrong@linaro.org, 
	rajaram.regupathy@intel.com, saranya.gopal@intel.com, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Delay the ucsi_check_altmodes task to be inline with surrounding partner
tasks. This allows partner, cable and identity discovery to complete
before alternate mode registration. With that order, alternate mode
discovery can be used to indicate the ucsi driver has completed
discovery.

Signed-off-by: Jameson Thies <jthies@google.com>
---
 drivers/usb/typec/ucsi/ucsi.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/typec/ucsi/ucsi.c b/drivers/usb/typec/ucsi/ucsi.c
index b8d56a443531f..cd4c3b7a5d989 100644
--- a/drivers/usb/typec/ucsi/ucsi.c
+++ b/drivers/usb/typec/ucsi/ucsi.c
@@ -963,7 +963,7 @@ static void ucsi_pwr_opmode_change(struct ucsi_connector *con)
 		con->rdo = con->status.request_data_obj;
 		typec_set_pwr_opmode(con->port, TYPEC_PWR_MODE_PD);
 		ucsi_partner_task(con, ucsi_get_src_pdos, 30, 0);
-		ucsi_partner_task(con, ucsi_check_altmodes, 30, 0);
+		ucsi_partner_task(con, ucsi_check_altmodes, 30, HZ);
 		ucsi_partner_task(con, ucsi_register_partner_pdos, 1, HZ);
 		break;
 	case UCSI_CONSTAT_PWR_OPMODE_TYPEC1_5:
@@ -1247,7 +1247,7 @@ static void ucsi_handle_connector_change(struct work_struct *work)
 	}
 
 	if (con->status.change & UCSI_CONSTAT_CAM_CHANGE)
-		ucsi_partner_task(con, ucsi_check_altmodes, 1, 0);
+		ucsi_partner_task(con, ucsi_check_altmodes, 1, HZ);
 
 out_unlock:
 	mutex_unlock(&con->lock);
-- 
2.44.0.769.g3c40516874-goog


