Return-Path: <linux-kernel+bounces-48459-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EB03A845C60
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 17:00:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 235971C2BE6F
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 16:00:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 289BB779E8;
	Thu,  1 Feb 2024 15:56:38 +0000 (UTC)
Received: from mail.enpas.org (zhong.enpas.org [46.38.239.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0599C626B6;
	Thu,  1 Feb 2024 15:56:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.38.239.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706802997; cv=none; b=UC1fXjiSyBIaLmw+w/u84txSDpeEgvgaqQVBZbKfVuJy+72ozqV7m6oxmexsPSSwWCSAPszCeU3ql6zGc7z6NqSSht2jB05iu6HVu1beEGH33kPUOfoWas4JN7dgfYVSerPzG6vzdXNbqwtY6hDxks92S3nyvTqKrAU9hmkDrOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706802997; c=relaxed/simple;
	bh=HZRmG/u2yOoG/gtlPI7AZER68B4VPuCYhtlhcp1Zmc4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=T6bI3LK0DlZasyDH7x5srKjspXPYYq6y1HqesqwssUbyC9T+EgwDpoH+qjoj28NCopThbzqcxwlya2DMnsqfIpFGBWVfAnzoiEXq+EUI9Dn09Y9tW6G7j3TVCInRO1CwyJyjfdSMroyYZhnPbT7dTI50eiVep5M+NiqMMWApwXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=enpas.org; spf=pass smtp.mailfrom=enpas.org; arc=none smtp.client-ip=46.38.239.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=enpas.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=enpas.org
Received: from [127.0.0.1] (localhost [127.0.0.1])
	by mail.enpas.org (Postfix) with ESMTPSA id A99A8FFE54;
	Thu,  1 Feb 2024 15:56:25 +0000 (UTC)
Message-ID: <b4aefd3f-e5b6-4474-8122-763523786cd2@enpas.org>
Date: Fri, 2 Feb 2024 00:56:19 +0900
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 7/7] HID: playstation: DS4: Add VID/PID for SZ-MYPOWER
 controllers
To: Roderick Colenbrander <thunderbird2k@gmail.com>
Cc: Roderick Colenbrander <roderick.colenbrander@sony.com>,
 Jiri Kosina <jikos@kernel.org>,
 Benjamin Tissoires <benjamin.tissoires@redhat.com>,
 linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240115144538.12018-1-max@enpas.org>
 <20240115144538.12018-8-max@enpas.org>
 <CAEc3jaBU3M0Zce2pdFvdBSG50a7Ky=GY4gLO3dkYdDrkYtiO0Q@mail.gmail.com>
 <e107b202-5843-41a7-b61e-68dd92128176@enpas.org>
 <CAEc3jaCifoWW3ZXHvySSfgwhVm1AffYe=z7HRP9RjmYyu53w7Q@mail.gmail.com>
 <d5d301c6-172d-4204-88cc-2dc9b351e693@enpas.org>
 <CAEc3jaDFh3UY8AGnXA3s13DbcKTFnBT8Z7iq4qdqnM5o3nVHFA@mail.gmail.com>
Content-Language: en-US
From: Max Staudt <max@enpas.org>
In-Reply-To: <CAEc3jaDFh3UY8AGnXA3s13DbcKTFnBT8Z7iq4qdqnM5o3nVHFA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/1/24 01:34, Roderick Colenbrander wrote:
> I agree it sounds like a good idea for now to drop just those 2 paches
> and just see what other devices are out there (SDL2 has a good ds4
> implementation too and they dealt with a lot of devices). May need to
> get some of the 8bitdo and many others to see some patterns.

8BitDo seem to be interesting indeed. IIRC they need the patches for the firmware version, the gyro calibration, and 0x01 events.


Max


