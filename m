Return-Path: <linux-kernel+bounces-38581-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 97D4983C291
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 13:33:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4EB891F2291C
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 12:33:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EF8C17586;
	Thu, 25 Jan 2024 12:33:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D3S7z5wK"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D57C91640B
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jan 2024 12:33:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706185998; cv=none; b=dHZBG8JCTsHqlhfXyBfVuFAFBr8g9RFvTPE7VTqQ2Flb59s1MlsPlUbeNxFIOH5hE5KZvaDOV3LYUXsZStqQJj/oAezreinQvXLgbrwMgBrYyM+fb7lq6gZ55J6HwQaGkXe0OjKpGEu+HQPktEfRVhJmDdKNtdtfbDPSOD1q1DQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706185998; c=relaxed/simple;
	bh=+ZIgcGxowx61juEgciIIOYybB0rNzuAwgWYAyG7g1/Y=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=MOqITGzTLTRTiSNVXOhOaS70ISrI2wRyKOuDLTnt/pCQB4TrrYPznvyQpirHfniEawKdHQLxvrxV/uJLYcoAx27CaPJYSjAusGeyVAlJOuyT97io9Ie7goPQEuFkjzzAQVJCZQMlQD+EukxjDqXEJq96mxvQ+Q4inwE6F+M7Vvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D3S7z5wK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E19FEC433C7;
	Thu, 25 Jan 2024 12:33:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706185998;
	bh=+ZIgcGxowx61juEgciIIOYybB0rNzuAwgWYAyG7g1/Y=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=D3S7z5wK09f7DXaoCdbKsmQCXTwJm/wPbDVMPYkUvdZTay/PsBs3NrhNYjBeJ88VZ
	 oPdzcCqb2Ywcw0Dvihkbx7pke96XXVrPcBERsd4y6h0W6mzHRYJlQGUs4jtifCiY8U
	 KMKBzvMXHM3QzsCJWx+9kHi6imKnktxeKrQQXGQZVVSHlhMu9gg1tK1axXqaCP7Fqz
	 2JZwOGo6ALdvArCdIXSO5vhEXC9P00dhTOsHtV3IZjt/BwT/9Pg//BZFcxUfQ1QYTU
	 tFC0gvWdWRxUmcrNXW9nWd/mVlmxnlQS8x/0UPuKN6gr6T4oWT3eoetCSlfcYp+oYY
	 dAnj6VD0NQi5g==
From: Lee Jones <lee@kernel.org>
To: Eckert.Florian@googlemail.com, lee@kernel.org, 
 Florian Eckert <fe@dev.tdt.de>
Cc: sfr@canb.auug.org.au, gregkh@linuxfoundation.org, m.brock@vanmierlo.com, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20240110133410.81645-1-fe@dev.tdt.de>
References: <20240110133410.81645-1-fe@dev.tdt.de>
Subject: Re: (subset) [PATCH] leds: update led-trigger-tty ABI
 documentation
Message-Id: <170618599663.1435734.16630956766785357200.b4-ty@kernel.org>
Date: Thu, 25 Jan 2024 12:33:16 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.12.3

On Wed, 10 Jan 2024 14:34:10 +0100, Florian Eckert wrote:
> The 'led-trigger-tty' uses the same naming in the ABI documentation as
> the 'led-trigger-netdev'. Which leads to the following warning when
> building the documentation.
> 
> Warning: /sys/class/leds/<led>/rx is defined 2 times:
> Documentation/ABI/testing/sysfs-class-led-trigger-tty:7
> Documentation/ABI/testing/sysfs-class-led-trigger-netdev:49
> Warning: /sys/class/leds/<led>/tx is defined 2 times:
> Documentation/ABI/testing/sysfs-class-led-trigger-tty:15
> Documentation/ABI/testing/sysfs-class-led-trigger-netdev:34
> 
> [...]

Applied, thanks!

[1/1] leds: update led-trigger-tty ABI documentation
      commit: a612e4fcdde623fd53c635bbc57e7a23993bc548

--
Lee Jones [李琼斯]


