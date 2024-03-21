Return-Path: <linux-kernel+bounces-110293-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 66877885CD6
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 17:02:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 19EC51F21E24
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 16:02:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B56F912BF24;
	Thu, 21 Mar 2024 16:02:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OXQuAqmG"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04EB912BF1A
	for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2024 16:02:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711036949; cv=none; b=jBsDcg3kyHtTr2t5G7K2MGvU9ckmqzm9N4ZbZHB/lXFX9KqpxUVQ/hkFKu6O2+gbUpxUFhx3jhixh3mTs6tIgk1JGVAlQy8uDmvryybR91BkMUhs4BU8HB3IYwltYdobhArr2X27Y2Pu9UFft1Qd8NzqYFKMclempj31RvRA5og=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711036949; c=relaxed/simple;
	bh=HrtgmLIfIWUBhGKPEXt+g86h6IDJNxP3q50KUyu2qMk=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Kj8BG2/ifluYoEuq7OJIWqMkoS26oYLTpxTOKPS222c+DqxgubxS9478ftOzLRj034fimF8uOslEA2uVWnYYbqOAYWRjCZnZ9KRWCMmeBgj7G6qNQ0lCFNIhxFqV4KG8vqrcgi0yL7dmAcZU7P8Ibrepf6zFZP6uNLytoAUyVAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OXQuAqmG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8C4CC433F1;
	Thu, 21 Mar 2024 16:02:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711036948;
	bh=HrtgmLIfIWUBhGKPEXt+g86h6IDJNxP3q50KUyu2qMk=;
	h=From:To:In-Reply-To:References:Subject:Date:From;
	b=OXQuAqmGkxuIdOpJmrmNi6swYcdCLKNFFfznFmtVkwTrlcVWn4crvzX1zvq2NLCBK
	 mS8KBrKPANfnLmPj6Dh0tc5HdEEJMNX6G/YoZkq0CFgekx6oG/YHcK5jKaVUta0D1Z
	 nIPS8611cpYtwjjZMoVd/P1qFPN+Kfhw89X6+wzT2U5eUh2/C+AHC3lX//IpkRx8p1
	 ctyoYF4w7gfYPeyc4V/0HiNGx+/qktTYt9IfAwEnO9fFoORNFy4lGl5bA1MqVSS7qP
	 pFmSFHlkrUpb22knScC18W21/05Q1cb61o77Cu1dKronSkCySp3ksqZQZ6rSfVFNAc
	 SolIgX4OomqEw==
From: Lee Jones <lee@kernel.org>
To: Lee Jones <lee@kernel.org>, linux-kernel@vger.kernel.org, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>
In-Reply-To: <20240312165905.1764507-1-andriy.shevchenko@linux.intel.com>
References: <20240312165905.1764507-1-andriy.shevchenko@linux.intel.com>
Subject: Re: (subset) [PATCH v1 1/1] mfd: intel-lpss: Switch over to MSI
 interrupts
Message-Id: <171103694768.83664.9898972271035200143.b4-ty@kernel.org>
Date: Thu, 21 Mar 2024 16:02:27 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.12.4

On Tue, 12 Mar 2024 18:59:05 +0200, Andy Shevchenko wrote:
> Some devices support MSI interrupts. Let's at least try to use them in
> platforms that provide MSI capability.
> 
> 

Applied, thanks!

[1/1] mfd: intel-lpss: Switch over to MSI interrupts
      commit: c3bb2ec530c7dd358222838c3fdc04c178237db3

--
Lee Jones [李琼斯]


