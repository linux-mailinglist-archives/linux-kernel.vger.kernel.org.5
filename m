Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D1967FFEBF
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 23:52:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377206AbjK3Wws (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 17:52:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377182AbjK3Wwq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 17:52:46 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3794B91
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 14:52:53 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7DA2EC433C8;
        Thu, 30 Nov 2023 22:52:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1701384772;
        bh=3Pjy/K2UERmUE9Lf5OSdmJ9hD0GKJkBFKQQACti98iE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=CsVIFbK84G7b2Vl8DXsPn+xC+ko6DzsEYdCpeoLL49f/wjG0q7+XJFA8Efc8EDrLB
         kWNBU0rp11lJIwEumnlUF0vW1QFCt/iSvb53/VZenYE6vQugSPGW+tCvDkbxMuIybt
         NjkhWJl8mlNRuK5K9LKmAwQg0Qj5GbFQr6QhmUwg=
Date:   Thu, 30 Nov 2023 14:52:51 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Arnd Bergmann <arnd@arndb.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        PowerPC <linuxppc-dev@lists.ozlabs.org>
Subject: Re: linux-next: build failure after merge of the mm tree
Message-Id: <20231130145251.f9dca8d062117e8ae1b129c1@linux-foundation.org>
In-Reply-To: <87sf4m27dz.fsf@mail.lhotse>
References: <20231127132809.45c2b398@canb.auug.org.au>
        <20231127144852.069b2e7e@canb.auug.org.au>
        <20231201090439.7ae92c13@canb.auug.org.au>
        <87sf4m27dz.fsf@mail.lhotse>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 01 Dec 2023 09:39:20 +1100 Michael Ellerman <mpe@ellerman.id.au> wrote:

> > I am still carrying this patch (it should probably go into the mm
> > tree).  Is someone going to pick it up (assuming it is correct)?
> 
> I applied it to my next a few days ago, but I must have forgotten to
> push. It's in there now.

I'll keep a copy in mm.git, to keep the dependencies nice.  I added
your acked-by.
