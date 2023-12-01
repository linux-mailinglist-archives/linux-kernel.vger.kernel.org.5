Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A906B8009F6
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 12:32:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378569AbjLALcM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 06:32:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378568AbjLALcK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 06:32:10 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16B5310E2
        for <linux-kernel@vger.kernel.org>; Fri,  1 Dec 2023 03:32:17 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8D38C433C8;
        Fri,  1 Dec 2023 11:32:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701430336;
        bh=svMrXC4RZTlqhG3aToJFIoPOyOSkobNJw9gmgfv7X+0=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=UhKGW9VHXF4LsBwjp/oieH6GTzNh0nsDEv3NO1kBGOCa4BZL17WjnBmgY4+XdxP30
         Z2S4Gw7R8E+3LhTQN6s7uA0xl8k6KWWfQYMMo8gphaU7/awjmEmIt27LmSZGkOO4+n
         URKX1wku/Q45i9QI0bQBPvbI6LCK6hf952dQffNS879RZP3xHTBFNPr5uihT5fc4+u
         1M2CP0Ztl/4V0ZD5s7QCsjz7DQVYFB3c1pji4mobmrRTO3DX0WcxpkyxNaoKsvK+w6
         bKiLlLHfIi6z66Jj9N0iyJ+RsZJ/+bUpqfL+rPfO5r3EBrJYbRSlz8G4YZpXAQ5peH
         ZtJw/AaeW9mSQ==
From:   Lee Jones <lee@kernel.org>
To:     linux-kernel@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Lee Jones <lee@kernel.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>
In-Reply-To: <20231130143206.1475831-1-andriy.shevchenko@linux.intel.com>
References: <20231130143206.1475831-1-andriy.shevchenko@linux.intel.com>
Subject: Re: (subset) [PATCH v1 1/1] mfd: intel-lpss: Don't fail probe on
 success of pci_alloc_irq_vectors()
Message-Id: <170143033548.3374621.18195206652202265675.b4-ty@kernel.org>
Date:   Fri, 01 Dec 2023 11:32:15 +0000
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

On Thu, 30 Nov 2023 16:32:06 +0200, Andy Shevchenko wrote:
> The pci_alloc_irq_vectors() returns a positive number on success.
> Hence we have to filter the negative numbers for error condition.
> Update the check accordingly.
> 
> 

Applied, thanks!

[1/1] mfd: intel-lpss: Don't fail probe on success of pci_alloc_irq_vectors()
      commit: d1432c3fc6c1d6a3fe9ab20332ac01336ee98371

--
Lee Jones [李琼斯]

