Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 098E08115F9
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 16:19:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442474AbjLMPTP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 10:19:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442459AbjLMPTO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 10:19:14 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32680EA
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 07:19:21 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9061C433C7;
        Wed, 13 Dec 2023 15:19:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1702480760;
        bh=aKQyqLRPtz8cBnFtl4KPJVdA7dWMQ5wPIzd85RCsUSI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=L38C7pKAouGb0Juinx4f/RnRsARz360TVksh6vKkWwro46zDD/hn2aeaXis7RuUvv
         AWwgJOsfSX5Xl4DYG+IsCiTTUoEIXiajCNsUx2u10okBtLJkU3m/8F1O77wD9CRwP1
         jProX4+XTuwRD1i7syVglvHGtu4vivMa73Kiqkfs=
Date:   Wed, 13 Dec 2023 10:19:19 -0500
From:   Konstantin Ryabitsev <konstantin@linuxfoundation.org>
To:     Willy Tarreau <w@1wt.eu>
Cc:     users@linux.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: PSA: final vger mailing list migration: Thu, Dec 14, 11AM PST
 (1900 UTC)
Message-ID: <20231213-gregarious-vole-of-luxury-42f22c@meerkat>
References: <20231212-unselfish-real-myna-67e444@lemur>
 <20231213052055.GA14113@1wt.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231213052055.GA14113@1wt.eu>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 13, 2023 at 06:20:55AM +0100, Willy Tarreau wrote:
> On Tue, Dec 12, 2023 at 04:36:28PM -0500, Konstantin Ryabitsev wrote:
> (...)
> > # Questions, comments?
> > 
> > If you have any questions or concerns, please reply to this message.
>  
> Thanks for this update. I'm having a no-delay rule on my SMTP server
> for a few well-known friendly senders whom I don't want to inflict
> the SMTP banner delay. Vger is on it the list. Which host will send
> messages now ? subspace.kernel.org or any other ? 

You can check the output of:

    dig -t txt _listspf.kernel.org

On our end, we use postwhite for similar purposes, which allows us to just add
domains and have it automatically generate the list of exceptions via
published spf records:

https://github.com/stevejenkins/postwhite

-K
