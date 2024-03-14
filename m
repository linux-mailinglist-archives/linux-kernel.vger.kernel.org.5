Return-Path: <linux-kernel+bounces-103600-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E6F2A87C1C1
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 18:01:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2478D1C21420
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 17:01:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3171774BEF;
	Thu, 14 Mar 2024 17:01:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=craftyguy.net header.i=@craftyguy.net header.b="UjPeQDh0"
Received: from out-187.mta0.migadu.com (out-187.mta0.migadu.com [91.218.175.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5339A74BE1;
	Thu, 14 Mar 2024 17:01:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710435673; cv=none; b=k9PRmUoaqbYLfhLdcW6hItM2R6AooWoZj00uOKUmCdvWeIiDxbwn7OszTDgplbjFUtDwR8OCWc6pZ8qDfF+h43X1S9GPYq81eoSPM9Y8O5+cp5mU75hCf2nDN+3BcHn7Vx8N7LK++ZDsDE7emqy73gSXDVHYaEBgj9JXf+kwcUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710435673; c=relaxed/simple;
	bh=kx/65Q2aEyNOq/9aSjIYHA7KOud5g13mAoAdscg6Sa8=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type:Content-Disposition; b=ca2Bk3UyLZ6s5GQcDI1i75mmrYOooCbixKoBWRcPC8OvaO7qCAUIj390LW1R1+ey+ICF2KuJkZC0oaLarjDHBsDwbU4K0UeM35IkmPB1mBoffbz4BhX8yDRG1wWSTICIvZSgF+scSBoKWDaL+yLRbyniUEp0gmW12NrNAvMlJEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=craftyguy.net; spf=pass smtp.mailfrom=craftyguy.net; dkim=pass (2048-bit key) header.d=craftyguy.net header.i=@craftyguy.net header.b=UjPeQDh0; arc=none smtp.client-ip=91.218.175.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=craftyguy.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=craftyguy.net
Date: Thu, 14 Mar 2024 10:01:03 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=craftyguy.net;
	s=key1; t=1710435669;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7VZ6BU3j+IT52okbFNFdHPBh3OIM0PFIwRzd4ocYRAA=;
	b=UjPeQDh0MqOYej8uHFOtfmcU7bWp8F5yq6dnVy5dBwyopL6cI4OB95jui2Io045Hv5SkiS
	oE3Wts4SLO8JxUSm/YcD4AS4KzgTDtv6cpusjdH8yR11G6xgaClhWiuV+EoEwTbNaUgfuC
	9LrZdNcK64GKzhH9gjS4i5qYfcjOYBSXea+UG8czGdcCLbl4FSYStSK3P21Q5cRIw2GXpc
	Pk2QSk/Z5KDTlNpFw5eEAdpOm+D9u85TQCfXUO9yhgEWQrZO53aN4N3+Sm/YoJeUf3JGet
	RkbTrjTU1oYW8j6ytut5tvGUfnBYDP9v9aMEnWd0ezTmUWsLpJOsq1WmwG4teg==
Message-ID: <20240314100103.GC6100@craftyguy.net>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Clayton Craft <clayton@craftyguy.net>
To: Johan Hovold <johan+linaro@kernel.org>
Cc: Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
 Marcel Holtmann <marcel@holtmann.org>, linux-bluetooth@vger.kernel.org,
 linux-kernel@vger.kernel.org, Johan Hovold <johan+linaro@kernel.org>,
 stable@vger.kernel.org, Janaki Ramaiah Thota <quic_janathot@quicinc.com>
Subject: Re: [PATCH] Revert "Bluetooth: hci_qca: Set BDA quirk bit if fwnode
 exists in DT"
In-Reply-To: <20240314084412.1127-1-johan+linaro@kernel.org>
References: <20240314084412.1127-1-johan+linaro@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On Thu, 14 Mar 2024 09:44:12 +0100 Johan Hovold <johan+linaro@kernel.org> wrote:
> This reverts commit 7dcd3e014aa7faeeaf4047190b22d8a19a0db696.
> 
> Qualcomm Bluetooth controllers like WCN6855 do not have persistent
> storage for the Bluetooth address and must therefore start as
> unconfigured to allow the user to set a valid address unless one has
> been provided by the boot firmware in the devicetree.
> 
> A recent change snuck into v6.8-rc7 and incorrectly started marking the
> default (non-unique) address as valid. This specifically also breaks the
> Bluetooth setup for some user of the Lenovo ThinkPad X13s.
> 
> Note that this is the second time Qualcomm breaks the driver this way
> and that this was fixed last year by commit 6945795bc81a ("Bluetooth:
> fix use-bdaddr-property quirk"), which also has some further details.
> 
> Fixes: 7dcd3e014aa7 ("Bluetooth: hci_qca: Set BDA quirk bit if fwnode exists in DT")
> Cc: stable@vger.kernel.org      # 6.8
> Cc: Janaki Ramaiah Thota <quic_janathot@quicinc.com>
> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>

Thanks Johan, this revert does indeed fix Bluetooth for me on the X13s.

Reported-by: Clayton Craft <clayton@craftyguy.net>
Tested-by: Clayton Craft <clayton@craftyguy.net>

-Clayton

