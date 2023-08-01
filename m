Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28B2476BB94
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 19:45:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231350AbjHARpp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 13:45:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229837AbjHARpo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 13:45:44 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19DF510C1;
        Tue,  1 Aug 2023 10:45:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=/SNNgw/0FDaNa7MTCNWJpiQbUlIU4iWNomHuRRVtt+I=; b=H9B1lsIkB15nld7dwESmfbaR7w
        WeN0JxBza+uKWmSaQBaYPxF7vfSsrbCuvkUU9fMtXortagJLx1Z7gKKPhMk0dumxD+Vat/LzD5ujW
        gmA1NquVRC4+tgo23/jsSIoUTQkYWFBAO6zhnR24V8pr92HmKcMVoZG99hcZ6fRndSfh6tVETsGT7
        zUj6K8TI3K4Ddj0Haw1c6Qoh3BPmbRKTb1aCCq5K0bPeLyBJDep2WhBhIpA01MZZZNh0eI+AUpfgA
        UndiA96n1UbMqiBbuO2GCO7v2gWTXYgQyVASSXos+NIzjzcxbsE3mZ1OACtLOJnMqn1+m+VZWtZY8
        S2xwl0xw==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1qQtR8-002xRj-1K;
        Tue, 01 Aug 2023 17:45:34 +0000
Date:   Tue, 1 Aug 2023 10:45:34 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Manuel Lauss <manuel.lauss@gmail.com>,
        Yangbo Lu <yangbo.lu@nxp.com>,
        Joshua Kinard <kumba@gentoo.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Arnd Bergmann <arnd@arndb.de>,
        linux-arm-kernel@lists.infradead.org,
        open list <linux-kernel@vger.kernel.org>,
        linux-mmc@vger.kernel.org, netdev@vger.kernel.org,
        linux-rtc@vger.kernel.org, linux-modules@vger.kernel.org
Subject: Re: require EXPORT_SYMBOL_GPL symbols for symbol_get v2
Message-ID: <ZMlEvr1Vo+475e5X@bombadil.infradead.org>
References: <20230801173544.1929519-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230801173544.1929519-1-hch@lst.de>
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 01, 2023 at 07:35:39PM +0200, Christoph Hellwig wrote:
> Hi all,
> 
> this series changes symbol_get to only work on EXPORT_SYMBOL_GPL
> as nvidia is abusing the lack of this check to bypass restrictions
> on importing symbols from proprietary modules.

Reviewed-by: Luis Chamberlain <mcgrof@kernel.org>

Let me know if you want this to go through the modules tree or your own.

  Luis

