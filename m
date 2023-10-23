Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB77B7D2DA4
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 11:07:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229802AbjJWJH5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 05:07:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229587AbjJWJHz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 05:07:55 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD1AC98;
        Mon, 23 Oct 2023 02:07:53 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E12B4C433C8;
        Mon, 23 Oct 2023 09:07:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698052073;
        bh=lxhnEyU4sD1CgKW/dGB/BjnL/21YnvGy7vLJvHPK7Js=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=c81gxoGXNHXXcM8q+DtdM8Hs21+Uj7sbe4rCbyxEuPCXtKisGmjprDBxdPB1qCzTw
         IvS6dxuo362BotUt3WtWTLS/wZJFIsq+JfMb3M8HcXZCp+UFsJzTkcvn0hPFnrcJ0v
         Cgt5YTjgdgRPnDjntNeGLRi4ZakKM2Qq5vukrGDdIicJddLCsS3sMkOJ8Gdz1CSBiI
         /wQ8Ig7aGCSypoDSzW4zRAlFk7heqLGrlgLeNB7vUlHiWMmOw+Lzcji4/hWxQ0g+MM
         4b+/Co+CBLFo4k2P8f4H9N63OvK9kdZfUtPO2QrZKdAcLRVyOxFPyjdzwFKYGTQvBH
         DLmCkCHmQF5Gw==
From:   Kalle Valo <kvalo@kernel.org>
To:     David Lin <yu-hao.lin@nxp.com>
Cc:     Francesco Dolcini <francesco@dolcini.it>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "briannorris@chromium.org" <briannorris@chromium.org>,
        Sharvari Harisangam <sharvari.harisangam@nxp.com>,
        Pete Hsieh <tsung-hsien.hsieh@nxp.com>
Subject: Re: [EXT] Re: [PATCH v6 0/6] wifi: mwifiex: added code to support
 host mlme.
References: <PA4PR04MB96388A628D6AB8359D3DAAD0D1DBA@PA4PR04MB9638.eurprd04.prod.outlook.com>
        <ZTKbxe1bAkfRI29V@francesco-nb.int.toradex.com>
        <PA4PR04MB9638847CEC6D16AE53B3875FD1D8A@PA4PR04MB9638.eurprd04.prod.outlook.com>
Date:   Mon, 23 Oct 2023 12:07:49 +0300
In-Reply-To: <PA4PR04MB9638847CEC6D16AE53B3875FD1D8A@PA4PR04MB9638.eurprd04.prod.outlook.com>
        (David Lin's message of "Mon, 23 Oct 2023 02:11:02 +0000")
Message-ID: <874jih1zbu.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

David Lin <yu-hao.lin@nxp.com> writes:

>> From: Francesco Dolcini <francesco@dolcini.it>
>> Sent: Friday, October 20, 2023 11:25 PM
>> To: David Lin <yu-hao.lin@nxp.com>
>> Cc: linux-wireless@vger.kernel.org; linux-kernel@vger.kernel.org;
>> briannorris@chromium.org; kvalo@kernel.org; francesco@dolcini.it; Sharvari
>> Harisangam <sharvari.harisangam@nxp.com>; Pete Hsieh
>> <tsung-hsien.hsieh@nxp.com>
>> Subject: [EXT] Re: [PATCH v6 0/6] wifi: mwifiex: added code to support host
>> mlme.
>>
>> Caution: This is an external email. Please take care when clicking links or
>> opening attachments. When in doubt, report the message using the 'Report
>> this email' button
>>
>>
>> On Fri, Oct 20, 2023 at 03:48:06AM +0000, David Lin wrote:
>> > Patch v6:
>> > Correct mailing sequence.
>>
>> You are still doing something wrong sending the patches over email, the
>> various emails are not threaded as expected, git-send-email should do
>> everything for you.
>>
>> No need to re-send now IMO, but please figure out what's wrong for the next
>> time.
>>
>> To give you an idea here [1] you see this email alone.
>>
>> This [2] and this [3] are examples of a properly sent patch series (just random
>> series from your NXP colleagues).
>>
>> You have also a winmail.dat file attached to every email in this series, not sure
>> what it is, but I would try to not send it.
>>
>
> Yes. I can send them as a single e-mail. However, I find other member
> would send multiple patches as separate e-mails with a cover letter. I
> think it would be easier for review.

We are not asking to send the patches as single email. We are asking to
run git send-email only _once_ per patchset to make sure threading is
correct (ie. References and In-Reply-to headers are set). For example,
you can do it like this:

$ git format-patch --base=auto --cover-letter -o outgoing/ main
outgoing/0000-cover-letter.patch
outgoing/0001-First-Commit.patch
outgoing/...

$ git send-email [...] outgoing/

More info:

https://wireless.wiki.kernel.org/en/developers/documentation/git-guide

https://www.kernel.org/doc/html/latest/process/submitting-patches.html

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
