Return-Path: <linux-kernel+bounces-74561-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CCEE685D5FF
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 11:48:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3909DB22FF9
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 10:48:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 240533BB34;
	Wed, 21 Feb 2024 10:48:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ti6uUWf4"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67A665394;
	Wed, 21 Feb 2024 10:48:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708512525; cv=none; b=sZYg1vMNcnziemxA97LU5FFC8NS9iriszzL2Nhn9HIHmWwQDaLn9fEZWPYpKE4km4vURpOKmGTLxh28uQfEZFX/3d8O+LvJcew9beDlw/pK3qbAojDCmVxbGscHzbVeFvYPwSwzhV5p0pDoz9qFI2T5UL7GjmlNgxMH8KLIPN68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708512525; c=relaxed/simple;
	bh=du6ulVJ73M5wtTyYQAMASVTtXVIeYy+D8eMVD7sAGcM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=eRo8KPE8HZpAHbp+yz91z3y1suK45t/APcRVr62vrG7AtbvvZmgIviYwsmMJkSHMqen8rZSDdfPmKJuk0IkkyqqLecLnxwL3h1FW37MVc+sfC/szRgUb3AXkOOtRZyO7dwtdpxKDURP0+QUFD/7BEMh2pLxBIA94Mm/A7VThl/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ti6uUWf4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D911CC43390;
	Wed, 21 Feb 2024 10:48:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708512525;
	bh=du6ulVJ73M5wtTyYQAMASVTtXVIeYy+D8eMVD7sAGcM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=ti6uUWf4IMz0kw7JYGID5wK+hy5KW5gd72V9h+qGGVURRiy25YuWyrqx7ytJVmBQm
	 W0SefMJ5GIJZVl9iBOwtS2c+VvgfP6bgM8VNer3k88ze/LPMVPJ0NCSSZKczu1KTat
	 bjag50BtU0sZlPkPe9Up4g4bkxKFHm4MBYQFq9v6ISJIBil9r9+moARU88SsTawU94
	 I0vgD//rWiWYCPYePus98rkRTlOWbTNO1YBeNBAAmxc3b8WtWaO1dhr7uU3r3MeVGM
	 Te92lqOTFG2tM34rDUW9tJ2ZIoyAi8eIJRNJIBfGcmh+/WJ8KKFudToHPJdo/cZioI
	 jjgzAhewmIzNQ==
From: Pratyush Yadav <pratyush@kernel.org>
To: "Michael Walle" <mwalle@kernel.org>
Cc: "Josua Mayer" <josua@solid-run.com>,  "Tudor Ambarus"
 <tudor.ambarus@linaro.org>,  "Pratyush Yadav" <pratyush@kernel.org>,
  "Miquel Raynal" <miquel.raynal@bootlin.com>,  "Richard Weinberger"
 <richard@nod.at>,  "Vignesh Raghavendra" <vigneshr@ti.com>,  "Rob Herring"
 <robh+dt@kernel.org>,  "Krzysztof Kozlowski"
 <krzysztof.kozlowski+dt@linaro.org>,  "Conor Dooley"
 <conor+dt@kernel.org>,  <linux-mtd@lists.infradead.org>,  "Takahiro
 Kuwano" <tkuw584924@gmail.com>,  "Takahiro Kuwano"
 <Takahiro.Kuwano@infineon.com>,  "Yazan Shhady"
 <yazan.shhady@solid-run.com>,  "Rob Herring" <robh@kernel.org>,
  <devicetree@vger.kernel.org>,  <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v7] dt-bindings: mtd: spi-nor: add optional interrupts
 property
In-Reply-To: <CZANBUQ2RJ3N.DO07Z9VFJCBZ@kernel.org> (Michael Walle's message
	of "Wed, 21 Feb 2024 10:23:25 +0100")
References: <20240219-mtd-flash-interrupt-binding-v7-1-206e30a656fa@solid-run.com>
	<CZAM553H2H56.2TDN36QEL90XX@kernel.org>
	<a0144c5b-4095-4a0c-84b6-93dfe9631a6b@solid-run.com>
	<CZANBUQ2RJ3N.DO07Z9VFJCBZ@kernel.org>
Date: Wed, 21 Feb 2024 11:48:41 +0100
Message-ID: <mafs0v86i6qk6.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Wed, Feb 21 2024, Michael Walle wrote:

> [+ Takahiro]
>
> Hi,
>
> On Wed Feb 21, 2024 at 10:13 AM CET, Josua Mayer wrote:
>> Hi,
>>
>> Am 21.02.24 um 09:27 schrieb Michael Walle:
>> > Hi,
>> >
>> > On Mon Feb 19, 2024 at 3:41 PM CET, Josua Mayer wrote:
>> >> Some spi flash memories have an interrupt signal which can be used for
>> >> signalling on-chip events such as busy status or ecc errors to the host.
>> > Do you have an example? Maybe one with a public datasheet?
>>
>> My example is Infineon S28HS512T, however datasheet download requires 
>> user account.
>>
>> S26HS512T has interrupt line, too, and datasheet is downloadable without 
>> registration:
>> https://www.infineon.com/cms/en/product/memories/nor-flash/semper-nor-flash-family/semper-nor-flash/#!documents
>
> Thanks, as far as I can see, both are hyperbus flashes. I'm asking
> because I'm not aware of any SPI NOR flash with an interrupt line. 

I found this datasheet [0] for S28H flash family from Infineon on
Google. These are SPI NOR flashes. In pinout you can see there is an
INT# signal. The signal description says: "System Interrupt (INT#). When
LOW, the device is indicating that an internal event has occurred."
Further in section 4.1.1.5 "INT# Output" it says:

    HL-T/HS-T supports INT# output pin to indicate to the host system
    that an event has occurred within the flash device. The user can
    configure the INT# output pin to transition to the active (LOW)
    state when:

    - 2-bit ECC error is detected
    - 1-bit ECC error is detected
    - Transitioning from the Busy to the Ready state

[0] https://www.infineon.com/dgdl/Infineon-S28HS256T_S28HS512T_S28HS01GT_S28HL256T_S28HL512T_S28HL01GT_256-Mb_(32-MB)_512-Mb_(64-MB)_1-Gb_(128-MB)_HS-T_(1.8-V)_HL-T_(3.0-V)_Semper_Flash_with_Octal_Interface-DataSheet-v03_00-EN.pdf?fileId=8ac78c8c7d0d8da4017d0ee6bca96f97&da=t

-- 
Regards,
Pratyush Yadav

