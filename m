Return-Path: <linux-kernel+bounces-70463-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4011085983D
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 18:43:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D29641F2137D
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 17:43:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5734F376EE;
	Sun, 18 Feb 2024 17:43:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=marvin24@gmx.de header.b="lcvObuoy"
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07CBC6E2CE;
	Sun, 18 Feb 2024 17:43:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708278195; cv=none; b=pgfO4jy+1S0yQNeenKCXtbphxQnl5HV1aNORurRS4QmnwphU4t/CPzEEUObWY5RXmurX7psXM3lWV4lTnnWeOnpnqvsR/dx4uWeCPCzg0Bl4orRysOj/3HxMjT5ph3k8khkONKshLm1b8C74rwPXq3JHqHN1MxYp4Mj8K6bCx6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708278195; c=relaxed/simple;
	bh=By6PFHCR4qLQ+02lF5TMbbObXzX5xIdUDrnHtDCLiEg=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=lztLTH7aB6oBjsq5bT5SWDAtRHTLULT8j4Zh32CkMB+5A9BsHvjMT/td9aG8sWBNqz8bCJFOtYpmmY2my9sJ3TZxRmutifUduFrTCbH0wgHxHuvws/stAKVs0RX+SBONVyFiYuzXPXODk7JxWqaKgPtvrzSCYTJ8HDTJjZQpxtw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=marvin24@gmx.de header.b=lcvObuoy; arc=none smtp.client-ip=212.227.15.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
	t=1708278178; x=1708882978; i=marvin24@gmx.de;
	bh=By6PFHCR4qLQ+02lF5TMbbObXzX5xIdUDrnHtDCLiEg=;
	h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:
	 References;
	b=lcvObuoyI3o1OHcgEDjnb//K3/5cBP/z4Tb3//tqxFDEtkgB2zrk2J2LwRxZtXjU
	 blN8LyR+MOwNhKrzEpJLEDsoFUtX+JhqHNf10f/G3p1BJ2JQj+62D5O02+XSzQ7IB
	 xDEs5vBu8788KfkrJxTsIeAhy6HRr7fiMY4VQl7cJA8RyTB3+RwoMNw9SPeXYNG1G
	 nnXSiKi3iVHrt0csrySqWgmCqlp6juLsi8GFAwpkRZB6xpC9nBy+nm+BHtPQPYzeu
	 HuaVLy73W66rfV5I+FJsUwRseCr8tDEG4c2UHEPP35wD8eCLg0xg/n9ftQq/MXZ0Z
	 cJvgRV4F0GR0e8ueLw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from n5219w05.fritz.box ([109.250.32.14]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MjS5A-1rDC4O2lzu-00ktAc; Sun, 18
 Feb 2024 18:42:58 +0100
Date: Sun, 18 Feb 2024 18:42:57 +0100 (CET)
From: Marc Dietrich <marvin24@gmx.de>
To: Nam Cao <namcao@linutronix.de>
cc: "Moritz C. Weber" <mo.c.weber@gmail.com>, marvin24@gmx.de, 
    ac100@lists.launchpad.net, linux-tegra@vger.kernel.org, 
    linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Staging: nvec: nvec: fixed two usleep_range is preferred
 over udelay warnings
In-Reply-To: <20240212152110.4f8fe0e6@namcao>
Message-ID: <569e7346-1063-3ef9-8bd0-3094fe200074@gmx.de>
References: <20240212133645.1836-1-mo.c.weber@gmail.com> <20240212152110.4f8fe0e6@namcao>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
X-Provags-ID: V03:K1:wbVFjpdcLoZ9zhlFytv7KJpI/WMjyvzvEWwhUxjkitP4Cjt+Gof
 9EGcPBiZztXzu5Clz9X6jEFl9FOoFbeYNICssSekV3FdyywEMdMmPxhRRUKdLvTaY2HTRUf
 YKQnuQVrcaEW+P7cXXSM2ZxKb+vUH2eR6AcW7AuDv3ZT6UvV0Ea6wlFPQpZCTjXwTCW0Gnd
 YICz5Z3N5/0yUKT4ThEcQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:PHBZs4daLeY=;/Kbot9neqGcH+Ta8Hr5K1f7jrAU
 JSs6cxjXRJGuxuB639lcklW+Uw/mfk8Ot5j7BlOTXVwHQKl9F/a8VltVyUEOE6W6glhkV0tw+
 wr+PZh4uIXIxZv+Fwkw067Aw5c/0yw+9IgZ+gvZeoxHdsoevog89aLQq8bl1PklPPaGf98QLF
 1nW49ArhvbCd7/fIO+xArnw2BsogBYhR3Vpgv52smz4AV6wuOWDFLDuBqc1OYO/mgYgs0p0+o
 mZ/p1pAW4qWw1L3d7etlwpcBWx3p1P5W7l6NV62dG963BiVOhjjlK1gz20EW6RZsLQ9TUMhwH
 +GJJSYkQxQOixRiGeAs/GC0nTpxL6M19Yd/TmeVRJe8XAOAkDl07UdrivxZrC5VUqOrCKuyib
 xyCUiyVUdeOqH8oXJQ4Zi8fUwDqd5pfHn6PsFNafrwwbqRoUftfNQAnq6sL8O+JCxVaktiiqK
 mL8DULWYPRa2787t/BcfXMIVHkTdhov/2jNKNgYSZQhZVj2LjS+QH2u9Ch2K+ddoDO0krEysw
 ah5SwiIKzw2SYFZjL6bWqXz4hA/2XUvstklzyji21zd9FnBSpXVNVujLwaixz+yail1nzDapB
 cMoIbzvEXmjEJqyAPxtoJs3GLfM9mZ4lJUXaNB9jtRDzt6F1busQElUfOlUTRNaDMEpWPsptF
 RwZiUq4Rqq/xNofIio33tzs4OmllLJh/HIinOYK4H9jYRm3rLVbDVXisxy1WDBf5MsYbcAbdB
 JEgifm+C3tC1jyAWpwLEpQH+mWKTmID/BHfr7lEGj8Vb/9ASMuK80dWfS3WOiQaPxnS5Us791
 lpstGJmmHPamqMTV2v7jewjcnaABtEEzq0HbgmDrqGss8=
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, 12 Feb 2024, Nam Cao wrote:

> On 12/Feb/2024 Moritz C. Weber wrote:
>> Fixed a code style issue raised by checkpatch.
>> ---
>>  drivers/staging/nvec/nvec.c | 4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/staging/nvec/nvec.c b/drivers/staging/nvec/nvec.c
>> index 2823cacde..18c5471d5 100644
>> --- a/drivers/staging/nvec/nvec.c
>> +++ b/drivers/staging/nvec/nvec.c
>> @@ -627,7 +627,7 @@ static irqreturn_t nvec_interrupt(int irq, void *de=
v)
>>  		break;
>>  	case 2:		/* first byte after command */
>>  		if (status =3D=3D (I2C_SL_IRQ | RNW | RCVD)) {
>> -			udelay(33);
>> +			usleep_range(32, 33);
>>  			if (nvec->rx->data[0] !=3D 0x01) {
>>  				dev_err(nvec->dev,
>>  					"Read without prior read command\n");
>> @@ -714,7 +714,7 @@ static irqreturn_t nvec_interrupt(int irq, void *de=
v)
>>  	 * We experience less incomplete messages with this delay than withou=
t
>>  	 * it, but we don't know why. Help is appreciated.
>>  	 */
>> -	udelay(100);
>> +	usleep_range(99, 100);
>>
>>  	return IRQ_HANDLED;
>>  }
>
> I have zero knowledge about this driver, but nvec_interrupt() seems to b=
e
> a hard interrupt handler, and sleeping in an interrupt handler is a big =
no
> no. So I think this change breaks the driver.
>
> Delaying like the driver is currently doing doesn't break things, but it=
 is
> not very nice because this is interrupt handler and the processor cannot
> switch to other tasks, so delaying is wasting processor's cycles here. T=
he
> better fix would be to figure out how to remove the delay entirely, or
> switch to threaded interrupt handler and then we can use usleep_range() =
in
> there, but you need actual hardware to test such changes.

the real fix to read back the value we wrote to the controller, similar to
what is done for the tegra i2c host, which is a trival fix.
Unfortunately, this breaks the touch pad initialisation, which needs to be
fixed first. As this topic comes up every year, I'm going to post a patch
in order to updated the comment, so this kind of patches should
(hopefully) stop in the future.

Best regrards,

Marc

