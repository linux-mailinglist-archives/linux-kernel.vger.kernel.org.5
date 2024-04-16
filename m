Return-Path: <linux-kernel+bounces-147756-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 065978A78A2
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 01:37:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AFA951F22378
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 23:37:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B8AD13A898;
	Tue, 16 Apr 2024 23:37:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="hsEqjb9H"
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DC8613A889;
	Tue, 16 Apr 2024 23:37:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713310658; cv=none; b=QbsFdk3B4+ZwJFgT19MwQNqmGHiHGLPHGP9/tQTYAxxhxK8Yv22ft/hoWY5mMICfgyO9/72+OLuj3rsIKibvok5nAY9qq1b7UQ5kdq0LALzynLSmtjXMcNPRRo4k4usNBfHcV79BdFJt53ZZojnSmDDKfUU4uWRzjl/QQTBe1EE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713310658; c=relaxed/simple;
	bh=Nq9yCv+TFvSoMEMcxkPDArscrYPIMDou7Z6C5MZQy/U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WjUVyUjMRmsclQGnymuMuoURTUA07FFU8mDvghEJJNEIgDi9PI8vqJ//9jukmqyDxtf9L9woCK5o46oHS1DbQ4r21zm8+4t7WnvninwhK2sze4J5RmUUylghXIEfYVCZx4nu5C0TFvc9Equ4bDefeP3kn1VtPGkkBtJu0LvF8l8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=hsEqjb9H; arc=none smtp.client-ip=217.70.183.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id C6CB640002;
	Tue, 16 Apr 2024 23:37:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1713310654;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=pQl2KeOkrlQwAMA3HrZQiABLrYEkjoNF0jZx8E0GZgo=;
	b=hsEqjb9HHaDQuWjpvdrdZWs1wDxGSMiWR2IHfkjfyIaUBRN0imiEWM61aU3tQ4Q4jePE8V
	TUMjpsSi+1vhYkGMcOQ4cW0mwd0bhkTYrLTA2xOo/pY6Y12TYXTlvkkU+ThuEKRPaUJBTa
	AdizBgwy1EOSO8qnu2on6VA1C3xYxzPu3cYgZSHxbtPWZ92LKJcaDioaIjSSPlwr+oSnuB
	34UMBlNCqC8OXHfkE8hFw5XhrkE4YBQLT25A8ATQrtrOpv/coF7BcCsogzF6FVXdnhbXjp
	WORGkZwDmR6xMW+h7VM2Xyg5wptXxymLknYLjZ4Q1MFfokdfuXs+PNHfMQtgHg==
Date: Wed, 17 Apr 2024 01:37:30 +0200
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: Luca Ceresoli <luca.ceresoli@bootlin.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Dimitris Papastamos <dp@opensource.wolfsonmicro.com>,
	Jarkko Nikula <jarkko.nikula@linux.intel.com>,
	Mihai Serban <mihai.serban@gmail.com>, linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] ASoC: dapm: improve debugfs output and introduce
 dapm-graph
Message-ID: <202404162337307fe8cc6d@mail.local>
References: <20240416-vizdapm-ng-v1-0-5d33c0b57bc5@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240416-vizdapm-ng-v1-0-5d33c0b57bc5@bootlin.com>
X-GND-Sasl: alexandre.belloni@bootlin.com

On 16/04/2024 08:00:23+0200, Luca Ceresoli wrote:
> This patch series improves the tools available to understand and debug
> DAPM.
> 
> Patches 1-2 add more information to the widget files exposed in debugfs.
> 
> Patch 3 introduces dapm-graph, a script to generate a picture of the DAPM
> state inspired to vizdapm.
> 
> Patch 1 is required for dapm-graph to work, while patch 2 allows to enhance
> its features but it is not required.
> 
> Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>

Reviewed-by: Alexandre Belloni <alexandre.belloni@bootlin.com>

> ---
> Luca Ceresoli (3):
>       ASoC: dapm: debugfs: add component to route lines
>       ASoC: dapm: debugfs: show the widget type
>       tools/sound/dapm-graph: new tool to visualize DAPM state
> 
>  MAINTAINERS            |   6 +
>  sound/soc/soc-dapm.c   |  54 ++++++++-
>  tools/sound/dapm-graph | 303 +++++++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 361 insertions(+), 2 deletions(-)
> ---
> base-commit: 5568f556e601b02d673bc7edab8de0f11815eec7
> change-id: 20240405-vizdapm-ng-c7569ffa8e58
> 
> Best regards,
> -- 
> Luca Ceresoli <luca.ceresoli@bootlin.com>
> 

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

