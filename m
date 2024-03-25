Return-Path: <linux-kernel+bounces-116810-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 12D3288A427
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 15:20:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C22B12E3DBD
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 14:20:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6A4413E6C8;
	Mon, 25 Mar 2024 10:47:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hEnbhZZG"
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7CF912FF99;
	Mon, 25 Mar 2024 10:19:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711361968; cv=none; b=Gj2eFCYOKzj2UB7k8xAadwBce4sK4A0WfXJARlwjfo+kqckBfCQL/APJt0HnJEpZahoegjXLeaXEt76tARhBqX9hm4ALKrlilQFxviDXC37ljlRcn6IhVU9zu5BEZv2j16FSux7U4Ph10QybCX21XdZqi0xygmbseOep4rRgNm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711361968; c=relaxed/simple;
	bh=BUGNqjoLfsxQHYk/8rWceZNAXz2Yeg4TAAXA9qHpQmQ=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rNmrqBn7ViUJ3lgx3DFLEyQoX5PWGLplQ2Oo83bxXfryYIeAqP1x/wV7NYJChR3OpV1WVh7cSpPEgQRosBL2mRIsPaW8++3Gwl+w8RYppXMjpW9odUskUawcZdpQ72gHBFgpLCxxb0BGHQOoyiYaAsM2gCBS1P7vBZ96A+t5p7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hEnbhZZG; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2d46c2e8dd7so52809541fa.1;
        Mon, 25 Mar 2024 03:19:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711361965; x=1711966765; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=WHRv7g3CiPKX519Ky5IELZFKVKXY3LsLEia5o8nsqvI=;
        b=hEnbhZZGMKZPX/A+j2pQpkHdK/Jp6wn6Je77NtPIqFCqSNN7dQFDFvMLYifefYfGUx
         Yb5xxMT8lSrJzhHPidCDDtc8dm7NhLcas2pz+lV8+hsOtkaAKxy2WUVbw6FkTqJFU2CE
         1yRqLCaRhlvow1IwoU6ObDRYOD74h2y1K4XzLBmW7V18doBAWxsGoZy44HqdDiy8e8zi
         /4+cQjuoqL7uFK3gXItgI2cycm66zM4ZxRB8a8CjlqvLZ708PG8yDvVkijxBlWmaqK1N
         1ILEYn3SxUBXFKPnqRviF3yD028uiS9zvf7UUMSwaS/t4aQQoNpGJY0XARFqIQB2fN7+
         ctDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711361965; x=1711966765;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WHRv7g3CiPKX519Ky5IELZFKVKXY3LsLEia5o8nsqvI=;
        b=Qomr3OMSYcOLME1biEmzYlRuPp6mo54/QlDaEwSI2CdnMAZr8q5liQSDslndTxED2i
         zEGONIHMb4EyITc6+RSRg7AVm5nKCNrTi9qG4BzsAYryuMKBJQMc2t+FOoe8ebhcL95M
         dEzB2VGGpKnhGh1SCfpfsJry8Hym0Wz51vP9vxM04r/kiIwx29RQ2Wbe8ZZx2Vmn+Lt1
         xTbK9osh+jNkx8lU2X1kJbZd+j4fVsR0TAABQcydYgqpNLLiAiCQLc1h4dfPdR9Pm6Jo
         358O8lr8NZNEVHPONM1wTT3O6UPoD7jvNGXqNURV+6J76R9BY1eC04/p3Lxp1pFimn7p
         sT7Q==
X-Forwarded-Encrypted: i=1; AJvYcCXMDreAwXFb8sR0PKaO3joN5qmH+Zyl/rwPV7qvt4vUpjM7KISPijVT+O/YXjVobrY+snCcq8LcmGq5Kwq8v04Wtq16lBGzQYzMYH7dMIXp3FN0JZAhG0YxHGXXM8/1+Uf1s7bB
X-Gm-Message-State: AOJu0YxxyzHiU836lsPCQO5X8LttqWXyeRozlKdvXEmkbMTMFkdGHY8A
	YLfLWpr7kxLvpifnfS2PlzDT+v1vVUxDvt5n2VGRwgiOwi+LxP3l
