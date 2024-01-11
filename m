Return-Path: <linux-kernel+bounces-23410-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E8BE82AC6B
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 11:47:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 037231F23AA4
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 10:47:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04D6F14F68;
	Thu, 11 Jan 2024 10:47:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kbSEQVMi"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5191214F62;
	Thu, 11 Jan 2024 10:47:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E17BFC433F1;
	Thu, 11 Jan 2024 10:47:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704970062;
	bh=PA1DrN2jKruYsGaRX2xQTe8kwVsI9xI6OOUmy1LzljU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kbSEQVMiBBST1I11qRBzYF0GT9sqekJg/+5ilfdCTkg3LxJPjI7+7NqZmsJwR62HI
	 NRqOGpRArC9VQHQCLgHeqyD97b9FDQg0KIndlHBPwcHuDJ6eu48W0ixwH/57eKSOv5
	 tO9pu029Vs5D9JZ6cjJ44xWWTFU3RMVEsajummkT8nBDrCeVaccb4I64t6cJE9QwRL
	 10Wbh2NA3gbCa5ZHh9XTXWfXt7nZytn7VwrM5fSGQhHhWFblroJjN7m55ISWOWenIN
	 b9r0QeBcoT4mSmJ7xy4In0vzQOPoDcPvoC/xjCmXD8QgstXViAK/2QOFD6pp43M5Kx
	 FP3ynbku3XPiw==
Date: Thu, 11 Jan 2024 10:47:38 +0000
From: Lee Jones <lee@kernel.org>
To: Min Li <lnimi@hotmail.com>
Cc: richardcochran@gmail.com, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, Min Li <min.li.xe@renesas.com>
Subject: Re: [PATCH net-next v7 4/5] ptp: clockmatrix: Fix caps.max_adj to
 reflect DPLL_MAX_FREQ_OFFSET[MAX_FFO]
Message-ID: <20240111104738.GD1665043@google.com>
References: <20240104163641.15893-1-lnimi@hotmail.com>
 <PH7PR03MB7064A4963CF7B4253AA93066A0672@PH7PR03MB7064.namprd03.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <PH7PR03MB7064A4963CF7B4253AA93066A0672@PH7PR03MB7064.namprd03.prod.outlook.com>

On Thu, 04 Jan 2024, Min Li wrote:

> From: Min Li <min.li.xe@renesas.com>
> 
> Query MAX_FREQ_OFFSET register to set the proper limit.
> 
> Signed-off-by: Min Li <min.li.xe@renesas.com>
> ---
>  drivers/ptp/ptp_clockmatrix.c    | 43 +++++++++++++++++++++++++-------
>  drivers/ptp/ptp_clockmatrix.h    |  1 +

>  include/linux/mfd/idt8a340_reg.h |  1 +

Acked-by: Lee Jones <lee@kernel.org>

>  3 files changed, 36 insertions(+), 9 deletions(-)

[...]

-- 
Lee Jones [李琼斯]

