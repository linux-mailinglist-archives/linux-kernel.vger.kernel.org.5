Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C67A67763DD
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 17:34:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234391AbjHIPed (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 11:34:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233617AbjHIPeR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 11:34:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B06981FFE
        for <linux-kernel@vger.kernel.org>; Wed,  9 Aug 2023 08:34:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4706863E16
        for <linux-kernel@vger.kernel.org>; Wed,  9 Aug 2023 15:34:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3B15C433C7;
        Wed,  9 Aug 2023 15:34:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691595255;
        bh=FpXLJiZZ8wkMTe/55YAeMEAs5DB5FhItaLWkPfeYvvs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=p7UCzO8Ule2ijgzxb7OloNb00khgYswfJxG5Dh0/jDpuQC4CO6rf/ZEoLI4RHqPat
         iBH8yoEmNjx0fBUicWj1WOVn5aBWfvkzc5ldcXaj9Ot30fW3qtHF3HlHU3Bk1J6v5H
         TTKDWrK/sAycapxrdZHqbuTMxiwNC1+qbA5ReuQc5rlg6lLFhnqD8sKm3zO5P2xVUe
         EZwxxLJhJLim3YJp2+Yb4W94hN0dKnKDsKaKxvGpfHC6QiZxLMs4+oLAOHxrvgeNAy
         0D4WxRXcVyHNhouSCoibi5VjV8RZimdCC+9UGrDz2oOAb7NoWNH38umu/NKNeCnOLr
         5ey6V6tLvqXzQ==
Date:   Wed, 9 Aug 2023 11:34:12 -0400
From:   Josh Poimboeuf <jpoimboe@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org, David.Kaplan@amd.com,
        Andrew.Cooper3@citrix.com, gregkh@linuxfoundation.org
Subject: Re: [RFC][PATCH 11/17] x86/cpu: Remove all SRSO interface nonsense
Message-ID: <20230809153412.dc232rqedqlrjlgc@treble>
References: <20230809071218.000335006@infradead.org>
 <20230809072201.192502969@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230809072201.192502969@infradead.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 09, 2023 at 09:12:29AM +0200, Peter Zijlstra wrote:
> Now that retbleed can do all that the srso knob did, and without the
> dubious interactions with retbleed selections, remove it.
> 
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> ---
>  arch/x86/kernel/cpu/bugs.c |  188 ++-------------------------------------------
>  drivers/base/cpu.c         |    8 -
>  include/linux/cpu.h        |    2 
>  3 files changed, 10 insertions(+), 188 deletions(-)

Documentation/admin-guide/hw-vuln/srso.rst also needs to be updated...

-- 
Josh
