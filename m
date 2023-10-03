Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 258557B62AC
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 09:44:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230281AbjJCHoZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 03:44:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229835AbjJCHoY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 03:44:24 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2086390;
        Tue,  3 Oct 2023 00:44:21 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id 5b1f17b1804b1-405524e6768so5583545e9.2;
        Tue, 03 Oct 2023 00:44:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696319059; x=1696923859; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L2DSaduBdxObJwWZIFqigN3NqgUJkY9BBZwkTlmZj2E=;
        b=aEwzzkhREJZ1r8YBebW+qRet2zohOlNXB2smdKS7eIVdZ5qxmoqPeEMJQdcYKWqNTj
         Ky0TjLHsQuGAnC2gIhOMJm6+CysbfwtVF3MObj7sF7ZVS07NmiDXAKe9WCjkAzRqmCVj
         iH6vLgKCNnhr8jpjoCXBKDzIg6j1HT9Yk6yN+YcfAjiwG9D6o5ESZaT9Z3XKeHm8/IEw
         FGnVkbkqKojrW2qy7Il9YqIXoxaJReWwuMRfDKOuGXfpHRT8vB6eewuPeO7Svyoua49L
         AFHngtqbuB7CaHUL1B6afNzoOQnFJP+DfnaAljK1wvM3Jd9TnA9rcebt+d8gGPT3sK9x
         lqBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696319059; x=1696923859;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=L2DSaduBdxObJwWZIFqigN3NqgUJkY9BBZwkTlmZj2E=;
        b=J3I/KDgCZixXuTN4xxWP7msxKSfj7q9I+tSuwxjWo0IKhdFHHN/PmyHlHE1BRw6b+J
         ve4+BUUXoPSrqlBmffm7uJpUbDLSxJpFqsk+OWycall4DMrxWjqYA6ccDSBqf21ozFkl
         QpvsZByh3K8HNkElaVjargTykihemVMd2HlVyumHExmN+ud5JK2UEd2VPJ4XTw20gfuw
         Qr2smU3ad+Vtj033QsZFGem6tZRxRvhUN3F6nw/PaHaV50lzKJHqtyjGHzuMSAh3eb1n
         LIbaFcEgI4WK90JX7rqLbcBA0NdIaGCh/La34Bk0o5ZwdvtjXcFptO9A7OyJQJFCCNcO
         pZIA==
X-Gm-Message-State: AOJu0Yy9sbq8FWWmwPzmv0uJ2xjSAtG553NOguoCKjZ7mH/lglR7Dzb8
        39gmFNIIfqtw7ICuX56Y1NE=
X-Google-Smtp-Source: AGHT+IEr8LwIruxc8YTUJJ9Vnl/NXdG9wFPnHmn68t7USWR6R9BFhAVuPuoKUX93lwe5t3dQyh/hkw==
X-Received: by 2002:a05:600c:b59:b0:3ff:233f:2cfb with SMTP id k25-20020a05600c0b5900b003ff233f2cfbmr11346128wmr.23.1696319059238;
        Tue, 03 Oct 2023 00:44:19 -0700 (PDT)
Received: from PCBABN.skidata.net ([91.230.2.244])
        by smtp.gmail.com with ESMTPSA id f14-20020a7bc8ce000000b00402d34ea099sm8679088wml.29.2023.10.03.00.44.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Oct 2023 00:44:18 -0700 (PDT)
From:   Benjamin Bara <bbara93@gmail.com>
To:     mripard@kernel.org
Cc:     aford173@gmail.com, bbara93@gmail.com, benjamin.bara@skidata.com,
        frank@oltmanns.dev, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, mturquette@baylibre.com,
        sboyd@kernel.org
Subject: Re: [PATCH RFC 0/4] clk: re-set required rates during clk_set_rate()
Date:   Tue,  3 Oct 2023 09:44:07 +0200
Message-Id: <20231003074407.2856447-1-bbara93@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cjow276e3hsgtaqq6e2lzv3xdxyssoh34wan7lcwunh636wsqv@35eyi5cvbbwd>
References: <cjow276e3hsgtaqq6e2lzv3xdxyssoh34wan7lcwunh636wsqv@35eyi5cvbbwd>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Maxime,

thank you for the feedback!

On Mon, 2 Oct 2023 at 14:27, Maxime Ripard <mripard@kernel.org> wrote:
> There's a couple of things you didn't reply on the first version and
> you didn't really expand it here:

Sorry for that, wanted to get the reduced series out first to have a
better discussion base. Planned to reply to them and link to the
spin-off later, probably should have mentioned that :/ Thanks for
summarizing!

> Most clocks don't care, and only the clocks that have used
> clk_set_rate_exclusive actually care.

