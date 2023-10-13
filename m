Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC21B7C8378
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 12:44:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231153AbjJMKoI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 06:44:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230334AbjJMKoB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 06:44:01 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DADB1EB
        for <linux-kernel@vger.kernel.org>; Fri, 13 Oct 2023 03:43:55 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A6C0C433CB;
        Fri, 13 Oct 2023 10:43:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697193834;
        bh=bpRiSXkMmQkHgeqQ+ymmdIlUJfXwAP6+/lOV9tV+YtU=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=KnTYlTITt6oJMVwtaPmTWqd5jnQcenZY/hc9k6LgKNufOz+aNua3WkkdaAoqScsux
         gjbSp4Avb4PJe5UNYcS0QF10a80sCpSNBYACS57v9Fm+k5sIJ6h+KJoGk2ZQ0mTzbO
         oE5/U4s9Ydw1Kj3gQlEUliAgIMiM+oiTMUYAlqVNJXsGHlj6oZoyO9/t5LT0w5RWW4
         OuTwuhlnQAY0NI4ItxtSxXYkvM5P/ZS/ECTIhOKkGRXSRUlRdhuD0ZI717fNZgLKS+
         NqOkC7QeiinEbbVTjrAYxFJ1t+bS7xjV4HRd9qR82G3+3Oak5JmadObeE+zG6WU6mO
         8Z0XN74bc6kOA==
From:   Vinod Koul <vkoul@kernel.org>
To:     Kishon Vijay Abraham I <kishon@kernel.org>,
        Rob Herring <robh@kernel.org>
Cc:     linux-phy@lists.infradead.org, linux-kernel@vger.kernel.org
In-Reply-To: <20231009172923.2457844-16-robh@kernel.org>
References: <20231009172923.2457844-16-robh@kernel.org>
Subject: Re: [PATCH] phy: Drop unnecessary of_match_device() calls
Message-Id: <169719383317.165658.7807942867322803604.b4-ty@kernel.org>
Date:   Fri, 13 Oct 2023 16:13:53 +0530
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 09 Oct 2023 12:29:11 -0500, Rob Herring wrote:
> If probe is reached, we've already matched the device and in the case of
> DT matching, the struct device_node pointer will be set. Therefore, there
> is no need to call of_match_device() in probe.
> 
> 

Applied, thanks!

[1/1] phy: Drop unnecessary of_match_device() calls
      commit: dd69a6379a07f21ab1c41360925ef29ebe992a62

Best regards,
-- 
~Vinod


