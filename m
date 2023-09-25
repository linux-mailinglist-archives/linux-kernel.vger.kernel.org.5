Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 834317ADAB7
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 16:55:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232435AbjIYO4A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 10:56:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232395AbjIYOz5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 10:55:57 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F04810C;
        Mon, 25 Sep 2023 07:55:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=wJKSHvRX2JxkhPx/HsYL92E1VTGeWyXM9NmRTnd2dkM=; b=KMgCFdcYzdi4gJvjK3P/sbbm3j
        WY1MDli4qbflqNzaQAQ4MI0hGRJunn+B/+4PUyReklOdHF9lVO8ix/vQjT2pcYI7At97OILvsSP1m
        anl6QjfMJ/OQ68+T6S2Ng9OcCVmtmfN2vkNm8BTYEAjSTe86zgL2l65ogXqeJTLk6GYethIbJ6eih
        q90vhS8qP7LHFe298SL/48kJ1oiHSduLIXykGeKNx47B4t955qe1Rmmw0XW7vRuzOVob08iKcPgET
        0+BZQrFImlnb+7OREtu+G3JQNwaPYL9zE9AK4isuXxM9R9HukQ1jeQg93Ujowqmvts7m0G4TQUZ+H
        Yy6BaiFg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1qkmzz-00EU4W-2A;
        Mon, 25 Sep 2023 14:55:47 +0000
Date:   Mon, 25 Sep 2023 07:55:47 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Wenchao Hao <haowenchao2@huawei.com>
Cc:     "James E . J . Bottomley" <jejb@linux.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, Hannes Reinecke <hare@suse.de>,
        linux-kernel@vger.kernel.org, louhongxiang@huawei.com,
        lixiaokeng@huawei.com
Subject: Re: [RFC PATCH v2 00/18] scsi: scsi_error: Introduce new error
 handle mechanism
Message-ID: <ZRGfc73BSW0yyUtI@infradead.org>
References: <20230901094127.2010873-1-haowenchao2@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230901094127.2010873-1-haowenchao2@huawei.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Before we add another new error handling mechanism we need to fix the
old one first.  Hannes' work on not passing the scsi_cmnd to the various
reset handlers hasn't made a lot of progress in the last five years and
we'll need to urgently fix that first before adding even more
complexity.

