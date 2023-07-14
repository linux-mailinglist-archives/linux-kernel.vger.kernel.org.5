Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93100754063
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 19:22:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235648AbjGNRWX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 13:22:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230093AbjGNRWV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 13:22:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A77B1D9;
        Fri, 14 Jul 2023 10:22:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 409AA61D5B;
        Fri, 14 Jul 2023 17:22:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 585E2C433C7;
        Fri, 14 Jul 2023 17:22:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689355339;
        bh=cvR8io2qBz8kzxUr1jEMqMrZC8hHY6BHGFedAAMvJWY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=JhqNc8bZXrx5V2AAdDq4dPyhfLzCv9Dn126Dn3P16vLrWnOQOTjwXQPrXG7k6hKS6
         GSumKbXcePuwUqLNcElEZ8Sf/EUuAi9I6KnfKuof62Kk76Ls+K/6RZXq8FvoocKYWZ
         IYkOdqsk6OA/GH5JWwwutOtAet6XD7H8FG5FA04IV7u9TTgusU2aWHFNaClfVL6uiV
         bxb162H1Ms7rgIay0lCWefKiQLpfHL6la7Kv9XeUUnDJetEwAR4WIZ4LyQ4aNmWbwD
         mtWuDcvxD1ST+gDGC/yeyt8LfrLNexLW6DMH8sikM2cb0Jyxbg9bGNwrLiE9UpxjYP
         QSX2VJC7bkKRg==
Date:   Fri, 14 Jul 2023 10:22:18 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Thorsten Leemhuis <linux@leemhuis.info>
Cc:     corbet@lwn.net, workflows@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        gregkh@linuxfoundation.org
Subject: Re: [PATCH docs] docs: maintainer: document expectations of small
 time maintainers
Message-ID: <20230714102218.687ee2ea@kernel.org>
In-Reply-To: <f61a12c6-9587-9cb4-122e-dc3a74e58bd1@leemhuis.info>
References: <20230713223432.1501133-1-kuba@kernel.org>
        <f61a12c6-9587-9cb4-122e-dc3a74e58bd1@leemhuis.info>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 14 Jul 2023 08:24:38 +0200 Thorsten Leemhuis wrote:
> Also: It's totally normal that commercial vendor contribute basic
> drivers with known problems and missing features (some of which will
> never be implemented). The latter will be considered a "bug" for quite a
> few users that read this. Those suddenly thus might becomes something
> they now "must" fix, which leads to questions: how fast? just in
> mainline, or in stable, too?

If we try to fend off anyone who doesn't understand common meaning 
of words the document will be very long and painful to read.

> All this also opens questions like "what counts as bug report" -- I'd
> assume users that find and read this will expect that a report in
> bugzilla.kernel.org is one maintainers "must" respond to. But I assume
> you only meant bugs reports by mail or in trackers the MAINTAINERS file
> mentions?

I don't want to be too prescriptive, subsystems will vary.

> And overall I don't really like the way how handling of regressions is
> described in that section, as they afaics are expected to be handled
> with a higher priority than bugs.

Me neither, FWIW. I tried a couple of times to weave that information
in but I can't come up with a way of doing that without breaking the
logical flow. Could just be me. Edit to what I sent to Krzysztof would
be appreciated if you have one in mind.
