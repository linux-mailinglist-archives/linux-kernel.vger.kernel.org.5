Return-Path: <linux-kernel+bounces-52253-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D71118495F7
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 10:08:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 62643280EB1
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 09:08:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C41F012B71;
	Mon,  5 Feb 2024 09:05:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="lO/DlnOT"
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A59D1773D
	for <linux-kernel@vger.kernel.org>; Mon,  5 Feb 2024 09:05:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707123920; cv=none; b=pppeQW/8kAJGnVYPfAt2KTbca6gM/DXZlwBzaGS2MUFwo6VJiAUQPzp2P4AB/5HcVMY3L2pS4wItQy2WK61LSaXolarAIDcJPOiFBPG14EVnqmLoX0nmZNGPfZDvoZgdAkypQIJn6noEwAfs7F+j0pDPL+BOwr2cpcJObFKdWaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707123920; c=relaxed/simple;
	bh=5uslP+6MiU5p4xB80AbckdzpFTK8AZLC0FSdU6yovsc=;
	h=References:From:To:Cc:Subject:Date:In-reply-to:Message-ID:
	 MIME-Version:Content-Type; b=saC9x47dyGlCoWLBpocqy0J7QJald1HlOLp/L2K/bCeGtTC5KevbLuogzshYVIRKiYtoQFvrskaEB3LAwCgthp1bXsVDRO2t8c9uy1JSW9rV8tYC6UWgTiQjhVaVx380d/E6QuxUy2Zl4T7q3Vp/4d9QcTpeo6xYWPgLcXJncsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=lO/DlnOT; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-40fccd09082so18143175e9.2
        for <linux-kernel@vger.kernel.org>; Mon, 05 Feb 2024 01:05:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1707123915; x=1707728715; darn=vger.kernel.org;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:from:to:cc:subject:date:message-id:reply-to;
        bh=FrzyemCCCe25zosXOoDYB16obaNMd4rjugvPsL9t2Tc=;
        b=lO/DlnOTsaXup4aulR7ByDaFa5LT985S2rvMV1Hx7xUnl0oI9WNNsdQSfeP10vkJ7P
         BtCHPjqc41MMGhBxXifdUN1MeKZxTH0Mn4VsJR0dYOgdzlMsfoekMgmGLFnHd47SGiyZ
         dw8VLOl7b5WW3NvNAmn9581hxcM7zMMV26IhD3ZBdVq57stN7A04DHcSMqTteh9p67ND
         Mdn/NAZ1YE8QnhbO5C8fY4JtanRm76WmS13xxe751bsIivr8Rjygly8lP4eE9JY0NrqX
         ZDftsEbRC+6BtlHwHLPc642iM+LSxB/fXBkR/JGy1YWeVlLZdujpASm3NvJkvZwuuY2J
         uC/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707123915; x=1707728715;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FrzyemCCCe25zosXOoDYB16obaNMd4rjugvPsL9t2Tc=;
        b=YR7AHtjF8GO4B4EV1wYJPNWYYlm9UQYai6Z3DOiTnGf8cu7e9gBFUFbrHH2oSilhKb
         8wyP+IdEA+jfD4cwjDT3iCpOfHtWC2J+SiixUzCYl8xndhnmSauDX7HNsLLnGF96fDSD
         xTR0Yw23/gvIxEu8GS5JybG7QMxXtjDu0JnHsNHljumMGmWlOh+ZwexlMiY2VCMDpQM5
         1CT/fjdsK/dnmD7mHBbmi5hWMV9hcxKpujjMUHtJotg4LKOmtdUsVQIiuVJDgTCJZu3x
         t5XyK712foUwgRkhZAkoQ411s0KJJv3UM3d0KRfZiv5pYv8RM4+aIyG0gvJlCeZv1O0O
         yA8A==
X-Gm-Message-State: AOJu0Yzs7ohqZnde3mcreR/0zjFma/l3wWwITSsae6fshoa7VUt74/Ly
	7vT4PlwlCCbEgLBnzekP/8v/TBWP11scJQjXwE4Ccgjuynz+W7GTG5gQopV6mRY=
