Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A857475B9B5
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 23:43:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230051AbjGTVm5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 17:42:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229528AbjGTVmt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 17:42:49 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E9EFE53;
        Thu, 20 Jul 2023 14:42:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AE0AE61C9C;
        Thu, 20 Jul 2023 21:42:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F57DC433C8;
        Thu, 20 Jul 2023 21:42:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689889368;
        bh=++9KJC+95Badpi6e4Z9Qi6JrsvpaaCgM0iDxU+I098I=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=oVmzzdHX1ozGOZytAVhUTJfYl3Buw8THkakySyOsv4RCOGIB5ibhd3iuOD4pJPMFZ
         vapReJq02teqjwMVyVfNlZQ3fPRsz9b0BAMT0zSYQBs4bNVMdG14tQ37AsD2umLWbY
         8gNDeFd6abktON2QerTzT/07eQnGb4TUtfmOxUpPdHPLiUXsD1mOOYIU+ibR9JRQMe
         BhzdDegv2D9xpJRL0NIH2g/SdRRZksFW78Ibr8H+M5IghsnieyhtcSQLtTW6NBgXKT
         pa0VOJlFlqY5o4m4VbOfZY0VlXISo5YQ2nTzExS6A0gFL+bMZ9PCfWQbCWJoFQC6x7
         YYekiguikaBuw==
Date:   Thu, 20 Jul 2023 14:42:46 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Edward Cree <ecree.xilinx@gmail.com>
Cc:     corbet@lwn.net, Andrew Lunn <andrew@lunn.ch>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Leon Romanovsky <leonro@nvidia.com>, workflows@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, linux@leemhuis.info, kvalo@kernel.org,
        benjamin.poirier@gmail.com
Subject: Re: [PATCH docs v3] docs: maintainer: document expectations of
 small time maintainers
Message-ID: <20230720144246.7e3507d1@kernel.org>
In-Reply-To: <50164116-9d12-698d-f552-96b52c718749@gmail.com>
References: <20230719183225.1827100-1-kuba@kernel.org>
        <50164116-9d12-698d-f552-96b52c718749@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 20 Jul 2023 19:23:56 +0100 Edward Cree wrote:
> Does this apply even to "checkpatch cleanup patch spam", where other patches
>  sprayed from the same source (perhaps against other drivers) have already
>  been nacked as worthless churn? 

For networking you can check patchwork, if it's already marked
as rejected or such - there's no need to respond.

> I've generally been assuming I can ignore those, do I need to make
> sure to explicitly respond with typically a repeat of what's already
> been said elsewhere?

Repeating the same thing over and over is sadly a part of being
a maintainer, tho.
