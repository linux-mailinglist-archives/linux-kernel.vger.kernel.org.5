Return-Path: <linux-kernel+bounces-98422-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E2A908779DD
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 03:37:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8EFCC281766
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 02:37:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA9C91FC8;
	Mon, 11 Mar 2024 02:37:36 +0000 (UTC)
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61C491841;
	Mon, 11 Mar 2024 02:37:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710124656; cv=none; b=AgWy/Y6ryxstFtLX4bwUFpQl4PZ8rLBI2QJex0IpOQKtUF0mfOky8dFVYpdhIy5FW6JpOCMfZcPC2UrBnUDO49nxsUr9YYQjXYlxixVye1Aioi5j/pTLmb5OttfEep6EPd1rzP++qKmy1ZaRgFtQkMADgDZ5ydTfcBKGOk6ylrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710124656; c=relaxed/simple;
	bh=KkWPgs33qgoq499jSSM0dfHvg5p8RlHA+Lh4J5L3mKo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cJUI9zs+C9xpyjSTTEe8HyyZTc1lguZ9uQ9DHRerkNoabkQHVGHoC/0db5UsesbgHX0lTvpr+AxrBHV7JhXTbGHQTHaKudUoYhaNJWtmgI5I5QfE74y41W18NPVSSO2GXEYu9OWzzYmJPekLka4fCv+8Oj08VX7Or0aCpPcgymU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.96.2)
	(envelope-from <daniel@makrotopia.org>)
	id 1rjVXJ-0005rO-36;
	Mon, 11 Mar 2024 02:37:10 +0000
Date: Mon, 11 Mar 2024 02:37:07 +0000
From: Daniel Golle <daniel@makrotopia.org>
To: Richard Weinberger <richard@nod.at>
Cc: Miquel Raynal <miquel.raynal@bootlin.com>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-mtd <linux-mtd@lists.infradead.org>,
	devicetree <devicetree@vger.kernel.org>,
	linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v7 7/7] mtd: ubi: provide NVMEM layer over UBI volumes
Message-ID: <Ze5uUyUuEDBM3p43@makrotopia.org>
References: <cover.1702952891.git.daniel@makrotopia.org>
 <82ceb13954f7e701bf47c112333e7b15a57fc360.1702952891.git.daniel@makrotopia.org>
 <20240219120156.383a1427@xps-13>
 <1209094181.98490.1708899174329.JavaMail.zimbra@nod.at>
 <ZdvV1KABu_UCSL7B@makrotopia.org>
 <1754825522.38834.1710105437883.JavaMail.zimbra@nod.at>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1754825522.38834.1710105437883.JavaMail.zimbra@nod.at>

Hi Richard,

On Sun, Mar 10, 2024 at 10:17:17PM +0100, Richard Weinberger wrote:
> Daniel,
> 
> ----- Ursprüngliche Mail -----
> > Von: "Daniel Golle" <daniel@makrotopia.org>
> >> Finally(!), I had enough time to look.
> >> Thanks for addressing all my comments form the previous series.
> >> Patches applied.
> > 
> > It's an enourmous coicident that you are writing just now that I found
> > a sizeof(int)-related problem which triggers a compiler warning when
> > building the UBI NVMEM provider on 32-bit platforms. I was just about
> > to prepare an updated series. Literally in this minute.
> > Should I still send the whole updates series or only the final patch
> > (as the necessary change is there) or a follow-up patch fixing the
> > original patch?
> 
> I have just merged your fixup patch. So all good.

Thank you!

> 
> >> 
> >> I have only one tiny request, can you share the lockdep spalt
> >> you encountered in ubi_notify_add() regarding mtd_table_mutex
> >> and ubi_devices_mutex? The solutions looks okay to me, but
> >> if you have more details that would be great.
> > 
> > I will setup a test build to reproduce the original warning and
> > let you know shortly.
> 
> Any news on that?

I've tried for days now to reproduce this on recent kernels and fail
to do so. Ie. when using regular mutex_lock() instead of
mutex_lock_nested() I no longer see any lockdep warning with
linux-next. It could be that I'm chasing a lockdep ghost...

> BTW: Is there a nice way to test this with nandsim in qemu?
> I'd love being able to test all ubi attach code paths on my test setup.

From what I can tell 'nandsim' doesn't have a way to be defined in
Device Tree, making it unsuitable to test the attachment of UBI in
this way.

However, QEMU does support emulating TI OMAP's OneNAND controller, eg.
as part of the Nokia N810 hardware supported by qemu-system-arm, see

https://www.qemu.org/docs/master/system/arm/nseries.html

So we could use that and modify the device tree in Linux to have a MTD
partition for UBI and 'compatible = "linux,ubi";' set therein:

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/arch/arm/boot/dts/ti/omap/omap2420-n8x0-common.dtsi#n84

If you like I can prepare such a test setup.

Is there a repository for MTD/UBI tests to be run on QEMU which I should
contribute this to?


Cheers


Daniel

