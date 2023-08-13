Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 342A577A6F7
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Aug 2023 16:33:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231294AbjHMOdH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Aug 2023 10:33:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229506AbjHMOdG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Aug 2023 10:33:06 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFC32E65;
        Sun, 13 Aug 2023 07:33:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6E709627FB;
        Sun, 13 Aug 2023 14:33:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48F0EC433C8;
        Sun, 13 Aug 2023 14:33:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691937187;
        bh=cKyXI9XxadOC9UNUdqwX4WVYcI+AA3mBDHUuq2vGUqs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XarEJc82Jskc5TbTqmF8iwjH0TXmULqxCrjEKDvOFeF+o6stDvJ1ucEvD7uI8Ke3E
         zAKFbqDl2uTGWhUuvtE9abfa+wO4bedz+Hkqb0oLA+i+9uMOeF/Y2V4282xDEQFZW3
         BL5WJbo6q/uTeCwYIRqvwK9KfKwcnwzkZz8IfOinOzNtHpX5TtoDG0zue1tMr47xSY
         8Tu1OBcr2EaCE2lmItXyVY4RRDJAFn5b6Ij4eXjaQK4uYbiJ7iDrDgWSOx19bzrhqI
         /yGCSB4Zr7YZrYvcwMnc1ttMBBw9r0VC82BdfKejdKPP+WZ8hoOrPh3kIYVAp8zVpO
         2a7HsQceeaIRw==
Date:   Sun, 13 Aug 2023 20:03:04 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] clk: qcom: gcc-sm8450: Use floor ops for SDCC RCGs
Message-ID: <ZNjpoBd05W9X/igQ@matsya>
References: <20230811-topic-8450_clk-v1-1-88031478d548@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230811-topic-8450_clk-v1-1-88031478d548@linaro.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11-08-23, 19:35, Konrad Dybcio wrote:
> Use the floor ops to prevent warnings like this at suspend exit and boot:
> 
> mmc0: Card appears overclocked; req 800000 Hz, actual 25000000 Hz

Reviewed-by: Vinod Koul <vkoul@kernel.org>

-- 
~Vinod
