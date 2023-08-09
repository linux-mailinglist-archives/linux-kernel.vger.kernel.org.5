Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D27EB7765B3
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 18:56:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231936AbjHIQ4C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 12:56:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230006AbjHIQ4A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 12:56:00 -0400
Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com [64.147.123.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB8FC128;
        Wed,  9 Aug 2023 09:55:58 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.west.internal (Postfix) with ESMTP id 75ACE32002E2;
        Wed,  9 Aug 2023 12:55:56 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Wed, 09 Aug 2023 12:55:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjusaka.me; h=
        cc:cc:content-transfer-encoding:content-type:content-type:date
        :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to; s=fm3; t=
        1691600155; x=1691686555; bh=7vzzVEDSeHlRi7xlJ/WW08Kp20PglUbojme
        4tOli+Yc=; b=I93U6tUfadoxnbfepuQCB8YBW077TiHdBM+WfdVfX8xgEF1DIXF
        JMv8s7FqE8bmF80GKOOnWVN+RLgqz+5NrFEgccENN5R3q1BgurRw2HpZKPgn+rXE
        Y/o3vEmEqPX6X3HfEUQfIAJuem1HFd56LuwAjWL1nNkcC5wiD+R0DAFtlQv8/qG3
        BjQeN6qu+1872K8ReaeHWPr1yei/zx5yyrjG+e1uiGmf50lQ2jo1tNK1HXMKd6qs
        LrURsQMFYSy+KunrzJLFyLiFnfEajddtvpTMIuYYPeR27aSH9qfDkvLwtcybr/Rk
        vaAxPj7OOdby/xJmESXRPB1q431KiaruAIA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
        1691600155; x=1691686555; bh=7vzzVEDSeHlRi7xlJ/WW08Kp20PglUbojme
        4tOli+Yc=; b=QhhbYH1V0k5bXf0+ijt9B/nTFQyg8OmoYW9R6H0PfjXnAuME6/B
        xC9XJTQytOfgcgH6SdghElu3YYZntiQxq/uOjzPW5KvAt2pF/ts2QKhMf0JSXp4d
        4iT9c3jYP5YF5sBcxbWdnIBj0TNSGdIavviYwvqltba7/j8S5yxlai4JCw0v2+NN
        Fn52vtHAgRHK6E0pJijrdIvBesGK6pEOYWO0kWjf0tLypWtsxUVeUCwBky8Yjhw3
        supyTwVGqB6y0OhKUKavinVjVziChYX+mlwEeFs1p8M/EQAlboapCJfFMEOPCWbT
        XjIQQhb8fqW7f2kPb0irsHUIMwHJDnyIXYw==
X-ME-Sender: <xms:G8XTZNJ2b93S16dYbnGNeaAETawzynvCC0hmC8BxW2A7HXLJRV3GQw>
    <xme:G8XTZJJfxFomgm9zoVbbJkFlHk8v2P5qCOXphDH7Js02ktBu2k6CQXIAta6cO3wvu
    CqnEvPOZOL1OGewtUI>
X-ME-Received: <xmr:G8XTZFs1csGuBzywY1FQCjt3Nhr4vHB1lW0sqvOn7I8dgOzxqf4smH1fKt_vO3nNY2JzCJbI6axhdJSVt1Gl4CjEZG9OUNAKvdAlCjxUXs-ug61azAVsmx8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrleeggddutdegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefkffggfgfuvfevfhfhjggtgfesth
    ejredttddvjeenucfhrhhomhepofgrnhhjuhhsrghkrgcuoehmvgesmhgrnhhjuhhsrghk
    rgdrmhgvqeenucggtffrrghtthgvrhhnpeejfeduieefudfftdehkeegieejfeeutedvle
    etieehffejkeduheetuefhjeekkeenucffohhmrghinhepfihikhhiphgvughirgdrohhr
    ghenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehmvg
    esmhgrnhhjuhhsrghkrgdrmhgv
X-ME-Proxy: <xmx:G8XTZOblV1iHb0Sxc9YTDwbqFg3mGFvGBt9sarrjsYfkHzFKlwlecw>
    <xmx:G8XTZEZLRTZCE1Z6JG2S1z5Xo0LtNxvR7kJ9snTjelW6FLXG6P2JKA>
    <xmx:G8XTZCCNkPa38CEQD_HO8qx1rOtSf3TR8v5CY9iqqZLHDE-Vmk-sSQ>
    <xmx:G8XTZBQ7TT6DGDKyyJha5YguQC3oB3Exd8HQsCoKZJYGGNbOsu-gkg>
Feedback-ID: i3ea9498d:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 9 Aug 2023 12:55:51 -0400 (EDT)
Message-ID: <13f5aff8-97c3-4b8c-8d0a-1fb8bdf534ea@manjusaka.me>
Date:   Thu, 10 Aug 2023 00:55:49 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] tracepoint: add new `tcp:tcp_ca_event` trace event
Content-Language: en-US
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     ncardwell@google.com, bpf@vger.kernel.org, davem@davemloft.net,
        dsahern@kernel.org, edumazet@google.com,
        linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        mhiramat@kernel.org, netdev@vger.kernel.org, pabeni@redhat.com,
        rostedt@goodmis.org
References: <CADVnQyn3UMa3Qx6cC1Rx97xLjQdG0eKsiF7oY9UR=b9vU4R-yA@mail.gmail.com>
 <20230808055817.3979-1-me@manjusaka.me> <20230808132124.1a17ea69@kernel.org>
From:   Manjusaka <me@manjusaka.me>
In-Reply-To: <20230808132124.1a17ea69@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/8/9 04:21, Jakub Kicinski wrote:
> On Tue,  8 Aug 2023 05:58:18 +0000 Manjusaka wrote:
>> Signed-off-by: Manjusaka <me@manjusaka.me>
> 
> Is that your name? For Developer's Certificate of Origin
> https://en.wikipedia.org/wiki/Developer_Certificate_of_Origin
> we need something that resembles a real name that'd stand up in court.
Sorry about this, I will update my real name in next patch.
