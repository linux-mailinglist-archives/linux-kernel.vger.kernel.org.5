Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22EA4777C7E
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 17:43:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236106AbjHJPnO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 11:43:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233659AbjHJPnN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 11:43:13 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E98EF1BD9;
        Thu, 10 Aug 2023 08:43:09 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 7616467373; Thu, 10 Aug 2023 17:43:00 +0200 (CEST)
Date:   Thu, 10 Aug 2023 17:43:00 +0200
From:   hch <hch@lst.de>
To:     Richard Weinberger <richard@nod.at>
Cc:     hch <hch@lst.de>, Stephan Wurm <stephan.wurm@a-eberle.de>,
        linux-block <linux-block@vger.kernel.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-mtd <linux-mtd@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Johannes Eigner <johannes.eigner@a-eberle.de>
Subject: Re: ubiblock: null pointer dereference using scatterlist in
 work_queue
Message-ID: <20230810154300.GA28000@lst.de>
References: <ZLT2qEYjaWgSpRD6@PC-LX-Wurm> <1293911429.1782934.1691445776353.JavaMail.zimbra@nod.at> <20230809135308.GA32214@lst.de> <ZNOec8JmndA63Mnh@PC-LX-Wurm> <20230809141542.GA32614@lst.de> <366198994.5052941.1691620484888.JavaMail.zimbra@nod.at> <20230809223703.GA10719@lst.de> <533238598.5052964.1691621039144.JavaMail.zimbra@nod.at>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <533238598.5052964.1691621039144.JavaMail.zimbra@nod.at>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 10, 2023 at 12:43:59AM +0200, Richard Weinberger wrote:
> > deprecated kmap_atomic to kmap_local first you can sleep and don't
> > need bounce buffers.
> 
> Yep, for upstream kmap_local will do the trick, but I need also something
> for the stable trees.
> Anyway, time to get some sleep.

Maybe just copy and paste it with the kmap_local change and then do
another patch (series) to unify them again.  IIRC we also have a copy
and paste version in an mmc driver somewhere.