X-Google-Smtp-Source: AGHT+IG52hmC5Eu0sn2V0dkLHe/o74ig7s+Lp2f9Gnes0yU8mdwBjfMoRc4d5bnf/qpdhfHC23lgYg==
X-Received: by 2002:a7b:cd85:0:b0:40e:fa6b:f355 with SMTP id y5-20020a7bcd85000000b0040efa6bf355mr4202944wmj.41.1707123915229;
        Mon, 05 Feb 2024 01:05:15 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCX7Wqy/vaUuoF/84sU2+37uNkcfW0D2VCaoFNsTSZi4e3JJEHKNwI+us6HkHjkYhwNaV5JILIKpnQrvUoG+vj+nBRSXfWhLuT1oQDOMLlTKIt77g2J8TfZ0WjBKxk9MEFPAIq4YAUGWuTJwJClAwRQTEOqLyJTmj4CZQ16p2SaLVx+ooRoppxNZO7MW9ue09hSQzl5Y1rdyaabmK0aMd5l4DdacudoB1InieW+d1kF0KxKdE5m13iR9mHcTD9SMvgpNYidAHQoxxndHA0idnQffXO8gKa/GQS5JytIIb20FZb3IK7HwewdhN2Wh/N4RexHqx0hPg6sb9fsKGZAx9/9h9SDwUvmBrMhhWmT9sY6JqVxfrJm8y7qQuN4IyAZzccwvRgL8CII3j804eaqFlCcv1HkXcmHaD0gvaGXtZt4LMt+sBzA6Bm7rAaYzeABxbhF0ZKcCaYm/iHBoKq7m3BuG
Received: from localhost ([2a01:e0a:3c5:5fb1:455:1a2b:40a2:1766])
        by smtp.gmail.com with ESMTPSA id fm24-20020a05600c0c1800b0040ee8765901sm8029761wmb.43.2024.02.05.01.05.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Feb 2024 01:05:14 -0800 (PST)
References: <20240202172537.1.I64656c75d84284bc91e6126b50b33c502be7c42a@changeid>
User-agent: mu4e 1.10.8; emacs 29.1
From: Jerome Brunet <jbrunet@baylibre.com>
To: Igor Prusov <ivprusov@salutedevices.com>
Cc: jbrunet@baylibre.com, neil.armstrong@linaro.org,
 kernel@salutedevices.com, prusovigor@gmail.com, Kevin Hilman
 <khilman@baylibre.com>, Martin  Blumenstingl
 <martin.blumenstingl@googlemail.com>, Michael Turquette
 <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>,
 linux-amlogic@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] clk: meson: Add missing clocks to axg_clk_regmaps
Date: Mon, 05 Feb 2024 10:02:01 +0100
In-reply-to: <20240202172537.1.I64656c75d84284bc91e6126b50b33c502be7c42a@changeid>
Message-ID: <1j7cjji8mu.fsf@starbuckisacylon.baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain


On Fri 02 Feb 2024 at 17:25, Igor Prusov <ivprusov@salutedevices.com> wrote:

