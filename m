Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C42967BD3CF
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 08:53:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345255AbjJIGxo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 02:53:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234202AbjJIGxm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 02:53:42 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95F48A3;
        Sun,  8 Oct 2023 23:53:41 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E0A5C433C7;
        Mon,  9 Oct 2023 06:53:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696834421;
        bh=Ou978eSAT3Bd15YEWuzFJAGjPe+8cG1d3P2RihzVcsM=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=RsYkMTXtygwPp457b0EM3YfNvfh2wlBhmg3S6W0DJTPASPz3ZoH91lQjsv1FGXEQ6
         sLY0u9K5VJkht47xdLesENZQng6lA5ZmhTRerilBtvUdWTzHwj5OPyq3jtfae+0Bm0
         oseKqkWHxM2u3dKaQStX0jXBINiXSe5gVt6F5JGWb4ctdKL+gdhaQ2Uw1l1QTDEE+G
         quXMEz1BwkeCp6ObrKpHSp6hQd5R5BG2xtR8pK0y3z6OXXzZ7NbEe0TAffBHcjzUJn
         Y1FHxQft28k3Swyb0JeCPtpM0qZzErKT06MSX7OmMQBjmZR3h28wX6azwp17O8Tt7H
         SMIroUuUPVs8g==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v3 1/8] wifi: wfx: fix power_save setting when AP is
 stopped
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20231004172843.195332-2-jerome.pouiller@silabs.com>
References: <20231004172843.195332-2-jerome.pouiller@silabs.com>
To:     =?utf-8?b?SsOpcsO0bWUgUG91aWxsZXI=?= <jerome.pouiller@silabs.com>
Cc:     linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?utf-8?b?SsOpcsO0bWUgUG91aWxsZXI=?= <jerome.pouiller@silabs.com>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <169683441797.2071896.13428503955043948509.kvalo@kernel.org>
Date:   Mon,  9 Oct 2023 06:53:40 +0000 (UTC)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jérôme Pouiller  <jerome.pouiller@silabs.com> wrote:

> The WF200 allow to start two network interfaces (one AP, one station) on
> two different channels. Since magic does not exist, it only works if the
> station interface enables power save.
> 
> Thus, the driver detects this case and enforce power save as necessary.
> 
> This patch fixes the case where the AP interface is stopped and it is no
> more necessary to enforce power saving on the station interface.
> 
> Signed-off-by: Jérôme Pouiller <jerome.pouiller@silabs.com>

8 patches applied to wireless-next.git, thanks.

8b27aed225ca wifi: wfx: fix power_save setting when AP is stopped
94c104d51830 wifi: wfx: relocate wfx_rate_mask_to_hw()
cf0cc05c8c23 wifi: wfx: move wfx_skb_*() out of the header file
fc5cb24fd50e wifi: wfx: introduce hif_scan_uniq()
f091bcb62dc6 wifi: wfx: simplify exclusion between scan and Rx filters
04106ec5bb02 wifi: wfx: scan_lock is global to the device
f7385a20249e wifi: wfx: allow to send frames during ROC
fc627dad3f01 wifi: wfx: implement wfx_remain_on_channel()

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20231004172843.195332-2-jerome.pouiller@silabs.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

