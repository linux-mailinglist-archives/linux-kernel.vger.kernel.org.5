Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2954E7D8EF5
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 08:52:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345289AbjJ0Gw3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Oct 2023 02:52:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229590AbjJ0Gw1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Oct 2023 02:52:27 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28E1E1A1
        for <linux-kernel@vger.kernel.org>; Thu, 26 Oct 2023 23:52:25 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47976C433C8;
        Fri, 27 Oct 2023 06:52:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1698389544;
        bh=FOFQHXHa8o0hAoUQR/R/cvgIByHdvM6QYZCpeAwOXB4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=1mATErMHA8kqjiU2UmW3F8y7xndcRNxen9+NHOqkpyR2G3TI20NpVNc5Ui0pPh7wz
         gF6zENaby5Kiop3uC4w717tB9CWLNN8pLSE5QV5Lk0q/KW5xqvt0lZCWpRe1UB3mR0
         n3ixYM8/NHCTcIibwIagSXJt+m1yCnYKmQdOZXIw=
Date:   Fri, 27 Oct 2023 08:52:20 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Zhangfei Gao <zhangfei.gao@linaro.org>
Cc:     linux-accelerators@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Zhou Wang <wangzhou1@hisilicon.com>,
        Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] uacce: make uacce_class constant
Message-ID: <2023102713-viewer-varied-d956@gregkh>
References: <2023102458-designate-vicinity-4c86@gregkh>
 <CABQgh9FYB21pm+-fB1hBYnM5rv70RqTc0NABmxdBt1AxUyNJdA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABQgh9FYB21pm+-fB1hBYnM5rv70RqTc0NABmxdBt1AxUyNJdA@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 26, 2023 at 10:21:52AM +0800, Zhangfei Gao wrote:
> On Tue, 24 Oct 2023 at 19:50, Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> >
> > Now that the driver core allows for struct class to be in read-only
> > memory, we should make all 'class' structures declared at build time
> > placing them into read-only memory, instead of having to be dynamically
> > allocated at runtime.
> >
> > Cc: Zhangfei Gao <zhangfei.gao@linaro.org>
> > Cc: Zhou Wang <wangzhou1@hisilicon.com>
> > Cc: Arnd Bergmann <arnd@arndb.de>
> > Cc: linux-accelerators@lists.ozlabs.org
> > Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> 
> Thanks, Greg
> 
> Tested-by: Zhangfei Gao <zhangfei.gao@linaro.org>

Wonderful, thanks for testing!
