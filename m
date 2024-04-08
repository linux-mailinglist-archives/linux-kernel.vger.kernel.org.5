Return-Path: <linux-kernel+bounces-135531-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F36089C73E
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 16:40:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C07041C21681
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 14:40:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED89613EFF3;
	Mon,  8 Apr 2024 14:40:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="DvciASTP"
Received: from mslow1.mail.gandi.net (mslow1.mail.gandi.net [217.70.178.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C65613CFAF;
	Mon,  8 Apr 2024 14:40:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.178.240
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712587241; cv=none; b=F2314xs8XmhCU4FTsZEIe5XlRIMQYYFi/HLtWgPmhKbwENXeluBte9ldYx67ibNKfskAmrEtoGRZanIOzldmTmT2I+Rzm5MuvqD99zq0jc6n2lFhbqKncQqJCki7KlzWu75BHlTFhE/IYgp9f94JkM9Sa1h12K48rRIlBxw7W94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712587241; c=relaxed/simple;
	bh=8X0MVOWlSi+HfrtqF9UetPVZ+u7e6t0GGlZGIkUh+fk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Bjae0jqq1p6PbtJt2NPuMiz+dMZO64+KrVv22oNzLuwMQ15o29FlerLxep3GbpPdHCHsJE302vto9RvvYA+liTsNPsqDGsamNpR1j7DmbaBLGSoil9dQta8ZNUvigCYO9fwL1sOYMrJgU9IdjSYbsO/I0DJNs3FrHOBdxgDtc1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=DvciASTP; arc=none smtp.client-ip=217.70.178.240
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from relay2-d.mail.gandi.net (unknown [IPv6:2001:4b98:dc4:8::222])
	by mslow1.mail.gandi.net (Postfix) with ESMTP id DDD8EC21C2;
	Mon,  8 Apr 2024 14:40:30 +0000 (UTC)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 8B7B040007;
	Mon,  8 Apr 2024 14:40:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1712587223;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zzXXIjVTOW/GVigtP+lIc6F2DTSKnHcKv5KIDE8o188=;
	b=DvciASTPrZ7p7Twm4rU2E4rW4lwWEthuTrCWrALitdoFetUariBc6YaLP5P1QuXkTH72o8
	lFgYvuKSTDWF86pLjBeklcMgY1o7Rule2Ql2sLReXfJDQRxHNdurKAwxB0fiAugeGi9AyK
	7XNEnw5JOfyLxFe5+khimRumVJUNQQWd35/VXJgTxinocaGKvxPOw3PE+skzhNmQKQejst
	ljkO6IEcgNx6EictOEMWWBeN+rYwocHW28XKzo+lUTexugKjee92FovMPgiO7qgpvGZtnZ
	MsEESdrndAf6HcAnMgljkhI+oUl8L2FJh0K6kaEF9T/sxaY+od6OXu2B0KSTfQ==
Date: Mon, 8 Apr 2024 16:40:21 +0200
From: Herve Codina <herve.codina@bootlin.com>
To: Saravana Kannan <saravanak@google.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki"
 <rafael@kernel.org>, Rob Herring <robh+dt@kernel.org>, Frank Rowand
 <frowand.list@gmail.com>, Shawn Guo <shawnguo@kernel.org>, Wolfram Sang
 <wsa@kernel.org>, Mark Brown <broonie@kernel.org>, Geert Uytterhoeven
 <geert+renesas@glider.be>, Rob Herring <robh@kernel.org>,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, Luca Ceresoli
 <luca.ceresoli@bootlin.com>, Thomas Petazzoni
 <thomas.petazzoni@bootlin.com>, stable@vger.kernel.org, Android Kernel Team
 <kernel-team@android.com>
Subject: Re: [PATCH 2/2] of: property: fw_devlink: Fix links to supplier
 when created from phandles
Message-ID: <20240408164021.6f13bf66@bootlin.com>
In-Reply-To: <CAGETcx-oMbjtgW-sqzP6GPuM9BwgQrYJawpui3QMf1A-ETHpvg@mail.gmail.com>
References: <20240220111044.133776-1-herve.codina@bootlin.com>
	<20240220111044.133776-3-herve.codina@bootlin.com>
	<CAGETcx_xkVJn1NvCmztAv13N-7ZGqZ+KfkFg-Xn__skEBiYtHw@mail.gmail.com>
	<20240221095137.616d2aaa@bootlin.com>
	<CAGETcx9eFuqwJTSrGz9Or8nfHCN3=kNO5KpXwdUxQ4Z7FxHZug@mail.gmail.com>
	<20240321125904.3ed99eb5@bootlin.com>
	<CAGETcx-oMbjtgW-sqzP6GPuM9BwgQrYJawpui3QMf1A-ETHpvg@mail.gmail.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-GND-Sasl: herve.codina@bootlin.com

Hi Sarava,

On Fri, 22 Mar 2024 19:00:03 -0700
Saravana Kannan <saravanak@google.com> wrote:

> On Thu, Mar 21, 2024 at 4:59 AM Herve Codina <herve.codina@bootlin.com> wrote:
> >
> > Hi Saravana,
> >
> > On Mon, 4 Mar 2024 23:14:13 -0800
> > Saravana Kannan <saravanak@google.com> wrote:
> >
> > ...  
> > >
> > > Thanks for the example. Let me think about this a bit on how we could
> > > fix this and get back to you.
> > >
> > > Please do ping me if I don't get back in a week or two.
> > >  
> >
> > This is my ping.
> > Do you move forward ?  
> 
> Thanks for the ping. I thought about it a bit. I think the right fix
> it to undo the overlay fix I had suggested to Geert and then make the
> overlay code call __fw_devlink_pickup_dangling_consumers() on the
> parent device of the top level overlay nodes that get added that don't
> have a device created for them.
> 
> I'll try to wrap up a patch for this on Monday. But if you want to
> take a shot at this, that's ok too.
> 

I didn't see anything on this topic. Maybe I missed the related modifications.
Did you move forward on that patch ?

Best regards,
Hervé

