Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89EB58003E0
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 07:31:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377626AbjLAGbY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 01:31:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232286AbjLAGbW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 01:31:22 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 610CF1711
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 22:31:28 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E36FC433C9;
        Fri,  1 Dec 2023 06:31:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701412288;
        bh=eoUyQsJT94DAWILg6gFccaj7bIJfUqiZc2gWBO/o6VM=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=Ps3CcdnFwsNIRZWMmICTP+/qiWhzaD+LXiB4Hat1zsHawebK9CasjLlUXfsJaw4q6
         2q6bAiMbUU7B5YSD+HApMNprQp2a9eT6aDaECF3+9aDf/ztvef+n3bsWU8slMLdZXB
         zfN690Ts0L+3liM7Y7uoFUjHL4zwtIvB750MufLs79aouNWFrds8rGuTv5EpODkcJ5
         SjfF4GuCGRxbACDIaITk0QgbzrMwjxfPjL3kgmk8r2+jIH6ZhT68yOue+QRlOTNDGe
         dMoWP0s5or96SAkIPMjcxaw/UsGHV7jZ7KN60aVqPktRb5uovk8V0Lbob8c2MKM9XJ
         hT+srA8xN9CZA==
From:   Kalle Valo <kvalo@kernel.org>
To:     Ping-Ke Shih <pkshih@realtek.com>
Cc:     "Lukas F. Hartmann" <lukas@mntre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "jernej.skrabec@gmail.com" <jernej.skrabec@gmail.com>,
        "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
        "tony0620emma@gmail.com" <tony0620emma@gmail.com>
Subject: Re: [PATCH v3] wifi: rtw88: sdio: Honor the host max_req_size in
 the RX path
References: <20231120115726.1569323-1-martin.blumenstingl@googlemail.com>
        <170137159397.1963309.4329648460865757143.kvalo@kernel.org>
        <87edg7ujhi.fsf@mntre.com>
        <98c69e6e8bb449ffae253840910df07f@realtek.com>
Date:   Fri, 01 Dec 2023 08:31:23 +0200
In-Reply-To: <98c69e6e8bb449ffae253840910df07f@realtek.com> (Ping-Ke Shih's
        message of "Fri, 1 Dec 2023 00:33:46 +0000")
Message-ID: <87cyvqsabo.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ping-Ke Shih <pkshih@realtek.com> writes:

>> sorry for my late reply. Yes, this patch fixes my original problems and
>> I have usable WiFi now. There are still some remaining problems like
>> connection dropouts every minute or so, but it's unrelated and a topic
>> of further investigation.
>> 
>> Tested-by: Lukas F. Hartmann <lukas@mntre.com>
>> 
>
> Would you mind to take my acked-by and Lukas' tested-by and send v4?
> That would be easier to Kalle to merge this patch.

Actually no need to send v4 as patchwork includes Tested-by and Acked-by
automatically:

$ curl https://patchwork.kernel.org/project/linux-wireless/patch/20231120115726.1569323-1-martin.blumenstingl@googlemail.com/mbox/ | grep -- -by:
Reported-by: Lukas F. Hartmann <lukas@mntre.com>
Suggested-by: Ping-Ke Shih <pkshih@realtek.com>
Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>
Acked-by: Ping-Ke Shih <pkshih@realtek.com>
Tested-by: Lukas F. Hartmann <lukas@mntre.com>

But thanks for considering my workload, very much appreciated :)

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
