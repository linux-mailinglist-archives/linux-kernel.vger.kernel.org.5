Return-Path: <linux-kernel+bounces-126755-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A521893C52
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 16:44:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CB41628149B
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 14:44:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B82644367;
	Mon,  1 Apr 2024 14:44:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fireburn-co-uk.20230601.gappssmtp.com header.i=@fireburn-co-uk.20230601.gappssmtp.com header.b="eDBMJ9WP"
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF1C941A8F
	for <linux-kernel@vger.kernel.org>; Mon,  1 Apr 2024 14:44:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711982677; cv=none; b=Dkw9UueKgvFNlXrropeLeD5aGOq7KZJ+NJQweue7wtxglkBMhhVIQ5ITmDNopLvKuEy3xmAAGx0nChVek/AInuX8LZ/kFXkZpvaaQBmhvudjAOnMl2sZXYbn8ytOwwaY16ToLRR8v58mXPeMSoVZhKSqW+h0mEq2eEmaZCO8OXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711982677; c=relaxed/simple;
	bh=bRVD+zYXwsd5blv6Xf8Xegw7LTvgK3LiOS69WsxaHgI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jIHs0Q92k+7ZQ1WZaVr+qxkg1vky6CVHqW6KBfP9hlUN774yPdSVbjNUGUe1JnIJBIn8EnBuhzMdTUHy/0xXo8VonnTB4S3K00dE6YepKo5+kMSGRRMoM4UovTi1TVxn8n2E6286AHJQCiLZvH143umcgTEnvDipfne4fH6I910=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fireburn.co.uk; spf=none smtp.mailfrom=fireburn.co.uk; dkim=pass (2048-bit key) header.d=fireburn-co-uk.20230601.gappssmtp.com header.i=@fireburn-co-uk.20230601.gappssmtp.com header.b=eDBMJ9WP; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fireburn.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=fireburn.co.uk
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4156e0cffdaso1586375e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 01 Apr 2024 07:44:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fireburn-co-uk.20230601.gappssmtp.com; s=20230601; t=1711982674; x=1712587474; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2RvYbbHjPyiORsf1A18YXo9DewRsvfmOj39Pus78xSY=;
        b=eDBMJ9WP/ekqywe8ArRLsXLvk7daBoCdGDwV7MXodNSOwjvw0TcWqPCC8M81iGtqgR
         NczYaYjsJif3pRJoYGxNCHu03JkGmblF69Wce5CEVrphPa3iknEFMS6Wjmj2OfksEX7m
         btlSClMvCkB5o4X9NqoUzq1o0b2zxo46J+a94H4LGWEDL7HniJEEZVFso/iYbs8+8uCW
         oq6BbhmF2FQbhg8qAD6wUO6HOvURcWfxtvksoFsXrEvqgW5/8l+hm6faNEq7g4VVclJ1
         rXnBT9Mo9/42z2ylHfTQYAUVM6Vp5Veiy/oljbLe3l6kF5XZ7BSkdFBFwJ9K3S8+3ADq
         GjsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711982674; x=1712587474;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2RvYbbHjPyiORsf1A18YXo9DewRsvfmOj39Pus78xSY=;
        b=QYnY60K+yvhQ41B2Nh0yioxcvZFJ/E+2WaO/5IuoujQ7VedbfidZt99h0CzQ26+yWs
         2D6484vwEUod9kvhKIDZOOZ7tGsE6CzLHDIdd8nLwfEt6u4XZ9ox7mZ0eIIkC1LTYnNC
         xH9hpBNMNL3lzZKzdd4HlB/Crr5Z/0KEwvw8wvoQRN0RMRHgsylUkd0McsXbE+uUXnfy
         HEDklfaFShLWnK3fQNoXRv9WM4eLdxKIAQCa+rIw0zsgXAaOOYaMlX25xPRs1uHf+gyQ
         jCSKYPDIapMcEIbwQ82okMYp0TXhYtWcrfnK0Y0wB8927DtE7MsKxTdzB5GFW7nEUDzy
         8T9w==
