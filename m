Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBA33793F96
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Sep 2023 16:52:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242158AbjIFOwq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Sep 2023 10:52:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229564AbjIFOwl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Sep 2023 10:52:41 -0400
Received: from box.trvn.ru (box.trvn.ru [194.87.146.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D40C10D0;
        Wed,  6 Sep 2023 07:52:37 -0700 (PDT)
Received: from authenticated-user (box.trvn.ru [194.87.146.52])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by box.trvn.ru (Postfix) with ESMTPSA id D1F54408E8;
        Wed,  6 Sep 2023 19:52:33 +0500 (+05)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=trvn.ru; s=mail;
        t=1694011954; bh=Bs4cf6Y5eP51WAQLneeZZUCkgqz/OE09oKhzHfI9xyE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=HvqWgZi8v5EuPKIMOTpJAaVpLKRvIPqjpc8FMfqHEzdPhlbH0ZHT57212ouWBrQ/d
         5ZT5p3RfG+CCnCWRB4lcdbKujkC5HlalRrPJr1lEyfdDd+hgSPEM/Z2hrNke6MeqUB
         P+LJ+K1BPj418KGYiKZEMy/cXE4a1rEuBzuz9NcO6fh0hMphT72YLILlPPLJ3hFfwY
         1Io3MOLr2gMgaK+r/iUF9B39p2knI8wf+o5PgBAUsPOBWtuxMViO9Qb6n/wqDE3UKY
         9lZViI4s3nOT9Q5MhN0800tcxC5mVWr84IOnHCODJP+/RudP0SVhjc9oWYQZ+ytZ0/
         Hb+3QqzmoyEwg==
MIME-Version: 1.0
Date:   Wed, 06 Sep 2023 19:52:32 +0500
From:   Nikita Travkin <nikita@trvn.ru>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        cros-qcom-dts-watchers@chromium.org,
        David Wronek <davidwronek@gmail.com>,
        linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht
Subject: Re: [PATCH v2 4/4] arm64: dts: qcom: sc7180: Add ADSP
In-Reply-To: <4202b582-c0a0-ce13-7561-f5185fe1930a@linaro.org>
References: <20230905-sc7180-adsp-rproc-v2-0-8ab7f299600a@trvn.ru>
 <20230905-sc7180-adsp-rproc-v2-4-8ab7f299600a@trvn.ru>
 <4202b582-c0a0-ce13-7561-f5185fe1930a@linaro.org>
Message-ID: <2caf25a10f8d97dd3694ec57ca0dad36@trvn.ru>
X-Sender: nikita@trvn.ru
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Krzysztof Kozlowski писал(а) 06.09.2023 18:36:
> On 05/09/2023 12:41, Nikita Travkin wrote:
>> sc7180 has an ADSP remoteproc that exclusively controls the audio
>> hardware on devices that use Qualcomm firmware.
> 
> 
>> +					q6afe: service@4 {
>> +						compatible = "qcom,q6afe";
>> +						reg = <APR_SVC_AFE>;
>> +						qcom,protection-domain = "avs/audio", "msm/adsp/audio_pd";
>> +
>> +						q6afedai: dais {
>> +							compatible = "qcom,q6afe-dais";
>> +							#address-cells = <1>;
>> +							#size-cells = <0>;
>> +							#sound-dai-cells = <1>;
>> +						};
>> +
>> +						q6afecc: cc {
> 
> 
> No improvements.
> 
> You need to add ADSP to your board and then test it. Otherwise you won't
> see errors and we do not want incorrect, even if disabled, nodes in DTSI.
> 

Ah, didn't think the check would (partially) ignore disabled nodes...

Is there any simple way to instruct the checker to ignore disabled
status and test anyway? I'd like to be able to test the "clean"
series as-to-be-sent to have less places for error (and manual action
I guess...)

I will make sure to fix that for v3

Nikita

> Best regards,
> Krzysztof
