Return-Path: <linux-kernel+bounces-134665-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0531E89B4A0
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 01:37:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B3E52281491
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 23:37:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19F1244C71;
	Sun,  7 Apr 2024 23:37:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HVxV9vva"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50C303BBD4;
	Sun,  7 Apr 2024 23:37:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712533033; cv=none; b=CbgUtk2GNif3E5oQUMWLW2T/YQDYUZpT5tS/qWtyTOhPdj8OWWIigouSeD1rDoDBfR21/9ZyfuO6FwXqTY1KM9fiCMqVQxr8oD2UGn04n5gjX0aPBQqgmaYdnU91vSYB79aAUaI3db3VtOIqwHiiVJpPLCp04eCPvoBd+gdjBv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712533033; c=relaxed/simple;
	bh=50CUNTe1kjs1rAWmd6fasZtqFBjC0nWodYXdh3hAMVM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZNyTFTeIqEz5T2UcssrDZ7P85DBC01YYjAFObI9vWdl757D++2w5ExwaclKyFR7b/cA/nNfGLsLTtmUgMOJ4+UuVrPMLERiQtV7za01qQsV+ySwy53hgS/ObN9EBvTDiQwK4+EtgkEROYFoG3Eo90z+TKynHQcpe2NfYBTxfGQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HVxV9vva; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89BBDC433F1;
	Sun,  7 Apr 2024 23:37:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712533032;
	bh=50CUNTe1kjs1rAWmd6fasZtqFBjC0nWodYXdh3hAMVM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HVxV9vvadjUq4BWg+JF4IMDstY3ssCcogUZspNddMzCTsR5zBzBj5i8+jPSDpm/ew
	 JkpIgb6tqs/qeRaPvIRFjeYRuj/vc7PmrL5rwo+45D4AVHIgoIBnc3cn8U1srFUiJX
	 BBOZcWDcmJmcTatMbPWOEemxzcDNRZtWt4QecR2omdF68Y8n8RfIULlozupzb80x4S
	 mDT5mEuyhXjDVvOhhVoQOBa91UagVJiQ5C4lG8rYuc1R9KBD32JXY9dnFmj9kIE5tu
	 WKQsSCv4ZTsaNCtn5wuSTd2R3LllXPjEJNlDA6Cb4I+dnULlJWHgI1S34a5OUfc0Wm
	 3BBnJpvHZGzBA==
Date: Sun, 7 Apr 2024 19:37:12 -0400
From: Sasha Levin <sashal@kernel.org>
To: Florian Fainelli <florian.fainelli@broadcom.com>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	Jacob Keller <jacob.e.keller@intel.com>,
	"David S . Miller" <davem@davemloft.net>, opendmb@gmail.com,
	andrew@lunn.ch, hkallweit1@gmail.com, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org
Subject: Re: [PATCH AUTOSEL 6.8 39/68] net: mdio: mdio-bcm-unimac: Manage
 clock around I/O accesses
Message-ID: <ZhMuKCJ7w-0PtJhV@sashalap>
References: <20240329122652.3082296-1-sashal@kernel.org>
 <20240329122652.3082296-39-sashal@kernel.org>
 <888b10eb-cdd5-43bb-a501-471aa28b1153@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <888b10eb-cdd5-43bb-a501-471aa28b1153@broadcom.com>

On Tue, Apr 02, 2024 at 05:41:44AM -0700, Florian Fainelli wrote:
>
>
>On 3/29/2024 5:25 AM, Sasha Levin wrote:
>>From: Florian Fainelli <florian.fainelli@broadcom.com>
>>
>>[ Upstream commit ee975351cf0c2a11cdf97eae58265c126cb32850 ]
>>
>>Up until now we have managed not to have the mdio-bcm-unimac manage its
>>clock except during probe and suspend/resume. This works most of the
>>time, except where it does not.
>>
>>With a fully modular build, we can get into a situation whereby the
>>GENET driver is fully registered, and so is the mdio-bcm-unimac driver,
>>however the Ethernet PHY driver is not yet, because it depends on a
>>resource that is not yet available (e.g.: GPIO provider). In that state,
>>the network device is not usable yet, and so to conserve power, the
>>GENET driver will have turned off its "main" clock which feeds its MDIO
>>controller.
>>
>>When the PHY driver finally probes however, we make an access to the PHY
>>registers to e.g.: disable interrupts, and this causes a bus error
>>within the MDIO controller space because the MDIO controller clock(s)
>>are turned off.
>>
>>To remedy that, we manage the clock around all of the I/O accesses to
>>the hardware which are done exclusively during read, write and clock
>>divider configuration.
>>
>>This ensures that the register space is accessible, and this also
>>ensures that there are not unnecessarily elevated reference counts
>>keeping the clocks active when the network device is administratively
>>turned off. It would be the case with the previous way of managing the
>>clock.
>>
>>Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
>>Signed-off-by: Florian Fainelli <florian.fainelli@broadcom.com>
>>Signed-off-by: David S. Miller <davem@davemloft.net>
>>Signed-off-by: Sasha Levin <sashal@kernel.org>
>
>Please drop this patch, it is usable in isolation and needs 2 
>additional patches to be meaningful:
>
>https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=ee2b4cf8b281606bbf332cbd73ce2a73eac417f0
>https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
>/commit/?id=ba0b78371c46b2104197ff2c244f13f011ddfa80

Ack, thanks!

-- 
Thanks,
Sasha

