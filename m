Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19F3A7C4DBD
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 10:55:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345633AbjJKIzs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 04:55:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230256AbjJKIzq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 04:55:46 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2617294;
        Wed, 11 Oct 2023 01:55:45 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9DF52C433C7;
        Wed, 11 Oct 2023 08:55:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697014544;
        bh=ypmKXRXN1bDbe6BFnY52JOMJEHn4p1Ml9jjg3Cls6yQ=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=S36I6tTLRNWWOyYJERZnEvDfdRdM5VZ2cY4TzOEtzhPF1BK1XQnusUKKdgYtXNYtF
         EYOKfZV6P6Y87HZ0Ol7jRG/4flF4wl9ah7+cZQjoctR+qT9L3LLTN+WN8RICEhgCGH
         G4r8vbPwdi8tm6fEv35Q7FtIy/m68ZfEocHGrQsyxUj5+ZrvFkQN6yOR69hd+ETv+w
         vik3NwzMmxk7CPqFjrZgYZKQwUh6TwnuCR19sBsk5veZMEf8IZ/NJdwOX8Qukhn5b3
         MttLjUgBZVrE1ihjmfpoDcvNSGaYtG8+FwQeP8vfVPnG8AiECFVzXiW/IcwHuZr3B5
         b8JQoJZmsIDKw==
From:   Kalle Valo <kvalo@kernel.org>
To:     Ma Ke <make_ruc2021@163.com>
Cc:     quic_jjohnson@quicinc.com, ath12k@lists.infradead.org,
        linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] wifi: ath12k: call ath12k_mac_fils_discovery() without
 condition
References: <20231011072950.4097927-1-make_ruc2021@163.com>
Date:   Wed, 11 Oct 2023 11:55:41 +0300
In-Reply-To: <20231011072950.4097927-1-make_ruc2021@163.com> (Ma Ke's message
        of "Wed, 11 Oct 2023 15:29:50 +0800")
Message-ID: <87mswp4jxu.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ma Ke <make_ruc2021@163.com> writes:

> Mac80211 does not set flags BSS_CHANGED_FILS_DISCOVERY and
> BSS_CHANGED_UNSOL_BCAST_PROBE_RESP if there are no updates to
> FILS discovery and unsolicited broadcast probe response transmission
> configurations respectively. This results in the transmissions getting
> stopped during BSS change operations which do not include these
> attributes. Remove the checks for the flags and always send the existing
> configuration to firmware.
>
> Signed-off-by: Ma Ke <make_ruc2021@163.com>

This looks almost identical to Aloka's patch:

wifi: ath12k: call ath12k_mac_fils_discovery() without condition

https://git.kernel.org/netdev/net-next/c/43a10990404f

What's happening here?

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
