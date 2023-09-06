Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17510796DC6
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Sep 2023 01:54:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240631AbjIFXyt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Sep 2023 19:54:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231382AbjIFXys (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Sep 2023 19:54:48 -0400
X-Greylist: delayed 1482 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 06 Sep 2023 16:54:45 PDT
Received: from vern.gendns.com (vern.gendns.com [98.142.107.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A87C10F7;
        Wed,  6 Sep 2023 16:54:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=lechnology.com; s=default; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=TjTUB0cvCFiEoE/LE/coauJxSKtR6oNTse5HzAq7szs=; b=Us66Fsg9c0WQtH2J+hJRt4tqje
        +zH2lcwAQpZykucVF1FC582LKw8GrBIVCVteuQlyijoovucl/PJJNKt4nSWWshMQVOHFyQ7KhPQDa
        frrvzGI2GstQ0Jrut+A/5c06Wg5PmZyd/tMD07mD9mvo58TCPfY85dG6hn5+lG3Aa5Kgc7kyDHLfG
        8cRopYhWxHErY2lCuL6L1LsUgslWpkHLDvsS146at0zqjMPQ/mgdAY5Itab9DLBdGf4BSr6cArR53
        J/7hPVEgqIGaWX9PVD//7STqNE3yVYQnuXhkuSw2FjcQVvHrRXMYZVf7SvaA3MhXsFKQ+Of+9atJU
        6BL0jjaQ==;
Received: from ip98-183-112-25.ok.ok.cox.net ([98.183.112.25]:39068 helo=[192.168.0.142])
        by vern.gendns.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.96)
        (envelope-from <david@lechnology.com>)
        id 1qe1y2-0005rT-0q;
        Wed, 06 Sep 2023 19:29:59 -0400
Message-ID: <bf1b80c1-0499-ebf8-969c-7d9c40538c65@lechnology.com>
Date:   Wed, 6 Sep 2023 18:29:57 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 0/2] Add st7735s drm driver and Winstar panel
Content-Language: en-US
To:     Stefan x Nilsson <stefan.x.nilsson@axis.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel@axis.com
References: <20230906-st7735s-v1-0-add92677c190@axis.com>
From:   David Lechner <david@lechnology.com>
In-Reply-To: <20230906-st7735s-v1-0-add92677c190@axis.com>
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
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/6/23 11:22 AM, Stefan x Nilsson wrote:
> Add a new driver for the Sitronix st7735s display controller
> together with a 0.96" 80x160 color TFT display by Winstar.
> 
> The driver is very similar to the st7735r driver, but uses a
> different pipe_enable sequence and also allows for an
> optional regulator to be specified using devicetree.
> 

Can this panel be used with the generic "panel-mipi-dbi-spi" driver?

more info: https://github.com/notro/panel-mipi-dbi/wiki

