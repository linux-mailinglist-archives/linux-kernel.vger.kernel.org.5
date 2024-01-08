Return-Path: <linux-kernel+bounces-20101-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E26782794B
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 21:44:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ABFC81F23E75
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 20:44:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB1F654BDA;
	Mon,  8 Jan 2024 20:43:45 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from netrider.rowland.org (netrider.rowland.org [192.131.102.5])
	by smtp.subspace.kernel.org (Postfix) with SMTP id 52CA156752
	for <linux-kernel@vger.kernel.org>; Mon,  8 Jan 2024 20:43:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=rowland.harvard.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=netrider.rowland.org
Received: (qmail 509471 invoked by uid 1000); 8 Jan 2024 15:43:42 -0500
Date: Mon, 8 Jan 2024 15:43:42 -0500
From: Alan Stern <stern@rowland.harvard.edu>
To: Elad Nachman <enachman@marvell.com>
Cc: gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
  linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] usb: host: Add ac5 to EHCI Orion
Message-ID: <79a951c8-abca-44b0-a769-a67c949b6ba3@rowland.harvard.edu>
References: <20240108175457.4113480-1-enachman@marvell.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240108175457.4113480-1-enachman@marvell.com>

On Mon, Jan 08, 2024 at 07:54:57PM +0200, Elad Nachman wrote:
> From: Elad Nachman <enachman@marvell.com>
> 
> Add support for ac5 to the EHCI Orion platform driver.
> The ac5 SOC has DDR starting at offset 0x2_0000_0000,
> Hence it requires a larger than 32-bit DMA mask to operate.
> Move the dma mask to be pointed by the OF match data, and
> use that match data when initializng the DMA mask.
> 
> Signed-off-by: Elad Nachman <enachman@marvell.com>
> ---

Acked-by: Alan Stern <stern@rowland.harvard.edu>

