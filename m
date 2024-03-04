Return-Path: <linux-kernel+bounces-91180-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A5777870AB7
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 20:30:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D83531C21E67
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 19:30:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BE417995A;
	Mon,  4 Mar 2024 19:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b="H9O9cVle"
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A3B079934;
	Mon,  4 Mar 2024 19:29:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.194.8.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709580604; cv=none; b=cZ3RS5CGwckDcDWpFa5IHabb5eCnM3Tcr30Z2hajAVbyU+j3G/koiV+shkp7L9JaTU8bKA+ecrXATSHESDi28adp3KKN6RdfmwwvcYKz8EaKAo0ohnplwvNcppSDXJJhjclhLVvTATkFic+Wa5OHiQ+Cduyc55ipcJzwz08m2f8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709580604; c=relaxed/simple;
	bh=OHHQkLHOYhKzzUAIATtYY0qzmwZeAs+dZRjgbBX/R1s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HyyVI/6gB5cqjWUox8ESQKioo1H6q8+wnd4m445g4zMUVhnyYvIKKfnf+Eei+Z/T76D32boMJrewMsGWKYactfzavIJp5saX6iybaDEQAyiFEeBoNB5nePADUjvSa+xR0MqdkV8Si55YoMzLjORYCy2H9l4EC/cGePf1S529VC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it; spf=pass smtp.mailfrom=dolcini.it; dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b=H9O9cVle; arc=none smtp.client-ip=217.194.8.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dolcini.it
Received: from francesco-nb (31-10-206-125.static.upc.ch [31.10.206.125])
	by mail11.truemail.it (Postfix) with ESMTPA id 3B4A320272;
	Mon,  4 Mar 2024 20:29:57 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
	s=default; t=1709580597;
	bh=gYZ+/ZNs5fL/27laenTgswxEUSGg+HFZXtEGcfk/WM8=; h=From:To:Subject;
	b=H9O9cVlewkYHIk3S/Cj4ZSQ5uqbe4unbHVBrnYKoUOdB0fHbS4ZOkyP9HhYp2Llsi
	 +klTM/4bR/M27dzGGAZr9au1TAgEPFWH4BOqosriFlWqGmS1bECUR2eNBx728/totM
	 mijIwfXuGK6zuv+T75j5pgjoZ/t4nJF1F2tiAgiWtUz3HokTRmPsw78KevG2SPDwWW
	 MATWS6uNniA3F2V0CNWRVMnA5CYqhAh8dOHXBR3Yt903uKL4IqDdPtbxo/nhj3RNGB
	 YR6+j2AiuBFFM6JHWfBpGXiKlj/7kez9vP3/gusltez2nO6LUpoJ9QUgOlbrXNZlRb
	 ydDhF8L6/hFmA==
Date: Mon, 4 Mar 2024 20:29:52 +0100
From: Francesco Dolcini <francesco@dolcini.it>
To: Neeraj Sanjay Kale <neeraj.sanjaykale@nxp.com>
Cc: marcel@holtmann.org, johan.hedberg@gmail.com, luiz.dentz@gmail.com,
	amitkumar.karwar@nxp.com, rohit.fule@nxp.com, sherry.sun@nxp.com,
	linux-kernel@vger.kernel.org, linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v2] Bluetooth: btnxpuart: Enable Power Save feature on
 startup
Message-ID: <20240304192952.GA17410@francesco-nb>
References: <20240304170753.500074-1-neeraj.sanjaykale@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240304170753.500074-1-neeraj.sanjaykale@nxp.com>

On Mon, Mar 04, 2024 at 10:37:53PM +0530, Neeraj Sanjay Kale wrote:
> This sets the default power save mode setting to enabled.
> 
> The power save feature is now stable and stress test issues, such as the
> TX timeout error, have been resolved.

I assume that the stability issue has been fixed in firmware, correct?
What's going to happen if running the updated driver with old firmware?
What about combo Wi-Fi/BT firmware files, were those updated? I'm
currently using this driver with this firmware [1]

[1] https://github.com/nxp-imx/imx-firmware/blob/lf-5.15.52_2.1.0/nxp/FwImage_IW416_SD/sdiouartiw416_combo_v0.bin

Francesco


