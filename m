Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21DD779C83B
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 09:33:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231610AbjILHdU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 03:33:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231559AbjILHdS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 03:33:18 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CB25B9
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 00:33:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=6/6nCFpJYOb81oHyjoj4GOPcuz7mb3zUs5Ixn0a6TUg=; b=rmXxwONqsOQr/lI39VVpNPTWvX
        QI0v9MYqJZXj1sMOJqK5f6xZ3veuOHex+KH6OcfJDIzrujrl7l0rYLMucRf5JLr/heE7J7UDZND4P
        KzbdrXP/YLQ2+MJOLiSW0Gx6nlNX+SDYqEQKO634cmQ2CrqYfxtllmqaWs3q5CGMegNB1L1QEjV07
        r8gVAzImm5n2d2zg0S7vsLsgnrE1gRI/K1aVeuqBTfwWJo9mwy0EaeEhnf3O9OsROdfXV9/1bK7ZF
        a2sA1uWfeIoGxiD2zRrWOvuakPLAMXJ6y+z7jIfs+sDrI9tOng0Y3VydMWaAPcpHoZJ+JHMXUDEXI
        fussHo7Q==;
Received: from [2601:1c2:980:9ec0::9fed]
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qfxta-002PZo-0j;
        Tue, 12 Sep 2023 07:33:14 +0000
Message-ID: <60faf0a3-a65c-ff83-6ecd-fe99ce9660f3@infradead.org>
Date:   Tue, 12 Sep 2023 00:33:13 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: Build regressions/improvements in v6.6-rc1
Content-Language: en-US
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     linux-kernel@vger.kernel.org
References: <CAHk-=wgfL1rwyvELk2VwJTtiLNpwxTFeFtStLeAQ-2rTRd34eQ@mail.gmail.com>
 <20230911083848.1027669-1-geert@linux-m68k.org>
 <8b5d0d32-4413-4c70-4ecb-ee44542f4dd5@infradead.org>
 <CAMuHMdUaXjDJ3=rPoUj3XD-fVXyfqQvohfn5FX=_21hOgGqeEg@mail.gmail.com>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <CAMuHMdUaXjDJ3=rPoUj3XD-fVXyfqQvohfn5FX=_21hOgGqeEg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/11/23 23:49, Geert Uytterhoeven wrote:
> Hi Randy,
> 
> On Tue, Sep 12, 2023 at 1:08 AM Randy Dunlap <rdunlap@infradead.org> wrote:
>> On 9/11/23 01:38, Geert Uytterhoeven wrote:
>>> 4 warning regressions:
>> []
>>>   + modpost: WARNING: modpost: vmlinux: section mismatch in reference: ioremap_prot+0x88 (section: .text) -> ioremap_fixed (section: .init.text):  => N/A
>>
>> I would consider trying to fix this one but I can't fathom trying to search thru 237 build logs with a web browser
>> to find which arch/config it is.
>>
>> I did start on that but I'm giving up.
>>
>> If possible, please add the arch/config info to the Build regressions/improvements reports
>> in the future.
> 
> I always reply with more details after my analysis (which is a manual
> process).  Unfortunately, due to hick-ups with vger and lore, none of
> the emails I sent out yesterday using git-send-email made it to the
> lists before last night, so I didn't have anything to reply to until
> this morning...

yep.

> Today, the email issues seem to have been fixed (although I still
> haven't received the report myself, but at least lore now has it),
> so the analysis is there.

I see it. Thanks.

> And FTR, I sent out a fix for the section mismatch yesterday, and
> Andrew has already picked it up.

:)

-- 
~Randy
