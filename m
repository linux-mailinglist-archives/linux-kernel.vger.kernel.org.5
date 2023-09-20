Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EECE77A713E
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 05:55:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232519AbjITDzP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 23:55:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232537AbjITDzD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 23:55:03 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E213B9;
        Tue, 19 Sep 2023 20:54:58 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76EA9C433C7;
        Wed, 20 Sep 2023 03:54:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695182098;
        bh=Zp4mN7NTiwPryycNsAtJzWVJqvydvecVdj4/IOxVxTc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=eh5JOuoLxpDRJL59oyIaJ6JiynCvflICUodvvWhJ+YSnsoaZLWCJVq72zP7rmfyyp
         pCu/EIfA8WX7XZMxxDtSPc35lwsQYkZe572V+cjpZsXBXo00LflMdgU/oj7HwKYRJU
         Vxdp3/+v3ZmupZ7/xiuyH0F4+6ja8QNWmZXx6mEpq82lWphAoaQUAVco8R6/qc59am
         sQD1VJ6IAUFKHKmaDlJud0V2bxMQv4xhC0GkjuSFsLDNeIWpSNvO+VtIOnOja4xHBk
         byD4inO5SPn/d4IC8Z+CdbA8kQVUzM73qKCjEHzw9wSnJJxPXZLyRhchz67G0OroDu
         3pq8X1tK/QQyQ==
From:   Bjorn Andersson <andersson@kernel.org>
To:     Andy Gross <agross@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] SDM845 Xperia GPIO names
Date:   Tue, 19 Sep 2023 20:58:49 -0700
Message-ID: <169518233716.1055386.14298183520088830517.b4-ty@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230824-topic-tama_gpio-v1-0-014e9d198dce@linaro.org>
References: <20230824-topic-tama_gpio-v1-0-014e9d198dce@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 24 Aug 2023 11:58:51 +0200, Konrad Dybcio wrote:
> Sony provides the actual GPIO line names for most of the pins.
> Use them!
> 
> (and prepare camera GPIO regulators as a bonus)
> 
> 

Applied, thanks!

[1/3] arm64: dts: qcom: sdm845-tama: Add GPIO line names for TLMM
      commit: ed92c9c8964c713bbdd610cf616cd10a5b4b9045
[2/3] arm64: dts: qcom: sdm845-tama: Add GPIO line names for PMIC GPIOs
      commit: cb1e322cb3f126f19859627a6aeae928caf1f26a
[3/3] arm64: dts: qcom: sdm845-tama: Add camera GPIO regulators
      commit: 714a1cf29d7015f87df28333d8f702e8398aa176

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
