Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA4117C5FC9
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 23:59:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376421AbjJKV7y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 17:59:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233339AbjJKV7x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 17:59:53 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 472109E
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 14:59:52 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id a640c23a62f3a-9ba1eb73c27so48240566b.3
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 14:59:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697061591; x=1697666391; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=P4ZKjGCx4nApKCYikS19QgH43+qwtiZ1ddNEcQjQDUQ=;
        b=P9+Pa+DX1AocSbG207uq9xIOvrkemHafQT+jIeWs7XtTgQZzSI17l0CpAbD4XX492q
         5YsWdH02YxWPJYeum2EmAWX5xECaabmms8UOcgfVEAVoIS0zko/WC+SNtJGs+b1jzcTo
         oLrAf64k0x5fxs3aEU263i1l9Y1yYr2ed2wb6qpCQevMBL6IxHeSFB3AwgXyHEyr0H+U
         YDHH8kFZG90/OwQ5IElY/kFzaBPDOmN83ZlqTuiEEGROEDY2FXBTQEKHWKFtMOqMDCGO
         yRvut1jRApuOEm6e3DqDMVGrVYpfCmhUgqbuxetfClsJ3p53zAhArR39Knjj/RuhTcmC
         fejQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697061591; x=1697666391;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=P4ZKjGCx4nApKCYikS19QgH43+qwtiZ1ddNEcQjQDUQ=;
        b=oUZHQ/YyEsAlmo1hQelq9SQVsuXCtr95GZX+vTT1m0x9m7yFBd8vdxGyjgLJGBWvJ+
         jvft6HS6ELuTJ2h25eG7XpjAbBPU1DhwZ0Qa/KkGxuYJ+mngR5G1zeHafws8+pbWxh3Q
         EiTfVV5gSI4iITstX0LJItSK36CxC1lFIagDj9jXZe4zcIW6WJV6LDOXwoHVLI7916yx
         B0dgkK8FbLNA8uKP/+u9Jmjde30qpZQag00xkKZGPxQzHc7zBfh3zEkOetAABbaxGfSI
         mjKsN/CazGyJf6mwWgwuauqLcigsnLlXhhKwabkAsiDAXc9DBtYtetLgk2HGGSloBzEc
         I0CA==
X-Gm-Message-State: AOJu0Yw+zBg1GJhcO+3wSGurz0hjeWX5M8V17NzeUaaLkGNBw28tUw9s
        y3wEh654/wdz0TmBS+3Su9s=
X-Google-Smtp-Source: AGHT+IFFQEX/2zN2S57PAqVp9/9LmuvQHcMM5rTusTvYCsiu+ds+OJ8190vUDhz+8xprA3/gJYbGIw==
X-Received: by 2002:a17:906:2929:b0:9b8:df8e:cbde with SMTP id v9-20020a170906292900b009b8df8ecbdemr17627616ejd.51.1697061590579;
        Wed, 11 Oct 2023 14:59:50 -0700 (PDT)
Received: from gmail.com (1F2EF405.nat.pool.telekom.hu. [31.46.244.5])
        by smtp.gmail.com with ESMTPSA id l12-20020a170906078c00b009b94fe3fc47sm10228660ejc.159.2023.10.11.14.59.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Oct 2023 14:59:49 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Wed, 11 Oct 2023 23:59:47 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Breno Leitao <leitao@debian.org>
Cc:     tglx@linutronix.de, bp@alien8.de, Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>, leit@meta.com,
        "open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)" 
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4] x86/bugs: Add a separate config for each mitigation
Message-ID: <ZSca08rnmZfkONEH@gmail.com>
References: <20231010103028.4192223-1-leitao@debian.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231010103028.4192223-1-leitao@debian.org>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Breno Leitao <leitao@debian.org> wrote:

> +config MITIGATE_MDS
> +	bool "Mitigate Microarchitectural Data Sampling (MDS) hardware bug"

> +config MITIGATE_TAA
> +	bool "Mitigate TSX Asynchronous Abort (TAA) hardware bug"

> +config MITIGATE_MMIO_STALE_DATA
> +	bool "Mitigate MMIO Stale Data hardware bug"

> +config MITIGATE_L1TF
> +	bool "Mitigate L1 Terminal Fault (L1TF) hardware bug"

> +config MITIGATE_RETBLEED
> +	bool "Mitigate RETBleed hardware bug"

> +config MITIGATE_SPECTRE_V1
> +	bool "Mitigate SPECTRE V1 hardware bug"

> +config MITIGATE_SPECTRE_V2
> +	bool "Mitigate SPECTRE V2 hardware bug"

> +config MITIGATE_SRBDS
> +	bool "Mitigate Special Register Buffer Data Sampling (SRBDS) hardware bug"

> +config MITIGATE_SSB
> +	bool "Mitigate Speculative Store Bypass (SSB) hardware bug"

> +#if IS_ENABLED(CONFIG_MITIGATE_RETBLEED)
>  static enum retbleed_mitigation_cmd retbleed_cmd __ro_after_init =
>  	RETBLEED_CMD_AUTO;
> +#else
> +static enum retbleed_mitigation_cmd retbleed_cmd __ro_after_init =
> +	RETBLEED_CMD_OFF;
> +#endif

1)

Yeah, so this #ifdeffery is unnecessarily ugly - we can actually assign 
integer values in the Kconfig language and use that for initialization.

Is there a reason why we wouldn't want to do something like:

	static enum retbleed_mitigation_cmd retbleed_cmd __ro_after_init = CONFIG_BOOT_DEFAULT_X86_MITIGATE_RETBLEED;

... or so?

2)

The new Kconfig namespace should probably be X86_MITIGATE_*, so that we 
don't crowd the generic kernel's Kconfig namespace.

3)

And yes, now that the rush of CPU vulnerabilities seems to be ebbing, we 
should probably consider unifying the existing hodgepodge of mitigation 
Kconfig options as well, to not build up even more technical debt.

The churn factor seems moderate:

  kepler:~/tip> git grep CONFIG_RETPOLINE | wc -l
  52

  kepler:~/tip> git grep RETHUNK | wc -l
  42

  kepler:~/tip> git grep CALL_DEPTH_TRACKING | wc -l
  24

... and since most of this code is maintained in the same tree, the usual 
arguments against churn (interfering with other Git trees) does not apply 
nearly as much.

4)

Fourth, I think we should inform users (in the boot log) when a kernel 
.config changes a mitigation default value compared from what the upstream 
kernel thinks is a suitable default.

Sometimes it can be a simple configuration mistake, or a user might have 
different opinion about the importance of a particular mitigation. Nothing 
heavy-handed, just a simple pr_info() table of changes?

Thanks,

	Ingo
