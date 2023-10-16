Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55A347CB365
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 21:38:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233270AbjJPTiw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 15:38:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233165AbjJPTiv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 15:38:51 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D8A783
        for <linux-kernel@vger.kernel.org>; Mon, 16 Oct 2023 12:38:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=VEMJ3qWfc/gnGMZ0WkHMvFgA9KFv1dUBDfwsGx8hNoM=; b=v81BEFrNrTBukCrZ/IZ+oL7c6r
        +G64zWrtJcjcPbJnCz4o850qqM6EHAsJaIuCv1gTnW7rMgrKMjsqHPPz/5IP5irBfIgZ2zHlHdMpS
        5vgnRiuxfzS3B2Rl9nl5TfGG0qF8kBb4dGhXBUAzXzp12QjB6B0swzaBHrLCubsSHTiXVBZwzcMX/
        VNcqCuQjgsRKQMd2gsNfUdQWQGdjDSqEOL3oK18JAdnxEEHYaUy3HTDk4k/aaSYZQswjy+cwqd/bu
        Ap9wcNAEjxy6f1Py5mRHS3C9QC1V3rws8Ma9o2YGEssnjHdN0Rqb9KqldY6xPBxBzXHGoOEpay8mm
        BRnE3G/w==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1qsTQJ-00AQCx-0s;
        Mon, 16 Oct 2023 19:38:43 +0000
Date:   Mon, 16 Oct 2023 12:38:43 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Joel Granados <j.granados@samsung.com>,
        linux-kernel@vger.kernel.org,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [resend, PATCH v1 0/3] parport: Switch to some modern APIs
Message-ID: <ZS2RQ7g4jxYs7qRt@bombadil.infradead.org>
References: <20231016133135.1203643-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231016133135.1203643-1-andriy.shevchenko@linux.intel.com>
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

On Mon, Oct 16, 2023 at 04:31:32PM +0300, Andy Shevchenko wrote:
> This is a set of ad-hoc refactorings and cleanups to the parport driver.
> 
> In v1,resent:
> - resent with Greg KH in Cc list
> 
> Initial contribution have been seen here 6 weeks ago:
> https://lore.kernel.org/r/20230901134250.1172990-1-andriy.shevchenko@linux.intel.com
> 
> Andy Shevchenko (3):
>   parport: Use kasprintf() instead of fixed buffer formatting
>   parport: Use list_for_each() helper
>   parport: Drop unneeded NULL or 0 assignments

Nice cleanup!

Reviewed-by: Luis Chamberlain <mcgrof@kernel.org>

  Luis
