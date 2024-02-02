Return-Path: <linux-kernel+bounces-49118-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FFF484660D
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 03:53:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A6DC2B244AC
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 02:53:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4904C8EA;
	Fri,  2 Feb 2024 02:52:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b="qe1pMcBX"
Received: from gate2.alliedtelesis.co.nz (gate2.alliedtelesis.co.nz [202.36.163.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06C5BE563
	for <linux-kernel@vger.kernel.org>; Fri,  2 Feb 2024 02:52:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.36.163.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706842374; cv=none; b=H6rSXeOmH+oD1bVoRh+X9bUV+yhF2gkTS4O+QCp+jf10uclmkdHWSejLGG5sl3Qike+KBaQfw+LZAqeDts/9gG1AzQ68K3MYAZ0PcvRhOm54qVMjcGLkH3fj0prffU9r2N14vEbDGnC9wTmZRyo+24PxgRz8b7Fi5i1yVtuf4NA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706842374; c=relaxed/simple;
	bh=FfI+psqa5rlhKOTLCfKVaPMsCPGNwBQKn4DDGo5wymk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ITp1QdPBOOuNBeGxsRjjA4FQsLIfzOCI/GqL9wU+pudIszzYFYSNICWz8259Ns/p7o7nrAfuFRMCWT+7hC/5dAD/4anmWqGrF/P4qoGfv6u0eAdLafu1KgrnVfNrmWqndSk5l4lkLSusc6MG7Uj5N8g1gMtVtKGIq6dREtOJqdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alliedtelesis.co.nz; spf=pass smtp.mailfrom=alliedtelesis.co.nz; dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b=qe1pMcBX; arc=none smtp.client-ip=202.36.163.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alliedtelesis.co.nz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alliedtelesis.co.nz
Received: from svr-chch-seg1.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id A8FBA2C018D;
	Fri,  2 Feb 2024 15:52:48 +1300 (NZDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
	s=mail181024; t=1706842368;
	bh=unF68hkU9VlsR/Q1RG29bTiUOBUgCrxhHhvhNebROP0=;
	h=From:To:Cc:Subject:Date:From;
	b=qe1pMcBXMfjf7j56Vl/Fes0jHWYlZXM1t7fIOrWSSYJdQgAnvwtR8//xAauKurupx
	 GM1PgsNQ+WIw9s9m4eGFBKGVyhDObMBkiXUweLd3/8LiWrjFIFLsgpNH0NF31drOcM
	 o726t3CG0EWC+6nH5PpwZ2ynwwIABzFH43iWL1WeVFGlBO2sI5rYe8rFDwWgJV0EfX
	 SlDOBZESbm1kVZgmK/uupqpEwp7TLw+XWfK0UYUcLpzMnHjy9I0KarNU0xeMtzJSD5
	 dikiW7t3lGy7XEq5mJow4UZSKtg6Y3/p/S3oBVzvrkoZt3CsiciS3W8NOMep015uY3
	 xqGvZlhAzpeCA==
Received: from pat.atlnz.lc (Not Verified[10.32.16.33]) by svr-chch-seg1.atlnz.lc with Trustwave SEG (v8,2,6,11305)
	id <B65bc59000000>; Fri, 02 Feb 2024 15:52:48 +1300
Received: from chrisp-dl.ws.atlnz.lc (chrisp-dl.ws.atlnz.lc [10.33.22.30])
	by pat.atlnz.lc (Postfix) with ESMTP id 608D913EDA9;
	Fri,  2 Feb 2024 15:52:48 +1300 (NZDT)
Received: by chrisp-dl.ws.atlnz.lc (Postfix, from userid 1030)
	id 56D5D280EB5; Fri,  2 Feb 2024 15:52:48 +1300 (NZDT)
From: Chris Packham <chris.packham@alliedtelesis.co.nz>
To: alexandre.belloni@bootlin.com,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	jdelvare@suse.com,
	linux@roeck-us.net,
	antoniu.miclaus@analog.com,
	noname.nuno@gmail.com
Cc: linux-rtc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-hwmon@vger.kernel.org,
	Chris Packham <chris.packham@alliedtelesis.co.nz>
Subject: [PATCH v6 0/2] drivers: rtc: add max313xx series rtc driver
Date: Fri,  2 Feb 2024 15:52:39 +1300
Message-ID: <20240202025241.834283-1-chris.packham@alliedtelesis.co.nz>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-SEG-SpamProfiler-Analysis: v=2.3 cv=LZFCFQXi c=1 sm=1 tr=0 a=KLBiSEs5mFS1a/PbTCJxuA==:117 a=k7vzHIieQBIA:10 a=QyXUC8HyAAAA:8 a=JN5pTWmEISIy-nGIZr8A:9
X-SEG-SpamProfiler-Score: 0
x-atlnz-ls: pat

changelog:
since v5:
  - change of maintainer
  - use adi,ti-diode property
  - deal with oscillator fail and releasing SWRST

since v4:
  - dt-binding: add enum value "2" to aux-voltage-chargable
  - dt-binding: remove adi,trickle-diode-enable
  - dt-binding: change description of trickle-resistor-ohms
  - dt-binding: reorder as in example schema
  - parse "wakeup-source" when irq not requested
  - remove limitation on max31328 irq and clockout
  - remove error and warning messages during trickle charger setup

since v3:
  - dt-binding: remove interrupt names.
  - dt-binding: add description for "interrupts" property
  - dt-binding: replace deprecated property "trickle-diode-disable"
      by "aux-voltage-chargeable"
  - dt-binding: add new property "adi,trickle-diode-enable"
  - dt-binding: remove "wakeup-source"
  - use clear_bit instead of __clear_bit
  - use devm_of_clk_add_hw_provider instead of of_clk_add_provider
  - use chip_desc pointer as driver data instead of enum.

since v2:
  - add "break" to fix warning: unannotated fall-through
    Reported-by: kernel test robot <lkp@intel.com>

since v1:
  - dt-binding: update title and description
  - dt-binding: remove last example
  - drop watchdog support
  - support reading 12Hr format instead of forcing 24hr at probe time
  - use "tm_year % 100" instead of range check
  - refactor max313xx_init for readability

Ibrahim Tilki (2):
  drivers: rtc: add max313xx series rtc driver
  dt-bindings: rtc: add max313xx RTCs

 .../devicetree/bindings/rtc/adi,max313xx.yaml |  145 +++
 drivers/rtc/Kconfig                           |   11 +
 drivers/rtc/Makefile                          |    1 +
 drivers/rtc/rtc-max313xx.c                    | 1098 +++++++++++++++++
 4 files changed, 1255 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/rtc/adi,max313xx.ya=
ml
 create mode 100644 drivers/rtc/rtc-max313xx.c

--=20
2.43.0


