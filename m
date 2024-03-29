Return-Path: <linux-kernel+bounces-125281-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D05B89235F
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 19:31:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 435711F24063
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 18:31:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4603138DD3;
	Fri, 29 Mar 2024 18:31:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bYhmm8jr"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 846AE320B;
	Fri, 29 Mar 2024 18:31:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711737091; cv=none; b=eGCI5ST4AU1X+v0v+TU3wOWCUDVWDnGMdRsl1JLWEScsO6bB+4EDsRltojauCXID7XThGBBODlZ8K9+RpIt1IvHCJY9Cf72tBD3GEH8a5lEtOlwKjPXTDjUE6U6tF5H/vM3h/jkLviveUH3tt19HfUebBJkD3NOgv3CrnYTY4VA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711737091; c=relaxed/simple;
	bh=TvpS37TuH38fbL7Zms7LKNeuuEbSsU60yenC+/E1pTU=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=Ysi3KGpZs+L+pV/AYLmr53AXKBE6NSgiQhp8KYnYcBLcGBsfPWhU/Hce36dbvpFhOZ32AaUgLcJWTgWBqjlyfDrPE4LICPovkMfbfPxzLbyn/a7dONDdz7lyOYN4yVcLie6HetW4d3lmgajv5USX8B+g+3bp4Hac8GQ5XLmoRCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bYhmm8jr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D7C4C433C7;
	Fri, 29 Mar 2024 18:31:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711737091;
	bh=TvpS37TuH38fbL7Zms7LKNeuuEbSsU60yenC+/E1pTU=;
	h=From:Date:Subject:To:Cc:From;
	b=bYhmm8jrDEgc8/5rNzjsR3m0ykpBpG+AeLnfqDe+87oEVDmXcYpwLnETptU9cXGfP
	 f6eD93VKr+jJ0+tBRj6hyzOUxaqPPf9cXaI1yYIo/cojDJU0sjhWa8NAKEdkR2EXUx
	 ekeKAxpKbR5Y7Y1LWx0PbY+PIwCQi1jDTzIEd+E2ifdVsPZ0GQY1DVnrNFaTwqd1qk
	 lZZVM5RFCPM3GgzhsoIxxj03E5kIukj6DyL+QTPwBbfgWBy8FREWpotMpaXAnOZX1+
	 j61hvUsFqQHqFadaLGAc7OHzw23lW+K92jvKa0pOIOU/RwVK5lc8Jdf7oezRGTOmXI
	 2ufFaXEwoXhBA==
Received: by mail-oo1-f48.google.com with SMTP id 006d021491bc7-5a4e0859b65so700277eaf.0;
        Fri, 29 Mar 2024 11:31:31 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUTRq34HRsxl7D+Bae3tPTrl5J09XZBwsDy8AveBnxlZ/bBePmto71hKgwWtWnl2J7hlpHWa6fmcSmAiYYfshHzcnsGdVTxvr+ouqwB
X-Gm-Message-State: AOJu0YxR2DdOzN6kqbx0GVDM9ovy7jaLjZchIb6PxbOsuSNhUdTHEb7M
	n2MT06zHBOvYC2z/Ypn3gT/noje/YacZVSaVdF5vq5U7puDaccWRvnXrhIAMWPGcRok2+Dhqi5r
	IE/NMmNgJyHldq2zZzs0ZR+xewQY=
X-Google-Smtp-Source: AGHT+IFIviysJgYU1yDqwD3yGYyhTcToYGEPzLF7ZAeMU2lDbUYA0TOx8kYIYxGJMdSeGn+dOzPcyzAMvvQcrk4KzQ0=
X-Received: by 2002:a05:6870:8e0e:b0:22a:1e0c:8bc6 with SMTP id
 lw14-20020a0568708e0e00b0022a1e0c8bc6mr3122507oab.2.1711737090421; Fri, 29
 Mar 2024 11:31:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 29 Mar 2024 19:31:19 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0jO6Op9u9x0j0XVfaSN-5OguoubAwxTbSacJ_QLX5wCDA@mail.gmail.com>
Message-ID: <CAJZ5v0jO6Op9u9x0j0XVfaSN-5OguoubAwxTbSacJ_QLX5wCDA@mail.gmail.com>
Subject: [GIT PULL] ACPI fixes for v6.9-rc2
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hi Linus,

Please pull from the tag

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 acpi-6.9-rc2

with top-most commit 6af71633b04036a12d165d03ce6f21145ec5a555

 Merge branch 'acpica'

on top of commit 4cece764965020c22cff7665b18a012006359095

 Linux 6.9-rc1

to receive ACPI fixes for 6.9-rc2.

These fix two issues that may lead to attempts to use memory that
has been freed already.

Specifics:

 - Drop __exit annotation from einj_remove() in the ACPI APEI code
   because this function can be called during runtime (Arnd Bergmann).

 - Make acpi_db_walk_for_fields() check acpi_evaluate_object() return
   value to avoid accessing memory that has been freed (Nikita
   Kiryushin).

Thanks!


---------------

Arnd Bergmann (1):
      ACPI: APEI: EINJ: mark remove callback as non-__exit

Nikita Kiryushin (1):
      ACPICA: debugger: check status of acpi_evaluate_object() in
acpi_db_walk_for_fields()

---------------

 drivers/acpi/acpica/dbnames.c | 8 ++++++--
 drivers/acpi/apei/einj-core.c | 2 +-
 2 files changed, 7 insertions(+), 3 deletions(-)

