Return-Path: <linux-kernel+bounces-112447-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A4138879F4
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Mar 2024 19:36:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A15491F21695
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Mar 2024 18:36:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 012B456440;
	Sat, 23 Mar 2024 18:36:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q7euYnb+"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FBCB23BF;
	Sat, 23 Mar 2024 18:36:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711219004; cv=none; b=iJSHc2dB3xyXKc+phRXMxTJloYFR+I4nnWCa8gJEr91vCAPM0epon2YKCexnbPL09wqnpNw4TVNAaz9uKTD76cIFMTer7YlWmZt4ESQP32FkwLSd/uaWa32ClJcYElPDP4snuKPFf0n0OaOhFh7KXncrUqpApLyGsntESlmUhNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711219004; c=relaxed/simple;
	bh=HM5zQmEX8Cyws1CvVcKCjSQ2/yfz5SMsIZulXcYzZWE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FZNFe0mJPXfCAIOpm9BzK4ZL+P5AzqG1lC3OzIK2HD3BYNRgS3aPz1ecC4J4Fi0Xix3mqQiVRQcf3RfMNpEynhYoIcxsG7wSwU0kR6o+EATeIyriMHXNReJMGGEsNvRDv4ldudGV9Wvu/JrktreWUKqmhAMOdheeaTTHfkPTRY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q7euYnb+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50ADEC433C7;
	Sat, 23 Mar 2024 18:36:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711219003;
	bh=HM5zQmEX8Cyws1CvVcKCjSQ2/yfz5SMsIZulXcYzZWE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Q7euYnb+DIfEHAFmpOeYb0oCz2v8PKBJLTtl612ohAey4kR2X7Fzu3LKjStT2TUhl
	 r3o+3eQO6RoecBHp/9WRI6yvrItb7Ho+dS2SbE76UYwHc4UlJQo0IGGFJk0wRwwucu
	 psYLDoj0lFDvRVBsKepuDWA8NCB4aQf6UxnLI0pO7Yd348/YfCRTidD4XHB+zEYDFr
	 0HOQ0Z/NkHMFZx76SxZjd36GdGmIFD8Ndmg/uCdq3aOTSM1K+EwPPlOuL5yhu3TtUo
	 OndU5o3FF3ZLjy6Hh85qC+IeSNyNSfM4LdNBrMb3cvIngNr887DMXadqTZDivWwTrs
	 R6cT7axrtW1mA==
Date: Sat, 23 Mar 2024 18:36:30 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: Michael Hennerich <michael.hennerich@analog.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Jonathan Corbet <corbet@lwn.net>,
 linux-doc@vger.kernel.org, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/2] docs: iio: new docs for ad7944 driver
Message-ID: <20240323183630.6aafce66@jic23-huawei>
In-Reply-To: <20240322-mainline-ad7944-doc-v2-0-0923d35d5596@baylibre.com>
References: <20240322-mainline-ad7944-doc-v2-0-0923d35d5596@baylibre.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 22 Mar 2024 16:52:12 -0500
David Lechner <dlechner@baylibre.com> wrote:

> Adding documentation for the recently applied ad7944 driver.
> 
> Note: this also covers the features added in [1] that hasn't been
> applied yet.
> 
> [1]: https://lore.kernel.org/linux-iio/20240311-mainline-ad7944-3-wire-mode-v1-1-8e8199efa1f7@baylibre.com/
> 
> Also updating the MAINTAINERS file to catch iio documentation since this
> seems to have been overlooked.
> 
There goes deniability :)

Applied to the togreg-normal branch of iio.git.

Thanks,

Jonathan

> ---
> Changes in v2:
> - Removed some paragraphs that would be redundant for most drivers,
>   e.g. most of the buffer section.
> - Link to v1: https://lore.kernel.org/r/20240313-mainline-ad7944-doc-v1-0-7860416726e4@baylibre.com
> 
> ---
> David Lechner (2):
>       MAINTAINERS: add Documentation/iio/ to IIO subsystem
>       docs: iio: new docs for ad7944 driver
> 
>  Documentation/iio/ad7944.rst | 130 +++++++++++++++++++++++++++++++++++++++++++
>  Documentation/iio/index.rst  |   1 +
>  MAINTAINERS                  |   2 +
>  3 files changed, 133 insertions(+)
> ---
> base-commit: bbafdb305d6b00934cc09a90ec1bb659d43e5171
> change-id: 20240313-mainline-ad7944-doc-285b47ed6d35


