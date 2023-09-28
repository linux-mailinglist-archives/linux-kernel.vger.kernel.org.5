Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C10F77B2142
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 17:29:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231851AbjI1P32 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 11:29:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231384AbjI1P3Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 11:29:25 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EDBDAC;
        Thu, 28 Sep 2023 08:29:23 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21992C433C8;
        Thu, 28 Sep 2023 15:29:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695914963;
        bh=BwRgdNKeJxIJ5cr5vGTDyf7GQ4JC9jrjgb1r743JPlg=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=PcufRPF3oYqO7p9A49NFfI9TrSP5l1pdFXe4cJ988aZz++6Aa/6vLvjXmy/+eFu/v
         9OGGSJmSq8O0P7jaSnGPmWbvWIc+lq5/fK3rcYDa4yDwttGRsmY/U5CawBTzd/fo4v
         B/v5t3odugztw5Rm3k6wIBUxdhAxxNhu0uk/IlK+RHFjygZorfrnpFsyvonA95SgKQ
         dQ6UIJt7TYaPDou5UW8tToBF0iu0sSMhkkRNLQ8daU1ftkPqcQP7pGgaSyVzhbSbfy
         bF/hCFfsg6gDEhAdiwFfKd02qb9/ueyh25E2mxRLkkdEoaFhh3r3I38u7FFdEARFdH
         JdSeRK2GtLOKw==
From:   Kalle Valo <kvalo@kernel.org>
To:     Christian Lamparter <chunkeey@gmail.com>
Cc:     Wu Yunchuan <yunchuan@nfschina.com>,
        linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH v2 wireless-next 2/9] carl9170: remove unnecessary
 (void*) conversions
References: <20230919044916.523308-1-yunchuan@nfschina.com>
        <e544d992-cddd-4ade-81ef-2eed4f3681e8@gmail.com>
Date:   Thu, 28 Sep 2023 18:31:28 +0300
In-Reply-To: <e544d992-cddd-4ade-81ef-2eed4f3681e8@gmail.com> (Christian
        Lamparter's message of "Wed, 20 Sep 2023 21:00:08 +0200")
Message-ID: <87zg16iab3.fsf@kernel.org>
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

Christian Lamparter <chunkeey@gmail.com> writes:

> On 9/19/23 06:49, Wu Yunchuan wrote:
>> No need cast (void *) to (struct ar9170 *), (u8 *) or (void*).
>
> hmm, your mail went into the spam folder. Good thing I checked.
>
> From what I remember: The reason why these casts were added in
> carl9170 was because of compiler warnings/complaints.
> Current gcc compilers should be OK (given that the kernel-bot
> didn't react, or went your Mail to their spam-folder as well?)
> but have you checked these older versions?

Do you remember anything more about these warnings? I tried to check the
git history and at least quickly couldn't find anything related to this.

The changes look very safe to me, struct urb::context field and the out
variable are both of type 'void *' so removing the explicit casts should
change anything. I cannot really come up a reason why would this patch
cause new warnings so I am inclined towards taking this patch. What do
you think?

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
