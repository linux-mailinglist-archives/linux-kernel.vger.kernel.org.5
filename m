Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91F3B7FA01B
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 13:57:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233453AbjK0M5A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 07:57:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233449AbjK0M46 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 07:56:58 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1334137;
        Mon, 27 Nov 2023 04:57:04 -0800 (PST)
Received: from [100.107.97.3] (cola.collaboradmins.com [195.201.22.229])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id D6FA166057B6;
        Mon, 27 Nov 2023 12:57:02 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1701089823;
        bh=FySumCrnHCkLNmJr8XJVzT+Zu5nrGGp8D2JVx0dI6Zo=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=czRxqj4tLuvWQ5UN0mnq/93x90RSVWFH35tTAHbAW0OSwJVBHmH1X2MrmkWHwaICV
         bUtG8Jf5AIoa0pmZJV6J5FP9ep6l46xRsB3zFdZFGxdtEwzu2jQS4Yp8iAn4Z5aj6/
         VWMv9pOz+yCjc6nfvFOZKzvXSoCcahu85stn8cr2qUv0Up8YMLdY7e0Zi8gDOgA5CU
         LLEMq8VotLORUfZY8pYGpaAAeeqpVnJMu4dCTAZeJUIMBHHNgsr/hFlzkJAvykPIIq
         kP3IX81JYE/rpiTQOe1PIvKjuz7ki4C4z1cNvMm+R7q5YAUayolMzQVbwHddH5F7B1
         7oMhPCh6e1kOQ==
Message-ID: <12601252-5a90-40cf-b634-493219cebf38@collabora.com>
Date:   Mon, 27 Nov 2023 13:57:00 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] arm64: dts: mediatek: mt6358: Merge ldo_vcn33_*
 regulators
Content-Language: en-US
To:     Chen-Yu Tsai <wenst@chromium.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20230913084457.1638690-1-wenst@chromium.org>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230913084457.1638690-1-wenst@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 13 Sep 2023 16:44:56 +0800, Chen-Yu Tsai wrote:
 > The ldo_vcn33_bt and ldo_vcn33_wifi regulators are actually the same
 > regulator, having the same voltage setting and output pin. There are
 > simply two enable bits that are ORed together to enable the regulator.
 >
 > Having two regulators representing the same output pin is misleading
 > from a design matching standpoint, and also error-prone in driver
 > implementations.
 >
 > [...]

Applied, thanks!

[1/1] arm64: dts: mediatek: mt6358: Merge ldo_vcn33_* regulators
       commit: 2a19d6609722b40d0f44337d56ee75a69a69aeab

Regards,
Angelo
