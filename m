Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71B827FF2C5
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 15:45:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346024AbjK3Op1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 09:45:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232192AbjK3OpZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 09:45:25 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBEA0B5
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 06:45:31 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CAFA9C433C8;
        Thu, 30 Nov 2023 14:45:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701355531;
        bh=7Xzs2a+J+/bu679bmpAL81rPo5EzQaET5V+tsApRoo0=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=LNrY1Hk6twb5igGRO/VofFIxZiJJhvsozXcCel13zDauov+lrWLohNl8D0lUCFKiW
         xzg61mN6HPr5T6K1L1sxD7pl4/3KEt2oRMAnCPdnmCPPDwUSuo6CQ2n1+26mL4Lewg
         Rn6G5aKm3e0HISA6gmUon4vDsh7erOLBg1nVahBzRB9v8pYl2qKtgY3YZ5apDYjd2e
         aMXuijw6zAP4uywKhbUiOo4z79t98DkWEY4t1VT+AVBDPTdBhMZBxUoDUSDSVYp7vL
         Qe0flyJh4Op481OlMjPWFoUerMedk7LWZuaKFQZyOplBE6dUv+o1OgN+iXKk90QDNj
         NvQ4s5TdbJ4IA==
From:   Lee Jones <lee@kernel.org>
To:     linux-kernel@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Lee Jones <lee@kernel.org>
In-Reply-To: <20231124200258.3682979-1-andriy.shevchenko@linux.intel.com>
References: <20231124200258.3682979-1-andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v1 0/5] mfd: intel-lpss: Set of cleanups
Message-Id: <170135553056.3273237.16761708726035735990.b4-ty@kernel.org>
Date:   Thu, 30 Nov 2023 14:45:30 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.12.3
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 24 Nov 2023 21:31:23 +0200, Andy Shevchenko wrote:
> After looking into the latest changes in the driver I noticed one
> wrong patch. That induced looking closer to the current state of
> affairs in the driver. It appears that some code is outdated and
> may be cleaned up. Hence this series.
> 
> Andy Shevchenko (5):
>   mfd: intel-lpss: Revert "Add missing check for platform_get_resource"
>   mfd: intel-lpss: Use device_get_match_data()
>   mfd: intel-lpss: Adjust header inclusions
>   mfd: intel-lpss: Move exported symbols to INTEL_LPSS namespace
>   mfd: intel-lpss: Provide Intel LPSS PM ops structure
> 
> [...]

Applied, thanks!

[1/5] mfd: intel-lpss: Revert "Add missing check for platform_get_resource"
      commit: ad85d36c6770f21d961f5e5e47dc25f56d50c96e
[2/5] mfd: intel-lpss: Use device_get_match_data()
      commit: 403c475743959f787156fc2120c1e5c557f8357d
[3/5] mfd: intel-lpss: Adjust header inclusions
      commit: 62b2a4b3fb4922cb5201ff3787efd84186b0699c
[4/5] mfd: intel-lpss: Move exported symbols to INTEL_LPSS namespace
      commit: 2221afc08e16bf0cbc5234107cc5c9edb850e0bb
[5/5] mfd: intel-lpss: Provide Intel LPSS PM ops structure
      commit: 41e15f246791772c312caa8662368191d5b7289a

--
Lee Jones [李琼斯]

