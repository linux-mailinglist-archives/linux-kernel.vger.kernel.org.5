Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB6E07FE4A3
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 01:12:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343726AbjK3ALy convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 29 Nov 2023 19:11:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229677AbjK3ALw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 19:11:52 -0500
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBBA6CA;
        Wed, 29 Nov 2023 16:11:58 -0800 (PST)
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-5c210e34088so343103a12.2;
        Wed, 29 Nov 2023 16:11:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701303118; x=1701907918;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zxF4apxaJBlvMUgBtSsnqaTgi+B++1D1aOFzjuMj80I=;
        b=uu59/6j9Oa9k3+pGZX/3EvYmVB+n9jHP8BWKrhyO20FEAPJONk6s4OdFco0EMTjHur
         sClc4eJrM5dtqX6z71xmtrE9Wg+fv2SPIPy2dRU66JnnTtEFkj8SuPqbDVuTCT4HTgcD
         ran4+SbZCsLGw8NFowvpGltwomz4NlyAUc9QtUxnprJlmnswyMn+IREE/TBbYUzxI0hQ
         oAci2n3S3cqC0VSeBGY6Yaf69cZfAtLBevmA+iKNnEtd27jHg/9uePG7lUf75KQldPCM
         UHPlGO9dASxXjtUcQ3kqehRWy9vuRGgQfR8brUhMyFj1seHdkdK5e7vY0LmBwgLUTuFJ
         tc4Q==
X-Gm-Message-State: AOJu0YyZcLoju5hUtheNHUKLI3Lb9vQ39x70TL4arzesbIOUSLUjWPcr
        evW11uF/eAboTt+JPr9B62j3uM3WtyM5gAplFJc=
X-Google-Smtp-Source: AGHT+IE+Uk+v6x/CP9oDnU2R+Nagu6RhFvYt93IMb6r6YRUzDm2f5MWzuHMlWKUAOzuDGex41XzfChKG8xOI+nKt7vE=
X-Received: by 2002:a05:6a21:999c:b0:18c:651:67fe with SMTP id
 ve28-20020a056a21999c00b0018c065167femr22234124pzb.62.1701303118285; Wed, 29
 Nov 2023 16:11:58 -0800 (PST)
MIME-Version: 1.0
References: <20231129085314.50306434@canb.auug.org.au>
In-Reply-To: <20231129085314.50306434@canb.auug.org.au>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Wed, 29 Nov 2023 16:11:47 -0800
Message-ID: <CAM9d7cjjZBN1FzJaS5TWaC0=_gE5aQ6j=eVjiHd9GZaaf_0mdw@mail.gmail.com>
Subject: Re: linux-next: manual merge of the perf tree with Linus' tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Athira Jajeev <atrajeev@linux.vnet.ibm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Oliver Upton <oliver.upton@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Tue, Nov 28, 2023 at 1:53 PM Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>
> Hi all,
>
> Today's linux-next merge of the perf tree got a conflict in:
>
>   tools/perf/Makefile.perf
>
> between commit:
>
>   e2bdd172e665 ("perf build: Generate arm64's sysreg-defs.h and add to include path")
>
> from Lius' tree and commit:
>
>   1638b11ef815 ("perf tools: Add perf binary dependent rule for shellcheck log in Makefile.perf")
>
> from the perf tree.
>
> I fixed it up (see below) and can carry the fix as necessary. This
> is now fixed as far as linux-next is concerned, but any non trivial
> conflicts should be mentioned to your upstream maintainer when your tree
> is submitted for merging.  You may also want to consider cooperating
> with the maintainer of the conflicting tree to minimise any particularly
> complex conflicts.

Thanks for letting us know.  I think Arnaldo can resolve the
conflict when he merges perf-tools into perf-tools-next later
(but before sending the changes for v6.8) as you did.

Thanks,
Namhyung

>
> --
> Cheers,
> Stephen Rothwell
>
> diff --cc tools/perf/Makefile.perf
> index 058c9aecf608,824cbc0af7d7..000000000000
> --- a/tools/perf/Makefile.perf
> +++ b/tools/perf/Makefile.perf
> @@@ -1150,7 -1151,8 +1168,8 @@@ endif # CONFIG_PERF_BPF_SKE
>   bpf-skel-clean:
>         $(call QUIET_CLEAN, bpf-skel) $(RM) -r $(SKEL_TMP_OUT) $(SKELETONS)
>
>  -clean:: $(LIBAPI)-clean $(LIBBPF)-clean $(LIBSUBCMD)-clean $(LIBSYMBOL)-clean $(LIBPERF)-clean fixdep-clean python-clean bpf-skel-clean tests-coresight-targets-clean
>  +clean:: $(LIBAPI)-clean $(LIBBPF)-clean $(LIBSUBCMD)-clean $(LIBSYMBOL)-clean $(LIBPERF)-clean arm64-sysreg-defs-clean fixdep-clean python-clean bpf-skel-clean tests-coresight-targets-clean
> +       $(Q)$(MAKE) -f $(srctree)/tools/perf/tests/Makefile.tests clean
>         $(call QUIET_CLEAN, core-objs)  $(RM) $(LIBPERF_A) $(OUTPUT)perf-archive $(OUTPUT)perf-iostat $(LANG_BINDINGS)
>         $(Q)find $(or $(OUTPUT),.) -name '*.o' -delete -o -name '\.*.cmd' -delete -o -name '\.*.d' -delete
>         $(Q)$(RM) $(OUTPUT).config-detected
