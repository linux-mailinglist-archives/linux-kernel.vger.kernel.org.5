Return-Path: <linux-kernel+bounces-162251-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D641E8B58A4
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 14:34:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 65FEB286222
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 12:34:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 205D810953;
	Mon, 29 Apr 2024 12:33:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="Y01eOQ+h";
	dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="Y01eOQ+h"
Received: from bedivere.hansenpartnership.com (bedivere.hansenpartnership.com [96.44.175.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 856275256;
	Mon, 29 Apr 2024 12:33:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=96.44.175.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714394027; cv=none; b=UAx8P6w+37Q0Mn62r1y4lds/2HwqqKqzQXMEbwvU45VD+JdH9HafTPcNldsh6gV2YhTtd/CAF+T5nmn+exg6WunBy6CwuM4OzVjrI5jbhtfrxOTWHq4mkvvr5JEian2vRgxrQscs3tM6d9BKLuRJnU5JCswezYG/Yky5qwdFbEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714394027; c=relaxed/simple;
	bh=ATeiuJG5nkTDI9WyGAWI5y5va3vPkJ4pxa/arMtw9Q8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Bq3GmCUaLiRqY8g7WEvgXBgLZB4aRn9ndqLhJ/ac23pF2jJldXTpZeBXMNfV+oq+NQZxlzZT8rT5IdZsL7ibYBIhP/I0NpujtwVvmZiQpwvDYL/e3J0FH2cmErHBgFPq38wqlqP0jsE2P9amDncD0R8FXPyRi1IpZAwHwSUAOnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=HansenPartnership.com; spf=pass smtp.mailfrom=HansenPartnership.com; dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b=Y01eOQ+h; dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b=Y01eOQ+h; arc=none smtp.client-ip=96.44.175.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=HansenPartnership.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=HansenPartnership.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=hansenpartnership.com; s=20151216; t=1714394024;
	bh=ATeiuJG5nkTDI9WyGAWI5y5va3vPkJ4pxa/arMtw9Q8=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
	b=Y01eOQ+hiXtV4tCjKbqdz6QDMwQbR/8M+4FlKDY4NvX5temk9JB2OLA1wzGDwyoD0
	 G4mmI22zhuK872Cu+gwYCxAEb1Z0I6GsKzjvZUv7truf83d7BgmRT7O7VWgRqY2qpc
	 e3kjvBwd2u8VushW/KJ4B5V+aLnxTcVrIxTs3Y+k=
Received: from localhost (localhost [127.0.0.1])
	by bedivere.hansenpartnership.com (Postfix) with ESMTP id B590D1287059;
	Mon, 29 Apr 2024 08:33:44 -0400 (EDT)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
 by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavis, port 10024)
 with ESMTP id ykbLNJe_6-7M; Mon, 29 Apr 2024 08:33:44 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=hansenpartnership.com; s=20151216; t=1714394024;
	bh=ATeiuJG5nkTDI9WyGAWI5y5va3vPkJ4pxa/arMtw9Q8=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
	b=Y01eOQ+hiXtV4tCjKbqdz6QDMwQbR/8M+4FlKDY4NvX5temk9JB2OLA1wzGDwyoD0
	 G4mmI22zhuK872Cu+gwYCxAEb1Z0I6GsKzjvZUv7truf83d7BgmRT7O7VWgRqY2qpc
	 e3kjvBwd2u8VushW/KJ4B5V+aLnxTcVrIxTs3Y+k=
Received: from [IPv6:2601:5c4:4302:c21::a774] (unknown [IPv6:2601:5c4:4302:c21::a774])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 13CE9128700E;
	Mon, 29 Apr 2024 08:33:43 -0400 (EDT)
Message-ID: <36c350dd23e4798c705154dcd56bf4e370779977.camel@HansenPartnership.com>
Subject: Re: Problem and solution about SCSI configs
From: James Bottomley <James.Bottomley@HansenPartnership.com>
To: Tiezhu Yang <yangtiezhu@loongson.cn>, martin.petersen@oracle.com
Cc: linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Mon, 29 Apr 2024 08:33:42 -0400
In-Reply-To: <ce58178c-7f26-a9a1-443a-71577162c814@loongson.cn>
References: <ce58178c-7f26-a9a1-443a-71577162c814@loongson.cn>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Mon, 2024-04-29 at 17:29 +0800, Tiezhu Yang wrote:
[...]
> Could you please let me know are you OK with the following change?
> 
> -- >8 --
> diff --git a/drivers/scsi/Kconfig b/drivers/scsi/Kconfig
> index 634f2f501c6c..3e59e3e59e79 100644
> --- a/drivers/scsi/Kconfig
> +++ b/drivers/scsi/Kconfig
> @@ -25,6 +25,7 @@ config SCSI
>          select SG_POOL
>          select SCSI_COMMON
>          select BLK_DEV_BSG_COMMON if BLK_DEV_BSG
> +       select BLK_DEV_SD if SCSI=y
>          help
>            If you want to use a SCSI hard disk, SCSI tape drive, SCSI
> CD-ROM or
>            any other SCSI device under Linux, say Y and make sure
> that 
> you know
> 
> If yes, I will post a formal patch later.

No: this is a distro config problem not a kernel one.  If the distro
doesn't boot with an initrd then every module used by the boot
(including all the SCSI drivers) must be built in and the distro kernel
builder must ensure that.

James


