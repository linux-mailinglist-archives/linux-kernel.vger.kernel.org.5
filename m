Return-Path: <linux-kernel+bounces-112727-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C9C8D887D7E
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 16:33:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 070101C20B0F
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 15:33:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FCAF18E3A;
	Sun, 24 Mar 2024 15:33:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="NkVGcMWH"
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FB1018651;
	Sun, 24 Mar 2024 15:33:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711294387; cv=none; b=FSENSWPQ5tGxL0CXiU7gugrY16okaY3D9C/sHEWEXQBXlHztPigitkNng6wx450nlGZ8jV0x9+zzr4opVxmSKhjUikOkLcVVnZ4jsK+jrMPge6Xua9dzWliZRjgDaHZ2ZGo8lpOUi5jnhSolJUmvagivocF4UUQ1YdPudhHAT4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711294387; c=relaxed/simple;
	bh=wUAtV8wQbBO1XcNrunnboFHejfDjPcWWK1zxAkVYNI4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=im4eu2V6WKpYGlb9lVElrwx8RQnaBBq6q+pduSrW4x+/KWnzzDkgZFfdedhUbaIgS3n+AFAcOEzDrVIOExK2jiKLHNsXCMTISFfR1WqzYFmRWKAYwZ4E4RK1VE0Kq7R57DLH/PDxA5Xksgf/F29HvkA592ewMjWN623HfgXitQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=NkVGcMWH; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=2TlEn+OknbnKMHjb6XpI9hq5uQzUBuHZ9lTXfUcMn94=; b=Nk
	VGcMWHr/2wzNCPmwHvsmx+9GLsGt5NjrUwpnHMrtWL5Z9hzFLS8v3wd0ibOCK69KHdVYswtdigpbn
	3dk6rkf1r42P4xn5gy/+/Bkk+6+nQYmFRArMRe/91Kl05l0cIMRPo7cIB4bWbwCx2dr5OXlKOysXZ
	WgWcFIpuY8OcVNc=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1roPq9-00B6On-FO; Sun, 24 Mar 2024 16:32:53 +0100
Date: Sun, 24 Mar 2024 16:32:53 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Luiz Angelo Daros de Luca <luizluca@gmail.com>
Cc: Linus Walleij <linus.walleij@linaro.org>,
	Alvin =?utf-8?Q?=C5=A0ipraga?= <alsi@bang-olufsen.dk>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 4/4] net: dsa: realtek: add LED drivers for
 rtl8366rb
Message-ID: <f76754f9-4141-4d48-81e8-f43aa2dfa90c@lunn.ch>
References: <20240310-realtek-led-v1-0-4d9813ce938e@gmail.com>
 <20240310-realtek-led-v1-4-4d9813ce938e@gmail.com>
 <d064b1be-1004-487b-9944-b62d91b671c9@lunn.ch>
 <CAJq09z54+049aPL2LzAqAFigrvpchPhv_YQ6yJ5C9b9J7mngLQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJq09z54+049aPL2LzAqAFigrvpchPhv_YQ6yJ5C9b9J7mngLQ@mail.gmail.com>

> OK, I'll add _group_/_GROUP_ both to the enum name and macros. Led
> blink rate, for example, is global, used by all groups. However, it
> will be difficult to respect the 80 columns limit passing
> RTL8366RB_LED_GROUP_OFF to a rb8366rb_set_ledgroup_mode function with
> only two levels of indentation. Do you have any recommendations?

https://www.kernel.org/doc/html/v4.10/process/coding-style.html

  Now, some people will claim that having 8-character indentations
  makes the code move too far to the right, and makes it hard to read
  on a 80-character terminal screen. The answer to that is that if you
  need more than 3 levels of indentation, you’re screwed anyway, and
  should fix your program.

  Functions should be short and sweet, and do just one thing. They
  should fit on one or two screenfuls of text (the ISO/ANSI screen
  size is 80x24, as we all know), and do one thing and do that well.

Maybe you need to use more helper functions?

      Andrew

