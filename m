Return-Path: <linux-kernel+bounces-27366-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DC20E82EEBB
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 13:10:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6CCDCB23A22
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 12:10:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3766D1B976;
	Tue, 16 Jan 2024 12:09:44 +0000 (UTC)
Received: from mail-oa1-f53.google.com (mail-oa1-f53.google.com [209.85.160.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BCD31BC20;
	Tue, 16 Jan 2024 12:09:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-204b216e4easo2140979fac.1;
        Tue, 16 Jan 2024 04:09:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705406981; x=1706011781;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lURx4EVsPbFSOQIiob3lxt3SbzdMQVY25MX0SZLU7b4=;
        b=BeYHSJaXjETyz0JGhpeaeGxh0thyhLYyX7kcSvoa5QuOR+fHLVIHGyG327K8lIBQlw
         6HvPDoQWU0tfAFdWH4rRwfzrOdsDgp132YiTzpkKjQtaHrIWuGQ+Pod7gqsAkZp4FZmg
         He1tRDs7adqG6m0OGZ1tLCoXUr8ICXlVsOHANznohT6wCNZaM+VfHbnLMriHgmf9R6d0
         iOSBZZxNAAhe7I6Amme7pHjQPotM79PvKjmlE6m7VhOlXLQUc0hbD0EhLpv0IQGBH+yd
         b7ZP0DLZgEr5DHUVlM/+3rO0RZ/2wtZkHzR/g0Ec/fmvlzGkxflo1J6jzgdJWkkIUOAa
         aGbg==
X-Gm-Message-State: AOJu0Yye0LMFCayADjYenD0vcf5R5LKoyd1mEg5SS/ps5O/BISrhN3pk
	6GLd4tBPWo6P1IEgZmAy1E1EV10YVdABQ5ePR5EFxzcyQRI=
X-Google-Smtp-Source: AGHT+IGQga0Tb68FRQF8wnULqbw67V+zoqJKfum3lp23NuJMvBjmrrmKN/1qAwULnpz53MU/inKa6e7ONIdn5YGkzLk=
X-Received: by 2002:a4a:9d19:0:b0:598:94b1:1658 with SMTP id
 w25-20020a4a9d19000000b0059894b11658mr9646366ooj.1.1705406981570; Tue, 16 Jan
 2024 04:09:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 16 Jan 2024 13:09:30 +0100
Message-ID: <CAJZ5v0iL9F8o5_QXv+Ki5cHmk74ofQ2PwKOtJjJQoOWEGpOGWA@mail.gmail.com>
Subject: [GIT PULL] More ACPI updates for v6.8-rc1
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hi Linus,

Please pull from the tag

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 acpi-6.8-rc1-2

with top-most commit 5b5268cd49d233f03a5cfb1108dcd38bcb83f6d1

 Merge branches 'pnp', 'acpi-resource' and 'acpica'

on top of commit 7da71072e1d6967c0482abcbb5991ffb5953fdf2

 Merge tag 'pm-6.8-rc1' of
git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm

to receive more ACPI updates for 6.8-rc1.

These add support for new MADT flags to ACPICA, constify the PNP bus
type structure and add new ACPI IRQ management quirks.

Specifics:

 - Make pnp_bus_type const (Greg Kroah-Hartman).

 - Add ACPI IRQ management quirks for ASUS ExpertBook B1502CGA and ASUS
   Vivobook E1504GA and E1504GAB (Ben Mayo, Michael Maltsev).

 - Add new MADT GICC/GICR/ITS non-coherent flags and GICC online capable
   bit handling to ACPICA (Lorenzo Pieralisi).

Thanks!


---------------

Ben Mayo (1):
      ACPI: resource: Add DMI quirks for ASUS Vivobook E1504GA and E1504GAB

Greg Kroah-Hartman (1):
      PNP: make pnp_bus_type const

Lorenzo Pieralisi (2):
      ACPICA: MADT: Add GICC online capable bit handling
      ACPICA: MADT: Add new MADT GICC/GICR/ITS non-coherent flags handling

Michael Maltsev (1):
      ACPI: resource: Skip IRQ override on ASUS ExpertBook B1502CGA

---------------

 drivers/acpi/resource.c | 21 +++++++++++++++++++++
 drivers/pnp/driver.c    |  2 +-
 include/acpi/actbl2.h   | 12 ++++++++++--
 include/linux/pnp.h     |  2 +-
 4 files changed, 33 insertions(+), 4 deletions(-)

