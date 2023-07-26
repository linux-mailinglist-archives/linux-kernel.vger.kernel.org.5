Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F5C87640B5
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 22:42:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229866AbjGZUml (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 16:42:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbjGZUmj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 16:42:39 -0400
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DFE4212F
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 13:42:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=OZA55SnNbAmvZEmnAh3o1Vey5rx64nx3FOwYsy8KhWI=;
  b=uCEDxfvQKI+OZ89DzhponjbY3VXv/Yryua8IgoxBZ9UIaendxM9D4OwW
   /3hyo6rHOZX3mmqNZc3Ek+iDJgWSyKbZ3hN/Veb92iLre72eWFOy7w/8T
   VUfzwM7DNGiP4hVKDO4iEuPMWGznDh7sQkb8XLv3Ut6S3bC2a6BuOQk5E
   Q=;
Authentication-Results: mail2-relais-roc.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=julia.lawall@inria.fr; dmarc=fail (p=none dis=none) d=inria.fr
X-IronPort-AV: E=Sophos;i="6.01,232,1684792800"; 
   d="scan'208";a="119229647"
Received: from 231.85.89.92.rev.sfr.net (HELO hadrien) ([92.89.85.231])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jul 2023 22:42:35 +0200
Date:   Wed, 26 Jul 2023 22:42:34 +0200 (CEST)
From:   Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To:     Sean Christopherson <seanjc@google.com>
cc:     Nicolas Palix <nicolas.palix@imag.fr>,
        linux-kernel@vger.kernel.org, cocci@inria.fr,
        Paolo Bonzini <pbonzini@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v2] Revert "debugfs, coccinelle: check for obsolete
 DEFINE_SIMPLE_ATTRIBUTE() usage"
In-Reply-To: <20230726202920.507756-1-seanjc@google.com>
Message-ID: <alpine.DEB.2.22.394.2307262242160.3129@hadrien>
References: <20230726202920.507756-1-seanjc@google.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 26 Jul 2023, Sean Christopherson wrote:

> Remove coccinelle's recommendation to use DEFINE_DEBUGFS_ATTRIBUTE()
> instead of DEFINE_SIMPLE_ATTRIBUTE().  Regardless of whether or not the
> "significant overhead" incurred by debugfs_create_file() is actually
> meaningful, warnings from the script have led to a rash of low-quality
> patches that have sowed confusion and consumed maintainer time for little
> to no benefit.  There have been no less than four attempts to "fix" KVM,
> and a quick search on lore shows that KVM is not alone.
>
> This reverts commit 5103068eaca290f890a30aae70085fac44cecaf6.

Applied.

>
> Link: https://lore.kernel.org/all/87tu2nbnz3.fsf@mpe.ellerman.id.au
> Link: https://lore.kernel.org/all/c0b98151-16b6-6d8f-1765-0f7d46682d60@redhat.com
> Link: https://lkml.kernel.org/r/20230706072954.4881-1-duminjie%40vivo.com
> Link: https://lore.kernel.org/all/Y2FsbufV00jbyF0B@google.com
> Link: https://lore.kernel.org/all/Y2ENJJ1YiSg5oHiy@orome
> Link: https://lore.kernel.org/all/7560b350e7b23786ce712118a9a504356ff1cca4.camel@kernel.org
> Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
> Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> ---
>
> v2: Fix a copy+paste goof in the changelog, add Greg's Ack.
>
>  .../api/debugfs/debugfs_simple_attr.cocci     | 68 -------------------
>  1 file changed, 68 deletions(-)
>  delete mode 100644 scripts/coccinelle/api/debugfs/debugfs_simple_attr.cocci
>
> diff --git a/scripts/coccinelle/api/debugfs/debugfs_simple_attr.cocci b/scripts/coccinelle/api/debugfs/debugfs_simple_attr.cocci
> deleted file mode 100644
> index 7c312310547c..000000000000
> --- a/scripts/coccinelle/api/debugfs/debugfs_simple_attr.cocci
> +++ /dev/null
> @@ -1,68 +0,0 @@
> -// SPDX-License-Identifier: GPL-2.0
> -/// Use DEFINE_DEBUGFS_ATTRIBUTE rather than DEFINE_SIMPLE_ATTRIBUTE
> -/// for debugfs files.
> -///
> -//# Rationale: DEFINE_SIMPLE_ATTRIBUTE + debugfs_create_file()
> -//# imposes some significant overhead as compared to
> -//# DEFINE_DEBUGFS_ATTRIBUTE + debugfs_create_file_unsafe().
> -//
> -// Copyright (C): 2016 Nicolai Stange
> -// Options: --no-includes
> -//
> -
> -virtual context
> -virtual patch
> -virtual org
> -virtual report
> -
> -@dsa@
> -declarer name DEFINE_SIMPLE_ATTRIBUTE;
> -identifier dsa_fops;
> -expression dsa_get, dsa_set, dsa_fmt;
> -position p;
> -@@
> -DEFINE_SIMPLE_ATTRIBUTE@p(dsa_fops, dsa_get, dsa_set, dsa_fmt);
> -
> -@dcf@
> -expression name, mode, parent, data;
> -identifier dsa.dsa_fops;
> -@@
> -debugfs_create_file(name, mode, parent, data, &dsa_fops)
> -
> -
> -@context_dsa depends on context && dcf@
> -declarer name DEFINE_DEBUGFS_ATTRIBUTE;
> -identifier dsa.dsa_fops;
> -expression dsa.dsa_get, dsa.dsa_set, dsa.dsa_fmt;
> -@@
> -* DEFINE_SIMPLE_ATTRIBUTE(dsa_fops, dsa_get, dsa_set, dsa_fmt);
> -
> -
> -@patch_dcf depends on patch expression@
> -expression name, mode, parent, data;
> -identifier dsa.dsa_fops;
> -@@
> -- debugfs_create_file(name, mode, parent, data, &dsa_fops)
> -+ debugfs_create_file_unsafe(name, mode, parent, data, &dsa_fops)
> -
> -@patch_dsa depends on patch_dcf && patch@
> -identifier dsa.dsa_fops;
> -expression dsa.dsa_get, dsa.dsa_set, dsa.dsa_fmt;
> -@@
> -- DEFINE_SIMPLE_ATTRIBUTE(dsa_fops, dsa_get, dsa_set, dsa_fmt);
> -+ DEFINE_DEBUGFS_ATTRIBUTE(dsa_fops, dsa_get, dsa_set, dsa_fmt);
> -
> -
> -@script:python depends on org && dcf@
> -fops << dsa.dsa_fops;
> -p << dsa.p;
> -@@
> -msg="%s should be defined with DEFINE_DEBUGFS_ATTRIBUTE" % (fops)
> -coccilib.org.print_todo(p[0], msg)
> -
> -@script:python depends on report && dcf@
> -fops << dsa.dsa_fops;
> -p << dsa.p;
> -@@
> -msg="WARNING: %s should be defined with DEFINE_DEBUGFS_ATTRIBUTE" % (fops)
> -coccilib.report.print_report(p[0], msg)
>
> base-commit: 06c2afb862f9da8dc5efa4b6076a0e48c3fbaaa5
> --
> 2.41.0.487.g6d72f3e995-goog
>
>
