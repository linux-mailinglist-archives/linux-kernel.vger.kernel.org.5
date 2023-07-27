Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 156E776592C
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 18:50:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231768AbjG0Que (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 12:50:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230523AbjG0Quc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 12:50:32 -0400
Received: from mout02.posteo.de (mout02.posteo.de [185.67.36.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E66151724
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 09:50:28 -0700 (PDT)
Received: from submission (posteo.de [185.67.36.169]) 
        by mout02.posteo.de (Postfix) with ESMTPS id EF665240105
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 18:50:21 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.net; s=2017;
        t=1690476622; bh=uXHQHEZB1n2cI4t1guKeGhWibX3EDqHJ7eWOrBCO3Ho=;
        h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:
         Content-Transfer-Encoding:From;
        b=SHdvkGCxkVTu+mpzVFlXQADUshjrg14ltCJ6sN+4Aqe2aGqeVqlmqOBnJ4kk9WUHN
         iVGdSaUmIOIbXLjetriYa8Xx9sgvUUh4lGm/MCMNlDY0dOPF2bjdtq96p6oM7887YO
         NYY2D4EE9fRUcBkAo660XBw56+n2ksUqYDGMvZEg6t/iiA0++8WFy0qOu5AqLVC25C
         2wyQFKXUjuPfHj8sTwG9UQBMF1FUremTreVTxlLk3UriA/aMa8uVshJMw2ioO0CBMU
         ECOQzE4cL/zbMElicp3e4/UMIwUTOBEhsvJLJkzkf4DW7mMXg/z1CcNulyObdsqJBp
         9YTBW7sJTc/7A==
Received: from customer (localhost [127.0.0.1])
        by submission (posteo.de) with ESMTPSA id 4RBcFm42S4z6ty0;
        Thu, 27 Jul 2023 18:50:20 +0200 (CEST)
Date:   Thu, 27 Jul 2023 16:50:19 +0000
From:   Daniil Stas <daniil.stas@posteo.net>
To:     Mario Limonciello <mario.limonciello@amd.com>
Cc:     James.Bottomley@hansenpartnership.com, Jason@zx2c4.com,
        jarkko@kernel.org, linux-integrity@vger.kernel.org,
        linux-kernel@vger.kernel.org, regressions@leemhuis.info,
        stable@vger.kernel.org, torvalds@linux-foundation.org
Subject: Re: [PATCH 1/1] tpm: disable hwrng for fTPM on some AMD designs
Message-ID: <20230727195019.41abb48d@g14>
In-Reply-To: <65a1c307-826d-4ca3-0336-07a185684e5d@amd.com>
References: <20230727183805.69c36d6e@g14>
        <b1dd27df-744b-3977-0a86-f5dde8e24288@amd.com>
        <20230727193949.55c18805@g14>
        <65a1c307-826d-4ca3-0336-07a185684e5d@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 27 Jul 2023 11:41:55 -0500
Mario Limonciello <mario.limonciello@amd.com> wrote:

> On 7/27/2023 11:39, Daniil Stas wrote:
> > On Thu, 27 Jul 2023 10:42:33 -0500
> > Mario Limonciello <mario.limonciello@amd.com> wrote:
> >   
> >> On 7/27/2023 10:38, Daniil Stas wrote:  
>  [...]  
> >>
> >> Can you please open up a kernel bugzilla and attach your dmesg to
> >> it both with TPM enabled and disabled?
> >>
> >> You can CC me on it directly.  
> > 
> > There are several bug categories to choose in the bugzilla. Which
> > one should I use?
> > I never used bugzilla before...  
> 
> drivers/other is fine.  If there is a better category we can move it
> later.

I see there are already several bug reports similar to mine. This one
for example: https://bugzilla.kernel.org/show_bug.cgi?id=217212
Should I still make a new one?
