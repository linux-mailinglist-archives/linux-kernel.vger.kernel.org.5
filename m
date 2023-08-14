Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DB7D77AF9C
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 04:37:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232570AbjHNCgt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Aug 2023 22:36:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232605AbjHNCgr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Aug 2023 22:36:47 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74BAEE5C;
        Sun, 13 Aug 2023 19:36:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1363E629A2;
        Mon, 14 Aug 2023 02:36:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7AAA8C433C8;
        Mon, 14 Aug 2023 02:36:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691980605;
        bh=hi915NBfBCKS64KEf5vxcDeHuhJzn5+iEohPYSmXYts=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LBaiDI9PfZtUGj1yFDII4GFd94r7KgetraiTnaXNGfWNwrI4igtM32kbUpklOlRCD
         QzHh6rbuwqQshdwW859vd7xdJ2+OnC9afwDzExlwuSg/P4DjWICIu6iqN8Cp3xl7oo
         ydCyPrkSwyw/eV1dpIog8q34emKXw9elHQviqqRDl2ynGrmW/+MB2qLBF+OWQcQELJ
         XAERa8Knab6qymKWNn8iaTewfQI9ypNDWtyEblcpeu9b9OvI0mnAjGZL0BybAESx9J
         l0EkhJuQ2i31WFp/NFLHBtPsbbsK+mih6Fd61/iZQIIk0JOGT32N+oeRcWRSK6HE4w
         Ze0G6yfAWPhNg==
Date:   Sun, 13 Aug 2023 19:39:32 -0700
From:   Bjorn Andersson <andersson@kernel.org>
To:     Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Vinod Koul <vkoul@kernel.org>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, linux-crypto@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] crypto: qcom-rng: Make the core clock optional
 regardless of ACPI presence
Message-ID: <ugwcpepkje53oujb626n6he5cfkhkwbm4tm6skc3ur7xdzcmhg@wh24p5rld2pq>
References: <20230811-topic-8450_prng-v1-0-01becceeb1ee@linaro.org>
 <20230811-topic-8450_prng-v1-2-01becceeb1ee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230811-topic-8450_prng-v1-2-01becceeb1ee@linaro.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 11, 2023 at 10:50:57PM +0200, Konrad Dybcio wrote:
> Some newer SoCs (like SM8450) do not require a clock vote for the PRNG
> to function. Make it entirely optional and rely on the bindings checker
> to ensure platforms that need it, consume one.
> 
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Reviewed-by: Bjorn Andersson <andersson@kernel.org>

Regards,
Bjorn
