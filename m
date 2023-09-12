Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FB4879D94F
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 21:08:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233383AbjILTIW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 15:08:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230204AbjILTIV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 15:08:21 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7A06E6;
        Tue, 12 Sep 2023 12:08:17 -0700 (PDT)
Received: from mercury (unknown [185.254.75.45])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: sre)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 5DE6A66072FA;
        Tue, 12 Sep 2023 20:08:16 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1694545696;
        bh=pA8KJDFOnD+DhYU8UQ5GUmUPJFV61o5LBqc3PMJvmlg=;
        h=From:To:In-Reply-To:References:Subject:Date:From;
        b=SvIO6AKPM2sN3Dor/LCJQ/uVBi2MEdl6p1zssSt4HkqiOblKRNlYv0I1L17ugY9/0
         KVcwLrAGCWS/WhS0asObuxNlq89+0kLKId17xk4xfsAU/6akMOnSb0dPaUf4JkaQmI
         DgiuyNQvU2r2Y3RqjXTbfuGw2vscaliIetotWvEvugMbeTzC9K0RGotjWRddRCGxY8
         Yms/YxwEnzMMLim+cLB7adhpBPnhUcepUyf0bZDmdaAKj9b/QqpHQlHn85wMtcKDZO
         mihR09+Ckgq/AX/cIQYOpKISmYzhSeEmr5IDldzpFWQlNb/pTAU75OXhHAI0kq8sS0
         XzPqCgSsWNt/Q==
Received: by mercury (Postfix, from userid 1000)
        id 62E04106098C; Tue, 12 Sep 2023 21:08:13 +0200 (CEST)
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230901120057.47018-1-krzysztof.kozlowski@linaro.org>
References: <20230901120057.47018-1-krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH 1/3] dt-bindings: power: syscon-poweroff: get regmap
 from parent node
Message-Id: <169454569339.510054.7177949356094614103.b4-ty@collabora.com>
Date:   Tue, 12 Sep 2023 21:08:13 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.3
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 01 Sep 2023 14:00:55 +0200, Krzysztof Kozlowski wrote:
> Just like syscon-reboot device, the syscon-poweroff is supposed to be a
> child of syscon node, thus we can take the same approach as
> syscon-poweroff: deprecate the 'regmap' field in favor of taking it from
> the parent's node.
> 
> 

Applied, thanks!

[1/3] dt-bindings: power: syscon-poweroff: get regmap from parent node
      commit: 716293381a0f9a400d0010628a9ba4354c2bea40
[2/3] power: reset: syscon-poweroff: simplify pdev->dev usage
      commit: 6f9c8a1338d90d150767331d4fab051fb8abdba5
[3/3] power: reset: syscon-poweroff: get regmap from parent node
      commit: 92bbb93aaaefe14c01eac18df46f8260ee4c2825

Best regards,
-- 
Sebastian Reichel <sebastian.reichel@collabora.com>

