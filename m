Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 340B5775E59
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 14:02:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231601AbjHIMCA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 08:02:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232220AbjHIMB6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 08:01:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A45721BDA
        for <linux-kernel@vger.kernel.org>; Wed,  9 Aug 2023 05:01:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 44812636F0
        for <linux-kernel@vger.kernel.org>; Wed,  9 Aug 2023 12:01:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51A6DC433C7;
        Wed,  9 Aug 2023 12:01:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1691582516;
        bh=hr375oXG/8cSC02+/y1zABz4gvagRjaNGCcZtZtFwOM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Xx5HzpxDVmVjqNxrZ2+1mbvrWCZ965qccgsMdGNBiHtuIy63d+0fyOc9tbcYsHbu1
         JGX8R3gicT1KiVgFEzKBQeW8S1X0+o+SSCTjiO9jLt5IOfVhOj1CLm/Fevm5T3+zCr
         j41bbJoqH6DDJUQk8HVA1Aq14TEacAQQ1udQwbig=
Date:   Wed, 9 Aug 2023 13:11:30 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Borislav Petkov <bp@alien8.de>
Cc:     X86 ML <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/3] x86/bugs: Some SRSO fixes
Message-ID: <2023080923-diabolic-turbulent-8008@gregkh>
References: <20230809102700.29449-1-bp@alien8.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230809102700.29449-1-bp@alien8.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 09, 2023 at 12:26:57PM +0200, Borislav Petkov wrote:
> From: "Borislav Petkov (AMD)" <bp@alien8.de>
> 
> Hi all,
> 
> those are the leftover smaller fixes which can go after the release
> date. I'll queue them next week.
> 
> Thx.
> 
> Borislav Petkov (AMD) (3):
>   Documentation/hw-vuln: Unify filename specification in index
>   driver core: cpu: Unify redundant silly stubs
>   Documentation/srso: Document IBPB aspect and fix formatting
> 
>  Documentation/admin-guide/hw-vuln/index.rst | 12 +--
>  Documentation/admin-guide/hw-vuln/srso.rst  | 71 ++++++++++-------
>  drivers/base/cpu.c                          | 86 +++++----------------
>  3 files changed, 68 insertions(+), 101 deletions(-)
> 
> -- 
> 2.41.0
> 

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
