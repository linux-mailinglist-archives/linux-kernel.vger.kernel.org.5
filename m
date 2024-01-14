Return-Path: <linux-kernel+bounces-25497-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1821482D126
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Jan 2024 16:17:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 578601C20C0A
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Jan 2024 15:17:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00E362599;
	Sun, 14 Jan 2024 15:17:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jfudFVxB"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CE3E7E;
	Sun, 14 Jan 2024 15:17:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4871C433C7;
	Sun, 14 Jan 2024 15:17:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705245462;
	bh=jollSml2+OM4Sa0F+IOmTJVXk53FpYSt8/GqaTL4RT0=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=jfudFVxBK71G0oW06zEROGpzorXRfUYL12QXEEG4r3NWje6A6JYor4oR7Mj5YhuOx
	 BmZvb5epwfyNICraTP/4Fdmxtw5gyMOdbie4ehD50UPQXfZpwsIyOASzqDM482qMgo
	 3x4a/zMwxSGHmKlJggrPo0lw5l3IaE80WNw64Rujj6oJQAaEpqw9G4HxIxlrF0GRop
	 /FUM5IXWoKICk8QBy+8xOjbOZxSG3BT70cllLbHBGefA/Gi2qloa6bKji1mrKRqswu
	 ZEjhO0QzBtaHjVHUa8YOW+mwDDmq3Y2eI1iNcd3AQhvTeNsNsXknMf3ExQPUvIr+jO
	 dVLGn00aVkIiQ==
From: Kalle Valo <kvalo@kernel.org>
To: Jeff Johnson <quic_jjohnson@quicinc.com>
Cc: <ath11k@lists.infradead.org>,  <linux-wireless@vger.kernel.org>,
  <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] wifi: ath11k: document HAL_RX_BUF_RBM_SW4_BM
References: <20240111-document-hal_rx_buf_rbm_sw4_bm-v1-1-ad277e8ab3cc@quicinc.com>
Date: Sun, 14 Jan 2024 17:17:39 +0200
In-Reply-To: <20240111-document-hal_rx_buf_rbm_sw4_bm-v1-1-ad277e8ab3cc@quicinc.com>
	(Jeff Johnson's message of "Thu, 11 Jan 2024 11:24:23 -0800")
Message-ID: <874jfg7xm4.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jeff Johnson <quic_jjohnson@quicinc.com> writes:

> Commit 7636c9a6e7d7 ("wifi: ath11k: Add multi TX ring support for WCN6750")
> added HAL_RX_BUF_RBM_SW4_BM to enum hal_rx_buf_return_buf_manager. However,
> as flagged by the kernel-doc script, the documentation was not updated:
>
> drivers/net/wireless/ath/ath11k/hal.h:689: warning: Enum value 'HAL_RX_BUF_RBM_SW4_BM' not described in enum 'hal_rx_buf_return_buf_manager'
>
> So update the documentation. No functional changes, compile tested only.
>
> Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>

I'm not really a fan of kernel-doc in wireless drivers, it feels more
unnecessary work. Should we remove the kernel-doc markings from ath11k
altogether?

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

