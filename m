Return-Path: <linux-kernel+bounces-36147-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B9821839C3F
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 23:31:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 71531284640
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 22:31:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3BC453E06;
	Tue, 23 Jan 2024 22:30:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="V8FXcH7a"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF0E547F5D
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 22:30:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706049044; cv=none; b=FHvXC4RfaVax5Bt3LJDnB1QlFC6WaL0QeDB56s7ORu+VZFXSk5ghIZFi2uTOrKve5DHUwTkhk93ikOw9IcUzIRoMeTvgGFm4GABi0Lg6l6HkpmpAAzfFwraMCMP+wDqxy5/ekPHvl3VtrhHTeHYW4Jc/SAk/ySCIKz9D4VIAxHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706049044; c=relaxed/simple;
	bh=dBBITS9FO1ji6Tbp5hcqIAnNiL5zxOzeCbOePyJkuP0=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=E4u/SMAXZrmjG9ZRDbhWSn7dT9hswmDovElbjkr7Kbja5KoEKFLxFf8j6RktIPar3Uk7VNBUJG77AKsbqMZU2TP2BfMbqFO8ibKMvD8bwt9IHXwU7HL6sEfk2bJIFBX9VdJMTQrHkcqaGbn0j3vmE8qFM8vBa5HtyyJIy1eCs1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--abhishekpandit.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=V8FXcH7a; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--abhishekpandit.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6002a655cc1so28016307b3.1
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 14:30:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706049042; x=1706653842; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=7Qx2jISN6WbjojC2jV3q1VojHLOX1qD9aHNvqQ5ekZs=;
        b=V8FXcH7anTrlVocZYTCZjJONtNctJdbTUssOyzVr9S3UZP87bOHxt2soQSH0mBrAgg
         a1oK2f/rpobrSj6WNqgbT1rXlkm/F+EsCRq4cZFVdH7bFVNMpXpiyObLOkqkP6tXiQHP
         E4VtpJ5bglpEUYtHbWI1TN/kJr653xu6yOYKdF6Yr/AUrMAGKadoN+2IZl76Vyj5IiPD
         vVKRiVrXAKXcjpnMwHBifAx9y/qLZj2CfTT67y3svCv2oh6q4sktdusami6IN2p2GfEv
         B5R2SGPC3fw25MsqM3/NWXdcI+qwTVJIe8WbH13UKdUHp8X2xZy7FVZI3iTqg+cqMFi8
         DryA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706049042; x=1706653842;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7Qx2jISN6WbjojC2jV3q1VojHLOX1qD9aHNvqQ5ekZs=;
        b=vHAyXjeeD7hNjQYKSZVCfZL4P95FvRJTjUk4TIWRWVm5bTjj/DBmuWa2AkaDf4i+kH
         ND6Uma5l7a33b0n66OcdXPlraBuJgw3la38BEDXAyGxgXN/T69FdU0UWr7l0zy2OOC9c
         k24AaP0evH5teS8rtFoLS2fUiv48JTD/yENCYXp6uRB6CuJrF+yTf1EJUzhDlw1kdRQB
         v3fwL5DpzWWJKuF3j+avYAokk122xnkBITdNX76L1H0kvho/WfsgYmy77SIwRdOEkTiP
         kix0llgLtyOW/he7lrnv+xCG8F1uncfgyASxcnxsXVS0ufpXTMy9pmO1RV7fd5fQtXXS
         XZ3w==
X-Gm-Message-State: AOJu0Yzg6+XcpCiQIHoYvOegLoQXRsDJ7KMlZUoJJUZhARYa/UEi9Clq
	c5k86fHbEcssIfPvKybAPfwKckGeTevUYOkDQB+bH7LnEk/Nr5GyNsLHRGrfpbvQ4r0nYBmkb5+
	aYveaZC2hvpkuABs9HWI++GPYPnou/wgxjg==
X-Google-Smtp-Source: AGHT+IGB0F14i78ehb8w+zWgRrzyyfOpVdBqKCpsudDfRkcBT5koahQk3yhFjaWF/gkifa7DHHNjaC1N+vTFW3RUI5WAvw==
X-Received: from abps.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:9b4])
 (user=abhishekpandit job=sendgmr) by 2002:a81:48c4:0:b0:5ff:5135:ffcf with
 SMTP id v187-20020a8148c4000000b005ff5135ffcfmr2338544ywa.4.1706049041923;
 Tue, 23 Jan 2024 14:30:41 -0800 (PST)
Date: Tue, 23 Jan 2024 14:30:33 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.43.0.429.g432eaa2c6b-goog
Message-ID: <20240123223039.1471557-1-abhishekpandit@google.com>
Subject: [PATCH v1 0/3] usb: typec: ucsi: Adding support for UCSI 3.0
From: Abhishek Pandit-Subedi <abhishekpandit@google.com>
To: Heikki Krogerus <heikki.krogerus@linux.intel.com>, linux-usb@vger.kernel.org
Cc: pmalani@chromium.org, jthies@google.com, 
	Abhishek Pandit-Subedi <abhishekpandit@chromium.org>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Bjorn Andersson <andersson@kernel.org>, 
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, Fabrice Gasnier <fabrice.gasnier@foss.st.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Hans de Goede <hdegoede@redhat.com>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Saranya Gopal <saranya.gopal@intel.com>, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

From: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>


Hi Heikki,

This series starts the work adding UCSI 3.0 support to the UCSI driver.

There's a couple of pieces to start here:
* Add version checks and limit read size on 1.2.
* Update Connector Status and Connector Capability structures.
* Expose Partner PD revision from Capability data.

These were tested against on a 6.6 kernel running a usermode PPM against
a Realtek Evaluation board.

One additional note: there are a lot more unaligned fields in UCSI now
and the struct definitions are getting a bit out of hand. We can discuss
alternate mechanisms for defining these structs in the patch that
changes these structures.

Thanks,
Abhishek


Abhishek Pandit-Subedi (3):
  usb: typec: ucsi: Limit read size on v1.2
  usb: typec: ucsi: Update connector cap and status
  usb: typec: ucsi: Get PD revision for partner

 drivers/usb/typec/ucsi/ucsi.c | 51 ++++++++++++++++++++++++++--
 drivers/usb/typec/ucsi/ucsi.h | 64 ++++++++++++++++++++++++++++++++---
 2 files changed, 109 insertions(+), 6 deletions(-)

-- 
2.43.0.429.g432eaa2c6b-goog


