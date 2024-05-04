Return-Path: <linux-kernel+bounces-168483-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E42F38BB90D
	for <lists+linux-kernel@lfdr.de>; Sat,  4 May 2024 03:04:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9DF86283DEA
	for <lists+linux-kernel@lfdr.de>; Sat,  4 May 2024 01:04:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4401328EF;
	Sat,  4 May 2024 01:04:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lyndeno.ca header.i=@lyndeno.ca header.b="IWH4myxU";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="SkXMJr2Y"
Received: from wfout8-smtp.messagingengine.com (wfout8-smtp.messagingengine.com [64.147.123.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A879E17F0;
	Sat,  4 May 2024 01:04:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714784650; cv=none; b=JvXHJKiWL8KZP3dbK0szBd+HGgmUci2s2Bfs1/TO/DAGFNzNq4bInXwsWgzMCpsGTns0IGc5INs/ijHiyt5Kx0NerVJ2pltwDIHEcFf+k3AI0U36eiMIwvhEAAZkD+0wwvOyAgDtlhpw6ByloNjxqXeClwTrYBhHUsvH0AjrI1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714784650; c=relaxed/simple;
	bh=GTAviRUSbLhWepPZbkOt/9B6fmwH/X/W0vVQuT4dRwk=;
	h=Date:From:Subject:To:Cc:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XcRou8pO2cF18aQzOQEz3YcL26IMCvV9fU7iiMaVfUNcscyAgFlXCZVITZiuVOeQZ1j4+jOWBl0I8sw8fzda1h2xkF1iXNkLPmdss1mxaTQmdF3uIT1/sPtdpzVCnPGmfAAMsMehBny6YM6W/OsvntAYmbHaFN6rA/z/MLoBw1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lyndeno.ca; spf=pass smtp.mailfrom=lyndeno.ca; dkim=pass (2048-bit key) header.d=lyndeno.ca header.i=@lyndeno.ca header.b=IWH4myxU; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=SkXMJr2Y; arc=none smtp.client-ip=64.147.123.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lyndeno.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lyndeno.ca
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailfout.west.internal (Postfix) with ESMTP id C03C41C00122;
	Fri,  3 May 2024 21:04:05 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Fri, 03 May 2024 21:04:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lyndeno.ca; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1714784645; x=1714871045; bh=hqb5qPm2Ez
	Fq5XsSUyPxT/J/oPYrlFVrHq8anqHONac=; b=IWH4myxUaXyxJWEEwlZyo4zXUr
	KlMPgbIxu93asxZ2GT74V9c+vm/qwnRl1AAJEh8BNTEbNvGs19+ZddDVvS1pFZU3
	KvA6R8tbPM2yKcnWqEXqGzAyW5LVCGXjdRHrtHjloJ7LQSgdQIaSwufshhExBsBV
	yp2VyKcf6uIgoKFgMS4cXr1C196VRCtW2qI6lQq+YfKBzSfrHpntW8ly3FDQtys+
	+cq0yEJIpfmBGGf7VxIfkFqafQIFTiyTmfS+L9+rtOpPQKP3Ssr8WQRLecKGCFOJ
	jTIQ7q3sZuZVrOQUt/9A6TgY2ePS0Xv0Wtl2YOhPWQ/oVksyFgbgCZo5PCCg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1714784645; x=1714871045; bh=hqb5qPm2EzFq5XsSUyPxT/J/oPYr
	lFVrHq8anqHONac=; b=SkXMJr2YnD04MZ0x/+PVsHd59w85r74zC76FZE67D46Z
	syf5HoMFxpg51gQF/ObM4beSJurk+hUuzfkT9e9D1YYnQLSjVtQ3pc7QkqbzPTFg
	hXYAc6X/oDoNswk+FzY9CLE/l6y2N/9kuaamHU0RDfZt+TDowhMCUCutcmZ21tGo
	7WnjgmrjgZDa7TFdh2RGfE4hh0FCJU8apdTHc6u0kgL5QrepTiHBrGxHoQutq0Lj
	KWlnzQR+1sQw2uVwZCwJ8VaTo/pWUpJRdRm1mBS8b5pd8oYJJCHTEfXi/S+n74z1
	jibpoTLRLkZZOcqpXV9ZwFWyN1X3VdXK/mbCXiyX2w==
X-ME-Sender: <xms:hIk1Zs7fqncGfg8UXnrEHClTwRowOaZcKy_OlS0HzFlMeySxZ1cPmg>
    <xme:hIk1Zt56sraQMlXzhWCIqmw8TgciaZWIcffG0I6JbyvYFKYPT_DN3hCGK8zzqMVLv
    23ZpjR3mqG0pkmm6mw>
X-ME-Received: <xmr:hIk1ZrccauRwvWZhM5twEGeylc18zUOkCPg47CJtuL-LNOe_hxAoUcdKFSu9ntp4U3bH>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvddvuddggedvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhuffvvefkjghfofggtgesthdtredtredtvdenucfhrhhomhepnfihnhgu
    ohhnucfurghntghhvgcuoehlshgrnhgthhgvsehlhihnuggvnhhordgtrgeqnecuggftrf
    grthhtvghrnhepvdfgjeduvddtheekkeduiedtieegveefgeekgfevffffjeevgeffueev
    heejjedtnecuffhomhgrihhnpehgihhtqdhstghmrdgtohhmpdhgihhthhhusgdrtghomh
    dpkhgvrhhnvghlrdhorhhgpddtuddrohhrghenucevlhhushhtvghrufhiiigvpedtnecu
    rfgrrhgrmhepmhgrihhlfhhrohhmpehlshgrnhgthhgvsehlhihnuggvnhhordgtrg
X-ME-Proxy: <xmx:hIk1ZhIQkgaynT7idR4bB-x_YMq0NVM106dCScAeY0O4tfQtiRQM-w>
    <xmx:hIk1ZgLIfK_63V8oTkanacBDwLbAB5SSdTjlGNbsMcGIfFu-pFGmEw>
    <xmx:hIk1ZiyRkXLf5OQN9bY3upnEA5-FxH4p4FoI2iqeFll4ABhIsFzqZw>
    <xmx:hIk1ZkLplf_lQRtRvjbjrR9NRrnmLOsairvz-pAUNf0DFowZ4CP_eg>
    <xmx:hYk1Zpeqtfdo85_ZJMW1kDxy4gw61w5IEYys4TSa9BO8QWcJn70t9zyA>
Feedback-ID: i1719461a:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 3 May 2024 21:03:45 -0400 (EDT)
Date: Fri, 03 May 2024 19:03:10 -0600
From: Lyndon Sanche <lsanche@lyndeno.ca>
Subject: Re: [PATCH v5] platform/x86: dell-laptop: Implement platform_profile
To: kernel test robot <lkp@intel.com>
Cc: Paul Gazzillo <paul@pgazz.com>, Necip Fazil Yildiran
	<fazilyildiran@gmail.com>, oe-kbuild-all@lists.linux.dev,
	mario.limonciello@amd.com, pali@kernel.org, W_Armin@gmx.de,
	srinivas.pandruvada@linux.intel.com, ilpo.jarvinen@linux.intel.com,
	Hans de Goede <hdegoede@redhat.com>, Matthew Garrett <mjg59@srcf.ucam.org>,
	Jonathan Corbet <corbet@lwn.net>, Heiner Kallweit <hkallweit1@gmail.com>,
	Vegard Nossum <vegard.nossum@oracle.com>, platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org, Dell.Client.Kernel@dell.com
Message-Id: <A9SXCS.IUN31UTTT9GM2@lyndeno.ca>
In-Reply-To: <202405031851.NYy0ZB02-lkp@intel.com>
References: <20240501215829.4991-2-lsanche@lyndeno.ca>
	<202405031851.NYy0ZB02-lkp@intel.com>
X-Mailer: geary/44.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed



On Fri, May 3 2024 at 06:19:18 PM +08:00:00, kernel test robot 
<lkp@intel.com> wrote:
> Hi Lyndon,
> 
> kernel test robot noticed the following build warnings:
> 
> [auto build test WARNING on linus/master]
> [also build test WARNING on v6.9-rc6 next-20240503]
> [If your patch is applied to the wrong git tree, kindly drop us a 
> note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch#_base_tree_information]
> 
> url:    
> https://github.com/intel-lab-lkp/linux/commits/Lyndon-Sanche/platform-x86-dell-laptop-Implement-platform_profile/20240502-060146
> base:   linus/master
> patch link:    
> https://lore.kernel.org/r/20240501215829.4991-2-lsanche%40lyndeno.ca
> patch subject: [PATCH v5] platform/x86: dell-laptop: Implement 
> platform_profile
> config: 
> i386-kismet-CONFIG_ACPI_PLATFORM_PROFILE-CONFIG_DELL_LAPTOP-0-0 
> (https://download.01.org/0day-ci/archive/20240503/202405031851.NYy0ZB02-lkp@intel.com/config)
> reproduce: 
> (https://download.01.org/0day-ci/archive/20240503/202405031851.NYy0ZB02-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new 
> version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: 
> https://lore.kernel.org/oe-kbuild-all/202405031851.NYy0ZB02-lkp@intel.com/
> 
> kismet warnings: (new ones prefixed by >>)
>>>  kismet: WARNING: unmet direct dependencies detected for 
>>> ACPI_PLATFORM_PROFILE when selected by DELL_LAPTOP
>    WARNING: unmet direct dependencies detected for 
> ACPI_PLATFORM_PROFILE
>      Depends on [n]: ACPI [=n]
>      Selected by [y]:
>      - DELL_LAPTOP [=y] && X86_PLATFORM_DEVICES [=y] && 
> X86_PLATFORM_DRIVERS_DELL [=y] && DMI [=y] && BACKLIGHT_CLASS_DEVICE 
> [=y] && (ACPI_VIDEO [=n] || ACPI_VIDEO [=n]=n) && (RFKILL [=n] || 
> RFKILL [=n]=n) && (DELL_WMI [=n] || DELL_WMI [=n]=n) && SERIO_I8042 
> [=y] && DELL_SMBIOS [=y]
> 
> --
> 0-DAY CI Kernel Test Service
> https://github.com/intel/lkp-tests/wiki

I will try reproducing this test on my machine, to avoid spamming the 
mailing list with the same error over and over.








