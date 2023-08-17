Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4195377F713
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 15:01:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351167AbjHQNAZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 09:00:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351085AbjHQNAE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 09:00:04 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C37E2D7D
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 05:59:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3A02F670C1
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 12:59:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16B2DC433C9;
        Thu, 17 Aug 2023 12:59:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692277198;
        bh=JK9yO7HlZ/Rm0ILnilcihgvXOiw1VPVtfjFvXJWKYfI=;
        h=Date:From:To:Subject:References:In-Reply-To:From;
        b=aYPbFbEKIA1fHZ8TM5XOKLWwRpcR7eRWgYCjlkLxTgf44Vr4h+tjdM/+cpMSwW3f2
         hGsPMq9bAFrhDAC2JZKQznB7bhCCPtg8CcFGpF2unxEGuJD5yBJb+OPt8x9NrQSNAb
         SfHbq5Eq6ZjXXX61ztD4dp3nL572nFEC3GXRWywmF9z8VquBrue5Zl8rUhmW4CAVPs
         LXgc65pA1ZlCYJ86UcIS4usKm7LkRBBRPX7MXSV0VBmuLM+flshOwtA7tCsPgEk+Ph
         pBNGhq/tTGCJa2CgOxV4Gk16gFFevMAfWzqyuXQUwvnJyiMa8hUkyW3yPwwfNJkQow
         tqEQUHEYx8xTg==
Date:   Thu, 17 Aug 2023 13:59:53 +0100
From:   Lee Jones <lee@kernel.org>
To:     thor.thayer@linux.intel.com, ckeepax@opensource.cirrus.com,
        rf@opensource.cirrus.com, patches@opensource.cirrus.com,
        linux-kernel@vger.kernel.org, Zhu Wang <wangzhu9@huawei.com>
Subject: Re: (subset) [PATCH -next 0/8] mfd: remove redundant of_match_ptr()
Message-ID: <20230817125953.GF986605@google.com>
References: <20230808130023.202700-1-wangzhu9@huawei.com>
 <169227714711.1041251.13985138202504208865.b4-ty@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <169227714711.1041251.13985138202504208865.b4-ty@kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 17 Aug 2023, Lee Jones wrote:

> On Tue, 08 Aug 2023 21:00:15 +0800, Zhu Wang wrote:
> > The driver depends on CONFIG_OF, so it is not necessary to use
> > of_match_ptr() here. We remove of_match_ptr() here.
> > 
> > Zhu Wang (8):
> >   mfd: rsmu_i2c: remove redundant of_match_ptr()
> >   mfd: altera-a10sr: remove redundant of_match_ptr()
> >   mfd: rsmu_spi: remove redundant of_match_ptr()
> >   mfd: act8945a: remove redundant of_match_ptr()
> >   mfd: stpmic1: remove redundant of_match_ptr()
> >   mfd: hi655x-pmic: remove redundant of_match_ptr()
> >   mfd: lochnagar-i2c: remove redundant of_match_ptr()
> >   mfd: rn5t618: remove redundant of_match_ptr()
> > 
> > [...]
> 
> Applied, thanks!
> 
> [1/8] mfd: rsmu_i2c: remove redundant of_match_ptr()
>       commit: f2a34ca84bbb1ca3c4eb68134e5612b94038cf70
> [2/8] mfd: altera-a10sr: remove redundant of_match_ptr()
>       commit: 511a6aec5229b4d3fe3ef45067b51ab8eaa52a2c
> [3/8] mfd: rsmu_spi: remove redundant of_match_ptr()
>       commit: 9ca9f37cea730283be34ed8f418b97be6778e1f3
> [4/8] mfd: act8945a: remove redundant of_match_ptr()
>       commit: 523b0a5912a64c80ac806adb24e736140cb68024
> [5/8] mfd: stpmic1: remove redundant of_match_ptr()
>       commit: 475db34fa3e77b2f78a131c987d04a3a07a7b31d
> [7/8] mfd: lochnagar-i2c: remove redundant of_match_ptr()
>       commit: 6d5c5c855c6f48678070bd4760d302143bcfa724
> [8/8] mfd: rn5t618: remove redundant of_match_ptr()
>       commit: d98edddb79885a4c46cbf5bfcd57cc0e8a72a57b

Notice that 6 did not apply cleanly.

Please rebase and resend.

-- 
Lee Jones [李琼斯]
