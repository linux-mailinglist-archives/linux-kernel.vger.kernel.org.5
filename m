Return-Path: <linux-kernel+bounces-98887-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E09B68780B1
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 14:34:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7556B283C83
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 13:34:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAD193FB2A;
	Mon, 11 Mar 2024 13:33:50 +0000 (UTC)
Received: from elvis.franken.de (elvis.franken.de [193.175.24.41])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67F593DB8C;
	Mon, 11 Mar 2024 13:33:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.175.24.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710164030; cv=none; b=s9E5K9m3q1KoFaV7/2V0PFSPkMINAoIIp1PnChYhXNZ8eGK1QoFn7saGwaTnvhJkqER2J2aFgsNwe7pGrFUR59wBb7VikiSqV4vNJVJJexivIiOKBpNfT2mRBwZUVFhYdOJWZYwDnhXRZNhE9CNxnlnn4/VedZJ2K+nKXRnuC7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710164030; c=relaxed/simple;
	bh=XJxQOUTBMprwFgLG2ugpTyRv75h4GfUXt/D6X/lSOnk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EZ22aUNNUw0GSgDlpZHA85fpn89n57ATAX9PF6OuxaT5ldbPV1Q9sCHJ1m7QnCvvaQm5nWHgEpXGmMnjid/MrPjbYqmNjc8itbXG/4HSnNgTXsNcoKckuN4skPVudddEcVG6LEeCFlys9jpSV6UWAAfIJvrs+uVn0fQTnfXO7gc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=alpha.franken.de; spf=pass smtp.mailfrom=alpha.franken.de; arc=none smtp.client-ip=193.175.24.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=alpha.franken.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alpha.franken.de
Received: from uucp by elvis.franken.de with local-rmail (Exim 3.36 #1)
	id 1rjfO2-0001bg-00; Mon, 11 Mar 2024 14:08:14 +0100
Received: by alpha.franken.de (Postfix, from userid 1000)
	id 9BF5AC0694; Mon, 11 Mar 2024 14:05:01 +0100 (CET)
Date: Mon, 11 Mar 2024 14:05:01 +0100
From: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To: Justin Swartz <justin.swartz@risingedge.co.za>
Cc: =?utf-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>,
	Sergio Paracuellos <sergio.paracuellos@gmail.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	linux-mips@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: Re: [PATCH v3 0/3] Extend devicetree coverage of MT7621's UART
 interfaces
Message-ID: <Ze8BfZl0IBFmK/1a@alpha.franken.de>
References: <20240308155616.11742-1-justin.swartz@risingedge.co.za>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240308155616.11742-1-justin.swartz@risingedge.co.za>

On Fri, Mar 08, 2024 at 05:56:13PM +0200, Justin Swartz wrote:
> This patchset associates the uart1_pins group with serial0 and adds
> two nodes, serial1 and serial2, that define the interface to the
> MT7621's UART2 and UART3 respectively. 
> 
> Changes in v3:
>   Added spacing between properties as requested by Arınç ÜNAL.
> 
> Changes in v2:
>   Reordered properties as requested by Sergio Paracuellos.
> 
> Justin Swartz (3):
>   mips: dts: ralink: mt7621: associate uart1_pins with serial0
>   mips: dts: ralink: mt7621: reorder serial0 properties
>   mips: dts: ralink: mt7621: add serial1 and serial2 nodes
> 
>  arch/mips/boot/dts/ralink/mt7621.dtsi | 44 +++++++++++++++++++++++++++
>  1 file changed, 44 insertions(+)

series applied to mips-next.

Thomas.

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessarily a
good idea.                                                [ RFC1925, 2.3 ]

