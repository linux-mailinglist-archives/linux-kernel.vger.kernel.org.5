Return-Path: <linux-kernel+bounces-164261-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 40C408B7B7D
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 17:28:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D5DC21F22002
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 15:28:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14332F9D6;
	Tue, 30 Apr 2024 15:27:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="knaUVQlZ"
Received: from mail-il1-f194.google.com (mail-il1-f194.google.com [209.85.166.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6473143747;
	Tue, 30 Apr 2024 15:27:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714490851; cv=none; b=BTNdNag4jmoQEpt9M5DQK/xSDDlal5tbFqpq4PmEQBXEtJyakA2/NdW1kD6icT4memRB5WQWmW4MEkARtgtYFgxfDc1bqQefHtR0DJietqW8o47ZPlmkyMHF6gBiOzshIO3HDbhCxg00mLCoreJGQbYZqEBpNZBRg0gg86lhwjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714490851; c=relaxed/simple;
	bh=Ss7g34ijX2BvxAvxl1n7pOtIXySDgZt+SZtJaMRV9dA=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=g5VBI6w3DBPNrlI+winTARw1yfznNq1LPKVNeEyWSv6/CSzim48zNAL/SpJBWEFFYVr3K3KN/3ByMh5vtAdno9saBTVfQvC7Q0eAVEs/Pja0CsSeCwcTJn6py/6SRj74kR5+R1h9f7FbaFku67Gv8b/kpUb4j2PFKxBYzK41FvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=knaUVQlZ; arc=none smtp.client-ip=209.85.166.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f194.google.com with SMTP id e9e14a558f8ab-36c50653eb6so9839435ab.3;
        Tue, 30 Apr 2024 08:27:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714490849; x=1715095649; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=HxYlb1r/6wE+G6eenoHFs2Veuqgy7yacwzWU3bvU/Ic=;
        b=knaUVQlZWTR93IRm1hQoVKwC4oMzodSPojD/df6cw4pFDNouwPWBl1WhEEX78YsO+e
         bpPCn3dCp3Tl2ZBEfvj5Hob3/Y6nMPmX8KekHA0h8v3l8VQa2O9NDUcByLgarOrnvZQo
         H7cBkbq71IhLZyDYAEFoY+XfkmLdhVBsSe0RKfX5sRNVrL620jnlOF2jm5POmxB9QWtz
         t2Pj9jgWxEil287wIAeyqMVGVXvI/LXV+2e6vBbbsCQOUB92L4zGTTP5nkYCzr69qqWM
         65Mx/rUGRCG5DxAGdOL7+h9HdmQqZAruPrr+0kHYpfoWTBh8CXyhIBiplWbdOtwyIpxQ
         QvuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714490849; x=1715095649;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HxYlb1r/6wE+G6eenoHFs2Veuqgy7yacwzWU3bvU/Ic=;
        b=lqnvsHPkt/WdS8NDCcXN+YbwPa8GKmFn9EPn+UNVTleb0drY2RMDdT9RG0vUrAg+g/
         UFl5QHh2Os9rV4MEvA3xf31WPzZLjMyQ4QORcsTXwhq0kXGj7ob5HcJNJOTQ0nAKb+sZ
         uQxh7lhksiffW3N1aMlfMYsszRGEKDkSQfh68WbedaK2IgpB+zFzHH2gnOHlo5uf1n5C
         EbbF5fgHdpRLOhpf8p9KIIs9gDC1NsOa/qb+79qH7WTBnaQwS8ux3qu44tgtWeQEfqtr
         KkABUv5EphRU3ZFCyJN63d6QBdk8O6FfT7wiQU1lkksGEKTIEhDDL3/QWUsv8NxJ5ZLx
         NJ0Q==
X-Forwarded-Encrypted: i=1; AJvYcCVIRC4H7VIXVBA3PkaovEY+TrNmmfk5rBlgL1KPpuRUhd6qIyu+kovEoaqM8RYK+WuEcjJvP/7QxV6KOv1KDavo07nVnJmcsXmueUFelQ8NBleq7xQOO5d56c9HCtdKC1Ue6BxRUklYtQ==
X-Gm-Message-State: AOJu0YxTpsT3wOze1surcAL3hmgT3nEzJVROxORQV/MhIIVRlURyps0w
	BN06vux+mRCYqPSmqaDRQAnJEKCc510BbPcyVG7fl/gugEPQzLfy1Vgao8M/zRi2VHWkyl/hlIe
	ZZqY6YrYr5IQIlydrCiqZPJJqw87Ciet0fA0=
X-Google-Smtp-Source: AGHT+IFyu8rsZYSJfyPGIb3N+4eo+tU/9t1+q4IauQha8NwkL2oy3iMHzAHpxLs7B7pl1JrNllUUlohxBgGp29NbiA8=
X-Received: by 2002:a05:6e02:12e8:b0:36c:4688:85b0 with SMTP id
 l8-20020a056e0212e800b0036c468885b0mr63734iln.5.1714490848910; Tue, 30 Apr
 2024 08:27:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Petar Stoykov <pd.pstoykov@gmail.com>
Date: Tue, 30 Apr 2024 17:27:17 +0200
Message-ID: <CADFWO8EZWkXeAMcURgGGEmzVjiSxFTVAbKpsb2Qmv66EZiTc+A@mail.gmail.com>
Subject: [PATCH v2 0/3] Add support for Sensirion SDP500
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Lars-Peter Clausen <lars@metafoo.de>, 
	Rob Herring <robh+dt@kernel.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	Angel Iglesias <ang.iglesiasg@gmail.com>, Conor Dooley <conor+dt@kernel.org>, 
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

From c4437fd0ea296c4c964b1fb924144ae24a2ce443 Mon Sep 17 00:00:00 2001
From: Petar Stoykov <pd.pstoykov@gmail.com>
Date: Mon, 29 Apr 2024 16:41:30 +0200
Subject: [PATCH 0/3] Add support for Sensirion SDP500

This patch series introduces support for Sensirion SDP500 in the IIO
subsystem. The series is split into three patches:

1. The first patch adds the device tree bindings.
2. The second patch implements the device driver.
3. The third patch updates the MAINTAINERS file.

The driver is relatively simple. It provides a way to read the measured
differential pressure directly in Pa, as the device has a fixed scale
factor of 1/60. When an applications wants to read the pressure value,
3 bytes are read from the device, 2 are data and 1 is CRC8. If the crc
check passes, the calculated pressure value is returned in Pa units.

The initialization of the device just starts the measurement process.

We have been using this device and driver in a product development for
almost a year now. There the pressure is read every 25ms and is used in a
control loop. We have not even seen crc errors. We are using the
"linux-imx" repository and not the mainline one but I see no risky kernel
functions in use so it should be fine here too.

All feedback is appreciated! Thank you for taking the time to review this.

v1->v2:
Many fixes suggested by Jonathan Cameron and Krzysztof Kozlowsk.
Mainly code style and re-using existing functions instead of custom ones.
The fixes are both in dt-bindings and iio: pressure.

Petar Stoykov (3):
  dt-bindings: iio: pressure: Add Sensirion SDP500
  iio: pressure: Add driver for Sensirion SDP500
  MAINTAINERS: Add Sensirion SDP500

 .../iio/pressure/sensirion,sdp500.yaml        |  39 +++++
 MAINTAINERS                                   |   6 +
 drivers/iio/pressure/Kconfig                  |   9 ++
 drivers/iio/pressure/Makefile                 |   1 +
 drivers/iio/pressure/sdp500.c                 | 144 ++++++++++++++++++
 5 files changed, 199 insertions(+)
 create mode 100644
Documentation/devicetree/bindings/iio/pressure/sensirion,sdp500.yaml
 create mode 100644 drivers/iio/pressure/sdp500.c

-- 
2.30.2

