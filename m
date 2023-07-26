Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 372F8763E83
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 20:30:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231897AbjGZSaj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 14:30:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229562AbjGZSah (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 14:30:37 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8462926BB;
        Wed, 26 Jul 2023 11:30:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:
        Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description;
        bh=mzVsJrG0gE0klDOerZJOODxVbBgujc+wV5trrlssUd4=; b=BNaC7DKnbIUyv0Zyc3uTSHKjc3
        z/yB9RC0260AU6ytrL7L0FWXil+CLLM2LAnpLHghxt6keoF57C1UqmZ1i5vc2JmmX2sevTWor576R
        3ZpWC0MZAeR73mYcaNEFNBicDT/DYQ5NSbET3MHqpJ+MPnEUwwUJoYLgOrTR+Dw5uyPmu4DOSvIYh
        TmeSeH4Va+1xIRJp03mP8h+kzdJnUgNPQMGUMNPlMcVQnfY/3bXxI2SzGIAWbcg+H4GlZuYKlXabb
        HQ+gETQw3H5v9kzXVHN5hBd9oCJE+yPTRzSKgHgYRYcepHpCFLO1S9WHT9wPwFTTZs+Egiyzk0vaS
        MbreCYJA==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1qOjHJ-00BHUf-1o;
        Wed, 26 Jul 2023 18:30:29 +0000
Date:   Wed, 26 Jul 2023 11:30:29 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Allen Webb <allenwebb@google.com>,
        Nick Alcock <nick.alcock@oracle.com>,
        Alexander Lobakin <aleksander.lobakin@intel.com>,
        Alessandro Carminati <alessandro.carminati@gmail.com>
Cc:     "linux-modules@vger.kernel.org" <linux-modules@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        gregkh@linuxfoundation.org, christophe.leroy@csgroup.eu
Subject: Re: [PATCH v10 08/11] build: Add modules.builtin.alias
Message-ID: <ZMFmRdqZDu/z1WxL@bombadil.infradead.org>
References: <20221219204619.2205248-1-allenwebb@google.com>
 <20230406190030.968972-1-allenwebb@google.com>
 <20230406190030.968972-9-allenwebb@google.com>
 <ZG22iPLED+SJsEFa@bombadil.infradead.org>
 <CAJzde04MmfyGeAzQ_7FW-0sATk7TT-MkxCbNPSzb-94wK6nhkA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJzde04MmfyGeAzQ_7FW-0sATk7TT-MkxCbNPSzb-94wK6nhkA@mail.gmail.com>
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Please cc Alexander and Alessandro in future patch series as well,
as they could likley be interested in your work too.

On Wed, Jul 19, 2023 at 02:51:48PM -0500, Allen Webb wrote:
> I finally got a chance to go through the comments and work on a
> follow-up to this series, but it probably makes sense to get this
> sorted ahead of the follow-up (if possible).
> 
> On Wed, May 24, 2023 at 2:02 AM Luis Chamberlain <mcgrof@kernel.org> wrote:
> >
> > On Thu, Apr 06, 2023 at 02:00:27PM -0500, Allen Webb wrote:
> > > Generate modules.builtin.alias using modpost and install it with the
> > > modules.
> >
> > Why? This is probably one of the more important commits and the
> > commit log is pretty slim.
> >
> > > Signed-off-by: Allen Webb <allenwebb@google.com>
> > > ---
> > >  .gitignore               |  1 +
> > >  Makefile                 |  1 +
> > >  scripts/Makefile.modpost | 15 +++++++++++++++
> > >  3 files changed, 17 insertions(+)
> > >
> > > diff --git a/.gitignore b/.gitignore
> > > index 13a7f08a3d73..ddaa622bddac 100644
> > > --- a/.gitignore
> > > +++ b/.gitignore
> > > @@ -71,6 +71,7 @@ modules.order
> > >  /System.map
> > >  /Module.markers
> > >  /modules.builtin
> > > +/modules.builtin.alias
> > >  /modules.builtin.modinfo
> > >  /modules.nsdeps
> > >
> > > diff --git a/Makefile b/Makefile
> > > index a2c310df2145..43dcc1ea5fcf 100644
> > > --- a/Makefile
> > > +++ b/Makefile
> > > @@ -1578,6 +1578,7 @@ __modinst_pre:
> > >       fi
> > >       @sed 's:^\(.*\)\.o$$:kernel/\1.ko:' modules.order > $(MODLIB)/modules.order
> > >       @cp -f modules.builtin $(MODLIB)/
> > > +     @cp -f modules.builtin.alias $(MODLIB)/
> > >       @cp -f $(objtree)/modules.builtin.modinfo $(MODLIB)/
> > >
> > >  endif # CONFIG_MODULES
> > > diff --git a/scripts/Makefile.modpost b/scripts/Makefile.modpost
> > > index 0980c58d8afc..e3ecc17a7a19 100644
> > > --- a/scripts/Makefile.modpost
> > > +++ b/scripts/Makefile.modpost
> > > @@ -15,6 +15,7 @@
> > >  # 2) modpost is then used to
> > >  # 3)  create one <module>.mod.c file per module
> > >  # 4)  create one Module.symvers file with CRC for all exported symbols
> > > +# 5)  create modules.builtin.alias the aliases for built-in modules
> >
> > Does everyone want that file?
> 
> Not everyone needs it so we could exclude it, but the cost of adding
> it isn't that high. I am fine with putting it behind a config, though
> we would need to decide whether to have it default on/off.

We didn't know the cost until I asked, it was the point of asking.
Perhaps Nick, Alessandro or Alexander could use it too later.

> > >  # Step 3 is used to place certain information in the module's ELF
> > >  # section, including information such as:
> > > @@ -63,6 +64,20 @@ modpost-args += -T $(MODORDER)
> > >  modpost-deps += $(MODORDER)
> > >  endif
> > >
> > > +ifneq ($(wildcard vmlinux.o),)
> > > +output-builtin.alias := modules.builtin.alias
> > > +modpost-args += -b .modules.builtin.alias.in
> > > +.modules.builtin.alias.in: $(output-symdump)
> > > +     @# Building $(output-symdump) generates .modules.builtin.alias.in as a
> > > +     @# side effect.
> > > +     @[ -e $@ ] || $(MODPOST) -b .modules.builtin.alias.in vmlinux.o
> >
> > Does using -b create a delay in builds ? What is the effect on build
> > time on a typical 4-core or 8-core build? Does everyone want it?
> 
> Here is some data I collected related to build time and memory usage impact:
> 
> Without builtin.alias:
> TIME="real %e\nuser %U\nsys %S\nres-max %M" time scripts/mod/modpost
> -E -o Module.symvers -T modules.order
> ERROR: modpost: "__x86_return_thunk"
> [arch/x86/crypto/chacha-x86_64.ko] undefined!
> ERROR: modpost: "kernel_fpu_end" [arch/x86/crypto/chacha-x86_64.ko] undefined!
> ERROR: modpost: "hchacha_block_generic"
> [arch/x86/crypto/chacha-x86_64.ko] undefined!
> ERROR: modpost: "boot_cpu_data" [arch/x86/crypto/chacha-x86_64.ko] undefined!
> ERROR: modpost: "static_key_enable" [arch/x86/crypto/chacha-x86_64.ko]
> undefined!
> ERROR: modpost: "cpu_has_xfeatures" [arch/x86/crypto/chacha-x86_64.ko]
> undefined!
> ERROR: modpost: "crypto_register_skciphers"
> [arch/x86/crypto/chacha-x86_64.ko] undefined!
> ERROR: modpost: "crypto_unregister_skciphers"
> [arch/x86/crypto/chacha-x86_64.ko] undefined!
> ERROR: modpost: "__stack_chk_fail" [arch/x86/crypto/chacha-x86_64.ko] undefined!
> ERROR: modpost: "memset" [arch/x86/crypto/chacha-x86_64.ko] undefined!
> WARNING: modpost: suppressed 17432 unresolved symbol warnings because
> there were too many)
> Command exited with non-zero status 1
> real 0.44
> user 0.43
> sys 0.01
> res-max 4896
> 
> With builtin.alias:
> TIME="real %e\nuser %U\nsys %S\nres-max %M" time scripts/mod/modpost
> -E -o Module.symvers -T modules.order -b .modules.builtin.alias.in
> vmlinux.o
> real 1.43
> user 1.38
> sys 0.05
> res-max 51920
> 
> Notice that modpost only uses a single core, so multicore isn't really
> as much of a factor here. While it more than triples the time required
> for the modpost operation the difference is only about one second of
> CPU time. The memory usage is much larger when generating
> modules.builtin.alias because of the size of vmlinux.o.

