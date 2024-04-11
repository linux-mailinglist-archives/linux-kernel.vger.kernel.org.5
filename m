Return-Path: <linux-kernel+bounces-139972-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E9ADA8A09D5
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 09:32:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A43A028566B
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 07:32:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5392913E054;
	Thu, 11 Apr 2024 07:32:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b="M2lOxx7X"
Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8B0913E04A;
	Thu, 11 Apr 2024 07:32:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.133.4.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712820741; cv=none; b=FdQ6mS3QnqC8suk+cGYcL+hRJ9ZsxN9pKE5VzfsZ9BKUVSEPfNAXvnf/3mhk3kpdA8Sh1uaYsaJ/FVBFD0R0hmopetekIDegbwIDCP+bwKmYaIpNBzGxTehEazJLt3pjOShW2CnqQ3HeO9Ac/B0j1wlP7t/vndfA7OWIFXyFPO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712820741; c=relaxed/simple;
	bh=o9XNePphrFGLADbN374hkRmD+LG18cKySdDPj/hyjWA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Wr3IPut8i9YaO38Zz2967ckpGob73xOFEcNFWG10fSoAjApcckHOlBNVL8tc8CF0LVvVPGZ8vphHvyw3vzAxln5JW5bMOFUg9czCF/eLrsoxnzqqIzcQ57A4DRivuAZMyuGhTjj7fECjkjHdThgmpc95wRjk6yqWtm9hClmWuXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de; spf=pass smtp.mailfrom=zedat.fu-berlin.de; dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b=M2lOxx7X; arc=none smtp.client-ip=130.133.4.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zedat.fu-berlin.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=fu-berlin.de; s=fub01; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=QPDpZoE/tjUUBV8p6vi4T9AN0aehyjX15I4+zRojGDo=; t=1712820737; x=1713425537; 
	b=M2lOxx7XCAryXeWFDXXIQvdJ4W+/7Qx8wrQ81e+OOifF9rD6ep9dmWsKh7NW3IIusFjmEQlTglW
	wPZZDjfqZFsve0tYHSbOG1D2Lo2UWz25uuHXAvjNH9r20v3JJy4G4mbzBFqePUWkcBQSY7otOJZhB
	S3kAvCDPxgJUxkH1WOeCM2/oCexAm/bUA+a8YJIF2FUAE4Djbp3JojyFIWbY5Hajdi4LhI361xaEy
	r1aNywcwYy4K+2i/w56PGm3rsEVdgavxY2S1lirY/5IfgyzaLSi8GZN/CZuwxe5fLSYFtICLZHoPH
	sclBtU+IMKk2ZqdGvtS0wYmSv9TRIQADr2LA==;
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.97)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1ruout-00000002zUf-32Mw; Thu, 11 Apr 2024 09:32:15 +0200
Received: from p5b13a9fd.dip0.t-ipconnect.de ([91.19.169.253] helo=[192.168.178.20])
          by inpost2.zedat.fu-berlin.de (Exim 4.97)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1ruout-00000002XFi-27xs; Thu, 11 Apr 2024 09:32:15 +0200
Message-ID: <404299f95cf50003eeee5d6598bd484117fe5378.camel@physik.fu-berlin.de>
Subject: Re: [PATCH] fbdev/sh7760fb: allow modular build
From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To: Helge Deller <deller@gmx.de>, Randy Dunlap <rdunlap@infradead.org>, 
	linux-kernel@vger.kernel.org
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, Thomas Zimmermann
 <tzimmermann@suse.de>, Javier Martinez Canillas <javierm@redhat.com>, Sam
 Ravnborg <sam@ravnborg.org>, linux-fbdev@vger.kernel.org,
 dri-devel@lists.freedesktop.org
Date: Thu, 11 Apr 2024 09:32:14 +0200
In-Reply-To: <5191337e-9ffc-44b7-9700-eb5f1f2fc4cc@gmx.de>
References: <20240210053938.30558-1-rdunlap@infradead.org>
	 <4d01127a9130ce46b7c1d447811c89c1d1503199.camel@physik.fu-berlin.de>
	 <c5436115-0b26-4369-8d71-154cc3c95659@infradead.org>
	 <5191337e-9ffc-44b7-9700-eb5f1f2fc4cc@gmx.de>
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

On Wed, 2024-04-10 at 15:17 +0200, Helge Deller wrote:
> On 4/10/24 06:54, Randy Dunlap wrote:
> > Hi,
> >=20
> > Will someone be merging this patch?
>=20
> I've just added it to the fbdev git tree.

Ah, good. Then I can drop it from my queue again.

Adrian

--=20
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer
`. `'   Physicist
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913

