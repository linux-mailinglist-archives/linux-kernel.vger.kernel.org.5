Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F4B3770168
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 15:25:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231211AbjHDNZJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 09:25:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231209AbjHDNYs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 09:24:48 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21D5149D8
        for <linux-kernel@vger.kernel.org>; Fri,  4 Aug 2023 06:24:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DA3896200D
        for <linux-kernel@vger.kernel.org>; Fri,  4 Aug 2023 13:23:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E93E9C433C8;
        Fri,  4 Aug 2023 13:23:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1691155400;
        bh=mHvtUgTV+sL0E6Wpk6D+SmtTx6hmt2jVkrZBdiW+48A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Ab0VHma4hqH9xJgAdStKiDFGpZpwOuCoGXp68Nh/ljiTG4KWscNcsapYA4S6P+1Gz
         fXI01DrE3SKTudGG7aARlzEXgIPZXygjjLOO4gkyqKvAfGi4vMs8nybQqdf9JaXI1V
         RR0kVN1lGj5yRAPUcMMyLbcVfLPrnRx6iT3oTVCc=
Date:   Fri, 4 Aug 2023 15:23:17 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Alexon Oliveira <alexondunkan@gmail.com>
Cc:     martyn@welchs.me.uk, manohar.vanga@gmail.com,
        linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev,
        dan.carpenter@linaro.org
Subject: Re: [PATCH v2] staging: vme_user: fix check alignment should match
 open parenthesis
Message-ID: <2023080424-mantra-stagnant-a912@gregkh>
References: <ZMkwA8TnMBAgPRgR@alolivei-thinkpadt480s.gru.csb>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZMkwA8TnMBAgPRgR@alolivei-thinkpadt480s.gru.csb>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 01, 2023 at 01:17:07PM -0300, Alexon Oliveira wrote:
> First patch was intended to fix all "CHECK: Alignment should match open parenthesis",
> but added new warnings in the process. This patch is intended to fixed them all,
> on lines 133, 142, 144, 145 and 173.

Patches are stand-alone, we have no idea what "First patch" is.

Please look at the commit log for this file, or for all of
drivers/staging:
	git log drivers/staging/
and get an idea of what changelog text should look like.


thanks,

greg k-h
