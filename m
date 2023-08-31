Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0F0078EA4B
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Aug 2023 12:38:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244998AbjHaKiS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Aug 2023 06:38:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230024AbjHaKiQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Aug 2023 06:38:16 -0400
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FCC2CF3;
        Thu, 31 Aug 2023 03:38:14 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id B5ACA5C0107;
        Thu, 31 Aug 2023 06:38:13 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Thu, 31 Aug 2023 06:38:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
        cc:cc:content-transfer-encoding:content-type:content-type:date
        :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to; s=fm2; t=
        1693478293; x=1693564693; bh=8JacaVERr2uJM4kt6LTrKdmQj865/Wvx6Qs
        UC8eM2qE=; b=GD3qw1MPXzsE4buinsCdFMABRuIrDWRq3SB3OihSjGmkAAw19F9
        taptJqf4lp7xQCVwv0Fh+50aV9Wr9VpgDBCgwwLkEg7f1AoBSWHar4h9rAuKIuN2
        YjfEmrkOPYZkFJPhHO7yBkTKZx73uSiXFQ0MkgUUb24NIyRmyNeWNoWY/NdbePl6
        sjVLUwwbR50/WuLDmgkO7aDSHdr3Wp7/jDI8lxFA/eLDYxnmVieentQZxpgk1F8N
        +6oIGE9N0ORm86y/hKnuesa0ipJxSzhH1rdZyPXjzYtIZL6+VzCPWuQ90Y5mpT3m
        jBveD8g0cNM7q1BdnaR4sjxZ4Obo6F2fMtw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
        1693478293; x=1693564693; bh=8JacaVERr2uJM4kt6LTrKdmQj865/Wvx6Qs
        UC8eM2qE=; b=lUz+HdC6kZCC2RBuMax6ORBmjAYYUoeS0sI2v9rq0UgS+Qr6jT0
        9TE2wfR16YA56og/hWSp6hgINH52xN9zRIsUoUGr7NPHzBGlDfD6FHh8Bi1qymsa
        yShVYThMytupuIpTx9A0Bvd0nNZLf32QQtytgEpAAJwpYeZLGWoJaTrHVrLAtTaB
        nPvf0JCy9BMLs1gJIyGYJH/DEjJ23jd1Ic8kRuKODgiC5FosDAg9cuqZd7hJ2SZL
        1lxIvHTSuSKAKT9oNcb3RCKifDRY2NiXiTSxdsxNfAq0jZkcdKLSDVOSSB9uUbsg
        msnJH62V/Qr6WvPTYQ/Ym7zqj/Q1zJ3cLrw==
X-ME-Sender: <xms:k23wZCsMZ4B3ONckN5DyZbYXBk7HochwZgDZXT-y_0df1xWCWAju2g>
    <xme:k23wZHfsaAqXGmOpi4OkkVNX9ag3OAY7Z68Fowlqn2PmP8S28JMCZCJ14LViU_jIe
    4S6YlHm8sDe9KQQS4Y>
X-ME-Received: <xmr:k23wZNzwM9qABzttcMfNgWDI0yipdBB_ixKuLiJTx1zSP9I_QAVGaaAS_z8-9UxN3n4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrudegtddgfedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepkfffgggfvfevfhfhufgjtgfgsehtkeertddtfeejnecuhfhrohhmpeflihgr
    gihunhcujggrnhhguceojhhirgiguhhnrdihrghnghesfhhlhihgohgrthdrtghomheqne
    cuggftrfgrthhtvghrnhephfehveeggeevieehgfdtveeigffgteehieehffetleetffeh
    hfeuteffudehfeffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilh
    hfrhhomhepjhhirgiguhhnrdihrghnghesfhhlhihgohgrthdrtghomh
X-ME-Proxy: <xmx:k23wZNOhNqqNVWGsSxgJVsYSpXRMQHxwfGqJ2upN30RIRt9rBKgqVQ>
    <xmx:k23wZC89bvMioTgHp4x_rK6GM7Q3gOveXtAI-DI2nvTVFbnQhXVytw>
    <xmx:k23wZFXjIltYN6ZkOk3bHWzVXbq2eBalcHsEtpsL8H6LnjGJi2MjyA>
    <xmx:lW3wZGZJxp8GnBOgcXBw6dLpOuuQLUJGAChl1toqwTrYEiekgazMqw>
Feedback-ID: ifd894703:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 31 Aug 2023 06:38:09 -0400 (EDT)
Message-ID: <500758f7-f749-469b-1419-0c08b01c9eab@flygoat.com>
Date:   Thu, 31 Aug 2023 18:38:07 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Content-Language: en-GB
To:     "Maciej W. Rozycki" <macro@orcam.me.uk>,
        Tiezhu Yang <yangtiezhu@loongson.cn>
Cc:     linux-mips@vger.kernel.org,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        linux-kernel@vger.kernel.org, loongson-kernel@lists.loongnix.cn
References: <1692434183-2054-1-git-send-email-yangtiezhu@loongson.cn>
 <ZOxkt/6EkQIy+Jkt@alpha.franken.de> <ZO4Mdr9/XUkXDK9j@alpha.franken.de>
From:   Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: Re: [PATCH v4 0/4] Modify die() for MIPS
In-Reply-To: <ZO4Mdr9/XUkXDK9j@alpha.franken.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



在 2023/8/29 23:19, Thomas Bogendoerfer 写道:
> On Mon, Aug 28, 2023 at 11:11:19AM +0200, Thomas Bogendoerfer wrote:
>> On Sat, Aug 19, 2023 at 04:36:19PM +0800, Tiezhu Yang wrote:
>>> v4:
>>>    -- Add BUG() at the end of nmi_exception_handler()
>>>    -- Return earlier in die() if notify_die() returns NOTIFY_STOP
>>>    -- Update the patch titles and commit messages
>>>
>>> v3:
>>>    -- Make each patch can be built without errors and warnings.
>>>
>>> v2:
>>>    -- Update the commit message to give more detailed info, split into
>>>       three individual patches, suggested by Maciej, thank you.
>>>
>>> Tiezhu Yang (4):
>>>    MIPS: Add BUG() at the end of nmi_exception_handler()
>>>    MIPS: Do not kill the task in die() if notify_die() returns
>>>      NOTIFY_STOP
>>>    MIPS: Return earlier in die() if notify_die() returns NOTIFY_STOP
>>>    MIPS: Add identifier names to arguments of die() declaration
>>>
>>>   arch/mips/include/asm/ptrace.h |  2 +-
>>>   arch/mips/kernel/traps.c       | 15 +++++++++------
>>>   2 files changed, 10 insertions(+), 7 deletions(-)
>> series applied to mips-next.
> I've dropped the series again after feedback from Maciej, that this
> still needs more changes.
Was the feedback made off-list?

I think it's important to make submitter aware of the problem before
action being taken.

 From my perspective Teizhu was working hard to address review comments
all the way so it looks unfair to neglect his work without transparent 
communication.

Thanks
- Jiaxun
> Thomas.
