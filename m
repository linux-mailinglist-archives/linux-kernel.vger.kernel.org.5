Return-Path: <linux-kernel+bounces-98210-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EB8B877693
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Mar 2024 13:34:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 707381C209F9
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Mar 2024 12:34:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79E4622F1E;
	Sun, 10 Mar 2024 12:34:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ravnborg.org header.i=@ravnborg.org header.b="XrZGVqiL";
	dkim=permerror (0-bit key) header.d=ravnborg.org header.i=@ravnborg.org header.b="m3RslpyQ"
Received: from mailrelay4-1.pub.mailoutpod2-cph3.one.com (mailrelay4-1.pub.mailoutpod2-cph3.one.com [46.30.211.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6DC31CD1C
	for <linux-kernel@vger.kernel.org>; Sun, 10 Mar 2024 12:34:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.30.211.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710074077; cv=none; b=DtdA1bbIx2ChfkkoVWYOdS7OkXJKdoL7zZr8vKiZSwEndpOrrIreG2gmT3As8rA+Pz8CBN3L40XXsem0AfNZDkXPPSrHmaH3+aS4+PCIHKWBoR+G00pZGecZKU+jGvQO7sKUGelKPvMrCSTHQ1aNMRwRLVk0ny0UMthM9XHEbmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710074077; c=relaxed/simple;
	bh=eVb3cFCjq/wLYohZULzNmR4wY1wWmg+rXCBfYx/lovk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fT0duPM4C0c9JepMfMB+Zr9oK3BQaCbH9XsdpEvJ8cYZMlXkm4m7/qvatDOEQLgdd/tSUchq1uXwdRsWfQso4x7INKXoV4GSiM/qIYEP34gPeJzX/xvHHfA71Wa0+j9Jh4F5y90e1Y7R4jGbfBQjIsg0l13zBOg5kaV9aE5u5Kk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ravnborg.org; spf=none smtp.mailfrom=ravnborg.org; dkim=pass (2048-bit key) header.d=ravnborg.org header.i=@ravnborg.org header.b=XrZGVqiL; dkim=permerror (0-bit key) header.d=ravnborg.org header.i=@ravnborg.org header.b=m3RslpyQ; arc=none smtp.client-ip=46.30.211.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ravnborg.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ravnborg.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=ravnborg.org; s=rsa2;
	h=in-reply-to:content-type:mime-version:references:message-id:subject:cc:to:
	 from:date:from;
	bh=YPj7mJSOmbCaNiEGC/t0Gr13wSnOz33kScWhnHNog2A=;
	b=XrZGVqiLZ7HmxgauHv34KliKYg3bdIPWco3WbmOUS/lB8zsCC5CO+ZmGjgOxo2GjOG74rWmUTzeTD
	 b/mY6sUBDEHan3+MiNqavhep1+qPHkyBDaWl6exwf4yZnQXZflm2ZNKhjgrSRP7oI7myR7O69SGebo
	 XlYfPZUDqofK/AVeAQ8SbwF/6PyanxchTuw/gVeaNJjgYIqCt52w0/UnbwyIPRtB3Doc3R096J0hgI
	 65BFZAHEQ6DOTY5XCc3HExn3ycYD4hb6fzaL/ouKN7wTNatsDLSWPfo0LIq8G88c92fKpkXAryb068
	 idmG4syFCwOqfBYTzt3xyh947vR51BQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed;
	d=ravnborg.org; s=ed2;
	h=in-reply-to:content-type:mime-version:references:message-id:subject:cc:to:
	 from:date:from;
	bh=YPj7mJSOmbCaNiEGC/t0Gr13wSnOz33kScWhnHNog2A=;
	b=m3RslpyQ6rat08/y9fWoWhKLFFXulH2lxA/XDZXt362zndzEJbzwHFpTAVufQTF1BKRUZp5V6l5Ws
	 lWldjHQAQ==
X-HalOne-ID: 84422ca7-deda-11ee-9cef-31e85a7fa845
Received: from ravnborg.org (2-105-2-98-cable.dk.customer.tdc.net [2.105.2.98])
	by mailrelay4.pub.mailoutpod2-cph3.one.com (Halon) with ESMTPSA
	id 84422ca7-deda-11ee-9cef-31e85a7fa845;
	Sun, 10 Mar 2024 12:34:22 +0000 (UTC)
Date: Sun, 10 Mar 2024 13:34:20 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: kernel test robot <lkp@intel.com>
Cc: Sam Ravnborg via B4 Relay <devnull+sam.ravnborg.org@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Arnd Bergmann <arnd@kernel.org>,
	Andreas Larsson <andreas@gaisler.com>,
	oe-kbuild-all@lists.linux.dev, netdev@vger.kernel.org,
	Helge Deller <deller@gmx.de>, Randy Dunlap <rdunlap@infradead.org>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
	Kjetil Oftedal <oftedal@gmail.com>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Alan Stern <stern@rowland.harvard.edu>,
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
	sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-usb@vger.kernel.org, linux-fbdev@vger.kernel.org,
	dri-devel@lists.freedesktop.org, linux-sound@vger.kernel.org
Subject: Re: [PATCH v2 14/28] sparc32: Drop unused mmu models
Message-ID: <20240310123420.GA989676@ravnborg.org>
References: <20240309-sunset-v2-14-f09912574d2c@ravnborg.org>
 <202403101854.Z94SAU13-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202403101854.Z94SAU13-lkp@intel.com>

Hi kernel test robot et al.

On Sun, Mar 10, 2024 at 06:37:53PM +0800, kernel test robot wrote:
> Hi Sam,
> 
> kernel test robot noticed the following build warnings:
> 
> [auto build test WARNING on 84b76d05828a1909e20d0f66553b876b801f98c8]
> 
> url:    https://github.com/intel-lab-lkp/linux/commits/Sam-Ravnborg-via-B4-Relay/sparc32-Update-defconfig-to-LEON-SMP/20240310-021717
> base:   84b76d05828a1909e20d0f66553b876b801f98c8
> patch link:    https://lore.kernel.org/r/20240309-sunset-v2-14-f09912574d2c%40ravnborg.org
> patch subject: [PATCH v2 14/28] sparc32: Drop unused mmu models
> config: sparc-randconfig-r113-20240310 (https://download.01.org/0day-ci/archive/20240310/202403101854.Z94SAU13-lkp@intel.com/config)
> compiler: sparc-linux-gcc (GCC) 13.2.0
> reproduce: (https://download.01.org/0day-ci/archive/20240310/202403101854.Z94SAU13-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202403101854.Z94SAU13-lkp@intel.com/
> 
> sparse warnings: (new ones prefixed by >>)
> >> arch/sparc/mm/srmmu.c:49:5: sparse: sparse: symbol 'vac_line_size' was not declared. Should it be static?
> 
> vim +/vac_line_size +49 arch/sparc/mm/srmmu.c
> 
> accf032cfa582e Sam Ravnborg   2012-05-19  46  
> ^1da177e4c3f41 Linus Torvalds 2005-04-16  47  int vac_cache_size;
> 9d262d95114cf2 Guenter Roeck  2017-04-01  48  EXPORT_SYMBOL(vac_cache_size);
> ^1da177e4c3f41 Linus Torvalds 2005-04-16 @49  int vac_line_size;
> ^1da177e4c3f41 Linus Torvalds 2005-04-16  50  

vac_line_size is no longer used and can be deleted.
vac_cache_size is never written to and can be deleted too.

vac_cache_size is used in shmparam_32.h like this:
#define SHMLBA (vac_cache_size ? vac_cache_size : PAGE_SIZE)

The same file has:
#define __ARCH_FORCE_SHMLBA	1

If I understand it right then when SHMLBA equals PAGE_SIZE then there is
no need to define __ARCH_FORCE_SHMLBA and sparc32 can use the asm-generic
variant of shmparam.h

I will do this change in v3.

	Sam

