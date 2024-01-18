Return-Path: <linux-kernel+bounces-30028-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 046E783181E
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 12:09:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 77E74B2499E
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 11:08:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FA7F24218;
	Thu, 18 Jan 2024 11:08:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FVq4UqzR"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6138E241E6;
	Thu, 18 Jan 2024 11:08:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705576114; cv=none; b=AwauZsuVmTPBI50YLe9DM2TAOp3HgHqS5za15MVUlmC/0Ql2eKI5YXuSjjRo0MV9m1fnR9URZJlKg2mquhhRob/KTJLUnRS2wk+YH/6BGXFX5BHkMZJJxIjU9I4ZkPIPdruh3/gVZCt+zhhOQ/mBl/CEVhFS+F9NxfJkqPhqcqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705576114; c=relaxed/simple;
	bh=rGbrI8sNR96Acbsy9tBWyCiVY3Sa9RJ0zm5JcTqANrE=;
	h=Received:DKIM-Signature:From:To:Cc:Subject:References:Date:
	 In-Reply-To:Message-ID:User-Agent:MIME-Version:Content-Type; b=f0sM4y12FbhGMXxDBK86B0T7u33mXLtaWeBxxxTYuygZcovAKc+frOpkqOrk+Ozwk+76ZINDgmq0gyVjk/tTr6hBjrcnU9GtKecJZ2mgPn77gsg/2JaaygWHlYhKCXgOXqn+WweT6bQ71BqWZqBIKKe/FJTlyny4Dw7M2nVe8pQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FVq4UqzR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30C51C433F1;
	Thu, 18 Jan 2024 11:08:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705576114;
	bh=rGbrI8sNR96Acbsy9tBWyCiVY3Sa9RJ0zm5JcTqANrE=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=FVq4UqzRz3KJliesJ/BdCC3eGm/OBDDeBB3uv+HhnSIqLhnBr7/eQvQ0jBozxLtpu
	 U6536KA0mxD/9x66U7v43Rn0CaLV6f5R87dQgciFJs4y6heCyH0s8Me4aE6n3s1PFL
	 4n9W6HFv0YjbE/nwWIcr9C7MPKK4tAcOJ+2St+hWdnJccAtPdlTiGtEuSClpbDHMaj
	 z4TepxfgrrXmvknY5qXn0p9puoJvxxKrU3qgL46W9s39AjDNvsiNCasO2vIwboI8q2
	 Guvaj5GWfNTh6QL/QV6pblEpBRY+nOR7D9MbJDo/mebTWcJYSqZcHgczeKMUoOwE6F
	 Etuudmr27d+ow==
From: Kalle Valo <kvalo@kernel.org>
To: Jeff Johnson <quic_jjohnson@quicinc.com>
Cc: <ath11k@lists.infradead.org>,  <linux-wireless@vger.kernel.org>,
  <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] wifi: ath11k: document HAL_RX_BUF_RBM_SW4_BM
References: <20240111-document-hal_rx_buf_rbm_sw4_bm-v1-1-ad277e8ab3cc@quicinc.com>
	<874jfg7xm4.fsf@kernel.org>
	<b4f29511-e001-4964-b88d-208dabf88121@quicinc.com>
Date: Thu, 18 Jan 2024 13:08:31 +0200
In-Reply-To: <b4f29511-e001-4964-b88d-208dabf88121@quicinc.com> (Jeff
	Johnson's message of "Tue, 16 Jan 2024 08:58:04 -0800")
Message-ID: <875xzq526o.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jeff Johnson <quic_jjohnson@quicinc.com> writes:

> On 1/14/2024 7:17 AM, Kalle Valo wrote:
>> Jeff Johnson <quic_jjohnson@quicinc.com> writes:
>> 
>>> Commit 7636c9a6e7d7 ("wifi: ath11k: Add multi TX ring support for WCN6750")
>>> added HAL_RX_BUF_RBM_SW4_BM to enum hal_rx_buf_return_buf_manager. However,
>>> as flagged by the kernel-doc script, the documentation was not updated:
>>>
>>> drivers/net/wireless/ath/ath11k/hal.h:689: warning: Enum value
>>> 'HAL_RX_BUF_RBM_SW4_BM' not described in enum
>>> 'hal_rx_buf_return_buf_manager'
>>>
>>> So update the documentation. No functional changes, compile tested only.
>>>
>>> Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>
>> 
>> I'm not really a fan of kernel-doc in wireless drivers, it feels more
>> unnecessary work. Should we remove the kernel-doc markings from ath11k
>> altogether?
>
> Are you not a fan of kernel-doc format specifically, or not a fan of
> documentation at all?

I'm definitely a fan of documentation where it makes sense, but I'm not
fan of kernel-doc if there are no users or readers. For example, using
kernel-doc in cfg80211 or mac80211 makes a lot of sense, and is
important, but I'm not convinced about using kernel-doc in wireless
drivers.

> I'm personally a fan of documentation since good documentation makes the
> code more maintainable. Yes, there is a cost in creating and maintaining
> the documentation, but this is hopefully offset by cost saving when new
> developers are trying to understand and modify the code.
>
> I'm also a fan of consistency. And since kernel-doc is the standard
> format defined for the kernel, it is my personal preference to use that
> format.

I understand your points and if we had plenty of free time I would be
onboard with this. To keep my mail short few quick points:

* To make sure there are no kernel-doc warnings we would have to add
  checks to ath11k-check, which would slow down it considerably and it
  would again slow down our workflow (I run it several times a day).

* To use kernel-doc formatting alone doesn't really make sense so we
  would have to start creating a kernel-doc book or something. But who
  would read it?

* kernel-doc moves field documentation in structures away from the
  actual fields which I find confusing.

* The risk of having outdated kernel-doc documentation is high, it would
  need active maintenance etc.

* I'm worried about creating useless documentation, like "Count number
  foo" for foo_count() just because of kernel-doc.

This is why I consider return on investment is low here :) My preference
is to make the code understandable (good symbol names etc) and document
the special cases, which are not obvious from the code, with a normal
code comment.

> I'm curious what others think of the ath10/11/12k level and style of
> documentation.

IIRC iwlwifi uses kernel-doc to document the firmware interface, not
sure how much it's used elsewhere in the driver.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

