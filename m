Return-Path: <linux-kernel+bounces-109841-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E8BCE88565D
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 10:23:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9EF1E1F21DE4
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 09:23:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D141E45958;
	Thu, 21 Mar 2024 09:22:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="PHMDHZm7"
Received: from mout.web.de (mout.web.de [212.227.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1E7F1CAA7;
	Thu, 21 Mar 2024 09:22:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711012977; cv=none; b=MvKVGTlSkNgCIwPnsBQsUg0iSJv2fzWggv35Y56WdwYEz7sOv5G5zQNuVN9oAcaDxiY0K1XYX+b2TFBc0HidsCLgc+NoQ16fzvvyi6LF8uUStPLCdyfwD19t8Q3XC8XeX21p28opn3pwZWfU0yWiuk6NE+on35fpJCUDP50fn8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711012977; c=relaxed/simple;
	bh=4p8wMshJ+yFtLneYfyNPTV/9zomFZv8Ksa7T6N1ajNA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VVUQigjv229zRdQBtI8pGGT9CtUgjG/k5wfHeadfWUYLtcqKTKQO5saOtOqOreCdaqGZQLvgiiSYIQ1tutOGv0gNXh/sFHcUTppBPoD54UMdNrjEamUJMVbwiGCar077bBL9MXUAMZZ/WTqrYn5Q/qYLhV8crCXLJirXangY2mM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=PHMDHZm7; arc=none smtp.client-ip=212.227.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1711012937; x=1711617737; i=markus.elfring@web.de;
	bh=ZDWpGRxuuXgMIGkCgrRV72gdMtBdi3nUH8g5ZUwjpqQ=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
	 In-Reply-To;
	b=PHMDHZm7S927K7Qa8DQ+uCFScscGlaUIHhr/7xkui+QCQ81H5pPwUFUCfs+vaNMB
	 MsiXT8C+FwHPhDw93c0YRfFMmUOxKJwFL3lZjwwt1LWgfFA85b0kXYv47ebKidABi
	 09i7WHKy1ZDLG4yVelJTeJIL6YFj+46fOsG6bz9ug8Ahut3/uNSJa16OwISPN16tL
	 YhL9T8rrDGwLr7j4D1BsnX601ZgmWQ9zM3YXAdVJW4w23pComl58rqsVThDnQmRAf
	 EXptKin8Pt/RXzyxngklTYMTiWpbVuFOR4NX5E8Il1e2bv2RlHcWfHLti+Ji5SPVe
	 Be9sdM4MzRMlVLtjKA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.90.95]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1Mdf8F-1rDctM2YfR-00ZLW4; Thu, 21
 Mar 2024 10:22:17 +0100
Message-ID: <ec90ffc0-fb26-462a-b470-4368c2f7dc68@web.de>
Date: Thu, 21 Mar 2024 10:22:00 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ata: ahci_ceva: return of_property_read_u8_array() error
 code
To: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>,
 linux-ide@vger.kernel.org, kernel-janitors@vger.kernel.org, git@amd.com,
 Damien Le Moal <dlemoal@kernel.org>, Niklas Cassel <cassel@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Jens Axboe <axboe@kernel.dk>,
 Michal Simek <michal.simek@amd.com>, Peter Zijlstra <peterz@infradead.org>,
 Philipp Zabel <p.zabel@pengutronix.de>
References: <1710960665-1391654-1-git-send-email-radhey.shyam.pandey@amd.com>
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <1710960665-1391654-1-git-send-email-radhey.shyam.pandey@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:pipZzMvsbhfDIdkh+8UmrM+TkbMt+xc7WylFo0K8wbWJaR2rcO3
 ItPimyGFYS8dSqvywXTZ5nqYeL/ljIeKw6XnMPVxy7BIYWk5drYBgH7i7Rt/pelhRHd2ggm
 s4HrQYY+0kvUBAljekmxlm0XDhbcund9qPj+rMyZ/46gO2OTm3Xm1ftqJxp27C+IFTCadKl
 Vpqb75X+Zbjvhz7FAkRaA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:Ufm26KgmjH8=;9RXnCeCBa9ORaL9WpPo4oCLJqyG
 goRIVR7XQ64Lnmm47XjtB+FxGM5DWwVq7gveB50DEkMgB3iBunD2K2JFwOYEm/KoSnoKhKmSz
 S7Hj2Ob2Gu2/zIltClPmgVcbEGiLA6I4gGGIoDwl6yQnllKirXjm0bAmFyymEwFvB5QEyED9t
 1iKj9BiVEJiq6KiaM/kfsK/DILIEl/73bjSFLTLckavN8go+ogUu7oprF3wSKAeWbYrqeB9nZ
 d5/ags1rH4uPYd7wrIBRtfzF5shFTUBoKOBlBdzf1VlHM9Tw/uZ9zq7pKkMyarPQdXxIkDSoo
 r0yyQXkglSrJNSKaRrwi+eozHN59oR09j6F9ft/qixY1Dh/Uh653H+Vyy1TdX+W2UrUh4XXz0
 iMu8/FTQmMsRQwUZmQRMoVQYmMzoMZBqqwYPZL8QUMJjITkZN45DgDpKdZp2Gp+jgTw3ikfOT
 RAeqpyQLEBqIS1NFVwfS5+T4e+SlAHq5Om3y/nC4Df4Uo5HUK9C4YWugMIHRMqUypZb0mSk3t
 XocnSGIFqZekbYRVlKy52RK5vhPpcbx8RAhkxTa0H0pQN4Onn1MTqK6sOA/HIzw6suZ5bkIBF
 cleFVFp/tR29gZ3Ve3B0QW9x9Z2zPMf48ncdp7UU6B42qCfkpGKlfOKrm0oUNb8dSXRrlgRWP
 yURRryRPbQaw4+g2j4RASgRG0BpGFaiZxTb6bDpuQW2untnLZGvbITj/qK0aOdI1i8OF1ujVx
 hBUmXjm1guVOYUPICBClmia3jXsViiXeNmnpDZmkUkpVzsf0gSJ+ae7gQOPtlmqFhhrPll97Y
 TZWhXHVuL+AYAE4sFu112kUP5sRnq6tLx8QSsQXWrzZeQ=

> In the ahci_ceva_probe() error path instead of returning -EINVAL for all
> of_property_read_u8_array() failure types return the actual error code.
> It removes the redundant -EINVAL assignment at multiple places and
> improves the error handling path.

A) Would a change description be more desirable with a corresponding imper=
ative wording?

   See also:
   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree=
/Documentation/process/submitting-patches.rst?h=3Dv6.8#n94


B) Can it be helpful to specify the hint =E2=80=9Cin ceva_ahci_probe()=E2=
=80=9D at the end
   of the patch subject?


C) How do you think about to extend the application of scope-based resourc=
e management here?

   See also:
   Article by Jonathan Corbet
   2023-06-15
   https://lwn.net/Articles/934679/


Regards,
Markus

