Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D9C480C62D
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 11:14:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234804AbjLKKOF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 05:14:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234537AbjLKKOB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 05:14:01 -0500
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::225])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E2D4AB;
        Mon, 11 Dec 2023 02:14:06 -0800 (PST)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 0D8391C000B;
        Mon, 11 Dec 2023 10:14:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gtucker.io; s=gm1;
        t=1702289644;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/o70oBtKb5Wyazm8QmMIsorrOqXJhESQkmX0r/S8Af4=;
        b=i1WiFIiq/y7viUcRW6JERDRaLQt1UT5USMBxIeZ4O94cyU1sjE3wSvmyJDpZYp59pvw2wN
        0ySx/AqLbRaMXIVIGVtLTF//HI9cjKyrnSm8fGxYtsVurfYnLQ3gvqJ7usIIWUvjU3l2k3
        KWLIOAJAdy7bT7Jlx7knphrzovwQdL7LXdL+GaGSNQL/10zSwkbyB/cX9l65bCxO7AeRar
        zMyYoS5g/Z0+MLy7fkUFLvi6kq3XUnCdHgMsGaub/SPDbBnsj3r7MMGnSNyB4gNuKWqItm
        tft3M6UZmvdC7Es+lEE/lRdD5ZyPyckL1juMuCULaSQlawUlT6qEPhVKOHSpqw==
Message-ID: <1ca05280-a03c-66c0-cd67-87c58c8f3929@gtucker.io>
Date:   Mon, 11 Dec 2023 11:14:03 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: stable/LTS test report from KernelCI (2023-12-08)
Content-Language: en-GB
To:     Greg KH <gregkh@linuxfoundation.org>,
        Gustavo Padovan <gustavo.padovan@collabora.com>
Cc:     stable@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Shreeya Patel <shreeya.patel@collabora.com>,
        "kernelci@lists.linux.dev" <kernelci@lists.linux.dev>
References: <738c6c87-527e-a1c2-671f-eed6a1dbaef3@collabora.com>
 <2023120846-taste-saga-c4a9@gregkh>
From:   Guillaume Tucker <gtucker@gtucker.io>
Organization: gtucker.io
In-Reply-To: <2023120846-taste-saga-c4a9@gregkh>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-GND-Sasl: gtucker@gtucker.io
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/12/2023 16:58, Greg KH wrote:
> On Fri, Dec 08, 2023 at 12:29:35PM -0300, Gustavo Padovan wrote:
>> Hello,
>>
>> As discussed with Greg at LPC, we are starting an iterative process to
>> deliver meaningful stable test reports from KernelCI. As Greg pointed out,
>> he doesn't look at the current reports sent automatically from KernelCI.
>> Those are not clean enough to help the stable release process, so we
>> discussed starting over again.
>>
>> This reporting process is a learning exercise, growing over time. We are
>> starting small with data we can verify manually (at first) to make sure we
>> are not introducing noise or reporting flakes and false-positives. The
>> feedback loop will teach us how to filter the results and report with
>> incremental automation of the steps.
>>
>> Today we are starting with build and boot tests (for the hardware platforms
>> in KernelCI with sustained availability over time). Then, at every iteration
>> we try to improve it, increasing the coverage and data visualization.
>> Feedback is really important. Eventually, we will also have this report
>> implemented in the upcoming KernelCI Web Dashboard.
>>
>> This work is a contribution from Collabora(on behalf of its clients) to
>> improve the Kernel Integration as whole. Moving forward, Shreeya Patel, from
>> the Collabora team will be taking on the responsibilities of delivering
>> these reports.
>>
>> Without further ado, here's our first report:
>>
>>
>> ## stable-rc HEADs:
>>
>> Date: 2023-12-08
>> 6.1: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git/log/?h=45deeed0dade29f16e1949365688ea591c20cf2c
>> 5:15: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git/log/?h=e5a5d1af708eced93db167ad55998166e9d893e1
>> 5.10: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git/log/?h=ce575ec88a51a60900cd0995928711df8258820a
>> 5:4: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git/log/?h=f47279cbca2ca9f2bbe1178634053024fd9faff3
>>
>> * 6.6 stable-rc was not added in KernelCI yet, but we plan to add it next
>> week.
>>
>>
>> ## Build failures:
>>
>> No build failures seen for the stable-rc/queue commit heads for
>> 6.1/5.15/5.10/5.4  \o/
>>
>>
>> ## Boot failures:
>>
>> No **new** boot failures seen for the stable-rc/queue commit heads for
>> 6.1/5.15/5.10/5.4  \o/
>>
>> (for the time being we are leaving existing failures behind)
>>
>>
>> ## Considerations
>>
>> All this data is available in the legacy KernelCI Web Dashboard -
>> https://linux.kernelci.org/ - but not easily filtered there. The data in
>> this report was checked manually. As we evolve this report, we want to add
>> traceability of the information, making it really easy for anyone to dig
>> deeper for more info, logs, etc.
>>
>> The report covers  the hardware platforms in KernelCI with sustained
>> availability over time - we will detail this further in future reports.
>>
>> We opted to make the report really simple as you can see above. It is just
>> an initial spark. From here your feedback will drive the process. So really
>> really tell us what you want to see next. We want FEEDBACK!
> 
> Looks great!
> 
> A few notes, it can be a bit more verbose if you want :)
> 
> One email per -rc release (i.e. one per branch) is fine, and that way if
> you add a:
> 	Tested-by: kernelci-bot <email goes here>
> or something like that, to the email, my systems will pick it up and it
> will get added to the final commit message.
> 
> But other than that, hey, I'll take the above, it's better than what was
> there before!
> 
> How about if something breaks, what will it look like?  That's where it
> gets more "interesting" :)

Brings back some memories, 5.10.20-rc2 :)

  https://lore.kernel.org/stable/32a6c609-642c-71cf-0a84-d5e8ccd104b1@collabora.com/

I see some people are working in my footsteps now, it'll be
interesting to see if they reach the same conclusions about how
to automate these emails and track regressions.  I guess it's
hard to convince others that the solutions we now know we need to
put in place are going to solve this, so everyone has to do the
journey themselves.  Maybe that's part of upstream development,
not always removing duplication of efforts.


Here's some feedback in general:

* Showing what is passing is mostly noise

As Greg pointed out, what's important is the things that are
broken (so new regressions).  For stable, I think we also
established that it was good to keep a record of all the things
that were tested and passed, but it's not too relevant when
gating releases.  See the other manual emails sent by Shuah,
Guenter and some Linaro folks for example.

* Replying to the stable review

This email is a detached thread, I know it's a draft and just a
way to discuss things, but obviously a real report would need to
be sent as a reply to the patch review thread using stable-rc.

On a related topic, it was once mentioned that since stable
releases occur once a week and they are used as the basis for
many distros and products, it would make sense to have
long-running tests after the release has been declared.  So we
could have say, 48h of testing with extended coverage from LTP,
fstests, benchmarks etc.  That would be a reply to the email with
the release tag, not the patch review.

For the record, a few years ago, KernelCI used to reply to the
review threads on the list.  Unfortunately this broke at some
point, mostly because the legacy system is too bloated and hard
to maintain, and now it's waiting to be enabled again with the
new API.  Here's one example, 4.4-202 in 2019 a bit before it
stopped:

  https://lore.kernel.org/stable/5dce97f3.1c69fb81.6633c.685c@mx.google.com/

* Automation

And also obviously, doing this by hand isn't really practical.
It's OK for a maintainer looking just at a small amount of
results, but for KernelCI it would take maybe 2h per stable
release candidate for a dedicated person to look at all the
regressions etc.  So discussing the format and type of content is
more relevant at this stage I think, while the automated data
harvesting part gets implemented in the background.  And of
course, we need the new API in production for this to be actually
enabled - so still a few months away from now.

I've mentioned before the concept of finding "2nd derivatives" in
the rest results, basically the first delta gives you all the
regressions and then you do a delta of the regressions to find
the new ones.  Maintainer trees would be typically comparing
against mainline or say, the -rc2 tag where they based their
branch.  In the case of stable, it would be between the stable-rc
branch being tested and the base stable branch with the last
tagged release.


But hey, I'm not a stable maintainer :) This is merely a summary
of what I recall from the past few years of discussions and what
I believe to be the current consensus on what people wanted to do
next.

One last thing, I see there's a change in KernelCI now to
actually stop sending the current (suboptimal) automated reports
to the stable mailing list:

  https://github.com/kernelci/kernelci-jenkins/pull/136

Is this actually what people here want?  I would argue that we
need the new reports first before deliberately stopping the old
ones.  Maybe I missed something, it just felt a bit arbitrary.
Some folks might actually be reading these emails, if we wanted
to stop them we probably should first send a warning about when
they'll stop etc.  Anyway, I'll go back under my rock for now :)

Cheers,
Guillaume

