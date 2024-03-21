Return-Path: <linux-kernel+bounces-110410-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 19897885ED7
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 17:57:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C9AB82816D2
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 16:57:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4112F13667F;
	Thu, 21 Mar 2024 16:49:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nULhEJkA"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8162C18AE8;
	Thu, 21 Mar 2024 16:49:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711039742; cv=none; b=rkh+WYrkucBkDftiarySg61Qw2SWvUloH2oMuU8u9CYtJAbgB/VTuAIe4IzIF/vbzU+aeBeNu40whTAZC5MTTl6LraEmmo8O5/bNz6VuhjzcJ4MYnVvyzoRsUOppZF6S3lJfz3pGJKZ4FPjXh2FG/hnLRK/FpqvQYjayX62U6oU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711039742; c=relaxed/simple;
	bh=g9UN7Rio7nv92BBowv6hN57VwZQYyjCoB6anDBSAi6U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tnTRnvKvN0YHbFr97Nykv2AKPR2GZIoxRs/2PbivwuoE39OQoCVJHg7ex5a+Lz21kt55k9uZGcKDuhmMT1KBdn3S7674qU43xZ6MQpsdqWgnhprpo77ECJfjlfOdyveuLx957Mm83NlftoETPQQIdeYdyXQ4zoTsVvoyaf9F3M4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nULhEJkA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D09DCC433F1;
	Thu, 21 Mar 2024 16:49:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711039742;
	bh=g9UN7Rio7nv92BBowv6hN57VwZQYyjCoB6anDBSAi6U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nULhEJkAn/C4DVanxi36af3Ykh1XxD7NqJg3wTWR6lt1mq9UcUfOo5vffu63I2Itl
	 ooKPRAsDdPEMD44wHFLN9eKMsbJXUwbMd6q/WogSDYz++/IytULSb7IJk72aprExWx
	 67wyngUgwzymK0VgUrC4kn6bTln7NHuwiOaShqKa0ZiDveVPHs4hukTzYwqe3+VOUh
	 j1w6KL0icOFQe4nI3xWF146mjzFdLp/PUoBSFFS0sCQtHAO6FjgC69+vGrNKdIgVvC
	 OUkP/wEI4ZdGm0h+ijcfbmNoDveF7ePV+3RCjNrfm2qVpX/f1M+T+jIeeFJX6gBLRz
	 4OcRHTBeFki5w==
Date: Thu, 21 Mar 2024 11:48:59 -0500
From: Rob Herring <robh@kernel.org>
To: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Cc: Jean Delvare <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, peiyu li <579lpy@gmail.com>,
	linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/2] dt-bindings: hwmon: convert lm87 and max6650 to
 dtschema
Message-ID: <20240321164859.GA2085432-robh@kernel.org>
References: <20240321-hwmon_yaml-v2-0-74fa8eb60ec9@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240321-hwmon_yaml-v2-0-74fa8eb60ec9@gmail.com>

On Thu, Mar 21, 2024 at 05:33:16PM +0100, Javier Carrasco wrote:
> This series converts the existing lm87.txt and max6650.txt bindings to
> dtschema. Both are direct conversions with no additional properties.
> 
> There has been an attempt to convert the bindings of the lm87 before
> [1], but the author (added to recipients) has confirmed that no further
> versions will be submitted, and no acknowledgment is desired.
> 
> Link: https://lore.kernel.org/linux-hwmon/20231030125221.12974-1-579lpy@gmail.com [1]
> 
> Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
> ---
> Changes in v2:
> - max6650: add property constraints and commit message indentation.
> - lm87: No changes, already applied to hwmon-next.

Then you should not have sent it again. And you forgot Conor's 
Reviewed-by.

Rob

