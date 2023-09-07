Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79A51797F4D
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Sep 2023 01:44:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240463AbjIGXoR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Sep 2023 19:44:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231601AbjIGXoQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Sep 2023 19:44:16 -0400
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEC1F1BD2
        for <linux-kernel@vger.kernel.org>; Thu,  7 Sep 2023 16:44:12 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id 550855C009E;
        Thu,  7 Sep 2023 19:44:12 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Thu, 07 Sep 2023 19:44:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1694130252; x=1694216652; bh=q5gchdWfXi6gz
        h8043+yIcq3FXTYfVp0J8SuZntpZm4=; b=FxPjoUcRadtqSeYFehso6rWtrz3SC
        pnei1qqAH8luZIS3w/dEznGBdbQjPtR4oieFyJqDY+wmtA29Gm3FfxvmQptn0Pul
        tu6LpEo4I6MWSGhRosuXZW5KBSQfLMXnXOJkDAChE2K5XMkZlQFKkXxBPnKPJHXO
        vFkuR6t1OjhLnOt5i22yb3GJ60Ribz8FFtgBBPqGzZ+MkGEdJy99B83sgYQMbfPC
        z7azGEjZwB8AvjFyRgt2jWY4WBQARAaiE8+xYmL6plM83fPqbzwNWKtV4qlCypYV
        Q1bPKqAS9llA1pOgcg/Nb9k5impTG0UstWih127pg/QF+DHjPbC6IshvQ==
X-ME-Sender: <xms:S2D6ZIr-oOoMaEp4AQCGknlXu253c0Mu5a3z88ut8e4_BDbXqJ_XbA>
    <xme:S2D6ZOp4aiaNrv8PoKwT8cb_ekIffWNaadChXK45AMBpe5hTaM0_DRiDM9yb28Ohl
    CXauIbb3fNnUQAP7KI>
X-ME-Received: <xmr:S2D6ZNMPEF90lZisvvGIB0l9-XfU4nV8F7X8ezRgrJDSIELB7bDz5pM-9GBRue2izttAh0zl_OUXOfYNbuMdz_UbWIGYML7idGU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrudehiedgvdejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevufgjkfhfgggtsehttdertddttddvnecuhfhrohhmpefhihhnnhcu
    vfhhrghinhcuoehfthhhrghinheslhhinhhugidqmheikehkrdhorhhgqeenucggtffrrg
    htthgvrhhnpeelueehleehkefgueevtdevteejkefhffekfeffffdtgfejveekgeefvdeu
    heeuleenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hfthhhrghinheslhhinhhugidqmheikehkrdhorhhg
X-ME-Proxy: <xmx:S2D6ZP66db3jVxyOd1lLgU-WclItNVAUtE5K2_qnbYBqr_94mu9rvg>
    <xmx:S2D6ZH6WjFPLImbtGKLVGEUvV2MEsNVMASj8H_JrR7JALKyQ1LvDVQ>
    <xmx:S2D6ZPjjH2P2oq9Nb1D_5_YS1JBG6S0-mBHDUpesdzzo5mg03ohy4w>
    <xmx:TGD6ZKYRbBK5KoAPWLQuZEctNvtjDbESYcnY8kxVxK6mg8wvnKQPPA>
Feedback-ID: i58a146ae:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 7 Sep 2023 19:44:08 -0400 (EDT)
Date:   Fri, 8 Sep 2023 09:44:21 +1000 (AEST)
From:   Finn Thain <fthain@linux-m68k.org>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
cc:     linux-m68k@lists.linux-m68k.org, Arnd Bergmann <arnd@arndb.de>,
        Michael Schmitz <schmitzmic@gmail.com>,
        Philip Blundell <philb@gnu.org>,
        Greg Ungerer <gerg@linux-m68k.org>,
        Joshua Thompson <funaho@jurai.org>,
        Sam Creasey <sammy@sammy.net>,
        Laurent Vivier <laurent@vivier.eu>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 32/52] m68k: mac: Add and use "mac.h"
In-Reply-To: <e9f3da9b152b7d19b64d775d04e9e11b63dc35b6.1694093327.git.geert@linux-m68k.org>
Message-ID: <1c7894fe-4cf4-1ad9-5ed2-aaab4351ff4c@linux-m68k.org>
References: <cover.1694093327.git.geert@linux-m68k.org> <e9f3da9b152b7d19b64d775d04e9e11b63dc35b6.1694093327.git.geert@linux-m68k.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 7 Sep 2023, Geert Uytterhoeven wrote:

