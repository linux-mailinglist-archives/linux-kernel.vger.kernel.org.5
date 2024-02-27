Return-Path: <linux-kernel+bounces-82872-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 31DC5868ADD
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 09:40:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5CEE41C21936
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 08:40:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57C3D12FF61;
	Tue, 27 Feb 2024 08:39:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QBuQLeCw"
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6975537F4
	for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 08:39:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709023194; cv=none; b=c+d6VUpfOQ14rBK7OHc6JcOc+DqI/mlC62aU6Xstygq23KaW+fcrVcGEK8VqSds86iICbVr6sYu2WKKy6jRLnWt3oxaMQIYG/MLyotfG5imCZd6wIQgP8McX2YgTpM+bD5LhuzelC9aUkMtTZMQ0ZwMB4TzWlgLLk4dwL7QEZ7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709023194; c=relaxed/simple;
	bh=zC5EbkVPtuLxCQ3EFeZNZhRxx7JKZV0PZ7xoAKVb0hM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=tR0bZvL7z1dkbYlon/FHorJ6fDI79Hn8IZXBmW17fMca36eiEAG0bijM7w3wIVb6Sxfn4pFhRfHweKLte6dsi3LfDWAU/RPgc0SLLOata2wTM+WA+RreruOzyktCSlWRh5TKYprwBmxUM95HyXV2MTkK4dBrXPfETqJxosWngmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=QBuQLeCw; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a3e7f7b3d95so447350766b.3
        for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 00:39:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709023191; x=1709627991; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=o+aXNHxIjzORWUCeiOERqJ0lGmTMQwDL8WshvudaaZ4=;
        b=QBuQLeCw2eJJy0/ZrgCiEma7RLIZWZ4QAGARvnIKQoKr4swGOle/+FUwvAJo6Qpebx
         r8a9KLuCx/vHJFr6lE4uqr67IBdUgKtt3LYBgKVB5MzOpM8sL3Pmbj2CZnI8IurOKW/D
         VGNgZad2il5UHd7urelRVh+h0mtyj9WhZukcHYJTYgUqVCnHKHjYUcXsR/6Sz+GKz+d0
         JYTBpOFXh0hnhayOSrCR03IWTY9tUszfUwGDwh9Gweny4JEjCf92YO4NdEXK7hHQh5Kg
         uQ0AXMXIs8ET3hjf8Kh/BpSBepEgEOtKofuSz/k04aKeU6k8wmYFX3RQzUM27+W3bCBj
         wd4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709023191; x=1709627991;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=o+aXNHxIjzORWUCeiOERqJ0lGmTMQwDL8WshvudaaZ4=;
        b=JBw3f56AROLqZcxN3XipkSPuH0lXdnaXaANPqYDy902Us3moem9bDmnZWIsj/lhKw1
         8kADQfxXR22ukTuXCiScaN18O3XAsxGKL/enk5fXMmfgAetobXDFEKTs3OfE0qbt1j8l
         u5ypLFYEiueAm2i4RT3le8uKcbQvwi0nKxdQye9ZFctllGhpXTdbsebwPaJgyL/ECJlQ
         Yc95GvAfBiM0qyo/jB1NPRZqFsnLlFRZO7fbT4Hc5juTUF9qMjy9mjIKe5oaa9LTl6Qd
         fopdAPIFt7nfCYBC5f0BKCPcRkXSA+A/zx7RmPCo4cgA203d2JyFo2X5TksiiOWSXbQZ
         yk7g==
X-Forwarded-Encrypted: i=1; AJvYcCUixJC3mQo6BnFwItNEewHNS7w7ghuWiQRVjjsimaGqk3tDxhwjcLwocnmAOAE5wxzOfuxzKhC/AqS9Da+tL3U/2Y8qwPtJkdaztT7v
X-Gm-Message-State: AOJu0Yy0sOG1/g/b99OBkgfcNEXNUq4BZtriYOfDagXo+OYOJNX5vdm/
	BXttolO+ilndjU0NClZZiE8UfFXHavEB3a0MZlrWCJK9GGx3Gzpk8ezXJOpS2Ro=
X-Google-Smtp-Source: AGHT+IHLBMMjgTbNefqywT33NvM4+xIzC/ENlVRQAvfdlVY39CbdhE9EVd1nQsd6+K63ig5wSid0dw==
X-Received: by 2002:a17:906:b206:b0:a3e:ba73:8341 with SMTP id p6-20020a170906b20600b00a3eba738341mr6678290ejz.19.1709023191119;
        Tue, 27 Feb 2024 00:39:51 -0800 (PST)
Received: from krzk-bin.. ([178.197.222.116])
        by smtp.gmail.com with ESMTPSA id q15-20020a170906b28f00b00a43903e7a7csm531101ejz.51.2024.02.27.00.39.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Feb 2024 00:39:50 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	linux-kernel@vger.kernel.org,
	Krzysztof Kozlowski <krzk@kernel.org>
Subject: [GIT PULL] w1: drivers for v6.9
Date: Tue, 27 Feb 2024 09:39:42 +0100
Message-Id: <20240227083942.37722-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi,

On top of tty-next branch (from 6th of Feb).

Best regards,
Krzysztof


The following changes since commit 6cc3028f797a549f256d593867a769ab6a8265f2:

  tty: vt: decrypt magic constants in vc_is_control() (2024-02-06 14:37:39 +0000)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux-w1.git tags/w1-drv-6.9

for you to fetch changes up to d97d263132a69a0bda54efce3df04e55fa6341f7:

  w1: w1-gpio: Convert to platform remove callback returning void (2024-02-20 11:24:34 +0100)

----------------------------------------------------------------
1-Wire bus drivers for v6.9

1. Few cleanups: constifying, convert platform remove callback returning
   void.

2. Add UART 1-Wire bus driver which uses UART interface to create the
   1-Wire timing patterns.

----------------------------------------------------------------
Christoph Winklhofer (3):
      dt-bindings: serial: allow onewire as child node
      dt-bindings: w1: UART 1-Wire bus
      w1: add UART w1 bus driver

Ricardo B. Marliere (1):
      w1: make w1_bus_type const

Uwe Kleine-König (4):
      w1: mxc_w1: Convert to platform remove callback returning void
      w1: omap_hdq: Convert to platform remove callback returning void
      w1: sgi_w1: Convert to platform remove callback returning void
      w1: w1-gpio: Convert to platform remove callback returning void

 .../devicetree/bindings/serial/serial.yaml         |   2 +-
 Documentation/devicetree/bindings/w1/w1-uart.yaml  |  59 +++
 Documentation/w1/masters/index.rst                 |   1 +
 Documentation/w1/masters/w1-uart.rst               |  54 +++
 drivers/w1/masters/Kconfig                         |  10 +
 drivers/w1/masters/Makefile                        |   1 +
 drivers/w1/masters/mxc_w1.c                        |   6 +-
 drivers/w1/masters/omap_hdq.c                      |   6 +-
 drivers/w1/masters/sgi_w1.c                        |   6 +-
 drivers/w1/masters/w1-gpio.c                       |   6 +-
 drivers/w1/masters/w1-uart.c                       | 415 +++++++++++++++++++++
 drivers/w1/w1.c                                    |   2 +-
 12 files changed, 550 insertions(+), 18 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/w1/w1-uart.yaml
 create mode 100644 Documentation/w1/masters/w1-uart.rst
 create mode 100644 drivers/w1/masters/w1-uart.c

