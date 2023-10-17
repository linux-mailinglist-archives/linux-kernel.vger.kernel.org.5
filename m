Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D1DA7CBED1
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 11:18:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234854AbjJQJSg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 05:18:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343526AbjJQJSW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 05:18:22 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2842FFC
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 02:18:19 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02222C433C8;
        Tue, 17 Oct 2023 09:18:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697534298;
        bh=qpijEw30yO3I2i4Uh+AxUics0aVeq+2voohpeVVfsx0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nsU6RJai9l9r7EFx/ChKj/t66QnpD+1dy54G4HcVFW82W+w/XQz6Wxid4JblCIvn6
         W8PdyT2DOmlVHTCnx6+irc9SIUuVn5MD08vbq9FspQXJQ6zy4qZiDieAYNQTpjQL/y
         W1J6d3JGLUqmR+hwojyvnlZY5a0lrpILlr+st0jet7OCi8XU5FEuEI48Jedw5vXYOg
         enRIxZPxktpgBGJgZTTY3a7wdwDo7wXs9uD1j3x6/hsexQ4TPmpACkWaVQ5/8/Av1P
         PPV67ivkYVaitTao93HKq1EbE8f+twnBKBtNQ6WctaJNQDJ7dxBJxnLMHOrwAe1FG0
         RZWNSBQVBYkGw==
Date:   Tue, 17 Oct 2023 11:18:14 +0200
From:   Simon Horman <horms@kernel.org>
To:     Nandha Kumar Singaram <nandhakumar.singaram@gmail.com>
Cc:     Manish Chopra <manishc@marvell.com>, GR-Linux-NIC-Dev@marvell.com,
        Coiby Xu <coiby.xu@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        netdev@vger.kernel.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org, kumaran.4353@gmail.com
Subject: Re: [PATCH] staging: qlge: Replace the occurrences of (1<<x) by
 BIT(x)
Message-ID: <20231017091814.GS1751252@kernel.org>
References: <20231015133558.GA5489@ubuntu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231015133558.GA5489@ubuntu>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 15, 2023 at 06:35:58AM -0700, Nandha Kumar Singaram wrote:
> Adhere to linux coding style. Reported by checkpatch.pl:
> CHECK: Prefer using the BIT macro
> 
> Signed-off-by: Nandha Kumar Singaram <nandhakumar.singaram@gmail.com>

Hi Nandha,

I am assuming that checkpatch clean ups are acceptable, perhaps
even desired, in staging. So this patch seems appropriate to me.

I do, however, see a lot more potential uses of BIT() in qlge.h.
Could you take a second look?

...
