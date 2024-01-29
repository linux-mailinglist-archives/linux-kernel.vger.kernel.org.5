Return-Path: <linux-kernel+bounces-42598-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DE31584039A
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 12:14:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 788081F2352A
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 11:14:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5195B5B5D2;
	Mon, 29 Jan 2024 11:14:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AJX8NpXl"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92B5155E7B;
	Mon, 29 Jan 2024 11:14:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706526883; cv=none; b=oKfxkSb+XnQxPA+splkMaCXl3+mq70ZAyEcn8N4WHntypb29lbkUAr++rgMnZhzhMLPp2cqExH9VDjmhZjXvb0bce23YQMQah5h3NIkrXPX5hiXD1X+WH4lG8Hq3lzbPY7S/3JxCq3fbY8CW1EJU450+CzPH+Oo7+/FwEu5Okrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706526883; c=relaxed/simple;
	bh=WmE0fsg1x9uaRKxDdJFE55N2p6ZINp1Yi48GoUlIIsc=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=txSPEwseNWkxQeBXVvP0rf8c9SV7HAqkhv14P6/KcsSK2k+SBr9jVKz+uErrG4v4tpkTejD63rz1sVQpXtGrQ+3nLzEM0DNilcRVE5iAroBq/qiCqRvoezyaMnAlctIKa5yCe1dYzqHvUiZl8qYS5k9mJmayRzgt2JaCKJDPMhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AJX8NpXl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18052C433C7;
	Mon, 29 Jan 2024 11:14:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706526883;
	bh=WmE0fsg1x9uaRKxDdJFE55N2p6ZINp1Yi48GoUlIIsc=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=AJX8NpXlwvyEcyqETHycRIfU3BmA3IJvX2EJsIH3Gx9wsO+hpJHCwvbBJv32e0dq5
	 JJPI+NDMTp6rTf85q2yrnQbTLr+O/KBdG/im06hpX1g2L6694mR12w0sUJn9gBdyb5
	 9LjJ5ds6YmXZyyFIQl7G7kqsnDDYweO25nuZheOQOOMd2Nt/+ScABH7J9PLdq4dATI
	 R0+JbPVCDlIM/HIs2XrREgL7/armESBa1z65Pwo5fIDkVQsNmMyhiK/Xw2q15aCXQa
	 kQeRE89hu0SLGHDhtTLQ8qHZaRgWKfpUMt/y9FSI1D/0Om13MA3JoNWrCQ0SC31MrY
	 plnmHKajOTBYg==
From: Kalle Valo <kvalo@kernel.org>
To: Jeff Johnson <quic_jjohnson@quicinc.com>
Cc: <ath11k@lists.infradead.org>,  <linux-wireless@vger.kernel.org>,
  <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] wifi: ath11k: document HAL_RX_BUF_RBM_SW4_BM
References: <20240111-document-hal_rx_buf_rbm_sw4_bm-v1-1-ad277e8ab3cc@quicinc.com>
	<874jfg7xm4.fsf@kernel.org>
	<b4f29511-e001-4964-b88d-208dabf88121@quicinc.com>
	<875xzq526o.fsf@kernel.org>
	<fc6ca019-83e9-4571-bfce-2b4e5c233aef@quicinc.com>
	<87ttn0xc9y.fsf@kernel.org>
	<9c321dfc-f10d-4092-a1cd-30952e4da695@quicinc.com>
Date: Mon, 29 Jan 2024 13:14:38 +0200
In-Reply-To: <9c321dfc-f10d-4092-a1cd-30952e4da695@quicinc.com> (Jeff
	Johnson's message of "Fri, 26 Jan 2024 09:05:26 -0800")
Message-ID: <875xzcxug1.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jeff Johnson <quic_jjohnson@quicinc.com> writes:

> On 1/26/2024 8:58 AM, Kalle Valo wrote:
>> Jeff Johnson <quic_jjohnson@quicinc.com> writes:
>>> They have the same problem I'm trying to fix ;)
>>> % scripts/kernel-doc -Werror -none \
>>> 	$(find drivers/net/wireless/intel/iwlwifi -name '*.[ch]')
>>> ...
>>> 322 warnings as Errors
>>> %
>> 
>> Ouch. But I'm surprised why nobody has reported these before? Are the
>> kernel-doc warnings ignored by everyone?
>
> There are folks who use the kernel 'make' command to build the
> documentation, and report issues from that. But my understanding is that
> 'make' only processes the source files that are referenced by the
> kernel's .rst files. So if a source file has documentation, but that
> source file is not included by one of the .rst files, it won't normally
> be processed.
>
> It is only by running kernel-doc directly against the sources that you
> can spot these issues.

Ah, thanks for the explanation.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

