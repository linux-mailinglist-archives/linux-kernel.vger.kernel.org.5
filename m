Return-Path: <linux-kernel+bounces-139968-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E3AF28A09C2
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 09:28:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9E29228289B
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 07:28:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B13313E037;
	Thu, 11 Apr 2024 07:28:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b="B3ITGZlg"
Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDD9813E033;
	Thu, 11 Apr 2024 07:28:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.133.4.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712820517; cv=none; b=lWv377owswPglmy55TbOWDx6W4Dj6ngnwus5oFsrkDsj8S4NLmheg5aPRGUyce9o+AW4oUHbSq1COEr4MO3qNwfp734aAuPD3Hx6VYiUeuSu0MF5SXV2NF0mqIut5GjaCuBg+teM0HWM8OBquF/xgZYEQW+jjkW26xxZTBHC6Uc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712820517; c=relaxed/simple;
	bh=Z84DwWbXl1JVUJ8ZxW/iocfC4nvd/IpKiq8ZDurc9mE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=YwBUc4FkpzrGyFaq4TktursIxlCJCNDdbdgaQHHCR/1to/66iSx9RshYAUujzjw9W6e/629kv+Wq25Ntck4zWePN0+3AkeuvLA/RA9MezqU3ZjlxAwhR208Ltw/LUw8HqDVuCGet0ypM+S3FHT44xvoO6pMmhXPbiGjKgYXTpEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de; spf=pass smtp.mailfrom=zedat.fu-berlin.de; dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b=B3ITGZlg; arc=none smtp.client-ip=130.133.4.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zedat.fu-berlin.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=fu-berlin.de; s=fub01; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=5+5LnM92E8OZOOReOchcrKgt2m7AJcZQIcLHyomng0U=; t=1712820513; x=1713425313; 
	b=B3ITGZlg9r6gTAwCOj7VXoURWMMLnD8ngTj7L9kIey9WPZQW/6cWo2Ye27q5OwBy7JV5y7VZxoB
	k+rmDALua44ymOZUIrwWxGNnGhaFxZbBpKF+dizWVqCDQiWZDyi6yi7eKcT37CipP8RlXtKnsN0Jg
	1s8SvohFcEQ6AXexgK7LZCYO97gTBEkuhmUoUu32cClXPM3NC89a34kWBHO9Xru19WrxxJsQYol8n
	fKFEBK6Opg/89hoixE1GUe9icsH3arYQ6tw0opqVLzCA7kdryF12kKcW4XtzjoDJQsKbw3Pni+Hfb
	Oxeg2cqXdNU5OlmkFyRckKTuuHTyIiYVzeBg==;
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.97)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1ruorB-00000002xuo-00YI; Thu, 11 Apr 2024 09:28:25 +0200
Received: from p5b13a9fd.dip0.t-ipconnect.de ([91.19.169.253] helo=[192.168.178.20])
          by inpost2.zedat.fu-berlin.de (Exim 4.97)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1ruorA-00000002WWD-2R6L; Thu, 11 Apr 2024 09:28:24 +0200
Message-ID: <1a1704ce20b4749206df34dc04099154bf900501.camel@physik.fu-berlin.de>
Subject: Re: [PATCH] fbdev/sh7760fb: allow modular build
From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To: Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, Thomas Zimmermann
 <tzimmermann@suse.de>, Javier Martinez Canillas <javierm@redhat.com>, Sam
 Ravnborg <sam@ravnborg.org>, Helge Deller <deller@gmx.de>,
 linux-fbdev@vger.kernel.org,  dri-devel@lists.freedesktop.org
Date: Thu, 11 Apr 2024 09:28:23 +0200
In-Reply-To: <c5436115-0b26-4369-8d71-154cc3c95659@infradead.org>
References: <20240210053938.30558-1-rdunlap@infradead.org>
	 <4d01127a9130ce46b7c1d447811c89c1d1503199.camel@physik.fu-berlin.de>
	 <c5436115-0b26-4369-8d71-154cc3c95659@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.0 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Original-Sender: glaubitz@physik.fu-berlin.de
X-ZEDAT-Hint: PO

Hi Randy,

On Tue, 2024-04-09 at 21:54 -0700, Randy Dunlap wrote:
> Will someone be merging this patch?

Shall I pick it up through my tree?

Adrian

--=20
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer
`. `'   Physicist
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913

