Return-Path: <linux-kernel+bounces-60483-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A19A85057F
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Feb 2024 18:01:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 61749285F83
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Feb 2024 17:01:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 395055337B;
	Sat, 10 Feb 2024 17:01:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Jti9DQCg"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 794B05C8E5;
	Sat, 10 Feb 2024 17:01:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707584488; cv=none; b=c27MrwPsNBV2C+Farq88QLmbNKa3hTVNTgb1Au8vyHAO6PNfofE1siCAhX7XfI26qeLy85wHjjwRqbw7FfeOUfx5f6PHkbU0LzTbiN05/pDXCJzkG1dbJpOou6LIZYFzV9VwvLA/WxejnRf51WGIbU8puABMPw0LRUxmJDl99Xs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707584488; c=relaxed/simple;
	bh=wBaZwgCz9hDMOWTOOkxRLr2T1pQmpM9MV+Znrfc3GPE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cEukKOvdWNyjd+ld9FcNEtrP3KwlMZyMxkCAu3C+G9Pnu1wcX2+yAXdCkTWgQzKjFc1UgkEGsfQpIcUtdr0nzUD/CPRkW9EZyN9mlgwQccZ6tJ2GOBcNPCVCyi8z7BTykjwfFguSC6O5GXLgKLeQK5lVfkVaHrM47quOZ5xeqWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Jti9DQCg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DAC73C433F1;
	Sat, 10 Feb 2024 17:01:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707584487;
	bh=wBaZwgCz9hDMOWTOOkxRLr2T1pQmpM9MV+Znrfc3GPE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Jti9DQCgOa1bYArslPlAj3zkaAxaVDja0M21z1Rvuol/alBRIECrnfwWERxVfZv8o
	 Lp/8JbQU1N0rGdzYyb716MkdAsb0DOBwK21NpDRP8PVmLXsL6LWP8s/QB4rHcK1RUb
	 4tqk9ARrED5fj9noZkUTBkKGlwa3f4B4jTorYjI73RVjyqD28JK4oOj1XnzYU12+U6
	 NBVsgFf55Ikr25rkp4ag/OmImRgFaJ7V8jjSGr1OTq8sF13aZHfqNKkd/R9dqIjfOk
	 ZkeET940pZGy6qUrIkKA2xz6rl2KCU32QOeSvWrX+Uasg2wzpfC4rHuVLLGIkR2SRX
	 hQHemKzUMGbCw==
Date: Sat, 10 Feb 2024 17:01:12 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Subhajit Ghosh <subhajit.ghosh@tweaklogic.com>, Lars-Peter Clausen
 <lars@metafoo.de>, Rob Herring <robh+dt@kernel.org>, Krzysztof Kozlowski
 <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>,
 Matti Vaittinen <mazziesaccount@gmail.com>, Andy Shevchenko
 <andriy.shevchenko@linux.intel.com>, Marek Vasut <marex@denx.de>, Anshul
 Dalal <anshulusr@gmail.com>, Javier Carrasco
 <javier.carrasco.cruz@gmail.com>, Matt Ranostay <matt@ranostay.sg>, Stefan
 Windfeldt-Prytz <stefan.windfeldt-prytz@axis.com>,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 2/5] dt-bindings: iio: light: adps9300: Add property
 vdd-supply
Message-ID: <20240210170112.6528a3d4@jic23-huawei>
In-Reply-To: <0a03e639-9998-40b2-95bd-15dc40139509@linaro.org>
References: <20240206130017.7839-1-subhajit.ghosh@tweaklogic.com>
	<20240206130017.7839-3-subhajit.ghosh@tweaklogic.com>
	<dbfde067-50b8-4f86-a098-0fc160114854@linaro.org>
	<84591019-6958-4685-8830-54260aadd26b@tweaklogic.com>
	<0a03e639-9998-40b2-95bd-15dc40139509@linaro.org>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 9 Feb 2024 08:33:11 +0100
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> wrote:

> On 08/02/2024 11:40, Subhajit Ghosh wrote:
> > Hi Krzysztof,
> > 
> > On 8/2/24 18:47, Krzysztof Kozlowski wrote:  
> >> On 06/02/2024 14:00, Subhajit Ghosh wrote:  
> >>> Add vdd-supply property which is valid and useful for all the
> >>> devices in this schema.  
> >>
> >> Why is it useful? How is it useful? DT describes the hardware, not
> >> because something is "useful".  
> > I am adding this property based on a previous review:
> > https://lore.kernel.org/all/20240121153655.5f734180@jic23-huawei/  
> 
> The property was there already.
> 
> > 
> > Does the below commit message in this context make sense to you?
> > "Add vdd-supply property for all the devices in this schema."  
> 
> It's still poor. You should say why, e.g. because devices have it.

I'd change the patch title to:

dt-bindings: iio: light: adps9300: Add missing vdd-supply

For description something simple like:

All devices covered by the binding have a vdd supply.


> 
> >>  
> >>>
> >>> this patch depends on patch:
> >>> "dt-bindings: iio: light: Merge APDS9300 and APDS9960 schemas"  
> >>
> >> This is unrelated and does not make any sense in commit msg. Drop.  
> > Apologies for the silly questions:
> > What does the "Drop" signify? Are you asking me to drop/delete the above
> > "...patch depends..." message or does it have any other meaning?  
> 
> Drop entire paragraph.
> 
> 
> Best regards,
> Krzysztof
> 


