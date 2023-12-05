Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C693805C78
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 18:50:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346055AbjLEPQp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 10:16:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346037AbjLEPQn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 10:16:43 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A882A9
        for <linux-kernel@vger.kernel.org>; Tue,  5 Dec 2023 07:16:50 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22A56C433C8;
        Tue,  5 Dec 2023 15:16:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701789409;
        bh=4lQZU/iiBrQ2BVAUSiRFmUkdr9sJyS+QQfQ/bWOyXU8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cgyFcZBFaqEOr6nyh4d25BAzG1aFR0qPFX4vWiT16EcfHLqekTkGfO9IBHcNmW3pn
         8jjTupD7KniAU9tGtc2egHT1T2PphXDFFLcep/WCTqznAC0TfwFD7LijuEqSqii+rm
         TvAHIHnLEBnJAT3OaKXl1i7tXKy8UwQcSnBS/PKG9jollKPyYcFnFHzBsB/6oMYDDk
         uenJNsAV5H+HAtSE7wuplRBus9QsNLqwOPg5sR9qsGolvYUHef2XqAiy/DTgpNAoVO
         RB3HO6h1GwKCsxiM6IRJ/t4NJs43nlKHh8S6j4NIEIu6b5pE8LPgd1V+m1aCLcRwec
         cUAprCWWxnQHA==
From:   Will Deacon <will@kernel.org>
To:     Anshuman Khandual <anshuman.khandual@arm.com>,
        linux-arm-kernel@lists.infradead.org
Cc:     catalin.marinas@arm.com, kernel-team@android.com,
        Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org,
        Mark Rutland <mark.rutland@arm.com>,
        James Clark <james.clark@arm.com>
Subject: Re: [PATCH V2 RESEND] drivers: perf: arm_pmuv3: Add new macro PMUV3_INIT_MAP_EVENT()
Date:   Tue,  5 Dec 2023 15:16:28 +0000
Message-Id: <170177961082.1060333.9015278022225472341.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20231114061656.337231-1-anshuman.khandual@arm.com>
References: <20231114061656.337231-1-anshuman.khandual@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 14 Nov 2023 11:46:56 +0530, Anshuman Khandual wrote:
> This further compacts all remaining PMU init procedures requiring specific
> map_event functions via a new macro PMUV3_INIT_MAP_EVENT(). While here, it
> also changes generated init function names to match to those generated via
> the other macro PMUV3_INIT_SIMPLE(). This does not cause functional change.
> 
> 

Applied to will (for-next/perf), thanks!

[1/1] drivers: perf: arm_pmuv3: Add new macro PMUV3_INIT_MAP_EVENT()
      https://git.kernel.org/will/c/877806b9b41e

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
