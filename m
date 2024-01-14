Return-Path: <linux-kernel+bounces-25487-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F2DB82D10A
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Jan 2024 16:01:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C97C1B21255
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Jan 2024 15:01:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE1852581;
	Sun, 14 Jan 2024 15:01:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xe4D1PxZ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 182087E;
	Sun, 14 Jan 2024 15:01:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A519C433C7;
	Sun, 14 Jan 2024 15:01:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705244462;
	bh=aRieRp79l/B2y5vjKinEX+iYJeaHanzDnbFW5Ls4f7c=;
	h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
	b=Xe4D1PxZsT3269QVH2gTyELMT7aGAoEsaGU8YG8fdfFBHVPNNrrblvLV2MoCokdqg
	 D1XUnCNMRzsvgdXhvczZx/35lGmUOQbtCs5U2zb5aZv2rtpQbmphTUJSCz/KbjQNNx
	 5+ZwukFf9axgEUtA7mZGYogLkaZivYrVUAn8xXRQ0ZGLRipyvAcZIAt/DPeGYaieiS
	 xQQeiLfA0iTewi5iApesC35R+hUr0rQ8z6INWobFL8LtOR09iA0vZkUqIcozYVohLY
	 fihuo/wsCduIvBOj8oULK6w18TCjfyQVU6BIevIBXgZyL5KZHqrdNJnQTifROaLFIC
	 y632ne2aIyD7A==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v2 1/3] wifi: ath12k: Remove unnecessary struct qmi_txn
 initializers
From: Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20240111-qmi-cleanup-v2-1-53343af953d5@quicinc.com>
References: <20240111-qmi-cleanup-v2-1-53343af953d5@quicinc.com>
To: Jeff Johnson <quic_jjohnson@quicinc.com>
Cc: Jeff Johnson <quic_jjohnson@quicinc.com>, <ath12k@lists.infradead.org>,
 <linux-wireless@vger.kernel.org>, <linux-kernel@vger.kernel.org>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <170524445957.1421352.9255954399937351219.kvalo@kernel.org>
Date: Sun, 14 Jan 2024 15:01:01 +0000 (UTC)

Jeff Johnson <quic_jjohnson@quicinc.com> wrote:

> Currently most of the ath12k QMI messaging functions define their
> struct qmi_txn variables with a {} initializer. However, all of these
> functions subsequently call qmi_txn_init(), and the very first thing
> that function does is zero the struct. Hence, the initializers are
> unnecessary. Since these consume code space and cpu cycles, remove
> them.
> 
> No functional changes, compile tested only.
> 
> Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>
> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>

3 patches applied to ath-next branch of ath.git, thanks.

59cf57ab3dee wifi: ath12k: Remove unnecessary struct qmi_txn initializers
2e82b5f09a97 wifi: ath12k: Add missing qmi_txn_cancel() calls
6d2b0a066941 wifi: ath12k: Use initializers for QMI message buffers

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20240111-qmi-cleanup-v2-1-53343af953d5@quicinc.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches


