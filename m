Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B27AA80286F
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Dec 2023 23:30:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234075AbjLCWac (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Dec 2023 17:30:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234082AbjLCWa3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Dec 2023 17:30:29 -0500
Received: from mail.horus.com (mail.horus.com [78.46.148.228])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AFAC116;
        Sun,  3 Dec 2023 14:30:20 -0800 (PST)
Received: from [192.168.1.22] (193-81-119-54.adsl.highway.telekom.at [193.81.119.54])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by mail.horus.com (Postfix) with ESMTPSA id D069C640D9;
        Sun,  3 Dec 2023 23:30:18 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=horus.com;
        s=20180324; t=1701642618;
        bh=SG4QXUafv7HBFyUQGEy8Wdv6fwaRmduVMKl810igHa8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WCN7iiIkXOuAaT+gX21mk9w9Rzs+zstRivGernVUh9P8UQrgDN2DZ3JUgUq0fe1G9
         bZMBSDw6sKHRewm6FfhntBeNRHQRt9A/bSuc9K7QRKQAr402ir1iQOL0lfq8bWGYUJ
         5cZxOe7h0hXysLK/b//N8afuRWyNtLyhS9VaOQjw=
Received: by camel3.lan (Postfix, from userid 1000)
        id 65B965401F9; Sun,  3 Dec 2023 23:30:18 +0100 (CET)
Date:   Sun, 3 Dec 2023 23:30:18 +0100
From:   Matthias Reichl <hias@horus.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        torvalds@linux-foundation.org, stable@vger.kernel.org,
        jslaby@suse.cz
Subject: Re: Linux 6.6.3
Message-ID: <ZW0BeuPt-B1HAban@camel3.lan>
Mail-Followup-To: Matthias Reichl <hias@horus.com>,
        Mark Brown <broonie@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        torvalds@linux-foundation.org, stable@vger.kernel.org,
        jslaby@suse.cz
References: <2023112811-ecosphere-defender-a75a@gregkh>
 <ZWo45hiK-n8W_yWJ@camel3.lan>
 <dea2db44-2e13-47c1-be0b-8548bfd54473@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dea2db44-2e13-47c1-be0b-8548bfd54473@sirena.org.uk>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 01, 2023 at 08:01:36PM +0000, Mark Brown wrote:
> On Fri, Dec 01, 2023 at 08:49:58PM +0100, Matthias Reichl wrote:
> 
> > I'm not familiar with the regcache code but it looks a bit like the
> > return value from the regcache_read check is leaking out - not
> > assigning the value to ret seems to resolve the issue, too
> > (no idea though if that would be the correct fix):
> 
> That looks sensible, can you submit as a proper patch please?

Thanks a lot for the feedback, I sent out the patch
https://lore.kernel.org/lkml/20231203222216.96547-1-hias@horus.com/T/#u

so long,

Hias
