Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC04F77B027
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 05:27:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232316AbjHNDZw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Aug 2023 23:25:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232774AbjHNDZQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Aug 2023 23:25:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5A56110;
        Sun, 13 Aug 2023 20:25:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4ABB162E2E;
        Mon, 14 Aug 2023 03:25:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7E48C433C7;
        Mon, 14 Aug 2023 03:25:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691983514;
        bh=HLH386a9SZPtK73nRr4aIDALjI8TGn0kUdlj2ARlonE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fsnVclABUujHo+IMyj0E7aCm82O7DRvu/UfzchEByDPSiHZBCMiQ6ai57BkIhOklp
         Lj97qZ982tq1g6aLcwDcoLld1qQLDBNnv/6InodfRvDsEx8gzB6bKKywfx4SYzludK
         PiF3n9CYEzZbIn5/57CoJ5I86zVhx5iMuyUKoOT8O4iYp2TcS7iFtSU6S8fbDsLZS/
         HZ0YK1hMChXdBPqd+HtpdBS0uED5YBkVEnw7feZm9Ln2gRhK2aYMQdH7Y3CC0GxkZl
         d9Jqes64HG9pp1QREmvWhIHaNVjMLfcd5TGKgz2np9sf3gEcQuGdkPFadO0Z2AAMy+
         WipfVdCq096jA==
From:   Bjorn Andersson <andersson@kernel.org>
To:     agross@kernel.org, konrad.dybcio@linaro.org, vkoul@kernel.org,
        kishon@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        abel.vesa@linaro.org, Rohit Agarwal <quic_rohiagar@quicinc.com>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org
Subject: Re: (subset) [PATCH RESEND v2 0/9] Add pmics supported in Qualcomm's SDX75 platform
Date:   Sun, 13 Aug 2023 20:27:43 -0700
Message-ID: <169198364312.2443702.8623911561594047426.b4-ty@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <1691415534-31820-1-git-send-email-quic_rohiagar@quicinc.com>
References: <1691415534-31820-1-git-send-email-quic_rohiagar@quicinc.com>
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


On Mon, 07 Aug 2023 19:08:45 +0530, Rohit Agarwal wrote:
> Changes in v2:
>  - Added compatible for pm7550ba for eusb2 repeater and used it in DT.
>  - Addressed some minor comments from Konrad to add fixes tag, labels
>    and update the labels
> 
> This series add support of pmics that are found in SDX75 platform and
> add the corresponding regulators in the IDP platform as well.
> It also parallely updates the pmic found in SDX65 to PM7250b and add pinctrl
> support for the same pmic chip.
> This series is based on the new header inclusion[1] and movement of the
> regulators level from rpmpd to rpmhpd[2].
> This series can be picked after successfully picking [2] and [3] as [1] has
> already been applied.
> 
> [...]

Applied, thanks!

[6/9] ARM: dts: qcom: sdx65-mtp: Update the pmic used in sdx65
      commit: f636d6c356b339b0d29eed025f8bf9efcb6eb274

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
