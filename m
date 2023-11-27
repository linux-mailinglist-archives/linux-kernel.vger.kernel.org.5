Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A35207F9C93
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 10:27:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232754AbjK0J1h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 04:27:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231339AbjK0J1g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 04:27:36 -0500
Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 859B7DE;
        Mon, 27 Nov 2023 01:27:42 -0800 (PST)
Received: from 8bytes.org (p4ffe1e67.dip0.t-ipconnect.de [79.254.30.103])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.8bytes.org (Postfix) with ESMTPSA id 673DD1A6646;
        Mon, 27 Nov 2023 10:27:41 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
        s=default; t=1701077261;
        bh=vQpNvz4tXNOtI3SlzAQTo7xVyAAZoeAnZPoiW7Qf4yI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=wK6npJ2bcjwrxH2HlnrnFuv3U6BXMzV9ySKpHZ/ytEtanu18iYp44zYiEtdrNqnKg
         n6OxL3FoUAxP+sa6K3aj8GpIgusAMtDAPARHcgyCpX6CCy3IrC9aGQnsfaWnzxxw0Z
         aGQcSKI0Tx18jy3ac7oS7YIDUTmkIlcbgn6Lz7d0Zcll7Zrb/KWjFmn6KYovkJu9+I
         6fO9BOzaPPK/CllYtcYn2occgUdM4L3iuVAkZiCON1QpvmrlbC0zN7Sps8zLkwWgkG
         sACRHpl+ORx50VUR4T5Co7YdINguOj7wXtHbtI+/tyNahHL3+YgzLNdeMsiJT0NICT
         gsgPimnep7BUw==
Date:   Mon, 27 Nov 2023 10:27:40 +0100
From:   Joerg Roedel <joro@8bytes.org>
To:     Dario Binacchi <dario.binacchi@amarulasolutions.com>
Cc:     linux-kernel@vger.kernel.org, Baolu Lu <baolu.lu@linux.intel.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Krishna Reddy <vdumpa@nvidia.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Will Deacon <will@kernel.org>, iommu@lists.linux.dev,
        linux-tegra@vger.kernel.org
Subject: Re: [PATCH v2] iommu/tegra-smmu: drop error checking for
 debugfs_create_dir()
Message-ID: <ZWRhDMgPCjP_hlZW@8bytes.org>
References: <20231025152609.2042815-1-dario.binacchi@amarulasolutions.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231025152609.2042815-1-dario.binacchi@amarulasolutions.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 25, 2023 at 05:25:58PM +0200, Dario Binacchi wrote:
> The return value of debugfs_create_dir() should be checked using the
> IS_ERR() function. The patch, however, drops the check statement without
> fixing it because the subsequent functions (i. e. debugfs_create_file())
> can handle the case where `@parent` is an error pointer.

This deserves a comment in the code explaining why no error checking is
needed.

Regards,

	Joerg

