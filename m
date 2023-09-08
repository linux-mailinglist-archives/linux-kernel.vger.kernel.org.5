Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70444798A9E
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Sep 2023 18:21:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245042AbjIHQVh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Sep 2023 12:21:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245021AbjIHQVf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Sep 2023 12:21:35 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19B621FCF;
        Fri,  8 Sep 2023 09:21:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=VcwGfc9Tnqkh9AJ6h3FTNgEYREA5iZxXd/O+7UXFIfA=; b=FPV2nHD2+8c2tNKohu9IFT6UXC
        C9tWY+8tcdN3Mpv08L0o8zM5C6J5ewbt0YKEeLgkNp5VGd9wzxfQl4+VcsSfdv7u8qyG0MIodMocp
        quM09Gmu5vltHdaiaEs3R1t8MbK/GO0qVR1UxB2hG95AHPImYJFKk9B1nPe3UnJZ55m92Nye9xuKA
        SdmZUQFEbBSHo/g+N7XpfoD/d3Ce/07UXgqB81X9S2rJ7PShSwv1VkSWzt/wF1kSUbudCmNTCHM/e
        lwcGryVr6Uj9KAGIk9Vms4t+pf7LfWZjQ5koUpfiQ16/+412ZmaAglvgeCjd6wqljFPR9i6UvOdR7
        Dp2sNwUQ==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1qeeEb-00E4q2-1B;
        Fri, 08 Sep 2023 16:21:29 +0000
Date:   Fri, 8 Sep 2023 09:21:29 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, stable <stable@kernel.org>,
        Stefan Lippers-Hollmann <s.l-h@gmx.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Christoph Hellwig <hch@lst.de>, linux-media@vger.kernel.org,
        linux-modules@vger.kernel.org
Subject: Re: [PATCH] media: dvb: symbol fixup for dvb_attach()
Message-ID: <ZPtKCc2PLi0wdR2+@bombadil.infradead.org>
References: <20230908092035.3815268-2-gregkh@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230908092035.3815268-2-gregkh@linuxfoundation.org>
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 08, 2023 at 10:20:36AM +0100, Greg Kroah-Hartman wrote:
> In commit 9011e49d54dc ("modules: only allow symbol_get of
> EXPORT_SYMBOL_GPL modules") the use of symbol_get is properly restricted
> to GPL-only marked symbols.  This interacts oddly with the DVB logic
> which only uses dvb_attach() to load the dvb driver which then uses
> symbol_get().
> 
> Fix this up by properly marking all of the dvb_attach attach symbols as
> EXPORT_SYMBOL_GPL().
> 
> Fixes: 9011e49d54dc ("modules: only allow symbol_get of EXPORT_SYMBOL_GPL modules")
> Cc: stable <stable@kernel.org>
> Reported-by: Stefan Lippers-Hollmann <s.l-h@gmx.de>
> Cc: Mauro Carvalho Chehab <mchehab@kernel.org>
> Cc: Luis Chamberlain <mcgrof@kernel.org>
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: linux-media@vger.kernel.org
> Cc: linux-modules@vger.kernel.org
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---
> Luis, do you want to take this through your tree?  Or Mauro's?  Or I can
> take it through mine, it should get to Linus soon as this is causing
> regressions in his tree.

You've done the work so it is up to you, whatever helps you expedite it
as it already hit stable. Feel free to take it through your tree.

  Luis
