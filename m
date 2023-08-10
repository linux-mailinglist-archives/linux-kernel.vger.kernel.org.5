Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6551777704
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 13:31:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234938AbjHJLbK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 07:31:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233044AbjHJLbJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 07:31:09 -0400
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E277AE4B;
        Thu, 10 Aug 2023 04:31:04 -0700 (PDT)
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1qU3sb-00024Y-Hk; Thu, 10 Aug 2023 13:31:01 +0200
Message-ID: <a10b911c-dc39-2924-26be-64c7964456ae@leemhuis.info>
Date:   Thu, 10 Aug 2023 13:31:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Drop 0fc6fea41c71 ("drm/i915: Disable DC states for all commits")
 from the 6.0.y series?
Content-Language: en-US, de-DE
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        Linux kernel regressions list <regressions@lists.linux.dev>,
        =?UTF-8?B?VmlsbGUgU3lyasOkbMOk?= <ville.syrjala@linux.intel.com>,
        Jani Nikula <jani.nikula@intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Kurt Garloff <kurt@garloff.de>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Sasha Levin <sashal@kernel.org>
References: <f0870e8f-0c66-57fd-f95d-18d014a11939@leemhuis.info>
 <2023080930-overturn-duo-17de@gregkh>
From:   Thorsten Leemhuis <regressions@leemhuis.info>
In-Reply-To: <2023080930-overturn-duo-17de@gregkh>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1691667065;8843100e;
X-HE-SMSGID: 1qU3sb-00024Y-Hk
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09.08.23 11:15, Greg KH wrote:
> On Mon, Aug 07, 2023 at 12:52:03PM +0200, Thorsten Leemhuis wrote:
>> Hi Greg! Months ago you picked up mainline commit a2b6e99d8a6
>> ("drm/i915: Disable DC states for all commits") for the 6.1.23 release
>> as commit 0fc6fea41c71. It causes issues vor a few people (at least
>> three, two of which are CCed) -- apparently because it depends on some
>> change that wasn't picked up for 6.1.y.

Fun fact: here I had an off-by-one error I noticed and fixed, but...

>> This is known for a while now,
>> but nobody has yet found which change that is (Al found something that
>> worked for him, but that didn't work for others). For the whole story
>> skim this ticket:
>>
>> https://gitlab.freedesktop.org/drm/intel/-/issues/8419
>>
>> I wonder if it might be better if you revert that commit for 6.0.y; I
>> asked already in the ticket if this is likely to cause regressions for
>> users of 6.0.y,

...here I did not. :-/ Sorry.

>> but got no answer from the i915 devs (or did I miss
>> something?). :-/
> 
> Now reverted (note, 6.0.y is long dead, I reverted this for 6.1.y)

Thx, but FWIW, seems my timing was bad. I had waited weeks before
escalating this to you (which looking back now is something I maybe
should have done earlier -- but first it looked like it was just one
person/machine affected by this problem). But it seems soon after I
brought this to your attention a solution came up, as a fix was posted
and confirmed working by one of the reporters -- and the developer wants
to post a backport for stable. For details see
https://gitlab.freedesktop.org/drm/intel/-/issues/8419#note_2035731

Not sure what's the right thing to do at this point for 6.1.y --
dropping the revert maybe before you do the release? You will know best
anyway.

> greg "drowning in kernel release numbers" k-h

Glad I'm not the only one. ;) But I guess it's worse for you...

Ciao, Thorsten
