Return-Path: <linux-kernel+bounces-45493-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6152E843171
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 00:43:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1F3FF283EBA
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 23:43:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FDB079953;
	Tue, 30 Jan 2024 23:43:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="xgF1qJE+"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7605037708;
	Tue, 30 Jan 2024 23:43:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706658198; cv=none; b=MoGkc46b+018J7Cu8estHO/yz9ybYZ1tXi03NR0IXSTXzOg2EcPLc7ShaENtYfw9n3fupjKd7fgkxcgvnZkEexKdL/54bixffwtQaNh4hLbdpRZRPO37BVfyQxsKpKu8rz4aBGUIQUmzsLLPi5yl0c6gde0tj/x/xTfHJkyusJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706658198; c=relaxed/simple;
	bh=V5PsE4TKDcZtDMie0XfyAU5qN0ZPlNLmQZMQgv0iDF0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lpsBe3QpzH6STTI59HpzPRloyTFtZ9QGbj85vroSHsV2PeUraBIV19WmKggNkVcSgGrnKryvppj0k0GtH+yeiWDQHXi1PjC/Qbkuvoh1FuhzWiTkbfHKVVWoqCXx9T4RAqKBXgEu19SZN8118Xpe/0lOQXX1ASJ/SL6/PDjX5s8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=xgF1qJE+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B25B7C433C7;
	Tue, 30 Jan 2024 23:43:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1706658197;
	bh=V5PsE4TKDcZtDMie0XfyAU5qN0ZPlNLmQZMQgv0iDF0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=xgF1qJE+D6myzL5YrBxw3WpTob9OuCFY3Qv3gPhJBJSd/tqoR8RSpDHeOgDiVvwdb
	 vBiBcormrRz1MEylxdsnL2BeR9pYMgbR91zit109+s8BWs5jNM+eK1zMxydJBqtfsJ
	 LbYHDCMtEa+MGzqo1dTsLA8xCw/maflTuFIunteI=
Date: Tue, 30 Jan 2024 15:43:17 -0800
From: "'gregkh@linuxfoundation.org'" <gregkh@linuxfoundation.org>
To: "Corona, Ernesto" <ernesto.corona@intel.com>
Cc: "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"linux-aspeed@lists.ozlabs.org" <linux-aspeed@lists.ozlabs.org>,
	"'oleksandrs@mellanox.com'" <oleksandrs@mellanox.com>,
	"'jiri@nvidia.com'" <jiri@nvidia.com>,
	"Castro, Omar Eduardo" <omar.eduardo.castro@intel.com>,
	"'omar.eduardo.castro@linux.intel.com'" <omar.eduardo.castro@linux.intel.com>,
	"'pombredanne@nexb.com'" <pombredanne@nexb.com>,
	"'arnd@arndb.de'" <arnd@arndb.de>,
	"'bbrezillon@kernel.org'" <bbrezillon@kernel.org>,
	"'rdunlap@infradead.org'" <rdunlap@infradead.org>,
	"'johan@kernel.org'" <johan@kernel.org>,
	"'axboe@kernel.dk'" <axboe@kernel.dk>,
	"'joel@jms.id.au'" <joel@jms.id.au>,
	"'palmer@sifive.com'" <palmer@sifive.com>,
	"'keescook@chromium.org'" <keescook@chromium.org>,
	"'vilhelm.gray@gmail.com'" <vilhelm.gray@gmail.com>,
	"'federico.vaga@cern.ch'" <federico.vaga@cern.ch>,
	"'Jonathan.Cameron@huawei.com'" <Jonathan.Cameron@huawei.com>,
	"Luck, Tony" <tony.luck@intel.com>,
	"'christian.gromm@microchip.com'" <christian.gromm@microchip.com>,
	"'linus.walleij@linaro.org'" <linus.walleij@linaro.org>,
	"'zzyiwei@google.com'" <zzyiwei@google.com>,
	"'rubini@gnudd.com'" <rubini@gnudd.com>,
	"'viresh.kumar@linaro.org'" <viresh.kumar@linaro.org>,
	"'mika.westerberg@linux.intel.com'" <mika.westerberg@linux.intel.com>,
	"Filary, Steven A" <steven.a.filary@intel.com>,
	"'vadimp@mellanox.com'" <vadimp@mellanox.com>,
	"'amithash@fb.com'" <amithash@fb.com>,
	"'patrickw3@fb.com'" <patrickw3@fb.com>,
	"Chen, Luke" <luke_chen@aspeedtech.com>,
	"'billy_tsai@aspeedtech.com'" <billy_tsai@aspeedtech.com>,
	"'rgrs@protonmail.com'" <rgrs@protonmail.com>
Subject: Re: [PATCH 30 1/7] Add JTAG core driver
Message-ID: <2024013039-tractor-subside-4535@gregkh>
References: <LV8PR11MB846358B901CA67965197C4AB8B7D2@LV8PR11MB8463.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <LV8PR11MB846358B901CA67965197C4AB8B7D2@LV8PR11MB8463.namprd11.prod.outlook.com>

On Tue, Jan 30, 2024 at 11:26:19PM +0000, Corona, Ernesto wrote:
> +/**
> + * union pad_config - Padding Configuration:
> + *
> + * @type: transfer type
> + * @pre_pad_number: Number of prepadding bits bit[11:0]
> + * @post_pad_number: Number of prepadding bits bit[23:12]
> + * @pad_data : Bit value to be used by pre and post padding bit[24]
> + * @int_value: unsigned int packed padding configuration value bit[32:0]
> + *
> + * Structure provide pre and post padding configuration in a single __u32
> + */
> +union pad_config {

Bad name for a global structure, don't you think?

> +	struct {
> +		__u32 pre_pad_number	: 12;
> +		__u32 post_pad_number	: 12;
> +		__u32 pad_data		: 1;
> +		__u32 rsvd		: 7;
> +	};

This obviously does not work, please don't do that.

thanks,

greg k-h

