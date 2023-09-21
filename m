Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9014B7AA481
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 00:11:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233043AbjIUWLO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Sep 2023 18:11:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232983AbjIUWKz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Sep 2023 18:10:55 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76D6084F3E;
        Thu, 21 Sep 2023 10:37:46 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E91A2C4AF7B;
        Thu, 21 Sep 2023 11:50:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695297053;
        bh=mXYzQ1Aw2AmUUG7pVcJYPh5w/95BLX6Xyx+iv32GdjM=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=Bs2WggFziPp0qrw2QPhcDrEk2iWOjqSQHn7c+YlHM/5kRBfSCxdlUXbYPM5UknYKM
         t75jJJqXm4wRyg2gGjrsZtyfooghoz7C/bJOP6/zSOwkA2uLsJAsPXMsYpmN6JLVGw
         8MFNURKRlvcipijmnRr+i+K1ab4Ofk3AybcxouKfYlng1S5z8qvNnw4jQO4R+gw0Er
         YmJqw+V2ZTRUIQ3RGeelZr92fzcpWFmM4+xp5Q8/pu48a0hfIPiN0rvRAeipckKMaK
         CQZPD0H6T10DUVULVf9Ud3NZenXyl4qlByMEHHXZDLHvuf3nJOZJGmylLkdNZ7GGn6
         1jm9QEt6fhN6g==
From:   Lee Jones <lee@kernel.org>
To:     william.gray@linaro.org, lee@kernel.org,
        Fabrice Gasnier <fabrice.gasnier@foss.st.com>
Cc:     alexandre.torgue@foss.st.com, linux-iio@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
In-Reply-To: <20230829134029.2402868-5-fabrice.gasnier@foss.st.com>
References: <20230829134029.2402868-1-fabrice.gasnier@foss.st.com>
 <20230829134029.2402868-5-fabrice.gasnier@foss.st.com>
Subject: Re: (subset) [PATCH 4/8] mfd: stm32-timers: add support for
 interrupts
Message-Id: <169529705167.3631705.15052366988953895917.b4-ty@kernel.org>
Date:   Thu, 21 Sep 2023 12:50:51 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.12.2
X-Spam-Status: No, score=-0.5 required=5.0 tests=BAYES_00,DATE_IN_PAST_03_06,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 29 Aug 2023 15:40:25 +0200, Fabrice Gasnier wrote:
> There are two types of STM32 timers that may have:
> - a global interrupt line
> - 4 dedicated interrupt lines.
> Those interrupts are optional as defined in the dt-bindings. Enforce checks
> on either one, four or no interrupts are provided with their names.
> Optionally get them here, to be used by child devices.
> 
> [...]

Applied, thanks!

[4/8] mfd: stm32-timers: add support for interrupts
      commit: f747b627d395c4eb8a82849dcccf31bf46b21504

--
Lee Jones [李琼斯]

