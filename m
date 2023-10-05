Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF40B7BA5BA
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 18:20:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242799AbjJEQTQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 12:19:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240476AbjJEQPi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 12:15:38 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF62223D17
        for <linux-kernel@vger.kernel.org>; Thu,  5 Oct 2023 07:38:03 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 211F2C43395;
        Thu,  5 Oct 2023 14:38:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696516683;
        bh=4mqxa2ktT8CFymqIv3kIpTC7CvQWNMevyIZrBFyjsSc=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=rEt0h0H8VCdGv6rTXJ5/ofeuFwlqNnDYR0yEjFXpqD5zZ3XnnblXLq1TQi/3X6cbA
         c8BcCLo1HLARdIstcze2jGoQ9AkR277+lN+IZFkTuJdx/Tx9doHuEhUSmQJXVyyFvV
         l1f7xYD0/Y/M82AOHHPo+120u+lsQwfy1P7Onlyxj6vsJjtLQ7hHU/sU2XxTvDI8Xm
         UBKyGMSV3rWnKkonTbFicRIOm2qttzuY0ETRJZGMBoEvxrf8w+jAHrQxD/fj47AsX6
         bQnXG6fezqHQXgWgNSCRK5oeyU+Mez2deyH6RBIeFEU7EUJn46uu0lHar0OB47a6zJ
         FYD2MIaHya8YA==
From:   Lee Jones <lee@kernel.org>
To:     Lee Jones <lee@kernel.org>, Chanwoo Choi <cw00.choi@samsung.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Mark Brown <broonie@kernel.org>
Cc:     linux-kernel@vger.kernel.org
In-Reply-To: <20231001-mfd-maxim-maple-v1-0-cdfeb48a4d15@kernel.org>
References: <20231001-mfd-maxim-maple-v1-0-cdfeb48a4d15@kernel.org>
Subject: Re: [PATCH 0/3] mfd: maxim: Convert to use maple tree cache
Message-Id: <169651668186.798961.17779128112478172086.b4-ty@kernel.org>
Date:   Thu, 05 Oct 2023 15:38:01 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.12.2
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 01 Oct 2023 00:47:04 +0100, Mark Brown wrote:
> The maple tree register cache is a more modern replacement for the
> rbtree cache, the data structure and surrounding implementation
> decisions are more modern.  Convert the Maxim MFDs to use maple tree.
> 
> 

Applied, thanks!

[1/3] mfd: max77620: Convert to use maple tree register cache
      commit: 966f92187485bf43edd76b7c53781cafa20cf808
[2/3] mfd: max77686: Convert to use maple tree register cache
      commit: ce828b9f04ba338ed3a1fb8d5137a0a66973b479
[3/3] mfd: max8907: Convert to use maple tree register cache
      commit: 58704298aa29615108e2dd33f88b31ae38609096

--
Lee Jones [李琼斯]

