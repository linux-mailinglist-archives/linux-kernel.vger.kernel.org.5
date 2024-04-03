Return-Path: <linux-kernel+bounces-129689-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 30A59896E74
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 13:48:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DD71B280FB2
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 11:48:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C341D146583;
	Wed,  3 Apr 2024 11:48:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jpcpFqrz"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BE9A17583;
	Wed,  3 Apr 2024 11:48:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712144920; cv=none; b=Mxzlmt1H2u36cDM5qnM9EIfDWzDPhmq8b1a2atHWdsxCRf9puETqmFZWTOrsNHefPBQzN87jXG+MyZBxn1kFPXI7e0+05Ly53NgbLvMiz3GIVoAbDCyLDlyIlfdBsjUcwIRwEAhXW2oJJIIXEeIRy2SxuJyRh4OWgYdPAjBPI4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712144920; c=relaxed/simple;
	bh=+bk5AVTGTLDyKn+7eW/2HRi0luW9LhNFv4tAhmqCL8Y=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=Ih06VZFXIclFLISxpXV4wF+f3kIBAjj49bJPp/3eVJVDrtKTHL4syZACArdU5+fxngSPo/kUB4g5QT+iZK48y0tT3TEWgCYkH7RxWiQM1QPD2e7IFUHkm37DfC0ycD2SiN0YIFBX3nnrtvrTJiIpwS/lazxSAOqcgc42lV7XfK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jpcpFqrz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3108EC433F1;
	Wed,  3 Apr 2024 11:48:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712144919;
	bh=+bk5AVTGTLDyKn+7eW/2HRi0luW9LhNFv4tAhmqCL8Y=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=jpcpFqrzvkNCbNza0prjLjHUJZA7b0prlj+uu5ngEA4plxEH/X8NTEDkV+Uu35nAA
	 eLZ6CaR7ytdQPFSnBCqP285hNioVeUv396n14xjNcyipbqm8/bSTbNJUgsbzLZkwZ7
	 6KlDSdrKr+2C2I0Y9e59g2z6tfT677V4vGze2BNXbA3a9cKFy8j5H/j3Gyo7K9T7M5
	 mF1G8NnBC5HithGcDrMoqNyxKWVsEq51DcqYCLViQSaxzDEtzwV74yBwtmhmyt9zLQ
	 ByS+BvuTBHeSOaTTE1g8mC/bxHrR/pPtUKH8tIN8h4gh39rgAOqpugUOx5gF4CGQyB
	 Cf/+8lMeAplqQ==
Date: Wed, 3 Apr 2024 13:48:37 +0200 (CEST)
From: Jiri Kosina <jikos@kernel.org>
To: Allen_Lin <allencl_lin@hotmail.com>
cc: dmitry.torokhov@gmail.com, robh@kernel.org, 
    krzysztof.kozlowski+dt@linaro.org, conor@kernel.org, 
    benjamin.tissoires@redhat.com, linux-input@vger.kernel.org, 
    devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/4] HID: Add support for Himax HX83102j touchscreen
In-Reply-To: <TY0PR06MB561132DF147C037093A1B94D9E3E2@TY0PR06MB5611.apcprd06.prod.outlook.com>
Message-ID: <nycvar.YFH.7.76.2404031347540.20263@cbobk.fhfr.pm>
References: <TY0PR06MB561132DF147C037093A1B94D9E3E2@TY0PR06MB5611.apcprd06.prod.outlook.com>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Tue, 2 Apr 2024, Allen_Lin wrote:

> Hi,
> This driver implements for Himax HID touchscreen HX83102j.
> 
> Using SPI interface to receive/send HID packets.
> 
> Changes in v2 :
> -Added power description in YAML document. 
> -Added ddreset-gpios property in YAML document.
> -Added firmware-name property in YAML document.
> -Modified the description of pid.
> -Modified the example.
> 
> Allen_Lin (4):
>   dt-bindings: input: Add Himax HX83102J touchscreen
>   HID: Add Himax HX83102J touchscreen driver
>   HID: Add DRM panel follower function
>   HID: Load firmware directly from file to IC
> 
>  .../input/touchscreen/himax,hx83102j.yaml     |  100 +
>  MAINTAINERS                                   |    7 +
>  drivers/hid/Kconfig                           |    7 +
>  drivers/hid/Makefile                          |    2 +
>  drivers/hid/hid-himax-83102j.c                | 3071 +++++++++++++++++
>  drivers/hid/hid-himax-83102j.h                |  460 +++

My only nit here -- could we please call the driver just hid-himax, to 
follow the pattern we generally use in this subsystem (drivers named after 
vendors).

Please add Ack from Rob, rename the driver, resend, and I'll apply it. 
Thanks,

-- 
Jiri Kosina
SUSE Labs


