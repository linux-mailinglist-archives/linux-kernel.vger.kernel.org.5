Return-Path: <linux-kernel+bounces-130751-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 14D37897CB6
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 01:51:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 756A9B2B01D
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 23:51:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C95C156F56;
	Wed,  3 Apr 2024 23:48:39 +0000 (UTC)
Received: from mail.enpas.org (zhong.enpas.org [46.38.239.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ACBD156C55;
	Wed,  3 Apr 2024 23:48:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.38.239.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712188118; cv=none; b=MtVL/m2AzVnkTbIzPGK2mrHxEes7PUOf0rpNH7nqSsNsly/jJ32d0AlD3dtDuK0iCcRT3qfW4A0F24C5iPbh4QTnZkhI7PHk3hPPB55hsSMpQNQeFkP/dJVLaKXEkjoxMzRhkiqudH998fHNe4nJSUsvvHVSkD/xJ4J1c2DuBxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712188118; c=relaxed/simple;
	bh=e3AmAhRdVsC9ZCv18OiGXTYofY/MAgcNFFeXYLqPwPY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LtkYVK5w6Ov5XyruSiG/nBL3GxlFq0Ma3pWpke4nu9HSnhVpJCDWXsVsoFi8xHqZ3F7r0H34vvwYQ6JVam5TnJPag9R1cwVvoEuB4Fhw2UaIncHCiAQ5gEPS0w7qXiVrSCS8GOr0yC3uFtAkPPRoHFENGNPgKT7cCKiGNxrNVqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=enpas.org; spf=pass smtp.mailfrom=enpas.org; arc=none smtp.client-ip=46.38.239.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=enpas.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=enpas.org
Received: from [127.0.0.1] (localhost [127.0.0.1])
	by mail.enpas.org (Postfix) with ESMTPSA id 9AB14FF94F;
	Wed,  3 Apr 2024 23:39:21 +0000 (UTC)
Message-ID: <e3d606bd-2ccb-4900-9de5-81f2569b6411@enpas.org>
Date: Thu, 4 Apr 2024 01:39:16 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/5] HID: playstation: DS4: LED bugfix, third-party
 gamepad support
To: Jiri Kosina <jikos@kernel.org>,
 Roderick Colenbrander <thunderbird2k@gmail.com>
Cc: Roderick Colenbrander <roderick.colenbrander@sony.com>,
 Benjamin Tissoires <benjamin.tissoires@redhat.com>,
 linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240207163647.15792-1-max@enpas.org>
 <nycvar.YFH.7.76.2402271740260.21798@cbobk.fhfr.pm>
 <nycvar.YFH.7.76.2404032010320.5680@cbobk.fhfr.pm>
 <CAEc3jaBvM6zVAqecUaxbtwUOTni4yT0wum_5ab5N1DLVYvhOeQ@mail.gmail.com>
 <nycvar.YFH.7.76.2404032154040.5680@cbobk.fhfr.pm>
Content-Language: en-US
From: Max Staudt <max@enpas.org>
In-Reply-To: <nycvar.YFH.7.76.2404032154040.5680@cbobk.fhfr.pm>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/3/24 21:54, Jiri Kosina wrote:
> On Wed, 3 Apr 2024, Roderick Colenbrander wrote:
> 
>>> Roderick, please speak up now, or I'll queue this as-is for 6.10 in the
>>> coming few days. Thanks,
>>
>> Hi Jiri,
>>
>> Sorry for late reply, let's merge it. There are maybe 1-2 nitpicky
>> things I forgot to email about, but I can deal with those later if I
>> feel it is needed down the road.
> 
> Welcome back! :-)
> 
> Now queued in hid.git#for-6.10/playstation. Thanks,


Thank you both!


Max