The modpost impact time of about 1 second for a type of config you used
should be described in your commit log and or kconfig entry to enable
this.

> My biggest performance related concern is actually the size difference
> of vmlinux caused by the modules.h changes, but it looks like that is
> negligible (24KiB):

And this size too.

24 KiB is not that small, so I'd prefer we kconfig'ize it for now and
have those who need it to select it. If we later all want it, we can
default to yes but for now default to no. The default today by
kconfig is to no so an empty default is fine.

> Without builtin.alias:
> du vmlinux.o
> 663048  vmlinux.o
> 
> With builtin.alias:
> du vmlinux.o
> 663072  vmlinux.o

What type of configuration was used? allyesconfig?

> >
> > Should we add a new option which lets people decide if they want this
> > at build time or not?
> 
> I don't feel strongly that there should or should not be a config for
> this. On the side for a config the extra second of CPU time and space
> taken up by the modules.builtin.alias file would add up across all the
> builds and machines, so removing it where it isn't used would help
> mitigate that. On the flip side if it isn't used widely enough, it is
> more likely that breakages are missed until someone who actually uses
> it notices.
> 
> Please let me know if you feel strongly either way given the data.

For now I'd prefer a kconfig option, it's easy to default to y later,
but saving 64 KiB seems like a desirable thing for some folks.

  Luis
