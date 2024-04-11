Return-Path: <linux-kernel+bounces-141444-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BF19A8A1E5D
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 20:33:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EF9301C24526
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 18:33:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E56A5029E;
	Thu, 11 Apr 2024 18:07:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E1sjHJRc"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B29C44AEF6;
	Thu, 11 Apr 2024 18:06:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712858819; cv=none; b=JDc/hnJ1KQL31+E8pTk5jvqJM3vnsC9usL9meeQfT0j3QfJrFLNht9GzLvmb5t03nyNYoHex6rUV+GavHrB70C8Q7s8F1/oWNljPJp6zY+uz2lter6m5uTRpS/EdbOkhejjKA85OEn0KCqzEAKMS2CTep+iulHXi7BaKvq7k/XU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712858819; c=relaxed/simple;
	bh=OBtJj7ZcYW9SVRHkZ8Ppp3O8vjrSvDbG3fOF0xOk690=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=FYlGTXHxRfXJxoUsM1q0Yq4IdJS5+89CevT9S05/lw6KYyZbin5E9ackExcviYeWWymC9MNhevjoywnoxn1tIGw7NEeNv74eUx2//X+EYSZIuvcxz+Cnj4IeRfjnTYo3H9h0lRe/G13cIc9M1rGaaS9jjKdmUqIuYGi/n6FqwgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E1sjHJRc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 515C8C113CD;
	Thu, 11 Apr 2024 18:06:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712858819;
	bh=OBtJj7ZcYW9SVRHkZ8Ppp3O8vjrSvDbG3fOF0xOk690=;
	h=From:Date:Subject:To:Cc:From;
	b=E1sjHJRcmAr7dYRq/xOaSMm0QKZqtA5gpGFb5Dlg0lAC2ipYJ+6jUcwyHqNU0HRsP
	 F4LfxCL6/aoW35PK3tIBZxR65G8JnRs0K4xXI/4+PoMazruYwcB7iw+VbafR8F7+rf
	 4G6RgWizq52t2MU3J3SLsk9fblAV0t5m/xAj47T1yIIyuy6LNdBNm9X2EweG88gaCR
	 46N2E0GTVk56Q8dY1MbCyHHeEAjlHtmI9OfeQod+AK9OiCuh8Y37R+Y7vQ1CPEMmY7
	 SyJQ3p6F1owph8MOQYqGdw27AiSBw+cs3Dd/uOOakNUsWZWyUU5pWVR6gZ24nyHx5N
	 SNdr2jRGgZkzA==
Received: by mail-oa1-f43.google.com with SMTP id 586e51a60fabf-22ed9094168so37279fac.1;
        Thu, 11 Apr 2024 11:06:59 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCURjbqHpNNh1w5l94RtqAQAba0eDgi5dyZ2zOCxXlMwTednWWSPMVqcossqPnHIca9GYRkafvGPkfGzaJcH4LvFDpM5hTbPcX7VadmZ
X-Gm-Message-State: AOJu0YwAnonuLY3UKWaJNPYoEvdu748FUoPUd6/2yCkSYcupZxaU5xJl
	PPMo+zWcSQE/sjXM7SMIS+zgb20/HbcSVSFHyrE1PGEvtnk6y03IBXbtah4NWOcytwCs+H+K2q0
	d8HuF9lUJBtavPb6VWCP/jIsZugg=
X-Google-Smtp-Source: AGHT+IHH6DIatP4LCBLRv1/7UkplGXpudSu3Xpr5O0NHr8dyFntl9eTZZGSg65NpawsRSDpm77MDno8ofi02EE5ZJMY=
X-Received: by 2002:a05:6871:612:b0:229:ee6d:77da with SMTP id
 w18-20020a056871061200b00229ee6d77damr293559oan.2.1712858818614; Thu, 11 Apr
 2024 11:06:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 11 Apr 2024 20:06:47 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0jH8rKc3=rNzDdWOobGb4xCCjK46eYoE3U729yRwpgCFQ@mail.gmail.com>
Message-ID: <CAJZ5v0jH8rKc3=rNzDdWOobGb4xCCjK46eYoE3U729yRwpgCFQ@mail.gmail.com>
Subject: [GIT PULL] ACPI fixes for v6.9-rc4
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hi Linus,

Please pull from the tag

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 acpi-6.9-rc4

with top-most commit d7da7e7cec9868b24f0e39298156caf0277e82c7

 Merge branch 'acpi-bus'

on top of commit fec50db7033ea478773b159e0e2efb135270e3b7

 Linux 6.9-rc3

to receive ACPI fixes for 6.9-rc4.

These fix the handling of dependencies between devices in the ACPI
device enumeration code and address a _UID matching regression from
6.8 development cycle.

Specifics:

 - Modify the ACPI device enumeration code to avoid counting
   dependencies that have been met already as unmet (Hans de Goede).

 - Make _UID matching take the integer value of 0 into account as
   appropriate (Raag Jadav).

Thanks!


---------------

Hans de Goede (1):
      ACPI: scan: Do not increase dep_unmet for already met dependencies

Raag Jadav (1):
      ACPI: bus: allow _UID matching for integer zero

---------------

 drivers/acpi/scan.c     | 3 ++-
 include/acpi/acpi_bus.h | 8 +++++---
 2 files changed, 7 insertions(+), 4 deletions(-)

