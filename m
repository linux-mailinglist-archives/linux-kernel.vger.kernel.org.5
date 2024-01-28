Return-Path: <linux-kernel+bounces-41988-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A5DC883FA5D
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 23:35:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 33AF5B221C3
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 22:35:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E90C4C605;
	Sun, 28 Jan 2024 22:35:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="DY5XBcTs"
Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com [64.147.123.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB08A4595D
	for <linux-kernel@vger.kernel.org>; Sun, 28 Jan 2024 22:34:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706481300; cv=none; b=qGpSg25nrBEoqyIbzU/Dmr5JLDfnJUir8JVV8Qv0EnmiyMzBx5J6avXgAhwIKU7dIyEUIzp/jAd2LWIR2vZlVpXeE1peMrM+Weh3f8qQ9ms+S39x5cJbaX6LpoPINpkRNYTdM7+OiFymeW0SBlQ7clfC2UhaoyqtxhQz5s3l/OM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706481300; c=relaxed/simple;
	bh=0cFPyEkMwRW7LWGPRa3CjFrN1T2de+1DrXN5dT6WK3E=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=U1OBaFDodjAAXCfKiLALwI2SyjiagN77yj0VzCnv8Zo+bDfM7U+IYJlXz73uJ4Q++rNRNdQE0mEckl6wyOZ4PU7c8M1kfM3tQu2lLxkFKWhvHxNdt4JtkhxxkMlM5zgZG1msxQ7P4g7oGjUiETbk0Kf68LuWFhq3Z2l7Mi9/0A0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=none smtp.mailfrom=linux-m68k.org; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=DY5XBcTs; arc=none smtp.client-ip=64.147.123.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux-m68k.org
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailout.west.internal (Postfix) with ESMTP id 2C4B43200AAC;
	Sun, 28 Jan 2024 17:34:56 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Sun, 28 Jan 2024 17:34:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1706481295; x=1706567695; bh=g12uW+xPEP7nxRNTu1rV1k935e2o
	J9MX42MHVhfS0zU=; b=DY5XBcTs45FuuMOCLbeAiSEulwUpTzVa8g2swmJYmfOR
	2uQqyfCJfbxs3mc6Cu97ndZje54fB9WBQil0AX8Z7826wPQhVnBBqEOUaIStAkqG
	N1GL41pPh7akrTey7WvhRS9yA33u6O45dUxEa822U7tzgZStP4rWoo62T2pSW8pS
	WUnFRv/ZZHoaRluGgcNZdHGWTF3XwuSZhnGttz/ltWVdVBbt9Yj6hPuB6PrlL78t
	tZH3I0r/AFTF1omfr84Wly/F0bIUoVldciL9wwWTfuDXqa97Bt/iNl5Pqd6JgQf5
	N4B5+9X4GkzBkf/Yj37jj2YIQDsMbnIAMziFCHvYMw==
X-ME-Sender: <xms:jta2ZRcYlGV6d6SMqUCACUhmSCXOH_dgy3SNbalIzTSKd4xlm7TjiA>
    <xme:jta2ZfMH3byGIXqqYUFVZZfgxumJROVLUHn8p8VADNRRYv1coS4xKU_Ax17zfsw7D
    AA_URKca6Pp6-qWaUk>
X-ME-Received: <xmr:jta2ZagMpQRU-7-Zz4wkOIxJiEiJdohw4Ro-_Tmp3mRAuTS_BceRoSmhAMlZppJYEXfTQjne2yYeNDc10mI82K-L9rt8qGQ5Idg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrfedtvddgudeiudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefujgfkfhggtgesthdtredttddtvdenucfhrhhomhephfhinhhn
    ucfvhhgrihhnuceofhhthhgrihhnsehlihhnuhigqdhmieekkhdrohhrgheqnecuggftrf
    grthhtvghrnhepleeuheelheekgfeuvedtveetjeekhfffkeeffffftdfgjeevkeegfedv
    ueehueelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    epfhhthhgrihhnsehlihhnuhigqdhmieekkhdrohhrgh
X-ME-Proxy: <xmx:jta2Za-_aOOhCnAfXlIY-Xg0pizHFaEsLINFPOKWQ5wROKTbZTiomA>
    <xmx:jta2ZdubaKMcTpZ6_YQPWy1Pn8juz34yIrLTJF724bysR3Q8hirNeQ>
    <xmx:jta2ZZG6W6jscofsfrT8WrX29Kj8IJNnPiKcfeu_xYnvwBtGJn-u9Q>
    <xmx:j9a2ZdOPTCX95bG1S_-sUi6BGMzOGlzRbgQ46C473zgLEUhFtksl2w>
Feedback-ID: i58a146ae:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 28 Jan 2024 17:34:50 -0500 (EST)
Date: Mon, 29 Jan 2024 09:34:56 +1100 (AEDT)
From: Finn Thain <fthain@linux-m68k.org>
To: Vincent MAILHOL <mailhol.vincent@wanadoo.fr>
cc: David Laight <David.Laight@aculab.com>, 
    Andrew Morton <akpm@linux-foundation.org>, 
    "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
    Yury Norov <yury.norov@gmail.com>, 
    Nick Desaulniers <ndesaulniers@google.com>, 
    Douglas Anderson <dianders@chromium.org>, 
    Kees Cook <keescook@chromium.org>, Petr Mladek <pmladek@suse.com>, 
    Randy Dunlap <rdunlap@infradead.org>, 
    Zhaoyang Huang <zhaoyang.huang@unisoc.com>, 
    Geert Uytterhoeven <geert+renesas@glider.be>, 
    Marco Elver <elver@google.com>, Brian Cain <bcain@quicinc.com>, 
    Geert Uytterhoeven <geert@linux-m68k.org>, 
    Matthew Wilcox <willy@infradead.org>, 
    "Paul E . McKenney" <paulmck@kernel.org>, 
    "linux-m68k@lists.linux-m68k.org" <linux-m68k@lists.linux-m68k.org>
Subject: Re: [PATCH v4 2/5] m68k/bitops: use __builtin_{clz,ctzl,ffs} to
 evaluate constant expressions
In-Reply-To: <CAMZ6Rq+RnY16sREhAZ6AFn3sz1SuPsKqhW-m0TrrDz1hd=vNOA@mail.gmail.com>
Message-ID: <77831c6f-7fc9-c42d-b29b-c3b2f3f5e687@linux-m68k.org>
References: <20221111081316.30373-1-mailhol.vincent@wanadoo.fr> <20240128050449.1332798-1-mailhol.vincent@wanadoo.fr> <20240128050449.1332798-3-mailhol.vincent@wanadoo.fr> <c47fedaf-cdc9-f970-460f-d2ee7e806da4@linux-m68k.org>
 <CAMZ6RqKj207uv5AF_fvb65nhCM32V=VAQXsUGLNmbeXYKPvZJg@mail.gmail.com> <9d9be9dbe92f43d2a95d11d6b2f434c1@AcuMS.aculab.com> <CAMZ6Rq+RnY16sREhAZ6AFn3sz1SuPsKqhW-m0TrrDz1hd=vNOA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII


On Sun, 28 Jan 2024, Vincent MAILHOL wrote:

> > > The asm is meant to produce better results when the argument is not 
> > > a constant expression.

Is that because gcc's implementation has to satisfy requirements that are 
excessively stringent for the kernel's purposes? Or is it a compiler 
deficiency only affecting certain architectures?

> ... The only thing I am not ready to do is to compare the produced 
> assembly code and confirm whether or not it is better to remove asm 
> code.
> 

If you do the comparison and find no change, you get to say so in the 
commit log, and everyone is happy.

