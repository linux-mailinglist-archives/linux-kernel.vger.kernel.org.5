Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9017C7653A1
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 14:23:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234092AbjG0MXL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 08:23:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234176AbjG0MW5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 08:22:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1502F3A97
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 05:22:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3D81961E5C
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 12:22:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E4D1C433C7;
        Thu, 27 Jul 2023 12:22:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690460565;
        bh=ZjjQ4YJMlZK7eBQkX1B2FnhLIHumREBi1I1m3omRNGw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=K6QxR0FaK2bNNEA4ErtKiiv6uMcAPzdrakbPdjSTWCgqcui0QoFjsA6ceG41lD/Rk
         IitBW2WKYIxMTubSfvJP7vWdl/gTHcPO/SktUsquRO669/7D+Od+fxBbCFpMaKZQvF
         oeEhJpBXV+CsTofO9Ys04YN+jpfe9LaR85osen6VHghE0TE13npTaJLXUir4Il3y/j
         8wuse7T2AarU5xsPQm57q6aQFgyi6903QjCWvKDSD028WSVtOU77BCEcoc0GDMr1uE
         G5WlcR0iMTNKQvnaTrXtmmbUNBB6ZyAXrnmz/zpqIJ1nnKNTIt1QSBZQiB0tmHLCFN
         9bfstDh9ii32Q==
From:   Will Deacon <will@kernel.org>
To:     Anshuman Khandual <anshuman.khandual@arm.com>,
        linux-arm-kernel@lists.infradead.org
Cc:     catalin.marinas@arm.com, kernel-team@android.com,
        Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64/mm: Directly use ID_AA64MMFR2_EL1_VARange_MASK
Date:   Thu, 27 Jul 2023 13:22:26 +0100
Message-Id: <169045270533.2140551.16114848783763636247.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20230711092055.245756-1-anshuman.khandual@arm.com>
References: <20230711092055.245756-1-anshuman.khandual@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 11 Jul 2023 14:50:55 +0530, Anshuman Khandual wrote:
> Tools generated register fields have in place mask macros which can be used
> directly instead of shifting the older right end sided masks.
> 
> 

Applied to arm64 (for-next/mm), thanks!

[1/1] arm64/mm: Directly use ID_AA64MMFR2_EL1_VARange_MASK
      https://git.kernel.org/arm64/c/62ce7af97ba5

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
