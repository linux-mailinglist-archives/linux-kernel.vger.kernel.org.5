Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB2957576EB
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 10:43:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232016AbjGRInV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 04:43:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232053AbjGRInE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 04:43:04 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64969FA;
        Tue, 18 Jul 2023 01:43:03 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 1C586218BB;
        Tue, 18 Jul 2023 08:43:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1689669782; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=UmZNxaOE9WdI5cQjddt15xDrk872x/oU18U9Nk98KSg=;
        b=f+dFVOm/4QVXMzGLzXUb4eQQ1GKgTuZP0EVzy7/BdVoUrgrMqRcEPRXWAp7MNXc7UVCx60
        2a0s5O4NVE5FN/BbyEq1lY0SH53IOPmqJQKiLfWCEpkSr1TKE0SWI8AyTKyAy/2aDSAGH4
        jiOoPHonJLUHTkka6BvPm/7P45+jMe8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1689669782;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=UmZNxaOE9WdI5cQjddt15xDrk872x/oU18U9Nk98KSg=;
        b=36fhTgkkcWOWVytO88TXvO1ozHe2+5oc8tMrzpz8PezOjZhO8mLekp/NYSnmtAPRY7jmNJ
        Xhh5EFUZkYrJE5BQ==
Received: from kitsune.suse.cz (kitsune.suse.cz [10.100.12.127])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id BA2DB2C142;
        Tue, 18 Jul 2023 08:43:01 +0000 (UTC)
Date:   Tue, 18 Jul 2023 10:43:00 +0200
From:   Michal =?iso-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>
To:     Jan Engelhardt <jengelh@inai.de>
Cc:     linux-modules@vger.kernel.org, Takashi Iwai <tiwai@suse.com>,
        Lucas De Marchi <lucas.de.marchi@gmail.com>,
        Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
        Jiri Slaby <jslaby@suse.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH kmod v4 4/4] libkmod, depmod, modprobe: Make directory
 for kernel modules configurable
Message-ID: <20230718084300.GU9196@kitsune.suse.cz>
References: <20230711153126.28876-1-msuchanek@suse.de>
 <cover.1689589902.git.msuchanek@suse.de>
 <cc04472084dc016679598fcffafc788bbb6d9c0f.1689589902.git.msuchanek@suse.de>
 <76o21q7n-8qo8-37p6-oqno-q08nqpos471@vanv.qr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <76o21q7n-8qo8-37p6-oqno-q08nqpos471@vanv.qr>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Mon, Jul 17, 2023 at 09:28:30PM +0200, Jan Engelhardt wrote:
> 
> On Monday 2023-07-17 12:39, Michal Suchanek wrote:
> 
> >modprobe.d is now searched under ${prefix}/lib, add ${module_directory} to
> >specify the directory where to search for kernel modules.
> >
> >With this distributions that do not want to ship files in /lib can also
> >move kernel modules to /usr while others can keep them in /lib.
> 
> This patch breaks kernel builds/installation.
> 
>  * assume $distro has given me a kmod that has your submission included,
>    and such kmod was ./configure'd --with-module-directory=/usr/lib/modules
> 
> With such a kmod, the module installation of current and past kernels
> is not possible, in other words, ** bisecting kernels ** is broken:

It might be nice to provide backwads compatibility with earlier
configurations.

However, if it comes at the cost of making the implementation more
complex and future maintenance more difficult it might not be such a
great idea. So far I have not seen a proposal how to do it nicely.

You can use any of the number of workarounds that have been used for
installing kernels on usrmerged distributions up until now.

sed -i -e s,/lib/modules,/usr/lib/modules, Makefile scripts/depmod.sh is
one.

Failing depmod is not critical, you can fix it up after the fact once
the modules are deployed on the test system.

You can also build a differently configured kmod for the purpose and
pass it with DEPMOD= to the kernel build.

Thanks

Michal
