Return-Path: <linux-kernel+bounces-132470-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C925089955E
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 08:31:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D54011C21ACD
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 06:31:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F9EA1CFB5;
	Fri,  5 Apr 2024 06:31:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kemnade.info header.i=@kemnade.info header.b="PEQk/ZxU"
Received: from mail2.andi.de1.cc (vmd64148.contaboserver.net [161.97.139.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBD231370;
	Fri,  5 Apr 2024 06:31:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=161.97.139.27
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712298707; cv=none; b=JrBJ8m8w/ehhHkfnUYZidbIl+mbIkpob4mGJksoWnRveI21SRKuVvZml+oHtLuUCZQKeGAkvg81lmBskijHXLLbgFznzzEAWBtPgozI4wvMRA6qPVaDnBlcyhLD6xMgQy1nzPKGouHs1clCusDEBap2lah1E957l4xHHigUz3J8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712298707; c=relaxed/simple;
	bh=K897GLuhjnsJfNkHgRNCDey+atP4zSPbOeJ4d5DFTV0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sij3FsFZ9BE0UcdXRKCxOjfKsTZudGC/35GVu1pTZ4r5SZwsdbFHOmE60OwvdTr4jlWA0/m5/tD3IDFHFmHXCh1TR1S2IMLo+XW6Li/rvuMnBIPzCmVaaAA3wdYE+d5HLPizzLKlwCz9ITx72PKr6WGvXDPr6iuChvpY9EX8TqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kemnade.info; spf=pass smtp.mailfrom=kemnade.info; dkim=pass (2048-bit key) header.d=kemnade.info header.i=@kemnade.info header.b=PEQk/ZxU; arc=none smtp.client-ip=161.97.139.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kemnade.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kemnade.info
Received: from mail.andi.de1.cc ([2a02:c205:3004:2154::1])
	by mail2.andi.de1.cc with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <andreas@kemnade.info>)
	id 1rsd70-003s36-3A;
	Fri, 05 Apr 2024 08:31:42 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=kemnade.info; s=20220719; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=rZMVeaRZwZjHm60vnokJXHYkA6h2dZHeIF5+s2NTwN8=; b=PEQk/ZxUvwZKeWgx9bzo+f9lk7
	kkRP5GpiK75WRYqBuKtTZY0GG0MqE7mNQ4J81wONOeOXfOs5cTcDsdzF6Gll27k8bjP6ObxCWqbKy
	x1czETGmMthYaiTMpvyWF++DEQtAJP6HtM3fXxwYMIuD/QHsGIG1U/EYODtkxhl2pxciuDlUIucqP
	327FQR1PytwgD0se+k21QamQhmDsHszCpJjgW3UYQcdO0ohxu0ZCj1cIVpR90TYhRgfykxdz7GtVr
	3s7OTCXI04IFBLCXlLwC5xbwXBXPmy2ul8qdyvaeKCV+H8n7fYZAxIWv0S/E0t8TJmHUKa0QQYPIc
	Wo9Llc6g==;
Received: from p2003010777026a001a3da2fffebfd33a.dip0.t-ipconnect.de ([2003:107:7702:6a00:1a3d:a2ff:febf:d33a] helo=aktux)
	by mail.andi.de1.cc with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <andreas@kemnade.info>)
	id 1rsd6x-000Oao-2e;
	Fri, 05 Apr 2024 08:31:40 +0200
Date: Fri, 5 Apr 2024 08:31:37 +0200
From: Andreas Kemnade <andreas@kemnade.info>
To: Matti Vaittinen <mazziesaccount@gmail.com>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, lee@kernel.org,
 robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: mfd: Add ROHM BD71879
Message-ID: <20240405083137.2291ea9d@aktux>
In-Reply-To: <0295c8db-b01e-45e7-b44e-79d36d81cd48@gmail.com>
References: <20240402193515.513713-1-andreas@kemnade.info>
	<20240402193515.513713-2-andreas@kemnade.info>
	<6420ac43-f200-459c-8c38-7cd55c64a155@linaro.org>
	<20240404123010.69454fda@aktux>
	<8f37211a-57ed-48ab-8de8-cd5a0d4c6609@linaro.org>
	<0295c8db-b01e-45e7-b44e-79d36d81cd48@gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 5 Apr 2024 09:01:25 +0300
Matti Vaittinen <mazziesaccount@gmail.com> wrote:

> > Yes. If there are reasons against, please briefly mention them in commit
> > msg.  
> 
> I would like to understand the rationale for allowing:
> compatible = "rohm,bd71879", "rohm,bd71828".
> 
> Is the intention to:
> 1) allow boards which tell the software that "the hardware may be 
> bd71828 or bd71879", or
> 2) to tell a binding reader that these ICs are likely to be usable as 
> replacements to each others?
> (Or, is there some other rationale beyond these?)

As far as I understand the second compatible can be a fallback for
software which does not know the bd71879 (remember the devicetree is
not only for linux). Especially if that software does not use the full
functionality of the device, like drivers in bootloaders do. E.g.
mmc drivers in bootloaders might not use high speed modes at all, so
differences in them do not matter.

Regards,
Andreas

