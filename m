Return-Path: <linux-kernel+bounces-119203-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5630E88C580
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 15:44:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5380E1C62CB6
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 14:44:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E63B13C811;
	Tue, 26 Mar 2024 14:44:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="PJnIYHx8"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8669213C693;
	Tue, 26 Mar 2024 14:44:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711464240; cv=none; b=BkQ3NY9mfPMF+1dam7NJhLUMV1Q75b+8g67ig99lDW28yjcUurjvK473iqM4sSNiLrClV4IAY27qFpVat7pK16jSX3A8JK8HRTTw0xTOBCKcgNKcM5Bl/t7desiLAavPWZrQWbveRmQrF+JGP1a6t1P8RSUqscvAi7tBGycwFyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711464240; c=relaxed/simple;
	bh=Yq3xPmqOC+jWpcs6JWkYjALCu081LQFaJBbCO9A5c2E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l1UpSpCSDMlcUu+cltxqoiPS0DyeKfDnxmsAB/x0aWeHp3P0fbJcuz4WhiGlTV9x13NaxZGd23B0eP/VoBoVMQW4y7JAHyDDllj7MZNIZSGYYr7JQfIz5AO9xv29Qy9bjtRglY4bcVX8UyO6P8j+rBTOAswUX639oiHlMPoK18o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b=PJnIYHx8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9DD86C43394;
	Tue, 26 Mar 2024 14:43:58 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="PJnIYHx8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
	t=1711464236;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QFtO6qgIeS/TrL6O/53SQRKmvPvLZK73MqbCr1eYYds=;
	b=PJnIYHx8QR58FlkIH8G9EjxJmFe26UWCkDQ2wfcQf9+akz24j234w/Y5esoPePv+euqtXx
	oB38fCdnbw8HA/CL7slD2bkNq/oYl5jkgNyews8PNgajO4GNeohowJOgnSW0K0JSmH/e6o
	6WS9b6yav67jBb21t41EFsp/E1nDcc0=
Received: 
	by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 30285613 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 26 Mar 2024 14:43:56 +0000 (UTC)
Date: Tue, 26 Mar 2024 15:43:55 +0100
From: "Jason A. Donenfeld" <Jason@zx2c4.com>
To: "Landge, Sudan" <sudanl@amazon.co.uk>
Cc: Rob Herring <robh@kernel.org>, Sudan Landge <sudanl@amazon.com>,
	tytso@mit.edu, krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org, sathyanarayanan.kuppuswamy@linux.intel.com,
	thomas.lendacky@amd.com, dan.j.williams@intel.com,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	graf@amazon.de, dwmw@amazon.co.uk, bchalios@amazon.es,
	xmarcalx@amazon.co.uk
Subject: Re: [PATCH v2 3/4] dt-bindings: rng: Add vmgenid support
Message-ID: <ZgLfKwp6cSrX7knJ@zx2c4.com>
References: <20240321025105.53210-1-sudanl@amazon.com>
 <20240321025105.53210-4-sudanl@amazon.com>
 <20240325150609.GA3477574-robh@kernel.org>
 <51403072-f5ca-450e-9206-19ca627ead11@amazon.co.uk>
 <CAL_JsqKpp+J2a_+wmcaOX8RfTEEyZBESWBX7GWGa_u_5_=4gsg@mail.gmail.com>
 <96df7e5a-52df-4171-9cd6-78d088a7a1e2@amazon.co.uk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <96df7e5a-52df-4171-9cd6-78d088a7a1e2@amazon.co.uk>

On Tue, Mar 26, 2024 at 01:06:16PM +0000, Landge, Sudan wrote:
> >>> Does the spec say anything about endianness or access size? DT assumes
> >>> native endianness by default. We have properties to deal these, but
> >>> would be better to be explicit if that's defined already.
> >>>
> >> The spec doesn't mention anything about the endianness but, I have
> >> updated the description with some more data.
> > 
> > Then what does your driver assume? Microsoft may not have thought
> > about it because they don't care, but now you want to use DT so you
> > have to because it is frequently used on BE systems. If we define
> > something, then there's some hope. Otherwise, it's pretty much a
> > guarantee folks will do the opposite.
> > 
> > Rob
> The driver does not assume any endianness. To provide more context, The 
> hypervisor stores a 128bit unique ID at the address pointed by the 
> "reg"'s 1st cell, driver memcpy's this ID to an internal context and 
> uses memcmp to compare if the ID is new or old.
> But yes, it will be good to define a fixed endianness to avoid any 
> error. I will update the description to use little endian.

It's a 16-byte blob. Why care about endianness at all here? Treat it as
a byte string, not an integer.

Jason

