Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81FE87D2484
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Oct 2023 18:24:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232253AbjJVQYE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Oct 2023 12:24:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232243AbjJVPqU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Oct 2023 11:46:20 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70382126;
        Sun, 22 Oct 2023 08:46:18 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B0A1C43391;
        Sun, 22 Oct 2023 15:46:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697989578;
        bh=HJ9McRNuINbftQ/frhPnfJqJLCcpGxFtBEJ97xDyd2U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=aw8SpN4wn9ISAerKFsfRL0XQluZ3Hzjv4WfzuSdoiK4WMJY/Jw+cRKGYo346Pf8mo
         2bWHTdJ/xlQyOMc5pu3PcMZzJBED5HIiJ6oGtT56UtWmj56e0bVPmhr/IO9Lz8Brwl
         CN3TH+Ab8X7iPlseTJajmVNkYRl4VAV+8bSzJ5BPhPl3gONMaF0iskNDTJKqZtjVfy
         PaCWCxKuWBF0a7GiLZksrM5yosrbJiGNviSKuoM1TbRNlS1YQ+ap1fzwRTgGXbg8TK
         nTflSQ0GKOjM+vPTQbFsOe5LUMlalULahJpLIraBoS6pLEB8zM8fP5wgxgq0J9NzAU
         WC74S0a66zljA==
From:   Bjorn Andersson <andersson@kernel.org>
To:     agross@kernel.org, konrad.dybcio@linaro.org,
        mturquette@baylibre.com, sboyd@kernel.org,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, Robert Marko <robimarko@gmail.com>
Cc:     Kathiravan Thirumoorthy <quic_kathirav@quicinc.com>
Subject: Re: [PATCH v2] clk: qcom: gcc-ipq6018: add QUP6 I2C clock
Date:   Sun, 22 Oct 2023 08:50:24 -0700
Message-ID: <169798982247.271027.17003524820041381973.b4-ty@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231021115545.229060-1-robimarko@gmail.com>
References: <20231021115545.229060-1-robimarko@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Sat, 21 Oct 2023 13:55:18 +0200, Robert Marko wrote:
> QUP6 I2C clock is listed in the dt bindings but it was never included in
> the GCC driver.
> So lets add support for it, it is marked as criticial as it is used by RPM
> to communicate to the external PMIC over I2C so this clock must not be
> disabled.
> 
> 
> [...]

Applied, thanks!

[1/1] clk: qcom: gcc-ipq6018: add QUP6 I2C clock
      commit: 3dcf7b59393812a5fbd83f8cd8d34b94afb4c4d1

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
