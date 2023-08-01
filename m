Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70B3876B2B0
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 13:08:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231992AbjHALIN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 07:08:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232733AbjHALHa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 07:07:30 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAE0626B7;
        Tue,  1 Aug 2023 04:01:22 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 418A66607122;
        Tue,  1 Aug 2023 12:01:21 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1690887681;
        bh=rzkBpwSwSWWQgjv+3n5YnAp89CT1YW+L2iQWOvn3if4=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=awZ1uOMmd7nMZ0NJx0a7IgEb71rVe/cuLKV4G9e23BNv52K2iyKtlUuPPPmTKNiXw
         GqAptgbcOs0XKedISpbZXchtmFdREiTM/vlFM/yiudjDigsIpk6U56x3VuV0VW1AEz
         4yyaxyLut2ASxVYfyEOgbgggwwDLVfLdsexfiyYM0b6qx51q/ICKMPupDbV2QUIsbh
         Vv0DI5hacBuRcK9qNWDM6oD0BUPAJ8fTQeJGjaKiddAP6iXL5jh8TgOLajaEa1qDoC
         VHd+dpvHfnrB6a9ovWUOVaoqtR5CyulJbGPTdopD1dhX/4JueWd0KGQDgatIli5eD7
         egbVA5My2ydtQ==
Message-ID: <0c6e3bc3-f71a-08f0-6f04-2580ca776466@collabora.com>
Date:   Tue, 1 Aug 2023 13:01:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v3] usb: common: usb-conn-gpio: Prevent bailing out if
 initial role is none
Content-Language: en-US
To:     Prashanth K <quic_prashk@quicinc.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        "# 5 . 4" <stable@vger.kernel.org>
References: <1690880632-12588-1-git-send-email-quic_prashk@quicinc.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <1690880632-12588-1-git-send-email-quic_prashk@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 01/08/23 11:03, Prashanth K ha scritto:
> Currently if we bootup a device without cable connected, then
> usb-conn-gpio won't call set_role() because last_role is same
> as current role. This happens since last_role gets initialised
> to zero during the probe.
> 
> To avoid this, add a new flag initial_detection into struct
> usb_conn_info, which prevents bailing out during initial
> detection.
> 
> Cc: <stable@vger.kernel.org> # 5.4
> Fixes: 4602f3bff266 ("usb: common: add USB GPIO based connection detection driver")
> Signed-off-by: Prashanth K <quic_prashk@quicinc.com>

Just noticed that there was a v3, sent the T-b to the v2 erroneously, so:

MediaTek platforms

Tested-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>


