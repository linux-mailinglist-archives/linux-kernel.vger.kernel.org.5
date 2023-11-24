Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DABDA7F773A
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Nov 2023 16:06:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345669AbjKXPGC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Nov 2023 10:06:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345657AbjKXPFo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Nov 2023 10:05:44 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 965811BD5
        for <linux-kernel@vger.kernel.org>; Fri, 24 Nov 2023 07:05:50 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BEF88C433CA;
        Fri, 24 Nov 2023 15:05:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700838350;
        bh=Lw4ddp5SRRaHbNDe7CMkDvQErv4vbWF/4A45oJbqhsQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pdevLJfVyCSjjA1P3fYUGSKdZZHBnKVrNkLw7Bo/RLiSgERLtxK3EsjDDdBh7DfSp
         BT/ltxx8EX+6aPl761mJCK+kBsI6Xj4Yqpi83meTzIS1A9hSbNQaUUx8qyURovyDs8
         bN4RTVQiSHWV/s3DuiLmJUV7jYFviPxaOWnynjLc=
Date:   Fri, 24 Nov 2023 15:05:47 +0000
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Oleksij Rempel <o.rempel@pengutronix.de>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Mark Brown <broonie@kernel.org>, kernel@pengutronix.de,
        linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org,
        linux-pm@vger.kernel.org,
        =?iso-8859-1?Q?S=F8ren?= Andersen <san@skov.dk>
Subject: Re: [PATCH v1 0/3] introduce priority-based shutdown support
Message-ID: <2023112403-laxative-lustiness-6a7f@gregkh>
References: <20231124145338.3112416-1-o.rempel@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231124145338.3112416-1-o.rempel@pengutronix.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 24, 2023 at 03:53:35PM +0100, Oleksij Rempel wrote:
> Hi,
> 
> This patch series introduces support for prioritized device shutdown.
> The main goal is to enable prioritization for shutting down specific
> devices, particularly crucial in scenarios like power loss where
> hardware damage can occur if not handled properly.

Oh fun, now we will have drivers and subsystems fighting over their
priority, with each one insisting that they are the most important!

/s

Anyway, this is ripe for problems and issues in the long-run, what is so
special about this hardware that it can not just shutdown in the
existing order that it has to be "first" over everyone else?  What
exactly does this prevent and what devices are requiring this?

And most importantly, what has changed in the past 20+ years to
suddenly require this new functionality and how does any other operating
system handle it?

thanks,

greg k-h
