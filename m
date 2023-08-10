Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C414377829A
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 23:18:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230285AbjHJVSo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 17:18:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230224AbjHJVSZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 17:18:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD2582D62;
        Thu, 10 Aug 2023 14:18:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5945566916;
        Thu, 10 Aug 2023 21:18:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB9D5C433C7;
        Thu, 10 Aug 2023 21:18:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691702302;
        bh=76wx2cP7SG/eY4qASv7YkVRhekhf3wmYDyCVqOvC8zI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=L/+7in6rOB+54LxPk14x7lvbJQERAAadpUTpZN9CQpvnZwBn77J/pC4jOio5Mg4/i
         w0t5qYOTUf92J4voJaHUqITfpjvkSsMG20ENuZQBtJorv9b0mOIivAFtn20Yw1fB15
         NAX3fe5DcMIsRqJU7aAKcqyLRD6yftWfA7PwG/EC1jEiEuPE3g+JaSasOxhm1GhzFh
         gMBzBrt08Jcw84XMfV8O7rjBCkJBVB5+ZjO4HEptNHT1M3SlQ/O4fGu9aC2wvcV0Cn
         PAHwS+ZT/2lWupRBKqR/D+9OfZ9DIbCNj4BjF31YLadjKxN6vEqapktDUF1Gwo/76R
         T58Snq+Mjy1Bg==
From:   Miguel Ojeda <ojeda@kernel.org>
To:     gregkh@linuxfoundation.org
Cc:     akpm@linux-foundation.org, conor@kernel.org, f.fainelli@gmail.com,
        jonathanh@nvidia.com, linux-kernel@vger.kernel.org,
        linux@roeck-us.net, lkft-triage@lists.linaro.org,
        patches@kernelci.org, patches@lists.linux.dev, pavel@denx.de,
        rwarsow@gmx.de, shuah@kernel.org, srw@sladewatkins.net,
        stable@vger.kernel.org, sudipm.mukherjee@gmail.com,
        torvalds@linux-foundation.org, Miguel Ojeda <ojeda@kernel.org>
Subject: Re: [PATCH 6.1 000/127] 6.1.45-rc1 review
Date:   Thu, 10 Aug 2023 23:17:37 +0200
Message-ID: <20230810211737.8646-1-ojeda@kernel.org>
In-Reply-To: <20230809103636.615294317@linuxfoundation.org>
References: <20230809103636.615294317@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 09, 2023 at 12:39:47PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.1.45 release.
> There are 127 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.

For Rust, build tested and booted to see the trivial Rust sample
output in the kernel log:

Tested-by: Miguel Ojeda <ojeda@kernel.org> # Rust

Cheers,
Miguel
