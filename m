Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C8D58112DF
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 14:30:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379060AbjLMNaG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 08:30:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233448AbjLMNaE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 08:30:04 -0500
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::225])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CFA7AB;
        Wed, 13 Dec 2023 05:30:06 -0800 (PST)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 26F7B1C0006;
        Wed, 13 Dec 2023 13:30:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gtucker.io; s=gm1;
        t=1702474204;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HciAWFsqkTxL2YfZMqDwMzCKBXTjDgpSa3BIdLw1iBs=;
        b=aNCcX/L1lLEUCaI+nAphi60hLG1V6H/zJUUUQdovJM0PG7ClWWHhQNHhZZE7KzdgObaL0H
        /pxH7yGkUUrC9OSKj+xA1CuDkQlJYYcyMaIOwZqcN525TlLHDDraNR/f/QJceUlR8K6MCs
        RZ66ckPUrqxam7KtTipV56LU4EY27KXcnmGoCvm5Fz3R9VUVOWGcr9n5xdsDCByavM/gFb
        M7pPohCK0AM04k7LlCwwWNFRbx4Y55wzJgOkUf+NYcyDta3fks+Y2rSJijIA+Eu+JPjO3K
        XW0nX7kv0uZ/gFgWZbnCP0M3tmKRM+K9rvriw42lFsDp4cxznN2PGQpJQ9nRjA==
Message-ID: <92a45817-cd45-c132-a8fc-b2f057d388d9@gtucker.io>
Date:   Wed, 13 Dec 2023 14:30:03 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: stable/LTS test report from KernelCI (2023-12-08)
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Gustavo Padovan <gustavo.padovan@collabora.com>,
        stable@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Shreeya Patel <shreeya.patel@collabora.com>,
        "kernelci@lists.linux.dev" <kernelci@lists.linux.dev>
References: <738c6c87-527e-a1c2-671f-eed6a1dbaef3@collabora.com>
 <2023120846-taste-saga-c4a9@gregkh>
 <1ca05280-a03c-66c0-cd67-87c58c8f3929@gtucker.io>
 <2023121131-delirious-roster-e729@gregkh>
Content-Language: en-GB
From:   Guillaume Tucker <gtucker@gtucker.io>
Organization: gtucker.io
In-Reply-To: <2023121131-delirious-roster-e729@gregkh>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-GND-Sasl: gtucker@gtucker.io
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/12/2023 14:07, Greg KH wrote:
> On Mon, Dec 11, 2023 at 11:14:03AM +0100, Guillaume Tucker wrote:
>> On a related topic, it was once mentioned that since stable
>> releases occur once a week and they are used as the basis for
>> many distros and products, it would make sense to have
>> long-running tests after the release has been declared.  So we
>> could have say, 48h of testing with extended coverage from LTP,
>> fstests, benchmarks etc.  That would be a reply to the email with
>> the release tag, not the patch review.
> 
> What tests take longer than 48 hours?

Well, I'm not sure what you're actually asking here.  Strictly
speaking, some benchmarks and fuzzing can run for longer than
48h.

What I meant is that testing is always open-ended, we could run
tests literally forever on every kernel revision if we wanted to.
For maintainer trees, it's really useful to have a short feedback
loop and get useful results within say, 1h.  For linux-next and
mainline, maybe more testing can be done and results could take
up to 4h to arrive.  Then for stable releases (not stable-rc), as
they happen basically once a week and are adopted as a base
revision by a large group of users, it would make sense to have a
bigger "testing budget" and allow up to maybe 48h of testing
efforts.  As to how to make best use of this time, there are
various ways to look at it.

I would suggest to first run the tests that aren't usually run
such as some less common fstests combinations as well as some LTP
and kselftests suites that take more than 30 min to complete.
Also, if there are any reproducers for the fixes that have been
applied to the stable branch then they could be run as true
regression testing to confirm these issues don't come back.  Then
some additional benchmarks and tests that are known to "fail"
occasionally could also be run to gather more stats.  This could
potentially show trends in case of say, performance deviation
over several months on LTS with finer granularity.

>> I've mentioned before the concept of finding "2nd derivatives" in
>> the rest results, basically the first delta gives you all the
>> regressions and then you do a delta of the regressions to find
>> the new ones.  Maintainer trees would be typically comparing
>> against mainline or say, the -rc2 tag where they based their
>> branch.  In the case of stable, it would be between the stable-rc
>> branch being tested and the base stable branch with the last
>> tagged release.
> 
> Yes, that is going to be required for this to be useful.

OK thanks for confirming.

>> One last thing, I see there's a change in KernelCI now to
>> actually stop sending the current (suboptimal) automated reports
>> to the stable mailing list:
>>
>>   https://github.com/kernelci/kernelci-jenkins/pull/136
>>
>> Is this actually what people here want?
> 
> If these reports are currently for me, I'm just deleting them as they
> provide no value anymore.  So yes, let's stop this until we can get
> something that actually works for us please.

Right, I wasn't sure if anyone else was interested in them.  It
sounds like Sasha doesn't really need them either, although he
wrote on IRC that he wouldn't disable them until something better
was in place.  I would suggest sending at least an email to the
stable list to propose to stop these emails with a particular
date and ideally some kind of plan about when some new emails
would be available to replace them.  But if really nobody else
than you needs the current emails, then effectively nobody needs
them and we can stop now of course.

Cheers,
Guillaume
