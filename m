Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FCC67CBA2A
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 07:34:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234399AbjJQFeA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 01:34:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234441AbjJQFdz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 01:33:55 -0400
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A98BBA2;
        Mon, 16 Oct 2023 22:33:52 -0700 (PDT)
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1qsciE-0005x2-Fn; Tue, 17 Oct 2023 07:33:50 +0200
Message-ID: <3d1355bc-d359-4ff6-aee1-fbc84437efec@leemhuis.info>
Date:   Tue, 17 Oct 2023 07:33:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] staging: rtl8192u: Remove broken driver
To:     Philipp Hortmann <philipp.g.hortmann@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Cc:     Arnd Bergmann <arnd@arndb.de>, Kalle Valo <kvalo@kernel.org>,
        Larry Finger <Larry.Finger@lwfinger.net>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
References: <20231014211051.GA29518@matrix-ESPRIMO-P710>
Content-Language: en-US, de-DE
From:   Thorsten Leemhuis <linux@leemhuis.info>
Autocrypt: addr=linux@leemhuis.info; keydata=
 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 n7RI
In-Reply-To: <20231014211051.GA29518@matrix-ESPRIMO-P710>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;linux@leemhuis.info;1697520832;6052905a;
X-HE-SMSGID: 1qsciE-0005x2-Fn
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14.10.23 23:10, Philipp Hortmann wrote:
> Tests on rtl8192u hardware have shown that this driver is broken since
> 2016. Remove broken driver. Find fix for two bugs in second link.
> 
> Link: https://lore.kernel.org/lkml/db98d9ac-7650-4a72-8eb9-4def1f17ea0d@app.fastmail.com/
> Link: https://lore.kernel.org/lkml/cover.1697089416.git.philipp.g.hortmann@gmail.com/
> Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
> ---
> V2: Added 2x links and adapted description.
> 
> Did not find any artifacts of rtl8192u in MAINTAINERS.
> ---
>  drivers/staging/Kconfig                       |    2 -
>  drivers/staging/rtl8192u/Kconfig              |   12 -
> [...]

My daily linux-next builds for Fedora (based on Fedora rawhide config)
failed today with this error msg:

"""
+ /usr/bin/make -s 'HOSTCFLAGS=-O2  -fexceptions -g
-grecord-gcc-switches -pipe -Wall -Werror=format-security
-Werror=implicit-function-declaration -Werror=implicit-int
-Wp,-U_FORTIFY_SOURCE,-D_FORTIFY_SOURCE=3 -Wp,-D_GLIBCXX_ASSERTIONS
-specs=/usr/lib/rpm/redhat/redhat-hardened-cc1 -fstack-protector-strong
-specs=/usr/lib/rpm/redhat/redhat-annobin-cc1  -m64 -mcpu=power8
-mtune=power8 -fasynchronous-unwind-tables -fstack-clash-protection '
'HOSTLDFLAGS=-Wl,-z,relro -Wl,--as-needed  -Wl,-z,now
-specs=/usr/lib/rpm/redhat/redhat-hardened-ld
-specs=/usr/lib/rpm/redhat/redhat-annobin-cc1  -Wl,--build-id=sha1
-specs=/usr/lib/rpm/redhat/redhat-package-notes ' -j2 mrproper
scripts/Makefile.clean:12: drivers/staging/rtl8192u/Makefile: No such
file or directory
make[5]: *** No rule to make target 'drivers/staging/rtl8192u/Makefile'.
 Stop.
make[4]: *** [scripts/Makefile.clean:61: drivers/staging/rtl8192u] Error 2
make[3]: *** [scripts/Makefile.clean:61: drivers/staging] Error 2
make[3]: *** Waiting for unfinished jobs....
make[2]: *** [scripts/Makefile.clean:61: drivers] Error 2
make[1]: ***
[/builddir/build/BUILD/kernel-next-20231017/linux-6.6.0-0.0.next.20231017.447.vanilla.fc40.ppc64le/Makefile:1920:
_clean_.] Error 2
make: *** [Makefile:236: __sub-make] Error 2
error: Bad exit status from /var/tmp/rpm-tmp.TJDlJV (%build)
"""

Full log:
https://copr-be.cloud.fedoraproject.org/results/@kernel-vanilla/next/fedora-rawhide-ppc64le/06536998-next-next-all/builder-live.log.gz

Made me wonder if this patch left something behind; a quick grep showed
something suspicious in drivers/staging/Makefile:
"""
obj-$(CONFIG_RTL8192U)		+= rtl8192u/
"""

Ciao, Thorsten
