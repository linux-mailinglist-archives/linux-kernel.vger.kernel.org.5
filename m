Return-Path: <linux-kernel+bounces-78615-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AC328615EA
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 16:34:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E81F6287A9E
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 15:34:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59A3D82868;
	Fri, 23 Feb 2024 15:34:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=trvn.ru header.i=@trvn.ru header.b="qq6TzNBG"
Received: from box.trvn.ru (unknown [194.87.146.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 827214A3D;
	Fri, 23 Feb 2024 15:34:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.87.146.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708702484; cv=none; b=tmTTw2da6IM0n0IcsmagIAG0cK7BR6h+UTMMm7+qC0nGcpnxTCUxfHKLXbXbpdmWNzpTTE1P+krNBnL2bsAvQMdxLlAtsYNk9zGTYl6ynAuq0rnq/OqrPiXHFwZVk6s4D1R/lwgrjULEes5jl+RXXWw/RBqWbs9Z/WFK18kf+W4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708702484; c=relaxed/simple;
	bh=0SNtXViAi/uuzITK6f3+yak148HxUT/1hggSYF8AK6Y=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=SmmfxeQ9jWjmDSuk33Sm9WTsdLK2WZB+pJ68pPZ3C9Ho1FR1XH1vohWb+b2nCy9r+CMcVX0IWgyrE9YDWiVkCWep7I2CfsOFjgp9Ar+LyT71F2kx1SZwvkCNL4cl3HPQ7NyzILZkS8W/enWDIiyr12y+o2wozFeHOVkELBsU0pU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=trvn.ru; spf=pass smtp.mailfrom=trvn.ru; dkim=pass (2048-bit key) header.d=trvn.ru header.i=@trvn.ru header.b=qq6TzNBG; arc=none smtp.client-ip=194.87.146.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=trvn.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trvn.ru
Received: from authenticated-user (box.trvn.ru [194.87.146.52])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	by box.trvn.ru (Postfix) with ESMTPSA id 9694A40164;
	Fri, 23 Feb 2024 20:34:30 +0500 (+05)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=trvn.ru; s=mail;
	t=1708702471; bh=0SNtXViAi/uuzITK6f3+yak148HxUT/1hggSYF8AK6Y=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=qq6TzNBGn05giGvmcRQt3AaAYb/F/pzsMBFrc0khdePz1ghzyF/iRXUEmoaELmULx
	 kGf29xKC7wG0D4ZNvipJkyYDbp7hnSCsq/2MHRw8ko6B4+ndA0lGGw2ylRvH3tKsZt
	 qdrTV6ECrpuN7f0V2xSsBgWoNyLUJQeJikTicP3lSiGIaIXp7QhUDaimK4uKjAE3eC
	 rcSnmEdBRh0QskL1PWIAyqEcZXukZp378sMEb7T5RFPDvw+44WEGLPaWS4j66IfprM
	 R5oBdwi2MET5cZCR+LtLhHxzrZxVDPWBeGtgereyi5DxsLAzQqEMUMP32E8hJP71Yd
	 CaU1bnWbVbJkA==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Fri, 23 Feb 2024 20:34:29 +0500
From: Nikita Travkin <nikita@trvn.ru>
To: Sebastian Reichel <sebastian.reichel@collabora.com>
Cc: Hans de Goede <hdegoede@redhat.com>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley
 <conor+dt@kernel.org>, cros-qcom-dts-watchers@chromium.org, Andy Gross
 <agross@kernel.org>, Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio
 <konrad.dybcio@linaro.org>, Rob Herring <robh@kernel.org>,
 linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 platform-driver-x86@vger.kernel.org
Subject: Re: [PATCH v3 2/3] power: supply: Add Acer Aspire 1 embedded
 controller driver
In-Reply-To: <xelebhoitnwguhewahw26xopl5btjo5ezznjjaeb2zfyy2bpcr@7pmclezshwck>
References: <20240220-aspire1-ec-v3-0-02cb139a4931@trvn.ru>
 <20240220-aspire1-ec-v3-2-02cb139a4931@trvn.ru>
 <qoidm5wujjbeoc2hlraky26wuwmuaxi2atyl6ehovhvffdbfeh@g5gunqdei45m>
 <7c429d2110dbac68d0c82c8fb8bfb742@trvn.ru>
 <xelebhoitnwguhewahw26xopl5btjo5ezznjjaeb2zfyy2bpcr@7pmclezshwck>
Message-ID: <6e3fb1080c54cfc38dc3c3e79e32a53d@trvn.ru>
X-Sender: nikita@trvn.ru
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Sebastian Reichel писал(а) 23.02.2024 20:04:
> Hi,
> 
> On Fri, Feb 23, 2024 at 07:32:17PM +0500, Nikita Travkin wrote:
>> >> + This driver provides battery and AC status support for the mentioned
>> >
>> > I did not see any AC status bits?
>>
>> I was referring to whatever ACPI spec calls "AC Adapter" but I guess
>> I should have used the word "charger" instead... Will reword this.
> 
> But you only register a power-supply device for the battery and not
> for the AC adapter/charger. When you write "and AC status support" I
> would have expected something similar to this (that's from ACPI AC
> adapter driver):
> 
> $ cat /sys/class/power_supply/AC/uevent
> POWER_SUPPLY_NAME=AC
> POWER_SUPPLY_TYPE=Mains
> POWER_SUPPLY_ONLINE=1
> 

Ah, I see... Yeah looking at it one more time, I mistakenly assumed the
acpi ac code uses the same data fields as the battery but seems like it
reads the single online flag from a different place. I don't think there
is really a point on implementing that field since we can still easily
track the battery charging/discharging status so I will probably omit it
for now. Will reword the help text to not mention charger/ac adapter.

Thanks for clarifying!
Nikita

> -- Sebastian

