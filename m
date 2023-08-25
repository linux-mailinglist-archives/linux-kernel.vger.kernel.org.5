Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 212F7788836
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 15:16:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245000AbjHYNPt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Aug 2023 09:15:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245082AbjHYNPl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Aug 2023 09:15:41 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB8D310FE;
        Fri, 25 Aug 2023 06:15:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5DE5460FF4;
        Fri, 25 Aug 2023 13:15:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3660EC433C8;
        Fri, 25 Aug 2023 13:15:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692969333;
        bh=V3qws4P4qh5eqWpjG1yq8mlLBDX8jzSYct5bPfL2t6w=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=J0kSi1s6U1Uvu43lYR0H3G94LmAZa2PaNgx8bawtA0r7cfW9hFitbyfSLUF/SIv/q
         5+N2yvvPiyBVUz1dWC9/Aks94HqVF1MrJDUJ3aYCV//24f4lB1xtZqikYDxOZ191RL
         m84u/RV4tauHnTpWC0/WeLtvKIuRBtvGck2KRBiynWwFq5c2bzveNj1/NUMoJPtYvh
         kGGLywvMPjQosG6UizQuX0al//JlJRg5r6USt3sNMDwgO0BFrsLTN8/xZuZLUS+ekp
         R7/Q4t9rlRpmgLZxsnRi7tyU5hhSIOfgUqkb6Jk3BI757UFMzkrooUiZbKJMH+/B5F
         0k5u61EXd+6Fw==
Message-ID: <4c7ba4c4-713e-1cae-8aa5-fec46cb83679@kernel.org>
Date:   Fri, 25 Aug 2023 22:15:31 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 0/2] ata: pata_ep93xx: dt convert preparation fixes
To:     nikita.shubin@maquefel.me, Sergey Shtylyov <s.shtylyov@omp.ru>
Cc:     linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230823-ep93xx_pata_fixes-v1-0-d7e7229be148@maquefel.me>
Content-Language: en-US
From:   Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20230823-ep93xx_pata_fixes-v1-0-d7e7229be148@maquefel.me>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/23/23 18:47, Nikita Shubin via B4 Relay wrote:
> Sending some fixes in prior to "ep93xx device tree conversion" series,
> as per Sergey request:
> 
> - simple replacement s/-ENXIO/-ENOMEM/ as it suits better.
> - second is s/ep93xx_chip_revision()/soc_device_match(), so i can drop 
>   ep93xx_chip_revision() entirely in later series.
> 
> Signed-off-by: Nikita Shubin <nikita.shubin@maquefel.me>
> ---
> Nikita Shubin (2):
>       ata: pata_ep93xx: fix error return code in probe
>       ata: pata_ep93xx: use soc_device_match for UDMA modes

Applied to for-6.6. Thanks !

-- 
Damien Le Moal
Western Digital Research

