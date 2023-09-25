Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF5037AD65F
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 12:48:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229863AbjIYKst (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 06:48:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229787AbjIYKsn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 06:48:43 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92966C6
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 03:48:36 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5213FC433C9;
        Mon, 25 Sep 2023 10:48:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695638915;
        bh=/LefVaK2r6dhjQD0FjoLJlEhyV3w7+sO/UDevvSJ9KA=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=W37ZhtByQB0sL6ztZ7emAQjxn1oWW/Y46gP91TnoZEQ4UGkZnmMBg1HRmFArrJaQT
         a1y9JCbItkVfSjvWLzjBYWaU9vw5z+TgOjyj+AlFFFylz/+Ifs6gpdJ1Vai2+N0TTV
         8ZfCfxCRi9VIVuBZ3CSGKnbwujqc1mkpzGJ54g3sZ9qHEzvDKaSEb3J/z6+GHaaHjS
         7KcMdd6cycyY9fkrHlRWUzLlIlLMPhUqvvxmU1nIX/HIH82JvJPZRzeeujhRdxcvTe
         QV809Ca5xMW+rG0OsWxtO+mynLG88dyuIy4JXSCZUa0Q4fzIfuLMX1tq3UTNRDEyI5
         cB9bprRO16g6Q==
From:   Robert Foss <rfoss@kernel.org>
To:     David Airlie <airlied@gmail.com>, Xin Ji <xji@analogixsemi.com>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Jonas Karlman <jonas@kwiboo.se>
Cc:     hsinyi@chromium.org, bliang@analogixsemi.com,
        qwen@analogixsemi.com, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230922093450.3574349-1-xji@analogixsemi.com>
References: <20230922093450.3574349-1-xji@analogixsemi.com>
Subject: Re: [PATCH v2] drm/bridge: Add 200ms delay to wait FW HPD status stable
Message-Id: <169563891302.3680913.670156571122914627.b4-ty@kernel.org>
Date:   Mon, 25 Sep 2023 12:48:33 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.10.1
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 22 Sep 2023 17:34:49 +0800, Xin Ji wrote:
> For the no-interrupt design (sink device is panel, polling HPD
> status when chip power on), anx7625 FW has more than 200ms HPD
> de-bounce time in FW, for the safety to get HPD status, driver
> better to wait 200ms before HPD detection after OS resume back.
> 
> 

Applied, thanks!

[1/1] drm/bridge: Add 200ms delay to wait FW HPD status stable
      https://cgit.freedesktop.org/drm/drm-misc/commit/?id=330140d7319f



Rob

