Return-Path: <linux-kernel+bounces-101536-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B08387A864
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 14:29:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9ED211F235BD
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 13:29:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 909D143AD5;
	Wed, 13 Mar 2024 13:28:04 +0000 (UTC)
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF2D84174F
	for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2024 13:28:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710336484; cv=none; b=Mnh48dibzcYBh9J2pbAISGA0Kr9Egjkyo7iXVKJzikQKDrqzsN7hXTT1bfKeYmUmzdbUHrg5dfyw3SZ7yJyiqRlWNkBwu0VW4mIcqJ50dRncc5g7lhr5ploXxOsirMfUTtAPy74cpKsmfbBsDciD24L9m7m4zYMDXlcmrFbY0ZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710336484; c=relaxed/simple;
	bh=nWXoeQ0vU63ggaoepGI1o9KLOR4AfeohtuPmYFdgKuA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=pt8ox/mkHhLnJfWZPduTAk/DeFlbK/b27TimlzyPSnnZiG1zjBbHkamaNXGi6HCHl6Cgw49qF34zl2H3OzZR0dTdXlbbWsgjiYGP7md2LiNXFLMRwj1k90pcJus/dlhmCl7kMMcu9g4LQTpAyed6XMwPU6lBGieykZGT0vfjOks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au; spf=pass smtp.mailfrom=ellerman.id.au; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ellerman.id.au
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4Tvrt86W1qz4x1m;
	Thu, 14 Mar 2024 00:28:00 +1100 (AEDT)
From: Michael Ellerman <patch-notifications@ellerman.id.au>
To: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, "Ricardo B. Marliere" <ricardo@marliere.net>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
In-Reply-To: <20240305-macintosh-v1-1-9c3f4f882045@marliere.net>
References: <20240305-macintosh-v1-1-9c3f4f882045@marliere.net>
Subject: Re: [PATCH] macintosh: adb: make adb_dev_class constant
Message-Id: <171033598346.517247.1715185962283268318.b4-ty@ellerman.id.au>
Date: Thu, 14 Mar 2024 00:19:43 +1100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

On Tue, 05 Mar 2024 17:13:48 -0300, Ricardo B. Marliere wrote:
> Since commit 43a7206b0963 ("driver core: class: make class_register() take
> a const *"), the driver core allows for struct class to be in read-only
> memory, so move the adb_dev_class structure to be declared at build time
> placing it into read-only memory, instead of having to be dynamically
> allocated at boot time.
> 
> 
> [...]

Applied to powerpc/next.

[1/1] macintosh: adb: make adb_dev_class constant
      https://git.kernel.org/powerpc/c/83bc680e87292f78c6e823100e417d58a66dcb06

cheers

