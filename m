Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B9E877B01D
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 05:26:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232882AbjHNDZc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Aug 2023 23:25:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232747AbjHNDZE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Aug 2023 23:25:04 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 255D2110;
        Sun, 13 Aug 2023 20:25:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A9EFE62908;
        Mon, 14 Aug 2023 03:25:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35A0EC433CC;
        Mon, 14 Aug 2023 03:25:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691983503;
        bh=bxGSndrpxJQWnLARX04cY5eZlUuocqI4pmyXXKrXCGk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=iS2Bu3DV9KpxcZRcAqLctoK45RB7JkiHqUenNjvtT5dbZ/3QnfG7sF8TaousVXjHb
         ZKZ8HRt+HGn3GQF5BFzithDymSAJgS9kXd6PWYOtMWmghNULtI2h4qEx070+QvlWdh
         inFvnSEzYTEORc8lmSTTZf/JO6rlxzdokxgIxqO4Dy32RuXD8Ohtw/mCqrh3L9xeub
         0eNhpAnnJyJC08IK47z5VckOvZdNqIdhvwbVYKEiYAf+1Zi4L1oCcwnQ6vXbXUIQUj
         +fOiXKjDvL4cP/qP4VmNSLyB+1OoSYNrVEJfLx7wzRAxVWxyyZuJWkwHngur/AEVKs
         EdP2u0UzYlOxw==
From:   Bjorn Andersson <andersson@kernel.org>
To:     Andy Gross <agross@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Johan Hovold <johan+linaro@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: qcom: sc8280xp-x13s: Unreserve NC pins
Date:   Sun, 13 Aug 2023 20:27:33 -0700
Message-ID: <169198364315.2443702.2452851462517536079.b4-ty@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230803-topic-x13s_pin-v1-1-fae792274e89@linaro.org>
References: <20230803-topic-x13s_pin-v1-1-fae792274e89@linaro.org>
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


On Thu, 03 Aug 2023 15:05:26 +0200, Konrad Dybcio wrote:
> Pins 83-86 and 158-160 are NC, so there's no point in keeping them
> reserved. Take care of that.
> 
> 

Applied, thanks!

[1/1] arm64: dts: qcom: sc8280xp-x13s: Unreserve NC pins
      commit: 7868ed0144b33903e16a50485775f669c109e41a

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
