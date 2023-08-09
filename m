Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93DB4775E18
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 13:47:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234322AbjHILrP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 07:47:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234430AbjHILrL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 07:47:11 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED3C6A3;
        Wed,  9 Aug 2023 04:47:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8C001635E0;
        Wed,  9 Aug 2023 11:47:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69245C433C7;
        Wed,  9 Aug 2023 11:47:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1691581629;
        bh=lohgGqt9f2tUPYle/xT621t+yaAN9xs1oy9vV4vCGRA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Vog3WRhdXumFnAR+KFsnwyGeIMxN5+E7lypn/T01zHm9ddnLKKeHPaBJ5J9sg7nU/
         eM1+nB51+ZsIE1O2VPAOazLz/zDgnwbwFPh0jg4LnKaI4+UwNrMd+aoF4if4k2SDU2
         /+7w8VDP9SVLQFafunMckDjrQVYifRNM5A6Vurt4=
Date:   Wed, 9 Aug 2023 13:47:07 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     240401736@qq.com
Cc:     andriy.shevchenko@linux.intel.com, ilpo.jarvinen@linux.intel.com,
        jirislaby@kernel.org, linux-kernel@vger.kernel.org,
        linux-serial@vger.kernel.org, ??? <luoruihong@xiaomi.com>,
        ??? <weipengliang@xiaomi.com>, ??? <wengjinfei@xiaomi.com>,
        colorsu1922@gmail.com
Subject: Re: [PATCH v2] serial: 8250: Preserve original value of DLF register
Message-ID: <2023080954-everyday-galore-f520@gregkh>
References: <tencent_CE78164E0DD743EAA6FD70A1D7F8565F9609@qq.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tencent_CE78164E0DD743EAA6FD70A1D7F8565F9609@qq.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 09, 2023 at 02:30:58PM +0800, 240401736@qq.com wrote:
> On Thu, 29 Jun 2023 20:35:30 +0800, ruihongluo wrote:
> > This commit is aimed at preserving the original value of the
> > DLF(Divisor Latch Fraction Register). When the DLF register is
> > modified without preservation, it can disrupt the baudrate settings
> > established by firmware or bootloader , leading to data corruption
> > and the generation of unreadable or distorted characters.
> >
> > Fixes: 701c5e73b296 ("serial: 8250_dw: add fractional divisor support")
> > Signed-off-by: Ruihong Luo <luoruihong@xiaomi.com>
> 
> Will this patch be merged into the 5.15 branch? We also need this patch on
> the 5.15 branch.

What is the git commit id of it in Linus's tree?

thanks,

greg k-h