I think that is one of the main points I don't understand yet... Why? I
mean, the point of calling clk_set_rate() is to get a certain rate for a
clock, right? Why should the clock not care if it is changed to
something completely different? Maybe I am a bit biased here because I
use the imx8mp as a reference. On this platform, most hardware blocks
have an own divider and therefore the clocks which are connected to the
blocks are mostly "exclusive". E.g. the tree for a panel looks like
this:
-osc_24m (oscillator)
-- video_pll1_ref_sel (mux)
--- video_pll1 (configurable; shared)
---- video_pll1_bypass (mux; shared)
----- video_pll1_out (gate; shared)
------ media_disp2_pix (divider; "panel exclusive")
------- media_disp2_pix_root_clk (gate; "panel exclusive")
-------- <PANEL>

> clk_set_rate never provided that guarantee, you're effectively merging
> clk_set_rate and clk_set_rate_exclusive.

Ah, I guess I see what you mean... Since we would error out now on a
"conflict", this becomes very close to the "exclusiveness concept".
However, what I actually try to achieve is to leave the rest of the
subtree unaffected by a change (if required and possible).

> This might or might not be a good idea (it's probably not unless you
> want to track down regressions forever), but we should really tie this
> to clk_set_rate_exclusive or merge both.

I see that the current "conflict handling" might fit very well for
clk_set_rate_exclusive(). However, I think it's pretty hard to use
clk_set_rate_exclusive() in a multi-platform driver, as the other
competing consumers are not known. But maybe it makes sense to have the
same path and decide on a conflict whether we are allowed to do the
change or not (exclusive/protected).

> Why do we need a new req_rate, and why req_rate can't be changed to
> accomodate your changes.

For me, the existing req_rate is a "persistent" rate. It is the rate a
consumer requires the clock to have. It's something typically for leaves
of the clock-tree, which are directly connected to (probably
multi-platform) clock-consuming blocks, e.g. the dividers mentioned.
The new req_rate is "temporary". It is rather important for the !leaves
and indicate that a clock is required to change during this
clk_set_rate() call, in order to fulfill the requested rate.

Short example, let's say we have something like this:
- Video PLL
-- LVDS divider
--- LVDS bridge (HW block)
-- CRTC divider
--- Panel (HW block)

From a hardware-description point of view, the CRTC divider is exclusive
to the panel and the LVDS divider exclusive to the LVDS bridge. However,
the Video PLL is not the only possible parent of both and it should also
not be set exclusively by one of them.

When a CRTC rate of 35M is required by the panel, it would be set to the
following:
- Video PLL:     req_tmp=35M, req=-1,  new=35M
-- LVDS divider: req_tmp=-1,  req=-1,  new=35M (div=1)
-- CRTC divider: req_tmp=35M, req=35M, new=35M (div=1)

Next, the LVDS bridge requires 245M, which would be a multiple of
35M. The Video PLL is configured again, this time "by" the LVDS divider:
- Video PLL:     req_tmp=245M, req=-1,   new=245M
-- LVDS divider: req_tmp=245M, req=245M, new=245M (div=1)
-- CRTC divider: req_tmp=-1,   req=35M,  new=245M (div=1)

So without additional interaction (current behaviour), we would set the
CRTC divider to 245M, which contradicts with the unchanged previous
requirement stored in req. As req_tmp == -1, we know that the new rate
of the CRTC divider is not crucial for the actual requested change (LVDS
=> 245M). Therefore, what I would like to achieve is to have some
component/process that tells the CRTC divider to set its div to 7, as
this won't affect the ongoing requested change and would restore a
required rate of a different component, which was changed "unintended".

> Why do you even need the core to be involved in the first place? You
> say you think it does, but you haven't answered any of my mails to
> provide more details and figure out if we can do it without it.

We already have this functionality (calc required new rates) inside the
core and the core currently is the only one knowing all the context
about the tree-structure and the required and new rates. So I think in
the example above, calling calc_new_rates() again, this time with the
CRTC divider and req, might be the simplest solution to the problem.

I think as the Video PLL isn't directly consumed, we don't really have a
different possibility to achieve the same outcome, except of starting
Video PLL already with 245M (e.g. via device-tree).

Just for the sake of completeness:
A "conflict" occurs if this call would try to re-configure Video PLL
again (if req_tmp is already set; by not involving req here, we
basically avoid the "exclusiveness"). IMO, there are different ways to
proceed on a conflict: A possible clk_set_rate() option would be to
ignore a potential re-change of Video PLL by the second calc_new_rates()
and just set a somewhat close to the req rate for CRTC divider. A
possible clk_set_rate_exclusive() option is the one implemented here:
error out if we cannot guarantee the existing required rates for the
rest of the subtree.

Thanks & regards
Benjamin
