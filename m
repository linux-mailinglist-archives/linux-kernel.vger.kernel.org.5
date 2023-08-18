Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 316F9780B0F
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 13:25:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376632AbjHRLYk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Aug 2023 07:24:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376665AbjHRLYW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Aug 2023 07:24:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 433C14204
        for <linux-kernel@vger.kernel.org>; Fri, 18 Aug 2023 04:24:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CCEDB622F3
        for <linux-kernel@vger.kernel.org>; Fri, 18 Aug 2023 11:24:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6AB0CC433C8;
        Fri, 18 Aug 2023 11:24:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692357859;
        bh=wJE4Q7Pg3P2Qi9nVHeng0Y6pVrWaJhbQXSo8rUNA3mc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Aek3+hR1UId17pgW6pK62MO7Vvc4/28yeVSU+TBWdGEOzLM+IOI2R0e0ZA87x2vvy
         C5BL9vus6yQVDrFLJWgpUGb1BPGkG0Cw6uNgHw6OQS7nU1C/mtq0p+fabvxXtoKdvM
         hv9XAGdVuTd/fo1W/xsm7nrDsEBcZJ0MAhdFfsvoOguoEXMviRLcVZ95SgfB02xUcn
         x+oiZEVqcWQZyQOO1r+zlDcYtEXcc6DxOew5xUZoEPDktObRm6jbRHsRpLy+o37QA7
         LUt+26Qj4ysCRL3Bpx/bfzNFlXJDopEWRKCjAPa5DEyF1Nc9TzE8701iLs5P/Z+AN5
         L8mloMs3CNo5Q==
Date:   Fri, 18 Aug 2023 12:24:15 +0100
From:   Lee Jones <lee@kernel.org>
To:     "Wenkai.Chung" <Wenkai.Chung@advantech.com.tw>
Cc:     "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
        "Susi.Driver" <Susi.Driver@advantech.com>
Subject: Re: [PATCH] Add a mfd driver to support Advantech EIO-IS200 series
 EC.
Message-ID: <20230818112415.GU986605@google.com>
References: <20230727053655.92525-1-wenkai.chung@advantech.com.tw>
 <ebc6d86e627242a785f75f88623108c6@advantech.com.tw>
 <20230818112239.GT986605@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230818112239.GT986605@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Also, this patch doesn't appear to be on lore.kernel.org.

Please make sure the email address and formatting for LKML is correct.

The formatting for it in your recipients headers look odd.

On Fri, 18 Aug 2023, Lee Jones wrote:

> With respect to the subject, please use this command for examples:
> 
>   git log --oneline -- drivers/mfd
> 
> On Thu, 27 Jul 2023, Wenkai.Chung wrote:
> 
> > Add a mfd driver to support Advantech EIO-IS200 series EC.
> 
> Please drop all references to "mfd".  It's not a real thing.
> 
> Please tell us all about your driver here.  A one line description is
> not appropriate for a 600 line commit.
> 
> > Signed-off-by: wenkai.chung <wenkai.chung@advantech.com.tw>
> > ---
> >  drivers/mfd/Kconfig         |  13 +
> >  drivers/mfd/Makefile        |   1 +
> >  drivers/mfd/eiois200.h      | 146 +++++++++++
> >  drivers/mfd/eiois200_core.c | 496 ++++++++++++++++++++++++++++++++++++
> >  4 files changed, 656 insertions(+)
> >  create mode 100644 drivers/mfd/eiois200.h  create mode 100644 drivers/mfd/eiois200_core.c



-- 
Lee Jones [李琼斯]
