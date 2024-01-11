Return-Path: <linux-kernel+bounces-23411-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 076DF82AC6D
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 11:48:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2C9D21C23D68
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 10:48:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D9C814F6B;
	Thu, 11 Jan 2024 10:48:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZGXrjQLc"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BD4C14F60;
	Thu, 11 Jan 2024 10:48:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B754FC433F1;
	Thu, 11 Jan 2024 10:48:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704970087;
	bh=o9/WdRHxP/NggLfgETmiPP3pACQ2kJOPJGBjShAl1PI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZGXrjQLcLWK7MLI/Cjt6UfEbx8d+wwvua2DU4sJyPJ9A3G0xS7HY65f4j4T9u45Wu
	 z2wliledwtx27b0NzIq9ZaG9yvfvgl3PzqlfW3Wh90gFGU5RTmqoUP7I44AAAIsWzP
	 KHodcuSdcKx8kbjhpPEKhZSI8u6dxFq/FgcJGIZGeno3S1KBiAuF0+1PiyRG0BElqB
	 2fj8VZod+DNxwzzuYSwi4s3hBDoBi4+3rHur1TQR/YOa1qHP0YYMeq7FgHW1JOqo8E
	 ILcAFUKuKAgaCiQPuDcfRFmAm7H/6pDH1xE7xK9PpeLCzLrgiKBQbr8g8KYFxP3sD/
	 ZuMBQqKZb8n1w==
Date: Thu, 11 Jan 2024 10:48:03 +0000
From: Lee Jones <lee@kernel.org>
To: Min Li <lnimi@hotmail.com>
Cc: richardcochran@gmail.com, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, Min Li <min.li.xe@renesas.com>
Subject: Re: [PATCH net-next v7 5/5] ptp: clockmatrix: move register and
 firmware related definition to idt8a340_reg.h
Message-ID: <20240111104803.GE1665043@google.com>
References: <20240104163641.15893-1-lnimi@hotmail.com>
 <PH7PR03MB7064E39ABB68A108919987C1A0672@PH7PR03MB7064.namprd03.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <PH7PR03MB7064E39ABB68A108919987C1A0672@PH7PR03MB7064.namprd03.prod.outlook.com>

On Thu, 04 Jan 2024, Min Li wrote:

> From: Min Li <min.li.xe@renesas.com>
> 
> This change is needed by rsmu driver, which will be submitted separately
> from mfd tree.
> 
> Signed-off-by: Min Li <min.li.xe@renesas.com>
> ---
>  drivers/ptp/ptp_clockmatrix.h    |  33 ---------
>  include/linux/mfd/idt8a340_reg.h | 121 +++++++++++++++++++++++++++++--

Acked-by: Lee Jones <lee@kernel.org>

>  2 files changed, 113 insertions(+), 41 deletions(-)

[...]

-- 
Lee Jones [李琼斯]

