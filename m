Return-Path: <linux-kernel+bounces-30371-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CA31A831DDF
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 17:52:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 51CC6B2618A
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 16:52:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EA902CCD5;
	Thu, 18 Jan 2024 16:51:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="mfnkzC+w"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 850202CCB2;
	Thu, 18 Jan 2024 16:51:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705596714; cv=none; b=I55ymS6QdYNnZwpcB/ORaCBUKlFD+xBAMDFvw8K1f8P+27EVD0tMEFjtp0PwG+ZVm8YEJ1FwcYyQz0b1mZUzsiSAkLwgclXKmq9HZpnHf+tKKB3H3bL7Lxkng+wNq5STwjlCpCSP5T8+Grvt/HRUkvrC83C7mfYvlvF0GEGW+oM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705596714; c=relaxed/simple;
	bh=g4k6Us6qSFK82rGxtE1fQ0gk7/WowjsnzucPID1s3Gs=;
	h=DKIM-Signature:Received:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:Content-Language:To:References:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding; b=WZ7zp2KNRRZRQmFOJYM1L5vSLsQlh+rJPtnygd/HFYtQ27q3qmugwGhNtPNGPW3SyGrnKHYGCGbUCCzZ8BlwLPlp+47wPHRdG5/G4RrQjVeqz4xaoI75EUn3w1adhthQQq86fFo+Rn3ZwBNO4q97k/3wn99BskHybPA0kbBw4N4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=mfnkzC+w; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Cc:Content-ID:Content-Description;
	bh=C8m0IK49u5sZ+IzhyuhM102/BfnX6Kya5OFI36Y2IJ8=; b=mfnkzC+wSFRKo6Wrp4w+dDHALj
	AIYZJI/XLWHabwPfImc0z7vz21lEFEItsfn5e3al/7st7Fgq5b3txT95wDkaL0fRY2v6LjWXmoiH9
	3BQCOeorz5T0vSRaTRTdIgPaKgPygtBb7J8dxSF11zEw+rSurypmHmX1fKkC8cexxoxp448GIItep
	lUptGLhlsXy4PhjnJMlBGK3n0k7vTLoefj3634I+KyWNpRX/a8h4zwb2JVkh8pc4nMniE+bfjOFOt
	2mouyE3kJAqI3AhtuaMlv+XtAf1Qh7W1KeUneahJvtAS39KgFfvD252biSAiBdifJwQ8xndAGrfGa
	SHJYGH/w==;
Received: from [50.53.46.231] (helo=[192.168.254.15])
	by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
	id 1rQVcO-003JGo-1Q;
	Thu, 18 Jan 2024 16:51:52 +0000
Message-ID: <954506be-2c8a-443a-8cc3-db0fcad9539f@infradead.org>
Date: Thu, 18 Jan 2024 08:51:52 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] staging: rts5208: Add more details to Kconfig help
Content-Language: en-US
To: Jacob Lott <jklott.git@gmail.com>, gregkh@linuxfoundation.org,
 linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20240118160901.71756-1-jklott.git@gmail.com>
 <3f4582ac-8180-417b-a83a-0b9f362cc5a0@infradead.org>
 <5a60b50d-34f5-42a2-8112-f988b89f1e7f@gmail.com>
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <5a60b50d-34f5-42a2-8112-f988b89f1e7f@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 1/18/24 08:50, Jacob Lott wrote:
> 
> On 1/18/24 11:47 AM, Randy Dunlap wrote:
>> Hi--
>>
>> On 1/18/24 08:09, Jacob Lott wrote:
>>> The current help text is short and triggers a
>>> warning from checkpatch.pl. This patch adds more
>>> details to the help text which should provide better
>>> information for whether or not to enable the driver.
>>>
>>> Signed-off-by: Jacob Lott <jklott.git@gmail.com>
>>> ---
>>>   drivers/staging/rts5208/Kconfig | 10 +++++++---
>>>   1 file changed, 7 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/drivers/staging/rts5208/Kconfig b/drivers/staging/rts5208/Kconfig
>>> index b864023d3ccb..4f9cc3f00e1a 100644
>>> --- a/drivers/staging/rts5208/Kconfig
>>> +++ b/drivers/staging/rts5208/Kconfig
>>> @@ -3,7 +3,11 @@ config RTS5208
>>>       tristate "Realtek PCI-E Card Reader RTS5208/5288 support"
>>>       depends on PCI && SCSI
>>>       help
>>> -      Say Y here to include driver code to support the Realtek
>>> -      PCI-E card reader rts5208/rts5288.
>>> +      Choose Y here to enable support for the Realtek PCI-E card reader
>> Above line is indented with spaces. It should be on tab + 2 spaces.
>>
>>> +      RTS5208/5288. This driver facilitates communication between the Linux
>>> +      kernel and the Realtek PCI-E card reader.
>>>   -      If this driver is compiled as a module, it will be named rts5208.
>>> +      If you opt to compile this driver as a module, it will be named rts5208.
>>> +      Selecting N will exclude this driver from the kernel build. Choose option
>>> +      Y if your system includes the Realtek PCI-E card reader rts5208/rts5288.
>>> +      When in doubt, it is generally safe to select N.
>> That's not incorrect, but it is verbose IMO.
>> More than we usually say.
>>
>>> \ No newline at end of file
>> Please add a newline at the end of the file.
>>
>> thanks.
> In general is there an option/additional check I can run besides checkpatch.pl to catch issues with tabs, newlines, col width, etc?

Not that I know of.

-- 
#Randy

