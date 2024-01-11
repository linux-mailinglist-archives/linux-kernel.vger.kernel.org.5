Return-Path: <linux-kernel+bounces-23367-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B2AD682ABB0
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 11:14:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7C1F41C2568E
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 10:14:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D226512E6C;
	Thu, 11 Jan 2024 10:14:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="onqAaDev"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EF8E12E5F
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jan 2024 10:14:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1C4FC433F1;
	Thu, 11 Jan 2024 10:14:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704968088;
	bh=SOZGmnEqJnw4Dndn0p0hDwSju4DSY08aFotbvMyXmjo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=onqAaDevMuTvxw0D1EPQYn5BwqY8zxxZXTtVbC038YjmEO2Rl5GxNqdNs7hqnwIrY
	 6xpqsehz6mcHFWM4w+deDL+4ISCbdLA/Vi5QTzflVEQ6rTZgjqsx/75pTgmXUNr483
	 +3MLhuLWAjGjWAyLB/4p17nDRGf492GBaLh6qQAjoPMHk4xcHII/Kp8lGHuVbtSxvf
	 1PKDejm1zK8mNArTgKGSX20ewaP906eVt1qKgkzFtr4RQszu84+OMr1KeI3XhTAQMO
	 RhLWzo4zs1Nu2MjPrUDJtkpGrL2k7l1kfEjEmcfuqLAtCfIYUjPxoRsgsyoX2+0DCt
	 zzOU4uZmTOMYg==
Date: Thu, 11 Jan 2024 10:14:44 +0000
From: Lee Jones <lee@kernel.org>
To: Aleksandrs Vinarskis <alex.vinarskis@gmail.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-kernel@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH v4 1/2] mfd: intel-lpss: Switch to generalized quirk table
Message-ID: <20240111101444.GO7948@google.com>
References: <20231221185142.9224-1-alex.vinarskis@gmail.com>
 <20231221185142.9224-2-alex.vinarskis@gmail.com>
 <20240111101409.GN7948@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240111101409.GN7948@google.com>

On Thu, 11 Jan 2024, Lee Jones wrote:

> On Thu, 21 Dec 2023, Aleksandrs Vinarskis wrote:
> 
> > Introduce generic quirk table, and port existing walkaround for select
> > Microsoft devices to it. This is a preparation for
> > QUIRK_CLOCK_DIVIDER_UNITY.
> > 
> > Signed-off-by: Aleksandrs Vinarskis <alex.vinarskis@gmail.com>
> > ---
> >  drivers/mfd/intel-lpss-pci.c | 23 +++++++++++++++--------
> >  drivers/mfd/intel-lpss.c     |  2 +-
> >  drivers/mfd/intel-lpss.h     |  9 ++++++++-
> >  3 files changed, 24 insertions(+), 10 deletions(-)
> 
> An RB from Andy would make for an easy apply.

Nevermind, I found it!  Old eyes!!

-- 
Lee Jones [李琼斯]

