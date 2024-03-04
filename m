Return-Path: <linux-kernel+bounces-90963-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DDBB38707AD
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 17:53:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1B15E1C21A15
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 16:53:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A1B26025A;
	Mon,  4 Mar 2024 16:52:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b="j6ZV8KqJ"
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 305655C5F3;
	Mon,  4 Mar 2024 16:52:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.194.8.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709571154; cv=none; b=o3SIwwM502Mt8BL+hPg9lpuZRbGuLU/+1/UWXDkmSz7Ckvm7rAZRP48OiJdZW38PlTtpUsTM9aT8hfGgvm6wb1MuvVbPwxfN5SGO0hIT78jotdeNo0xiVxLY7nrNQ7jaF3P4nwA21UuKLeJ4CvZmIPwLG8q3gu8TGVdpIGvuGfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709571154; c=relaxed/simple;
	bh=jGxmwGSIl7tuc8+rfHyGnfHMlZ/+hS4235WbUDm3wVU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PXGbFO6+KnNbkgCdKTlyZgK7hshVMlVqEqX8Nkl8OcJ9sZ5pvi0J0/ugwfw3vdqGi2KYAQA7KY9e0UV8FbwbiLotlj3kaZoG0oUG8UTjjqHRhozDK/aSGwkQmw31g4BYGqJvZYW9eW8Hwhp8TN934eAyspX6BUy0gQkDWxBBq5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it; spf=pass smtp.mailfrom=dolcini.it; dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b=j6ZV8KqJ; arc=none smtp.client-ip=217.194.8.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dolcini.it
Received: from francesco-nb (31-10-206-125.static.upc.ch [31.10.206.125])
	by mail11.truemail.it (Postfix) with ESMTPA id F0B0F1F843;
	Mon,  4 Mar 2024 17:52:19 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
	s=default; t=1709571140;
	bh=TU+KnY/l5ZMvBUlG7xkTv0umnHHuyUr5GT5n3D8znCo=; h=From:To:Subject;
	b=j6ZV8KqJ6r9cHlnECDlf8h0OVY55oWYEUO5LmrwRxET0dx+MBYsCLWi+pDHZwYja9
	 lVaSLRfa2H9SFG9hWxIXsncUF8rU7WICYs9q3oY9jH4AAKjgTopXzTJuEPmPHn6Vrf
	 XouJS1XLGGulIx68O0ZNOPbbUo0cUvhkUH1NCuLfe1/DXL8vl3zzyulCIaVmkAmJ5B
	 gW2vNBsq5PHHR6991aS+r3x9dkCjGUfUWUBL+TV1pCbjM4fplsWdX0h5nzYK8HIiRC
	 BzL09dULFK8xHKnlbdcJqQpTzfeXoAEo+SvP3t62Oa+iNw/2isDBgiQsrXkGxvVaKf
	 hfGGQ64Z20B0A==
Date: Mon, 4 Mar 2024 17:52:15 +0100
From: Francesco Dolcini <francesco@dolcini.it>
To: Francesco Dolcini <francesco@dolcini.it>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Cc: linux-bluetooth@vger.kernel.org, Sherry Sun <sherry.sun@nxp.com>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	Neeraj Sanjay Kale <neeraj.sanjaykale@nxp.com>,
	linux-kernel@vger.kernel.org, Marcel Holtmann <marcel@holtmann.org>,
	Marcel Ziswiler <marcel.ziswiler@toradex.com>,
	Amitkumar Karwar <amitkumar.karwar@nxp.com>,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Marcel Ziswiler <marcel@ziswiler.com>
Subject: Re: [PATCH v1 1/2] Bluetooth: btnxpuart: Fix btnxpuart_close
Message-ID: <20240304165215.GA11208@francesco-nb>
References: <20231018145540.34014-1-marcel@ziswiler.com>
 <20231018145540.34014-2-marcel@ziswiler.com>
 <ZWEG40nzRhm6oVEq@francesco-nb.int.toradex.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZWEG40nzRhm6oVEq@francesco-nb.int.toradex.com>

Hi Luiz,

On Fri, Nov 24, 2023 at 09:26:11PM +0100, Francesco Dolcini wrote:
> On Wed, Oct 18, 2023 at 04:55:39PM +0200, Marcel Ziswiler wrote:
> > From: Marcel Ziswiler <marcel.ziswiler@toradex.com>
> > 
> > Unfortunately, btnxpuart_close() may trigger a BUG: scheduling while
> > atomic. Fix this by properly purging the transmit queue and freeing the
> > receive skb.
> > 
> > Fixes: 689ca16e5232 ("Bluetooth: NXP: Add protocol support for NXP Bluetooth chipsets")
> > 
> > Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>
> > ---
> > This is the kernel trace this commit fixes:
> > [   29.270685] BUG: scheduling while atomic: kworker/u3:0/55/0x00000002
> 
> I just hit this bug with 6.7-rc2, I think it would be worth to
> apply this fix.

Do you need any change for having this patch (1/2) applied? Do you want this
to be re-sent without the second patch (2/2) from this series that is
maybe more controversial?

Let me know how I can help,

Thanks,
Francesco


