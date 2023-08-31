Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC68C78F15A
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Aug 2023 18:33:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345539AbjHaQd5 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 31 Aug 2023 12:33:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345085AbjHaQdq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Aug 2023 12:33:46 -0400
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2577B1B1
        for <linux-kernel@vger.kernel.org>; Thu, 31 Aug 2023 09:33:42 -0700 (PDT)
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-563ab574cb5so1149815a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 31 Aug 2023 09:33:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693499621; x=1694104421;
        h=content-transfer-encoding:cc:to:from:subject:message-id:in-reply-to
         :date:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UL/+xv3TEvCkbPqVL9ATP2J9Zi+p02gmwTovxR3XYgM=;
        b=VDpxTnGWoA83FJ6MYQWTayvOJ8+6BQbHQcFix7O3UO47+2h3n7qUYXu+rf4nLPLa17
         SA1dENXEv759b2/hhosEoXJTLFPwVTzmCV1yBpNxUjLa98SgboD46qm04pNg8vrWj+nJ
         rwWXoTy4eSUcJvFwsTADLbxBuVES2UQ/TpAqUmAoyX985KMTucNNQglajz7EBSmVty+a
         Js+kUx07Ne/W6W8a6PvPMzV4iglFeTdMnC0xMqmmJQQulNgZnSvwOwGBKtyIIvDGgOC5
         Wn5PUR4JTi0Oq5e90wotbDm/6lDNGENTOlnk5w12xiFGG6w1+pX60drS6b1Zh6UXMwA8
         b84Q==
X-Gm-Message-State: AOJu0YyI1+L78UkZNglloEDqSl7wNZSUoJvqos4SrYf4OqI1vCvxlMrd
        puPAlQD1sNHrkKsASB5rmzB+4Andq3Ks3I6Cd8X33e21d0ZA
X-Google-Smtp-Source: AGHT+IHPF3Cw3+xs3CR4+mcl68Oz2lVLsNfuG54lDd66IEOCoiMwjN2IQHzvYhA4tfjSPi/FDAd05NQkcRZK4Z3Z0k73OSHB2xav
MIME-Version: 1.0
X-Received: by 2002:a17:902:fb03:b0:1bb:8c42:79f4 with SMTP id
 le3-20020a170902fb0300b001bb8c4279f4mr42126plb.2.1693499621693; Thu, 31 Aug
 2023 09:33:41 -0700 (PDT)
Date:   Thu, 31 Aug 2023 09:33:41 -0700
In-Reply-To: <ZPDA1Z8Hwq3jdvgh@smile.fi.intel.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000060e52d06043a9b7b@google.com>
Subject: Re: [syzbot] [kernel?] general protection fault in netdev_register_kobject
From:   syzbot <syzbot+d2c31705e468a347e6db@syzkaller.appspotmail.com>
To:     andriy.shevchenko@linux.intel.com
Cc:     andriy.shevchenko@linux.intel.com, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, nogikh@google.com, rafael@kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> On Thu, Aug 31, 2023 at 05:53:29PM +0200, Aleksandr Nogikh wrote:
>> On Thu, Aug 31, 2023 at 5:39 PM Andy Shevchenko
>> <andriy.shevchenko@linux.intel.com> wrote:
>> > On Thu, Aug 31, 2023 at 04:15:23PM +0200, Aleksandr Nogikh wrote:
>> > > #syz dup: general protection fault in nfc_register_device
>> >
>> > Thanks!
>> >
>> > Maybe you can improve it to
>> > 1) drop those prefixes by itself;
>> 
>> Yeah, I've just thought about it too when I was correcting the command.
>> 
>> > 2) explain better in the quick help below what "exact" means.
>> >
>> > Also is it possible to test just patches without repository?
>> > Can you add this feature when you simply submit a message ID
>> > to it and it uses lore.kernel.org for the patch or series?
>> 
>> Thanks, these are good suggestions!
>> The first one is easy to do (we actually already support that
>> internally, so only a small change is needed), the second one is a bit
>> trickier, but I'll look into that.
>
> JFYI:
> 20230828145824.3895288-1-andriy.shevchenko@linux.intel.com
>
> Can be used for testing.
> So I like to write
>
> #syz test patch: 20230828145824.3895288-1-andriy.shevchenko@linux.intel.com

"patch:" does not look like a valid git repo address.

>
> The responses can be (among others?):
> 1/ tested and test results;
> 2/ not found.
>
> -- 
> With Best Regards,
> Andy Shevchenko
>
>
