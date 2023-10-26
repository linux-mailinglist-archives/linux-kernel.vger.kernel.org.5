Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6502F7D8742
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 19:09:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345302AbjJZRJa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Oct 2023 13:09:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231774AbjJZRJ2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 13:09:28 -0400
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F555116
        for <linux-kernel@vger.kernel.org>; Thu, 26 Oct 2023 10:09:22 -0700 (PDT)
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-53ed4688b9fso1757375a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 26 Oct 2023 10:09:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698340161; x=1698944961;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e0o7jDaoKx4+0wnIpeEC5Hmyo14WMLzTeYk9uPnzim0=;
        b=l4jU/y/FdwslPLlOfTZblCepQrlX0k7mq6W/j75+ICjKJr2qbwxSMTrxB3NksKNNZI
         8WNghW0KXhM+DYEohczgs8s2nM+E48xa33GxxPj1ocL5Hf2S7d4xktp0V+dHGasm1yK5
         jbeeqAvpJ181OVKCEd7J5+sHb+bP2UQFN24lKrbhk68BSqQaJfKrmQN4w5vA3/oC/kUq
         y8s+Hlev6tTUhE8ciNXC0ypr26AbxBkOI15c660EG9VoGjM+/IyaqgFk3/pC+kz0ShZ8
         FX+2PfwFyeT11q7Q2bsr0mzM9CLrG6v+txxB+zPDW41crsPUCb37jIe/jZ6O9gFCivpK
         hhnQ==
X-Gm-Message-State: AOJu0YzLPGJfAodIE3gixD9rYMMEhPkzPmUDaLBkh7NmJuaujMn25yu/
        QCdOBgPKgdzP3pQ2NPO2yqKEvCHcL+c=
X-Google-Smtp-Source: AGHT+IGjeJoc67HE5c4wCr+k/fz6Sq0roZVXr149m3vhp1XY47hneTuiX+xuDYNoVGVqY6IyiSKHxg==
X-Received: by 2002:a05:6402:792:b0:53f:ba1a:800d with SMTP id d18-20020a056402079200b0053fba1a800dmr381395edy.14.1698340159898;
        Thu, 26 Oct 2023 10:09:19 -0700 (PDT)
Received: from gmail.com (fwdproxy-cln-000.fbsv.net. [2a03:2880:31ff::face:b00c])
        by smtp.gmail.com with ESMTPSA id h12-20020aa7de0c000000b0053e43492ef1sm11376792edv.65.2023.10.26.10.09.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Oct 2023 10:09:19 -0700 (PDT)
Date:   Thu, 26 Oct 2023 10:09:17 -0700
From:   Breno Leitao <leitao@debian.org>
To:     Josh Poimboeuf <jpoimboe@kernel.org>
Cc:     mingo@redhat.com, tglx@linutronix.de, bp@alien8.de,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>, leit@meta.com,
        "open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)" 
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v5 12/12] x86/bugs: Add a separate config for missing
 mitigation
Message-ID: <ZTqdPc59HWBdP269@gmail.com>
References: <20231019181158.1982205-1-leitao@debian.org>
 <20231019181158.1982205-13-leitao@debian.org>
 <20231025162906.abnyb7xum7cpjwxy@treble>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231025162906.abnyb7xum7cpjwxy@treble>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Josh,

On Wed, Oct 25, 2023 at 09:29:06AM -0700, Josh Poimboeuf wrote:
> On Thu, Oct 19, 2023 at 11:11:58AM -0700, Breno Leitao wrote:
> > Currently, the CONFIG_SPECULATION_MITIGATIONS is halfway populated,
> > where some mitigations have entries in Kconfig, and they could be
> > modified, while others mitigations do not have Kconfig entries, and
> > could not be controlled at build time.
> > 
> > Create an entry for each CPU mitigation under
> > CONFIG_SPECULATION_MITIGATIONS. This allow users to enable or disable
> > them at compilation time.
> > 
> > Signed-off-by: Breno Leitao <leitao@debian.org>
> 
> We also probably need a CONFIG_MITIGATION_MELTDOWN.

Isn't Meltdown covered by the MITIGATION_PAGE_TABLE_ISOLATION Kconfig
entry? Would you mind clarifying what would be the difference between
CONFIG_MITIGATION_MELTDOWN and MITIGATION_PAGE_TABLE_ISOLATION, and why
do we want CONFIG_MITIGATION_MELTDOWN?

> > ---
> >  arch/x86/Kconfig           | 93 ++++++++++++++++++++++++++++++++++++++
> >  arch/x86/kernel/cpu/bugs.c | 39 ++++++++++------
> >  2 files changed, 117 insertions(+), 15 deletions(-)

<snip>

> > +config MITIGATION_SRBDS
> > +	bool "Mitigate Special Register Buffer Data Sampling (SRBDS) hardware bug"
> > +	depends on CPU_SUP_INTEL
> > +	default y
> > +	help
> > +	  Enable mitigation for Special Register Buffer Data Sampling (SRBDS).
> > +	  SRBDS is a hardware vulnerability that allows Microarchitectural Data
> > +	  Sampling (MDS) techniques to infer values returned from special
> > +	  register accesses. An unprivileged user can extract values returned
> > +	  from RDRAND and RDSEED executed on another core or sibling thread
> > +	  using MDS techniques.
> 
> Refer to Documentation/admin-guide/hw-vuln/special-register-buffer-data-sampling.rst

Sure, I will update this and all the other suggestions that were cut
above. Thanks!

> > +	cmd = IS_ENABLED(CONFIG_MITIGATION_SPECTRE_V2) ?  SPECTRE_V2_CMD_AUTO : SPECTRE_V2_CMD_NONE;
> >  	if (cmdline_find_option_bool(boot_command_line, "nospectre_v2") ||
> >  	    cpu_mitigations_off())
> >  		return SPECTRE_V2_CMD_NONE;
> 
> I'm thinking CONFIG_MITIGATION_SPECTRE_V2 should also affect whether the spectre v2 user
> mitigation gets enabled.

Makes sense, would something like this be enough?

diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index 11ccbadd8800..cfcdbfa72a81 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -1221,8 +1221,10 @@ static __ro_after_init enum spectre_v2_mitigation_cmd spectre_v2_cmd;
 static enum spectre_v2_user_cmd __init
 spectre_v2_parse_user_cmdline(void)
 {
+       int ret, i, mode;
        char arg[20];
-       int ret, i;
+
+       mode = IS_ENABLED(CONFIG_MITIGATION_SPECTRE_V2) ? SPECTRE_V2_USER_CMD_AUTO : SPECTRE_V2_USER_CMD_NONE;

        switch (spectre_v2_cmd) {
        case SPECTRE_V2_CMD_NONE:
@@ -1236,7 +1238,7 @@ spectre_v2_parse_user_cmdline(void)
        ret = cmdline_find_option(boot_command_line, "spectre_v2_user",
                                  arg, sizeof(arg));
        if (ret < 0)
-               return SPECTRE_V2_USER_CMD_AUTO;
+               return mode;

        for (i = 0; i < ARRAY_SIZE(v2_user_options); i++) {
                if (match_option(arg, ret, v2_user_options[i].option)) {
@@ -1246,8 +1248,8 @@ spectre_v2_parse_user_cmdline(void)
                }
        }

-       pr_err("Unknown user space protection option (%s). Switching to AUTO select\n", arg);
-       return SPECTRE_V2_USER_CMD_AUTO;
+       pr_err("Unknown user space protection option (%s). Switching to default\n", arg);
+       return mode;
 }

