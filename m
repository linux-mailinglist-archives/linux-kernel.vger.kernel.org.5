Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCAF87A503F
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Sep 2023 19:02:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231297AbjIRRCl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 13:02:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229520AbjIRRCh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 13:02:37 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E4DB8E;
        Mon, 18 Sep 2023 10:02:32 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18049C32783;
        Mon, 18 Sep 2023 14:28:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695047303;
        bh=cVt3BSeAbCgVpGd6WsEDtgkVPihUYdejvLe8R1O+i1g=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=oujQRKR3JJRDQPQnBYyL9Mg1kpOvs+cB33amTS3eFRjjqd1ZG90xTJeuoCIljLWSh
         77WZKkUjudUGRZIgu3zj8S3mVt8EOKLZYDjtT05yhKmY7IfiIxZLbLhCC8AruV3ojg
         UMhQ8RsJVZBstLuk0jUp5BH0orKiLeSIezkoh/b26DFLv6yZlsFbPy+66G54AQ3sO5
         6wfuro4Idxl2oYwUqrRAifR5IZOQdnnjV/JhDh9fm1EKl4Ox8JjFOAuH26AFjEs5pY
         zOds9b6vC4jPfASTBfTap1B9zqOOL9Fn2sbFEgLN7ARf0r6uZ12mYb7JLJwRvgSpyT
         dZudbPpR/4joA==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v3 1/2] wifi: cw1200: Avoid processing an invalid TIM IE
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20230831-ieee80211_tim_ie-v3-1-e10ff584ab5d@quicinc.com>
References: <20230831-ieee80211_tim_ie-v3-1-e10ff584ab5d@quicinc.com>
To:     Jeff Johnson <quic_jjohnson@quicinc.com>
Cc:     <kernel@quicinc.com>,
        =?utf-8?q?Toke_H?= =?utf-8?q?=C3=B8iland-J=C3=B8rgensen?= 
        <toke@toke.dk>, "Christian Lamparter" <chunkeey@googlemail.com>,
        Stanislaw Gruszka <stf_xl@wp.pl>,
        "Helmut Schaa" <helmut.schaa@googlemail.com>,
        Ping-Ke Shih <pkshih@realtek.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        <linux-wireless@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <netdev@vger.kernel.org>, Jeff Johnson <quic_jjohnson@quicinc.com>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <169504729816.740666.17271538419199878496.kvalo@kernel.org>
Date:   Mon, 18 Sep 2023 14:28:19 +0000 (UTC)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Johnson <quic_jjohnson@quicinc.com> wrote:

> While converting struct ieee80211_tim_ie::virtual_map to be a flexible
> array it was observed that the TIM IE processing in cw1200_rx_cb()
> could potentially process a malformed IE in a manner that could result
> in a buffer over-read. Add logic to verify that the TIM IE length is
> large enough to hold a valid TIM payload before processing it.
> 
> Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>

Patch applied to wireless-next.git, thanks.

b7bcea9c27b3 wifi: cw1200: Avoid processing an invalid TIM IE

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20230831-ieee80211_tim_ie-v3-1-e10ff584ab5d@quicinc.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

