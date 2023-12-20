Return-Path: <linux-kernel+bounces-7523-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B36CB81A943
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 23:41:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6F8C4281473
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 22:41:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 707F44A9B2;
	Wed, 20 Dec 2023 22:41:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="eTagRBiK"
X-Original-To: linux-kernel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 921B21E527;
	Wed, 20 Dec 2023 22:41:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=/RajmtD0X7/0mTwIrcPHmeX+DW181fJFVhZhihu0AOk=; b=eTagRBiKvDTDsQgmpKIKPFxULD
	TrzcsNIRkhtwLSKLie9SEU4Opld++XqQTUjDmHOAtG4Sr6oLNUtQsDpjHXaLniYNYR4r0URTj9Xdz
	8hA0Ndzu1cOw15Qvw3s0Ah9tPQVenGKDTgbu4tDDyryT54o4wcz69pPuPGOUGs+AiJaUcPjYR+kQU
	fS37/afQdm3DLBjAEab6Ygxr/H7Kq4CvwkqfQuQbLWiylMb12TadjV7Rb9jtWElBtEq/XVX5K+g7G
	y8EEp9TpIO5Vpli0Tpprf48O4I2kohI8y2q4VhLjjpydGgbmlfuUnwb9Qw218bkH2SQ7R2u4eJReW
	8FS7Lh8g==;
Received: from [50.53.46.231] (helo=[192.168.254.15])
	by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
	id 1rG5Fk-0016GF-33;
	Wed, 20 Dec 2023 22:41:24 +0000
Message-ID: <88cf45e3-c383-499a-9a6f-3dd586ce15c2@infradead.org>
Date: Wed, 20 Dec 2023 14:41:24 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: scripts/kernel-doc: drivers/gpu/drm/vmwgfx/vmwgfx_stdu.c:76:
 warning: Excess struct member 'transfer' description in 'vmw_stdu_dirty'
Content-Language: en-US
To: kernel test robot <lkp@intel.com>, Zack Rusin <zackr@vmware.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
 Martin Krastev <krastevm@vmware.com>,
 Maaz Mombasawala <mombasawalam@vmware.com>
References: <202312210609.kvPv3OIN-lkp@intel.com>
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <202312210609.kvPv3OIN-lkp@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 12/20/23 14:38, kernel test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   1a44b0073b9235521280e19d963b6dfef7888f18
> commit: 39985eea5a6dd1e844f216028252870e980b9e7f drm/vmwgfx: Abstract placement selection
> date:   10 months ago
> config: x86_64-rhel-8.3-func (https://download.01.org/0day-ci/archive/20231221/202312210609.kvPv3OIN-lkp@intel.com/config)
> compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231221/202312210609.kvPv3OIN-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202312210609.kvPv3OIN-lkp@intel.com/
> 
> All warnings (new ones prefixed by >>):
> 
>>> scripts/kernel-doc: drivers/gpu/drm/vmwgfx/vmwgfx_stdu.c:76: warning: Excess struct member 'transfer' description in 'vmw_stdu_dirty'
>>> scripts/kernel-doc: drivers/gpu/drm/vmwgfx/vmwgfx_stdu.c:76: warning: Excess struct member 'transfer' description in 'vmw_stdu_dirty'
> 

I have already sent a patch for this:
https://lore.kernel.org/dri-devel/20231215234102.16574-1-rdunlap@infradead.org/

-- 
#Randy
https://people.kernel.org/tglx/notes-about-netiquette
https://subspace.kernel.org/etiquette.html

