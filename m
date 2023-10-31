Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CF357DC745
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 08:27:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343676AbjJaH1G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Oct 2023 03:27:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343673AbjJaH0z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 03:26:55 -0400
Received: from box.trvn.ru (box.trvn.ru [194.87.146.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26E37102;
        Tue, 31 Oct 2023 00:26:53 -0700 (PDT)
Received: from authenticated-user (box.trvn.ru [194.87.146.52])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by box.trvn.ru (Postfix) with ESMTPSA id B088940533;
        Tue, 31 Oct 2023 12:26:50 +0500 (+05)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=trvn.ru; s=mail;
        t=1698737211; bh=WJxb7W6rboneHUIuZlHpAeADGZktYloPmkRPQUiY27s=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=rYSirMVWXHH2P3Ra+u+X0pTHw8ZjSJE3OAncpHPKKMCRwXyuosvBfw4dDLs/YfFaL
         dJkvEUryIlvyw1ymKfAGubp7kMs1u3sPzGIzpea5sk9TmH2l1G73V9PjmEE+r8kXIW
         W/jjbWWK9XRWnlhznlHpPlpcLsGGMATLNXvcJvkKD+WwGenpdlJQhmT/RbyWNMaVaO
         c+URFL7hFZv5/X++fsgqAw7IfHpNvwzxB3Dikh2d9KrpTxWZZB/cujew3VZW4gg2uF
         e9tcxa1jJTaK8/mMyZI7jtB0YJEP3Kk4NWK4dfrEIqlNRR5xdFIpn7/C1eHIaBiWay
         AX1bZjWr0s+8w==
MIME-Version: 1.0
Date:   Tue, 31 Oct 2023 12:26:50 +0500
From:   Nikita Travkin <nikita@trvn.ru>
To:     Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     cros-qcom-dts-watchers@chromium.org,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] arm64: dts: qcom: acer-aspire1: Add sound
In-Reply-To: <db624c01-a48c-4a8f-b9ea-548b25aa3091@linaro.org>
References: <20231027-aspire1-sound-v1-0-5ff3cf8b5701@trvn.ru>
 <20231027-aspire1-sound-v1-3-5ff3cf8b5701@trvn.ru>
 <c2ad06fd-805f-44b9-bf4d-806ef20f272a@linaro.org>
 <db624c01-a48c-4a8f-b9ea-548b25aa3091@linaro.org>
Message-ID: <8b13ec027d960a09aee9434055a12e15@trvn.ru>
X-Sender: nikita@trvn.ru
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,DOS_RCVD_IP_TWICE_B,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Konrad Dybcio писал(а) 31.10.2023 02:51:
> On 30.10.2023 22:50, Konrad Dybcio wrote:
>> On 27.10.2023 16:42, Nikita Travkin wrote:
>>> This laptop has two i2s speakers; an i2s audio codec for the headset
>>> jack; two DMIC microphones in the lid and the displayport audio channel.
>>>
>>> This commit adds the audio node that describes all of the above with the
>>> exception of the DMICs that require in-SoC digital codec to be brought
>>> up, which will be done later.
>>>
>>> Note that the displayport channel is connected here for completeness,
>>> but the displayport can't be used yet since the HPD signal is created by
>>> the embedded controller, which will be added later.
>>>
>>> Signed-off-by: Nikita Travkin <nikita@trvn.ru>
>>> ---
>> [...]
>>
>>
>>> +		primary-tx-dai-link {
>>> +			link-name = "Primary MI2S Capture";
>>> +
>>> +			cpu {
>>> +				sound-dai = <&q6afedai PRIMARY_MI2S_TX>;
>>> +			};
>>> +
>>> +			platform {
>>> +				sound-dai = <&q6routing>;
>>> +			};
>>> +
>>> +			codec {
>>> +				sound-dai = <&alc5682 0>;
>> Both RX and TX going to 5862 interface?
> interface1*

Yes, indeed. The codec has a single i2s with rx and tx, and
shared i2s clocks. They are connected to the prim i2s.

Codec playback is headphone jack, and capture is headset
mic. It could have also been the lid dmics, like on trogdor
but 2/3 describes that sad story...

Nikita

>>
>> Konrad
