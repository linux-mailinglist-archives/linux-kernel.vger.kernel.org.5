Return-Path: <linux-kernel+bounces-23857-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 61A2B82B2D9
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 17:23:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 86DA31C24D4E
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 16:23:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FE22524A3;
	Thu, 11 Jan 2024 16:21:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Sd4NHbiu"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CE4851C27;
	Thu, 11 Jan 2024 16:21:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE39BC433F1;
	Thu, 11 Jan 2024 16:21:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704990081;
	bh=cLMSls0CclaGc98AAZVASmR+hPSsayxTFbvOAqBnEQQ=;
	h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
	b=Sd4NHbiuDtAmFeJViN6EkVGtGanE/TQTIzyeIoRQ1TBpYJFA4se4MwkT0lhmmdoP2
	 UwOH/0tWuDwDFGs0+VktMMWC06uQDmrTkMMR1jEDikRZTPsfngeGWbHF+Ie1PaUNMu
	 oOoCzWEw6IUC79iks94p6YnoftyVkzWvKT1t915YKJgt97ySr9ScjRLSV0xjdad6xS
	 MAG+G21MdgH0t6wZD0HMrQ/uUublvOQXgU4o/IxuHuvI1X5ebtZfEbhmSQQCaJlvrG
	 7QnTkR5GUrTywjZkEwjh9MaLeCJkeh2NSJc063rn6cGT2UH75tutXnjeT7G7/al5hX
	 Ln7c0PocxePzQ==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 1/3] wifi: ath12k: Remove unnecessary struct qmi_txn
 initializers
From: Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20240109-qmi-cleanup-v1-1-607b10858566@quicinc.com>
References: <20240109-qmi-cleanup-v1-1-607b10858566@quicinc.com>
To: Jeff Johnson <quic_jjohnson@quicinc.com>
Cc: Jeff Johnson <quic_jjohnson@quicinc.com>, <ath12k@lists.infradead.org>,
 <linux-wireless@vger.kernel.org>, <linux-kernel@vger.kernel.org>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <170499007813.916301.2323327164409855961.kvalo@kernel.org>
Date: Thu, 11 Jan 2024 16:21:19 +0000 (UTC)

Jeff Johnson <quic_jjohnson@quicinc.com> wrote:

> Currently most of the ath12k QMI messaging functions define their
> struct qmi_txn variables with a {} initializer. However, all of these
> functions subsequently call qmi_txn_init(), and the very first thing
> that function does is zero the struct. Hence, the initializers are
> unnecessary. Since these consume code space and cpu cycles, remove
> them.
> 
> No functional changes, compile tested only.

s-o-b missing on all 3 patches.

3 patches set to Changes Requested.

13515170 [1/3] wifi: ath12k: Remove unnecessary struct qmi_txn initializers
13515167 [2/3] wifi: ath12k: Add missing qmi_txn_cancel() calls
13515168 [3/3] wifi: ath12k: Use initializers for QMI message buffers

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20240109-qmi-cleanup-v1-1-607b10858566@quicinc.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches


