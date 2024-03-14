Return-Path: <linux-kernel+bounces-103493-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C7B987C038
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 16:31:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E00D71F232A6
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 15:31:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 766A371B4E;
	Thu, 14 Mar 2024 15:31:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GoHGtf4K"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B13AF51C3B;
	Thu, 14 Mar 2024 15:31:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710430264; cv=none; b=rSNVzzhN1lx9PdhkGAHE8VeZOaUQVA7jBl1C8WovfADauDdJWxdyv0A4Pn29OiPBgvz6ioYnnB3f48Bhv3t6LeXMEPoojGl7LYTtL938RtuT1e6LN+RJiqhIodiz+ev0IhfPwPrWwYTj1eAEfnLGoOaNk6DGD+k4QOYWf8TUrDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710430264; c=relaxed/simple;
	bh=P4R5rvdPbrYzDtuRH0MY+VhzazE1F5Yf9nqntNMPj0I=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ns6x6k9MrQ5DXrQQEb+j3otA54PRyLVQdtaZBjSW9YAYq0PEcHHHX3NUYbT0JtxazasPuis1mHzPIesexoWUAIvUWLkpnOwiZohvWUTJ17lNzwJckGYbt76m+NDy8IfeLBr1Ww+q20B3KapRZ6WCizIxhqDJNYFBYiyP9PYVsK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GoHGtf4K; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F66CC433F1;
	Thu, 14 Mar 2024 15:31:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710430264;
	bh=P4R5rvdPbrYzDtuRH0MY+VhzazE1F5Yf9nqntNMPj0I=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=GoHGtf4K0Ea5Bn1ObXjForkxtSUmTv7QkIjE07GRk/nKrGHZYRGwvG4GMOIB6kwiC
	 f2xOenaZCYAQuumCoKpQufcUFL1LLti3M6nNGI+pa+n2GjPtnujZNtiH+YN+P9hnOp
	 wDend5Grsh7gVrhLrJDS+zaWL3AQvClipf4XPk6lVrrohS13J7pPOvbT5a5whNxQKv
	 gghbVtlIqbq200Cz/pUF/hoymJ8KlAkAtD7QTpIOucCswnDmfJcxTCrZ79rKlqnX7K
	 Hg7FE3DjjdYhQiSBHKjHJUWJtyHQPAsFgCPxNmLGZGTwIVSlMd1VW82ZS2OUHj3hzu
	 AB3mMUqu/NM3g==
Date: Thu, 14 Mar 2024 15:30:49 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: Michael Hennerich <michael.hennerich@analog.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Jonathan Corbet <corbet@lwn.net>,
 linux-doc@vger.kernel.org, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] docs: iio: new docs for ad7944 driver
Message-ID: <20240314153049.5895703d@jic23-huawei>
In-Reply-To: <20240313-mainline-ad7944-doc-v1-2-7860416726e4@baylibre.com>
References: <20240313-mainline-ad7944-doc-v1-0-7860416726e4@baylibre.com>
	<20240313-mainline-ad7944-doc-v1-2-7860416726e4@baylibre.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 13 Mar 2024 15:21:52 -0500
David Lechner <dlechner@baylibre.com> wrote:

> This adds a new page to document how to use the ad7944 ADC driver.
> 
> Credit: the basic structure and some of the text is copied from the
> adis16475 docs.
> 
> Signed-off-by: David Lechner <dlechner@baylibre.com>

In many cases I don't think it's useful to have a per driver doc, but
for this particular part the asci art diagrams make it useful - so thanks
for putting this together.

LGTM, but I'll let it sit on the list for others to take a look.
Poke me if it looks like I've forgotten it (which I used to manage
a lot, but patchwork keeps me organized better these days!)

Jonathan



