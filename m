Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 463197728FF
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 17:21:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229796AbjHGPVz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 11:21:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229777AbjHGPVx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 11:21:53 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EF691703
        for <linux-kernel@vger.kernel.org>; Mon,  7 Aug 2023 08:21:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D30F061E01
        for <linux-kernel@vger.kernel.org>; Mon,  7 Aug 2023 15:21:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 455CEC433C8;
        Mon,  7 Aug 2023 15:21:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691421711;
        bh=eKeOwnUilQvBQlfyJP6vAB2J5JPookLqOqnK6bxP1ak=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WnWM64mAcr3BbMWMRRT+DrK7ilmVcRbK8xjvF66wlMS54tv5rEuG7/lQrIieChzR3
         JqJAFTLcEBTcNZ2ulxtBMyr+qX8opnPheb46zFH5YtLoPkSPUQV0auZiNaNEcUKYv7
         v4uM3izi3sbc6xwcDLodd8ecfYkZm1dGAwyHJu0QkpVzlWKStbdH8WSENckquJ8dbg
         8k/6pk7JkLRlU4kG+jcCNrIQW5EewFhtRgjPr/mC+UgU/oM3CfQwOls8693bbd7W2W
         uOAs5kdW+SvcTjVyPyfyJXbEU3GCvlaXCUUWZ5fuFRLyCyCmkxGWEuOYL5al1CMwEX
         iltcix4f6mJ/Q==
Date:   Mon, 7 Aug 2023 17:21:46 +0200
From:   Simon Horman <horms@kernel.org>
To:     Daniel Golle <daniel@makrotopia.org>
Cc:     Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Vladimir Oltean <olteanv@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] net: dsa: mt7530: improve and relax PHY driver
 dependency
Message-ID: <ZNEMCub3K+WSuEQu@vergenet.net>
References: <3ae907b7b60792e36bc5292c2e0bab74f84285e7.1691246642.git.daniel@makrotopia.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3ae907b7b60792e36bc5292c2e0bab74f84285e7.1691246642.git.daniel@makrotopia.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 05, 2023 at 03:45:36PM +0100, Daniel Golle wrote:
> Different MT7530 variants require different PHY drivers.
> Use 'imply' instead of 'select' to relax the dependency on the PHY
> driver, and choose the appropriate driver.
> 
> Signed-off-by: Daniel Golle <daniel@makrotopia.org>

Reviewed-by: Simon Horman <horms@kernel.org>

