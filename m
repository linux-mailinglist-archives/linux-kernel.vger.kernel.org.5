Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 731AE75BCBA
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 05:19:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229944AbjGUDTH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 23:19:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229557AbjGUDTF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 23:19:05 -0400
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A135A272A;
        Thu, 20 Jul 2023 20:19:04 -0700 (PDT)
Received: by mail-pg1-x52f.google.com with SMTP id 41be03b00d2f7-55b5a3915f5so835565a12.0;
        Thu, 20 Jul 2023 20:19:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689909544; x=1690514344;
        h=content-transfer-encoding:subject:cc:from:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JnZZLXKopoPDJZvlIe8Qkn79tGnv8EjnYImRJi/CMeQ=;
        b=OKJCRsLgzRojvIEOd+G+WO6qOOPYlbEGMnAA3etxOJ15TH8pVpZ91Uj+HLI/eEZM9N
         rsHdmVRWR+lyRyX0XgGoDL5M1HzdfQu2QDsny/+w5kPr/w4UjuSLdt6dFEhYHH4vKRbd
         jeXA62nQZc/vierDW5+n+WlSEswqA76E6yILexTMvg/h/qimCtJA5xlqJFOqm4CBCDrB
         vW7zS5AFR+Han2K8UuYA68AQX/RY7WDkWGaXjcGRjfEE2A+KTQlmBfGU00CLGQ/Ac6KT
         4cWf4FNF8v1MkoryWoTEHDT8Imh5EICCkKl8QfGy01M5V+Bc9+5H3uW/IwOhVJ1VS94D
         HBhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689909544; x=1690514344;
        h=content-transfer-encoding:subject:cc:from:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=JnZZLXKopoPDJZvlIe8Qkn79tGnv8EjnYImRJi/CMeQ=;
        b=Pj4uQqVpDrS7Hmb5IBJQQCvrN4A0/qU6n0ZR8+H0XOSKctHoYnQpTkBNpxiDB72k5e
         M7fsI9IlrugIpqh6It5X8v45amRwq1nvcvq+B3kBxj1laixIPw3JIF/UKLYTK8adT/ic
         ziQ/iED22ICjCaIE5U7sVw2nJdDu1YxyNHjeudn3CI7VV8YYe0/tFiDC3l/niey4o8h8
         sH1XNF2A2XokeKqNMk8FDyjpR3sLYwZnUdaqE1yt/5uNmpMEM1xxWwy5G4mGzUiWwD7S
         UyEZrWTDtm36eXURF+IEFq2Q5AgR+7VlipAtl20UgU0nWTXpCR9avtOF6AruEgJFwD5E
         j9MQ==
X-Gm-Message-State: ABy/qLZ1SwmuKG1BXBAsXsbwg6Yw8gA490mFK3EtAcqWxF9C3EDLaYd3
        xtFPn+T9afhn79vgG8+3f+w=
X-Google-Smtp-Source: APBJJlFSH473ZQlUiP9jUwhRDcbaBihfrQY+6GdViIe2H0d4aBUC/ywhBHN9DLxYCIocDhOIlYvVcg==
X-Received: by 2002:a05:6a20:748b:b0:134:e14c:851b with SMTP id p11-20020a056a20748b00b00134e14c851bmr695853pzd.23.1689909543853;
        Thu, 20 Jul 2023 20:19:03 -0700 (PDT)
Received: from [192.168.0.104] ([103.131.18.64])
        by smtp.gmail.com with ESMTPSA id c7-20020a170902d48700b001b80b342f61sm2134066plg.268.2023.07.20.20.19.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Jul 2023 20:19:03 -0700 (PDT)
Message-ID: <e7292802-e517-6469-6fbd-a4d30887c99b@gmail.com>
Date:   Fri, 21 Jul 2023 10:18:56 +0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Content-Language: en-US
To:     Josh Triplett <josh@joshtriplett.org>,
        Nicolas Schier <nicolas@fjasle.eu>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Sasha Levin <sashal@kernel.org>,
        Brian Lindholm <brian_lindholm@users.sourceforge.net>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Regressions <regressions@lists.linux.dev>,
        Linux Stable <stable@vger.kernel.org>,
        Linux Kernel Build System <linux-kbuild@vger.kernel.org>
Subject: Fwd: 6.4.4 breaks module-free builds of Debian kernel packages
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I notice a regression report on Bugzilla [1]. Quoting from it:

> I'm on AMD64 with Debian testing (trixie), where I build my own kernels (with CONFIG_MODULES unset) using "make bindeb-pkg". The build proceeds through 99% of the process, but fails here:
> 
> Kernel: arch/x86/boot/bzImage is ready  (#2)
> make -f ./Makefile ARCH=x86     KERNELRELEASE=6.4.4-i5 intdeb-pkg
> sh ./scripts/package/builddeb
> ***
> *** The present kernel configuration has modules disabled.
> *** To use the module feature, please run "make menuconfig" etc.
> *** to enable CONFIG_MODULES.
> ***
> make[5]: *** [Makefile:1969: modules_install] Error 1
> make[4]: *** [scripts/Makefile.package:150: intdeb-pkg] Error 2
> make[3]: *** [Makefile:1657: intdeb-pkg] Error 2
> make[2]: *** [debian/rules:16: binary-arch] Error 2
> dpkg-buildpackage: error: debian/rules binary subprocess returned exit status 2
> make[1]: *** [scripts/Makefile.package:139: bindeb-pkg] Error 2
> make: *** [Makefile:1657: bindeb-pkg] Error 2
> 
> 6.3.13 contained the same error, but I "fixed" that by moving to 6.4.3.  But alas, 6.4.4 now has the same issue.
> 
> I worked around the issue by changing "exit 1" to "exit 0" in the main Makefile (at "modules module_install", per the attached patch), but I don't know if this is a true fix or something that simply happens to work for my particular configuration.

See Bugzilla for the full thread and attached patch that ignores the error.

Josh: It looks like this regression is caused by a commit of yours
(and also 1240dabe8d58b4). Would you like to take a look on it?

Anyway, I'm adding this regression to be tracked by regzbot:

#regzbot introduced: 4243afdb932677 https://bugzilla.kernel.org/show_bug.cgi?id=217689
#regzbot title: always doing modules_install breaks CONFIG_MODULES=n builds

Thanks.

[1]: https://bugzilla.kernel.org/show_bug.cgi?id=217689

-- 
An old man doll... just what I always wanted! - Clara
