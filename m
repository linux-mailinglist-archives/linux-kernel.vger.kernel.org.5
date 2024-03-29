Return-Path: <linux-kernel+bounces-125105-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CF2D89203B
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 16:19:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EFB82B3748A
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 15:18:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B9901386DC;
	Fri, 29 Mar 2024 15:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="kp9Of4ua"
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 780911327E2;
	Fri, 29 Mar 2024 15:00:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711724409; cv=none; b=NixbH9mWlKrQbgTjmYHAfkAfv2ZfdwKARYXSXEVv62N6cx4QPaQujmRX8xQFWd8TS5n1IUoPO93cznfSPMKrxPXrKOGRLCxTkXoJHIqWGp1VfDjqnYbPllbdGxwBr3A+9wI9YQKODjI7ezcK6VIZOndfI5+RS0E1T+vY7s+o+4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711724409; c=relaxed/simple;
	bh=xiJYibBt4mATTF+/F9qQBqo73xzYuvvMoo966DU8xYU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SosrMe4fwWCILNcDJJBpp/wAuYYs1xNlE1cjJ7MFcc9IJaxA3tyTqZA8QM5hZzHBA5OoOllQi6cc3wiXybx8U5p+w/Jz2ZCfUzJl0VowcM5ozpooc0Ocac/9L4qX01qlfsXXMFSYRfOb2+k880m8UvmcETwFt4GhTqEAe+713c4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=kp9Of4ua; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 8D0862000A;
	Fri, 29 Mar 2024 14:59:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1711724399;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=70fRv3S4p3jpgudcra18IGGuls9BjP38bw0X/xcQ+NA=;
	b=kp9Of4ua4u/9pk8ZAh/3eSrKka9lgVebaaN0lgwTubZf6P1Jc1N5s4Vu4CaKkluvxX31bA
	fsrYruiE7+DinPEMGXI6yEdlxOxitgajqxVV//PHUJy5WzWLkI6yJAthSuGSAee/jMHhkd
	Igv6DvlCCC1FWMA1I9002aVtjOi65Kfp5xg8EwfhlSneE1A8DdeFZcsGDURfXhfUxuSEjp
	81+W7mV0eL7xn0ps+oWkat04PHFryW7T3UNeFvbCHxOq8F/CS5tkg2m7BOIweVUJrA6ve0
	d7+2W0IElFAH2AK42lUrinMTP0SnVMRxnmszQZlGFhwjSfQhi9l7RBl3owXgsA==
Date: Fri, 29 Mar 2024 15:59:58 +0100
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: avifishman70@gmail.com, tmaimon77@gmail.com, tali.perry1@gmail.com,
	venture@google.com, yuenn@google.com, benjaminfair@google.com,
	KWLIU@nuvoton.com, mylin1@nuvoton.com,
	Mia Lin <mimi05633@gmail.com>
Cc: openbmc@lists.ozlabs.org, linux-rtc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 0/1] rtc: nuvoton: Modify part number value
Message-ID: <171172436465.1832232.12409120687199982859.b4-ty@bootlin.com>
References: <20240311013405.3398823-1-mimi05633@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240311013405.3398823-1-mimi05633@gmail.com>
X-GND-Sasl: alexandre.belloni@bootlin.com

On Mon, 11 Mar 2024 09:34:04 +0800, Mia Lin wrote:
> Changes since version 1:
>   rtc: nuvoton: Modify part number value to match datasheet definition.
> 
> Mia Lin (1):
>   rtc: nuvoton: Modify part number value
> 
> drivers/rtc/rtc-nct3018y.c | 15 +++++++++------
>  1 file changed, 9 insertions(+), 6 deletions(-)
> 
> [...]

Applied, thanks!

[1/1] rtc: nuvoton: Modify part number value
      https://git.kernel.org/abelloni/c/8b59a11fb8e6

Best regards,

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

