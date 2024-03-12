Return-Path: <linux-kernel+bounces-100921-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 22C68879FAE
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 00:26:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 54BA81C2135A
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 23:26:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DB2B47A52;
	Tue, 12 Mar 2024 23:26:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bewilderbeest.net header.i=@bewilderbeest.net header.b="ES8+2yK7"
Received: from thorn.bewilderbeest.net (thorn.bewilderbeest.net [71.19.156.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1122D4AEC7;
	Tue, 12 Mar 2024 23:26:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=71.19.156.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710285997; cv=none; b=BBZIQS+IH45QQyvozR15xCbeLebqV2FR+y4SDO5BTkqhOJnsy17ttuLo4w0zQxXRoHO9ivqCM2MCpuByLz/W7JnOUk9SANWnVxeSbxDhvZFP9HIRc6cS+uvQ3H0cuQVCjJge2Z2GABu+KyZJJbutDezDqmdxL5hYCHrCZwhh0YE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710285997; c=relaxed/simple;
	bh=Kh3TkSItmOPvkF5HlCsbRVwXmKzwWlNpiqTijsrHll8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P+U3KVbffwk7TFu006uT4hEaMyZswyJqDJ3NzpeLhty4gQvW1vUj81VfqUZUOIRs84+4rBV0OBqQgv6Su8Zc13x6cX/2FvwF19jCDfhxDao7wwTA9sSp1DuokIUDiMTHfYl2DG3EyTCPBgT96VPGCU5IoSHYQHbIv086BKR2ois=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bewilderbeest.net; spf=pass smtp.mailfrom=bewilderbeest.net; dkim=pass (1024-bit key) header.d=bewilderbeest.net header.i=@bewilderbeest.net header.b=ES8+2yK7; arc=none smtp.client-ip=71.19.156.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bewilderbeest.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bewilderbeest.net
Received: from hatter.bewilderbeest.net (unknown [IPv6:2602:61:712b:6300::2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: zev)
	by thorn.bewilderbeest.net (Postfix) with ESMTPSA id 1EBA16C5;
	Tue, 12 Mar 2024 16:18:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bewilderbeest.net;
	s=thorn; t=1710285504;
	bh=EYwBh95DHhz9r9QVHywR28E43x2Y+m0ywwZ1m0v/Ne0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ES8+2yK7wjiIjMBDw8RuZ3IxWwX8x2LPTh/Meu+zvnyCL6IYGxZdM9aT3q79RhEi6
	 5Ky10wTfYLgc2llCsDKgXtoEiF2wNm0KL+qU//WdHHqw/CQbnyyBucXq13DMfgwMFY
	 rJFLg1Ruo/C2nb9DLfhytK/QIcETYK369yehGzEA=
Date: Tue, 12 Mar 2024 16:18:22 -0700
From: Zev Weiss <zev@bewilderbeest.net>
To: Ban Feng <baneric926@gmail.com>
Cc: jdelvare@suse.com, linux@roeck-us.net, robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
	corbet@lwn.net, linux-hwmon@vger.kernel.org,
	devicetree@vger.kernel.org, kcfeng0@nuvoton.com, kwliu@nuvoton.com,
	openbmc@lists.ozlabs.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, DELPHINE_CHIU@wiwynn.com,
	naresh.solanki@9elements.com, billy_tsai@aspeedtech.com
Subject: Re: [PATCH v4 3/3] hwmon: Driver for Nuvoton NCT7363Y
Message-ID: <cd63bec7-01c6-466e-b772-3a3d3d90a7d5@hatter.bewilderbeest.net>
References: <20240227005606.1107203-1-kcfeng0@nuvoton.com>
 <20240227005606.1107203-4-kcfeng0@nuvoton.com>
 <a90ed00c-f836-4fb6-8191-9974937e3eb7@hatter.bewilderbeest.net>
 <CALz278Zgfgob573vgWz4PgC7vb=i8xt3kC1hSjo_cQi00B0XAg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CALz278Zgfgob573vgWz4PgC7vb=i8xt3kC1hSjo_cQi00B0XAg@mail.gmail.com>

On Wed, Mar 06, 2024 at 11:35:31PM PST, Ban Feng wrote:
>Hi Zev,
>
>On Sat, Mar 2, 2024 at 4:19 PM Zev Weiss <zev@bewilderbeest.net> wrote:
>>
>> On Mon, Feb 26, 2024 at 04:56:06PM PST, baneric926@gmail.com wrote:
>> >From: Ban Feng <kcfeng0@nuvoton.com>
>> >
>> >NCT7363Y is an I2C based hardware monitoring chip from Nuvoton.
>> >
>> >Signed-off-by: Ban Feng <kcfeng0@nuvoton.com>
>> >---

<snip>

>> >+
>> >+static const struct of_device_id nct7363_of_match[] = {
>> >+      { .compatible = "nuvoton,nct7363" },
>>
>> As far as I can see from the code in this driver, it looks like this
>> driver should also be compatible with the nct7362; shall we add the ID
>> table entry for it now?  (Though I only have a datasheet for the
>> nct7362, not the nct7363, so I don't know exactly how they differ.)
>
>As far as I know, the difference between these two ICs is 0x2A~0x2C
>Fading LED for 7362, and 0x2A Watchdog Timer for 7363.
>In my v1 patch, I indeed add the nct7362 to the ID table, however,
>this makes it more complicated and our datasheet isn't public yet.
>I think maybe supporting more chips will be done in the future, but not now.
>

If the only differences are in features the driver doesn't utilize, I'm 
not clear on how it adds any complexity.  As far as I'm aware, neither 
datasheet is public (NCT7363 nor NCT7362), so if we're going to have a 
public driver for one, why not also do so for the other?  It's a single 
additional line -- and furthermore, having made that change and tested 
it out, I can report that the driver seems to work just fine on NCT7362 
hardware as well.


Zev


