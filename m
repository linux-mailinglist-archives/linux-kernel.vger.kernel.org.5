Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3DD076A519
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 01:50:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231996AbjGaXuA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 19:50:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231753AbjGaXtr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 19:49:47 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C04FE10CA;
        Mon, 31 Jul 2023 16:49:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 49C9161356;
        Mon, 31 Jul 2023 23:49:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07DB2C433C7;
        Mon, 31 Jul 2023 23:49:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690847385;
        bh=aQ/Ili2xonkhHxeXN8MQAn0Wz8NhL8UQ7psjlZ6Ab2U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OTSq05iWDGMx+8aMxLj+ZtfSLNSUTkWPcUiJXqANQJaYlw5AFeyUDvwSlLw5xaka5
         S9jT/3wvrEpyk+ks9xD08dL1kRmUwoWVHig6VttHmBWzmOww7OYGsr6U1eYSpalQnI
         4Pm7aq+rGxgNtmY71AB94qzP7MEUs5mFaidJqeZGdd/Gc1WapBsgD41ki30cscJxYH
         0yLvNea5syS1P3qQoadiue+zemtlK1qyQfSePL/TB5/XsBIA5DVKwwGWwWGiUYr7tj
         qsckIIeNKEVXUCOmdcISlTABzLOPKU0FLKk4YFvnQEidt87zLEO9zbcFKOjQE6AWPV
         Zw2qSyC6iYXdw==
From:   Bjorn Andersson <andersson@kernel.org>
To:     agross@kernel.org, konrad.dybcio@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        Zeyan Li <qaz6750@outlook.com>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH V3] arm64: dts: qcom: sm8150: Fix the I2C7 interrupt
Date:   Mon, 31 Jul 2023 16:52:43 -0700
Message-ID: <169084756376.3010488.8597692845373650899.b4-ty@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <SY7P282MB378712225CBCEA95FE71554DB201A@SY7P282MB3787.AUSP282.PROD.OUTLOOK.COM>
References: <SY7P282MB378712225CBCEA95FE71554DB201A@SY7P282MB3787.AUSP282.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 27 Jul 2023 10:53:21 +0800, Zeyan Li wrote:
> I2C6 and I2C7 use the same interrupts, which is incorrect.
> In the downstream kernel, I2C7 has interrupts of 608 instead of 607.
> 
> 

Applied, thanks!

[1/1] arm64: dts: qcom: sm8150: Fix the I2C7 interrupt
      commit: f9568d22ce06192a7e14bda3a29dc216659554ff

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
