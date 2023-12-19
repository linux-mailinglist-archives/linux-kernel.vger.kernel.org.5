Return-Path: <linux-kernel+bounces-5413-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 93E87818A6E
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 15:49:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2FCE81F2DD2E
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 14:49:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 206A01BDFD;
	Tue, 19 Dec 2023 14:49:26 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B62D1C284;
	Tue, 19 Dec 2023 14:49:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=kernel.org
X-IronPort-AV: E=McAfee;i="6600,9927,10929"; a="460009654"
X-IronPort-AV: E=Sophos;i="6.04,288,1695711600"; 
   d="scan'208";a="460009654"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Dec 2023 06:49:24 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10929"; a="866655630"
X-IronPort-AV: E=Sophos;i="6.04,288,1695711600"; 
   d="scan'208";a="866655630"
Received: from smile.fi.intel.com ([10.237.72.54])
  by FMSMGA003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Dec 2023 06:49:21 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andy@kernel.org>)
	id 1rFbPK-00000007Hww-3Wxb;
	Tue, 19 Dec 2023 16:49:18 +0200
Date: Tue, 19 Dec 2023 16:49:18 +0200
From: Andy Shevchenko <andy@kernel.org>
To: xiongxin <xiongxin@kylinos.cn>
Cc: fancer.lancer@gmail.com, hoan@os.amperecomputing.com,
	linus.walleij@linaro.org, brgl@bgdev.pl, linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@kernel.org,
	Riwen Lu <luriwen@kylinos.cn>
Subject: Re: [PATCH v4] gpio: dwapb: mask/unmask IRQ when disable/enale it
Message-ID: <ZYGtbgmQS0x43l3k@smile.fi.intel.com>
References: <20231219101620.4617-1-xiongxin@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231219101620.4617-1-xiongxin@kylinos.cn>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Tue, Dec 19, 2023 at 06:16:20PM +0800, xiongxin wrote:

Code wise it's fine, but while answering to Serge's email I realized that
the Subject has a typo and additionally you or Bart (if he is fine with that)
can amend:

> In the hardware implementation of the i2c hid driver based on dwapb gpio

I²C HID (alternatively: I2C HID)

here and everywhere else in the commit message unless it's the file or
function name.

> irq,

DesignWare GPIO IRQ chip

> when the user continues to use the i2c hid device in the suspend
> process, the i2c hid interrupt will be masked after the resume process
> is finished.
> 
> This is because the disable_irq()/enable_irq() of the dwapb gpio driver

DesignWare GPIO

> does not synchronize the irq mask register state. In normal use of the

IRQ

> i2c hid procedure, the gpio irq irq_mask()/irq_unmask() functions are
> called in pairs. In case of an exception, i2c_hid_core_suspend() calls
> disable_irq() to disable the gpio irq. With low probability, this causes

GPIO IRQ

> irq_unmask() to not be called, which causes the gpio irq to be masked

GPIO IRQ

> and not unmasked in enable_irq(), raising an exception.
> 
> Add synchronization to the masked register state in the
> dwapb_irq_enable()/dwapb_irq_disable() function. mask the gpio irq

GPIO IRQ

> before disabling it. After enabling the gpio irq, unmask the irq.

GPIO IRQ
IRQ

-- 
With Best Regards,
Andy Shevchenko



