Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E30C377CDE0
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 16:11:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237537AbjHOOL3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 10:11:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237555AbjHOOLF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 10:11:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DE05199B;
        Tue, 15 Aug 2023 07:11:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9AEBF62C9C;
        Tue, 15 Aug 2023 14:11:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5BB76C433C9;
        Tue, 15 Aug 2023 14:10:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692108663;
        bh=IhgKIaCPd+mwevpEPUSDQZbSsOZK+yrdE/Fu9JPnvXw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pK3EUfmzxr5H5AGVajSpO3bVBNMnf8/nnT7gE+x2ZsXaUoSmN8vzLXKBn5KlrfO8a
         F+ZQ+tJrtUks5d6DqsU0iyIXFofegNIaHes6Iiclv0PHwxqzbMwovfckO+cf6Y+VsX
         1X9ntDMWuj2W7GfuFQae4Fe91iirYZ3n6vdL6/rWk2nKdclnEE+f/8nYtuwx671CRs
         fDROWl07GrtNHlwJTt5R4MXHxsb1gw52b+3QGGPXKhNqD/SJt2O7Ldh6IHAv2lNOrP
         mcRcUgNs20v1+pkcq5zdgBbKbJBjZZCg3wSC19vZjtIjedS/919vE326w9/k5zUgc5
         0Qq4tYrkkGxWQ==
From:   Will Deacon <will@kernel.org>
To:     linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
        robin.murphy@arm.com, linux-acpi@vger.kernel.org,
        lpieralisi@kernel.org, guohanjun@huawei.com, mark.rutland@arm.com,
        rafael@kernel.org, corbet@lwn.net,
        Yicong Yang <yangyicong@huawei.com>, catalin.marinas@arm.com
Cc:     kernel-team@android.com, Will Deacon <will@kernel.org>,
        yangyicong@hisilicon.com, jonathan.cameron@huawei.com,
        zhurui3@huawei.com, hejunhao3@huawei.com,
        linux-kernel@vger.kernel.org, prime.zeng@hisilicon.com,
        shameerali.kolothum.thodi@huawei.com, linuxarm@huawei.com
Subject: Re: [PATCH v2] perf/smmuv3: Enable HiSilicon Erratum 162001900 quirk for HIP08/09
Date:   Tue, 15 Aug 2023 15:10:50 +0100
Message-Id: <169210025390.538323.7942274665229323750.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20230814124012.58013-1-yangyicong@huawei.com>
References: <20230814124012.58013-1-yangyicong@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 14 Aug 2023 20:40:12 +0800, Yicong Yang wrote:
> From: Yicong Yang <yangyicong@hisilicon.com>
> 
> Some HiSilicon SMMU PMCG suffers the erratum 162001900 that the PMU
> disable control sometimes fail to disable the counters. This will lead
> to error or inaccurate data since before we enable the counters the
> counter's still counting for the event used in last perf session.
> 
> [...]

Applied to will (for-next/perf), thanks!

[1/1] perf/smmuv3: Enable HiSilicon Erratum 162001900 quirk for HIP08/09
      https://git.kernel.org/will/c/0242737dc4eb

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
