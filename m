Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CD2080A5F3
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 15:51:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1574074AbjLHOvN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 09:51:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1574035AbjLHOvD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 09:51:03 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F256F173B
        for <linux-kernel@vger.kernel.org>; Fri,  8 Dec 2023 06:51:08 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18C11C4339A;
        Fri,  8 Dec 2023 14:51:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702047068;
        bh=G1lWFIjvvTNVG5ctSS0/Zso7kE6RrimNplmGMqRD9yg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pp/Xskpply7Cl19j2tEv9Ed/qZ/uHCCHxo1Pio1bx9KrSQTJuh/iyteDErP3YjTSs
         rtfDHj+GeckYHIy4qwOxLnBezecY2oFcZye2qvRtsSDWvlQEa7EWE6cSMjAwboIb9J
         KJv/v6qlky+Vb0N7bRcVHBHCf9tZI0xSYMEI0iVzR9oT7ZwySP476MrtSD5QrnENQ+
         aG59+77sXztFmUjYUS0yFsGuhJDjUZmQCVGGYLq4F/xGHToFeBOXtjGO8CVHb5twGk
         JUinO49oQTuixF2EQ0tn8HXYX1PE35qTRH95n0vTkVh7+tljxPiymBzJLZInCC7g7p
         iYs9fR9jvgxIA==
From:   Bjorn Andersson <andersson@kernel.org>
To:     Johan Hovold <johan+linaro@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Subject: Re: [PATCH] soc: qcom: pmic_glink_altmode: fix port sanity check
Date:   Fri,  8 Dec 2023 06:55:18 -0800
Message-ID: <170204733617.342318.9486757967416986550.b4-ty@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231109093100.19971-1-johan+linaro@kernel.org>
References: <20231109093100.19971-1-johan+linaro@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 09 Nov 2023 10:31:00 +0100, Johan Hovold wrote:
> The PMIC GLINK altmode driver currently supports at most two ports.
> 
> Fix the incomplete port sanity check on notifications to avoid
> accessing and corrupting memory beyond the port array if we ever get a
> notification for an unsupported port.
> 
> 
> [...]

Applied, thanks!

[1/1] soc: qcom: pmic_glink_altmode: fix port sanity check
      commit: c4fb7d2eac9ff9bfc35a2e4d40c7169a332416e0

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
