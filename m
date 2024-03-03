Return-Path: <linux-kernel+bounces-89868-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BBC9086F6B8
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Mar 2024 20:15:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AE5981C204F7
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Mar 2024 19:15:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91B9479DA0;
	Sun,  3 Mar 2024 19:15:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="SybIzYFr"
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B4938BE8;
	Sun,  3 Mar 2024 19:15:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709493320; cv=none; b=qQC9aTkgzTrxkjA+MPSd6xNwYq+WVMUFAgjjocS6s7FbscpQvwLHkSnwm7aYa3oAW5SQd+joEJ6HDxk3A0adY8aSd5IUzos7GGE/gF/V/hWv8/0y6k6vskJvRmQ2iWEq785+MZOtLQE0VeKTDAvRUWRjWCOmqLhkOy0V6BgXe3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709493320; c=relaxed/simple;
	bh=N4PBUmj2kADEi2NGvZOma7ycbVJgN0KLWkB8ZTVI1mk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hRK+eXcNQV48ym1IloqPc7jDvf0rRhYAWheIabnAnEuMgIWVpb+Kn887NF3EMjXZpNZUP55mux3v4w7XCsDqDf21vXmkIW0Pj06QRngEQ8ig5ndaF7abNcP3r4yqFewENXomCr3VyCpcFcJDLBB+i+rhm5f67cqtwxhtHJnaPZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=SybIzYFr; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=LjcLQ1z0lBbXZGI5dOfu2yMBvuw6O+vnpyNO4pY2cE8=; b=SybIzYFrqtEV5t5VBq8JC6bP8+
	QciPKhO6Fby1a5lYdnX5Dbxg/YwZDvt+xEaIVI87Ku41u7KR5CTOwfWl0svbfmdes6dnOJEYFiTZw
	3vp8LCxLGk0Ag6j8T83bIWb7b7qu3B/qmiADMOCrCDYjkDLX8B4KVnqXTNYT1ItU+A4yttp8Qq93/
	4DOzkfQNKVHrIHEQSzA8fzO+G9Fm7XM1Lkxo/TeVtrr0tR3bQSVKFOCXVx86UO6Fj1OrvfRK3MLl+
	0oKOvkkMpffoIDBmOl6v0PwQTQWh533Y9ink/aErIIbCDNRVPyQtvjzDu/TCZA7rnBED1Ne7EbYdk
	giVUFwpw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1rgrIj-002CRg-2H;
	Sun, 03 Mar 2024 19:15:10 +0000
Date: Sun, 3 Mar 2024 19:15:09 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: kernel test robot <lkp@intel.com>
Cc: Kees Cook <keescook@chromium.org>, oe-kbuild-all@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: WARNING: modpost: "strcat" [lib/strcat_kunit.ko] has no CRC!
Message-ID: <20240303191509.GA524366@ZenIV>
References: <202403040332.AgBq81MC-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202403040332.AgBq81MC-lkp@intel.com>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Mon, Mar 04, 2024 at 03:09:04AM +0800, kernel test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   04b8076df2534f08bb4190f90a24e0f7f8930aca
> commit: 3bf301e1ab85e18ed0e337ce124dc71d6d7b5fd7 string: Add Kunit tests for strcat() family
> date:   10 months ago
> config: alpha-randconfig-r032-20221115 (https://download.01.org/0day-ci/archive/20240304/202403040332.AgBq81MC-lkp@intel.com/config)
> compiler: alpha-linux-gcc (GCC) 13.2.0
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240304/202403040332.AgBq81MC-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202403040332.AgBq81MC-lkp@intel.com/

See 8a4a2705ed98 "alpha: fix modversions for strcpy() et.al."
in git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git #work.alpha


