Return-Path: <linux-kernel+bounces-166669-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B3B448B9DE1
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 17:55:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 43E712812D2
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 15:55:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EEAE15D5A6;
	Thu,  2 May 2024 15:54:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=finest.io header.i=parker@finest.io header.b="wTqRH8Zo"
Received: from mout.perfora.net (mout.perfora.net [74.208.4.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D69354FA1;
	Thu,  2 May 2024 15:54:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.208.4.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714665291; cv=none; b=Cy80ZlGL4GuAdMgV9AJG/HXY/7C5qniN8+md/abX/y6gITNOcsD+FbWX3NskAe6xIUImhCR2l3BeQKFluToR9QvTV5HS3tWvkvMOrNAJAiHKnturiDP6mmNj4Qhysy6NmVAXtWEiE/RQaaOqLtB02Ywr6FNpZ1tEF8UsEDGMNnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714665291; c=relaxed/simple;
	bh=w83vnfpEMyCqf/DtOPaDcN2V7HnJBekzxeWD8OcGOLM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jBWRYRn9KdO/xIZB6OzdN4t0a06OgRNYjObX4Pp8LOJ2FvoW19tJzYi3wbpNizwR7V28Z/JrffuQfxEZdalnO/kcdIz4rZfA605SPW2PyKjtNWH5TmoHaJLy07sdhDyXteg2bnSXorVb25d76jWDtRySzb7FjZhpNu2tdqLCu/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=finest.io; spf=pass smtp.mailfrom=finest.io; dkim=pass (2048-bit key) header.d=finest.io header.i=parker@finest.io header.b=wTqRH8Zo; arc=none smtp.client-ip=74.208.4.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=finest.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=finest.io
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=finest.io;
	s=s1-ionos; t=1714665281; x=1715270081; i=parker@finest.io;
	bh=w83vnfpEMyCqf/DtOPaDcN2V7HnJBekzxeWD8OcGOLM=;
	h=X-UI-Sender-Class:Date:From:To:Cc:Subject:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=wTqRH8ZoGpPh5E5Dgzlu1KPKj4SavWZjgAcH7yUi5NDr7TbMcmVA643pvIzujXrt
	 2uc7jCTxUl7MQPq+R07unBoy/+tkM4SnEer6Jdl/l8AC2eOeUYqPfPPWzxj/lOezX
	 8ZD7Q754Vpxa8pSKNKPhwcN7rK5C7c54SADhXERBNSFTPo8mgaoBw5G9l4z5/RI59
	 wsswMVrN9S5F2QMOFG84nkDHbciMLI4lHtnWBcW8DXfEGyLv4O5yRjgpno7Dktqih
	 hvNMvJsUwmyaV/+xj9/oD+yx+01xN67ykgt7akI6ro3jah2JAxww1PrFCqaW1kfN3
	 jfkfJjGPNzg4Bja5gg==
X-UI-Sender-Class: 55c96926-9e95-11ee-ae09-1f7a4046a0f6
Received: from SWDEV2.connecttech.local ([98.159.241.229]) by
 mrelay.perfora.net (mreueus003 [74.208.5.2]) with ESMTPSA (Nemesis) id
 0MbO9C-1sLK4b1qQm-00InBP; Thu, 02 May 2024 17:54:41 +0200
Date: Thu, 2 May 2024 11:54:39 -0400
From: Parker Newman <parker@finest.io>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Parker Newman <pnewman@connecttech.com>, linux-kernel@vger.kernel.org,
 linux-serial@vger.kernel.org, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>
Subject: Re: [PATCH v1 03/13] serial: 8250_exar: Kill CTI_PCI_DEVICE()
Message-ID: <20240502115439.3b104aae@SWDEV2.connecttech.local>
In-Reply-To: <ZjO0v9i0-adEM9Nq@smile.fi.intel.com>
References: <20240502144626.2716994-1-andriy.shevchenko@linux.intel.com>
	<20240502144626.2716994-4-andriy.shevchenko@linux.intel.com>
	<20240502111314.63d66b54@SWDEV2.connecttech.local>
	<ZjOxQWc1OtGWatKC@smile.fi.intel.com>
	<20240502113610.01881f3b@SWDEV2.connecttech.local>
	<ZjO0v9i0-adEM9Nq@smile.fi.intel.com>
Organization: Connect Tech Inc.
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:figyIoWM+WHWJ70XdY9ZufANO7yBRdcy3RmflpKvjyl+KDBMKLG
 brdyH1g1Ic1wE6er9WhP2yB4U0t51kdjrNxoHEl3pNg+JXRurM38uyKSM53yWwtCFf1wYvt
 9xeqtCiFgus7YhWhTN5YFq1ASMYNKf/ES0CfD8vhPxRrVkqVNM5P42DVPnoYFtQZyes310o
 iSIJIRzGvxzWNs6z8PnPA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:LxEQPiNi2qQ=;oDJRXOyey/uOHFIivj4hNC56wyt
 LQbqii3x/evcw8Syto3IfhxoJMAkEfekppjF/qoq6HnwD5kt1ZK3H27ZOqatborfUmUiR0a64
 Hb+C8OxBt+i10tVX56JQI+d8vuEX0KY2uWyNapscO1EGWfmpDYrVnsI2UAWc7MfUQ0BsPDAx6
 nwssHLPYxX5q+P+d4uWTZBQ/neHN7YDFGWqXjtGTA0icpFYSj3MUSs2QZMGYK6ST4WZ9ebxnr
 MZg2H+nj/XFMoXRcZ2Vv1vXy2DeR1djaQuCUiYcLkQVjPriH1GX5S3cp7ArAXG4Lz48dwkrN7
 4y5UIeYQnXXlOKm3Sr933BjLN35uhUAtU8b9PJDlE+PMDATeKujGq5bOR5HHwJh3qR2DMPK1z
 qw58v1aMo6k4P2POZJ01sm0zoaolZ0luqLFGBbj2ZtyeVDB++kd2gVRNL0dzLP7uA0yeQ4vqy
 1odxzA6G46Y9LFdh4gsgAOmvsnHPQM8QIpPncR1E+xHupPp+euQvT4zMcvRXNJ4xCYuZLPXXk
 rWnNS4WkyHWwetMTkpE20hw8/St0akqzBLglTgDhpaYALIIhWClW4eruEQ+awbPQCutBDxBQb
 lAU5QmuzRcJq2jW2vLSAqr+PCzG1PQ9t/TQoVYBpHhfxCfn4MwAvoU+zaA4r/K/iU25wsmT0X
 7K9MMZlVaxGbW8LrWx8VrhXeeuviZC23E+ZfZ9Ea/eqW0GjRH3unmawZsEK7VFAlIJU+qXuRb
 A5IIRcZ4HNqYSQRQ2TlZJYEgZ7eVKUX3J/k3MeEt0VSAhfX177SDqw=

On Thu, 2 May 2024 18:43:59 +0300
Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

> On Thu, May 02, 2024 at 11:36:10AM -0400, Parker Newman wrote:
> > On Thu, 2 May 2024 18:29:05 +0300
> > Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:
> > > On Thu, May 02, 2024 at 11:13:14AM -0400, Parker Newman wrote:
>
> ...
>
> > > Above I added current code of these macros, can you elaborate how it=
's incorrect?
> >
> > Sorry, you are correct. I was mixed up.
>
> No problem. And since you are here, can you tell me what type of EEPROM =
is
> connected to the chip in your case?
>

Microchip AT93C46D and various other vendors equivalent parts.
Let me know if you have any other questions.
Parker

