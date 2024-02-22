Return-Path: <linux-kernel+bounces-77548-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 39542860729
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 00:55:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6AA9D1C211A2
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 23:55:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15B2C13BAF6;
	Thu, 22 Feb 2024 23:55:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho.pizza header.i=@tycho.pizza header.b="N4cPvAnS";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="YBRqsSVJ"
Received: from wfout5-smtp.messagingengine.com (wfout5-smtp.messagingengine.com [64.147.123.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B35B13BAD8;
	Thu, 22 Feb 2024 23:55:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708646116; cv=none; b=MWiB9+bP5N09+fqQbOKN+YXKNdCN+cr90YZmK6+hh1DznZzSwatuXcUC4lKAI4obHTUlDuNAH/ujVziG/ZJjQggTDFRTWp8U11O1/mOIwchqQaqBWbu/VzBXB9nRslZeOK/4OplNMQ921QUZQAdYSaoRxTQSOvzjVqHzttIsKTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708646116; c=relaxed/simple;
	bh=5DbrVE98gnMbW/sOxH/2/zMMJkQFjIVpVGo0lc7VS5c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PEkZxyjJFLwcg7N66MuWC81cP1AgiYr3+GjBYyn+Vg5Um7Sr7rdEm2zMQEZjurbV6qKkbfZGm7U82puR5rhnDccD25nUxmRAxbfFP+b4Wy4xEWP6yC/Wi0cDJb0Ikb3UfQkmP6qqw2+sloXtbi/5AhdLGgIri4oJ/Mr/CwVE1T8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tycho.pizza; spf=pass smtp.mailfrom=tycho.pizza; dkim=pass (2048-bit key) header.d=tycho.pizza header.i=@tycho.pizza header.b=N4cPvAnS; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=YBRqsSVJ; arc=none smtp.client-ip=64.147.123.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tycho.pizza
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tycho.pizza
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfout.west.internal (Postfix) with ESMTP id 321511C0007D;
	Thu, 22 Feb 2024 18:55:13 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Thu, 22 Feb 2024 18:55:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tycho.pizza; h=
	cc:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1708646112; x=1708732512; bh=Pl5vMqRidv
	VS3SQYlynbhIdESVfcbmX9djCvU9x2wXo=; b=N4cPvAnSweShcMB1XLNY81DJ8+
	F9vxf7JZsBOALVaHY4hy7dNmzenRz0fc3qEiY9paB/b0NBeIp5sDZpCRTClkmrXT
	VoEDj029veG9v0ax7UIGWq+CnJ1ZvrHf56u7WgY4iU9IbFx6JXOmQsWPJ5kKd3Fq
	WZi/EdWvHsVsFS3VgzFzFuxIL+aZpK0i9FmowqUqbLK5kWoa4GviFJBuz7O8HMm4
	Km8spXAlnD0n3XutD38kSl7FGygO2CrjrAf4f1EMWZ7XYhW0ICxOa8M8xRxhnCiM
	EQJsjiHYgFS/xIWVbrliXV6Nr6y3aTtx5lCoS5UE4Wa8lGY6896PQNw/cTiA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1708646112; x=1708732512; bh=Pl5vMqRidvVS3SQYlynbhIdESVfc
	bmX9djCvU9x2wXo=; b=YBRqsSVJqK9CrlMIbF99AtjQTUSNF7AuV8tjQbV4cXGQ
	h8ZrPtfg7cZ2M5/BlCVKChYXo9Auv74w8I0GI+jIlVdM28Hm/Lk8XM3N1h/Hzxti
	6k9fwoWlpH99hNDsk5H3v/YhEhi+kwxPqEzQfBTXVT3KKvO16O0Oek+xXqsoGH4W
	YwtytgyWLRYEhvJZaJWc7/PtOk51DXLnsPs+spM98F6mgkB/ZaArcw4ethBDoTT/
	8RSpnpQisPHK94yg9HKVqM9+ntyjwGcmfS6zVdcTuUAPN6VRvOYZTBubekNMV4AZ
	+4yvgn/6SH2/ewjkyxOiRgJwUoOl1Q43GiyEVuuC7A==
X-ME-Sender: <xms:4N7XZe6s6BpoK6IEAWAFRjpHeFKUZzyZWLgnSR3JBBDASNZlSlslkQ>
    <xme:4N7XZX6RzZecA_xZLHaIjL6lyzbcqHntZ2HZpfup94tnoLyAshLUEl71C3WR-7RJM
    2b7fcb6XFBH6O3io3Q>
X-ME-Received: <xmr:4N7XZdd-xq5EiOWyEpcaThNuPZzguC_f547wle3yoTRQWXub6k6SJujrLes>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrfeehgdduhecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefvhigthhho
    ucetnhguvghrshgvnhcuoehthigthhhosehthigthhhordhpihiiiigrqeenucggtffrrg
    htthgvrhhnpeeutedttefgjeefffehffffkeejueevieefudelgeejuddtfeffteeklefh
    leelteenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hthigthhhosehthigthhhordhpihiiiigr
X-ME-Proxy: <xmx:4N7XZbKXkGX29ehCbjpcgVU4jL-4-moyeK7IRn6-scv4A-DF-ykHew>
    <xmx:4N7XZSJHNpeHj57N8yS51lGisUE5ONhHklevuzQddTD9cp42N6xnlg>
    <xmx:4N7XZcxxQ7asKFnZjtFl_JaS4qpJeBov9hB1_G1QWS4WcR74EXakBg>
    <xmx:4N7XZa8ps-2IUHLj4xLwptKNuuZuRMO_Q5rBcAjR_RrVETEF_ey_kxew_OY>
Feedback-ID: i21f147d5:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 22 Feb 2024 18:55:11 -0500 (EST)
Date: Thu, 22 Feb 2024 16:55:09 -0700
From: Tycho Andersen <tycho@tycho.pizza>
To: Kees Cook <keescook@chromium.org>
Cc: "Tobin C. Harding" <me@tobin.cc>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Guixiong Wei <guixiongwei@gmail.com>, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH v2 0/4] leaking_addresses: Provide mechanism to scan
 binary files
Message-ID: <Zdfe3Ze/PKLxvvt7@tycho.pizza>
References: <20240222215755.it.764-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240222215755.it.764-kees@kernel.org>

Hi Kees,

On Thu, Feb 22, 2024 at 02:00:47PM -0800, Kees Cook wrote:
> Hi,
> 
> Since I was in this script for the binary file scanning, I did other
> clean-ups and tweaked the MAINTAINERS file per Tycho's suggestion.

Thanks, the whole series is:

Reviewed-by: Tycho Andersen <tandersen@netflix.com>

I also pinged Tobin off-list with this thread, perhaps he will respond
here.

Tycho

