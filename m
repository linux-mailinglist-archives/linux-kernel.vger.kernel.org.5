Return-Path: <linux-kernel+bounces-149534-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F44A8A928A
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 07:42:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1DE50B22017
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 05:42:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F395758119;
	Thu, 18 Apr 2024 05:42:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="pDOhn3tR"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4D262207A;
	Thu, 18 Apr 2024 05:42:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713418960; cv=none; b=fEkqOoOdo9XiqxzD/soCnV6r4J9YBbGhJ+yKt3Evovc3Jmuy1oz5pYHPMHswRxEPbIF3MUx7ICScA6BSuvRIhaLX6OAM4dB/kHbhPTtygQn/tLMmFA2if0xWzWlnd4gzS23BE3rI80/t576qeD+s0QDZQv8Kx1DkAlX606/pxy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713418960; c=relaxed/simple;
	bh=YxeBu55FKWBCDcGmYLprM+1TwrDCa2GsynnmzRxvMB0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bFHRWp8mpNdolsozivDKWjTcViWJGn3yp4EnHhDP/UPbEJHYeDVXAZB4/tMddVpQMgJFn4KWyj8xfnW4zgTPgOgCeo+IPilKwE44+eUZBhgtL6JbehkVsgPyn+QFp1b4eKgfntYQsRzUftmqla5UptMRANf5Hm8ZW8kVvoaQfCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=pDOhn3tR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8525C113CC;
	Thu, 18 Apr 2024 05:42:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1713418959;
	bh=YxeBu55FKWBCDcGmYLprM+1TwrDCa2GsynnmzRxvMB0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pDOhn3tRmtikJzVGPVu/TKmUosb/PJmkdHIdEkBRQAr+TNKYlDHgh6lqZ15uXtpJO
	 5pTKs15x9FxaVUTqSECZMnNVoXsx/3cboJ53v1QdEKl3myVVT/hkCo3lHAWnppOUpR
	 5vH0y883KEaaI9wptVKZDJ9dITNrJmeRJHPJS54Y=
Date: Thu, 18 Apr 2024 07:42:34 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Parker Newman <parker@finest.io>
Cc: kernel test robot <lkp@intel.com>, Jiri Slaby <jirislaby@kernel.org>,
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
	oe-kbuild-all@lists.linux.dev,
	Parker Newman <pnewman@connecttech.com>
Subject: Re: [PATCH v4 6/7] serial: exar: add CTI specific setup code
Message-ID: <2024041810-regain-handgrip-a942@gregkh>
References: <ae4a66e7342b686cb8d4b15317585dfb37222cf4.1713382717.git.pnewman@connecttech.com>
 <202404181353.1VIC4cz9-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202404181353.1VIC4cz9-lkp@intel.com>

On Thu, Apr 18, 2024 at 01:29:14PM +0800, kernel test robot wrote:
> Hi Parker,
> 
> kernel test robot noticed the following build warnings:
> 
> [auto build test WARNING on b86ae40ffcf5a16b9569b1016da4a08c4f352ca2]
> 
> url:    https://github.com/intel-lab-lkp/linux/commits/Parker-Newman/serial-exar-remove-old-Connect-Tech-setup/20240418-043457
> base:   b86ae40ffcf5a16b9569b1016da4a08c4f352ca2
> patch link:    https://lore.kernel.org/r/ae4a66e7342b686cb8d4b15317585dfb37222cf4.1713382717.git.pnewman%40connecttech.com
> patch subject: [PATCH v4 6/7] serial: exar: add CTI specific setup code
> config: alpha-defconfig (https://download.01.org/0day-ci/archive/20240418/202404181353.1VIC4cz9-lkp@intel.com/config)
> compiler: alpha-linux-gcc (GCC) 13.2.0
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240418/202404181353.1VIC4cz9-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202404181353.1VIC4cz9-lkp@intel.com/
> 
> All warnings (new ones prefixed by >>):
> 
> >> drivers/tty/serial/8250/8250_exar.c:727: warning: Function parameter or struct member 'pcidev' not described in 'cti_get_port_type_xr17c15x_xr17v25x'
> >> drivers/tty/serial/8250/8250_exar.c:819: warning: Function parameter or struct member 'pcidev' not described in 'cti_get_port_type_fpga'
> >> drivers/tty/serial/8250/8250_exar.c:849: warning: Function parameter or struct member 'pcidev' not described in 'cti_get_port_type_xr17v35x'
> 
> 
> vim +727 drivers/tty/serial/8250/8250_exar.c
> 
>    714	
>    715	/**
>    716	 * cti_get_port_type_xr17c15x_xr17v25x() - Get port type of xr17c15x/xr17v25x
>    717	 * @priv: Device's private structure
>    718	 * @port_num: Port to get type of
>    719	 *
>    720	 * CTI xr17c15x and xr17v25x based cards port types are based on PCI IDs.
>    721	 *
>    722	 * Return: port type on success, CTI_PORT_TYPE_NONE on failure
>    723	 */
>    724	static enum cti_port_type cti_get_port_type_xr17c15x_xr17v25x(struct exar8250 *priv,
>    725								struct pci_dev *pcidev,
>    726								unsigned int port_num)
>  > 727	{

Parker, no need to resend this, you can send a follow-on patch after
this to resolve it.  Simplest way is to just not do kernel-doc formats
for static functions, as it's usually not needed.  Or you can add the
function parameter, either one will silence the warning.

thanks,

greg k-h

