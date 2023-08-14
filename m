Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 154DC77B104
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 08:03:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233288AbjHNGCh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 02:02:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233294AbjHNGCU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 02:02:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24F97B4;
        Sun, 13 Aug 2023 23:02:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B6AF362987;
        Mon, 14 Aug 2023 06:02:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9BDBEC433C7;
        Mon, 14 Aug 2023 06:02:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1691992938;
        bh=bWQE+knkPDexsk5CayFor2pwXRX42J9XJ9j+G5K22WQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fLDhfybewPP9yvESjtahMyDlG8PZfkIu0PjSuqnTZD4i8lVnuIthwCoAdcrXExjNc
         ifbQOR0LYE5+tlb+Ds2kXgnKIeEAQqhnBrLU3Yhe1o1ry9Dw7Lu6vnyhXO94sME2rN
         dN7W7/A2TqJT4TZLhhqjp9v+1DkbNbRHvmmaW3sg=
Date:   Mon, 14 Aug 2023 08:02:15 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Nick Hu <nick.hu@sifive.com>
Cc:     zong.li@sifive.com, jirislaby@kernel.org, palmer@dabbelt.com,
        paul.walmsley@sifive.com, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
Subject: Re: [PATCH v2 0/1] Add Sifive uart suspend and resume
Message-ID: <2023081432-level-prelaw-3794@gregkh>
References: <20230809135042.2443350-1-nick.hu@sifive.com>
 <2023081143-flannels-verbally-9d0f@gregkh>
 <CAKddAkA9TZs2vVCzBWtfgo3gYJsrMMmsDMtA22iEMM3ok9TgPA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAKddAkA9TZs2vVCzBWtfgo3gYJsrMMmsDMtA22iEMM3ok9TgPA@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 14, 2023 at 01:55:58PM +0800, Nick Hu wrote:
> Hi Greg
> 
> On Sat, Aug 12, 2023 at 3:11 AM Greg KH <gregkh@linuxfoundation.org> wrote:
> >
> > On Wed, Aug 09, 2023 at 09:50:41PM +0800, Nick Hu wrote:
> > > Add Sifive uart suspend and resume functions for system suspend.
> > >
> > > Changes in v2:
> > > - Change Signed-off-by: Ben Dooks to Reviewed-by: Ben Dooks
> > > - Remove the unnecessary check
> > >
> > > Nick Hu (1):
> > >   serial: sifive: Add suspend and resume operations
> > >
> > >  drivers/tty/serial/sifive.c | 18 ++++++++++++++++++
> > >  1 file changed, 18 insertions(+)
> > >
> > > --
> > > 2.34.1
> > >
> >
> > Does not apply to my tree :(
> Is there any reason that it doesn't apply to your tree?
> Which tree should I go?

Which tree did you make it against?  It doesn't apply due to conflicts.
Perhaps either regenerate it against the tty-next branch of the tty.git
tree, or linux-next?

thanks,

greg k-h
