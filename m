Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4016E7558EA
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 02:44:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230033AbjGQAos (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Jul 2023 20:44:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229547AbjGQAor (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Jul 2023 20:44:47 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3BCBF1;
        Sun, 16 Jul 2023 17:44:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5881760C61;
        Mon, 17 Jul 2023 00:44:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6BDE4C433C7;
        Mon, 17 Jul 2023 00:44:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689554684;
        bh=GZajVsWW/s80ddVKhYj9EUiUEU7y3xOxGtR9CYJ4i0g=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=K+CDsmm4A7MQqQXpIAlUP093CKWVlk4FiKlF5GgeHUnfSXGHLfCiW1it1PTzQcWET
         3r3qOxAFu0GpmcgrdLaR6Cqv4fbybPEaU3nWq1051BuWSH3IVyIvpZHGcA422yqpJ9
         ujRFRY+mKWNvRIw1PGzg93MvhphPSt1SEBzSQd7u3XIqw/gPKAiJirw60JNHS3z9fc
         cO7G2DjxwreAyE49ZfXAHmsN1fgRJehOaH3X4naBpifT+57vXHL7TwEZWyWjgsRue4
         7MvBVhQrGpBf2dbyv0A1YEuzpdKLEGPI2UtfsOOnajm5oH7WsihgqMR4oEDdBUzpRT
         WFnJKmJQSrB0g==
Message-ID: <d8cb9a46-8f6e-ad47-12d1-2989ab99ca3f@kernel.org>
Date:   Mon, 17 Jul 2023 09:44:43 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v3 01/11] ata: ahci_octeon: Convert to
 devm_platform_ioremap_resource()
Content-Language: en-US
To:     Yangtao Li <frank.li@vivo.com>
Cc:     linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230710024550.59544-1-frank.li@vivo.com>
From:   Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20230710024550.59544-1-frank.li@vivo.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/10/23 11:45, Yangtao Li wrote:
> Use devm_platform_ioremap_resource() to simplify code.
> 
> Signed-off-by: Yangtao Li <frank.li@vivo.com>

Applied the series to for-6.6. Thanks !

(next time, please add a cover letter for a multi-patch series)


-- 
Damien Le Moal
Western Digital Research

