Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E39CB758119
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 17:38:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232827AbjGRPiY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 11:38:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233682AbjGRPiV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 11:38:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B54719A0;
        Tue, 18 Jul 2023 08:37:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B98066163F;
        Tue, 18 Jul 2023 15:37:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8838C433C8;
        Tue, 18 Jul 2023 15:37:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689694674;
        bh=4lzpTYj2kIXHXWaJYs/83EbVi/o1EKnwum3LfzARXr8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=cNzyHRvyhQo8fy2tY5qhlfauywDksEZ+wW+jlrLSvyw0CUNqEW+spb+JpKUeB2vOF
         XRpuWyi5psLzSvAtrML+E9fp18f+Wxveel+SbkG2kyrEQIi1sELC0TkdIjv8SKOj6E
         HvfhLomkv0Sc67piLn6lGkvzrpMvQz7GqNiKqfkczbT1uZnRHaCUYs7u4O3MUvUPeQ
         rP7waYDkAeKoM0V0LAbaZjfjyY+bD8tj/zX3/bJBJtCrOHshOjfjNsx8x45l1cEGDE
         37ios2bSMjDt03MW1wvDgqPoxSzZVqBJqMqK2DNaN3mYtVo/gjp/77YoiLOgZpOhX2
         XoHMPrp44k96A==
Date:   Tue, 18 Jul 2023 08:37:53 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     "Linux regression tracking (Thorsten Leemhuis)" 
        <regressions@leemhuis.info>
Cc:     Linux regressions mailing list <regressions@lists.linux.dev>,
        Krzysztof Kozlowski <krzk@kernel.org>, corbet@lwn.net,
        workflows@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org,
        Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH docs] docs: maintainer: document expectations of small
 time maintainers
Message-ID: <20230718083753.2d1e003a@kernel.org>
In-Reply-To: <bb8c6476-283c-3bc6-710b-5a8602ccd40e@leemhuis.info>
References: <20230713223432.1501133-1-kuba@kernel.org>
        <6f1014cd-f8c5-f935-dcc7-4f5a6b85e473@kernel.org>
        <20230714101028.337fb39a@kernel.org>
        <bb8c6476-283c-3bc6-710b-5a8602ccd40e@leemhuis.info>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 15 Jul 2023 12:31:02 +0200 Linux regression tracking (Thorsten
Leemhuis) wrote:
> Maintainers must ensure severe problems in their code reported to them
> are resolved in a timely manner: security vulnerabilities, regressions,
> compilation errors, data loss, kernel crashes, and bugs of similar scope.

SG, thanks for the suggestion!

One edit - I'd like to remove "security vulnerabilities" from the list.
Security implications are an axis on which bug can be evaluated, one of
many. All kernel bugs have some security implications. Placing them as
a category like crashes, lockups or compiler errors could deepen the
confusion.
