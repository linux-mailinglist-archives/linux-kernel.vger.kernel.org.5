Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D5C17782A9
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 23:22:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230049AbjHJVWk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 17:22:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229971AbjHJVWi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 17:22:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CBFC2700;
        Thu, 10 Aug 2023 14:22:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 030B8664D6;
        Thu, 10 Aug 2023 21:22:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C82EC433C8;
        Thu, 10 Aug 2023 21:22:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691702557;
        bh=YMQ4T+V+4av5a2QyAfzgiDZ5pvPb5wu7VbVoV8FkOkI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fEiv7sDEAvrpqpkeODsOZdhu6L9KP528yYT+YktRGzmSp40q3ZzkvUTpnftqr4Esx
         BtuMh+NbgGretkJTS0pOHcQHWmmDChiGuuoPuEx8qkd9M6JjzdxrjPBc/OaVWDpH9K
         QFZXdPzcz47bUukG8H/wlmmkRdp5BmUfF1dDRUIi5Z8MTDoNl3Y7QQPimsYAj/k1xO
         CL6D5TKrV4ebai5Pdwl104ztWZG6apxg/kZpznc4nneA8DWISVInpx5HY+QzC2m/nS
         Wm1MrfyeqyWy7ttdxq8SsHaamZ3yXQ2cACXIuJkYcHn/kLb+0WYkaFslqN7KysPXY/
         iiPfRVie0mRcg==
From:   Miguel Ojeda <ojeda@kernel.org>
To:     gregkh@linuxfoundation.org
Cc:     akpm@linux-foundation.org, conor@kernel.org, f.fainelli@gmail.com,
        jonathanh@nvidia.com, linux-kernel@vger.kernel.org,
        linux@roeck-us.net, lkft-triage@lists.linaro.org,
        patches@kernelci.org, patches@lists.linux.dev, pavel@denx.de,
        rwarsow@gmx.de, shuah@kernel.org, srw@sladewatkins.net,
        stable@vger.kernel.org, sudipm.mukherjee@gmail.com,
        torvalds@linux-foundation.org, Miguel Ojeda <ojeda@kernel.org>
Subject: Re: [PATCH 6.4 000/165] 6.4.10-rc1 review
Date:   Thu, 10 Aug 2023 23:21:40 +0200
Message-ID: <20230810212140.9001-1-ojeda@kernel.org>
In-Reply-To: <20230809103642.720851262@linuxfoundation.org>
References: <20230809103642.720851262@linuxfoundation.org>
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

On Wed, Aug 09, 2023 at 12:38:51PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.4.10 release.
> There are 165 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.

For Rust, build tested and booted to see the minimal and printing Rust
samples output in the kernel log:

Tested-by: Miguel Ojeda <ojeda@kernel.org> # Rust

Cheers,
Miguel
