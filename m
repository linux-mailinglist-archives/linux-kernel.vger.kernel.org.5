Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 608318057C3
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 15:49:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345680AbjLEOpx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 09:45:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345572AbjLEOpt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 09:45:49 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7410AF
        for <linux-kernel@vger.kernel.org>; Tue,  5 Dec 2023 06:45:55 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36C69C433C7;
        Tue,  5 Dec 2023 14:45:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701787555;
        bh=cErcNxuSq+KwDwGNIQMoU3Oz6YM+Ijm70S9VqePDyoo=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=JJWROqHH/czRco/daAN5+vEzbMTMOOFShTNzRfXpPc5yqzEvuNpmfOM63EGkcXSiY
         LO1i0RnJehM6di/b+Yk0SmAAuHbkHUbzj5KXGUkQCrVwgaZh7oypLmP9K6OyRS4DXV
         1MyzjaZSbhXaO9yJOR2N10xFWi+8jABl2TsJ9VRLL8GrqyjWJVvhXcdmx69RL+shm2
         SPYZJ/sFremswXB4JMPY+xpHP3Vr3dvSCk9bNxb5V1sEVHLIqh9kasEw3gV94U/pqL
         hqQ07L4U5jF7ZgA19LANGGSvoOxFBb5BiJOwjBmTeIa8Cy4dHIgynHIlcZ+FZYICjB
         bkB2RDlJoLQKA==
From:   Kalle Valo <kvalo@kernel.org>
To:     Jiri Slaby <jirislaby@kernel.org>
Cc:     linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
        Felix Fietkau <nbd@openwrt.org>,
        Nick Kossifidis <mickflemm@gmail.com>,
        Luis Chamberlain <mcgrof@kernel.org>
Subject: Re: [PATCH] ath5k: remove unused ath5k_eeprom_info::ee_antenna
References: <20231205111515.21470-1-jirislaby@kernel.org>
        <874jgwrgxu.fsf@kernel.org>
        <dde1fdb0-c905-4c46-baf6-cdc1011df4cc@kernel.org>
Date:   Tue, 05 Dec 2023 16:45:51 +0200
In-Reply-To: <dde1fdb0-c905-4c46-baf6-cdc1011df4cc@kernel.org> (Jiri Slaby's
        message of "Tue, 5 Dec 2023 14:10:11 +0100")
Message-ID: <87msuopv1c.fsf@kernel.org>
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

Jiri Slaby <jirislaby@kernel.org> writes:

> On 05. 12. 23, 13:07, Kalle Valo wrote:
>> "Jiri Slaby (SUSE)" <jirislaby@kernel.org> writes:
>> 
>>> clang-struct [1] found that ee_antenna in struct ath5k_eeprom_info is
>>> unused. The commit 1048643ea94d ("ath5k: Clean up eeprom
>>> parsing and add missing calibration data") added it, but did not use it
>>> in any way. Neither, there is a later user.
>>>
>>> So remove that unused member.
>>>
>>> [1] https://github.com/jirislaby/clang-struct
>>
>> clang-struct looks really nice, especially if it can also find unused
>> structures.
>
> It can...

Nice!

>> What about unused defines or enums, any chance to find those
>> in the future? :)
>
> All of that is IMO possible (I'm not completely sure about macros,
> despite clang ASTs provide a lot of info. Incl. info about them and
> their expansion).

Too bad, I wish that there would be a tool for that. I suspect wireless
drivers have unused defines and enums, it would be nice to clean up
that.

> It's all limited only by man-force: me.

Yeah, I guessed that. Thanks for making this tool available, hopefully
more people start using it.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
