Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BD71798426
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Sep 2023 10:35:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238863AbjIHIfs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Sep 2023 04:35:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238621AbjIHIfr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Sep 2023 04:35:47 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C4681BF5;
        Fri,  8 Sep 2023 01:35:42 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id DAFA068B05; Fri,  8 Sep 2023 10:35:38 +0200 (CEST)
Date:   Fri, 8 Sep 2023 10:35:38 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Stefan Lippers-Hollmann <s.l-h@gmx.de>, stable@vger.kernel.org,
        patches@lists.linux.dev, Christoph Hellwig <hch@lst.de>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6.5 11/34] modules: only allow symbol_get of
 EXPORT_SYMBOL_GPL modules
Message-ID: <20230908083538.GA10228@lst.de>
References: <20230904182948.594404081@linuxfoundation.org> <20230904182949.104100132@linuxfoundation.org> <20230907084135.02d97441@mir> <2023090719-virtuous-snowflake-d015@gregkh> <20230907221737.07f12f38@mir> <2023090848-chastise-paycheck-6d4d@gregkh> <2023090841-antitrust-reword-d6bc@gregkh> <20230908083139.GA9985@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230908083139.GA9985@lst.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 08, 2023 at 10:31:39AM +0200, Christoph Hellwig wrote:
> On Fri, Sep 08, 2023 at 08:07:08AM +0100, Greg Kroah-Hartman wrote:
> > And it's over 130 symbols, attached, I'll figure out a way to script
> > this...
> 
> Eww. Sorry for missing this, and I suspect it really should be
> entirely reworked in the future.  But for now the scripting sounds
> right.  Let me know if you'd done anything, otherwise I can look into
> it this afternoon Chilean time.

.. and it turns out dvb_attach has already been deprecated for 5 years
time, it's just that it still has all these users around.
