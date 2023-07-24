Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E462675FEC7
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 20:05:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229931AbjGXSFb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 14:05:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230323AbjGXSFY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 14:05:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 566AE18D;
        Mon, 24 Jul 2023 11:05:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D6FFC6136F;
        Mon, 24 Jul 2023 18:05:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE987C433C7;
        Mon, 24 Jul 2023 18:05:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1690221921;
        bh=bo6Hth2LfD40LFq41IDucHbQY25BRVrqOLMhMDl2lFw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=GJRf6ZpE5l5TpgA04FRFJpMyIWz551q/9hr3D3jWHa2yv4Vy1bJxgeU/wxtE6tkWB
         JROBdPwcrrL1R0yUrnsmNUqRhoR0smqLDdDNXhf0OKgU/lkrkBxDa1e4FNyXYVhMuB
         MV2oM9QK8st8i1Mn+vNpvQH242XM3t50teeDAQME=
Date:   Mon, 24 Jul 2023 11:05:20 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     andriy.shevchenko@linux.intel.com, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] kstrtox: Remove strtobool()
Message-Id: <20230724110520.b250bc244908a40a53bf2da7@linux-foundation.org>
In-Reply-To: <23d2ea6b90579207e87cc1bf64fc4eed1ed9f173.1689885328.git.christophe.jaillet@wanadoo.fr>
References: <23d2ea6b90579207e87cc1bf64fc4eed1ed9f173.1689885328.git.christophe.jaillet@wanadoo.fr>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 20 Jul 2023 22:40:35 +0200 Christophe JAILLET <christophe.jaillet@wanadoo.fr> wrote:

> The conversion from strtobool() to kstrtobool() is completed.
> So strtobool() can now be removed.

I still have some strtobool()s in mm.git, so I can't apply this. 

Probably nobody can apply this to their tree at this stage.  A resend
after 6.6-rc1 would be the simplest approach.

