Return-Path: <linux-kernel+bounces-119708-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DC7788CC4B
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 19:48:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2D6D01F8541D
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 18:48:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8658313CAB6;
	Tue, 26 Mar 2024 18:47:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ttMtnRQf"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA8A213C836;
	Tue, 26 Mar 2024 18:47:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711478834; cv=none; b=qkA4V3GIf6jRAPeI8LzhZB/xOM2Bci3L85vMrmByHoNQj2TcFNWkIGk7zws+cWDft2SCe3qiLYoJLzjsDVLFa8PrR4dxu3VZhu0E0QJvyQ3zJ1hDkOftI1ZkJAtQg5H9xjJHC6Ay3XSNQNWgmuud8CJRWZmrRPSXlLn1cujBr5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711478834; c=relaxed/simple;
	bh=mluiAor2f4Fl8dUvJLJjVtfHfDF4072q/JzfzNuHlmY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i3ih9tNghvlRNzVR7Fly3PU18SOL6HcGi7v+4mKi1XkE7z7JxemkFjbTgmV4RcVcfwk9Dfwn0i/vMT0ykvm9eR0QEQEr/F8KZ8HE4fUsrY+SiWZlcauHyYCaQHM99BbO10GOu13KzHYoXDQ24IxAlal785luwbfUs0iJJU1g25c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ttMtnRQf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21122C433F1;
	Tue, 26 Mar 2024 18:47:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711478834;
	bh=mluiAor2f4Fl8dUvJLJjVtfHfDF4072q/JzfzNuHlmY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ttMtnRQfhgQML3Fqaz/fiMB5dyPi7L9fT6L48b8tuOBsNTpPmoT6/RQqE2b0CspNV
	 6idDQSUT1KuZcUb6ij2DnBtwczb4kuXTz69S8cwpVJI3aOtZ4Nc21YuON6TLV/AbKr
	 i/3mrFZK7XdqXmd6Qzz6GPuhqFgujXEhIigNkiBZtn284P9wU8Fm34hEiTizah5Htb
	 8PsnCkKtZLR8x5ACQ4GvlcQlDIf3LRbAA+3+bBdeoOPv+s668cZ7z6S3Lw51w1E/uO
	 LvcbWXnKh9TSkKH/967NAIEQtpRQ8r+qJwySdHg5uETOuc2YjHAJechuzSdzRdT0wP
	 tHbDKRvt2A0WA==
Date: Tue, 26 Mar 2024 13:47:12 -0500
From: Rob Herring <robh@kernel.org>
To: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Cc: linux-rtc@vger.kernel.org, devicetree@vger.kernel.org,
	Baruch Siach <baruch@tkos.co.il>,
	Conor Dooley <conor+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: Re: [PATCH v2 2/4] dt-bindings: rtc: alphascale,asm9260-rtc: convert
 to dtschema
Message-ID: <171147883150.3182142.14773258890447359682.robh@kernel.org>
References: <20240325-rtc-yaml-v2-0-ff9f68f43dbc@gmail.com>
 <20240325-rtc-yaml-v2-2-ff9f68f43dbc@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240325-rtc-yaml-v2-2-ff9f68f43dbc@gmail.com>


On Mon, 25 Mar 2024 22:10:09 +0100, Javier Carrasco wrote:
> Convert existing binding to dtschema to support validation.
> 
> This is a direct conversion with no additions.
> 
> Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
> ---
>  .../bindings/rtc/alphascale,asm9260-rtc.txt        | 19 --------
>  .../bindings/rtc/alphascale,asm9260-rtc.yaml       | 52 ++++++++++++++++++++++
>  2 files changed, 52 insertions(+), 19 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>


