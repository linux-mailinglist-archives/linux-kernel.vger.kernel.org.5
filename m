Return-Path: <linux-kernel+bounces-145338-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2207A8A52FD
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 16:22:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4DFAD1C21137
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 14:22:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04A0C762FF;
	Mon, 15 Apr 2024 14:22:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aDJdQYJF"
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EE617602A;
	Mon, 15 Apr 2024 14:22:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713190941; cv=none; b=L35fR8gN1BppqV/rRHS6jj2/orHorwau0XBRcELM0JXNHA8hs4KmZgRQIsvmZU3QRHd+gx9JNmDQtCs4tsy09adCQQWL2K+IJgdH4/olCMNA4vcMXTJ3iSkOxgENz7kVwAx9somjfB9tyRRmzJiPwnG8zBzuvONtMe7Giqax29M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713190941; c=relaxed/simple;
	bh=9Ir3scp8W23/upQsjLBGH5uBSSThzCEeVGhPNF50irY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sReDT4k8E7vXJhX5pSJk7o9+i1zuk4MeBOMvlKt3YuG0mnpEGZMQmxF+8FqUxd4W9zS8nlb6Rby3h3FCABecFBLpGbf01/4PTjmysGiqTG/p+JYbVHn7mDP413vO427DnVd7fAEscGsFgjAxxucLcjfvo/CrGf80EiiHMxomIgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aDJdQYJF; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-343f62d8124so2806276f8f.2;
        Mon, 15 Apr 2024 07:22:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713190937; x=1713795737; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=NBenbo5yQKESlQcuptjD7PXvm5EokMPUnv64i7h32sY=;
        b=aDJdQYJFVOm2mQZxsfgXeVG5MYkL0Ysu2Ry5WT848l0jY+2I2CUa9IyI1v8Z2sxpwe
         t2S5EUWRPhRn8XzB3xsMO2Pogr/ihOFbFVt5bMfq0ETyjMbMVLPbukUmXloaUTcGQ1NH
         CnzC2mIRX53ImtrzQmapCDXDlrVUC+z3IAH+8fp888X7CwOzEGDtYBik4hMFIe6DeDgQ
         mkMZmCNIf+uKAhvyWQMIW8oH9MiyNcF+4kOpS69qc3iBfhQm8bMSSfXL2xz0ORn32TC9
         jmgJCoqLslVEeJb2Sa1L9bqIeuHflMCGnYsGH53ALyESLmkrhDZSPrEcfuiNfKJhYkYN
         jxGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713190937; x=1713795737;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NBenbo5yQKESlQcuptjD7PXvm5EokMPUnv64i7h32sY=;
        b=FNeEGtkzkIJwNn11zO58ec5wHDWkEbUhPIVLxwqyI0zAiqHtyul2+CnNMXC3frJ+BU
         l5jOhutQ97X6zXrdaSdfNNpaQAobWLAd6foUmA11k5FMAUJuJQ3l0p8CekjTkZbKuF3m
         5jW2w0rd3EaiN+xg2gATuCJFJj6svPR4QlhaddUA5LD2uL34bu06YPfe0bmKUip+Gz0w
         FLbpKPixUx9dNL8u7AVlpdx6QzxKGFEKnj8infeWY1K0xONpCQ36i3Cy9Dp9yfRPfaTB
         ciH1DyEMpp73TaIfdfrVYElagSsnDw5VLQFOG0S4dXfBb0i503XRcwprWwU9J4+tzW2S
         xKXQ==
X-Forwarded-Encrypted: i=1; AJvYcCVZxuCHvr20AKT78hwPO1j/JBfvdCMTBlEwq5v+9YDE457bNQwVSeZJycbhIxF09IKuj+VfKQpU0JfsLr0xgDIN3ywjyMm+VbnLRQvGSS0=
X-Gm-Message-State: AOJu0YwVzrp8jc3yaByW6NriziPXQEvqD4yO3j2I6zF692RFZw5cTrvy
	bfrMVYtC2MzW6ZV9dfezwqCFtYG4xE61TZfqq8fi04FcZZVmT3Ll
X-Google-Smtp-Source: AGHT+IHAzOowbhnnS1r8iOQS2XKcb1UW9ylxxkx+9LC1Cc9deOsVai8q8xm55TijMA3QQR8NySm2Zw==
X-Received: by 2002:adf:e610:0:b0:33e:c389:69ff with SMTP id p16-20020adfe610000000b0033ec38969ffmr5612522wrm.68.1713190937035;
        Mon, 15 Apr 2024 07:22:17 -0700 (PDT)
Received: from localhost (cpc1-brnt4-2-0-cust862.4-2.cable.virginm.net. [86.9.131.95])
        by smtp.gmail.com with ESMTPSA id k12-20020a5d6d4c000000b00343e392829dsm12185010wri.97.2024.04.15.07.22.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Apr 2024 07:22:15 -0700 (PDT)
Date: Mon, 15 Apr 2024 15:22:15 +0100
From: Stafford Horne <shorne@gmail.com>
To: Sebastian Reichel <sebastian.reichel@collabora.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Jonas Bonn <jonas@southpole.se>,
	Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Andrew Davis <afd@ti.com>, linux-openrisc@vger.kernel.org
Subject: Re: [PATCH] openrisc: Use do_kernel_power_off()
Message-ID: <Zh04F8RP2vQsOiH8@antec>
References: <20240331070230.2252922-1-shorne@gmail.com>
 <rfbxtgppobtvtp2flghzpw7mzlrhnzwuk5gulwdauf5ecfkpa7@xk4qspf3mo3c>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <rfbxtgppobtvtp2flghzpw7mzlrhnzwuk5gulwdauf5ecfkpa7@xk4qspf3mo3c>

On Sun, Apr 14, 2024 at 07:52:03PM +0200, Sebastian Reichel wrote:
> Hi,
> 
> On Sun, Mar 31, 2024 at 08:02:28AM +0100, Stafford Horne wrote:
> > After commit 14c5678720bd ("power: reset: syscon-poweroff: Use
> > devm_register_sys_off_handler(POWER_OFF)") setting up of pm_power_off
> > was removed from the driver, this causes OpenRISC platforms using
> > syscon-poweroff to no longer shutdown.
> > 
> > The kernel now supports chained power-off handlers. Use
> > do_kernel_power_off() that invokes chained power-off handlers.  All
> > architectures have moved away from using pm_power_off except OpenRISC.
> > 
> > This patch migrates openrisc to use do_kernel_power_off() instead of the
> > legacy pm_power_off().
> > 
> > Fixes: 14c5678720bd ("power: reset: syscon-poweroff: Use devm_register_sys_off_handler(POWER_OFF)")
> > Signed-off-by: Stafford Horne <shorne@gmail.com>
> > ---
> 
> Reviewed-by: Sebastian Reichel <sebastian.reichel@collabora.com>

Hello,

Thank you for the review.

-Stafford

