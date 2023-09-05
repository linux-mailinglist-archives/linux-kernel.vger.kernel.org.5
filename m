Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C14BD792C76
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Sep 2023 19:34:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237942AbjIEReI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 13:34:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232745AbjIERdq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Sep 2023 13:33:46 -0400
Received: from box.trvn.ru (box.trvn.ru [194.87.146.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D47F2982D;
        Tue,  5 Sep 2023 09:59:46 -0700 (PDT)
Received: from authenticated-user (box.trvn.ru [194.87.146.52])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by box.trvn.ru (Postfix) with ESMTPSA id 9EB59413C3;
        Tue,  5 Sep 2023 21:19:50 +0500 (+05)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=trvn.ru; s=mail;
        t=1693930793; bh=IQAfAAAt1LGu73JtyGaJgjPEBbd/yqvUrrv8VjeBH3A=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=dM91jrBMFeLZtvu8mepoSal8xctG6L/VIffQlMI5eol656uU1qgLbbDdZ8VJUTF+2
         Tn4V2ZIL0Jm8mvYINEWZdKE9XPB9sge6CqA1oNNb8HpxXZu38j+IU1N8S2Dn/PpyEl
         tWWjs7QZSDRySpCB3YLDsDo3iaCSX8HpwzHPICcsBH12/R+hlPX4SQJDnlIveBGewJ
         KWfCKv4+MPy8KPmWDOoiretuXyhw1sgh10iZYzVJRBL7Z9NV5ky7texSrVUynJA6g3
         EQzIWwwoPa27LI6iyx44sFtnZbOBx5ts6CHtu4wqHN/CiaTWWba8/rCmq2aHTG6fno
         jEwc0ntDTMLFQ==
MIME-Version: 1.0
Date:   Tue, 05 Sep 2023 21:19:49 +0500
From:   Nikita Travkin <nikita@trvn.ru>
To:     Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
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
Subject: Re: [PATCH v2 3/4] arm64: dts: qcom: sc7180: Add tertiary mi2s
 pinctrl
In-Reply-To: <4b87a766-9e8d-4676-b77e-d54e6d9c36ef@linaro.org>
References: <20230905-sc7180-adsp-rproc-v2-0-8ab7f299600a@trvn.ru>
 <20230905-sc7180-adsp-rproc-v2-3-8ab7f299600a@trvn.ru>
 <4b87a766-9e8d-4676-b77e-d54e6d9c36ef@linaro.org>
Message-ID: <c14229b715f98f3270bc7ee63409a8af@trvn.ru>
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

Konrad Dybcio писал(а) 05.09.2023 20:53:
> On 5.09.2023 12:41, Nikita Travkin wrote:
>> Some devices use tertiary mi2s to connect external audio codec.
>> Add it near the other two i2s pinctrl definitions so the devices don't
>> have to duplicate it.
>>
>> Signed-off-by: Nikita Travkin <nikita@trvn.ru>
>> ---
> This sorting makes no sense, neither alphabetically nor gpio-idx-wise
> 
> I'd suggest chucking it in after pri_mi2s_mclk_active.
> 

I assumed these are alphabetically sorted since other nodes before mostly
are, with the pri_* being an outlier, but I can move it below if you think
it would be better.

Nikita

> Konrad
