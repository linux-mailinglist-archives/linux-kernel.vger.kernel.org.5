Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E419B772272
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 13:34:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232873AbjHGLeM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 07:34:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233286AbjHGLdc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 07:33:32 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6EFE4EF4;
        Mon,  7 Aug 2023 04:31:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id ED7146187F;
        Mon,  7 Aug 2023 11:20:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50EBCC433CA;
        Mon,  7 Aug 2023 11:20:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691407207;
        bh=lfov+GI9PtgjRx7EN6YfaLKl9aVqTtIrT6Szi7Q5Aw0=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=VGjJjiA/AR6RZlEx3M6eiKSYq97WMJhhiBtOLOFsPk7larBUKSpY6orDIQ37W40Eg
         CkqBNC7jUKQk0V7TvLsE15J9VZMBiVdm2pb4oVHqqPLXKq0rQ47jG9DaKHQV6dyqG/
         /GElL6HneXvTVdRJvuU42r2DcJFAZGFYI3ojxZHDPpka14OaeWtZCw0XsncjjBmT+v
         nKwIMBRphNY4JzOev79uLBmc0lUCwdAAKQn7j++7OPIqCq1rD1K4CqPDdZdNCV+2Im
         GCDuyHXYd66NvsEt1UDm+2LKH/KEV7mefNkOlXl1Ijm14BPzcDnTFoEXJCfqcQQuoQ
         IK0t/UdJU9E/w==
Date:   Mon, 7 Aug 2023 13:19:54 +0200 (CEST)
From:   Jiri Kosina <jikos@kernel.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
cc:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: Re: [PATCH v1 00/12] HID: cp2112: Cleanups and refactorings
In-Reply-To: <ZMydcGv8Dvu3Hje1@smile.fi.intel.com>
Message-ID: <nycvar.YFH.7.76.2308071319140.14207@cbobk.fhfr.pm>
References: <20230703185222.50554-1-andriy.shevchenko@linux.intel.com> <ZMK60UphgVuj4Z+L@smile.fi.intel.com> <ZMydcGv8Dvu3Hje1@smile.fi.intel.com>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 4 Aug 2023, Andy Shevchenko wrote:

> On Thu, Jul 27, 2023 at 09:43:29PM +0300, Andy Shevchenko wrote:
> > On Mon, Jul 03, 2023 at 09:52:10PM +0300, Andy Shevchenko wrote:
> > > After I updated GPIO library for the case Benjamin has with CP2112,
> > > I have a brief look into the CP2112 driver itself.
> > > 
> > > From GPIO perspective it has two main (maitenance) issues:
> > > - usage of ->to_irq() with IRQ chip present;
> > > - having IRQ chip not immutable.
> > > 
> > > Besides that there are plenty small cleanups here and there.
> > > Hence this series.
> > 
> > Any comments on this?
> 
> Gentle ping^2 for this...
> 
> Anything should I do to improve it or is it okay to go as is?

I have been off pretty much the whole July. I am now back and slowly 
making my way through everything that accumulated, I will eventually get 
to this.

Thanks for the patience,

-- 
Jiri Kosina
SUSE Labs

