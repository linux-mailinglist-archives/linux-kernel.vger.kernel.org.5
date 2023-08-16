Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58D0A77EABF
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 22:32:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346161AbjHPUcO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 16:32:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346212AbjHPUb6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 16:31:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 046E42724;
        Wed, 16 Aug 2023 13:31:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 97B7C61F26;
        Wed, 16 Aug 2023 20:31:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C470CC433CA;
        Wed, 16 Aug 2023 20:31:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692217914;
        bh=7kaCAjuisot0L0qK782IHFbkVCwaenXeGwD2osirKwk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=axEDtixtIDv4YRoOMmZh9s8ZipBPq6ZtP5pFAsvX5nhOkersoGEkJX+3cbSovAjSS
         2bNGVrfKk3TG1kmchQwMZX/nQo7LrEOSMA/A6PsQ/SwBpTgelSHbbCx0b0m2PwSvYT
         UiEasSv02fBflJJm+QMW3A5Qp0NyOPkzkZSQrprNnVAnW3kv47NGD5Z9+o+p0RTiUt
         D95u5i5XioQlMFXqC1AzsrCW3SOxqgyTSm9qOR0SIAEbhlO2Ap/OuqEJDIQDaqkkqL
         dGCD3UWWvlhobMLMnYfXMKUJ1sN4jR81ojjYiESMBOHPMXoHi0cp91p39bHSowsJ2F
         l7K8njw0ulo3Q==
Date:   Wed, 16 Aug 2023 13:31:52 -0700
From:   Josh Poimboeuf <jpoimboe@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org, linux-tip-commits@vger.kernel.org,
        "Borislav Petkov (AMD)" <bp@alien8.de>, x86@kernel.org
Subject: Re: [tip: x86/urgent] objtool/x86: Fix SRSO mess
Message-ID: <20230816203152.co5hgmo2epd6wvef@treble>
References: <20230814121148.704502245@infradead.org>
 <169217251760.27769.15304146275480287222.tip-bot2@tip-bot2>
 <20230816115921.GH980931@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230816115921.GH980931@hirez.programming.kicks-ass.net>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 16, 2023 at 01:59:21PM +0200, Peter Zijlstra wrote:
> Turns out I forgot to build with FRAME_POINTER=y, that still gives:
> 
> vmlinux.o: warning: objtool: srso_untrain_ret+0xd: call without frame pointer save/setup
> 
> the below seems to cure this.

LGTM

-- 
Josh
