Return-Path: <linux-kernel+bounces-105977-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 354BC87E707
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 11:16:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 650B31C21A37
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 10:16:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BC002D605;
	Mon, 18 Mar 2024 10:16:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="F6cjIG4L"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A5BD2E633;
	Mon, 18 Mar 2024 10:16:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710756969; cv=none; b=jJg1Mv7q1DwQdOyIxLrmzgL/YwveoujZ7TUOKFgk3jXnLFxrCe9HnGTnaonG5d+rC4FEFGTON/Q4z0xSmZ35i4xM61HR2fJVhPDK+OMTy7HafhbXjWS97yGP03PxNpRJ4phm1TgfAkq5qhNn/hicwNxwEa2oargsGDrh+WiOB3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710756969; c=relaxed/simple;
	bh=wdXdeRL5x3UOBKa21ru0LJKOTtloww8Fsce2L+TBuw4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eNN3PwFvf70MnmTMjYVR+NwhdeojGBFNVdLhsAiQiHgOiEuNOZReEHyknlCWrLjVUnHtdCM0pvcOATvEGe20OnpHtAXk7q012PuE10pJYP8bKXJ4Jn+zI2nw9mQYJo7hqBJ/pIykCJDuPH0zU8mXc5D3XGHABV+2mFZgAdvZIj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=F6cjIG4L; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1710756966;
	bh=wdXdeRL5x3UOBKa21ru0LJKOTtloww8Fsce2L+TBuw4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=F6cjIG4L2XY8BPDTZdzVLWFg4FUME3aGH2vdFWDlZlRpzmPdHhWx3iypezSs1oCgU
	 as7Q+/lbn01t611RG/+UNFL7P6ryKxX90SxVRrBOo8NLMvN3ULR+UBgLSLT1uVBO3s
	 PbTQPh/QhDLNxKj+y9UotgF1YpnVBM3BBqDo6RZB2JZafeOQZF0mTTU5Z3WNEukIcI
	 HQN03+0Tri4OpkavDA/UoH7pQJJpZZk50q/r94CGPBAI8uB5iTMvlSNlnW2pr3q1TD
	 r7duVIF9h4WeO0PDZznD4hZI4gDOp9zChN5XrJPd1Gu8aICumFoCTA4e3o82wRyX88
	 79x1a3IIiK6eg==
Received: from [100.113.186.2] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 15D6C3781FCD;
	Mon, 18 Mar 2024 10:16:06 +0000 (UTC)
Message-ID: <ff184df8-1917-456b-97c8-bc270987bd55@collabora.com>
Date: Mon, 18 Mar 2024 11:16:05 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] spi: mt7621: allow GPIO chip select lines
Content-Language: en-US
To: Justin Swartz <justin.swartz@risingedge.co.za>,
 Mark Brown <broonie@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org
References: <71533474-eb08-438c-b7ec-5f3277c195fc@sirena.org.uk>
 <20240316010302.20776-1-justin.swartz@risingedge.co.za>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20240316010302.20776-1-justin.swartz@risingedge.co.za>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 16/03/24 02:03, Justin Swartz ha scritto:
> Extract a magic number, from mt7621_spi_probe(), used to
> declare the number of chip select lines (which co-incides
> with the native chip select count of 2) to a macro.
> 
> Use the newly defined MT7621_NATIVE_CS_COUNT macro to
> instead populate both the spi_controller's max_native_cs
> and num_chipselect members.
> 
> Declare that the spi_controller should use_gpio_descriptors
> if present in the device properties (such as those declared
> in the cs-gpio property of a "ralink,mt7621-spi" compatible
> device-tree node) so that the SPI core will recalculcate
> num_chipselect to account for the GPIO descriptors that
> it should have populated in the cs_gpiod array member.
> 
> Remove the assignment of mt7621_spi_transfer_one_message()
> to the spi_controller's transfer_one_message hook.
> 
> Refactor the mt7621_spi_transfer_one_message() logic into
> mt7621_spi_prepare_message() and mt7621_spi_transfer_one()
> and assign both to the spi_controller's prepare_message
> and transfer_one hooks respectively.
> 
> Migrate the call mt7621_spi_transfer_one_message() made to
> mt7621_spi_flush() just before chip select deactivation,
> to the end of mt7621_spi_write_half_duplex() to ensure
> that any pending data is shifted out of MOSI before the SPI
> core deactivates the chip select line.
> 
> As chip select activation is now taken care of by the SPI
> core, due to the use of the transfer_one hook instead of
> transfer_one_message, the calls to mt7621_spi_set_cs()
> from mt7621_spi_transfer_one_message() have fallen away.
> 
> And although the SPI core will handle activation for GPIO
> chip select lines behind the scenes, it requires a callback
> to allow the driver to perform controller-specific
> operations to control its native chip select lines.
> 
> Rename mt7621_spi_set_cs() to mt7621_spi_set_native_cs()
> and make sure that it takes into account the activation
> polarity of the chip select line it's acting upon, as the
> passed enable parameter represents the desired line level
> and not the desired activation state, and then assign
> mt7621_set_cs() to the spi_controller's set_cs hook.
> 
> Signed-off-by: Justin Swartz <justin.swartz@risingedge.co.za>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>



