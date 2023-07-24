Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74A7B75FB35
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 17:52:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231359AbjGXPv5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 11:51:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229557AbjGXPvy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 11:51:54 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E0A1B0;
        Mon, 24 Jul 2023 08:51:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8D33C6121B;
        Mon, 24 Jul 2023 15:51:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1141C433C7;
        Mon, 24 Jul 2023 15:51:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690213913;
        bh=b5CSWJ2CN7mIvSTFkNHVm5+ARyCjUmz+Ym1Av0lBizM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TXD5MB8XPeAVQ/uXBgeHPBx+SqOjCq6GTFGrB6hIgMgSUrUcZNh6Nz0OWy7hZ4VdQ
         YhgrI9Z+5iMFqBWgw1L7wV8nDCErRGq92kM9BGX2fpg6p1JOUPrDNX4DvTeG6jUs7o
         vd6/jrEII0DKAIKJWzaV5K1kLEmLnhMroDzXKS2qQEIXMdhhgOK7DJtxMcNCbNsW4y
         e8LPpjAwMH+VSlelMlK/BJTWB0NRNZVG0Ora84ArsSitiyCPWAoU7qDspCs4q7KF46
         Fx2Zr11O2Kt95eAeqWwDtMwPF9LkgOoUugm/tob1I3PrT79Sc/D6fs7dp1grmX/ukl
         nHro6ZYCWUZ/g==
Received: (nullmailer pid 3607201 invoked by uid 1000);
        Mon, 24 Jul 2023 15:51:48 -0000
Date:   Mon, 24 Jul 2023 09:51:48 -0600
From:   Rob Herring <robh@kernel.org>
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     conor+dt@kernel.org, quic_richardp@quicinc.com,
        quic_nguyenb@quicinc.com, quic_nitirawa@quicinc.com,
        linux-kernel@vger.kernel.org, quic_ziqichen@quicinc.com,
        linux-pm@vger.kernel.org, nm@ti.com, quic_bhaskarv@quicinc.com,
        martin.petersen@oracle.com, devicetree@vger.kernel.org,
        robh+dt@kernel.org, quic_asutoshd@quicinc.com,
        alim.akhtar@samsung.com, vireshk@kernel.org,
        kyungmin.park@samsung.com, jejb@linux.ibm.com, bvanassche@acm.org,
        konrad.dybcio@linaro.org, krzysztof.kozlowski+dt@linaro.org,
        quic_cang@quicinc.com, linux-arm-msm@vger.kernel.org,
        myungjoo.ham@samsung.com, andersson@kernel.org, sboyd@kernel.org,
        linux-scsi@vger.kernel.org, cw00.choi@samsung.com,
        krzysztof.kozlowski@linaro.org, avri.altman@wdc.com,
        bmasney@redhat.com, quic_narepall@quicinc.com
Subject: Re: [PATCH v2 02/15] dt-bindings: opp: Increase maxItems for opp-hz
 property
Message-ID: <169021390783.3607138.9583713600185509839.robh@kernel.org>
References: <20230720054100.9940-1-manivannan.sadhasivam@linaro.org>
 <20230720054100.9940-3-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230720054100.9940-3-manivannan.sadhasivam@linaro.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 20 Jul 2023 11:10:47 +0530, Manivannan Sadhasivam wrote:
> Current limit of 16 will be exhausted by platforms specifying the frequency
> for 9 clocks using opp-hz, like Qcom SDM845 SoC. For instance, specifying
> the frequency for 9 clocks with 64bit specifier as below would consume
> (9 * 2 = 18) items.
> 
> 	opp-50000000 {
> 		opp-hz = /bits/ 64 <50000000>,
> 			 /bits/ 64 <0>,
> 			 /bits/ 64 <0>,
> 			 /bits/ 64 <37500000>,
> 			 /bits/ 64 <0>,
> 			 /bits/ 64 <0>,
> 			 /bits/ 64 <0>,
> 			 /bits/ 64 <0>,
> 			 /bits/ 64 <75000000>;
> 	};
> 
> So let's increase the limit to 32 which should be enough for most platforms
> (hopefully).
> 
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> ---
>  Documentation/devicetree/bindings/opp/opp-v2-base.yaml | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Acked-by: Rob Herring <robh@kernel.org>

