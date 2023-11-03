Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6A2A7E0055
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Nov 2023 11:29:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346996AbjKCJY3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Nov 2023 05:24:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347010AbjKCJY1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Nov 2023 05:24:27 -0400
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [81.169.146.167])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FE7ED50;
        Fri,  3 Nov 2023 02:24:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1699003458; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=GKhEhc9fuAGxCPvn0OUpgiyGm/vrq/Wvqjmott3WRhZn0LkD4UJZVWTDCFe/9rIjx+
    FzMZKFqBE6gVzyF+7sYF8IL8awZzgOUyLkojo0vXOvTWaDswdqDRtpP1X6s4UXZuduB3
    2upqFv3fPhmwRmeZiCMWuNbEJvtfY8R3x4CXpbowgMnrsOTBokVcp6UTciNuUiFUSQeC
    cxz0VV+y9iKEooICabbXw5fFKeOD7L8OoCFp187Yw27KKxAa62H97G/NbTmqF9/aUy+y
    bygiJEGWn0RT0uUW81VgZ/xPLputMgY5csHjzNmn8BTrxo3cQn0qOnn2P/fDE5NgK47c
    oukw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1699003458;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=panjHvmhHlKR5Tkzdso//74lQRh4FS57QtoM0h4NJ6g=;
    b=dD88eMl3NtdIdxGpPfYTqZv6QnH4JMx0s99tu+4u/mhO6+6tQ751hMJrSx/PzsoiCk
    VgUdn1CDkMY+6ZGsm3KQZhP85hJvLr6rPvIAfG9JzkxaOeBxbZkuU+thea5nLgOlNhLQ
    zigeDaF6ZEAr+ZeMjgIsQNjXrwTor1WrnAYokaF0Y1Y1MXDNG4cYUcoufEhVE6N03434
    ePOmVDsimdGRP4NvbUUJvsb4mzOL4gkUBcDXoL6iddboC5zKV30k/s+HYXwDxzVYh9LE
    YuBj8g/D5Sb6I24p+QJ/hx196Hn0KAGlQ+L5alpRUNtHspBLLazJDRorDs+bZOC4ZvDP
    iMBg==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1699003458;
    s=strato-dkim-0002; d=gerhold.net;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=panjHvmhHlKR5Tkzdso//74lQRh4FS57QtoM0h4NJ6g=;
    b=tfgak9uUOkO5QZpU6NQ+UIkZ/7aEbNTUIkgkmWFlEuo93wqHPzDfnqhfdbduNPq0Q+
    1ltFt10095uUtXiKFQzeilQz3nwUw0hNNuNT6DkbiPK3g5fwtWrKkxRjligY6Crh1e9+
    mbh47zTspT5U5QkCcrrNq3O+k7IWwtbAqPtf/6uf3lCm7hItFdrwcL3PBehKoH2xMqoZ
    JU+H6WsyVO/PRJ3Ij3Gjd32Op2Y6s7zL4v1KzaobyRDh0durwDiBHwgHTNNp7fObmv+p
    7NKgNMCxmJrfEgyMW+ceu/Oy4tqpq81neE6tPp/++NWLCWBpMvMx7OKZwlJGYwfx5k+2
    MWJA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1699003458;
    s=strato-dkim-0003; d=gerhold.net;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=panjHvmhHlKR5Tkzdso//74lQRh4FS57QtoM0h4NJ6g=;
    b=2zlNwS+eVl/msYpE8lBbocy7BxUccc0Cjp/JiiBPaDqMCT2Td3yVEsb6YHMcmSGTYn
    z8p37FU/272Ji0wr0ZBw==
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVOQ/OcYgojyw4j34+u261EJF5OxJD4paA8Z2L1A=="
Received: from gerhold.net
    by smtp.strato.de (RZmta 49.9.1 DYNA|AUTH)
    with ESMTPSA id Lbb8e2zA39OHOuj
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Fri, 3 Nov 2023 10:24:17 +0100 (CET)
Date:   Fri, 3 Nov 2023 10:24:08 +0100
From:   Stephan Gerhold <stephan@gerhold.net>
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Nishanth Menon <nm@ti.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Viresh Kumar <vireshk@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Stephan Gerhold <stephan.gerhold@kernkonzept.com>,
        linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2 0/3] OPP: Simplify required-opp handling
Message-ID: <ZUS8OC6tY4sxS5RA@gerhold.net>
References: <cover.1698661048.git.viresh.kumar@linaro.org>
 <20231103052854.bc7jqaubc5uj6ncj@vireshk-i7>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231103052854.bc7jqaubc5uj6ncj@vireshk-i7>
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 03, 2023 at 10:58:54AM +0530, Viresh Kumar wrote:
> On 30-10-23, 15:54, Viresh Kumar wrote:
> > I wasn't able to test this locally (despite trying to hack it around) and need
> > help from someone who is `virt_devs` field of `struct dev_pm_opp_config`.
> > 
> > Pushed here:
> > 
> > git://git.kernel.org/pub/scm/linux/kernel/git/vireshk/pm.git opp/required-opps
> > 
> > V1->V2:
> > - Support opp-level 0, drop vote i.e..
> > - Fix OPP pointer while calling dev_pm_opp_set_opp() recursively.
> > - Minor checks and fixes.
> > - Add Reviewed-by from Ulf.
> 
> Stephan, Ulf,
> 
> Any feedback on this before I merge it ?
> 

Sorry for the delay. I tested this successfully on the MSM8909 board on
Wednesday (with the single genpd, and without opp-level 0 there), but
until now didn't find time to test it on the MSM8916 board with the
multiple genpds and the opp-level 0.

The opp-level 0 works fine now, thanks for fixing that!

The warning in _link_required_opps() when using the parent genpd setup
[1] is still present though. Given that this setup is an existing
feature in the genpd core I would appreciate if we try to find a
solution before merging this patch set. It's kind of a regression
otherwise since the warning isn't present without this patch set.
Maybe someone else is already actively using such a setup.

Thanks!
Stephan

[1]: https://lore.kernel.org/linux-pm/ZTkciw5AwufxQYnB@gerhold.net/
