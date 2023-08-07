Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9207A771E1C
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 12:30:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231325AbjHGKas (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 06:30:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231166AbjHGKao (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 06:30:44 -0400
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1E72173B
        for <linux-kernel@vger.kernel.org>; Mon,  7 Aug 2023 03:30:40 -0700 (PDT)
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1qSxVP-0004E8-4E; Mon, 07 Aug 2023 12:30:31 +0200
Message-ID: <d7290782-bf72-3a65-26fa-b58e75bcae2c@leemhuis.info>
Date:   Mon, 7 Aug 2023 12:30:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Fwd: Ubuntu 22.04, "nvme list" will hang for 60 seconds after
 "nvme subsystem-reset"
Content-Language: en-US, de-DE
To:     Bagas Sanjaya <bagasdotme@gmail.com>,
        Keith Busch <kbusch@kernel.org>,
        Christoph Hellwig <hch@lst.de>, shenlinghai@163.com,
        Jens Axboe <axboe@fb.com>, Sagi Grimberg <sagi@grimberg.me>,
        dwmw2@infradead.org
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Regressions <regressions@lists.linux.dev>,
        Linux NVMe <linux-nvme@lists.infradead.org>
References: <8edde583-2b5f-2332-e59a-f1f4688b9e40@gmail.com>
From:   Thorsten Leemhuis <regressions@leemhuis.info>
In-Reply-To: <8edde583-2b5f-2332-e59a-f1f4688b9e40@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1691404241;681f063d;
X-HE-SMSGID: 1qSxVP-0004E8-4E
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02.08.23 13:41, Bagas Sanjaya wrote:
> 
> I notice a regression report on Bugzilla [1]. Quoting from it:
> 
>> Issue description:
>> root:~# lsb_release -a
>> No LSB modules are available.
>> Distributor ID:	Ubuntu
>> Description:	Ubuntu 22.04 LTS
>> Release:	22.04
>> Codename:	jammy
>>
>> root:~# uname -a
>> Linux dapu-Star-Lake 5.19.0-46-generic #47~22.04.1-Ubuntu SMP PREEMPT_DYNAMIC Wed Jun 21 15:35:31 UTC 2 x86_64 x86_64 x86_64 GNU/Linux

Bagas, please don't forward reports to the developers (and also don't
add them to the regression tracking) if the report is about a problem
with a vendor kernel that is known or likely to be patched[1].
Developers otherwise will just start to ignore your mails, as you are
wasting their time.

Ciao, Thorsten

[1] unless of course the reporter confirmed that the issue also happens
with a fresh vanilla kernel; but that afaics still hasn't happened in
this case yet; and even if that's the case it must be really obvious
when forwarding a report.

>> root:~#nvme subsystem-reset /dev/nvme0
>>
>> root:~#nvme list      //This command will hang about 60 seconds. 
>>
>> Issue analysis:
>> Maybe it hangs in function nvme_wait_reset. When we revert the following commit, this issue will disappear.
>> if (!nvme_wait_reset(ctrl))
>> https://github.com/torvalds/linux/commit/1e866afd4bcdd01a70a5eddb4371158d3035ce03?diff=split
> 
> See Bugzilla for the full thread.
> 
> Anyway, I'm adding this regression to be tracked by regzbot:
> 
> #regzbot introduced: 1e866afd4bcdd0 https://bugzilla.kernel.org/show_bug.cgi?id=217745
> #regzbot title: listing nvme devices hangs after subsystem reset
> 
> Thanks.
> 
> [1]: https://bugzilla.kernel.org/show_bug.cgi?id=217745
> 
