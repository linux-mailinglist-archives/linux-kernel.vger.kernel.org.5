Return-Path: <linux-kernel+bounces-50539-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B0AD847A6E
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 21:22:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 637BB1C25B32
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 20:22:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE4958172E;
	Fri,  2 Feb 2024 20:22:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vHfONgv5"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 172DE2FE3F;
	Fri,  2 Feb 2024 20:22:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706905321; cv=none; b=k28n3CRAqCy52eNFOAeGR5Hpu0CZIBKIrPEFVA8p/HcIqWIwJHPdSM1FTMkBZpNSnV9VzzQS4QlTMtu7Z3JzPkAql+XNlg9izmB2gvmI6HahyfPWe7DANInEksuQzMXFt6VEOOMg1ityV+3YvWP5vlO+TzD40lr8CJ7ZmBPUQzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706905321; c=relaxed/simple;
	bh=+l6xmMtGx88Ja2KwOafyi6g4YZxkCJK5ea96nkAej3M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aT+s1UIoPpPCNjMVvPi+fEHUjcpwH7GRgLheTaenTFz6bbMUduqZIJNyohopXZK+upfbsbbaRPwvIw5dNc6+e8Ry/FFvrrClRS1puWMOiQJUx+TVLz1EyzCyzvXka1WX5fCXa2hAHXPtD7KsVLpSKCR5Z/eOLb0xBG1Pp/sxjbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vHfONgv5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C077C43390;
	Fri,  2 Feb 2024 20:22:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706905320;
	bh=+l6xmMtGx88Ja2KwOafyi6g4YZxkCJK5ea96nkAej3M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=vHfONgv5bp3nw/5BQQBxFABlpD4dswpeqWaZ9kdLpNnG25ND9Ibg1qtNTnwxNP0k+
	 UjTINVQLu3iGG19vu3S5zvxAfpiIqRMZe15H2ktSLwiY3J9M9p/ye/AmVfAGCjHU6G
	 UDpmWstk/3Yuh+20glbCwJOqYGQuWnxKfUqkfMZo4OR8InE2j1wMTUIqyBWGAxpNRm
	 UAB1adOXcwtSWxPlKUX2hO6CwPUtlWl/Gs1cHYkAjJEOZw2BPS7sdYN3Zybmwza90b
	 x7u/uahun+vLqGdLOSdo1F+fNO/EbjeRR+ddEjCQFi3KhyNnoc1/p5679HFl0tdA5o
	 1cEWNWSfAotMw==
Date: Fri, 2 Feb 2024 14:21:58 -0600
From: Rob Herring <robh@kernel.org>
To: Conor Dooley <conor@kernel.org>
Cc: Guenter Roeck <linux@roeck-us.net>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, Charles Hsu <ythsu0511@gmail.com>,
	linux-hwmon@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: trivial-devices: sort entries
 alphanumerically
Message-ID: <20240202202158.GA1007609-robh@kernel.org>
References: <20240201075805.7492-1-krzysztof.kozlowski@linaro.org>
 <5461a237-1df4-4077-86ef-e9ff6ff17e27@roeck-us.net>
 <20240201-silliness-unfair-265a0d896377@spud>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240201-silliness-unfair-265a0d896377@spud>

On Thu, Feb 01, 2024 at 06:32:09PM +0000, Conor Dooley wrote:
> On Thu, Feb 01, 2024 at 05:25:13AM -0800, Guenter Roeck wrote:
> > On 1/31/24 23:58, Krzysztof Kozlowski wrote:
> > > Sort entries alphanumerically.  This was a semi manual job with help of:
> > > 
> > >    cat Documentation/devicetree/bindings/trivial-devices.yaml | grep '    - ' > old
> > >    cat old | sort -n > new
> > >    diff -ubB old new
> > > 
> > > Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> > > 
> > 
> > Acked-by: Guenter Roeck <linux@roeck-us.net>
> 
> z sorts before a, please fix in the whole file.

I don't follow this comment.

> 
> Acked-by: Conor Dooley <conor.dooley@microchip.com>
> 
> Thanks,
> Conor.

