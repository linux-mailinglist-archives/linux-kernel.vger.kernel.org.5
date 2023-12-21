Return-Path: <linux-kernel+bounces-8581-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 66C0981B9BB
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 15:41:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 997541C215EC
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 14:41:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23AF33608D;
	Thu, 21 Dec 2023 14:41:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="atejqCvs"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D0441D69C;
	Thu, 21 Dec 2023 14:41:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31C6AC433C8;
	Thu, 21 Dec 2023 14:41:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703169702;
	bh=EVUMYl3rOlHtN/K6V9hi9IeUlzUhMbQYqoThI5xvNHg=;
	h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
	b=atejqCvskyYhQxXzNXFV6zuf9UR1fIL0CqfG4VlLwRt6ReMNwXqKiEpjvy5Srdbjo
	 aIAoXM7fxtWEgsF4Vl7SCvoXfWvWcgIGLlH6FHcrAHUQTxHWxnAhJfgAUZXFNmbTjH
	 78KXRF43V6YN+eQQAqbsBn6hNVAwHSXDW/Mne5Q7swkujLyi+VRAOiAPJi7224VyXx
	 tZDoTBwuXAuHy7bUAlP+5ZM6vjZj5lbjnQTTDoMXrCH43D9jAxvLp1irrd391jcA2N
	 8cGw1UxMsDDlaNynY+mgmlw9gm7pjgel+C5JVXv2sKLoJvtoWB0LfBe2P2yBhK/fdn
	 gjEa9yzYV5CkA==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v2] wifi: mwifiex: fix uninitialized firmware_stat
From: Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20231221015511.1032128-1-yu-hao.lin@nxp.com>
References: <20231221015511.1032128-1-yu-hao.lin@nxp.com>
To: David Lin <yu-hao.lin@nxp.com>
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
 briannorris@chromium.org, francesco@dolcini.it, tsung-hsien.hsieh@nxp.com,
 David Lin <yu-hao.lin@nxp.com>, stable@vger.kernel.org,
 kernel test robot <lkp@intel.com>, Dan Carpenter <error27@gmail.com>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <170316969802.1243375.17807414549323669608.kvalo@kernel.org>
Date: Thu, 21 Dec 2023 14:41:40 +0000 (UTC)

David Lin <yu-hao.lin@nxp.com> wrote:

> Variable firmware_stat is possible to be used without initialization.
> 
> Signed-off-by: David Lin <yu-hao.lin@nxp.com>
> Fixes: 1c5d463c0770 ("wifi: mwifiex: add extra delay for firmware ready")
> Cc: stable@vger.kernel.org
> Reported-by: kernel test robot <lkp@intel.com>
> Reported-by: Dan Carpenter <error27@gmail.com>
> Closes: https://lore.kernel.org/r/202312192236.ZflaWYCw-lkp@intel.com/
> Acked-by: Brian Norris <briannorris@chromium.org>

Patch applied to wireless-next.git, thanks.

3df95e265924 wifi: mwifiex: fix uninitialized firmware_stat

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20231221015511.1032128-1-yu-hao.lin@nxp.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches


