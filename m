Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C21C75DAF1
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jul 2023 09:58:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231344AbjGVH6z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Jul 2023 03:58:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229704AbjGVH6y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Jul 2023 03:58:54 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAC9B2706;
        Sat, 22 Jul 2023 00:58:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 666C160C7B;
        Sat, 22 Jul 2023 07:58:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 550C0C433C8;
        Sat, 22 Jul 2023 07:58:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690012729;
        bh=W22OUYzBd0y3n1IM+TwJc0IU0KyzWrQ5/98qv8qJEeI=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=AsAzuM31jVJCTIe3iw9J7JKy8DV69rYJ6/06MVQvy7aw4wGqWD7pQ5U6KqfoCgR5s
         U1o3KHpDS+K5xYg/S5w+racHLW4F5coRScMVccMeIx+r3D0AAt8ODoWROHEv+69FL+
         rY9gtf9yA+/9uo117aDj7/R7T0pg0ml4GidHmK4JCUndipCnN561GTeJTZmlOEKsPl
         T/jnhSKq6sz6/NLAUp974PHJZmqvniX9A4uxEECgYkKM5uYpuiDV/7xncYGxMKDAyJ
         H6cL1ZwZW/RjC9sFJB4w2jbcdzvXxxT0DJiTjA8tyLqRkhiApljzlw8pgQo0QgRK1Y
         NK/9QCN9nRaPQ==
Message-ID: <223668f4-d707-c432-8e89-3ada68cb8f0a@kernel.org>
Date:   Sat, 22 Jul 2023 10:58:45 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v1] usb: cdns3: Add PHY mode switch to usb2 PHY
To:     Minda Chen <minda.chen@starfivetech.com>,
        Pawel Laszczak <pawell@cadence.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Peter Chen <peter.chen@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
References: <20230721095923.20445-1-minda.chen@starfivetech.com>
Content-Language: en-US
From:   Roger Quadros <rogerq@kernel.org>
In-Reply-To: <20230721095923.20445-1-minda.chen@starfivetech.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 21/07/2023 12:59, Minda Chen wrote:
> cdns3 just set PHY mode switch for USB3.0 PHY.
> If USB 2.0 PHY contains PHY mode switch setting,
> USB 2.0 PHY mode function can't be called.
> So add PHY mode switch function for USB 2.0 PHY.
> 
> Signed-off-by: Minda Chen <minda.chen@starfivetech.com>

Reviewed-by: Roger Quadros <rogerq@kernel.org>
