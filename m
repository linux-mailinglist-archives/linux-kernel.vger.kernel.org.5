Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 209927C8370
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 12:43:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230374AbjJMKnv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 06:43:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230239AbjJMKns (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 06:43:48 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5D2DC9
        for <linux-kernel@vger.kernel.org>; Fri, 13 Oct 2023 03:43:47 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1DEDEC433C9;
        Fri, 13 Oct 2023 10:43:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697193827;
        bh=tz4bTfvoAxAxO7+aRO4LZJYQw4kQiRKdfh3IvW/T5Uo=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=UbsUQ0mFbbMMy98hJOpN5MbmVjqH6ARC503+8U4SsneOHzZDjygYj2DOriPQ9hDvv
         re7BmjWZpWFZPpoqhKLujN+e4RiE1pPsOlqDF+y114UWxW1BwxwU6rOiHTu8TMqC+O
         pMqd6xlk5346r2a8Jqg99/vsyQltLnJIL/de7nbK8xcg0Q4kikGPQf//lUZkrQ5PpF
         zpPf12M4yfa9wjLzx5XN57X6ZCBsttgW4D3erpyXoWaI4g5jL3aeM8NWzILXT04b/3
         0RDUmb9Ofq0ItYZprZ1H2hImYA0KwM1vCM6aLSgKizg+eOxV+MkCWCX7TZaXHBUmWx
         9WnTq0SsBDw1g==
From:   Vinod Koul <vkoul@kernel.org>
To:     Kishon Vijay Abraham I <kishon@kernel.org>,
        Rob Herring <robh@kernel.org>
Cc:     linux-phy@lists.infradead.org, linux-kernel@vger.kernel.org
In-Reply-To: <20231010205701.1585026-1-robh@kernel.org>
References: <20231010205701.1585026-1-robh@kernel.org>
Subject: Re: [PATCH] phy: realtek: Replace of_device.h with explicit
 includes
Message-Id: <169719382572.165658.7595857660529623801.b4-ty@kernel.org>
Date:   Fri, 13 Oct 2023 16:13:45 +0530
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


On Tue, 10 Oct 2023 15:57:00 -0500, Rob Herring wrote:
> The DT of_device.h and of_platform.h date back to the separate
> of_platform_bus_type before it as merged into the regular platform bus.
> As part of that merge prepping Arm DT support 13 years ago, they
> "temporarily" include each other and pull in various other headers. In
> preparation to fix this, adjust the includes for what is actually needed.
> 
> of_device.h isn't needed, but platform_device.h was implicitly included by
> it.
> 
> [...]

Applied, thanks!

[1/1] phy: realtek: Replace of_device.h with explicit includes
      commit: 7e909370a5cd44b4c16df500fb40762f48aae966

Best regards,
-- 
~Vinod


