Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 705DF7E8B84
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Nov 2023 17:11:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231299AbjKKQLZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Nov 2023 11:11:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229797AbjKKQLY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Nov 2023 11:11:24 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67C2D3A8D
        for <linux-kernel@vger.kernel.org>; Sat, 11 Nov 2023 08:11:21 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB4A1C433C8;
        Sat, 11 Nov 2023 16:11:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699719081;
        bh=7hFDkPY40TSUqr/I2+vQYFELs1jchsJhchkqz8iEWmI=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=OfQt+5Vgr0DueZVEZ9T7dwlKICLyvoT7y/mxCq61FoVR6l9sQrRAt6hZePMGA0vlO
         TgXJ0VrqErt6VqIXZ4kyA6R8yOsyBGKK760XGIRSnW7xUpfEn5qIkNLRfhVL1MvFhE
         x9we1cJotdwoCFmOusncfo1QOgtU7sd5uwFLOLDXBxmlHLNHqQp9CRlljkgExruPnF
         dC8jAv3eYGAXe6fd9tJoGrTACccp8wNIpMUwEOKLc7bXCCCwqeusNRtsM2coEqBcoK
         z5nnoj51htn63An89T72EqmSSGdRbW2sfCZI4YDX7deaNDwNLI8lYX33euuzWxHDfU
         RBjsNCg31PZZQ==
Message-ID: <8d92ee52-fa77-4fba-88bf-2cf24f43d985@kernel.org>
Date:   Sat, 11 Nov 2023 18:11:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v3] net: ti: icssg-prueth: Fix error cleanup on
 failing pruss_request_mem_region
Content-Language: en-US
To:     Jan Kiszka <jan.kiszka@siemens.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        MD Danish Anwar <danishanwar@ti.com>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Lopes Ivo, Diogo Miguel (T CED IFD-PT)" <diogo.ivo@siemens.com>,
        Nishanth Menon <nm@ti.com>,
        "Su, Bao Cheng (RC-CN DF FA R&D)" <baocheng.su@siemens.com>,
        Wojciech Drewek <wojciech.drewek@intel.com>
References: <bbc536dd-f64e-4ccf-89df-3afbe02b59ca@siemens.com>
From:   Roger Quadros <rogerq@kernel.org>
In-Reply-To: <bbc536dd-f64e-4ccf-89df-3afbe02b59ca@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/11/2023 18:13, Jan Kiszka wrote:
> From: Jan Kiszka <jan.kiszka@siemens.com>
> 
> We were just continuing in this case, surely not desired.
> 
> Fixes: 128d5874c082 ("net: ti: icssg-prueth: Add ICSSG ethernet driver")
> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
> Reviewed-by: Wojciech Drewek <wojciech.drewek@intel.com>

Reviewed-by: Roger Quadros <rogerq@kernel.org>
