Return-Path: <linux-kernel+bounces-8095-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D8C8681B21E
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 10:23:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1654D1C246CD
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 09:23:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 062AA4B5BB;
	Thu, 21 Dec 2023 09:11:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Zbt+M9Fv"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27FB920DFD;
	Thu, 21 Dec 2023 09:11:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07B60C433C8;
	Thu, 21 Dec 2023 09:11:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1703149867;
	bh=/WzNv9MnpdH5DL+RbcHgW/lhQEnlhmwuWZbe7H2FjoI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Zbt+M9FvnqygUuM7jlyguqNlW2VmMiyfgcxqdiEa3FDBXrccfvI55WRXCFP5zcIrl
	 jWL/AidAA8QFWGEt6e6VJyeOh0sQv36uLT2RzJQCClFYma8Dl/19W5HYdmNAQLC4p8
	 b/dZVANnIoJp+s3NmVmALYa6SKFkzZBaTHMVBI3A=
Date: Thu, 21 Dec 2023 10:11:04 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: "Gan, Yi Fang" <yi.fang.gan@intel.com>
Cc: Andrew Halaney <ahalaney@redhat.com>,
	Javier Martinez Canillas <javierm@redhat.com>,
	John Stultz <jstultz@google.com>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Jens Axboe <axboe@kernel.dk>, Russell King <linux@armlinux.org.uk>,
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Marek =?iso-8859-1?Q?Beh=FAn?= <kabel@kernel.org>,
	netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	Looi Hong Aun <hong.aun.looi@intel.com>,
	Voon Weifeng <weifeng.voon@intel.com>,
	Song Yoong Siang <yoong.siang.song@intel.com>,
	Lai Peter Jun Ann <peter.jun.ann.lai@intel.com>,
	Choong Yong Liang <yong.liang.choong@intel.com>
Subject: Re: [PATCH net v2 0/2] Fix phylink unloadable issue
Message-ID: <2023122141-smuggling-confidant-d1d8@gregkh>
References: <20231221085109.2830794-1-yi.fang.gan@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231221085109.2830794-1-yi.fang.gan@intel.com>

On Thu, Dec 21, 2023 at 04:51:07PM +0800, Gan, Yi Fang wrote:
> Add module_exit_stub() for phylink module.
> 
> Changes since v1:
> - Introduce a helper macro for module_exit() boilerplate
> 
> This series is the combination of following:
> v1 with empty phylink_exit():
> https://lore.kernel.org/all/20231127101603.807593-1-yi.fang.gan@intel.com/
> v1 of module_exit_stub():
> https://lore.kernel.org/all/20231212094352.2263283-1-yi.fang.gan@intel.com/

As I said before, no, this isn't ok.  Why just resubmit a patch when
it's already been rejected?

This patch series should NOT be accepted as-is, you know this!

Also, you are not following the documented and REQUIRED rules for Intel
developers to be submitting kernel patches, so on that reason alone
these need to be rejected.

Please work with the Intel internel developers to do this correctly if
you wish to submit this again in the future.

greg k-h

