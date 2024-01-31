Return-Path: <linux-kernel+bounces-45513-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CB2B88431AF
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 01:12:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 269DEB241FD
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 00:12:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D49736F;
	Wed, 31 Jan 2024 00:12:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="rdjxNWNV"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE0C4363;
	Wed, 31 Jan 2024 00:11:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706659921; cv=none; b=umG+rYQWLZCBwRQC1qBSodZEZi6eYaDM9iEmbh8emWgEi9j3MZ0jQ3dbbxFQKiCIqzCV+IiMFsa0KUOUm94kSIA2RRo6HEAIrmkg7ZunzitlouxZropLqOt2OBesrISYQGbwA06atSISQ5W4vPOwEWnu+uqDKVT6sLAiYN2bPS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706659921; c=relaxed/simple;
	bh=GgouBS036lSk8Ti6LM62/pvnl1AZvOJ/NE31Wux+lX0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lkR/nqGKXmAAUDIATKpWDjxfLrOcJ+AcL0Emy7sjcBvESybwwyFin+hHe33ypUgNE19oulufC9nrtewjcqyvzCENDsi4jfyWl8LHjiZ5T4HSeZUcJWNN32XNlKQp55vOtzyo0u0+WvjrwH40Q49fvuSK5mJ3wIfHoEMexDccuKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=rdjxNWNV; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=ZUu41NIy1go0/WlVvM2jE8yEu9KhVGZIlw10YLiU/wY=; b=rdjxNWNVvuMp7Dmxu3W5l2C6BA
	/YB0Cvf8+ETvJfkSgHCZ1T7HAJtN19VT+sAv2UWv9rw8KXeWTtIpa6FDYhFpDGOSnRP8M2nf254O/
	S8tVjHO59MmBufpzYO52ZYslGjmslX+/nCj7HOMbTdedBr6AAAI/QOviTqVmS6qIyQanWyJ5HHLWa
	02+IBQfpfg8ThqEZYSuvXWab/Ezvsr220iLYP6q9AhXGpz0ZEpqAMWZ7FepsxY/TEsjelwgPQqG6k
	DAC8CHlFiNP0MRXrST0eywfT9OO23BpH0AWOpZg+7spVdLxUzFOzOJa+BbzMd4AjRZq4TyiJTO+Cr
	xKilm3ww==;
Received: from [50.53.50.0] (helo=[192.168.254.15])
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rUyCr-00000000z5O-1bh8;
	Wed, 31 Jan 2024 00:11:57 +0000
Message-ID: <8fe881af-dab8-456f-8e8a-8d76153c4322@infradead.org>
Date: Tue, 30 Jan 2024 16:11:55 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 30 3/7] Add Aspeed SOC 24xx, 25xx and 26xx JTAG support
Content-Language: en-US
To: "Corona, Ernesto" <ernesto.corona@intel.com>,
 "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>,
 "linux-aspeed@lists.ozlabs.org" <linux-aspeed@lists.ozlabs.org>
Cc: "'oleksandrs@mellanox.com'" <oleksandrs@mellanox.com>,
 "'jiri@nvidia.com'" <jiri@nvidia.com>,
 "Castro, Omar Eduardo" <omar.eduardo.castro@intel.com>,
 "'omar.eduardo.castro@linux.intel.com'"
 <omar.eduardo.castro@linux.intel.com>, "'arnd@arndb.de'" <arnd@arndb.de>,
 "'pombredanne@nexb.com'" <pombredanne@nexb.com>,
 "'joel@jms.id.au'" <joel@jms.id.au>, "'andrew@aj.id.au'" <andrew@aj.id.au>,
 "'p.zabel@pengutronix.de'" <p.zabel@pengutronix.de>,
 "Filary, Steven A" <steven.a.filary@intel.com>,
 "'vadimp@mellanox.com'" <vadimp@mellanox.com>,
 "'amithash@fb.com'" <amithash@fb.com>, "'patrickw3@fb.com'"
 <patrickw3@fb.com>, "Chen, Luke" <luke_chen@aspeedtech.com>,
 "'billy_tsai@aspeedtech.com'" <billy_tsai@aspeedtech.com>,
 "'rgrs@protonmail.com'" <rgrs@protonmail.com>
References: <LV8PR11MB846379E82775EFA1C9062D1C8B7D2@LV8PR11MB8463.namprd11.prod.outlook.com>
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <LV8PR11MB846379E82775EFA1C9062D1C8B7D2@LV8PR11MB8463.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 1/30/24 15:30, Corona, Ernesto wrote:
> +config USE_INTERRUPTS
> +	bool "Use interrupts as event wait mechanism"
> +	depends on JTAG_ASPEED
> +	default n
> +	help

This symbol needs some kind of namespacing. It is too generic as is.

Thanks.
-- 
#Randy

