Return-Path: <linux-kernel+bounces-23366-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 46EB182ABAC
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 11:14:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EA0622856AE
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 10:14:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2188914F69;
	Thu, 11 Jan 2024 10:14:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Kj2J1u1l"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7192614F60
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jan 2024 10:14:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 002E8C433F1;
	Thu, 11 Jan 2024 10:14:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704968053;
	bh=sFeHsNR73jBu45m9fAaxoxQiDSkmC8MvNj3PulTZ3sE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Kj2J1u1l0rfPT/aahHntHGRqvpd8s/n8QPpbdLLqIj5k3yL9+RZZLo54maRwAS5h6
	 CM2ku1MwxxFx8hU7cNcNDsPzKgZrcXXVKCn/NgUo2NYN1W3QzIU3c3VkGnk3qimMEp
	 B6FRF07b4GYj+mRsPjOtzxNY+PfDmXB5/PuYsVN1hkflmkoj/9ZE64iGiMhYtvPccV
	 H85dGoHOaoBMLW56ndBFHwzJ3vW7JszBiFaqSEZrW7mAt/jIFGzwKx2K09aGkLgaKg
	 efQ7iJune57Yil3eBAqENSty5ikhcO4cVZCmZP8jB5E8ixmzp6m02B/3uqLgWd02+K
	 SJ4bQMfkltyEQ==
Date: Thu, 11 Jan 2024 10:14:09 +0000
From: Lee Jones <lee@kernel.org>
To: Aleksandrs Vinarskis <alex.vinarskis@gmail.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-kernel@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH v4 1/2] mfd: intel-lpss: Switch to generalized quirk table
Message-ID: <20240111101409.GN7948@google.com>
References: <20231221185142.9224-1-alex.vinarskis@gmail.com>
 <20231221185142.9224-2-alex.vinarskis@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231221185142.9224-2-alex.vinarskis@gmail.com>

On Thu, 21 Dec 2023, Aleksandrs Vinarskis wrote:

> Introduce generic quirk table, and port existing walkaround for select
> Microsoft devices to it. This is a preparation for
> QUIRK_CLOCK_DIVIDER_UNITY.
> 
> Signed-off-by: Aleksandrs Vinarskis <alex.vinarskis@gmail.com>
> ---
>  drivers/mfd/intel-lpss-pci.c | 23 +++++++++++++++--------
>  drivers/mfd/intel-lpss.c     |  2 +-
>  drivers/mfd/intel-lpss.h     |  9 ++++++++-
>  3 files changed, 24 insertions(+), 10 deletions(-)

An RB from Andy would make for an easy apply.

-- 
Lee Jones [李琼斯]

