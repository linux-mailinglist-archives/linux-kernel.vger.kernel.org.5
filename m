Return-Path: <linux-kernel+bounces-5793-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CC02818F8D
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 19:17:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EEAE81F25C69
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 18:17:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7D9939FE0;
	Tue, 19 Dec 2023 18:12:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="agCLjYzu"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 394BD3D0A5;
	Tue, 19 Dec 2023 18:12:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60565C433C7;
	Tue, 19 Dec 2023 18:12:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1703009557;
	bh=ldSuYB2INrB+8Nap+s0z44AwB74zFZX5GkPYteh4Nw4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=agCLjYzuaaWPNzg3lpfrvdCxi92qvd01Jk/ROrIdCzLLkzA9Fa0uL2FyuHBiEvp8k
	 VmpsdT1UpS0145+PtQQqyZtsH1opX/H6NOKCzzZKH+sgtOaPqdUS2KiwSkwpLIlAIS
	 6FDe2LCrzv/As1bDApaMBf25kVbfBxeQbRj2SybU=
Date: Tue, 19 Dec 2023 19:12:35 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, Andreas Noever <andreas.noever@gmail.com>,
	Michael Jamet <michael.jamet@intel.com>,
	Yehezkel Bernat <YehezkelShB@gmail.com>, linux-usb@vger.kernel.org
Subject: Re: [PATCH] thunderbolt: make tb_bus_type const
Message-ID: <2023121930-glimpse-nanny-e8fc@gregkh>
References: <2023121904-utopia-broadcast-06d1@gregkh>
 <20231219180102.GK1074920@black.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231219180102.GK1074920@black.fi.intel.com>

On Tue, Dec 19, 2023 at 08:01:02PM +0200, Mika Westerberg wrote:
> On Tue, Dec 19, 2023 at 04:43:05PM +0100, Greg Kroah-Hartman wrote:
> > Now that the driver core can properly handle constant struct bus_type,
> > move the tb_bus_type variable to be a constant structure as well,
> > placing it into read-only memory which can not be modified at runtime.
> > 
> > Cc: Andreas Noever <andreas.noever@gmail.com>
> > Cc: Michael Jamet <michael.jamet@intel.com>
> > Cc: Mika Westerberg <mika.westerberg@linux.intel.com>
> 
> Acked-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> 
> Or you want me to pick it up?
> 

I can, thanks!

greg k-h

