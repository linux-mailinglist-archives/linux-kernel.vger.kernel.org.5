Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18F1275434F
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 21:39:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236477AbjGNTjC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 15:39:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236284AbjGNTjB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 15:39:01 -0400
Received: from vern.gendns.com (vern.gendns.com [98.142.107.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 414141BD;
        Fri, 14 Jul 2023 12:38:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=lechnology.com; s=default; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=Fu2v2ZknbSYqYlR712W9GiqrG+kuSMyi/wnVvYy0El0=; b=ACPao1VaSoNAzSB1iaedLJ7Dwu
        KWUcWOQHm3UVzwAaGNi6JsA+r8lBhWbuaZwoyNCBFs4x2XxPa+HPF2tZC+v+cBpjqO2vOMcgf0qcY
        n/5d/EKa1A85pVkwh0t/c2ELD/mJ+gYYuiUCYxyX82vUJnI3QGDJzew8S+xIULAHkMyKPVbnmfjP+
        VXbZafYl0ZvxCX0DZB9iUCGAp/sWIqCSsgVrZk7EoUp19vR2Dc1N+W0wsxIiLUJDJU1xY5Vs4sehQ
        RyntiGzeTzWGQdzHx0L2Fl91bFa4yc6e5bq2WpuYnNC0TOWn4yMaBkzmVNn5GOO4Nkv1IwGEnPcoF
        XY7BW7rQ==;
Received: from ip98-183-112-42.ok.ok.cox.net ([98.183.112.42]:51022 helo=[192.168.0.142])
        by vern.gendns.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.96)
        (envelope-from <david@lechnology.com>)
        id 1qKOci-0004Qk-37;
        Fri, 14 Jul 2023 15:38:55 -0400
Message-ID: <22df2c05-165b-c24a-b32b-bd4d74563230@lechnology.com>
Date:   Fri, 14 Jul 2023 14:38:50 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] power: Explicitly include correct DT includes
Content-Language: en-US
To:     Rob Herring <robh@kernel.org>, Sebastian Reichel <sre@kernel.org>,
        Florian Fainelli <florian.fainelli@broadcom.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Support Opensource <support.opensource@diasemi.com>,
        Iskren Chernev <me@iskren.info>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Matheus Castello <matheus@castello.eng.br>
Cc:     devicetree@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-oxnas@groups.io
References: <20230714174919.4062992-1-robh@kernel.org>
From:   David Lechner <david@lechnology.com>
In-Reply-To: <20230714174919.4062992-1-robh@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - vern.gendns.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - lechnology.com
X-Get-Message-Sender-Via: vern.gendns.com: authenticated_id: davidmain+lechnology.com/only user confirmed/virtual account not confirmed
X-Authenticated-Sender: vern.gendns.com: davidmain@lechnology.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/14/23 12:49 PM, Rob Herring wrote:
> The DT of_device.h and of_platform.h date back to the separate
> of_platform_bus_type before it as merged into the regular platform bus.
> As part of that merge prepping Arm DT support 13 years ago, they
> "temporarily" include each other. They also include platform_device.h
> and of.h. As a result, there's a pretty much random mix of those include
> files used throughout the tree. In order to detangle these headers and
> replace the implicit includes with struct declarations, users need to
> explicitly include the correct includes.
> 
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
Acked-by: David Lechner <david@lechnology.com>


