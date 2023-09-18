Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 909107A4458
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Sep 2023 10:17:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240783AbjIRIRD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 04:17:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240838AbjIRIQm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 04:16:42 -0400
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8C23CC5;
        Mon, 18 Sep 2023 01:15:04 -0700 (PDT)
Received: from localhost (pd-18-104-112.service.infuturo.it [151.18.104.112])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id C2F1B5BF;
        Mon, 18 Sep 2023 08:15:01 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net C2F1B5BF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1695024902; bh=eO3FPiymp+iTHHU/EAH1KhhWva6tzLX0SlXrOUuecKI=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=F/X+0g1BkEtSJy4X0dGXJFRPhTqQQHD4cK4jicIp7kT8raAGKJSedVkneJZQE+hoS
         1eEhYcpuuzcXg9dwhyfHGlGkTmr/CFr2SaLkZU3QVs3uDc6lA3WLgYhwjiIRxT+tLW
         /BLdMyj0ZOLfohXPAPveVdWJbHfL7A/fFYN0efy+okTnf0rxFM80kEZdGMgjsgI8Wt
         sTE/aND8cfVd2i8xaTf2xrtUFIl7bE2oFf8uGSVYtp+Or4GL2zWJKETfY22ZLtfsSf
         dY6xyWE0FIKTCaUgMchsVp7NYQgoktvDVOJruV4AQFjpyOXWnqPvpNf7Ibo4HE+Eby
         eCXkT+HWaSS1Q==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Bagas Sanjaya <bagasdotme@gmail.com>,
        Charles Han <hanchunchao@inspur.com>, djwong@kernel.org,
        dchinner@redhat.com, allison.henderson@oracle.com,
        bhelgaas@google.com
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/1] Documentation: xfs: Remove duplicate 'the' in
 transaction sequence process
In-Reply-To: <ZQgEYU71YE6Jv38D@debian.me>
References: <20230918074054.313204-1-hanchunchao@inspur.com>
 <ZQgEYU71YE6Jv38D@debian.me>
Date:   Mon, 18 Sep 2023 02:14:58 -0600
Message-ID: <87ttrrc2yl.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Bagas Sanjaya <bagasdotme@gmail.com> writes:

> On Mon, Sep 18, 2023 at 03:40:54PM +0800, Charles Han wrote:
>> Remove the repeated word "the" in comments.
>
> Patch title looks OK but in this case, the patch description should also match.
> Hint: there is no code comments in the doc below.
>
>> 
>> Signed-off-by: Charles Han <hanchunchao@inspur.com>
>> ---
>>  Documentation/filesystems/xfs-online-fsck-design.rst | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>> 
>> diff --git a/Documentation/filesystems/xfs-online-fsck-design.rst b/Documentation/filesystems/xfs-online-fsck-design.rst
>> index 1625d1131093..a0678101a7d0 100644
>> --- a/Documentation/filesystems/xfs-online-fsck-design.rst
>> +++ b/Documentation/filesystems/xfs-online-fsck-design.rst
>> @@ -1585,7 +1585,7 @@ The transaction sequence looks like this:
>>  2. The second transaction contains a physical update to the free space btrees
>>     of AG 3 to release the former BMBT block and a second physical update to the
>>     free space btrees of AG 7 to release the unmapped file space.
>> -   Observe that the the physical updates are resequenced in the correct order
>> +   Observe that the physical updates are resequenced in the correct order
>>     when possible.
>>     Attached to the transaction is a an extent free done (EFD) log item.
>>     The EFD contains a pointer to the EFI logged in transaction #1 so that log
>
> Regardless, wait for one or few days before rerolling this patch with
> reviews addressed. It allows other reviewers to catch up and review. You can
> also Cc: me if you'd like.

Bagas, this is a patch removing an extra "the".  We do not need to make
life this hard for such a simple fix.

Charles, the patch is good enough, no need for a third version.

(Next time, though, do wait before resubmitting a patch.  When you do,
put a description of what changed below the "---" line.)

Thanks,

jon
