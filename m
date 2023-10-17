Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB7597CC7CA
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 17:46:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235178AbjJQPqP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 11:46:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235140AbjJQPqA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 11:46:00 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8994197;
        Tue, 17 Oct 2023 08:45:44 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 5986221D23;
        Tue, 17 Oct 2023 15:45:42 +0000 (UTC)
Received: from kitsune.suse.cz (kitsune.suse.cz [10.100.12.127])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 13C422CD7D;
        Tue, 17 Oct 2023 15:45:41 +0000 (UTC)
Date:   Tue, 17 Oct 2023 17:45:39 +0200
From:   Michal =?iso-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>
To:     linux-modules@vger.kernel.org
Cc:     Takashi Iwai <tiwai@suse.com>,
        Lucas De Marchi <lucas.de.marchi@gmail.com>,
        Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
        Jiri Slaby <jslaby@suse.com>, Jan Engelhardt <jengelh@inai.de>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH kmod v5 0/5] kmod /usr support
Message-ID: <20231017154539.GK6241@kitsune.suse.cz>
References: <cover.1689589902.git.msuchanek@suse.de>
 <cover.1689681454.git.msuchanek@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1689681454.git.msuchanek@suse.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Level: 
Authentication-Results: smtp-out1.suse.de;
        dkim=none;
        dmarc=none;
        spf=softfail (smtp-out1.suse.de: 149.44.160.134 is neither permitted nor denied by domain of msuchanek@suse.de) smtp.mailfrom=msuchanek@suse.de
X-Rspamd-Server: rspamd2
X-Spamd-Result: default: False [-1.01 / 50.00];
         ARC_NA(0.00)[];
         BAYES_HAM(-3.00)[100.00%];
         FROM_HAS_DN(0.00)[];
         TO_DN_SOME(0.00)[];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         FREEMAIL_ENVRCPT(0.00)[gmail.com];
         TAGGED_RCPT(0.00)[];
         MIME_GOOD(-0.10)[text/plain];
         DMARC_NA(0.20)[suse.de];
         R_SPF_SOFTFAIL(0.60)[~all:c];
         NEURAL_HAM_LONG(-3.00)[-1.000];
         RWL_MAILSPIKE_GOOD(0.00)[149.44.160.134:from];
         VIOLATED_DIRECT_SPF(3.50)[];
         MX_GOOD(-0.01)[];
         NEURAL_HAM_SHORT(-1.00)[-1.000];
         RCPT_COUNT_TWELVE(0.00)[12];
         RCVD_NO_TLS_LAST(0.10)[];
         FROM_EQ_ENVFROM(0.00)[];
         R_DKIM_NA(0.20)[];
         MIME_TRACE(0.00)[0:+];
         RCVD_COUNT_TWO(0.00)[2];
         FREEMAIL_CC(0.00)[suse.com,gmail.com,inai.de,kernel.org,google.com,fjasle.eu,vger.kernel.org];
         SUSPICIOUS_RECIPS(1.50)[]
X-Spam-Score: -1.01
X-Rspamd-Queue-Id: 5986221D23
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

it has been a few months since these kmod patches have been posted, and
a new kmod versio has been released since.

Is there any interest in adding this to kmod?

Thanks

Michal

On Tue, Jul 18, 2023 at 02:01:51PM +0200, Michal Suchanek wrote:
> Hello,
> 
> with these patches it is possible to install kernel modules in an arbitrary
> directory - eg. moving the /lib/modules to /usr/lib/modules or /opt/linux.
> 
> While the modprobe.d and depmod.d search which already includes multiple
> paths is expanded to also include $(prefix) the module directory still
> supports only one location, only a different one under $(module_directory).
> 
> Having kmod search multiple module locations while only one is supported now
> might break some assumption about relative module path corresponding to a
> specific file, would require more invasive changes to implement, and is not
> supportive of the goal of moving the modules away from /lib.
> 
> Both kmod and the kernel need to be patched to make use of this feature.
> Patched kernel is backwards compatible with older kmod.  Patched kmod
> with $(module_directory) set to /lib/modules is equivalent to unpatched kmod.
> 
> Thanks
> 
> Michal
> 
> Link: https://lore.kernel.org/linux-modules/20210112160211.5614-1-msuchanek@suse.de/
> 
> v4: set whole path to module directory instead of adding prefix
> v5: use pkg-config instead of jq, fix build on openssl without sm3 support
> 
> 
> Michal Suchanek (5):
>   configure: Detect openssl sm3 support
>   man/depmod.d: Fix incorrect /usr/lib search path
>   libkmod, depmod: Load modprobe.d, depmod.d from ${prefix}/lib.
>   kmod: Add pkgconfig file with kmod compile time configuration
>   libkmod, depmod, modprobe: Make directory for kernel modules
>     configurable
> 
>  Makefile.am                          |   6 +-
>  configure.ac                         |  30 ++++++++
>  libkmod/libkmod.c                    |  11 +--
>  man/Makefile.am                      |  10 ++-
>  man/depmod.d.xml                     |   9 ++-
>  man/depmod.xml                       |   4 +-
>  man/modinfo.xml                      |   2 +-
>  man/modprobe.d.xml                   |   1 +
>  man/modprobe.xml                     |   2 +-
>  man/modules.dep.xml                  |   6 +-
>  testsuite/module-playground/Makefile |   2 +-
>  testsuite/setup-rootfs.sh            | 109 +++++++++++++++------------
>  testsuite/test-depmod.c              |  16 ++--
>  testsuite/test-testsuite.c           |   8 +-
>  tools/depmod.c                       |   7 +-
>  tools/kmod.pc.in                     |  10 +++
>  tools/modinfo.c                      |   4 +-
>  tools/modprobe.c                     |   4 +-
>  tools/static-nodes.c                 |   6 +-
>  19 files changed, 156 insertions(+), 91 deletions(-)
>  create mode 100644 tools/kmod.pc.in
> 
> -- 
> 2.41.0
> 
