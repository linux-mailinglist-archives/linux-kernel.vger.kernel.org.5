Return-Path: <linux-kernel+bounces-153468-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E77D48ACE75
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 15:38:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 734D5B24171
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 13:38:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89EB6150984;
	Mon, 22 Apr 2024 13:38:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="aNzX6kRK"
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 848A513E8B2;
	Mon, 22 Apr 2024 13:38:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713793103; cv=none; b=RGK1FTkv0icDjlrbOj5/KKjoDKO2L+gD9VREddpSWlhFx2MsWiUwok6H0BOA1MB2w4xk+X0y7UJD4jo7G84MGgNYF6UmdPmYNI7n4VzQdEyQsmTEE5TKLhVDNdjklkIuNzybFNlLxKVsZk2wmEH7bBeHdfpRMYmq0VbcniE8sgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713793103; c=relaxed/simple;
	bh=1EHewe849FDvpKAciNsMRNp+NNLA9ySdIhs+MKUlUg8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qmwjcriCLEk96eSwIBTZ97HRCUp6rXfFI4i1BMoD/JeHjVx7YiZoSvh9RQpw7whRG/YgojbZZoh2kueuG4/11iOoJUzewv7SgmW99SehEqjP8TWICY2/e7KozLDCAPxcCQBGEYtaT+IOCwWZPYlOFqsEe+eBymwjDEXCnPvY8zc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=aNzX6kRK; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=xthIm2+XJziqm/i945Kfvh8l2zb6qAHn14WQ6VKNlhQ=; b=aNzX6kRKbVPv/m44o/jS3L/nJq
	bQqYdRBZhg87hosxX4scINxpve9EWqdlLphLWMyqspKiJSrG5YHUuZ4QMw3LgAzcb7rTCWSJKFHKs
	elT18a4kmeSdlpa+GofUhuHJqXTXogNmMdBC11v4bODv9XmFmwHgT+ql2GZyU1gHcOf8=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1ryts9-00DcaU-LO; Mon, 22 Apr 2024 15:38:17 +0200
Date: Mon, 22 Apr 2024 15:38:17 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Josua Mayer <josua@solid-run.com>
Cc: Gregory Clement <gregory.clement@bootlin.com>,
	Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, Rob Herring <robh@kernel.org>,
	Yazan Shhady <yazan.shhady@solid-run.com>,
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH v3 2/4] dt-bindings: arm64: marvell: add solidrun cn9132
 CEX-7 evaluation board
Message-ID: <f31301c1-3e47-41bd-99f1-aac367f6c368@lunn.ch>
References: <20240414-cn9130-som-v3-0-350a67d44e0a@solid-run.com>
 <20240414-cn9130-som-v3-2-350a67d44e0a@solid-run.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240414-cn9130-som-v3-2-350a67d44e0a@solid-run.com>

On Sun, Apr 14, 2024 at 02:58:33PM +0200, Josua Mayer wrote:
> Add bindings for the SolidRun CN9132 COM-Express Type 7 evaluation board.
> The CEX is based on CN9130 SoC and includes two southbridges.
> 
> Because CN9132 and 9131 are just names for different designs around the
> same SoC, no soc compatibles beside marvell,cn9130 are needed.
> 
> Signed-off-by: Josua Mayer <josua@solid-run.com>
> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