X-Forwarded-Encrypted: i=1; AJvYcCVVlLLikrbAFYuaqDwKlWNt7uhKq+INV7UoWdwCK8fQd1wBFqrU9M3bStj+k7FY+QmqaiKcZYoEKOn8Rl8dOotZkSE/pvCQFknBXE7H
X-Gm-Message-State: AOJu0Yw/dTpsDecw5Bt2d2p2klUdk4n+IUZZ5tM+vu3hNDfTCTBMjEhq
	M/q7AENMen/TM+uoFITKyTzUzkZTywTMWUoVqgjdoaDZunECtFchJExucOdFog==
X-Google-Smtp-Source: AGHT+IHFwTeHa3eLF0iSWmR3ZRa9CNqiw+F/uWJvheTXNwpRf9+4QL+uhvTDDxHrRzI6a2UhU6K3YQ==
X-Received: by 2002:a05:600c:35c1:b0:415:6b9a:326d with SMTP id r1-20020a05600c35c100b004156b9a326dmr1118098wmq.4.1711982673860;
        Mon, 01 Apr 2024 07:44:33 -0700 (PDT)
Received: from axion.fireburn.co.uk ([2a01:4b00:d309:1c00:cf6f:1e76:917a:6efb])
        by smtp.gmail.com with ESMTPSA id bi11-20020a05600c3d8b00b004156c8d0530sm1258026wmb.13.2024.04.01.07.44.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Apr 2024 07:44:33 -0700 (PDT)
From: Mike Lothian <mike@fireburn.co.uk>
To: peter.tsao@mediatek.com
Cc: aaron.hou@mediatek.com,
	chris.lu@mediatek.com,
	deren.Wu@mediatek.com,
	johan.hedberg@gmail.com,
	linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	luiz.dentz@gmail.com,
	marcel@holtmann.org,
	sean.wang@mediatek.com,
	steve.lee@mediatek.com
Subject: Re: [PATCH] [PATCH] Bluetooth: btusb: Add support Mediatek MT7920
Date: Mon,  1 Apr 2024 15:44:24 +0100
Message-ID: <20240401144424.1714-1-mike@fireburn.co.uk>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240304144844.2042-1-peter.tsao@mediatek.com>
References: <20240304144844.2042-1-peter.tsao@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi

I think this patch is cauisng issues with older firmware

Bus 003 Device 002: ID 13d3:3563 IMC Networks Wireless_Device

[    0.315064] Bluetooth: Core ver 2.22
[    0.315064] NET: Registered PF_BLUETOOTH protocol family
[    0.315064] Bluetooth: HCI device and connection manager initialized
[    0.315064] Bluetooth: HCI socket layer initialized
[    0.315064] Bluetooth: L2CAP socket layer initialized
[    0.315064] Bluetooth: SCO socket layer initialized
[    4.670811] Bluetooth: RFCOMM TTY layer initialized
[    4.671029] Bluetooth: RFCOMM socket layer initialized
[    4.671790] Bluetooth: RFCOMM ver 1.11
[    4.673416] Bluetooth: BNEP (Ethernet Emulation) ver 1.3
[    4.673659] Bluetooth: BNEP filters: protocol multicast
[    4.673895] Bluetooth: BNEP socket layer initialized
[    4.674125] Bluetooth: HIDP (Human Interface Emulation) ver 1.2
[    4.674360] Bluetooth: HIDP socket layer initialized
[    5.016365] bluetooth hci0: Direct firmware load for mediatek/BT_RAM_CODE_MT7961_1a_2_hdr.bin failed with error -2
[    5.017163] Bluetooth: hci0: Failed to load firmware file (-2)
[    5.017557] Bluetooth: hci0: Failed to set up firmware (-2)
[    5.018129] Bluetooth: hci0: HCI Enhanced Setup Synchronous Connection command is advertised, but not supported.

The correct name should be mediatek/BT_RAM_CODE_MT7961_1_2_hdr.bin

Reverting this patch fixes things

Cheers

Mike

