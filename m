Return-Path: <linux-kernel+bounces-131238-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B269D8984FE
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 12:30:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E29241C2137F
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 10:30:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F292979B99;
	Thu,  4 Apr 2024 10:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kemnade.info header.i=@kemnade.info header.b="MU9K97QZ"
Received: from mail2.andi.de1.cc (vmd64148.contaboserver.net [161.97.139.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74EF826AC2;
	Thu,  4 Apr 2024 10:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=161.97.139.27
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712226632; cv=none; b=Pxs4tSu8Fr4H/iqUw8CCKE3gCK8RBJ1rq7V5j8ZBC6aythyohkVhHmWbNgyfLkS67uh5GMAASM7n/zVKZocl3HLzMOOmc2XSDppd/bB1+KsiVTqMH6PJz2yhSalJBjodkdf9QkRsPu1aqluBPnhldCqexq2lYzyVo16rhTaZV6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712226632; c=relaxed/simple;
	bh=fi23JuwtyP1lHeEIDpdepo4pa0QszQeh6JDB9hnJF0Q=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XVdN6i0uQo6m2612GNHC3HtigtdvQWo8km0h/YD8KPKLd5UEeg02Z9e1g8wi6ecMKK1Xa8+dWFtWxBNkJSS6xJVopg19/0RWwPjc1Z/MptP7wBYIUtn53Rdt8uE1gnlfctX9KMEvEmPMp5debqPXmkC+sD12bizrcuxdkAStJk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kemnade.info; spf=pass smtp.mailfrom=kemnade.info; dkim=pass (2048-bit key) header.d=kemnade.info header.i=@kemnade.info header.b=MU9K97QZ; arc=none smtp.client-ip=161.97.139.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kemnade.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kemnade.info
Received: from mail.andi.de1.cc ([2a02:c205:3004:2154::1])
	by mail2.andi.de1.cc with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <andreas@kemnade.info>)
	id 1rsKMN-003pqi-1c;
	Thu, 04 Apr 2024 12:30:19 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=kemnade.info; s=20220719; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=E/34isoAZGnKljzjMfO2Azug5qzgDqUuSHc9Kqx6JT0=; b=MU9K97QZ1KE4Jmb/EPnHKY006q
	yGTuQogwHgKuyyayE+E+84gR/O06dFH2OcUNaFZIgajcUP58rkiysNjuA2tF8W8iowr7stoqnfUXp
	hfR29wXpaPTZlRVvCoiXxnKJ0LgI4wcE14pp5vDjQa+/jtXAgmUuHBH62O8DpolJEZEqlk2xS3oVR
	uzkjCKIijYBfLm/2OYvJPnmPl0xfg+xm8/w1UjJaHaaD7h+oFRGm8tjwGp8mx1lHP62YuTeKpDaaI
	wcjygz8cpJI8eJ011BIIJ0JeCp7T9WI98zgsOC+REFiI2jqqC9HshEBK2YeaX+dJhDZ/qajds9eAN
	W3G5tETQ==;
Received: from p2003010777026a001a3da2fffebfd33a.dip0.t-ipconnect.de ([2003:107:7702:6a00:1a3d:a2ff:febf:d33a] helo=aktux)
	by mail.andi.de1.cc with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <andreas@kemnade.info>)
	id 1rsKMG-000Mjc-1M;
	Thu, 04 Apr 2024 12:30:13 +0200
Date: Thu, 4 Apr 2024 12:30:10 +0200
From: Andreas Kemnade <andreas@kemnade.info>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: lee@kernel.org, robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
 conor+dt@kernel.org, mazziesaccount@gmail.com, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: mfd: Add ROHM BD71879
Message-ID: <20240404123010.69454fda@aktux>
In-Reply-To: <6420ac43-f200-459c-8c38-7cd55c64a155@linaro.org>
References: <20240402193515.513713-1-andreas@kemnade.info>
	<20240402193515.513713-2-andreas@kemnade.info>
	<6420ac43-f200-459c-8c38-7cd55c64a155@linaro.org>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 4 Apr 2024 08:59:54 +0200
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> wrote:

> On 02/04/2024 21:35, Andreas Kemnade wrote:
> > As this chip was seen in several devices in the wild, add it.
> > 
> > Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
> > Suggested-by: Matti Vaittinen <mazziesaccount@gmail.com>
> > ---
> >  Documentation/devicetree/bindings/mfd/rohm,bd71828-pmic.yaml | 4 +++-
> >  1 file changed, 3 insertions(+), 1 deletion(-)
> > 
> > diff --git a/Documentation/devicetree/bindings/mfd/rohm,bd71828-pmic.yaml b/Documentation/devicetree/bindings/mfd/rohm,bd71828-pmic.yaml
> > index 0b62f854bf6b..e4df09e8961c 100644
> > --- a/Documentation/devicetree/bindings/mfd/rohm,bd71828-pmic.yaml
> > +++ b/Documentation/devicetree/bindings/mfd/rohm,bd71828-pmic.yaml
> > @@ -17,7 +17,9 @@ description: |
> >  
> >  properties:
> >    compatible:
> > -    const: rohm,bd71828
> > +    enum:
> > +      - rohm,bd71828
> > +      - rohm,bd71879  
> 
> In your second commit you claim they are compatible, so why they are not
> marked as such?
> 
so you mean allowing

compatible = "rohm,bd71828"
and
compatible = "rohm,bd71879", "rohm,bd71828"

Regards,
Andreas
> Best regards,
> Krzysztof
> 
> 


