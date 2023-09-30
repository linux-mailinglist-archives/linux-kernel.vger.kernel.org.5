Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F8A67B4382
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Sep 2023 22:28:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231364AbjI3U2V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Sep 2023 16:28:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230113AbjI3U2U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Sep 2023 16:28:20 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A22ADD;
        Sat, 30 Sep 2023 13:28:18 -0700 (PDT)
Received: from mercury (unknown [185.254.75.28])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: sre)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 571DB6607295;
        Sat, 30 Sep 2023 21:28:17 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1696105697;
        bh=92DkQyHS0PNt6RSf48WpmItGWQPcmIWdjNbW7Ztjv+I=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=S4ADqFKP1/gg7NRYb93kcw/V5d/9BAF+E9HjydhXlU5OpaaLUlGGJMQq9eyrGjEQx
         STteKj+SXUrsivSCBE9KwYOdU26cYVCq0OkVxAfQmuzU7AaPS7LX6j3STqZUyl2syx
         glR99uFVPTfVlkZTmwHPd0vmgrAmisjV1qZ4ImZzNB1m07f4KUOrmU3Q1K/9ByO/Ih
         gsgLkQ92N20KagXIXl1ueh3MTncSNhKjjzzaWfFTfy2YtsaSliOC4sNOqVSpMKDR69
         +HZumZZ/o66roqexQDruDz+aDeUTYpgTAR2ekIVyQ/8L8XwhZPEakagJZqAUwFgxj3
         0qvGJEI6fc+CQ==
Received: by mercury (Postfix, from userid 1000)
        id 26D6B10605D7; Sat, 30 Sep 2023 22:28:15 +0200 (CEST)
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Sebastian Reichel <sre@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Rob Herring <robh@kernel.org>
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230926164446.101327-1-robh@kernel.org>
References: <20230926164446.101327-1-robh@kernel.org>
Subject: Re: [PATCH] dt-bindings: power/supply: sbs-manager: Add missing
 unevaluatedProperties on child node schemas
Message-Id: <169610569514.214910.2987951622225757545.b4-ty@collabora.com>
Date:   Sat, 30 Sep 2023 22:28:15 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 26 Sep 2023 11:44:42 -0500, Rob Herring wrote:
> Just as unevaluatedProperties or additionalProperties are required at
> the top level of schemas, they should (and will) also be required for
> child node schemas. That ensures only documented properties are
> present for any node.
> 
> Add unevaluatedProperties as needed, and then add any missing properties
> flagged by the addition.
> 
> [...]

Applied, thanks!

[1/1] dt-bindings: power/supply: sbs-manager: Add missing unevaluatedProperties on child node schemas
      commit: 15a4e422f3c9b041261b6810c90ce09d4ebe2a14

Best regards,
-- 
Sebastian Reichel <sebastian.reichel@collabora.com>

