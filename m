Return-Path: <linux-kernel+bounces-133480-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B117889A458
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 20:42:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 519E01F215A5
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 18:42:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3788174ECB;
	Fri,  5 Apr 2024 18:41:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iFzTlWaL"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B517172766;
	Fri,  5 Apr 2024 18:41:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712342476; cv=none; b=l0d60MKdRKAZu9ts45jB9bSGD4S9zDWk8FOTYW5Wc8/VwTlzDwRC1GnFpH8Do9P+VD14aINZRw64xbIvAHM5GZo2YG9aYV0ucyffJo2NX0UVfYQyQgEPokyhXv0F5xomQrsS3mD1rd5fkO0LRDxxRFU8wFP8GBuSq1vPu9I8k30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712342476; c=relaxed/simple;
	bh=ahFnZ0vavyaYu2qL/A3OV5znLtsIcqMrPE06H3bADIA=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=rdzbdR0sxEqlviw2GcKnkBCuw3MQ4a6OXJ/mh1iMls59ZaFy6/vCftWPKWGsEPvM3ZV0yHCIuXP04ij1WkCuE5RdQI6jrRfe4wzrV4OHPTG1eT6GdRFQI6wlx6iGvd7E2a2kD01U+OduDRNcLJ6GSvpX48Xn1NoYme4aV4GYG2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iFzTlWaL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B8C0C43601;
	Fri,  5 Apr 2024 18:41:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712342476;
	bh=ahFnZ0vavyaYu2qL/A3OV5znLtsIcqMrPE06H3bADIA=;
	h=From:Date:Subject:To:Cc:From;
	b=iFzTlWaLQTeMd9XvbeleRgWhGAIQr9PUENHM8uWLJZgfbMpaxFX+71yRNICh8zl/H
	 E9F/g5+CMQD/XSKdojWjRHx2iCaMACFBZbja2nP4hnji6p3DAQGDf07JHrmROnUG0H
	 OUCCM3+3PpJUJn5mPwSsX3qw0yp/9XHF38Deh/WqlAJhnt8vfybNIs0e5+CZJl9rxm
	 vjt7JV5M5+N68zEvzN3iYAzv+A/00h6PrjJ6EDYBS7fD8nyqsNI6UzwYj16qwSlVK3
	 iol/I9BUbCNxCsjC6ttdg1cG+lJqlN/vashy7XPQIq22gKVWZhKko8KKbWlAGgcVWl
	 su5FVFmDsFbAg==
Received: by mail-oo1-f46.google.com with SMTP id 006d021491bc7-5a47680a806so732645eaf.0;
        Fri, 05 Apr 2024 11:41:16 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXwox0CeC3BQdi8vxNnJXgdxt01M/Oq8pl2CYghbhYXmlyxOwQCq+mJ/0UOuON+zNZuuBLhC8Es8npdZs906TTJXzu/Z7gJ2EU3C7jK3rc+vBIIK6yZ8u2gjP63SpAj0wslt8Mv36dUyQ==
X-Gm-Message-State: AOJu0YwlmKjwURm5CEP8YmGQkauj4EKE6mqNcjtTfAfgQvvOEav+nHab
	tJbEhKXnP/Dwwrscap7n4s3S1IrbGEo0WBIDyVWz1GSs+FjfV5hiIGZgg8S/WuvWax4F23/Pygy
	JPQbQc7FQushx0lDprTV5pSPN5Z0=
X-Google-Smtp-Source: AGHT+IGWs1c8u7OEOwNopt7d01lGeC9+Ckks5+bsi/GEKX5c7e0wX/vghKSGy2MIGCgKqoLRArct50Z9D68anlgGuww=
X-Received: by 2002:a05:6820:2b81:b0:5a6:2c6b:d3b with SMTP id
 du1-20020a0568202b8100b005a62c6b0d3bmr2688220oob.0.1712342475428; Fri, 05 Apr
 2024 11:41:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 5 Apr 2024 20:41:04 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0hHLvQWGDtwk=yXv_bJxZH2KTW2SWSUopdRDHHQp0sqow@mail.gmail.com>
Message-ID: <CAJZ5v0hHLvQWGDtwk=yXv_bJxZH2KTW2SWSUopdRDHHQp0sqow@mail.gmail.com>
Subject: [GIT PULL] Thermal control fixes for v6.9-rc3
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux PM <linux-pm@vger.kernel.org>, 
	ACPI Devel Maling List <linux-acpi@vger.kernel.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>
Content-Type: text/plain; charset="UTF-8"

Hi Linus,

Please pull from the tag

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 thermal-6.9-rc3

with top-most commit 6f824c9fccd494319988fa529601923edf5caacb

 Merge branch 'acpi-thermal'

on top of commit 39cd87c4eb2b893354f3b850f916353f2658ae6f

 Linux 6.9-rc2

to receive thermal control fixes for 6.9-rc3.

These fix two power allocator thermal governor issues and an ACPI
thermal driver regression that all were introduced during the 6.8
development cycle.

Specifics:

 - Allow the power allocator thermal governor to bind to a thermal zone
   without cooling devices and/or without trip points (Nikita Travkin).

 - Make the ACPI thermal driver register a tripless thermal zone when
   it cannot find any usable trip points instead of returning an error
   from acpi_thermal_add() (Stephen Horvath).

Thanks!


---------------

Nikita Travkin (2):
      thermal: gov_power_allocator: Allow binding without cooling devices
      thermal: gov_power_allocator: Allow binding without trip points

Stephen Horvath (1):
      ACPI: thermal: Register thermal zones without valid trip points

---------------

 drivers/acpi/thermal.c                | 22 ++++++++++------------
 drivers/thermal/gov_power_allocator.c | 14 +++++---------
 2 files changed, 15 insertions(+), 21 deletions(-)

