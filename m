Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 001967DCBA1
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 12:18:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234787AbjJaLSY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Oct 2023 07:18:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229974AbjJaLSX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 07:18:23 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AA8697
        for <linux-kernel@vger.kernel.org>; Tue, 31 Oct 2023 04:18:21 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E680C433C8;
        Tue, 31 Oct 2023 11:18:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1698751100;
        bh=FrkgzgA5lVgOv9L7nzUu3Pnkn7b1h5ivphcK2rmy0/k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=0SnFDTNYaKYCbdOzEos6VTDFSfwrsP68TOPQnm1RW6NlEHxCMLjW5JSmUoK5ya9Yn
         wvsTROrz11Ki59JxvLNnYJdmRMpdVzi6WC2gjr3O2xq6Rd0NE5r/0OMIHmdM+ucQvJ
         c0k+YQyEE43MNueByonhQ6Zw4tfdwPoxruNsrMr4=
Date:   Tue, 31 Oct 2023 12:18:17 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Jinjie Ruan <ruanjinjie@huawei.com>
Cc:     catalin.marinas@arm.com, will.deacon@arm.com, mark.rutland@arm.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4.19] arm64: fix a concurrency issue in
 emulation_proc_handler()
Message-ID: <2023103103-revision-gigantic-cc05@gregkh>
References: <20231030063709.2443546-1-ruanjinjie@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231030063709.2443546-1-ruanjinjie@huawei.com>
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 30, 2023 at 06:37:09AM +0000, Jinjie Ruan wrote:
> In linux-6.1, the related code is refactored in commit 124c49b1b5d9
> ("arm64: armv8_deprecated: rework deprected instruction handling") and this
> issue was incidentally fixed. I have adapted the patch set to linux stable
> 5.10. However, 4.19 and 5.10 are too different and the patch set is
> hard to adapt to 4.19.

This is also needed for 5.4.y, right?  Now queued up for both.

thanks,

greg k-h
