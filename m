Return-Path: <linux-kernel+bounces-63425-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CA84B852F12
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 12:23:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5B64FB260C1
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 11:23:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56891376F7;
	Tue, 13 Feb 2024 11:21:36 +0000 (UTC)
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 513935024D;
	Tue, 13 Feb 2024 11:21:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707823295; cv=none; b=OOde2Ty6S7hWl27BKfi2DBxjiqWIC0ORTS4buefbtxdrbOEbpq1wWn7aROTNW70XsMi2Eno7otMGvF5ebIyOPYv7vLSTTCZDLrtKGP+2EaLELc6uRSsubJe5TNdpD8ZR3+NVGaL+f5gZF5ckz0mvRARCeInSKMc4q88Pw8k0RQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707823295; c=relaxed/simple;
	bh=fFSNniLAWkf8c0MLxnowmolHEKH0061HIh1s461qREk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=kCbdlwDqQNzR9bnqCJ0jgV+PIQU0cMENepp+273UTTCAo2UfPDF+MZaqL1t9/1blYZ+hM+92JfaSRF43jbVaHiaeksmqQG7B9O3q14noLXYcPrTm6dctaNM92IPKrlWQSVrkw0XQ6fxHw1oVUs27b7jLyWTZt3U8B1swM0yyGnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-56001b47285so1111788a12.1;
        Tue, 13 Feb 2024 03:21:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707823292; x=1708428092;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9sNntIU4CURpyJ9gZt8pV5lbH5nP3yXgLrEWL6ezzCM=;
        b=c4Z2sb0bNKiXuhHffITJeWOTcD7FRIB+8IGD8XLc3uZcVnpFFONmqBXR+AIq09x/pg
         qx6jOLfJfGRe5HfOFDRKt75oaum7grV3fLVOzjqfcVpUpKgG9HSNqOEMTdKxGMKqpzvN
         rDTji29f0c3088dvkb62bfqukHX9t0OS8C0m3UCGGkgW/sbKx4iPR6mjsxi7sW62RZf4
         xT8Hmp2+aMsNs6FcCduqLknDkZ9MqRs7qbtB+gmSdDJacUODaboL4QlOMofjKHyv5OQW
         drDMoL9zwBJ9rvNighU6ZwQYsPE8n4gocIYe6SnnmLD6w5JjpQxZ9D1OgxHJ86SeBPOM
         6Xzg==
X-Forwarded-Encrypted: i=1; AJvYcCVBdpVCTbSx2fDFHRXVNHolaiVkCdB6Pqa0HZotZTeEPAIJeCWaUJfWK2ioGaJ82Bb2PsNxJZGtaJ3jH1MgVPdN3w1HgqYWExNRDpC8
X-Gm-Message-State: AOJu0YzCq2Ye+TP8mV23ghqCOxrZ+MKXSLKS/Kw74QHQ6G7ZkQ8jflWO
	g8MsYIvPq0qkv04VxmtR0VcYBrczk1Uk8AO2DlEzhJW4IMQ9bEV5
X-Google-Smtp-Source: AGHT+IEFNitBssBTvRVkcz1/ngcmTnrvzd4K6a2RmJN/HJ9aJOL4qLFJGXnRJL1SXbva7+EllrnVSg==
X-Received: by 2002:a17:906:3489:b0:a38:3428:2548 with SMTP id g9-20020a170906348900b00a3834282548mr6341674ejb.42.1707823292266;
        Tue, 13 Feb 2024 03:21:32 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWX3vzRDuyIT6Z+tWKZW/IUH/LSWLqEpU5rqkS9GOMVnmu5u4J7YR5bgSaxzoUF3oMyIgLk0aDc50fivtFCGEiRwQckEPKvIvhjiAM50vEyFUI3+yNW1LrqY97l69akBPriHMbwifdbQNdozJIGiFK5zlIv/XezjBwHGa3r6ywvD+QZjZwCIHLxXi0KTI0JfezMSYbbvD/4o5wf6w==
Received: from localhost (fwdproxy-lla-008.fbsv.net. [2a03:2880:30ff:8::face:b00c])
        by smtp.gmail.com with ESMTPSA id gr3-20020a170906e2c300b00a3c10026c94sm1197991ejb.20.2024.02.13.03.21.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Feb 2024 03:21:31 -0800 (PST)
From: Breno Leitao <leitao@debian.org>
To: kuba@kernel.org,
	davem@davemloft.net,
	pabeni@redhat.com,
	edumazet@google.com
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	horms@kernel.org
Subject: [PATCH net 0/7] Fix MODULE_DESCRIPTION() for net (p6)
Date: Tue, 13 Feb 2024 03:21:15 -0800
Message-Id: <20240213112122.404045-1-leitao@debian.org>
X-Mailer: git-send-email 2.39.3
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There are a few network modules left that misses MODULE_DESCRIPTION(),
causing a warnning when compiling with W=1. Example:

        WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/net/arcnet/....

This last patchset solves the problem for all the missing driver. It is
not expect to see any warning for the driver/net and net/ directory once
all these patches have landed.

Breno Leitao (7):
  net: fill in MODULE_DESCRIPTION()s for xen-netback
  net: fill in MODULE_DESCRIPTION()s for ieee802154/fakelb
  net: fill in MODULE_DESCRIPTION()s for plip
  net: fill in MODULE_DESCRIPTION()s for fddik/skfp
  net: fill in MODULE_DESCRIPTION()s for ppp
  net: fill in MODULE_DESCRIPTION()s for mdio_devres
  net: fill in MODULE_DESCRIPTION()s for missing arcnet

 drivers/net/arcnet/arc-rawmode.c  | 1 +
 drivers/net/arcnet/arc-rimi.c     | 1 +
 drivers/net/arcnet/capmode.c      | 1 +
 drivers/net/arcnet/com20020-pci.c | 1 +
 drivers/net/arcnet/com20020.c     | 1 +
 drivers/net/arcnet/com20020_cs.c  | 1 +
 drivers/net/arcnet/com90io.c      | 1 +
 drivers/net/arcnet/com90xx.c      | 1 +
 drivers/net/arcnet/rfc1051.c      | 1 +
 drivers/net/arcnet/rfc1201.c      | 1 +
 drivers/net/fddi/skfp/skfddi.c    | 1 +
 drivers/net/ieee802154/fakelb.c   | 1 +
 drivers/net/phy/mdio_devres.c     | 1 +
 drivers/net/plip/plip.c           | 1 +
 drivers/net/ppp/bsd_comp.c        | 1 +
 drivers/net/ppp/ppp_async.c       | 1 +
 drivers/net/ppp/ppp_deflate.c     | 1 +
 drivers/net/ppp/ppp_generic.c     | 1 +
 drivers/net/ppp/ppp_synctty.c     | 1 +
 drivers/net/xen-netback/netback.c | 1 +
 20 files changed, 20 insertions(+)

-- 
2.39.3