> Some clocks were missing from axg_clk_regmaps, which caused kernel panic
> during cat /sys/kernel/debug/clk/clk_summary
>
> [   57.349402] Unable to handle kernel NULL pointer dereference at virtual address 00000000000001fc
> ...
> [   57.430002] pstate: 60000005 (nZCv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
> [   57.436900] pc : regmap_read+0x1c/0x88
> [   57.440608] lr : clk_regmap_gate_is_enabled+0x3c/0xb0
> [   57.445611] sp : ffff800082f1b690
> [   57.448888] x29: ffff800082f1b690 x28: 0000000000000000 x27: ffff800080eb9a70
> [   57.455961] x26: 0000000000000007 x25: 0000000000000016 x24: 0000000000000000
> [   57.463033] x23: ffff800080e8b488 x22: 0000000000000015 x21: ffff00000e7e7000
> [   57.470106] x20: ffff00000400ec00 x19: 0000000000000000 x18: ffffffffffffffff
> [   57.477178] x17: 0000000000000000 x16: 0000000000000000 x15: ffff0000042a3000
> [   57.484251] x14: 0000000000000000 x13: ffff0000042a2fec x12: 0000000005f5e100
> [   57.491323] x11: abcc77118461cefd x10: 0000000000000020 x9 : ffff8000805e4b24
> [   57.498396] x8 : ffff0000028063c0 x7 : ffff800082f1b710 x6 : ffff800082f1b710
> [   57.505468] x5 : 00000000ffffffd0 x4 : ffff800082f1b6e0 x3 : 0000000000001000
> [   57.512541] x2 : ffff800082f1b6e4 x1 : 000000000000012c x0 : 0000000000000000
> [   57.519615] Call trace:
> [   57.522030]  regmap_read+0x1c/0x88
> [   57.525393]  clk_regmap_gate_is_enabled+0x3c/0xb0
> [   57.530050]  clk_core_is_enabled+0x44/0x120
> [   57.534190]  clk_summary_show_subtree+0x154/0x2f0
> [   57.538847]  clk_summary_show_subtree+0x220/0x2f0
> [   57.543505]  clk_summary_show_subtree+0x220/0x2f0
> [   57.548162]  clk_summary_show_subtree+0x220/0x2f0
> [   57.552820]  clk_summary_show_subtree+0x220/0x2f0
> [   57.557477]  clk_summary_show_subtree+0x220/0x2f0
> [   57.562135]  clk_summary_show_subtree+0x220/0x2f0
> [   57.566792]  clk_summary_show_subtree+0x220/0x2f0
> [   57.571450]  clk_summary_show+0x84/0xb8
> [   57.575245]  seq_read_iter+0x1bc/0x4b8
> [   57.578954]  seq_read+0x8c/0xd0
> [   57.582059]  full_proxy_read+0x68/0xc8
> [   57.585767]  vfs_read+0xb0/0x268
> [   57.588959]  ksys_read+0x70/0x108
> [   57.592236]  __arm64_sys_read+0x24/0x38
> [   57.596031]  invoke_syscall+0x50/0x128
> [   57.599740]  el0_svc_common.constprop.0+0x48/0xf8
> [   57.604397]  do_el0_svc+0x28/0x40
> [   57.607675]  el0_svc+0x34/0xb8
> [   57.610694]  el0t_64_sync_handler+0x13c/0x158
> [   57.615006]  el0t_64_sync+0x190/0x198
> [   57.618635] Code: a9bd7bfd 910003fd a90153f3 aa0003f3 (b941fc00)
> [   57.624668] ---[ end trace 0000000000000000 ]---
>
> Signed-off-by: Igor Prusov <ivprusov@salutedevices.com>

This has gone un-noticed for a while :/
Thanks Igor.

Please remember to add an appropriate Fixes tag for patches like this.
It is important to help stable releases.

Fixes: 14ebb3154b8f ("clk: meson: axg: add Video Clocks")

> ---
>
>  drivers/clk/meson/axg.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/clk/meson/axg.c b/drivers/clk/meson/axg.c
> index c12f81dfa674..5f60f2bcca59 100644
> --- a/drivers/clk/meson/axg.c
> +++ b/drivers/clk/meson/axg.c
> @@ -2142,7 +2142,9 @@ static struct clk_regmap *const axg_clk_regmaps[] = {
>  	&axg_vclk_input,
>  	&axg_vclk2_input,
>  	&axg_vclk_div,
> +	&axg_vclk_div1,
>  	&axg_vclk2_div,
> +	&axg_vclk2_div1,
>  	&axg_vclk_div2_en,
>  	&axg_vclk_div4_en,
>  	&axg_vclk_div6_en,


-- 
Jerome

