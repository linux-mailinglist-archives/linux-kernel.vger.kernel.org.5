Return-Path: <linux-kernel+bounces-45282-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 63AF6842E07
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 21:40:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1F800283FCB
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 20:40:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 359C755E57;
	Tue, 30 Jan 2024 20:39:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aodd4YZu"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 738B455E63;
	Tue, 30 Jan 2024 20:39:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706647195; cv=none; b=M0xCrHqB78dpUZXXeocXFXqFf8BBwZUejDOxEgZN+OOuVzLoTFfNxt58qtYRx7Q/8UGmwkuIiYkx07XJjxJj+nDXy54aiqfYXZzI2vEPEFDgTFOWuBuu5eufwAg12jIFiCibglPosb4UwLX7/pu2MlJfa9Zecg3El9FyXsIlIis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706647195; c=relaxed/simple;
	bh=GNVwHJNHT1SMuiGtMBj4haZpGb2M+rvd7V+k57yQTSk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u2hzLWgubScmxgTma3CFta7PMqd6hXf4C3kchpeO0Ugf4nMQwkkDBeWz2zdh94eJxsoQ/9hmrtegq58rQW0s8g7pautSSB2JthF7oFMgPoBjhB+SpeY79zSsV/xTO4G1rijcg/KFiQGAa2pfhJ9SIC0WkM0hii27n/55pHWJyso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aodd4YZu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5F0EC433F1;
	Tue, 30 Jan 2024 20:39:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706647195;
	bh=GNVwHJNHT1SMuiGtMBj4haZpGb2M+rvd7V+k57yQTSk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=aodd4YZu7hJfofXdzBOuSJXMv0wZiW5QJhTA4RUvtMZxxiAnHfHQmLdUMKX3sOj+P
	 rohQ7kDpG3M98T71q3/HdHpdlqdm2P132b6b4WKywQbV8Hpm8Y+iP9mAqhU2+SGwaU
	 XqirU8yqI/i4siKT+CSyaJMQNbDo49NZU191eXNhn0dnfD5SgL+lIYdvPBZ88xOA5P
	 tW98SYXhunD6+en5jL4TrDTH+3b4MBRGUrEd14jV4sij0NvNhYPZl2RdfXa+txRFRw
	 +P2rb8bIg5ADgjq/OR2dSvNKd+gQ8NrlUtLjBv1VAUuJD1xfQv0c7EqvxBJPk9qa6I
	 9kVQelinw2iSQ==
Date: Tue, 30 Jan 2024 14:39:52 -0600
From: Rob Herring <robh@kernel.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Marc Zyngier <maz@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
	Rob Herring <robh+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: timer: narrow regex for unit address to hex
 numbers
Message-ID: <170664719175.2303984.18174512878854689922.robh@kernel.org>
References: <20240123083312.20808-1-krzysztof.kozlowski@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240123083312.20808-1-krzysztof.kozlowski@linaro.org>


On Tue, 23 Jan 2024 09:33:12 +0100, Krzysztof Kozlowski wrote:
> Regular expression used to match the unit address part should not allow
> non-hex numbers.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  .../devicetree/bindings/timer/arm,arch_timer_mmio.yaml          | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Acked-by: Rob Herring <robh@kernel.org>


