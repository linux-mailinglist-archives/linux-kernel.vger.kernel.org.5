Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6037577F6FC
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 15:00:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351035AbjHQM7o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 08:59:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351029AbjHQM7L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 08:59:11 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBC002D7D
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 05:59:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4F7E6654DF
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 12:59:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5DB0EC433C7;
        Thu, 17 Aug 2023 12:59:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692277148;
        bh=R5xWVhGaqe3fyx1qAmc2v07cy3zdEsK2dL8tPBNYbFA=;
        h=From:To:In-Reply-To:References:Subject:Date:From;
        b=oUQf0bOci4aVgFAfWTK3InT1QMVple3HEHNf2OZsiNGJ0W7fyYeN79FYH+FXefYgz
         ip2Ddeo7eEmzjgb4KsRm86SvxdghWm/warxN1EKlmEprfZ9IRXYvV4rNeBgq2zfLQ7
         H6zFrotzDdRSQ/vUN+Wvkqnrw+5VauEvIu2KzmERlM81iSe07ACXyqLj1YbFYF8fq/
         yZYn8861rRRZAoN2jGsQoqsFU7R67VKdiJlGj4AzY1QjC40db3y839/6h4rwt1qM4E
         xD+zMx9Dc5DIG0DjiAFLkM6dQRC3XeK0ZsWVekJDdh0PHjdB2aiC1Dh+0D6LigVy1v
         wZxNatTcgBx+g==
From:   Lee Jones <lee@kernel.org>
To:     lee@kernel.org, thor.thayer@linux.intel.com,
        ckeepax@opensource.cirrus.com, rf@opensource.cirrus.com,
        patches@opensource.cirrus.com, linux-kernel@vger.kernel.org,
        Zhu Wang <wangzhu9@huawei.com>
In-Reply-To: <20230808130023.202700-1-wangzhu9@huawei.com>
References: <20230808130023.202700-1-wangzhu9@huawei.com>
Subject: Re: (subset) [PATCH -next 0/8] mfd: remove redundant
 of_match_ptr()
Message-Id: <169227714711.1041251.13985138202504208865.b4-ty@kernel.org>
Date:   Thu, 17 Aug 2023 13:59:07 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.12.2
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 08 Aug 2023 21:00:15 +0800, Zhu Wang wrote:
> The driver depends on CONFIG_OF, so it is not necessary to use
> of_match_ptr() here. We remove of_match_ptr() here.
> 
> Zhu Wang (8):
>   mfd: rsmu_i2c: remove redundant of_match_ptr()
>   mfd: altera-a10sr: remove redundant of_match_ptr()
>   mfd: rsmu_spi: remove redundant of_match_ptr()
>   mfd: act8945a: remove redundant of_match_ptr()
>   mfd: stpmic1: remove redundant of_match_ptr()
>   mfd: hi655x-pmic: remove redundant of_match_ptr()
>   mfd: lochnagar-i2c: remove redundant of_match_ptr()
>   mfd: rn5t618: remove redundant of_match_ptr()
> 
> [...]

Applied, thanks!

[1/8] mfd: rsmu_i2c: remove redundant of_match_ptr()
      commit: f2a34ca84bbb1ca3c4eb68134e5612b94038cf70
[2/8] mfd: altera-a10sr: remove redundant of_match_ptr()
      commit: 511a6aec5229b4d3fe3ef45067b51ab8eaa52a2c
[3/8] mfd: rsmu_spi: remove redundant of_match_ptr()
      commit: 9ca9f37cea730283be34ed8f418b97be6778e1f3
[4/8] mfd: act8945a: remove redundant of_match_ptr()
      commit: 523b0a5912a64c80ac806adb24e736140cb68024
[5/8] mfd: stpmic1: remove redundant of_match_ptr()
      commit: 475db34fa3e77b2f78a131c987d04a3a07a7b31d
[7/8] mfd: lochnagar-i2c: remove redundant of_match_ptr()
      commit: 6d5c5c855c6f48678070bd4760d302143bcfa724
[8/8] mfd: rn5t618: remove redundant of_match_ptr()
      commit: d98edddb79885a4c46cbf5bfcd57cc0e8a72a57b

--
Lee Jones [李琼斯]

