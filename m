Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D94B87664CC
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 09:07:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233804AbjG1HHN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 03:07:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232557AbjG1HHL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 03:07:11 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4CBD1FFF
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jul 2023 00:07:08 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id C3CA71A357B;
        Fri, 28 Jul 2023 03:07:07 -0400 (EDT)
        (envelope-from tdavies@darkphysics.net)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=date:from
        :to:cc:subject:message-id:references:mime-version:content-type
        :in-reply-to; s=sasl; bh=xbdqGhy7iwAmsLXlc2lOGZO/RGmggC2w9K6TKKU
        bp4E=; b=clzFT48Vy02CptHhHUAlTq4feU6/x4UkGJgFRA3SB1A2KyLydydnitL
        LRuOCMp5wvV+sP9DPjRytZYmcimn1AxHns+U6zwadq/0XtdJlcO77lqSNudu2ONH
        Qa3aJ6U1Uz04Et+TECIHEY03GkepW+N/FH4VlM+N56VuAur0bZTc=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id AB8F71A3579;
        Fri, 28 Jul 2023 03:07:07 -0400 (EDT)
        (envelope-from tdavies@darkphysics.net)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=darkphysics.net;
 h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=2019-09.pbsmtp; bh=xbdqGhy7iwAmsLXlc2lOGZO/RGmggC2w9K6TKKUbp4E=; b=gfIW2EAnGUzV4YWoDIz7dJELxT4tYq5+kVW99q68JZrGfM1muOylbP3jhP5bOxKosrRs5uwXf8KtnrInKVUEPU7MDpRjOxXoxQKbsEngRYSD5PafyZdNm43HQtyeOgdpNowqZxUOMPX2h2zqthiV7WrHskL5rPdntjC5s0+Q9uE=
Received: from basil (unknown [76.146.178.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id ED7F91A3578;
        Fri, 28 Jul 2023 03:07:05 -0400 (EDT)
        (envelope-from tdavies@darkphysics.net)
Date:   Fri, 28 Jul 2023 00:08:34 -0700
From:   Tree Davies <tdavies@darkphysics.net>
To:     Dan Carpenter <dan.carpenter@linaro.org>
Cc:     Philipp Hortmann <philipp.g.hortmann@gmail.com>,
        gregkh@linuxfoundation.org, anjan@momi.ca, error27@gmail.com,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/5] Staging: rtl8192e: Function name cleanup series 1
Message-ID: <ZMNpcvPbpQp3Z8rp@basil>
References: <20230728054742.622297-1-tdavies@darkphysics.net>
 <f4aaf5f5-a6b0-ef10-0d9b-fc52035ca309@gmail.com>
 <ZMNf2d615rXJ8O95@basil>
 <f47c3d86-aada-470d-8ed8-5d7957edb28a@kadam.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f47c3d86-aada-470d-8ed8-5d7957edb28a@kadam.mountain>
X-Pobox-Relay-ID: 5C8FB22A-2D15-11EE-A9CA-307A8E0A682E-45285927!pb-smtp2.pobox.com
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NO_DNS_FOR_FROM,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 28, 2023 at 09:49:26AM +0300, Dan Carpenter wrote:
> On Thu, Jul 27, 2023 at 11:27:37PM -0700, Tree Davies wrote:
> > On Fri, Jul 28, 2023 at 08:16:03AM +0200, Philipp Hortmann wrote:
> > > On 7/28/23 07:47, Tree Davies wrote:
> > > > Rename functions to fix checkpatch warning: Avoid CamelCase
> > > > 
> > > > 
> > > > Changelist:
> > > > v3: Changed patch #5, Rename global function ResetBaEntry to rtllib_reset_ba_entry
> > > > v2: Sent to mailing list via git send-email, patches are the same.
> > > > 
> > > > Tree Davies (5):
> > > >    Staging: rtl8192e: Rename function ActivateBAEntry
> > > >    Staging: rtl8192e: Rename function DeActivateBAEntry
> > > >    Staging: rtl8192e: Rename function TxTsDeleteBA
> > > >    Staging: rtl8192e: Rename function RxTsDeleteBA
> > > >    Staging: rtl8192e: Rename function ResetBaEntry
> > > > 
> > > >   drivers/staging/rtl8192e/rtl819x_BAProc.c | 44 +++++++++++------------
> > > >   drivers/staging/rtl8192e/rtl819x_TSProc.c |  6 ++--
> > > >   drivers/staging/rtl8192e/rtllib.h         |  2 +-
> > > >   3 files changed, 26 insertions(+), 26 deletions(-)
> > > > 
> > > Hi Tree,
> > > 
> > > those patches have been accepted and cannot be applied again.
> > > 
> > 
> > Hi Philipp,
> > 
> > Right, patch #5 was not accepted though. Grep asked to fix it up.
> > I thought that because it was part of that series I was supposed to
> > resend as new version.
> 
> But now you understand what to do, right?  Pull the latest code and do
> all your work on top of that.  Don't resend the stuff which was applied.
> 
> regards,
> dan carpenter
>

Understood. Thanks.
regards,
Tree

 
