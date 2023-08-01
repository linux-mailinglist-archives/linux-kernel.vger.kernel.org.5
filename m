Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C08E76B855
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 17:17:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232517AbjHAPRk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 11:17:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230462AbjHAPRi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 11:17:38 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58D76116
        for <linux-kernel@vger.kernel.org>; Tue,  1 Aug 2023 08:17:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=KaTVczCiAifY0etxyFsXnvO/WsA+ysZZ7LHyawNWwZc=; b=ZntiGMpWRuk98P8GDQ/ElshiNh
        sW7DLUFZTT+I9HGcq/NJMCERdDhmRMFah/lNzwcS9XtgjPV+4Nhhmh8jA7mjTugCh8bAqeIQr0PHp
        pARWkR7SzXPXUZ+m0h2LTXYTzR4rOssMLBeYn+rYU42/PTRG9SKAZadihIXevBB9ou8Qm6wJGS5hf
        ChJAyRqxfbZaBZdnAbwCdasYP6z4sIs5L3DZgEOweeXkVlfoMq/WzgIlRj1meL+s5RkRFANOoPGY7
        6KPUSZYDI1oqwE+wk+mmQkwEwPpjYPsfzUAOk679MFKYe+TI/rnay9g3nflyYTfGedRvEtIcwsSPB
        3dErMELg==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qQr7u-00EkGl-1T;
        Tue, 01 Aug 2023 15:17:34 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 1C5363001DD;
        Tue,  1 Aug 2023 17:17:34 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id EE92F20297BBD; Tue,  1 Aug 2023 17:17:33 +0200 (CEST)
Date:   Tue, 1 Aug 2023 17:17:33 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Ramazan Safiullin <ram.safiullin2001@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MAINTAINERS: add documentation to PSI section
Message-ID: <20230801151733.GA111053@hirez.programming.kicks-ass.net>
References: <20230728120909.234244-1-ram.safiullin2001@gmail.com>
 <CAJuCfpGyV5nM+4t_RTxDgvgZ_VhjpdoZ4TJZBn7RgxSHC6+Hyw@mail.gmail.com>
 <CAJuCfpEjozCfqfPPttcnWdzhQBCGnr+MzWGN8FT40YObZf_mGA@mail.gmail.com>
 <20230801103936.GA79828@hirez.programming.kicks-ass.net>
 <CAKXUXMwJk2bB-mPpeAj8dU3DVhdX-TRRV6eXSjMVO16Xsivj3g@mail.gmail.com>
 <20230801130301.GB11704@hirez.programming.kicks-ass.net>
 <20230801133235.GA1766885@cmpxchg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230801133235.GA1766885@cmpxchg.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 01, 2023 at 09:32:35AM -0400, Johannes Weiner wrote:
> From f00cd5986718e7ff435444523305d480b54e34e8 Mon Sep 17 00:00:00 2001
> From: Johannes Weiner <hannes@cmpxchg.org>
> Date: Tue, 1 Aug 2023 09:18:21 -0400
> Subject: [PATCH] MAINTAINERS: add Peter explicitly to the psi section
> 
> Peter is kind enough to route the low-volume psi patches through the
> scheduler tree, but he is frequently not CC'd on them.
> 
> While he is matched through the SCHEDULER maintainers and reviewers on
> kern/sched/*, that list is long, and mostly not applicable to psi
> code. Thus, patch submitters often just CC the explicit PSI entries.
> 
> Add him to that section, to make sure he gets those patches.
> 
> Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>

Thanks!

> ---
>  MAINTAINERS | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 3be1bdfe8ecc..b68f3ab368c1 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -17037,6 +17037,7 @@ F:	drivers/net/ppp/pptp.c
>  PRESSURE STALL INFORMATION (PSI)
>  M:	Johannes Weiner <hannes@cmpxchg.org>
>  M:	Suren Baghdasaryan <surenb@google.com>
> +R:	Peter Ziljstra <peterz@infradead.org>
>  S:	Maintained
>  F:	include/linux/psi*
>  F:	kernel/sched/psi.c
> -- 
> 2.41.0
