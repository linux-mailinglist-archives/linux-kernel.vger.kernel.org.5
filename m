Return-Path: <linux-kernel+bounces-106036-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C882187E815
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 12:07:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 74F6B1F23915
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 11:07:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 216D1364A7;
	Mon, 18 Mar 2024 11:07:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=risingedge.co.za header.i=@risingedge.co.za header.b="OmNaC+rW"
Received: from outgoing6.flk.host-h.net (outgoing6.flk.host-h.net [188.40.0.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F273D3BB4B;
	Mon, 18 Mar 2024 11:07:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.40.0.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710760031; cv=none; b=NxLDUObD2sENBo7mxarRdPsVpF/3h3xTpyldyLhK02HpXOt+d3ptCaJtQPDDVnEXP1rrbPcOpCAq58XnRuLvbLIlgV0n4yWFv/pJ6S5xQK48Fix8hzxophpHw5mffUBbyf/TAzdRwdPpn24M6ZpEKmHig+5K8NRZYyEkAbjve64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710760031; c=relaxed/simple;
	bh=dGIraIGBAlkTALVcyrBv04qRPHos8xuCffmq35I8Xz0=;
	h=MIME-Version:Content-Type:Date:From:To:Cc:Subject:In-Reply-To:
	 References:Message-ID; b=iL6h1TW0qwDCoo6Zk0o8DvcuO0YTWEHR+90L17uk/lOLa6SCLxkq+SSaELMq7t3Au6RKWllaMVMnQAYZZFrgKR8Dn4S0KlrylDbtfZPXknIo9w7HnZk5bwYGvUTeGuC2TEKpCpQoKATREBEvrEOsIQb3R+SuKj7XL6zAns9H8VU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=risingedge.co.za; spf=pass smtp.mailfrom=risingedge.co.za; dkim=pass (2048-bit key) header.d=risingedge.co.za header.i=@risingedge.co.za header.b=OmNaC+rW; arc=none smtp.client-ip=188.40.0.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=risingedge.co.za
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=risingedge.co.za
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=risingedge.co.za; s=xneelo; h=Message-ID:References:In-Reply-To:Subject:Cc:
	To:From:Date:Content-Transfer-Encoding:Content-Type:MIME-Version:reply-to:
	sender:bcc; bh=aES6a3OS2c4CKqUTrnxXQB0ATrFApT/0W3SOsIjOfVU=; b=OmNaC+rW3uAs2f
	QgoUHaCkWRJlDD3UxCGRpqFNur+6MhqA397ef+xMUh/UlBjgp4u5NrCu3qCzu3N5+OZ5y5ytCpQIj
	YDMSJ1Nu+YHON0k+sVJ+YXLP3N07tlwo8a+oIdq4/MLwtgAoyWIc0VwOyOf9k56J1FOSZafpl6sSj
	OdL/r3zyA4MPp875CrZD6u/RB6JBbrS56DDTdSBMJOfVlI6Dfi91pcKw88/u/xk35oRNy2Bt83i5w
	x7Is1hqNs7p4hSn82TcXZZWmyP2wgM8mzrWZ59Q5FD1fh0+bBtX2OX2BRLSedC/Nlzh5cTblbOhiJ
	Vgzj0tKZ7nccCyo5hIdw==;
Received: from www31.flk1.host-h.net ([188.40.1.173])
	by antispam2-flk1.host-h.net with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <justin.swartz@risingedge.co.za>)
	id 1rmApV-0041NY-7Q; Mon, 18 Mar 2024 13:06:59 +0200
Received: from roundcubeweb1.flk1.host-h.net ([138.201.244.33] helo=webmail9.konsoleh.co.za)
	by www31.flk1.host-h.net with esmtpa (Exim 4.92)
	(envelope-from <justin.swartz@risingedge.co.za>)
	id 1rmApS-0004FG-48; Mon, 18 Mar 2024 13:06:54 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date: Mon, 18 Mar 2024 13:06:54 +0200
From: Justin Swartz <justin.swartz@risingedge.co.za>
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: Mark Brown <broonie@kernel.org>, Matthias Brugger
 <matthias.bgg@gmail.com>, linux-spi@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org
Subject: Re: [PATCH v2] spi: mt7621: allow GPIO chip select lines
In-Reply-To: <ff184df8-1917-456b-97c8-bc270987bd55@collabora.com>
References: <71533474-eb08-438c-b7ec-5f3277c195fc@sirena.org.uk>
 <20240316010302.20776-1-justin.swartz@risingedge.co.za>
 <ff184df8-1917-456b-97c8-bc270987bd55@collabora.com>
Message-ID: <f068eab7d873b9cdfae41b5413ebdbb8@risingedge.co.za>
X-Sender: justin.swartz@risingedge.co.za
User-Agent: Roundcube Webmail/1.3.17
X-Authenticated-Sender: justin.swartz@risingedge.co.za
X-Virus-Scanned: Clear
X-SpamExperts-Domain: risingedge.co.za
X-SpamExperts-Username: 
Authentication-Results: host-h.net; auth=pass (login) smtp.auth=@risingedge.co.za
X-SpamExperts-Outgoing-Class: ham
X-SpamExperts-Outgoing-Evidence: Combined (0.17)
X-Recommended-Action: accept
X-Filter-ID: Pt3MvcO5N4iKaDQ5O6lkdGlMVN6RH8bjRMzItlySaT/rOJCKbX9miqwerxCr/aRDPUtbdvnXkggZ
 3YnVId/Y5jcf0yeVQAvfjHznO7+bT5wCPRB8bAzJcv2cv+UqiTTc2+CpNcmBnO4XM3Sck4bwNogU
 WCl1nkLBzZX0KuJ9bXiS85Z42w/+2OBolTNFbPomXFWCX8oNdggW7HE9XDTdSejrkEpbuUvwMvHx
 3T+KSG//gbuP7hnUK8NQdLwsVWKIss2oH4Yjh6Q4paNNh70vrmKlRYN8+ZW0XX0AH/7tz8mRXWrF
 hJyjzh57IgdFI86qE2zvVTW9GHsmX5lEgZyi8RqOqcNSPSnc4M/XfNJWJDtOUWMR3Oz/N19DDfqg
 //ykQCB4rUl3suKct8rEwEjtlMaQ3Kqc4IaO53NS7XmlLOmnyX004TPenHFXEu+U7r0UWmuNA8WT
 ybi1JN85FSnfKaZl5e9CnNR0t//S8nh6vX9JR7tTkgtGxbJXMnaWeORi/IOL8hFK8UwSRsjj826v
 xIvoo9siXVea4yN8+JzC4p2qtoJeAaAIM5zNlwLSz7WsotxMDYRAzuCR0I/uZN17IfdXFZsEUcDk
 8TfE1VxuxGc2M4JzCc//R6Wyn0xEa4/gbKRUuwP9TxU53J++//mag2wVXO50BuTihrUiUr+Ne0YD
 3ddZG295JphtZpms9X0aBNANCxNWMmHXUTEMGGbKThOghFKJuzFdJ78lk25pCKnYrhUnk1aI/tYo
 PYfrgLItviC2z3vIzjh1mXBwO7cA3LYE//971/IPrjStHq+sLtv6f48W6vJ1YXzwg/yHdBoe6D9l
 C5HcnR5sMHCtNqaTmXQ4BkBE3IhMX1f/+suluw5k87r8vepAOoS2eUqUWS3rIOs6OFebJBWcGqKs
 Jc1xjt6Txl9yx/3BhqO3m5yd2tj74O4hBSz/kkmPgL+fgIguflsMx6vatUpjecZPSp26CgsDSXR1
 fPypOcxCjKydCywowm3Us7sd7s2fkLXUoQJ04q/WKvSWBPzknbkTJiNN9rwBJkpKiGGp8ai4iv7H
 Q04RFZ4oobg8BBg3Jq+ntzj0FowsI0DXck/yx+ZVYiqsOvAPPsA1Nn6T/CCq0ZTp7nHbYJHXR97j
 NGQqQSATsgnFexc/Dnd/+IKrbpnIVB7kSlFfEoXm0/FPF8PR0w363llwyMFXKarlqLFqhfrB0GFR
 NCI72pnwdS+UMZgGNjw2gmyaDtrWPzIOQpV3d9KAZvFEy4yZs8FnQMzvojpIo6wEKULl9qYjJqeC
 CacQRjWWfmKrLjRFuOfsv9pIlKVsvXNK4117w0+Iu7iq/3ilwajFT6Qh9VybPYnXpWlnmHX0yg==
X-Report-Abuse-To: spam@antispamquarantine.host-h.net

On 2024-03-18 12:16, AngeloGioacchino Del Regno wrote:
> Il 16/03/24 02:03, Justin Swartz ha scritto:
>> Extract a magic number, from mt7621_spi_probe(), used to
>> declare the number of chip select lines (which co-incides
>> with the native chip select count of 2) to a macro.
>> 
>> Use the newly defined MT7621_NATIVE_CS_COUNT macro to
>> instead populate both the spi_controller's max_native_cs
>> and num_chipselect members.
>> 
>> Declare that the spi_controller should use_gpio_descriptors
>> if present in the device properties (such as those declared
>> in the cs-gpio property of a "ralink,mt7621-spi" compatible
>> device-tree node) so that the SPI core will recalculcate
>> num_chipselect to account for the GPIO descriptors that
>> it should have populated in the cs_gpiod array member.
>> 
>> Remove the assignment of mt7621_spi_transfer_one_message()
>> to the spi_controller's transfer_one_message hook.
>> 
>> Refactor the mt7621_spi_transfer_one_message() logic into
>> mt7621_spi_prepare_message() and mt7621_spi_transfer_one()
>> and assign both to the spi_controller's prepare_message
>> and transfer_one hooks respectively.
>> 
>> Migrate the call mt7621_spi_transfer_one_message() made to
>> mt7621_spi_flush() just before chip select deactivation,
>> to the end of mt7621_spi_write_half_duplex() to ensure
>> that any pending data is shifted out of MOSI before the SPI
>> core deactivates the chip select line.
>> 
>> As chip select activation is now taken care of by the SPI
>> core, due to the use of the transfer_one hook instead of
>> transfer_one_message, the calls to mt7621_spi_set_cs()
>> from mt7621_spi_transfer_one_message() have fallen away.
>> 
>> And although the SPI core will handle activation for GPIO
>> chip select lines behind the scenes, it requires a callback
>> to allow the driver to perform controller-specific
>> operations to control its native chip select lines.
>> 
>> Rename mt7621_spi_set_cs() to mt7621_spi_set_native_cs()
>> and make sure that it takes into account the activation
>> polarity of the chip select line it's acting upon, as the
>> passed enable parameter represents the desired line level
>> and not the desired activation state, and then assign
>> mt7621_set_cs() to the spi_controller's set_cs hook.
>> 
>> Signed-off-by: Justin Swartz <justin.swartz@risingedge.co.za>
> 
> Reviewed-by: AngeloGioacchino Del Regno
> <angelogioacchino.delregno@collabora.com>

Thank you very much for the review.

