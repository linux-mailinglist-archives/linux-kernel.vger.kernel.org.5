Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F473753999
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 13:38:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235176AbjGNLiu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 07:38:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233017AbjGNLis (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 07:38:48 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8231E65
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jul 2023 04:38:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3D12A61CFD
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jul 2023 11:38:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C8C9C433C7;
        Fri, 14 Jul 2023 11:38:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689334726;
        bh=9artJVaQtMug2n6qMELklKGNREEdY8yUeo63Mr8mbsU=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=EdaymevCQ0+erDe9qggKjzpnZwcOBTDQdIp7GnJJfWGKvLYWOFvZ0MUBHQJgo/Znc
         svhwY5LgJs4LUjWO0Ey1Sx8Fc+iaZPTBzFhhrWMG1NqCKGrI5bXxhcRrjf/30ab4bq
         6CmdhtPABgWfFC3xPYtxPy8LN301ptw9Pb3in3XxpJD/f2ESby9GlQvWob5dCHp+xB
         n6VG2p12ageWJki9prZWOPcRllaLSrXYjglYakFRxDzpuf7IXIiSpB43zEOeuqq4jE
         i5sbHnXTWRlLmtmQOS71atufV1XaknAkKvz1j3oYPSflhS+NBzI+weiyWoKFioUQJF
         xC+H9mV14D6/g==
Message-ID: <2bd1189a-3cca-220d-0db3-c63c539b03bc@kernel.org>
Date:   Fri, 14 Jul 2023 14:38:42 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v2] phy: ti: gmii-sel: Allow parent to not be syscon node
Content-Language: en-US
To:     Andrew Davis <afd@ti.com>, Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Siddharth Vadapalli <s-vadapalli@ti.com>
Cc:     linux-phy@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20230713200957.134480-1-afd@ti.com>
From:   Roger Quadros <rogerq@kernel.org>
In-Reply-To: <20230713200957.134480-1-afd@ti.com>
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



On 13/07/2023 23:09, Andrew Davis wrote:
> If the parent node is not a syscon type, then fallback and check
> if we can get a regmap from our own node. This no longer forces
> us to make the parent of this node a syscon node when that might
> not be appropriate.
> 
> Signed-off-by: Andrew Davis <afd@ti.com>

Reviewed-by: Roger Quadros <rogerq@ti.com>
