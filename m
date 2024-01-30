Return-Path: <linux-kernel+bounces-44697-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E541C842621
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 14:23:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 971351F26A4D
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 13:23:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4016C6BB57;
	Tue, 30 Jan 2024 13:23:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hfgaGVjx"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AB6267E79;
	Tue, 30 Jan 2024 13:23:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706621019; cv=none; b=txsk8KbiMNKH72QrhTxoAlccKun9HKrU16/7AAPcqoD4Q37quWe/qKL4+lg/yFI2SJVTpPsk2bImaMYGj2aNxOGjGUtxuuLqUu0YBSbWUcj6Vn3t5b7P2s4A15zNIJOVboJE0LHTaC3cvRxQhkRpcYp6IZPcQ6GXW+w+fNBrVyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706621019; c=relaxed/simple;
	bh=RKCaoganjPDCgCyRbdn8LRljyVTeQzOhld1mynpH6IE=;
	h=Content-Type:MIME-Version:Subject:From:In-Reply-To:References:To:
	 Cc:Message-ID:Date; b=WfrpWsDhpDoLyF+wcFzIGmNVEaFMOcPyk88IirVEfDdrbr7n+D8n8dTjecL7uekwFGuoZSjsGNXrdWhaMQuF6Ty7VFAXrdX/vyagqvZZKbl3gL41EqMwggFfRVNRU1huUS30i7ImQ1f/v+f2t2MIF3T2GjS9gylQ58uhyQLwKeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hfgaGVjx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45888C433F1;
	Tue, 30 Jan 2024 13:23:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706621019;
	bh=RKCaoganjPDCgCyRbdn8LRljyVTeQzOhld1mynpH6IE=;
	h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
	b=hfgaGVjxcvyna3GhthcWEKWDqEORuAbjlOUPMeN2l7juh1cp9EYG+LISdbeEXoOVM
	 cAp81Ln8FsBdK0r6dE85VTjxP7GKydDukJ5AeV4+MuTYtlHqBn0YKQETO2OWuCel2u
	 QNl4kkCRQXztsPpboXwdTOWm4uKE+FQ9ec9pW9Ip0MkD3oXKIM/Wvpx+QCAZcQnOFe
	 jujOfgXFbxyRZUzcw8zWf4M/miCP0hHuVXuaMu+QA5xAqkKoi9juFZrtgnryc1u1te
	 O9TP265RGdK3L3X18iM0AhLZ+UlMj8QxLehrqX4MHq8eyTC7wNhg4SuAxx+kqrE8LI
	 dvQUaBiEjzTOg==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH net 1/9] wifi: fill in MODULE_DESCRIPTION()s for wlcore
From: Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20240130104243.3025393-2-leitao@debian.org>
References: <20240130104243.3025393-2-leitao@debian.org>
To: Breno Leitao <leitao@debian.org>
Cc: kuba@kernel.org, davem@davemloft.net, pabeni@redhat.com,
 edumazet@google.com, dsahern@kernel.org, weiwan@google.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, horms@kernel.org,
 andrew@lunn.ch, leit@fb.com,
 =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
 Kees Cook <keescook@chromium.org>, Johannes Berg <johannes.berg@intel.com>,
 Emmanuel Grumbach <emmanuel.grumbach@intel.com>,
 Justin Stitt <justinstitt@google.com>, Li Zetao <lizetao1@huawei.com>,
 Francois Romieu <romieu@fr.zoreil.com>, Rob Herring <robh@kernel.org>,
 Marc Kleine-Budde <mkl@pengutronix.de>, Ruan Jinjie <ruanjinjie@huawei.com>,
 linux-wireless@vger.kernel.org (open list:TI WILINK WIRELESS DRIVERS)
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <170662101207.2289851.7564186430529596261.kvalo@kernel.org>
Date: Tue, 30 Jan 2024 13:23:34 +0000 (UTC)

Breno Leitao <leitao@debian.org> wrote:

> W=1 builds now warn if module is built without a MODULE_DESCRIPTION().
> Add descriptions to the TI WLAN wlcore drivers.
> 
> Signed-off-by: Breno Leitao <leitao@debian.org>

These patches go to wireless-next, not net. But no need to resend because of this.

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20240130104243.3025393-2-leitao@debian.org/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches


