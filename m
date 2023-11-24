Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54B027F7472
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Nov 2023 13:59:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345177AbjKXM7Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Nov 2023 07:59:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229742AbjKXM7W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Nov 2023 07:59:22 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE5AA110
        for <linux-kernel@vger.kernel.org>; Fri, 24 Nov 2023 04:59:28 -0800 (PST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 418D821DF5;
        Fri, 24 Nov 2023 12:59:25 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 19D551340B;
        Fri, 24 Nov 2023 12:59:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
        by imap1.dmz-prg2.suse.org with ESMTPSA
        id Mw6jBS2eYGVuKgAAD6G6ig
        (envelope-from <vbabka@suse.cz>); Fri, 24 Nov 2023 12:59:25 +0000
Message-ID: <bfc4259e-c293-1e53-a787-4131e8bacc21@suse.cz>
Date:   Fri, 24 Nov 2023 13:59:24 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [REGRESSION] USB ports do not work after suspend/resume cycle
 with v6.6.2
Content-Language: en-US
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Oleksandr Natalenko <oleksandr@natalenko.name>
Cc:     linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        stable@vger.kernel.org, Mathias Nyman <mathias.nyman@intel.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Basavaraj Natikar <Basavaraj.Natikar@amd.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        Sasha Levin <sashal@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Thorsten Leemhuis <linux@leemhuis.info>,
        Petr Tesarik <petr@tesarici.cz>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Javier Martinez Canillas <javierm@redhat.com>,
        workflows@vger.kernel.org
References: <5993222.lOV4Wx5bFT@natalenko.name>
 <2023112421-brisket-starless-c20d@gregkh>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <2023112421-brisket-starless-c20d@gregkh>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Bar: +++++++
X-Spam-Score: 7.64
X-Rspamd-Server: rspamd1
X-Rspamd-Queue-Id: 418D821DF5
Authentication-Results: smtp-out1.suse.de;
        dkim=none;
        dmarc=none;
        spf=softfail (smtp-out1.suse.de: 2a07:de40:b281:104:10:150:64:97 is neither permitted nor denied by domain of vbabka@suse.cz) smtp.mailfrom=vbabka@suse.cz
X-Spamd-Result: default: False [7.64 / 50.00];
         RCVD_VIA_SMTP_AUTH(0.00)[];
         ARC_NA(0.00)[];
         SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
         FROM_HAS_DN(0.00)[];
         TO_DN_SOME(0.00)[];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         BAYES_HAM(-3.00)[100.00%];
         MIME_GOOD(-0.10)[text/plain];
         DMARC_NA(1.20)[suse.cz];
         R_SPF_SOFTFAIL(4.60)[~all];
         NEURAL_SPAM_SHORT(2.66)[0.886];
         RCVD_COUNT_THREE(0.00)[3];
         MX_GOOD(-0.01)[];
         NEURAL_SPAM_LONG(0.09)[0.027];
         RCPT_COUNT_TWELVE(0.00)[16];
         DBL_BLOCKED_OPENRESOLVER(0.00)[natalenko.name:url];
         FUZZY_BLOCKED(0.00)[rspamd.com];
         FROM_EQ_ENVFROM(0.00)[];
         R_DKIM_NA(2.20)[];
         MIME_TRACE(0.00)[0:+];
         RCVD_TLS_ALL(0.00)[];
         MID_RHS_MATCH_FROM(0.00)[]
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+Cc workflows

On 11/24/23 12:43, Greg Kroah-Hartman wrote:
> On Thu, Nov 23, 2023 at 07:20:46PM +0100, Oleksandr Natalenko wrote:
>> Hello.
>> 
>> Since v6.6.2 kernel release I'm experiencing a regression with regard
>> to USB ports behaviour after a suspend/resume cycle.
>> 
>> If a USB port is empty before suspending, after resuming the machine
>> the port doesn't work. After a device insertion there's no reaction in
>> the kernel log whatsoever, although I do see that the device gets
>> powered up physically. If the machine is suspended with a device
>> inserted into the USB port, the port works fine after resume.
>> 
>> This is an AMD-based machine with hci version 0x110 reported. As per
>> the changelog between v6.6.1 and v6.6.2, 603 commits were backported
>> into v6.6.2, and one of the commits was as follows:
>> 
>> $ git log --oneline v6.6.1..v6.6.2 -- drivers/usb/host/xhci-pci.c 
>> 14a51fa544225 xhci: Loosen RPM as default policy to cover for AMD xHC
>> 1.1
>> 
>> It seems that this commit explicitly enables runtime PM specifically
>> for my platform. As per dmesg:
>> 
>> v6.6.1: quirks 0x0000000000000410 v6.6.2: quirks 0x0000000200000410
>> 
>> Here, bit 33 gets set, which, as expected, corresponds to:
>> 
>> drivers/usb/host/xhci.h 1895:#define XHCI_DEFAULT_PM_RUNTIME_ALLOW
>> BIT_ULL(33)
>> 
>> This commit is backported from the upstream commit 4baf12181509, which
>> is one of 16 commits of the following series named "xhci features":
>> 
>> https://lore.kernel.org/all/20231019102924.2797346-1-mathias.nyman@linux.intel.com/
>>
>>  It appears that there was another commit in this series, also from
>> Basavaraj (in Cc), a5d6264b638e, which was not picked for v6.6.2, but
>> which stated the following:
>> 
>> Use the low-power states of the underlying platform to enable runtime
>> PM. If the platform doesn't support runtime D3, then enabling default
>> RPM will result in the controller malfunctioning, as in the case of
>> hotplug devices not being detected because of a failed interrupt
>> generation.
>> 
>> It felt like this was exactly my case. So, I've conducted two tests:
>> 
>> 1. Reverted 14a51fa544225 from v6.6.2. With this revert the USB ports
>> started to work fine, just as they did in v6.6.1. 2. Left 14a51fa544225
>> in place, but also applied upstream a5d6264b638e on top of v6.6.2. With
>> this patch added the USB ports also work after a suspend/resume cycle.
>> 
>> This runtime PM enablement did also impact my AX200 Bluetooth device,
>> resulting in long delays before headphones/speaker can connect, but
>> I've solved this with btusb.enable_autosuspend=N. I think this has
>> nothing to do with the original issue, and I'm OK with this workaround
>> unless someone has got a different idea.
>> 
>> With that, please consider either reverting 14a51fa544225 from the
>> stable kernel, or applying a5d6264b638e in addition to it. Given the
>> mainline kernel has got both of them, I'm in favour of applying
>> additional commit to the stable kernel.
> 
> I've applied this other commit as well to all of the affected branches, 
> thanks for letting us know.
> 
>> I'm also Cc'ing all the people from our Mastodon discussion where I
>> initially complained about the issue as well as about stable kernel
>> branch stability:
>> 
>> https://activitypub.natalenko.name/@oleksandr/statuses/01HFRXBYWMXF9G4KYPE3XHH0S8
>>
>>  I'm not going to expand more on that in this email, especially given
>> Greg indicated he read the conversation, but I'm open to continuing
>> this discussion as I still think that current workflow brings visible
>> issues to ordinary users, and hence some adjustments should be made.
> 
> What type of adjustments exactly?  Testing on wide ranges of systems is
> pretty hard, and this patch explicitly was set to be backported when it
> hit Linus's tree,

Are you sure about that "explicitly was set to be backported" part?
According to Documentation/process/stable-kernel-rules.rst:

> There are three options to submit a change to -stable trees:
> 
>  1. Add a 'stable tag' to the description of a patch you then submit for
>     mainline inclusion.
>  2. Ask the stable team to pick up a patch already mainlined.
>  3. Submit a patch to the stable team that is equivalent to a change already
>     mainlined.

I don't see a stable tag in 4baf12181509 ("xhci: Loosen RPM as default
policy to cover for AMD xHC 1.1"), was it option 2 or 3 then?

Do you mean the Fixes: tag? the docs only say that can replace the "# 3.3.x"
part to determine where backporting should stop, but is not itself an
explicit marking for stable backport?

> it just looks like someone forgot to mark the
> follow-up patch that you found also to be properly backported.
> 
> We will always make mistakes, we are only human.  The best thing to do
> is if we get notified quickly of issues, like you did here, and work to
> resolve them, as we have done here.  So again, thanks for letting us
> know about the problem, and be sure to let us know of any future issues
> you might find as well.
> 
> Remember, hardware is messy, and the kernel's job is to fix hardware
> issues and quirks in it.  Sometimes we get it wrong as we are trying to
> fix up inconsistencies and they cause other problems, so in the end, we
> can only grumble at the hardware companies for stuff like this, be
> patient with those of us who have to deal with this mess :)
> 
> thanks,
> 
> greg k-h

