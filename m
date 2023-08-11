Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 920597796C4
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 20:07:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236983AbjHKSHR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 14:07:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236968AbjHKSHO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 14:07:14 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E576F30DA;
        Fri, 11 Aug 2023 11:06:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CDA5D678B5;
        Fri, 11 Aug 2023 18:06:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 863B8C433C9;
        Fri, 11 Aug 2023 18:06:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691777212;
        bh=RgqWs8uUCZmleYis5opY5915nzwoQ4uuD3Ubl+gzSdA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WeG6ZCZhrrHrRi5HwRf6Y6IoPnuoKFrifypi9lrLc5JfM2/cpkt9feTTW/nwScUI0
         S8bn2bmwRkOTlO3i7WH3CQz36Hb+duN0D+mj438VDd2F2WZfGuLU5wF43ZmWEcvpw+
         PbLsXm/9dtaYuXQ8fpC4fsaLL+SwuMW0lNOGNjwkgrJDw0ZCgUnvT3LdoL3fcgMxdb
         fN5i+CjHdsRcXYTf1pU+ImRAYUixxPMdK2sZp7XEFJJwTgXJpwEqmOYRP4FHxfUGE4
         EiKn/3RieA2vqWCeaY0/x+40zi+seFYKrB0oegBvCy5xCNLzUsNRKeV4Qvrljz6cYL
         aJLxWMEwoDVEQ==
Received: (nullmailer pid 3701663 invoked by uid 1000);
        Fri, 11 Aug 2023 18:06:50 -0000
Date:   Fri, 11 Aug 2023 12:06:50 -0600
From:   Rob Herring <robh@kernel.org>
To:     Nikita Travkin <nikita@trvn.ru>
Cc:     Sebastian Reichel <sre@kernel.org>, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Subject: Re: [PATCH v2 1/4] dt-bindings: power: supply: Add pm8916 VM-BMS
Message-ID: <169177720998.3701432.1284637500689752288.robh@kernel.org>
References: <20230731-pm8916-bms-lbc-v2-0-82a4ebb39c16@trvn.ru>
 <20230731-pm8916-bms-lbc-v2-1-82a4ebb39c16@trvn.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230731-pm8916-bms-lbc-v2-1-82a4ebb39c16@trvn.ru>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 31 Jul 2023 22:06:24 +0500, Nikita Travkin wrote:
> Qualcomm Voltage Mode BMS is a battery monitoring block in PM8916 PMIC.
> Document it's DT binding.
> 
> Signed-off-by: Nikita Travkin <nikita@trvn.ru>
> ---
> v2: Describe all interrupts. (Conor)
> ---
>  .../bindings/power/supply/qcom,pm8916-bms-vm.yaml  | 83 ++++++++++++++++++++++
>  1 file changed, 83 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>

