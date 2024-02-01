Return-Path: <linux-kernel+bounces-47933-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BF9328454CB
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 11:05:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F234A1C282D6
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 10:05:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92DBA15B10E;
	Thu,  1 Feb 2024 10:05:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Spb11YDQ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4626157E8C;
	Thu,  1 Feb 2024 10:04:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706781899; cv=none; b=YBo5oo8hj0SWwTy2LgtRAysmRedfY+lHnmNNo/mK9Q91+8uZ/7QdbJYL8Tp3appBABqhvjOKvvYKE2wt8wSocqOmNlBgQg9Rie4qpAKrNUi28oFxh0GHBskCuT4uzgKArCJ2RO1xzNllkk7w8tA5emdezoQixwjm6rDOAb3AfVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706781899; c=relaxed/simple;
	bh=8TIIbJywfSgXtb8lGT94VIK+gTj2yGJOv20IJhffFuw=;
	h=Content-Type:MIME-Version:Subject:From:In-Reply-To:References:To:
	 Cc:Message-ID:Date; b=RUQmPw3bWu+e741YCUw2rYDrPOmXa+QQsdQ5ZCl9Cn9RXh5FpsgCOmjFGn+Q4DSpvLztjvJM7NpGURyjkGoxS+KIy4up5EDJ03Hu42fsb7DjH0zVJSx/Jmp8yoxWFk5+WjN79Sf5yq2KsuAReTyUdq5j0CiK50vwS/jWpvN/yI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Spb11YDQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36F6BC43390;
	Thu,  1 Feb 2024 10:04:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706781899;
	bh=8TIIbJywfSgXtb8lGT94VIK+gTj2yGJOv20IJhffFuw=;
	h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
	b=Spb11YDQ3+JmhooytAL0rCa5lO8q2jebhc1EbXXL77WVIXSNSYqWuTOyfb1sgRZPW
	 LGEk0tHyT8k1BaTDpio/sunz5a/0MTFK9v0I8BT37d6V2w1TSzvce6nb+rrhLxZwN1
	 /sZ1T3KmW8sjZUnosO1eaLbK3VsS0aZ7iupBuubg9H8xqeeG96r/E4XViMha50BnGb
	 ehDAE/XcdR/oUEFEF9fMxMYdzBXaEi2h3PhPMlv7noV1muJABt/Sx0GfwVAr6BJ1mP
	 q07zIwXelyyaPikk5belAo9rX2PU3fBhchEc6OFjhaFW/cc8Jnz8i991IFEVkuzxeQ
	 oFdgn3+1zGluw==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] wifi: brcmfmac: Adjust n_channels usage for __counted_by
From: Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20240126223150.work.548-kees@kernel.org>
References: <20240126223150.work.548-kees@kernel.org>
To: Kees Cook <keescook@chromium.org>
Cc: Arend van Spriel <aspriel@gmail.com>, Kees Cook <keescook@chromium.org>,
 Franky Lin <franky.lin@broadcom.com>,
 Hante Meuleman <hante.meuleman@broadcom.com>,
 Chi-hsien Lin <chi-hsien.lin@infineon.com>, Ian Lin <ian.lin@infineon.com>,
 Johannes Berg <johannes.berg@intel.com>,
 Wright Feng <wright.feng@cypress.com>, Hector Martin <marcan@marcan.st>,
 linux-wireless@vger.kernel.org, brcm80211-dev-list.pdl@broadcom.com,
 "Gustavo A. R. Silva" <gustavoars@kernel.org>,
 Linus Walleij <linus.walleij@linaro.org>,
 Jisoo Jang <jisoo.jang@yonsei.ac.kr>, Hans de Goede <hdegoede@redhat.com>,
 Aloka Dixit <quic_alokad@quicinc.com>, John Keeping <john@keeping.me.uk>,
 Jeff Johnson <quic_jjohnson@quicinc.com>, linux-kernel@vger.kernel.org,
 linux-hardening@vger.kernel.org
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <170678189299.2736043.11616312910656558919.kvalo@kernel.org>
Date: Thu,  1 Feb 2024 10:04:55 +0000 (UTC)

Kees Cook <keescook@chromium.org> wrote:

> After commit e3eac9f32ec0 ("wifi: cfg80211: Annotate struct
> cfg80211_scan_request with __counted_by"), the compiler may enforce
> dynamic array indexing of req->channels to stay below n_channels. As a
> result, n_channels needs to be increased _before_ accessing the newly
> added array index. Increment it first, then use "i" for the prior index.
> Solves this warning in the coming GCC that has __counted_by support:
> 
> ../drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c: In function 'brcmf_internal_escan_add_info':
> ../drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c:3783:46: warning: operation on 'req->
> n_channels' may be undefined [-Wsequence-point]
>  3783 |                 req->channels[req->n_channels++] = chan;
>       |                               ~~~~~~~~~~~~~~~^~
> 
> Fixes: e3eac9f32ec0 ("wifi: cfg80211: Annotate struct cfg80211_scan_request with __counted_by")
> Cc: Arend van Spriel <aspriel@gmail.com>
> Cc: Franky Lin <franky.lin@broadcom.com>
> Cc: Hante Meuleman <hante.meuleman@broadcom.com>
> Cc: Kalle Valo <kvalo@kernel.org>
> Cc: Chi-hsien Lin <chi-hsien.lin@infineon.com>
> Cc: Ian Lin <ian.lin@infineon.com>
> Cc: Johannes Berg <johannes.berg@intel.com>
> Cc: Wright Feng <wright.feng@cypress.com>
> Cc: Hector Martin <marcan@marcan.st>
> Cc: linux-wireless@vger.kernel.org
> Cc: brcm80211-dev-list.pdl@broadcom.com
> Signed-off-by: Kees Cook <keescook@chromium.org>
> Reviewed-by: Hans de Goede <hdegoede@redhat.com>
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
> Reviewed-by: Gustavo A. R. Silva <gustavoars@kernel.org>

I'm planning to queue this for wireless tree. Arend, ack?

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20240126223150.work.548-kees@kernel.org/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches


