Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48EF4788C0F
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 17:02:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343842AbjHYPBp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Aug 2023 11:01:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343879AbjHYPBU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Aug 2023 11:01:20 -0400
X-Greylist: delayed 88 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 25 Aug 2023 08:01:17 PDT
Received: from smtp-42a8.mail.infomaniak.ch (smtp-42a8.mail.infomaniak.ch [84.16.66.168])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E6202126;
        Fri, 25 Aug 2023 08:01:17 -0700 (PDT)
Received: from smtp-3-0001.mail.infomaniak.ch (unknown [10.4.36.108])
        by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4RXNSW6BLlzMrQRp;
        Fri, 25 Aug 2023 15:01:15 +0000 (UTC)
Received: from unknown by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4RXNSV4QTMzMppB6;
        Fri, 25 Aug 2023 17:01:14 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=digikod.net;
        s=20191114; t=1692975675;
        bh=OSWgiupN6r3xc6GohyM7Ufm5JcLmepgwISMqZyG+Kaw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=syS9ukBZkb5WhWKzZgOpazkKcKMqOApNoYo45yVagq1T8plCpSy9PDfniFaKBBdNo
         Browhp0n9Kkst6gX5L6nLEvTcclMD6prEzSJsINi6G9XMJLyLxuEB+el/AsRW3cx2m
         h6CHOsji4/0Hy+vGGeNeHQhs2RXTpt9BvXze8Ouc=
Date:   Fri, 25 Aug 2023 17:01:11 +0200
From:   =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To:     Casey Schaufler <casey@schaufler-ca.com>
Cc:     paul@paul-moore.com, linux-security-module@vger.kernel.org,
        jmorris@namei.org, serge@hallyn.com, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        stephen.smalley.work@gmail.com, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org
Subject: Re: [PATCH v13 11/11] LSM: selftests for Linux Security Module
 syscalls
Message-ID: <20230825.OokahF6aezae@digikod.net>
References: <20230802174435.11928-1-casey@schaufler-ca.com>
 <20230802174435.11928-12-casey@schaufler-ca.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230802174435.11928-12-casey@schaufler-ca.com>
X-Infomaniak-Routing: alpha
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These tests look good!

I suggested other tests to add in my previous emails.

I'd suggest to re-run clang-format -i on them though.

On Wed, Aug 02, 2023 at 10:44:34AM -0700, Casey Schaufler wrote:
> Add selftests for the three system calls supporting the LSM
> infrastructure. This set of tests is limited by the differences
> in access policy enforced by the existing security modules.
> 
> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
> ---
>  MAINTAINERS                                   |   1 +
>  tools/testing/selftests/Makefile              |   1 +
>  tools/testing/selftests/lsm/Makefile          |  19 ++
>  tools/testing/selftests/lsm/common.c          |  81 ++++++
>  tools/testing/selftests/lsm/common.h          |  33 +++
>  tools/testing/selftests/lsm/config            |   3 +
>  .../selftests/lsm/lsm_get_self_attr_test.c    | 240 ++++++++++++++++++
>  .../selftests/lsm/lsm_list_modules_test.c     | 140 ++++++++++
>  .../selftests/lsm/lsm_set_self_attr_test.c    |  74 ++++++
>  9 files changed, 592 insertions(+)
>  create mode 100644 tools/testing/selftests/lsm/Makefile
>  create mode 100644 tools/testing/selftests/lsm/common.c
>  create mode 100644 tools/testing/selftests/lsm/common.h
>  create mode 100644 tools/testing/selftests/lsm/config
>  create mode 100644 tools/testing/selftests/lsm/lsm_get_self_attr_test.c
>  create mode 100644 tools/testing/selftests/lsm/lsm_list_modules_test.c
>  create mode 100644 tools/testing/selftests/lsm/lsm_set_self_attr_test.c
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index aca4db11dd02..c96f1c388d22 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -19158,6 +19158,7 @@ W:	http://kernsec.org/
>  T:	git git://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/lsm.git
>  F:	include/uapi/linux/lsm.h
>  F:	security/
> +F:	tools/testing/selftests/lsm/
>  X:	security/selinux/
>  
>  SELINUX SECURITY MODULE
> diff --git a/tools/testing/selftests/Makefile b/tools/testing/selftests/Makefile
> index 666b56f22a41..bde7c217b23f 100644
> --- a/tools/testing/selftests/Makefile
> +++ b/tools/testing/selftests/Makefile
> @@ -39,6 +39,7 @@ TARGETS += landlock
>  TARGETS += lib
>  TARGETS += livepatch
>  TARGETS += lkdtm
> +TARGETS += lsm
>  TARGETS += membarrier
>  TARGETS += memfd
>  TARGETS += memory-hotplug
> diff --git a/tools/testing/selftests/lsm/Makefile b/tools/testing/selftests/lsm/Makefile
> new file mode 100644
> index 000000000000..bae6c1e3bba4
> --- /dev/null
> +++ b/tools/testing/selftests/lsm/Makefile
> @@ -0,0 +1,19 @@
> +# SPDX-License-Identifier: GPL-2.0
> +#
> +# First run: make -C ../../../.. headers_install
> +
> +CFLAGS += -Wall -O2 $(KHDR_INCLUDES)
> +LOCAL_HDRS += common.h
> +
> +TEST_GEN_PROGS := lsm_get_self_attr_test lsm_list_modules_test \
> +		  lsm_set_self_attr_test
> +
> +include ../lib.mk
> +
> +$(TEST_GEN_PROGS):

This target can be removed.

> +
> +$(OUTPUT)/lsm_get_self_attr_test: lsm_get_self_attr_test.c common.c
> +$(OUTPUT)/lsm_set_self_attr_test: lsm_set_self_attr_test.c common.c
> +$(OUTPUT)/lsm_list_modules_test: lsm_list_modules_test.c common.c
> +
> +EXTRA_CLEAN = $(OUTPUT)/common.o
