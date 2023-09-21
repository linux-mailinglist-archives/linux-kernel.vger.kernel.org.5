Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93CA47A9E2A
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Sep 2023 21:58:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230460AbjIUT6T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Sep 2023 15:58:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230346AbjIUT6G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Sep 2023 15:58:06 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B24840062;
        Thu, 21 Sep 2023 11:55:03 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28139C433C7;
        Thu, 21 Sep 2023 18:55:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695322502;
        bh=+ITl6i5O0qO8N7J52aMXg4Y16ZZB0+VuzRDddRpxbT4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PswoqZnJpmSHZqX1IkJM3D1IkZKlK4EB7M4LvLUel6hWlZ4zpCyl22bKqZxQL0oBi
         D1vQ3PfqPlw08pSK9UbrGstz5fOmDhl+bMQuQ1BU7GvGxiPm9AwYAhPc+DY10lNe0f
         usQR4DHgOcEkJ7R2ZeQzZFvmKyobzQDTvVpUGzSeGon/f05LMPo56J0UYDnWHjSUrW
         11FFHBzavYh3cfX4pzrYTShBV7bqiGE5sVa5UK6d0ZHHwX4ucTwvqeYG7xtq2Xeuv1
         wLuD2CrUkAuBdAJL/g/MnmgzJhS3QujIG1NyFt6ugTJX/dBIE64aimTSZkj7QVs+av
         9zjcGU9HyoV+w==
Received: (nullmailer pid 800436 invoked by uid 1000);
        Thu, 21 Sep 2023 18:55:00 -0000
Date:   Thu, 21 Sep 2023 13:55:00 -0500
From:   Rob Herring <robh@kernel.org>
To:     Bjorn Andersson <quic_bjorande@quicinc.com>
Cc:     linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Ilia Lin <ilia.lin@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>, linux-pm@vger.kernel.org,
        Conor Dooley <conor+dt@kernel.org>
Subject: Re: [PATCH] dt-bindings: opp: opp-v2-kryo-cpu: Allow opp-peak-kBps
Message-ID: <169532249877.800354.7360993815442441183.robh@kernel.org>
References: <20230920-opp-kbps-binding-cleanup-v1-1-65b059bb4afc@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230920-opp-kbps-binding-cleanup-v1-1-65b059bb4afc@quicinc.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 20 Sep 2023 16:03:57 -0700, Bjorn Andersson wrote:
> Many of the users of operating-points-v2-kryo-cpu scales interconnect
> bandwidth based on the selected opp. Extend the binding to allow the
> opp-peak-kBps property, inherited from opp-v2-base.yaml, to be used to
> specify the requested bandwidth.
> 
> Signed-off-by: Bjorn Andersson <quic_bjorande@quicinc.com>
> ---
>  Documentation/devicetree/bindings/opp/opp-v2-kryo-cpu.yaml | 2 ++
>  1 file changed, 2 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>

