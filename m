Return-Path: <linux-kernel+bounces-146150-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 946918A615B
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 05:16:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 51267282E04
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 03:16:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9C381799B;
	Tue, 16 Apr 2024 03:16:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YJ/z2i7J"
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5A53156E4;
	Tue, 16 Apr 2024 03:16:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713237373; cv=none; b=rkJjDKDw0aTYf3KSWyNufD9gQHtNl36fwjoG5Qo9jG1TYqPfwBC2XyPedrpmjQ0zkjSo3NsC9ZKjS/LbFTFRa5thvcaXKW9c+TQtHmCyYG6xy/dmhub3z0Mwsw5/cvapoK8c3uBYon7GNxSXz1xNl3Fr++cdorawCGPvw2qKLGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713237373; c=relaxed/simple;
	bh=B3BEeQqzlf4FZKveKyo0QpREp7f6dmwUHp30YnzGYyQ=;
	h=From:To:Cc:Subject:Date:Message-Id; b=FibeztqYlKaz4OFeCzM3eR2dOP/a9Z2GXYR5XygfAtYuO2AJR4mm+JrT0ycvKY58UXkG2UIIQeUJz9BVw+HDMxb6c/kaOKBIz6+9qRwkawcLV+RPNpVs28Co7+dOatiDRt0Gam+Z4TKuWAbeUJWuts1BGopxAHHJJDWTcqvhqqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YJ/z2i7J; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1e4c4fb6af3so21278255ad.0;
        Mon, 15 Apr 2024 20:16:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713237371; x=1713842171; darn=vger.kernel.org;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vkzqh0jNf3IiQKrXTxkpy8kUD3tILL0aPn6146+WbnA=;
        b=YJ/z2i7Jx4GuAaXesYZ80KqXxG70nzFASTZEjfriIr3kKedT6xyVvSA/UwFLf5EEIw
         fL6vJlClHvL0pdrMMTE6v3WRQtEAbq7Hd8Kl+ChJgPaY4T5wkEnfWMM1Gr5mjoUNCkZU
         zGhnjCCuAiP3s54Lj+85KxyHlr+swaJCRPBpuApsAQS2jSb55i9EAbQqOGXADPjcDno5
         OT2QdFSyxEt6xICCeALT5YBHG+TooDskm26iUD5VgLZCihPYVg/I4wZ5wL5Ub81uQxCZ
         t4/cAD15xQZ0WKOTAX70aHO4O31vbGsOOFcWtkORT2luQ5vz79u6sPbjZUmxrZWtXa3h
         Rngw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713237371; x=1713842171;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vkzqh0jNf3IiQKrXTxkpy8kUD3tILL0aPn6146+WbnA=;
        b=LH2XLRktl/a156md+O9Xb+VevEnXGg3ZUn7d+2oUsnQp8XoMjDV4bxr6NMVbIrrUyO
         D0+ZEBG5bsvaiIqEw5SUkT5RXc9bSSI/zDwBRei9kbHWdLlId1TlGj4UCFwtWzRnRxat
         S2m58kVyTfMM8lv5Lsyuea1zn4f3vrwfzrHnnDTOcCwtWPfrq1PiJ8lQDgIq7XN1WfkZ
         5TEhkkfSkpCLCP6ezfVZZisURYiIAfJf1goekEXQBG/V722Ojva5f/NPSBE4/IfyaPpv
         Dpootja5UwCKUZ1qow058fG3v3JvEKUCgjNnZ0kZAS+vykgEsiR83JgRi3MbicHQTDdr
         5p3g==
X-Forwarded-Encrypted: i=1; AJvYcCXRJrcVJ90yQJ0be+35IKMjpbUnWDRlvPcHerQXRg7OLbwBLO5DO2lVbwLskIbeeONxypvLtwT1BUHkH8kSqfIliAUUWA0gu2dqxoBhIE1zfjyJCGYdA0Jx3Q+ScOU5KkSGlNXe/9agXkQM
X-Gm-Message-State: AOJu0Yw55GBvlYa608q/uBdDm76GKeuQ69dRFGnJ0dGdWZ2s1PGnJskM
	xOvAZWwIB+DB/VZqlSZwiUCWChHXESFMMqe8yEMr3GLn/YftEqWMFU3KZQ==
X-Google-Smtp-Source: AGHT+IHSIjAivD3fuCRu8S3x6WqiHOYqcW39EQUhx8cIBtuh1xObkH/0VJ0EScu8OF+u+nXFp73CgQ==
X-Received: by 2002:a17:903:2450:b0:1e0:b60f:5de3 with SMTP id l16-20020a170903245000b001e0b60f5de3mr1335314pls.7.1713237370958;
        Mon, 15 Apr 2024 20:16:10 -0700 (PDT)
Received: from localhost.localdomain ([43.159.199.34])
        by smtp.gmail.com with ESMTPSA id j13-20020a170903024d00b001e1072382a1sm8640310plh.142.2024.04.15.20.16.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Apr 2024 20:16:10 -0700 (PDT)
From: Guanbing Huang <albanhuang0@gmail.com>
To: gregkh@linuxfoundation.org,
	andriy.shevchenko@intel.com,
	rafael.j.wysocki@intel.com
Cc: linux-acpi@vger.kernel.org,
	tony@atomide.com,
	john.ogness@linutronix.de,
	yangyicong@hisilicon.com,
	jirislaby@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	lvjianmin@loongson.cn,
	albanhuang@tencent.com,
	tombinfan@tencent.com
Subject: [PATCH v8 0/3] serial: 8250_pnp: Support configurable reg shift property
Date: Tue, 16 Apr 2024 11:15:57 +0800
Message-Id: <cover.1713234515.git.albanhuang@tencent.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

From: Guanbing Huang <albanhuang@tencent.com>

The 16550a serial port based on the ACPI table requires obtaining the
reg-shift attribute. In the ACPI scenario, If the reg-shift property
is not configured like in DTS, the 16550a serial driver cannot read or
write controller registers properly during initialization.

To address the issue of configuring the reg-shift property, the 
__uart_read_properties() universal interface is called to implement it.
Adaptation of PNP devices is done in the __uart_read_properties() function.

Guanbing Huang (3):
  PNP: Add dev_is_pnp() macro
  serial: port: Add support of PNP IRQ to __uart_read_properties()
  serial: 8250_pnp: Support configurable reg shift property

 drivers/tty/serial/8250/8250_pnp.c | 40 +++++++++++++++++++-----------
 drivers/tty/serial/serial_port.c   |  7 +++++-
 include/linux/pnp.h                |  4 +++
 3 files changed, 35 insertions(+), 16 deletions(-)

-- 
2.17.1


