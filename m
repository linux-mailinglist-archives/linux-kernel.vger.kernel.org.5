Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23E8C769C72
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 18:27:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233373AbjGaQ1h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 12:27:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231479AbjGaQ12 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 12:27:28 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22B2A173F;
        Mon, 31 Jul 2023 09:27:04 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 90AF268AA6; Mon, 31 Jul 2023 18:26:39 +0200 (CEST)
Date:   Mon, 31 Jul 2023 18:26:39 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Christoph Hellwig <hch@lst.de>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Yangbo Lu <yangbo.lu@nxp.com>,
        Joshua Kinard <kumba@gentoo.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        linux-arm-kernel@lists.infradead.org,
        open list <linux-kernel@vger.kernel.org>,
        "linux-mmc @ vger . kernel . org" <linux-mmc@vger.kernel.org>,
        Netdev <netdev@vger.kernel.org>, linux-rtc@vger.kernel.org,
        linux-modules@vger.kernel.org
Subject: Re: [PATCH 1/5] ARM/pxa: use EXPORT_SYMBOL_GPL for
 sharpsl_battery_kick
Message-ID: <20230731162639.GA9441@lst.de>
References: <20230731083806.453036-1-hch@lst.de> <20230731083806.453036-2-hch@lst.de> <86b73242-94bb-4537-92ec-51da02127848@app.fastmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <86b73242-94bb-4537-92ec-51da02127848@app.fastmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 31, 2023 at 06:12:22PM +0200, Arnd Bergmann wrote:
> Or let me know if you want a better fix. Since sharpsl_pm.c and
> spitz.c are no longer loadable modules and just get linked together
> these days, I think the variant below would be simpler (this could
> be cleanup up further, endlessly, of course):

That actually looks way nicer, thanks!

If you give me a singoff I'll add it to the next version.
