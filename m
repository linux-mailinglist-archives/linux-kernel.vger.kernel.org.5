Return-Path: <linux-kernel+bounces-111456-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B97E886CA1
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 14:14:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C96031C21362
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 13:14:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BC234595B;
	Fri, 22 Mar 2024 13:14:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="LYvbscrW"
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E27593FE3F
	for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2024 13:14:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711113283; cv=none; b=UtBIQkiPjDoECrQRUJ6qni8lOjBIlg4W7MxZVCNb9d9EE5xO6CUM3Kh65+pgbsvIbGvDSQ/S8SucgL78uJNQB11uPc6ItANrVwaT9RZHyJo05QWj3mZgEJg40mL4p2HBijh3WkxBLHmgceJt9XcsLFaNdtdhB6ys30HJnlqbBBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711113283; c=relaxed/simple;
	bh=qZNEGHs1Kwq2gn8k8DpiXnE1vNLz5XvMr7NXzgQ+ACw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OMIuIR+VK+Be90yBprKSaho0Sil8Uqkkv5Ew15ZbWNyVxJ62p+j30p0HL9Ac6mW4NgkOkBspmAHn9Lq+WFFBkobdm2jCCFGJpjoHxypLyLwpLV5OSYutz7yyHtXPp6/yKr902sa4zD66UtwvPgab5ULSUzM5X+ksS1XsBBuV/8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=LYvbscrW; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=vIwrXgz6mGqYH+RLNNIetaWtlUBzNHwGkAChikoCXt4=; b=LYvbscrWOzxXELMGyTRAUKsso+
	0PK0gHi6At8wOpXed5xwM//GqJVMALwzJjP3o3EnQjh3g7jywOKJIA7XrqRnTjS8a7y9szH73OZX0
	ClZU2dAjjeL0s2cRcAph0vSkNYeVDBu/e1te5+jmR9X/7Tf5z3XNwB8/w+/5xRVlASPo=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rnej2-00Axe0-LV; Fri, 22 Mar 2024 14:14:24 +0100
Date: Fri, 22 Mar 2024 14:14:24 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Arnd Bergmann <arnd@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, Arnd Bergmann <arnd@arndb.de>,
	Gregory Clement <gregory.clement@bootlin.com>,
	Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
	Marc Zyngier <maz@kernel.org>, Nathan Rossi <nathan.rossi@digi.com>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [RESEND] irqchip: armada: suppress unused-function
 warning
Message-ID: <1656dbc4-a695-4150-b24c-aeb3d6ecd77e@lunn.ch>
References: <20240322125838.901649-1-arnd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240322125838.901649-1-arnd@kernel.org>

On Fri, Mar 22, 2024 at 01:58:25PM +0100, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> armada_370_xp_msi_reenable_percpu is only defined when CONFIG_PCI_MSI
> is enabled, and only called when SMP is enabled.
> 
> Without CONFIG_SMP, there are no callers, so we get a build time
> warning instead:
> 
> drivers/irqchip/irq-armada-370-xp.c:319:13: error: 'armada_370_xp_msi_reenable_percpu' defined but not used [-Werror=unused-function]
>   319 | static void armada_370_xp_msi_reenable_percpu(void) {}
>       |             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> 
> Mark the function as __maybe_unused to avoid adding more complexity
> to the #ifdefs.
> 
> Fixes: 8ca61cde32c1 ("irqchip/armada-370-xp: Enable MSI affinity configuration")
> Link: https://lore.kernel.org/lkml/20221215170202.2441960-1-arnd@kernel.org/
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

