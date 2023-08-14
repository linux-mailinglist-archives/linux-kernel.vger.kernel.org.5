Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5402477AF57
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 04:02:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231786AbjHNCA2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Aug 2023 22:00:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231806AbjHNCAE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Aug 2023 22:00:04 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0249910C0;
        Sun, 13 Aug 2023 19:00:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 846E9628F7;
        Mon, 14 Aug 2023 02:00:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FC44C4339A;
        Mon, 14 Aug 2023 02:00:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691978402;
        bh=atGkZXgfaLZ4abmSZTUzfQOaLYygHw/XUXopRZ+5rMY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YN1FPEaf0WxUusgoJNdb168ItssD5qTzdB4XNOzTkITE34NZvgwOxu63gbIe5/28f
         NR25co88zp0piyMFKfm2oIDiVKVZ/XEUFc+DZiUyfoPS+fHQUPOCBU2cva9UGIJXd0
         FcHgP7oMwVGVI2hli6NUVbmjsRbK2N1J5lJevHNhkMpwDkS6XVM6yjEolNtolRRqT1
         X/+hJtz78Ozk7l2Dlo+LC4ITF9i8E1QSGvJjlh5Bj0F1rm5FB5l/d7fU0kCI/ExfBT
         4W0fLY4S3KqCmW2fs/SLSm00bKUyOSuC+JOHcGMuMHkfOeiFowMCraHDYA6oG8iT+5
         Zmfxi2BsvZEAw==
From:   Bjorn Andersson <andersson@kernel.org>
To:     agross@kernel.org, konrad.dybcio@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Robert Marko <robert.marko@sartura.hr>
Cc:     luka.perkov@sartura.hr
Subject: Re: [PATCH v2] ARM: dts: qcom: ipq4019: correct SDHCI XO clock
Date:   Sun, 13 Aug 2023 19:02:45 -0700
Message-ID: <169197856181.2338511.2110113165380288451.b4-ty@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230811110150.229966-1-robert.marko@sartura.hr>
References: <20230811110150.229966-1-robert.marko@sartura.hr>
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


On Fri, 11 Aug 2023 13:01:16 +0200, Robert Marko wrote:
> Using GCC_DCD_XO_CLK as the XO clock for SDHCI controller is not correct,
> it seems that I somehow made a mistake of passing it instead of the fixed
> XO clock.
> 
> 

Applied, thanks!

[1/1] ARM: dts: qcom: ipq4019: correct SDHCI XO clock
      commit: b5ed7a5c1fdb3981713f7b637b72aa390c3db036

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
