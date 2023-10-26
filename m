Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8D4F7D7FF9
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 11:49:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231311AbjJZJt1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Oct 2023 05:49:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230257AbjJZJt0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 05:49:26 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E945B191;
        Thu, 26 Oct 2023 02:49:23 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F324C433C8;
        Thu, 26 Oct 2023 09:49:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698313763;
        bh=ncOp1N3ea9kk7KOsgsA6VBFVmgEpZN509tgZREJl3nI=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=nYXOeX9DvwUB+3aK3+/M2o7umYxQkiX614IgM/dz6QQUgLin0rb/tevRZ5GKkNAFQ
         qvVgvbclmMTkgbU7mFfK2UaWXDDz54TyUV+B126gobsPLpP6BbW/gASlmmCmpXC8Kf
         IMP6Yq1/B//x3DS6NM3vSLnh7sHcfYVBLkoMgV1Y0N0K9FkD/jRYy74jAzJvpJqbdF
         2qQd3WuJUrlch/+kJVNo7me+AqaIx+KIg7EsauYZtErmrveOhXoVhRr7VOSfZ9sW6e
         kON1WQhgi/1UrkGISBe7RuW2QbbdS6jpg7CpgHPzsINfXGL/CsbviAx6PbyvEq0Rt/
         GwJp7g3bvdzXg==
From:   Kalle Valo <kvalo@kernel.org>
To:     Philipp Hortmann <philipp.g.hortmann@gmail.com>
Cc:     Witold Baryluk <witold.baryluk@gmail.com>, arnd@kernel.org,
        Larry.Finger@lwfinger.net, alexandre.belloni@bootlin.com,
        arnd@arndb.de, claudiu.beznea@tuxon.dev, davem@davemloft.net,
        geert@linux-m68k.org, geoff@infradead.org,
        gregkh@linuxfoundation.org, gregory.greenman@intel.com,
        ilw@linux.intel.com, johannes@sipsolutions.net, kuba@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-staging@lists.linux.dev, linux-wireless@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, nicolas.ferre@microchip.com,
        pavel@ucw.cz, quic_jjohnson@quicinc.com, stas.yakovlev@gmail.com,
        stf_xl@wp.pl
Subject: Re: [PATCH 10/10] [RFC] wifi: remove ipw2100/ipw2200 drivers
References: <CAEGMnwo6RFqADPO5FRkRUNL=GfV6DY8UuwgsypEYOD3LTnXdJg@mail.gmail.com>
        <c608f328-387e-431b-b3c2-4b8fa0c4f11f@gmail.com>
Date:   Thu, 26 Oct 2023 12:49:16 +0300
In-Reply-To: <c608f328-387e-431b-b3c2-4b8fa0c4f11f@gmail.com> (Philipp
        Hortmann's message of "Thu, 26 Oct 2023 00:48:18 +0200")
Message-ID: <87jzr9d883.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Philipp Hortmann <philipp.g.hortmann@gmail.com> writes:

> On 10/26/23 00:27, Witold Baryluk wrote:
>> I might be interested in modernizing the driver, but I have no idea
>> how much effort it would be (in terms of changed fraction of code).
>> 20k LOC is neither small or big, and not obvious (a lot of it would
>> be unchanged), if it is a week of work, or months of work.
>
> Hi Witold,
>
> I am trying to do this with rtl8192e.
> One possibility is to take the following patch series as a starting point:
> https://yhbt.net/lore/all/1414604649-9105-1-git-send-email-tvboxspy@gmail.com/
>
> For me as a beginner and hobbyist this is a huge task. I am happy when
> I can finish it until next summer.

We also have some docs available:

https://docs.kernel.org/driver-api/80211/

And I also recommend looking at our hwsim driver as that gives a good
idea how a simple mac80211 driver works:

https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless-next.git/tree/drivers/net/wireless/virtual/mac80211_hwsim.c

And you can even tinker the driver and run tests without needing any
real hardware:

https://docs.kernel.org/networking/mac80211_hwsim/mac80211_hwsim.html

And if there are any questions about mac80211 or anything wireless
related please send them to linux-wireless. Usually someone will answer
as long the question is well formulated.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
