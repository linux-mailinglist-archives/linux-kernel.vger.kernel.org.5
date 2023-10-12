Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E77B7C6EB1
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 15:02:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378422AbjJLNCt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 09:02:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343680AbjJLNCs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 09:02:48 -0400
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD74D91
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 06:02:45 -0700 (PDT)
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-9ae2cc4d17eso155456066b.1
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 06:02:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697115764; x=1697720564;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MZcvOgS6R9Jh5H0fbnyLf7qSXFyijYcnyIvdBSAxHA4=;
        b=YgSzVVJOopjjq7W3Pg28m02I2vnpxlulkrBhQPA3YFSCsSVvZs3+pLIs0JnJly2F8S
         /tWqmT9CAyQI4ZvPX/mdAKVYgvl6fYdDBYA3qaXM7xH32XVO372yvzZBUHMVAG5InRA6
         BTHoYkdq20PdXiOkQdfQRmxG2znTaK1h4cu0UYLG8dUka4fL92KQps01q6cdlk16ePTg
         fw8eqjuIR9Ka+0T0Y0Qhbhdai6hYWp/eT0h5dfBoAgf05+w0Umt8k1eL6NFiK2I1nwv4
         HXJC7KiMORyfgrRMB11jJfKpKE37LYwgw19FwwHBPeEMyNdExQWZ33cvl9Gw0Z+I9SgY
         tSBw==
X-Gm-Message-State: AOJu0Yw1u9jUam0AdRF2gX+lftAS4O1CwRljQlAzBOuOFPgx5saKhqhO
        UiYPl3sGHRyZeAB25puP2Ow=
X-Google-Smtp-Source: AGHT+IGahdJC++NRXVLbK8KyuViV9nJqzj3xRvHYppSU8zc+FH2/q4eF4Ty4m3Vwj72zJUTrEY2a7g==
X-Received: by 2002:a17:906:2249:b0:9ae:5ba3:9d8f with SMTP id 9-20020a170906224900b009ae5ba39d8fmr22050826ejr.17.1697115763879;
        Thu, 12 Oct 2023 06:02:43 -0700 (PDT)
Received: from gmail.com (fwdproxy-cln-011.fbsv.net. [2a03:2880:31ff:b::face:b00c])
        by smtp.gmail.com with ESMTPSA id h16-20020a17090619d000b00997e99a662bsm10976064ejd.20.2023.10.12.06.02.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Oct 2023 06:02:43 -0700 (PDT)
Date:   Thu, 12 Oct 2023 06:02:41 -0700
From:   Breno Leitao <leitao@debian.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     tglx@linutronix.de, bp@alien8.de, Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>, leit@meta.com,
        "open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)" 
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4] x86/bugs: Add a separate config for each mitigation
Message-ID: <ZSfucR6docdnLznb@gmail.com>
References: <20231010103028.4192223-1-leitao@debian.org>
 <ZSca08rnmZfkONEH@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZSca08rnmZfkONEH@gmail.com>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Ingo,

On Wed, Oct 11, 2023 at 11:59:47PM +0200, Ingo Molnar wrote:
> 
> * Breno Leitao <leitao@debian.org> wrote:

> > +#if IS_ENABLED(CONFIG_MITIGATE_RETBLEED)
> >  static enum retbleed_mitigation_cmd retbleed_cmd __ro_after_init =
> >  	RETBLEED_CMD_AUTO;
> > +#else
> > +static enum retbleed_mitigation_cmd retbleed_cmd __ro_after_init =
> > +	RETBLEED_CMD_OFF;
> > +#endif
> 
> 1)
> 
> Yeah, so this #ifdeffery is unnecessarily ugly - we can actually assign 
> integer values in the Kconfig language and use that for initialization.
> 
> Is there a reason why we wouldn't want to do something like:
> 
> 	static enum retbleed_mitigation_cmd retbleed_cmd __ro_after_init = CONFIG_BOOT_DEFAULT_X86_MITIGATE_RETBLEED;
> 
> ... or so?

Yes. There are two reasons rigth now:

1) How to avoid the "undefined" behaviour when
CONFIG_BOOT_DEFAULT_X86_MITIGATE_RETBLEED is not defined ? Something as:

 error: ‘CONFIG_BOOT_DEFAULT_X86_MITIGATE_RETBLEED’ undeclared (first use in this function)

2) Right now, these _cmd values are all different by default. Here are a few
examples when the kernel is compiled with the mitigations:

 retbleed_cmd = RETBLEED_CMD_AUTO (1)
 spectre_v2_mitigation_cmd = SPECTRE_V2_CMD_AUTO (1)
 ssb_mitigation_cmd = SPEC_STORE_BYPASS_CMD_AUTO (1)
 l1tf_mitigation = L1TF_MITIGATION_FLUSH(2)
 mds_mitigation =  MDS_MITIGATION_FULL(1)
 taa_mitigation = TAA_MITIGATION_VERW (2)
 mmio_mitigation = MMIO_MITIGATION_VERW (2)
 gds_mitigation =  GDS_MITIGATION_FULL (3)

If there is a solution for 1, then I _think_ we can probably reorder the
enums, so, the "AUTO" value is always 1?!


> 2)
> 
> The new Kconfig namespace should probably be X86_MITIGATE_*, so that we 
> don't crowd the generic kernel's Kconfig namespace.

There is another sub-thread under this patchset that is discussing
naming as well. Boris wants to keep it as simple as it is today:

https://lore.kernel.org/all/20231011190317.GDZSbxdd5TuCIp5+JN@fat_crate.local/

> 3)
> 
> And yes, now that the rush of CPU vulnerabilities seems to be ebbing, we 
> should probably consider unifying the existing hodgepodge of mitigation 
> Kconfig options as well, to not build up even more technical debt.

What do you mean by unifying the existing hodgepodge of mitigation
Kconfigs? If you are implying to just have fewer config options, I think
that is the opposite of what Linus has suggested previously:

https://lore.kernel.org/all/CAHk-=wjTHeQjsqtHcBGvy9TaJQ5uAm5HrCDuOD9v7qA9U1Xr4w@mail.gmail.com/

> 4)
> 
> Fourth, I think we should inform users (in the boot log) when a kernel 
> .config changes a mitigation default value compared from what the upstream 
> kernel thinks is a suitable default.
> 
> Sometimes it can be a simple configuration mistake, or a user might have 
> different opinion about the importance of a particular mitigation. Nothing 
> heavy-handed, just a simple pr_info() table of changes?

That could be done, but, right now messages are printed in regard to the
mitigations. Aren't these enough?

Here are some examples:

  pr_info("MDS: %s\n", mds_strings[mds_mitigation]);
  pr_info("TAA: %s\n", taa_strings[taa_mitigation]);
  pr_info("MMIO Stale Data: %s\n", mmio_strings[mmio_mitigation]);
  pr_info("MMIO Stale Data: Unknown: No mitigations\n");
  pr_info("%s\n", srbds_strings[srbds_mitigation]);
  pr_info("%s\n", gds_strings[gds_mitigation]);
  pr_info("%s\n", spectre_v1_strings[spectre_v1_mitigation]);
  pr_info("%s\n", spectre_v2_user_strings[mode]);
  pr_info("%s\n", retbleed_strings[retbleed_mitigation]);
  pr_info("%s\n", ssb_strings[ssb_mode]);


Thanks for the review!
