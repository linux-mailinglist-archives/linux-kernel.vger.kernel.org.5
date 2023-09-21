Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 035C07A9F0B
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Sep 2023 22:16:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231475AbjIUUQh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Sep 2023 16:16:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231423AbjIUUQD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Sep 2023 16:16:03 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id BA76B40068;
        Thu, 21 Sep 2023 10:14:56 -0700 (PDT)
Received: by linux.microsoft.com (Postfix, from userid 1127)
        id 3CEC8212C497; Thu, 21 Sep 2023 10:14:08 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 3CEC8212C497
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1695316448;
        bh=+CYT1qzL77ITSUiOiG5QEUM8nPiTvooU7tBhQsqM/d0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Bxk57YQd0srLJzlZokrzXcny5XIx+dF2kGt7HYXVpIUe0SakExM0oIxva5SYAUg/4
         xUYtOtU39CtQBe1UJl3ntPkxhwJIZ0WhMG11AndfPt7z5qykB0IBS7t9BgNVy4Otc1
         fDIuapaILU/4/D3d6l/6+Ljha+rQIYQlcNFbkkZo=
Date:   Thu, 21 Sep 2023 10:14:08 -0700
From:   Saurabh Singh Sengar <ssengar@linux.microsoft.com>
To:     Mathias Krause <minipli@grsecurity.net>
Cc:     kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
        decui@microsoft.com, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org,
        hpa@zytor.com, linux-hyperv@vger.kernel.org,
        linux-kernel@vger.kernel.org, mikelley@microsoft.com,
        ssengar@microsoft.com
Subject: Re: [PATCH] x86/hyperv: Remove hv_vtl_early_init initcall
Message-ID: <20230921171408.GA26395@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <1695185552-19910-1-git-send-email-ssengar@linux.microsoft.com>
 <0e86d1cb-a042-7d80-b410-0cc4b31744aa@grsecurity.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0e86d1cb-a042-7d80-b410-0cc4b31744aa@grsecurity.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Spam-Status: No, score=-17.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,ENV_AND_HDR_SPF_MATCH,SPF_HELO_PASS,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 21, 2023 at 09:17:24AM +0200, Mathias Krause wrote:
> On 20.09.23 06:52, Saurabh Sengar wrote:
> > There has been cases reported where HYPERV_VTL_MODE is enabled by mistake,
> > on a non Hyper-V platforms. This causes the hv_vtl_early_init function to
> > be called in an non Hyper-V/VTL platforms which results the memory
> > corruption.
> > 
> > Remove the early_initcall for vhv_vtl_early_init and call it at the end of

vhv_vtl_early_init need to be replaced with hv_vtl_early_init here.

Wei,

Do you need a V2 for it ?

- Saurabh