> diff --git a/arch/m68k/mac/baboon.c b/arch/m68k/mac/baboon.c
> index a7d280220662c747..5c97a7058bcdee2e 100644
> --- a/arch/m68k/mac/baboon.c
> +++ b/arch/m68k/mac/baboon.c
> @@ -15,6 +15,8 @@
>  #include <asm/macints.h>
>  #include <asm/mac_baboon.h>
>  
> +#include "mac.h"
> +
>  int baboon_present;
>  static volatile struct baboon *baboon;
>  
> diff --git a/arch/m68k/mac/config.c b/arch/m68k/mac/config.c
> index d56affefd5cabeb5..e324410ef239c09f 100644
> --- a/arch/m68k/mac/config.c
> +++ b/arch/m68k/mac/config.c
> @@ -50,22 +50,14 @@
>  #include <asm/mac_psc.h>
>  #include <asm/config.h>
>  
> +#include "mac.h"
> +
>  /* Mac bootinfo struct */
>  struct mac_booter_data mac_bi_data;
>  
>  /* The phys. video addr. - might be bogus on some machines */
>  static unsigned long mac_orig_videoaddr;
>  
> -extern int mac_hwclk(int, struct rtc_time *);
> -extern void iop_init(void);
> -extern void via_init(void);
> -extern void via_init_clock(void);
> -extern void oss_init(void);
> -extern void psc_init(void);
> -extern void baboon_init(void);
> -
> -extern void mac_mksound(unsigned int, unsigned int);
> -
>  static void mac_get_model(char *str);
>  static void mac_identify(void);
>  static void mac_report_hardware(void);
> diff --git a/arch/m68k/mac/iop.c b/arch/m68k/mac/iop.c
> index 010b3b5ae8e8584a..a92740d530ac4fbe 100644
> --- a/arch/m68k/mac/iop.c
> +++ b/arch/m68k/mac/iop.c
> @@ -119,6 +119,8 @@
>  #include <asm/macints.h>
>  #include <asm/mac_iop.h>
>  
> +#include "mac.h"
> +
>  #ifdef DEBUG
>  #define iop_pr_debug(fmt, ...) \
>  	printk(KERN_DEBUG "%s: " fmt, __func__, ##__VA_ARGS__)
> diff --git a/arch/m68k/mac/mac.h b/arch/m68k/mac/mac.h
> new file mode 100644
> index 0000000000000000..d3d142cea3b4b911
> --- /dev/null
> +++ b/arch/m68k/mac/mac.h
> @@ -0,0 +1,25 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +
> +struct rtc_time;
> +

I don't think we need a new header file. Related function prototypes 
already have homes in existing header files --

> +/* baboon.c */
> +void baboon_init(void);
> +

this could go into mac_baboon.h

> +/* iop.c */
> +void iop_init(void);
> +

mac_iop.h

> +/* misc.c */
> +int mac_hwclk(int op, struct rtc_time *t);
> +

macintosh.h

> +/* macboing.c */
> +void mac_mksound(unsigned int freq, unsigned int length);
> +

mac_asc.h

> +/* oss.c */
> +void oss_init(void);
> +

mac_oss.h

> +/* psc.c */
> +void psc_init(void);
> +

mac_psc.h

> +/* via.c */
> +void via_init(void);
> +void via_init_clock(void);

mac_via.h

> diff --git a/arch/m68k/mac/macboing.c b/arch/m68k/mac/macboing.c
> index 76431241347682fc..faea2265a540192d 100644
> --- a/arch/m68k/mac/macboing.c
> +++ b/arch/m68k/mac/macboing.c
> @@ -16,6 +16,8 @@
>  #include <asm/macintosh.h>
>  #include <asm/mac_asc.h>
>  
> +#include "mac.h"
> +
>  static int mac_asc_inited;
>  /*
>   * dumb triangular wave table
> diff --git a/arch/m68k/mac/misc.c b/arch/m68k/mac/misc.c
> index 65107abc8848232c..4c8f8cbfa05f3404 100644
> --- a/arch/m68k/mac/misc.c
> +++ b/arch/m68k/mac/misc.c
> @@ -25,6 +25,8 @@
>  
>  #include <asm/machdep.h>
>  
> +#include "mac.h"
> +
>  /*
>   * Offset between Unix time (1970-based) and Mac time (1904-based). Cuda and PMU
>   * times wrap in 2040. If we need to handle later times, the read_time functions
> diff --git a/arch/m68k/mac/oss.c b/arch/m68k/mac/oss.c
> index 921e6c092f2c6626..1641607f300d981c 100644
> --- a/arch/m68k/mac/oss.c
> +++ b/arch/m68k/mac/oss.c
> @@ -27,6 +27,8 @@
>  #include <asm/mac_via.h>
>  #include <asm/mac_oss.h>
>  
> +#include "mac.h"
> +
>  int oss_present;
>  volatile struct mac_oss *oss;
>  
> diff --git a/arch/m68k/mac/psc.c b/arch/m68k/mac/psc.c
> index 0d0965b19c09b439..b4183cf66efef7f5 100644
> --- a/arch/m68k/mac/psc.c
> +++ b/arch/m68k/mac/psc.c
> @@ -26,6 +26,8 @@
>  #include <asm/macints.h>
>  #include <asm/mac_psc.h>
>  
> +#include "mac.h"
> +
>  #define DEBUG_PSC
>  
>  volatile __u8 *psc;
> diff --git a/arch/m68k/mac/via.c b/arch/m68k/mac/via.c
> index 3d11d6219cdd56da..01e6b0e37f8dd0e8 100644
> --- a/arch/m68k/mac/via.c
> +++ b/arch/m68k/mac/via.c
> @@ -38,6 +38,8 @@
>  #include <asm/mac_psc.h>
>  #include <asm/mac_oss.h>
>  
> +#include "mac.h"
> +
>  volatile __u8 *via1, *via2;
>  int rbv_present;
>  int via_alt_mapping;
> 
