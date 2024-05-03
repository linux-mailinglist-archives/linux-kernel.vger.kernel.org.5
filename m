Return-Path: <linux-kernel+bounces-167912-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 138708BB0F9
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 18:36:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3FAC0B20C64
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 16:36:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2FBC1553A9;
	Fri,  3 May 2024 16:35:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="mRmu+22o"
Received: from mout.web.de (mout.web.de [212.227.17.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E7CD1CD13;
	Fri,  3 May 2024 16:35:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714754156; cv=none; b=i3ocWtnAKep8xKy7ebaEI8kbfr0s5698KMTZeeNAZCb5rP7XtJ0z9OIneHWtMDdbAxE0StwmH9ixCQ/uxZO+JUBQXQQ5/NvjlwpurNeoTT1Iu+P53GmYk+cMwcusjfQm2tLtXLe59brxP3bXb/yMqq1gN6zRwF5Xg36r0SbRTX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714754156; c=relaxed/simple;
	bh=n/9hFbF2+WfiltNRFRaTIEsLys/9NeHlNk4TTNWPjak=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=c+JR0ddiKupOGwfucdDgRSXRK/sq17tJ4owQNNfaHmvZouaTtB0eUhQrugJFo5Wtueqx1j+RguDHR8WazQSeNXfB6CqY+yNSNPc7PHrsIQTzqxm57TFWwlqS5SerRXKSpRG3pNxwBCRxYungXo793l1iAwPtAD3Wm7iHSD5WLYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=mRmu+22o; arc=none smtp.client-ip=212.227.17.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1714754150; x=1715358950; i=markus.elfring@web.de;
	bh=qI/wYC/RyotTKQTORqzcTsleWbiY2bQQMWYFl52q9fg=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=mRmu+22oI2IxkJ3K3kyXSwinr4iSATeihekuX9WevI8XHo3NwEcDE++Qsz17gNhu
	 sXO7TWcmScQcJ/eb/dMVmFzkwn+VhdjkE+HbuAEk2J2v+a+0Ff8IOc+3vI9lkg1/y
	 v5di9nQgH9jC7AZ18vbMTjJnadwY4gPfeD42QZWbf5PzWypSrAd2KFx/+X7nMw6ob
	 /HLvRFMoDvtFZMc+JwiXG/GZZxmae4C6FI8BF8tcC7Gsagwqe8XmvAO40pWrDRGm4
	 IjhA1P3JbMbmszAMnVFMw9uMqn7sBNHjiiVVCVl7F74MOKwSJfDqPfTCMGHZNS8vx
	 jJJf1H7qjEQMDxSY4A==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.83.95]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MkVsa-1sVAPu28Ew-00kLVd; Fri, 03
 May 2024 18:30:16 +0200
Message-ID: <f616ab40-68a1-4f80-9bb9-c80214d087c5@web.de>
Date: Fri, 3 May 2024 18:30:12 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Jim Liu <JJLIU0@nuvoton.com>, openbmc@lists.ozlabs.org,
 linux-gpio@vger.kernel.org, kernel-janitors@vger.kernel.org,
 Bartosz Golaszewski <brgl@bgdev.pl>, Dan Carpenter
 <dan.carpenter@linaro.org>, Linus Walleij <linus.walleij@linaro.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Jim Liu <jim.t90615@gmail.com>,
 KWLIU@nuvoton.com
References: <20240429070523.3160248-1-JJLIU0@nuvoton.com>
Subject: Re: [PATCH v3] gpio: nuvoton: Fix sgpio irq handle error
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20240429070523.3160248-1-JJLIU0@nuvoton.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:QfKikTXkYDmDVNk692GaHnGmUB3CSL6kLdR/8/PnieOW7UxBWoN
 47KNl2ajuHpuJLCtpbBBDwt7Lr3lrpaZbDP1tn1T0OT59g9x0L4UG6Fy+CnvWiN4SsRbqUD
 7Sw+m7P8kK3KEJ9kXF0ku85VB61tTE7pO3f61+vu9KTacvPF0b1V7mx7KXpI1KdwetuI4mb
 7b9hmyaOHSogHJ9D3zDOA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:x+oB7poDoL4=;Fp4/4SF+NcCiCPwDW32AjIruY/b
 HvF7r2yPgZ9jp8si72j5ehHd6Ll5Zvz4n4NsB77OhMpyW2YDDcWr3rTSqRcDh5in99rTTOEPp
 cOSUFS5ZO06XvapCJ8pXURmp9C0VTBAfEM4jEpSn387i+1Ty0cHPM0UhStY8uOqzE0im7wdl9
 a8EC//6WkzFOU2ODnlVzSZfsFfqx5FibtN5h1GXdVfY68GpqW5eUF4cxnYJxd05uLmB6AxrR8
 t+VZPf8FAs45D3USO26MNlgSLDqEKID4kLgdje5tygwRbc5wMzi4rsb00EwahhUwGNl9kLCkD
 40xv5N7fPLdg3m/g8DVWzWbn9TrdE6/Z2oogwca49SQo+we2to/YwHo6X8hsRf2Jy+gw3kgGf
 8oi8SMA/9jqzLeR6tUTde93sy/Zf0BXN9Q4m6E4M8lQRQfD4Twb8LoWptEBm/VABHzDjHDxrh
 GGzVB1TvOZh7BfW0DeP2i+gzpAbTV4fYvnr2216ga4K128p5FSMoB7GkwD9GiPQT+2V4IXCCi
 GQUgXklxFm+FRbaosCRW0+iJ+HPXhLnYGEM0BD+rhIEyvzMcUJt6RK+9GAUvI4OG7L3+VJaH5
 S+lnBaYkSQRmy/sJDfBWJ7zRSO9QjLDmD7grFm5Lu9+os+Vo9vEwIZR9juCLOx7VNh2As9yxQ
 g206lN9uw69rjbY0dkmo6L5s0faPrLsReiDjk1jCuOoNchDUtNUdVb9h3kBvbznR2WteutOZc
 0XlsKbXGwbufBkG40g/Oqeb78G4AnKiduGw1sNzwK4VhWH8WY+AuhBdA8luG6dG4xP3VEZdB/
 QybCV6ZG5BEOHvYOVDsRusUZzhref2nv0YbIYyYfXzGyZ89GoH2NWV4wmByxZvEo3g

> The generic_handle_domain_irq() function calls irq_resolve_mapping()
> so calling irq_find_mapping() is duplicative and will lead to a stack
> trace and an RCU stall.

Can a wording approach (like the following) be a bit nicer?

   The generic_handle_domain_irq() function calls irq_resolve_mapping().
   Thus delete a duplicative irq_find_mapping() call
   so that a stack trace and an RCU stall will be avoided.


Regards,
Markus

