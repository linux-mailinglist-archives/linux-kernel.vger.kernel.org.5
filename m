Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88D7F766F9D
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 16:38:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237134AbjG1OiR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 10:38:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234699AbjG1OiP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 10:38:15 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EC8E3C24;
        Fri, 28 Jul 2023 07:38:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 98A506216B;
        Fri, 28 Jul 2023 14:38:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7BEFC433C7;
        Fri, 28 Jul 2023 14:38:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690555094;
        bh=wjwP4w8BS9th/B1i8S2XP4Q49a2HggcUKgJCWV6NSnY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fsRyWTTPKyVWiRdY9AHqj1FaDyEf4MZ5PJH6E/bKtl6NhpFj2PpGSuDWe4LN+HIf0
         TxfygMz7KKizlaX/iIMtfG/NWrGLin1ZDUIisexCEQlVR3B44vMunEQtAYZ5e93vUc
         Qty6vSkCUVg13t49PJmud32F6vvTV+rByQMom5SZECR82L2/aArG2naeuAw1BecSce
         8KSJnVeI/mG/phKHy62vELq7mun/lwbWetVhwv0E4ZZq9K8LCPg3vq/iH6dD9bawfn
         F+n+lCO+EBPpdFawB7M4l9BqHZOiLjzMQCKQ8qPcZY8ZtH9PSJmMYppqrPd66BOF+0
         7BgeP5g1GNgPA==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 67AB340096; Fri, 28 Jul 2023 11:38:11 -0300 (-03)
Date:   Fri, 28 Jul 2023 11:38:11 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Leo Yan <leo.yan@linaro.org>
Cc:     Ali Saidi <alisaidi@amazon.com>, catalin.marinas@arm.com,
        will@kernel.org, john.g.garry@oracle.com, james.clark@arm.com,
        mike.leach@linaro.org, peterz@infradead.org, mingo@redhat.com,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        jolsa@kernel.org, namhyung@kernel.org, irogers@google.com,
        adrian.hunter@intel.com, scott@os.amperecomputing.com,
        maz@kernel.org, anshuman.khandual@arm.com, german.gomez@arm.com,
        renyu.zj@linux.alibaba.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        fissure2010@gmail.com
Subject: Re: [PATCH v1 0/3] arm64: Support Cortex-X4 CPU for Perf Arm SPE
Message-ID: <ZMPS04R7MpnxKwJ0@kernel.org>
References: <20230717054327.79815-1-leo.yan@linaro.org>
 <20230721181653.22398-1-alisaidi@amazon.com>
 <20230724113013.GB76473@leoy-huanghe.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230724113013.GB76473@leoy-huanghe.lan>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, Jul 24, 2023 at 07:30:13PM +0800, Leo Yan escreveu:
> Hi Ali,
> 
> On Fri, Jul 21, 2023 at 06:16:53PM +0000, Ali Saidi wrote:
> 
> > > This series support Cortex-X4 CPU in Perf Arm SPE.
> 
> [...]
> 
> > This looks good to me, but can we add the other cores that operate the
> > same way now too? Flipping through the TRMs A78, X3, V2, X1, A715,
> > A720, and A78C all have the same encodings. 
> 
> Thanks a lot for exploring more CPU variants which share the same data
> source packet format.
> 
> The latest Linux kernel have defined the CPU part number and MIDR for
> below CPU variants:
> 
> - A78
> - X1
> - A715
> - A78C
> 
> I would like to use a patch to support these CPUs in perf tool.  Given
> other CPU variants (X3/V2/A720) have not been supported in the kernel,
> and so far no one requests them, I would like leave them out.
> 
> Please let me know if this okay for you or not.
> 
> 
> > Reviewed-by: Ali Saidi <alisaidi@amazon.com>
> 
> Thanks for review, I will add your review tags in the new patch set.

Ok, waiting for the new patch set.

- Arnaldo
