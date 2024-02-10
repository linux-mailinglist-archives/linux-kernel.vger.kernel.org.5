Return-Path: <linux-kernel+bounces-60484-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AC54850583
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Feb 2024 18:03:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 48B991C2322C
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Feb 2024 17:03:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0ED0C5CDE7;
	Sat, 10 Feb 2024 17:03:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GJ8Mrr/U"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4914447F63;
	Sat, 10 Feb 2024 17:03:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707584593; cv=none; b=s/A38j/7JpndJKn/ShJofo4fkvwqILCkC7p3BjekP3vzZh2h3plQGYhQsRB2ansmu53XZ/sv+B86q5WV3t5dW3PDwqIfroJphAvUgdVTsFpYZiOVgCbrIHH8g4b0FrVeCMhde4e9bo3J+zY5HQVqbd40elESX2LNli4KQbR9wjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707584593; c=relaxed/simple;
	bh=dM5P/BLPpv65XEEBRcA7+EHDNw1b9Ov8MqVYouph3b8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dlI4yLu/fMFbNGf1GNV9f97P+XjfkDNTYWyTZeIfiU4NBmtPPx0ktGlwlRMB5sOjBa8RmB9S5UnRXbk/fqOS3T2gKQqu+JKCahwLw86kRqz8DaL4BlKrLNjpiaeMNgqR0gXIRIgZF5WNxKeicmtn38xHw2qBGefpiOMUpV7YDpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GJ8Mrr/U; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F50BC433F1;
	Sat, 10 Feb 2024 17:03:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707584593;
	bh=dM5P/BLPpv65XEEBRcA7+EHDNw1b9Ov8MqVYouph3b8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=GJ8Mrr/UdwQenKyY57B8T2UMN3atxirCv0QJ6u41CB7hnqKyG4eK4f4952lhbkaTh
	 N4CdNQhaVAScWHJql9TXS36o1q0+7x2LUTs4cEICafL8F7FzhwhZGJtlO+eyO0G1JU
	 Jg4BM7Tk/g+HRC90Uq2/e8FXCUP+K6WFo9fl+3I2Ttz1Jw78zc//QeXW0c8vQ5ekAY
	 kLnbZ+1ir+fib6H6/XmDq7KoReHJSKV++h/P16fu8myX7o/3cviGRPb7OF84S/92A3
	 Hmy8uismDiisFZi2u4BkjWhm232sGhuxSJceS9aqoubelRBn2vqyTECu0oOS66NbyI
	 Q1kXvyCVC9JMA==
Date: Sat, 10 Feb 2024 17:02:58 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Subhajit Ghosh <subhajit.ghosh@tweaklogic.com>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, Lars-Peter Clausen
 <lars@metafoo.de>, Rob Herring <robh+dt@kernel.org>, Krzysztof Kozlowski
 <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>,
 Matti Vaittinen <mazziesaccount@gmail.com>, Andy Shevchenko
 <andriy.shevchenko@linux.intel.com>, Marek Vasut <marex@denx.de>, Anshul
 Dalal <anshulusr@gmail.com>, Javier Carrasco
 <javier.carrasco.cruz@gmail.com>, Matt Ranostay <matt@ranostay.sg>, Stefan
 Windfeldt-Prytz <stefan.windfeldt-prytz@axis.com>,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 3/5] dt-bindings: iio: light: adps9300: Update
 interrupt definitions
Message-ID: <20240210170258.17fd1099@jic23-huawei>
In-Reply-To: <9f806e4e-b4a4-4e85-9a68-332b7920bfce@tweaklogic.com>
References: <20240206130017.7839-1-subhajit.ghosh@tweaklogic.com>
	<20240206130017.7839-4-subhajit.ghosh@tweaklogic.com>
	<4647ae5a-b700-4eb0-91a2-d9885bd60431@linaro.org>
	<9f806e4e-b4a4-4e85-9a68-332b7920bfce@tweaklogic.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 8 Feb 2024 21:23:09 +1030
Subhajit Ghosh <subhajit.ghosh@tweaklogic.com> wrote:

> On 8/2/24 18:48, Krzysztof Kozlowski wrote:
> > On 06/02/2024 14:00, Subhajit Ghosh wrote:  
> >> Include irq.h and irq level macro in the example for readability
> >>
> >> this patch depends on patch:
> >> "dt-bindings: iio: light: Add property vdd-supply"  
> > 
> > Please, don't write such useless dependencies. This is neither true nor
> > useful.  
> Understood.
Just for reference:

If there were such a dependency (beyond noise in the diff) then there is
still no need to state it when the patches are in the same series.

Jonathan


> > 
> > 
> > Best regards,
> > Krzysztof
> >   
> Thank you for reviewing.
> Regards,
> Subhajit Ghosh
> 


