Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28A017DB8F7
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Oct 2023 12:31:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233005AbjJ3LbC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Oct 2023 07:31:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232994AbjJ3La7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Oct 2023 07:30:59 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05041C2
        for <linux-kernel@vger.kernel.org>; Mon, 30 Oct 2023 04:30:57 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19F5FC433C9;
        Mon, 30 Oct 2023 11:30:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1698665456;
        bh=q5C0XeoTb5hF68Y7iJ6RhFTSeQ2+oNiU+mCivDgdJug=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ewS67qD/AN4O2GttzBkCrJ9iizj+il5TiSzrNQwNRqWwCeSz+eQ8oR3tTF/e7V4jQ
         DakM3od+7l9fNCldh9moD5Yhj4uqWRL6trv9OaXN1SYmhaJPORzYFlW989Cel6aErJ
         TU1D5AhVE1erOcIcZOZ0kvc8RvmA49konJyxQSr8=
Date:   Mon, 30 Oct 2023 12:30:53 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Tingwei Zhang <quic_tingweiz@quicinc.com>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org, Trilok Soni <quic_tsoni@quicinc.com>,
        Jinlong Mao <quic_jinlmao@quicinc.com>
Subject: Re: How to pass software configuration to driver built as module in
 boot up phase
Message-ID: <2023103021-revolving-clapper-632d@gregkh>
References: <1c001c6f-9902-4803-9406-39e3325422bf@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1c001c6f-9902-4803-9406-39e3325422bf@quicinc.com>
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 30, 2023 at 07:21:48PM +0800, Tingwei Zhang wrote:
> Hi Masami, Greg and Rafael,
> 
> I have one driver that needs a bunch to software configuration like 1000
> settings. These settings can be different according to the use case.

That seems very odd, what type of driver is this?

> They are required in boot up phase so we can't reply on user space to make
> the configuration.
> 
> Boot config is not preferred since we'd like to build that driver as dynamic
> load Kernel module.
> 
> Could you let me know if there's any mechanism in Kernel to do that?

What is wrong with the existing ways of doing this that all other
drivers use?

thanks,

greg k-h
