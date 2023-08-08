Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7512D773E99
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 18:33:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232925AbjHHQcy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 12:32:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232831AbjHHQb0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 12:31:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FBAB13968;
        Tue,  8 Aug 2023 08:51:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1B290624AE;
        Tue,  8 Aug 2023 11:03:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15FDFC433C8;
        Tue,  8 Aug 2023 11:03:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691492630;
        bh=A+mqCpN+QuFAcnM1ap+yOp5utSXZlVUNIHG5R4odB6M=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=Lik0sr/+SSNBgc79MfJ0720gb9FA9wUR4ajKbE4hlQU6LR65Rua/0DtXWZPnb1DcG
         O8S9x3mi3rg6f3b/25KTN1yGu+//8gTrvLdJNpL6MBlgN+OL7yD/a5LCCQ7s5wRz+W
         il/KbU0sOxJm3PI2uS15NacnsFKi4D8/aNvPGNKTSu+f1v7cEoyXzlOm9qUZGjOjBo
         2XjDDJUpf9x71LBBoQtAEXWcTLpdyF0gxg1ikRhp+ZMePGOLAGme6a9c6PjX0IYCCl
         sPPm2ZRYpnLlp42kQv2Vr5psLo4DHDAqcZCzE+6CtOX/1phyAG/52byRnUO6ef2GKQ
         HrZXAh5+GT4WA==
Message-ID: <4c0dfd1c-2b61-b954-73ad-ac8d4b82487d@kernel.org>
Date:   Tue, 8 Aug 2023 06:03:47 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v2 4/5] clk: socfpga: agilex: add clock driver for the
 Agilex5
Content-Language: en-US
To:     niravkumar.l.rabara@intel.com
Cc:     adrian.ho.yin.ng@intel.com, andrew@lunn.ch, conor+dt@kernel.org,
        devicetree@vger.kernel.org, krzysztof.kozlowski+dt@linaro.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        mturquette@baylibre.com, netdev@vger.kernel.org,
        p.zabel@pengutronix.de, richardcochran@gmail.com,
        robh+dt@kernel.org, sboyd@kernel.org, wen.ping.teh@intel.com
References: <20230618132235.728641-1-niravkumar.l.rabara@intel.com>
 <20230801010234.792557-1-niravkumar.l.rabara@intel.com>
 <20230801010234.792557-5-niravkumar.l.rabara@intel.com>
From:   Dinh Nguyen <dinguyen@kernel.org>
In-Reply-To: <20230801010234.792557-5-niravkumar.l.rabara@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stephen/Mike,

On 7/31/23 20:02, niravkumar.l.rabara@intel.com wrote:
> From: Niravkumar L Rabara <niravkumar.l.rabara@intel.com>
> 
> Add support for Intel's SoCFPGA Agilex5 platform. The clock manager
> driver for the Agilex5 is very similar to the Agilex platform,we can
> re-use most of the Agilex clock driver.
> 
> Signed-off-by: Teh Wen Ping <wen.ping.teh@intel.com>
> Reviewed-by: Dinh Nguyen <dinguyen@kernel.org>
> Signed-off-by: Niravkumar L Rabara <niravkumar.l.rabara@intel.com>
> ---
>   drivers/clk/socfpga/clk-agilex.c | 433 ++++++++++++++++++++++++++++++-
>   1 file changed, 431 insertions(+), 2 deletions(-)
> 

If you're ok with this patch, can I take this through armsoc?

Dinh
