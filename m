Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 123B27F6255
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 16:09:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346000AbjKWPJN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 10:09:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345968AbjKWPJL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 10:09:11 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B3F1A4
        for <linux-kernel@vger.kernel.org>; Thu, 23 Nov 2023 07:09:17 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3070C433C8;
        Thu, 23 Nov 2023 15:09:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700752156;
        bh=+c9SEek8h8usTjzD3WgxNQAR1+4ctQ4AQ4en0fWUy/o=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=WnzPAinAyN8E6iANQ3h7hicUWYWRG2VfCzsudsFkF99aolnpz7Jp6QbJUAGeP3Ue7
         wBGdqRc256ZChoj5oQ6DS/Poj44WhVJ/CJXXUil4vZXm6nVvAzsiFVQdeqR01WRyaN
         PCkr4feiPQbLq7QtRL7OUf15ZLFwrX4o7+c3bY8EWA0d1qDiKDlvw994jFZhbI20gI
         4NkzYGnWEXUUEgUevbKmzaJCwGOAjT20AeLcoXTkR9HBZC7ZMvcewoOVzl9uodifNR
         qHXcqOXRJdG/gdaslG4ppguroMXTN/8GDrbmtDg/dJW5fVmclj/9GMF43WRi2JRewg
         Ii/xuTsFF5SEw==
From:   Lee Jones <lee@kernel.org>
To:     Lee Jones <lee@kernel.org>,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        Neil Armstrong <neil.armstrong@linaro.org>
Cc:     linux-kernel@vger.kernel.org, Adam Green <greena88@gmail.com>
In-Reply-To: <20231116-topic-amlogic-upstream-fix-rk8xx-devid-auto-v2-1-3f1bad68ab9d@linaro.org>
References: <20231116-topic-amlogic-upstream-fix-rk8xx-devid-auto-v2-1-3f1bad68ab9d@linaro.org>
Subject: Re: (subset) [PATCH v2] mfd: rk8xx: fixup devices registration
 with PLATFORM_DEVID_AUTO
Message-Id: <170075215540.1376129.9613156325295712570.b4-ty@kernel.org>
Date:   Thu, 23 Nov 2023 15:09:15 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.12.3
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 16 Nov 2023 15:05:13 +0100, Neil Armstrong wrote:
> Since commit 210f418f8ace ("mfd: rk8xx: Add rk806 support"), devices are
> registered with "0" as id, causing devices to not have an automatic device id
> and prevents having multiple RK8xx PMICs on the same system.
> 
> Properly pass PLATFORM_DEVID_AUTO to devm_mfd_add_devices() and since
> it will ignore the cells .id with this special value, also cleanup
> by removing all now ignored cells .id values.
> 
> [...]

Applied, thanks!

[1/1] mfd: rk8xx: fixup devices registration with PLATFORM_DEVID_AUTO
      commit: a6f86de216cd36e0f57f5797df7361c8900f93e6

--
Lee Jones [李琼斯]

