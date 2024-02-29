Return-Path: <linux-kernel+bounces-87216-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 894F686D137
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 18:54:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 42C1228302A
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 17:54:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D29AA757F5;
	Thu, 29 Feb 2024 17:54:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iTscuO98"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 214AB651A1;
	Thu, 29 Feb 2024 17:54:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709229292; cv=none; b=VZ0Vmqa1WyZK1RLnS+z68U2pTnSy/TxrAMR2LqmcMQMxew971IMUMdHkPFoyk/gyIuAHH9LSNSPsG2zTBEmMz7IVf4BM8Ffb4p2jSaLZkrpkYk4pIVhJylCQbfWToVc1UuY7tvai/xlVTfONTOw2IE/y3pAkzU02PeC0PRV4G1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709229292; c=relaxed/simple;
	bh=wcTJ+jcw4JHQfD5Uq2LZ/uVm9cXm5XQGypXgvX5wUZ0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=gnoktyCqC/8yt81tnMRTRrxzyRWBZlgkwVtKhxygf4Z1rKbPeBK7hmp73UvGwfqKpzlYWz4YtXwnVvl5lgA/NK8WUoidnehfhHx1uPPKVqMKwbvwuCj0qI2ov3Yjzxjx/gP8gaZXccb2ZJqCITK3S39B3pqQS11hxU81IYQjvK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iTscuO98; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 930CAC433C7;
	Thu, 29 Feb 2024 17:54:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709229291;
	bh=wcTJ+jcw4JHQfD5Uq2LZ/uVm9cXm5XQGypXgvX5wUZ0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=iTscuO98vJO1y21Tyz5KLRiBR7J4pdyIJq94pLizg1TyEe+7QGAsSai9L/gJ5PLey
	 NwG7Hz3R3YjQ5GAQ0MF8A7gqLkUCpUTGtQuc9oELROVq7Q3qi5I22H32/V36mjgodE
	 59c9vmnH0J5aizaW4sGBmVAXmiFuUbgVLfvb/jgq6/4yLVXo6/UmppJyPRd/0EUH3l
	 4uCMaep8BYYacjXJmypJ8F5BYIhquO97Yjn2GPEwNTXU6FG4J17roQNmzsf0hvHJpD
	 +tJ4b3VotRrEede2ginFiPjOA4gu+DwoPLt3V6akZ+H0IOJCEXocNbMEc87b3qrgtb
	 o7D6fQznOlX9Q==
From: Lee Jones <lee@kernel.org>
To: Maciej Strozek <mstrozek@opensource.cirrus.com>
Cc: alsa-devel@alsa-project.org, patches@opensource.cirrus.com, 
 linux-kernel@vger.kernel.org, linux-sound@vger.kernel.org
In-Reply-To: <20240229155616.118457-1-mstrozek@opensource.cirrus.com>
References: <20240229155616.118457-1-mstrozek@opensource.cirrus.com>
Subject: Re: (subset) [PATCH] mfd: cs42l43: Fix wrong register defaults
Message-Id: <170922929033.1634028.9810093983638212642.b4-ty@kernel.org>
Date: Thu, 29 Feb 2024 17:54:50 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.12.4

On Thu, 29 Feb 2024 15:56:14 +0000, Maciej Strozek wrote:
> A few regs have unnecessary values in defaults, change them to match the
> datasheet
> 
> Fixes: ace6d1448138 ("mfd: cs42l43: Add support for cs42l43 core driver")
> 
> 

Applied, thanks!

[1/1] mfd: cs42l43: Fix wrong register defaults
      commit: c9e1e505cde1a8ddd0968b4d54ec2ea1937dfe00

--
Lee Jones [李琼斯]


