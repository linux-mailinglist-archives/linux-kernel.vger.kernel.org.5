Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AA737AA204
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Sep 2023 23:12:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231977AbjIUVL3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Sep 2023 17:11:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232859AbjIUVFF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Sep 2023 17:05:05 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D13FA86138;
        Thu, 21 Sep 2023 10:37:58 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B7CDC4E75F;
        Thu, 21 Sep 2023 14:26:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695306378;
        bh=Y6tF5Sxcca3uknZoiD/RUnNmXLKJdlsB7DP2Xfz3jH8=;
        h=From:To:In-Reply-To:References:Subject:Date:From;
        b=Oow2mZRnk+semWy/ipKx+k8QwxReBm+OSDMXyq0ak5vClB9HJH5RTVQKBHHNFj0AS
         OJ76rfLM1FPKDS5/qRKPEPl5giDEPW1xtnUQlonfcZZakQPFUqTxwh6tVDi8F37Til
         G7s5rZwh9z7iiwlhIgOVPEo5Zn711BAhrxARs3bGfkxs2g/jRCS0CB6U+5AQMtknlb
         Os4crsN1kXLjpB3s/2ZZjlnUJP8XsCCW44uA+lEJhSB8SI6R9SEtLfCgRKZozptoTM
         Wko0pEZ8kXpoyUk3VJ1Gn3xGa1k5l+YSgiNq0NmieVaXv4EMEN/o1lotfFZ8FIBnjp
         V9rqMxpUe5eYw==
From:   Vinod Koul <vkoul@kernel.org>
To:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        kishon@kernel.org, linux-arm-msm@vger.kernel.org,
        linux-phy@lists.infradead.org, linux-kernel@vger.kernel.org,
        Varadarajan Narayanan <quic_varada@quicinc.com>
In-Reply-To: <1694069452-3794-1-git-send-email-quic_varada@quicinc.com>
References: <1694069452-3794-1-git-send-email-quic_varada@quicinc.com>
Subject: Re: [PATCH] phy: qcom: m31: Remove unwanted qphy->vreg is NULL
 check
Message-Id: <169530637607.106093.6024035938522205244.b4-ty@kernel.org>
Date:   Thu, 21 Sep 2023 16:26:16 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.3
X-Spam-Status: No, score=-0.5 required=5.0 tests=BAYES_00,DATE_IN_PAST_03_06,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 07 Sep 2023 12:20:52 +0530, Varadarajan Narayanan wrote:
> Fix the following Smatch complaint:
> 	drivers/phy/qualcomm/phy-qcom-m31.c:175 m31usb_phy_init()
> 	warn: variable dereferenced before check 'qphy->vreg' (see line 167)
> 
> drivers/phy/qualcomm/phy-qcom-m31.c
>    166
>    167		ret = regulator_enable(qphy->vreg);
>                                        ^^^^^^^^^^
> Unchecked dereference
> 
> [...]

Applied, thanks!

[1/1] phy: qcom: m31: Remove unwanted qphy->vreg is NULL check
      commit: ecec1de5c58f8f3ab6959fcf8d68752eeb65311d

Best regards,
-- 
~Vinod


