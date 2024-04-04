Return-Path: <linux-kernel+bounces-131213-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C600C8984A2
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 12:05:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 01E271C21F19
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 10:05:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7147E74C17;
	Thu,  4 Apr 2024 10:05:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rtdcZlin"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEFF78F7D;
	Thu,  4 Apr 2024 10:05:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712225148; cv=none; b=C/IWY81nn1TQHarU+i/JVK8OO4nJVjt54JTTG6GcJ8NgonizG2ClIL8Rp9CUp0fVmuLwZWDMqklxWoPq28/nqNeWpsgQLvnBLxsQ35Ufaa+wiiv6IfzxmsBSH8LTQ1egMtMHB1PZedPiUObiGx7fXhxbBtQ6MI4kSPbwB7o0gYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712225148; c=relaxed/simple;
	bh=SMwANtbw6TFtzOiI5CiblchYkN5X389DW6eKfwxQnJ0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MWFCLrifvZgu2QRHsiWPnTWJw8Yn+P9rYYGLYH3kORGtRxeJH1lEzt3FijaDo2UjR9r3GlGjx/dSw2feIGxDYqhFCM/qSDb0oRplnUbfEN2OuDXIgFBwFvb86E3/OV3LlV5W6rnzQ1OsI/td7afIhX7aZoi1LI0a7qgV7lCOj2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rtdcZlin; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8BD4C433C7;
	Thu,  4 Apr 2024 10:05:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712225148;
	bh=SMwANtbw6TFtzOiI5CiblchYkN5X389DW6eKfwxQnJ0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rtdcZling1hQuYen2XhnKeoF694hLs82lIdwA2ENczGAp3LdK8gd9t47ogsQDIOnx
	 ApM6/Ntd3ldW+Vyh5d9GQ6ikgZoVY31nJ8hZ7F8mba+Xc7X2DGqE14wtPiyGv5aHCv
	 RURw76iXbMCu7G5ali4J3CirPgsRaMNy7G5JNm6JwtZ7p5gtIWEepi7rSGsK7wNiCV
	 pp3DTmlqoXh3Bo40mocAkvEqBv/9FIsqUugRrTNrjYq/Sxw75T0XAIev+EAk3ZS7mP
	 cgmrxN7gXxGbVpVC/+hRlauSnY2I/vTtCLk09xwQ8Qfew4J+teIY77lrEsMHvVQaUJ
	 n5GUujhjCniLA==
Date: Thu, 4 Apr 2024 12:05:43 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Niklas Schnelle <schnelle@linux.ibm.com>
Cc: Damien Le Moal <dlemoal@kernel.org>, linux-ide@vger.kernel.org,
	Arnd Bergmann <arnd@kernel.org>, Heiko Carstens <hca@linux.ibm.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] ata: add HAS_IOPORT dependencies
Message-ID: <Zg57dww6ap9zEwy7@ryzen>
References: <20240404092936.3127972-1-schnelle@linux.ibm.com>
 <20240404092936.3127972-2-schnelle@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240404092936.3127972-2-schnelle@linux.ibm.com>

On Thu, Apr 04, 2024 at 11:29:36AM +0200, Niklas Schnelle wrote:
> In a future patch HAS_IOPORT=n will disable inb()/outb() and friends at
> compile time. We thus need to add HAS_IOPORT as dependency for those
> drivers using them.
> 
> Co-developed-by: Arnd Bergmann <arnd@kernel.org>
> Signed-off-by: Arnd Bergmann <arnd@kernel.org>
> Acked-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
> Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>
> ---

Reviewed-by: Niklas Cassel <cassel@kernel.org>

