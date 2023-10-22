Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DEAD27D246D
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Oct 2023 18:22:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232790AbjJVQV6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Oct 2023 12:21:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232460AbjJVQVe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Oct 2023 12:21:34 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 737BD10EF;
        Sun, 22 Oct 2023 09:21:30 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3C44C433C7;
        Sun, 22 Oct 2023 16:21:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697991689;
        bh=03/JJEW9Bq9E/2CmcNiDP3vC7x+uehh2myCxOWCs22c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lQYwcXMV3z1ELjkInL0rujtVN/gi3flF6G00OtOd0COz9WwoWSSQ4uo94KBlXJLb+
         +9hvOEW2xRChq3NyySyYmz9GOssP1dM9MP+MianPFLEpebdW/5/5TYDmkKkd7cmhiF
         L6EHh61wJ+7BlxBdXy8vpqfWDk8jGiLKwcAfcF3MxOAK2knca2iiDZW+CwZy1s+afX
         YGdabXPzkXksPxVq8OmZ73NozseWciJ2CV3MzvsDOx+IwFQOWo2Wp4D2zyJxGvE+qc
         PTGzZrB14fqgPA3JUXsksiElz0NmJhmMgOCCdLRwGvqJCy4WZPGmWIKu2//Pu4T6E5
         Oltr1nr2MU7UQ==
From:   Bjorn Andersson <andersson@kernel.org>
To:     Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Elliot Berman <quic_eberman@quicinc.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Guru Das Srinagesh <quic_gurus@quicinc.com>,
        Andrew Halaney <ahalaney@redhat.com>,
        Maximilian Luz <luzmaximilian@gmail.com>,
        Alex Elder <elder@linaro.org>,
        Srini Kandagatla <srinivas.kandagatla@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, kernel@quicinc.com,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: Re: (subset) [PATCH v5 00/15] arm64: qcom: add and enable SHM Bridge support
Date:   Sun, 22 Oct 2023 09:25:50 -0700
Message-ID: <169799194924.679418.4730981095291244080.b4-ty@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231017092732.19983-1-brgl@bgdev.pl>
References: <20231017092732.19983-1-brgl@bgdev.pl>
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


On Tue, 17 Oct 2023 11:27:17 +0200, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> 
> This is pretty much another full rewrite of the SHM Bridge support
> series. After more on- and off-list discussions I think this time it
> will be close to the final thing though.
> 
> We've established the need for using separate pools for SCM and QSEECOM
> as well as the upcoming scminvoke driver.
> 
> [...]

Applied, thanks!

[01/15] firmware: qcom: move Qualcomm code into its own directory
        commit: bdac188ec3c71800dd8419620224ee74ef37732a
[02/15] firmware: qcom: scm: add a missing forward declaration for struct device
        commit: 3294d01f7a5ddacb796d7f7bf31eb100a8f6d0e0
[03/15] firmware: qcom: scm: remove unneeded 'extern' specifiers
        commit: d79a27ea8e35a2dfc02096d2937267912bcca022

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
