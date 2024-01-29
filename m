Return-Path: <linux-kernel+bounces-42949-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D0D4B840928
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 15:59:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3B19728BDE1
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 14:59:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C01B6152DEC;
	Mon, 29 Jan 2024 14:58:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="zi/GyC4z"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3FF0153516;
	Mon, 29 Jan 2024 14:58:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706540330; cv=none; b=JhgIVDhf4PEdueqRfgpyaP7DzkVEaxU69A+pmg3WfvtAXez8RkSCQdZYUld4YpfIY9ANTSGEl3isVTDsN24AjIP9fkTGBitbIxXdJnS/suR4b5UkgCaO9WRbHiDWR0pK9eoJRLnHlzZbS2fyp8DYG/OAk6iyECCATu9ickYOlMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706540330; c=relaxed/simple;
	bh=URo/fOTMMhuXS6QDqp8DWouPHKt9fwcNin6WyF3JYfw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SQ5Cwc8ZIYT+yEc6siqLbxuy5VvFTFxuPk153GCZzw4cnwfIZCd3r1kuRtXmmXF4cu0vsdFQJFbKHXKGtttUgNxQezUr2/ME853qeQqgXgTO/lEyIstrbHmKJRE1yZ4DI0De3iToRzUnIwljVlDC2Daw7e79kiMnELSLmW80LEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=zi/GyC4z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76CFAC43394;
	Mon, 29 Jan 2024 14:58:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1706540329;
	bh=URo/fOTMMhuXS6QDqp8DWouPHKt9fwcNin6WyF3JYfw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=zi/GyC4zdRABxTz4RY6cq5x1iYWhgsm1P2aRkgPIxAbU7Jd4dBGB2IQFvkiSxaiJq
	 WtRjO8u4LBHlo6zJVPjtBV7VRXch7iSACAcBtqTXjRvlAc4vCzZ6NC71IWgLl4N9Gu
	 kuVKKFl4ABdI49e9Go1ZBigaQruS/4Efymbbj8G4=
Date: Mon, 29 Jan 2024 06:58:50 -0800
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Andreas Larsson <andreas@gaisler.com>
Cc: Alan Stern <stern@rowland.harvard.edu>, linux-usb@vger.kernel.org,
	Rob Herring <robh@kernel.org>, linux-kernel@vger.kernel.org,
	software@gaisler.com
Subject: Re: [PATCH] usb: uhci-grlib: Explicitly include
 linux/platform_device.h
Message-ID: <2024012943-print-wronged-e884@gregkh>
References: <20240122082225.984523-1-andreas@gaisler.com>
 <2024012740-amaretto-unvarying-465a@gregkh>
 <b6b66bed-10f1-421a-a561-3e07dcbd6781@gaisler.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b6b66bed-10f1-421a-a561-3e07dcbd6781@gaisler.com>

On Mon, Jan 29, 2024 at 08:41:50AM +0100, Andreas Larsson wrote:
> On 2024-01-28 01:31, Greg Kroah-Hartman wrote:
> > On Mon, Jan 22, 2024 at 09:22:25AM +0100, Andreas Larsson wrote:
> >> This fixes relying upon linux/of_platform.h to include
> >> linux/platform_device.h, which it no longer does, thereby fixing
> >> compilation problems like:
> >>
> >> In file included from drivers/usb/host/uhci-hcd.c:850:
> >> drivers/usb/host/uhci-grlib.c: In function 'uhci_hcd_grlib_probe':
> >> drivers/usb/host/uhci-grlib.c:92:29: error: invalid use of undefined type 'struct platform_device'
> >>    92 |  struct device_node *dn = op->dev.of_node;
> >>       |                             ^~
> >>
> >> Fixes: 0d18bcdebb2f ("of: Stop circularly including of_device.h and of_platform.h")
> > 
> > I don't see this commit id in Linus's tree, where is it?
> 
> Ah, sorry, it went into Linus's tree with a different commit ID. I
> should have referred to ef175b29a242.

Please fix up and resend.

thanks,

greg k-h

