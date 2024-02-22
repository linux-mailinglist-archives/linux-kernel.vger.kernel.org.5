Return-Path: <linux-kernel+bounces-77543-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A0558860719
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 00:43:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3D8241F2373D
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 23:43:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E231F13BAE0;
	Thu, 22 Feb 2024 23:43:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jnJy0g8a"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D6471CD25;
	Thu, 22 Feb 2024 23:43:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708645385; cv=none; b=g3oRLvnXnEb3urdrHToAbTx1ZuNAnDmGPTnEfA9BO4Nduo8GWyKnlQAp2Bemt1y/o5nWnoZ3kn9w1p3TSuH/75Kr8Hj5LV7uZ97PeJc+8Qx6d6LkpOfSQOKnrB6iuI1pMfOO1/rget5rz+GmTG9rNw6fRTG/9y/pE1ByQZvxQ8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708645385; c=relaxed/simple;
	bh=orYPHvKEF7pNsfLnqS3JuQ7jmo0kJmxsHCs+Py+BljA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EvV6+WSXxJnujFkmJnR+9D1DyzRkGtkj1vPE2aQ0i6QnjgLuOuAr1CZRC3cyqXJKOqYS/CGG1/AiKMlV7xdJ3vps4WMzCs+wqoO3utX8nvFn2tKmhZ5KECbBQiVeN8T8MIzgh0o+ItTQLnklqW6BCRbreO135hjVXV2BTlppzME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jnJy0g8a; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3385EC433F1;
	Thu, 22 Feb 2024 23:43:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708645384;
	bh=orYPHvKEF7pNsfLnqS3JuQ7jmo0kJmxsHCs+Py+BljA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jnJy0g8aJUy/nsIbPKzZliYyca0yhygNbHrmb8qSxM9IRSUuonUBjN6cqCGiQPs7t
	 sinQph2fUfALhfnfpUT+l0JSThKKjSVvJkRtH+chmJYXTaWkISRtTzM1H1qxPKZ7Z0
	 XLw1swd88spcG3rvy3Ts3unIJLjo5G5UCye+DlcyDHRtWAa9e26hKlFH3FGdmUrOU3
	 E0hiarafAkSIvMbvLMG/egu1oKGeUll0sJq9ExZ6oHzpX2Xop7tAqpemff2KWx6Yy1
	 kwE7TSSNCsvBNiIhxz/PEwmOGs2fh/vgnCYqVv/Pc0OH9RQQ8mDNbBnRfdiXSC7mUq
	 RsVPZsDPDk7UQ==
Date: Thu, 22 Feb 2024 16:43:00 -0700
From: Rob Herring <robh@kernel.org>
To: Antonio Borneo <antonio.borneo@foss.st.com>
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	Fabrice Gasnier <fabrice.gasnier@foss.st.com>
Subject: Re: [PATCH 02/12] dt-bindings: interrupt-controller: stm32-exti: Add
 irq nexus child node
Message-ID: <20240222234300.GA3809915-robh@kernel.org>
References: <20240216094758.916722-1-antonio.borneo@foss.st.com>
 <20240216094758.916722-3-antonio.borneo@foss.st.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240216094758.916722-3-antonio.borneo@foss.st.com>

On Fri, Feb 16, 2024 at 10:47:47AM +0100, Antonio Borneo wrote:
> The mapping of EXTI interrupts to its parent interrupt controller
> is both SoC and instance dependent.
> The current implementation requires adding a new table to the
> driver's code and a new compatible for each new EXTI instance.
> 
> Add to the binding an interrupt nexus child node that will be
> used on the new EXTI instances and can be optionally used on the
> existing instances.
> The property 'interrupt-map' in the nexus node maps each EXTI
> interrupt to the parent interrupt.
> Align #address-cells and #interrupt-cells between the EXTI node
> and its nexus node.

Looks like an abuse of interrupt-map. You avoid adding yourself to the 
abuser list by putting it in a child node. Clever. (See list in 
drivers/of/irq.c if you don't know what I'm talking about)

I assume the EXTI has 0..N interrupts. Just define 'interrupts' with N 
entries with each entry mapping EXTI interrupt N to 'interrupts' entry 
N.

Rob

