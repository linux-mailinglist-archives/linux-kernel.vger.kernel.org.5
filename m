Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AABC77CC781
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 17:32:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344352AbjJQPb7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 11:31:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbjJQPb5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 11:31:57 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6DB5F0;
        Tue, 17 Oct 2023 08:31:55 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C01B7C433C7;
        Tue, 17 Oct 2023 15:31:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697556715;
        bh=UcVz+SM54qPz5n7vZecomg8M0DBa65XVStlTBYqpz7k=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=FXoRBHZblUzvsPFN3PmE4uhPt9qDLP7LhMsy1/D7iAtziqgvL9N+dEPAqp/evJIyp
         F7ercjuTae6EBoDfVqk+b7eZBFHHb1ruMg0NnqS8/qkFymdx7xhTjR2tJNkqkdObto
         2U9lD/NKDmYFNd66NgT8v5ViuGWVP4OPXYZkCZCYioJnGW4UgoexiHUh6oT2Ry9yvn
         tFZo/fueQlrE0hYylmiMSOHlQf/yt+zBOl+82XfrRwLCYKrbK8R8yWc0UBfmxiH03d
         2Bo5KQXHacj53rUeZk8QfMojMSEABLAvUraMgYlI2L6EFI1vmdPGBDR65mYfqdLNez
         Ul7PYsG5VcGsg==
From:   Kalle Valo <kvalo@kernel.org>
To:     Arend van Spriel <aspriel@gmail.com>
Cc:     <linux-wireless@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [RFH] wireless-next: fix new W=1 warnings
References: <87fs2k5l1a.fsf@kernel.org>
        <18b3e27d218.279b.9696ff82abe5fb6502268bdc3b0467d4@gmail.com>
Date:   Tue, 17 Oct 2023 18:31:52 +0300
In-Reply-To: <18b3e27d218.279b.9696ff82abe5fb6502268bdc3b0467d4@gmail.com>
        (Arend van Spriel's message of "Tue, 17 Oct 2023 17:01:19 +0200")
Message-ID: <87a5sh2rkn.fsf@kernel.org>
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

Arend van Spriel <aspriel@gmail.com> writes:

> On October 9, 2023 9:10:11 AM Kalle Valo <kvalo@kernel.org> wrote:
>
>> Hi,
>>
>> During the weekend we updated wireless-next tree from v6.5 to v6.6-rc4+.
>> It looks like a new warning was enabled for v6.6 as I see with GCC 13.2
>> and W=1 several warnings (list below). In v6.5 wireless code was still
>> W=1 warning free with GCC.
>
> Can't say I am a big fan of this new warning, but I will look at the
> brcmfmac related warnings.

I already sent a patch, please take a look:

https://patchwork.kernel.org/project/linux-wireless/patch/20231012135854.3473332-1-kvalo@kernel.org/

> Btw. is it possible to opt out per driver.

Usually that's not preferred.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