X-Google-Smtp-Source: AGHT+IGg5wJ2qRptsbAUpuTEIcDJSsOM1PIB+jrxgL/A4nsVGf35/xFZrJb8g4txRn38MH5eXDKUqA==
X-Received: by 2002:a2e:b794:0:b0:2d4:6814:7c98 with SMTP id n20-20020a2eb794000000b002d468147c98mr4026696ljo.43.1711361964560;
        Mon, 25 Mar 2024 03:19:24 -0700 (PDT)
Received: from Ansuel-XPS. (93-34-89-13.ip49.fastwebnet.it. [93.34.89.13])
        by smtp.gmail.com with ESMTPSA id gw8-20020a05600c850800b004146dd6bfe2sm7935583wmb.47.2024.03.25.03.19.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Mar 2024 03:19:24 -0700 (PDT)
Message-ID: <66014fac.050a0220.92b6d.5b41@mx.google.com>
X-Google-Original-Message-ID: <ZgFPqANkonYB2rla@Ansuel-XPS.>
Date: Mon, 25 Mar 2024 11:19:20 +0100
From: Christian Marangi <ansuelsmth@gmail.com>
To: Miquel Raynal <miquel.raynal@bootlin.com>
Cc: Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
	=?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v2] mtd: limit OTP NVMEM Cell parse to non Nand devices
References: <20240321095522.12755-1-ansuelsmth@gmail.com>
 <20240321113256.7e66ac0f@xps-13>
 <65fc0d2b.050a0220.102ac.24f6@mx.google.com>
 <20240321141935.1b9f6e71@xps-13>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240321141935.1b9f6e71@xps-13>

On Thu, Mar 21, 2024 at 02:19:35PM +0100, Miquel Raynal wrote:
> Hi,
> 
> ansuelsmth@gmail.com wrote on Thu, 21 Mar 2024 11:34:16 +0100:
> 
> > On Thu, Mar 21, 2024 at 11:32:56AM +0100, Miquel Raynal wrote:
> > > Hi Christian,
> > > 
> > > ansuelsmth@gmail.com wrote on Thu, 21 Mar 2024 10:55:13 +0100:
> > >   
> > > > MTD OTP logic is very fragile and can be problematic with some specific
> > > > kind of devices.
> > > > 
> > > > NVMEM across the years had various iteration on how Cells could be
> > > > declared in DT and MTD OTP probably was left behind and
> > > > add_legacy_fixed_of_cells was enabled without thinking of the consequences.
> > > > 
> > > > That option enables NVMEM to scan the provided of_node and treat each
> > > > child as a NVMEM Cell, this was to support legacy NVMEM implementation
> > > > and don't cause regression.
> > > > 
> > > > This is problematic if we have devices like Nand where the OTP is
> > > > triggered by setting a special mode in the flash. In this context real
> > > > partitions declared in the Nand node are registered as OTP Cells and
> > > > this cause probe fail with -EINVAL error.
> > > > 
> > > > This was never notice due to the fact that till now, no Nand supported
> > > > the OTP feature. With commit e87161321a40 ("mtd: rawnand: macronix: OTP
> > > > access for MX30LFxG18AC") this changed and coincidentally this Nand is
> > > > used on an FritzBox 7530 supported on OpenWrt.
> > > > 
> > > > Alternative and more robust way to declare OTP Cells are already
> > > > prossible by using the fixed-layout node or by declaring a child node
> > > > with the compatible set to "otp-user" or "otp-factory".
> > > > 
> > > > To fix this and limit any regression with other MTD that makes use of
> > > > declaring OTP as direct child of the dev node, disable
> > > > add_legacy_fixed_of_cells if we have a node called nand since it's the
> > > > standard property name to identify Nand devices attached to a Nand
> > > > Controller.  
> > > 
> > > You forgot to update the commit log :-)
> > >  
> > 
> > Ugh... sorry. Ok to resend or I need to wait 24h similar to the rules on
> > net-next?
> > 
> 
> You can go ahead, but I'll only queue it after -rc1 is out.
>

Doing it right now.

-- 
	Ansuel

