Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47159780FCC
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 18:06:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378315AbjHRQGM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Aug 2023 12:06:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378236AbjHRQFp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Aug 2023 12:05:45 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F234AE42;
        Fri, 18 Aug 2023 09:05:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 78D0C61B22;
        Fri, 18 Aug 2023 16:05:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B77DC433C8;
        Fri, 18 Aug 2023 16:05:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692374742;
        bh=BJY/X/OrUTc9OCn8r+cSv43KgNc/JdpyK6t6hn30eMU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=C4A0gtQwRiaLc8WQm077/wVlUth7fUXjeSRI6M1xXbomD8PZyUsjfVeuLS3owV73x
         DHz8UDOO/SzX/V1XcSi2leTNQCltIYQL5QBhFSAdemETf97DjKqNncXMAB+iqEKw2g
         U4C6Mwkd71psq0rREQIEbyjfPPzKPusHn/nDZhO2hgxmnQDtGGoFNiz0sM4N/Ohu9q
         rT8mWAhPOXYqriSUqeBq7xNdTukIHJd++YcfHo3IYihquJ0Vd29sqyG/jeMo3qoaXd
         8LLJjVbeaEUrXAw3aDoHwGf5FxP1qBKMJEw+ntNt/K4l/023tEvKzRalo6HocM6XCQ
         yigf2+UgJOxmA==
Date:   Fri, 18 Aug 2023 17:05:36 +0100
From:   Will Deacon <will@kernel.org>
To:     Besar Wicaksono <bwicaksono@nvidia.com>
Cc:     suzuki.poulose@arm.com, robin.murphy@arm.com,
        ilkka@os.amperecomputing.com, catalin.marinas@arm.com,
        mark.rutland@arm.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org,
        treding@nvidia.com, jonathanh@nvidia.com, vsethi@nvidia.com,
        rwiley@nvidia.com, efunsten@nvidia.com
Subject: Re: [PATCH v5] perf: arm_cspmu: Separate Arm and vendor module
Message-ID: <20230818160536.GA16119@willie-the-truck>
References: <20230705104745.52255-1-bwicaksono@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230705104745.52255-1-bwicaksono@nvidia.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Besar,

On Wed, Jul 05, 2023 at 05:47:45AM -0500, Besar Wicaksono wrote:
> Arm Coresight PMU driver consists of main standard code and
> vendor backend code. Both are currently built as a single module.
> This patch adds vendor registration API to separate the two to
> keep things modular. The main driver requests each known backend
> module during initialization and defer device binding process.
> The backend module then registers an init callback to the main
> driver and continue the device driver binding process.
> 
> Signed-off-by: Besar Wicaksono <bwicaksono@nvidia.com>
> ---
> 
> Changes from v4:
>  * Fix warning reported by kernel test robot
> v4: https://lore.kernel.org/linux-arm-kernel/20230620041438.32514-1-bwicaksono@nvidia.com/T/#u

Do you plan to send a v5 addressing Suzuki's comments? This series is
blocking the Ampere work from Ilkka.

Thanks,

Will
