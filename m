Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCBFF787667
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 19:12:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237169AbjHXRLa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 13:11:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230385AbjHXRK6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 13:10:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC797199D;
        Thu, 24 Aug 2023 10:10:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 70EDC632D2;
        Thu, 24 Aug 2023 17:10:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F54CC433C7;
        Thu, 24 Aug 2023 17:10:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692897055;
        bh=3MUBjtSfXVqcpiARHA23t0wkZwet4S8Qo1HUSXv+dLw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=J1ANo/ABTwMz16yeMQJCeo+LiDN4EkwDchvmdXQnwIlgBWS4QG1igD1xKD3jduqzQ
         hHZ6XV1D1ECNCW4nFsX5XXww1ZLlRlcNUA8XjxQ+3AW7DwNXNFzMWHwNqbp0aPEwUX
         J0eZe3G7EXZpv5LAbVDk6makQuKsEBAZnxStwtwknsOFpCPTrrd0m7OH01L7b+qGr2
         bdoyTz+a12JKOr+vnaSluTXQhYg7dmwRZrOaxqLbHjHhGdw8uEY3hniLqMzSN413Dt
         sapgArOv+LCgRFhfHKSokZb4svCzEIHy1dMpASY62OvKxheGFG1qOHZ11miUKiw58k
         KY+C1QJInLFrQ==
Received: (nullmailer pid 1048461 invoked by uid 1000);
        Thu, 24 Aug 2023 17:10:52 -0000
Date:   Thu, 24 Aug 2023 12:10:52 -0500
From:   Rob Herring <robh@kernel.org>
To:     Luca Weiss <luca.weiss@fairphone.com>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Avri Altman <avri.altman@wdc.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Iskren Chernev <me@iskren.info>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-arm-msm@vger.kernel.org, linux-scsi@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        linux-crypto@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Bhupesh Sharma <bhupesh.sharma@linaro.org>,
        Eric Biggers <ebiggers@google.com>
Subject: Re: [PATCH v6 0/4] Fix some issues in QCOM UFS bindings
Message-ID: <20230824171052.GA1037612-robh@kernel.org>
References: <20230814-dt-binding-ufs-v6-0-fd94845adeda@fairphone.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230814-dt-binding-ufs-v6-0-fd94845adeda@fairphone.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 14, 2023 at 12:14:12PM +0200, Luca Weiss wrote:
> This series aims to solve the dtbs_check errors from the qcom ufs
> bindings. It has changed in scope a bit since v1, so it may be a bit all
> over the place.
> 
> Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
> ---
> Changes in v6:
> - Rebase on linux-next
> - Drop applied dts patch
> - Pick up tags
> - Link to v5: https://lore.kernel.org/r/20221209-dt-binding-ufs-v5-0-c9a58c0a53f5@fairphone.com
> 
> Changes in v5:
> - Convert sm8450.dtsi to use qcom,ice property, so stop modifying schema
>   for sm8450 and only add qcom,ice property.
> - Move reg-names names to top-level with only minItems/maxItems in the
>   'if'
> - Link to v4: https://lore.kernel.org/r/20221209-dt-binding-ufs-v4-0-14ced60f3d1b@fairphone.com
> 
> Changes in v4:
> - Pick up tags
> - Rebase on linux-next (again)
> - Link to v3: https://lore.kernel.org/r/20221209-dt-binding-ufs-v3-0-499dff23a03c@fairphone.com
> 
> Changes in v3:
> - Drop applied patch
> - Pick up sm6115 patch from v5 https://lore.kernel.org/all/20221030094258.486428-2-iskren.chernev@gmail.com/
> - Rebase on linux-next
> - Link to v2: https://lore.kernel.org/r/20221209-dt-binding-ufs-v2-0-dc7a04699579@fairphone.com
> 
> Changes in v2:
> - Add new patch adding reg-names to sm6115 & rebase series on top of sm6115
>   addition
> - Fix binding example after sm8450 move, split this patch from original patch
>   since it became too big
> - Move reg-names definition to top-level
> - Link to v1: https://lore.kernel.org/r/20221209-dt-binding-ufs-v1-0-8d502f0e18d5@fairphone.com
> 
> ---
> Iskren Chernev (1):
>       dt-bindings: ufs: qcom: Add sm6115 binding
> 
> Luca Weiss (3):
>       dt-bindings: ufs: qcom: Add reg-names property for ICE
>       dt-bindings: ufs: qcom: Add ICE to sm8450 example
>       dt-bindings: crypto: ice: Document sm8450 inline crypto engine
> 
>  .../bindings/crypto/qcom,inline-crypto-engine.yaml |  1 +
>  .../devicetree/bindings/ufs/qcom,ufs.yaml          | 44 ++++++++++++++++++++++
>  2 files changed, 45 insertions(+)

I guess the subsystem maintainers aren't going to pick this up, so I've 
applied it.

Rob
