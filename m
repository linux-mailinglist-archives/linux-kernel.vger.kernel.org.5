Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F07357653A2
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 14:23:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229801AbjG0MXS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 08:23:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234203AbjG0MW6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 08:22:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF1BB3AAD
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 05:22:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D76C861E58
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 12:22:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17442C433CB;
        Thu, 27 Jul 2023 12:22:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690460567;
        bh=2yFuncp9B0GmOtmtU9VqghvfUsu8KVXcrQJfhNrGwfo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FPG4bhKqFsR4c/o55c3gx5DUVGOwf4SpG7MuvmWhml07DaQvSPVrxgo+RHk3I+xrN
         8qKlBfYahP0PDB+Aydo5T5+yp06gYEJy52nAbViBYSkhkLDUY1ZlxegYOCrsdFdf52
         FeVOwE6Rkup8jFQwrKYnn8wc4Pj0tpfCDxv8ea0fybeEG5umAIcWJw0BnKU1B3Cf1e
         Ey0B2+XWe1crShE4Yjg1rH6yuD5S+pwyx0hAZHhNx0MlpJCqj8L/qCpeJAoYvxHA3p
         hfKrbuihod9pgXTAAHg+DZ7WjSj7Vn3K70SZp120Tu/+OWKCJt++Ah1B54I00wrkl1
         lJpy5rXwZjLMA==
From:   Will Deacon <will@kernel.org>
To:     linux-arm-kernel@lists.infradead.org,
        Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     catalin.marinas@arm.com, kernel-team@android.com,
        Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64/mm: Replace an open coding with ID_AA64MMFR1_EL1_HAFDBS_MASK
Date:   Thu, 27 Jul 2023 13:22:27 +0100
Message-Id: <169045210667.2094040.6244703578911220597.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20230711090458.238346-1-anshuman.khandual@arm.com>
References: <20230711090458.238346-1-anshuman.khandual@arm.com>
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

On Tue, 11 Jul 2023 14:34:58 +0530, Anshuman Khandual wrote:
> Replace '0xf' with ID_AA64MMFR1_EL1_HAFDBS_MASK while evaluating if the cpu
> supports implicit page table entry access flag update in HW.
> 
> 

Applied to arm64 (for-next/mm), thanks!

[1/1] arm64/mm: Replace an open coding with ID_AA64MMFR1_EL1_HAFDBS_MASK
      https://git.kernel.org/arm64/c/d0999555e306

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
