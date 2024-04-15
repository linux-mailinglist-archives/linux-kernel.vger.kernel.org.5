Return-Path: <linux-kernel+bounces-144673-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D57178A490C
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 09:31:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7D05C1F23655
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 07:31:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EFC1241E1;
	Mon, 15 Apr 2024 07:31:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b="sJPN5/JZ"
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E68A022EF4;
	Mon, 15 Apr 2024 07:31:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.194.8.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713166286; cv=none; b=mIkCETpnsFhg3o9STNQZUFBylI+T7cinUtuk3UNSikxgT4DvjAoX1vAk/tKe42Ao5XJQlJnL4OCjp28SWX9vdAFvuH7/yIutduiBJui7/dJ4An9CgBckpgHnzbEcKkLQFoDqN0DOyo3TLUs4DH7fKLkrFbv9ZVs7OCwYlOucw/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713166286; c=relaxed/simple;
	bh=oDv6BRxXCtYnrOXkRKjrSFTdgGWLemZJutwGxpAwXaE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GbqlysHH0Mt0faVv8nyfjpBSmSGYh9kmsesrrT7lR3b0jQMZ/PiKimobYCyejAi8523nCiByl4tYcO7P8LO+Dgg44jlVB4VQo7REAh88qvdkjtjwfaBtaV8BkDC+EyzIdr9HXTiJb4dgJCyef6pLQVpPBR4tGDOMgr+9kF/Ik08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it; spf=pass smtp.mailfrom=dolcini.it; dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b=sJPN5/JZ; arc=none smtp.client-ip=217.194.8.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dolcini.it
Received: from francesco-nb (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
	by mail11.truemail.it (Postfix) with ESMTPA id F27BD1F91E;
	Mon, 15 Apr 2024 09:31:13 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
	s=default; t=1713166274;
	bh=9bgbSLn8w7LWy5U13HiOlSznXVfDMLIhp3YYmdC9IC4=; h=From:To:Subject;
	b=sJPN5/JZbaoZdLIEg+4BSESHRIS4CKUd8MKjoUxYZXmaxqMjX6ffqxhks8m7U4iaA
	 dAuduXNt6fETQJUNZYO8Hd/wdDN6QVfYdzI7LQ1Bd4nmwvOre+7jL5sLe4PTk1x1IV
	 NKScLbOZcajW9j+cfTzVCpBt62Yon39qkpKtLzPFD7mB2Kbxgc+JsY1tz1U1vs5eU4
	 uR/58k4ceTR2Agl+fMqwRlXZAskTppgpGxPQ0STKWa/z5a4zgN/VDtJFNNqLGM54bd
	 yNYk3CD4D8nYsfmNmk3ayDNYNPpPDOWpC7waMcs6Ox1wUz11k37qInsgvqHRfFDhRh
	 FqG+O3V+NT2/w==
Date: Mon, 15 Apr 2024 09:31:10 +0200
From: Francesco Dolcini <francesco@dolcini.it>
To: Udit Kumar <u-kumar1@ti.com>
Cc: nm@ti.com, vigneshr@ti.com, linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org, kristo@kernel.org, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/4] arm64: dts: ti: k3-j784s4-evm: Arranging mux and
 macro update
Message-ID: <20240415073110.GA7360@francesco-nb>
References: <20240415063329.3286600-1-u-kumar1@ti.com>
 <20240415063329.3286600-2-u-kumar1@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240415063329.3286600-2-u-kumar1@ti.com>

Hello,

On Mon, Apr 15, 2024 at 12:03:26PM +0530, Udit Kumar wrote:
> Updating J784S4 macro for pin mux instead of J721S2.
> 
> Also arranging pin mux in order of main_pmx0/1, wkup_pmx0/1/2/3
> along with fixing pin type for TX as output of wkup_uart.

Are you doing a refactoring + fixes in the same commit or I
misunderstood your commit message? 

If this is the case I would suggest to have separate commit for the fix
and the refactoring, with the fix being first in the series and with a
fixes tag.

From a quick look, this comment may apply to other commits in the
series.

Thanks,
Francesco


