Return-Path: <linux-kernel+bounces-78069-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 33AF0860E96
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 10:50:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C96C1B2762E
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 09:50:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 708655C8F8;
	Fri, 23 Feb 2024 09:45:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="CGiYXaky"
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 646D55D49A;
	Fri, 23 Feb 2024 09:45:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708681558; cv=none; b=kWf7P6HUeVHHm4bYFh1xESkHUmqUyaYAq+L26ADORaGlgpF2aruENyUUdqjVBUbG1VZoHqgQkC7JtMrSWcvHbnCPIIT/DChjF6v+5yGKc9k9Hh9PsMLUpBY1kDOM5ekocOMpAY0sTauSZcA5eolM5WodDyYEK2c9qc0+36YFQEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708681558; c=relaxed/simple;
	bh=vnPXFRNx+a86m5DmfswPlKp7l/rv3+K3EFPRz/NMN+s=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MmQdjI17wT11qlfsnZBklUOfgdhrFA/nFftEicaE61ro2IG+qtKPHNsen0X0cbQlUoJriwC2a2G2k25gM6tZvuzVONAsPz57cZDoSLI+fMssb9X88hDvWbeiNjsWst1nizK9X4uw3sZx6Sh7cnzmZTZ2U7QxETrTYtGs7iA4V+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=CGiYXaky; arc=none smtp.client-ip=217.70.183.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id F3E0AE0009;
	Fri, 23 Feb 2024 09:45:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1708681553;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Gwfzm0aIYjJ7qpMl8GKhOJn5YclIVRibK7FZGX4d/IU=;
	b=CGiYXakyeEbP1DuGWVuf85ujvDQhvxQmVkfZ5rB1A24G2QeYIo8280L6QaVc1HFAYX6RsG
	3Wmgs9yneuhowGrJOmN8rt+BZZsQOk0kcN5b8urakcrWilzJEamyYqVWipWddZ2AQzYoPj
	U07u/z6IvrnPsf5WVjc+0pTWmwgX7G/nd1Ze+2l4K/jpWgdBOFTFkRdMrSMeMdfJJmSw6J
	Rb2kv9A2zBAahGq9px7yhLiy28TmaX62iqoTRlM7xSeeUsEyLqkKe0xBDwdA29LMR1xaPf
	dZZdToMfsRecobHAxCl0Gt6kqFoTWYBbD7/kqdLgW03uoouExJfPO5FDVaMcCQ==
Date: Fri, 23 Feb 2024 10:45:50 +0100
From: Herve Codina <herve.codina@bootlin.com>
To: Saravana Kannan <saravanak@google.com>, Nuno Sa <nuno.sa@analog.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki"
 <rafael@kernel.org>, Rob Herring <robh+dt@kernel.org>, Frank Rowand
 <frowand.list@gmail.com>, Lizhi Hou <lizhi.hou@amd.com>, Max Zhen
 <max.zhen@amd.com>, Sonal Santan <sonal.santan@amd.com>, Stefano Stabellini
 <stefano.stabellini@xilinx.com>, Jonathan Cameron
 <Jonathan.Cameron@huawei.com>, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, Allan Nielsen <allan.nielsen@microchip.com>,
 Horatiu Vultur <horatiu.vultur@microchip.com>, Steen Hegelund
 <steen.hegelund@microchip.com>, Thomas Petazzoni
 <thomas.petazzoni@bootlin.com>, Luca Ceresoli <luca.ceresoli@bootlin.com>,
 Android Kernel Team <kernel-team@android.com>
Subject: Re: [PATCH 2/2] of: overlay: Synchronize of_overlay_remove() with
 the devlink removals
Message-ID: <20240223104550.234ecdcb@bootlin.com>
In-Reply-To: <CAGETcx_zB95nyTpi-_kYW_VqnPqMEc8mS9sewSwRNVr0x=7+kA@mail.gmail.com>
References: <20231130174126.688486-1-herve.codina@bootlin.com>
	<20231130174126.688486-3-herve.codina@bootlin.com>
	<CAGETcx_zB95nyTpi-_kYW_VqnPqMEc8mS9sewSwRNVr0x=7+kA@mail.gmail.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.38; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-GND-Sasl: herve.codina@bootlin.com

Hi Saravana, Nuno, 

On Tue, 20 Feb 2024 16:37:05 -0800
Saravana Kannan <saravanak@google.com> wrote:

..
> > @@ -1202,6 +1202,12 @@ int of_overlay_remove(int *ovcs_id)
> >                 goto out;
> >         }
> >
> > +       /*
> > +        * Wait for any ongoing device link removals before removing some of
> > +        * nodes
> > +        */
> > +       device_link_wait_removal();
> > +  
> 
> Nuno in his patch[1] had this "wait" happen inside
> __of_changeset_entry_destroy(). Which seems to be necessary to not hit
> the issue that Luca reported[2] in this patch series. Is there any
> problem with doing that?

Is it the right place to wait ?

__of_changeset_entry_destroy() can do some of_node_put() and I am not sure
that of_node_put() can call device_put() when the of_node refcount reachs
zero.

If of_node_put() cannot call device_put(), I think we can wait in the
of_changeset_destroy(). I.e. the __of_changeset_entry_destroy() caller.
  https://elixir.bootlin.com/linux/v6.8-rc1/source/drivers/of/dynamic.c#L670

What do you think about this ?
Does it make sense ?

> 
> Luca for some reason did a unlock/lock(of_mutex) in his test patch and
> I don't think that's necessary.
> 
> Can you move this call to where Nuno did it and see if that works for
> all of you?

I will check.

Best regards,
Hervé

