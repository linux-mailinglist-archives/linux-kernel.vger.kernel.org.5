Return-Path: <linux-kernel+bounces-45431-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 30A2E84306B
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 23:52:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D92961F23BDA
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 22:52:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98C627EEFD;
	Tue, 30 Jan 2024 22:52:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DjaOInZf"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF12078661;
	Tue, 30 Jan 2024 22:52:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706655124; cv=none; b=aFyPru0iBvhPONl5IpIVXsoDVeY44YzVbqC+Nci3lRiUlSF4vE3FguK6Ssg36gRD4bpRaHhO6WE1lRlri+TsCnKNOgKe+5pJf8/wIHPFskY05wEJXN5GXcCNQkrGKGKrXP9JI9hIB62Yh4q5z6wiSVjG7FQvS69QsWzanpAbC3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706655124; c=relaxed/simple;
	bh=Z9JSOZJwv4veo8nEmqZ3zyrn1RuKLDCF57K2KTf6Gdk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nxWPqAC5I2aL8JKbSZDBjzoJ7C++fdve/ezhSY3MOsIpk2H7idy6OFYWhTknUy124ExWInI2B5MTWSS438f0wquEFi5v1K16QeoMW7k54wVJJizWViSEURZ9+oi0HQBSS0+sbO348nqDdQ0V7K2wrFkbGRVd7kJ+vdFMQrOQSxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DjaOInZf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09B38C433C7;
	Tue, 30 Jan 2024 22:52:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706655124;
	bh=Z9JSOZJwv4veo8nEmqZ3zyrn1RuKLDCF57K2KTf6Gdk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DjaOInZfp82KjVrjgPjw4ZXqGcMp2+fZJdVaHZTK/8E+4+c87wYUZlAjbKt1O0vOf
	 dfN1npQ76k5AFv4vFmqARwCW5hVB97FsbHD42hwdPCMo4FVQu7y6aqEFeAxueoE2PQ
	 RcfOLmb0oDpHhIiQRW3dx/0eQf/6NrV5Wtw0raO+CqetuVIpUJusFRYTe3vCXbih89
	 f9uuir4h5RHOeXkyW3z599Ia5W787tgp1Mobyp1ryLle2rDRN/FFcwx7wpXUcVBpBO
	 DNECB6qyMEawqKM2cXwsf1Y0+CCWZ/zSKOCFHC+tHMTprs5elV/vHv1g8bSV4G9NGm
	 Yo7Hz6+n2vTmg==
Date: Tue, 30 Jan 2024 16:52:02 -0600
From: Rob Herring <robh@kernel.org>
To: Christoph Winklhofer <cj.winklhofer@gmail.com>
Cc: Jiri Slaby <jirislaby@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	linux-serial@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	linux-doc@vger.kernel.org
Subject: Re: [PATCH v5 1/3] dt-bindings: w1: UART 1-Wire bus
Message-ID: <170665512145.2562941.4940727869669470030.robh@kernel.org>
References: <20240126-w1-uart-v5-0-1d82bfdc2ae9@gmail.com>
 <20240126-w1-uart-v5-1-1d82bfdc2ae9@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240126-w1-uart-v5-1-1d82bfdc2ae9@gmail.com>


On Fri, 26 Jan 2024 16:42:03 +0100, Christoph Winklhofer wrote:
> Add device tree binding for UART 1-Wire bus.
> 
> Signed-off-by: Christoph Winklhofer <cj.winklhofer@gmail.com>
> ---
>  Documentation/devicetree/bindings/w1/w1-uart.yaml | 60 +++++++++++++++++++++++
>  1 file changed, 60 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>


