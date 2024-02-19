Return-Path: <linux-kernel+bounces-72052-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B7F0B85AE4B
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 23:18:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EAE7F1C219E4
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 22:18:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E61D55E58;
	Mon, 19 Feb 2024 22:18:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b="RBDcXqM3"
Received: from gate2.alliedtelesis.co.nz (gate2.alliedtelesis.co.nz [202.36.163.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26BE754F90
	for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 22:18:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.36.163.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708381114; cv=none; b=FDlV0FMoegM7zeKPl6LfyrbGOx0u4KhSQt+42xy2lnCJD4ldJDXATXZzZW94iN+JrqoboEjVNfg4w2hA83ufs0917CS5FJBT8IG00WUkiJSxQoK0BAuGlfuE45kqlVQHbdyoGGSb4rMMcwSEMGXd87xgSdDNBdmv55zKV80wc/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708381114; c=relaxed/simple;
	bh=+Ij6kwZR+2dY9E/Lb0nEhao1ELc9Q88v/d3z6cVuWLs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MSo+azemxTqSFlXMXtPiMxaXl6jFaL7sQArqwAUSyUxXt8FAiZzCyqapxj4Hry615WqtBWdtwxF6E6d0dZll88pyjM/3bp7SZRJSrzN96uJbowyItaC5Z2Qhyxv6y5YJY2s8/XZ+Eu08ACN1ycJJf4deTDic9+Vuj2Itz5/Hw2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alliedtelesis.co.nz; spf=pass smtp.mailfrom=alliedtelesis.co.nz; dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b=RBDcXqM3; arc=none smtp.client-ip=202.36.163.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alliedtelesis.co.nz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alliedtelesis.co.nz
Received: from svr-chch-seg1.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id C00212C01BD;
	Tue, 20 Feb 2024 11:18:28 +1300 (NZDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
	s=mail181024; t=1708381108;
	bh=3dVDwJlreXWm2zRETKBpr2jnueJtS3dMPMAFBAB+1Qk=;
	h=From:To:Cc:Subject:Date:From;
	b=RBDcXqM3k9+8WmJDh5IW1IgSp06S/P8YQZvY47Qi0r5VWfc8GQ2c9WWjZ4gjoVu/X
	 Hl6r3LUE7reO8y5OxQqGxTOB6RaxlFdxwPuTYyvpF0cRmavPCRtzmHvCFz4S2M2wDk
	 AE8wXSSkAVdj68qiUJDKIUx6/Ue9jMjmUWIWBnuKWnOVJUncO0+t68ogl1PJpvbSt2
	 OyfgffIG/m8J+dQ732EWwe5V25ItPZzirw6vhW0cgE/RZgDaMpUiiEkV+kjcMDzyxm
	 6vpm2w2HssJVnj90816qrEimPYzwqJG15ODuShIpm90tdsDEqPZ6oRUR4FwiC+ik0v
	 AcFJdCunq3S5A==
Received: from pat.atlnz.lc (Not Verified[10.32.16.33]) by svr-chch-seg1.atlnz.lc with Trustwave SEG (v8,2,6,11305)
	id <B65d3d3b40000>; Tue, 20 Feb 2024 11:18:28 +1300
Received: from chrisp-dl.ws.atlnz.lc (chrisp-dl.ws.atlnz.lc [10.33.22.30])
	by pat.atlnz.lc (Postfix) with ESMTP id 89E4B13EDA8;
	Tue, 20 Feb 2024 11:18:28 +1300 (NZDT)
Received: by chrisp-dl.ws.atlnz.lc (Postfix, from userid 1030)
	id 8357A280AA8; Tue, 20 Feb 2024 11:18:28 +1300 (NZDT)
From: Chris Packham <chris.packham@alliedtelesis.co.nz>
To: antoniu.miclaus@analog.com,
	alexandre.belloni@bootlin.com,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	jdelvare@suse.com,
	linux@roeck-us.net
Cc: linux-rtc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-hwmon@vger.kernel.org,
	Chris Packham <chris.packham@alliedtelesis.co.nz>
Subject: [PATCH v7 0/2] drivers: rtc: add max313xx series rtc driver
Date: Tue, 20 Feb 2024 11:18:22 +1300
Message-ID: <20240219221827.3821415-1-chris.packham@alliedtelesis.co.nz>
X-Mailer: git-send-email 2.43.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-SEG-SpamProfiler-Analysis: v=2.4 cv=BKkQr0QG c=1 sm=1 tr=0 ts=65d3d3b4 a=KLBiSEs5mFS1a/PbTCJxuA==:117 a=k7vzHIieQBIA:10 a=gAnH3GRIAAAA:8 a=QyXUC8HyAAAA:8 a=yHl31WW8M-5d8Fq9UaYA:9 a=3ZKOabzyN94A:10 a=oVHKYsEdi7-vN-J5QA_j:22
X-SEG-SpamProfiler-Score: 0
x-atlnz-ls: pat

Datasheets:
  https://www.analog.com/media/en/technical-documentation/data-sheets/MAX=
31328.pdf
  https://www.analog.com/media/en/technical-documentation/data-sheets/MAX=
31329.pdf
  https://www.analog.com/media/en/technical-documentation/data-sheets/MAX=
31331.pdf
  https://www.analog.com/media/en/technical-documentation/data-sheets/MAX=
31334.pdf
  https://www.analog.com/media/en/technical-documentation/data-sheets/MAX=
31341B-MAX31341C.pdf
  https://www.analog.com/media/en/technical-documentation/data-sheets/MAX=
31342.pdf
  https://www.analog.com/media/en/technical-documentation/data-sheets/MAX=
31343.pdf

Note that I've only got access to a MAX31334 to test with. I'm relying on=
 the
fact that Ibrahim would have been testing on the other variants through e=
arlier
iterations of this series. I've also made a best effort attempt to integr=
ate
the MAX31335 support with the more generic code but as the datasheet is n=
ot
public I can't be sure it's been done correctly and the MAX31335 has defi=
nitely
not been tested with this updated code (Antoniu if you could test it on y=
our
hardware that would really help).

changelog:
since v6:
  - Roll changes into max31335 driver that was landed while this was
    in-flight.
  - Adjusted code order and variable names to reduce the delta with
    the max31335

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

 .../devicetree/bindings/rtc/adi,max31335.yaml |   70 -
 .../devicetree/bindings/rtc/adi,max313xx.yaml |  167 +++
 drivers/rtc/Kconfig                           |    2 +-
 drivers/rtc/rtc-max31335.c                    | 1154 +++++++++++------
 4 files changed, 958 insertions(+), 435 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/rtc/adi,max31335.ya=
ml
 create mode 100644 Documentation/devicetree/bindings/rtc/adi,max313xx.ya=
ml

--=20
2.43.2


