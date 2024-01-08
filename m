Return-Path: <linux-kernel+bounces-19032-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E05AC8266FC
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 01:49:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 04C0CB21495
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 00:49:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8F52EC3;
	Mon,  8 Jan 2024 00:49:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="nrzawd0d"
X-Original-To: linux-kernel@vger.kernel.org
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8DCD4C64;
	Mon,  8 Jan 2024 00:49:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id C43EC240004;
	Mon,  8 Jan 2024 00:49:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1704674967;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/9bINBDxZTlSIxnFZAry/M5thfpfgQSmaU4fj/OySnc=;
	b=nrzawd0dsJ366U/LK6BZs/ZAo5nBmAUjwkZvjmkZ5GlHzKjhWafujTDI7RM2eXIDC4/0qF
	467HG4dOALDOahszKElWv9ZygiEe8df+6yz1H1Bskjhi5jbGKWPtDOhRq03NQpIqkGQX0P
	opErY82UofBeveuzQnCrZPITesaCNu+U4OfO0/x/6ubpopE+GseFaog2+TDwoWKf0KGJ7j
	regL+7rBMZcY5qluhJTpF5Ap/REEmNedAIXU78YHqRFFvVaCEUUbiscTiic4HxXB/djbdc
	d8dVO1Akkdnjw4YtwpPPAKdEbiNX0lptKBwHAye+3BirrObK+aud8x6xSoo1Hg==
Date: Mon, 8 Jan 2024 01:49:22 +0100
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
	linux-rtc@vger.kernel.org
Subject: Re: [PATCH] rtc: class: Remove usage of the deprecated
 ida_simple_xx() API
Message-ID: <170467494525.604370.3583249646131521858.b4-ty@bootlin.com>
References: <4f2c049cb09d46fed336e22445c71988b4f340d6.1702962419.git.christophe.jaillet@wanadoo.fr>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4f2c049cb09d46fed336e22445c71988b4f340d6.1702962419.git.christophe.jaillet@wanadoo.fr>
X-GND-Sasl: alexandre.belloni@bootlin.com


On Tue, 19 Dec 2023 06:07:12 +0100, Christophe JAILLET wrote:
> ida_alloc() and ida_free() should be preferred to the deprecated
> ida_simple_get() and ida_simple_remove().
> 
> This is less verbose.
> 
> 

Applied, thanks!

[1/1] rtc: class: Remove usage of the deprecated ida_simple_xx() API
      commit: e3d3fe7e7bf08820a83c9d9a4c38c7b29a2927f1

Best regards,

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

