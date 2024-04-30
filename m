Return-Path: <linux-kernel+bounces-164118-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 967E18B793E
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 16:26:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8ADD6B22412
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 14:26:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDD361BF6EF;
	Tue, 30 Apr 2024 14:14:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Fv4aWUaK"
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACB921BF6DE
	for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 14:14:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714486494; cv=none; b=TrO8bWA+pWupHlzdvY5HTswtWmbXPqa2I7yoqFAFn1rRwMaAhgIBxdQ9nq/y43dyovRujW4F+NYa8hTUaJrt5K4U0H9EDbirvl0BUmsjdebqt0lXqWPjvhHBlgZVYQtgvtBTHAecXkxIXLWyXB7tOVIQF1XaGJBQrYZkOAEJ8wo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714486494; c=relaxed/simple;
	bh=BMB+z9c1zfhOZlvqXHvsg89v/QWq0s4HCgmAlwaHots=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=dj/fAqhOX1HWmFKuXTuG0yFga7i5nD7w7VyS+ufY4FcvwVa8UieZeU1oLv+IaxmutUkIBcPVbbDiHCclMy93jxu1VVEW+WzNMGc4ngG6pN2DSmHMkGej01/tLVyN23fjbxypyOY+QCu1hfMzS3cON0OeXzEgnS4uBMAVI1uzfv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Fv4aWUaK; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-2dcc8d10d39so66557191fa.3
        for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 07:14:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1714486491; x=1715091291; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jUVDGtf9QkAcRfngS/o++38b1IM12LgCsv7+0IqjJHk=;
        b=Fv4aWUaKbK+khIng1+xQxP2uyhPASQEP4Iq6ih9A6OEcSEtvplA4v+ColSVpky0QPj
         mtEhSs0Wlp/h2kaWM1psFA5xsjsLbMlY4gN+HRfl6z9nWgsnv2uhwgwE5d1tkd8BYnLr
         Vd8mZA1Ip0W1b9gKDS3R4SYWJ0JhpoQjG2R2aYLZaAfxJtajFThAoMLvFCVMTD99TI2j
         KwpSIMEdlp6c7KwCMbmmHFJCZ5EZhhkY15zQ2zNVCAXxHKQqm55lEDX3HmdvDQinMO+C
         1pCVdjbyv3OCntJCxekEVuSoak6l4QFvFScV7PSP6fdP29Z0HdGXInRwiE6z2tpcgfi/
         Quug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714486491; x=1715091291;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jUVDGtf9QkAcRfngS/o++38b1IM12LgCsv7+0IqjJHk=;
        b=J7DMXBOEtZl/C6NvkL5L7qhCAWMAvUNG8Gp3FBYlqJpNd8v616GBLOPMOoR7viZWp4
         NuYbYXJcaZSDNLXzSifaT10AgRoEAZJ4QRUvOXdimfpM0Yu6xpVHkfTRydaAKJjfxxGV
         3g7czlZ6zTKElstQkp9Yjg2tKqDO7GNn4VbKa7k69zWJhTZochH+FMkiS9tZ6NWJ080/
         w8KYSIJ68yf+LsuVOPWpaPFfisLZl0l8GVLUfpsbMqq6nXdUllYnndFOl+VfABG3Lwvo
         pbUDdz9Xxwzz/Bu1bhLZ8ZpEdixxdhpHr6o0eKjJLak6KAgth5d53RQqDVf2NCgYz4On
         EU6g==
X-Forwarded-Encrypted: i=1; AJvYcCXfJooRR/P3/2PktMkaYigBfMaqAyK4ybrcRW8TPJ44XmHD2DIv1+mfBYVFp239DzUYGujnLDpYIbfEbQaYkXNoLzqsv420rvDQXJ8V
X-Gm-Message-State: AOJu0Yw9oID0v1bJErytrM4dZJ4lKKYY68u/ZlGZIfY7WEbabmR1+wRc
	xi9RiNtPe7l1V585q0h36cFgqhOSMEjzkSKOjTmFgO0uOsxqDbW4nMIGky5AY0A=
