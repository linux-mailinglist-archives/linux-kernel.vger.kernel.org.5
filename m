Return-Path: <linux-kernel+bounces-37617-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7894983B29B
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 20:56:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2F79D1F21F8D
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 19:56:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58446133423;
	Wed, 24 Jan 2024 19:56:09 +0000 (UTC)
Received: from bmailout3.hostsharing.net (bmailout3.hostsharing.net [176.9.242.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8112131756;
	Wed, 24 Jan 2024 19:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=176.9.242.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706126168; cv=none; b=MMP8wckWlHgESGmgw+J0gou+DebOW55vRxkjqsm9FdJbxj+SOvz0Zyb2fsS5U6ueLGJi9YnPhx8cbQBEx9E6OyqQXmK1Zz7E1XAZyGW8sZMvo88f7/ybZXtYgi8ufPjcV7bR/xp8Pz0YrE+zw8sQh0jPVbbh+WzVoi4CjcBwamg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706126168; c=relaxed/simple;
	bh=xK8NuItTiHpf9JuLKFLE4eMw7RYhppd6J5A1Qd7qZ5c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NIdQiESWNdXHCzcE9TuUrbPX6ry12zI5+0BLqVmUpvgjNTgydITMS19+6SvEivYaIBxmQx9eG8oxgn/IcApx/tOKu5JxZqERemS31oAVVHluhk8qB+F4de6Yawr8u4Ksa4K7Nc0GOy4VzaztCSDGw4ixcVA/Fatp8VdNm/PhedA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=none smtp.mailfrom=h08.hostsharing.net; arc=none smtp.client-ip=176.9.242.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by bmailout3.hostsharing.net (Postfix) with ESMTPS id 324FF100D942F;
	Wed, 24 Jan 2024 20:55:57 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id F32B7334557; Wed, 24 Jan 2024 20:55:56 +0100 (CET)
Date: Wed, 24 Jan 2024 20:55:56 +0100
From: Lukas Wunner <lukas@wunner.de>
To: Rob Herring <robh@kernel.org>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: tpm: Drop type from "resets"
Message-ID: <20240124195556.GA9756@wunner.de>
References: <20240124190714.1553772-1-robh@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240124190714.1553772-1-robh@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Wed, Jan 24, 2024 at 01:07:14PM -0600, Rob Herring wrote:
> "resets" is a standard property which already has a type. Users only need
> to define how many clocks and what each clock is if more than 1 clock.
> 
> Signed-off-by: Rob Herring <robh@kernel.org>

Reviewed-by: Lukas Wunner <lukas@wunner.de>

