Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E2DE7CC8FE
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 18:40:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234950AbjJQQk3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 12:40:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230343AbjJQQk0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 12:40:26 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E48B294;
        Tue, 17 Oct 2023 09:40:24 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 89DF421979;
        Tue, 17 Oct 2023 16:40:23 +0000 (UTC)
Received: from kitsune.suse.cz (kitsune.suse.cz [10.100.12.127])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id E91EE2C720;
        Tue, 17 Oct 2023 16:40:22 +0000 (UTC)
Date:   Tue, 17 Oct 2023 18:40:21 +0200
From:   Michal =?iso-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>
To:     Lucas De Marchi <lucas.demarchi@intel.com>
Cc:     linux-modules@vger.kernel.org, Takashi Iwai <tiwai@suse.com>,
        Lucas De Marchi <lucas.de.marchi@gmail.com>,
        Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
        Jiri Slaby <jslaby@suse.com>, Jan Engelhardt <jengelh@inai.de>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH kmod v5 0/5] kmod /usr support
Message-ID: <20231017164021.GL6241@kitsune.suse.cz>
References: <cover.1689589902.git.msuchanek@suse.de>
 <cover.1689681454.git.msuchanek@suse.de>
 <20231017154539.GK6241@kitsune.suse.cz>
 <iplnlgb5mxrltogppm2buz63unviqrziwf7liob6mht6yl776l@3j2dzm7nbs3i>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <iplnlgb5mxrltogppm2buz63unviqrziwf7liob6mht6yl776l@3j2dzm7nbs3i>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Level: 
Authentication-Results: smtp-out1.suse.de;
        none
X-Rspamd-Server: rspamd2
X-Spamd-Result: default: False [-4.00 / 50.00];
         TAGGED_RCPT(0.00)[];
         REPLY(-4.00)[]
X-Spam-Score: -4.00
X-Rspamd-Queue-Id: 89DF421979
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 17, 2023 at 11:18:23AM -0500, Lucas De Marchi wrote:
> On Tue, Oct 17, 2023 at 05:45:39PM +0200, Michal Suchánek wrote:
> > Hello,
> > 
> > it has been a few months since these kmod patches have been posted, and
> > a new kmod versio has been released since.
> > 
> > Is there any interest in adding this to kmod?
> 
> yes, but I think the main drag is deciding with the kernel build system
> maintainers what they are willing to accept as an interface. There isn't
> much point in exporting a json config if from the kernel side they would
> rather use something else. Or to use pkg-config.
> 
> I confess I lost track of that discussion. Did that settle with
> pkg-config being the preferred solution?

The current discussion about the kernel side can be found here:

https://lore.kernel.org/linux-kbuild/20231017151050.GJ6241@kitsune.suse.cz/T/#t

My impression is that pkg-config is accepted as an interface on the
basis that it's already required for building the kernel while jq is
currently required only for some additional optional tools.

Thanks

Michal
