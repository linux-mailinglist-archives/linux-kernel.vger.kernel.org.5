Return-Path: <linux-kernel+bounces-7283-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C3F3881A4DC
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 17:24:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 65F51B24CB7
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 16:24:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFEA64B15C;
	Wed, 20 Dec 2023 16:20:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NlffhOCJ"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C264482F7;
	Wed, 20 Dec 2023 16:20:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7DBC9C433C8;
	Wed, 20 Dec 2023 16:20:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703089232;
	bh=XVgd7pqYNT+knJLpFJ5VDLSw1dPBnwpebcm4HpkJ8yQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=NlffhOCJ1UyfI+WZlEScRu+W0FpBZpCOJutilYVtmDMnQM1SUCDQWrom7mdcLTN2C
	 xzavSclOmhmxZGL4IWQ8ZF9qjqBsAsJBj7Y6fdMEBqFF7HH7ITrhwei88JIFCIf4X5
	 vWzFZ6NJm8blBrsml3RNc6tpZfCqhk0wa0Jhhac//IgP7apWRYSVJ1Bpk6BXpVQUiL
	 eY2i9NXO494PrP21ejfBr7KYvLeCuQRenGVx2zr4IByU/k9Fx5Oo42PUOhmkgHMkQH
	 XGuorGu0QbKOuaJTAJAATGEVDqNUuAl85YwL27w1Vs9OxDPP5oIDAt4ytA796XcyNP
	 2v3e/q9WJ0epQ==
Date: Wed, 20 Dec 2023 17:20:25 +0100
From: Marek =?UTF-8?B?QmVow7pu?= <kabel@kernel.org>
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: Pavel Machek <pavel@ucw.cz>, Lee Jones <lee@kernel.org>, Andrew Lunn
 <andrew@lunn.ch>, Jakub Kicinski <kuba@kernel.org>, Daniel Golle
 <daniel@makrotopia.org>, "David S. Miller" <davem@davemloft.net>, Li Zetao
 <lizetao1@huawei.com>, linux-kernel@vger.kernel.org,
 linux-leds@vger.kernel.org
Subject: Re: [PATCH v4 1/2] leds: trigger: netdev: display only supported
 link speed attribute
Message-ID: <20231220172025.3b9c452b@dellmb>
In-Reply-To: <20231219165353.23233-1-ansuelsmth@gmail.com>
References: <20231219165353.23233-1-ansuelsmth@gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 19 Dec 2023 17:53:52 +0100
Christian Marangi <ansuelsmth@gmail.com> wrote:

> +	for_each_set_bit(mode, supported_link_modes, __ETHTOOL_LINK_MODE_MASK_NBITS) {
> +		struct ethtool_link_ksettings link_ksettings;
> +
> +		ethtool_params_from_link_mode(&link_ksettings, mode);
> +
> +		if (attr == &dev_attr_link_10.attr &&
> +		    link_ksettings.base.speed == SPEED_10)
> +			return attr->mode;
> +
> +		if (attr == &dev_attr_link_100.attr &&
> +		    link_ksettings.base.speed == SPEED_100)
> +			return attr->mode;
> +
> +		if (attr == &dev_attr_link_1000.attr &&
> +		    link_ksettings.base.speed == SPEED_1000)
> +			return attr->mode;
> +
> +		if (attr == &dev_attr_link_2500.attr &&
> +		    link_ksettings.base.speed == SPEED_2500)
> +			return attr->mode;
> +
> +		if (attr == &dev_attr_link_5000.attr &&
> +		    link_ksettings.base.speed == SPEED_5000)
> +			return attr->mode;
> +
> +		if (attr == &dev_attr_link_10000.attr &&
> +		    link_ksettings.base.speed == SPEED_10000)
> +			return attr->mode;

Hi Christian,

ugly code repetition. Use a macro or a switch or something.

Marek