X-Google-Smtp-Source: AGHT+IFH+e1i2EkTrM5iUSZe3Re0sq92AVs5C4352oNgc8DcuUMjfPoN4eshBnWIIyKpbwdQMVCK8w==
X-Received: by 2002:a2e:780d:0:b0:2e0:b7d6:eaa5 with SMTP id t13-20020a2e780d000000b002e0b7d6eaa5mr2877492ljc.40.1714486490613;
        Tue, 30 Apr 2024 07:14:50 -0700 (PDT)
Received: from gpeter-l.lan ([2a0d:3344:2e8:8510:f162:7aca:a805:2c2f])
        by smtp.gmail.com with ESMTPSA id r10-20020a05600c458a00b0041bf3a716b9sm11593517wmo.34.2024.04.30.07.14.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Apr 2024 07:14:50 -0700 (PDT)
From: Peter Griffin <peter.griffin@linaro.org>
To: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	alim.akhtar@samsung.com
Cc: devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	tudor.ambarus@linaro.org,
	andre.draszik@linaro.org,
	saravanak@google.com,
	willmcvicker@google.com,
	kernel-team@android.com,
	Peter Griffin <peter.griffin@linaro.org>
Subject: [PATCH v5 0/3] Enable UFS on gs101 / Pixel 6 (Oriole)
Date: Tue, 30 Apr 2024 15:14:42 +0100
Message-ID: <20240430141445.2688499-1-peter.griffin@linaro.org>
X-Mailer: git-send-email 2.45.0.rc0.197.gbae5840b3b-goog
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Krzysztof,

This series contains the dts, dtsi that enables UFS on Pixel 6 (Oriole).
From v3 onwards it has been split into separate series as you requested.
v5 has been rebased on next-20240430, to avoid the conflicts with Andre's
USB enablement work that was recently queued.

Along with the various driver code UFS is now functional, the SKhynix
HN8T05BZGKX015 can be enumerated, partitions mounted etc.

UFS bindings in this series are proposed:
https://lore.kernel.org/linux-arm-kernel/20240426122004.2249178-1-peter.griffin@linaro.org/

* Clock cmu_hsi2 bindings used here are already queued by you
* UFS phy bindings used here are already queued by Vinod

kind regards,

Peter.

lore v4: https://lore.kernel.org/linux-kernel/20240429111537.2369227-4-peter.griffin@linaro.org/T/
lore v3: https://lore.kernel.org/lkml/20240426122004.2249178-1-peter.griffin@linaro.org/
lore v2: https://lore.kernel.org/linux-kernel/20240423205006.1785138-1-peter.griffin@linaro.org/
lore v1: https://lore.kernel.org/linux-clk/20240404122559.898930-1-peter.griffin@linaro.org/

Changes since v4:
 - Rebase on next-20240430
 - Drop '0x' from unit address (Krzysztof)

Changes since v3:
 - Fix unit address ordering in gs101.dtsi (Krzysztof)

Changes since v2:
 - Split into separate subsystem series
 - Split dts and dtsi patches (Krzysztof)

Changes since v1:
 - Collect up tags
 - fix google,gs101-hsi2-sysreg size (0x10000 not 0x1000) (Andre)
 - use GPIO defines in DT and add TODO pmic comment (Krzysztof)
 - Add sysreg clock to ufs node (Andre)

Peter Griffin (3):
  arm64: dts: exynos: gs101: Add the hsi2 sysreg node
  arm64: dts: exynos: gs101: Add ufs and ufs-phy dt nodes
  arm64: dts: exynos: gs101: enable ufs, phy on oriole & define ufs
    regulator

 .../boot/dts/exynos/google/gs101-oriole.dts   | 18 ++++++++
 arch/arm64/boot/dts/exynos/google/gs101.dtsi  | 42 +++++++++++++++++++
 2 files changed, 60 insertions(+)

-- 
2.45.0.rc0.197.gbae5840b3b-goog


