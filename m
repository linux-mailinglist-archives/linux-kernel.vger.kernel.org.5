Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B98CD7DC716
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 08:18:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343625AbjJaHSY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Oct 2023 03:18:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343603AbjJaHSW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 03:18:22 -0400
Received: from box.trvn.ru (box.trvn.ru [194.87.146.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C14F8DB;
        Tue, 31 Oct 2023 00:18:19 -0700 (PDT)
Received: from authenticated-user (box.trvn.ru [194.87.146.52])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by box.trvn.ru (Postfix) with ESMTPSA id 2A8D84140C;
        Tue, 31 Oct 2023 12:18:11 +0500 (+05)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=trvn.ru; s=mail;
        t=1698736692; bh=xnyRWdL+NdKNQmT5h3gBkSuEgvXkNp1V2Sk1J7cHl3Y=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=s5lauFYUlfv9MNE4zi6/ThT/z69ngFC1oupMRy7Yz3R/DPrb2Y5M4pDOqCskY3igK
         8J+gdc4BXEyDkh6nsWvtrn/FC5X+EtIpsJ3dycb3mNL99NEuToOg8D3SD99XqUrBH4
         kOXH/LJUrhls/MtxkyQfs17W/I6k2CClZBkvFnIsDLg1Ttdb7B1iOOAYLFBeT38msG
         kGrA/jB+3K3xeGV+HFxuHxZEMDPGTGh0D2+xve5pd5cvC3Jwp3vrggCZTcPuGNFOyK
         QhJIDZxf86rhpLNFcuK/ZHT3Oi+jvn8vlODMqcVKeHwO74khnBxQq7buHJABnQ+Dac
         qsaA2RHv1XUfQ==
MIME-Version: 1.0
Date:   Tue, 31 Oct 2023 12:18:08 +0500
From:   Nikita Travkin <nikita@trvn.ru>
To:     Doug Anderson <dianders@chromium.org>
Cc:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        cros-qcom-dts-watchers@chromium.org,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] arm64: dts: qcom: acer-aspire1: Enable RTC
In-Reply-To: <CAD=FV=UigovpD_s89j6V7MhCXOVHVVXLRtH3XGEHtcHKbwVgBA@mail.gmail.com>
References: <20231027-aspire1-sound-v1-0-5ff3cf8b5701@trvn.ru>
 <20231027-aspire1-sound-v1-1-5ff3cf8b5701@trvn.ru>
 <d6b63a3c-d171-4b6b-b222-8c619d90f51b@linaro.org>
 <CAD=FV=UigovpD_s89j6V7MhCXOVHVVXLRtH3XGEHtcHKbwVgBA@mail.gmail.com>
Message-ID: <9157b1f2ffc28f00da4d40b1baedb4b9@trvn.ru>
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

Doug Anderson писал(а) 31.10.2023 02:55:
> Hi,
> 
> On Mon, Oct 30, 2023 at 2:47 PM Konrad Dybcio <konrad.dybcio@linaro.org> wrote:
>>
>> On 27.10.2023 16:42, Nikita Travkin wrote:
>> > pm6150 has a read-only RTC that can be used to keep the time with some
>> > extra userspace tools. Enable it.
>> >
>> > Signed-off-by: Nikita Travkin <nikita@trvn.ru>
>> > ---
>> Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
>>
>> kinda unsure why it'd ever be disabled
>>
>> Konrad
> 
> FWIW we don't use the PMIC RTC in Chrome boards. I can't quite
> remember why, but I _think_ that the power lines aren't hooked up to
> the PMIC to keep power on for the board's lowest power states.
> Instead we use the RTC that's on the EC (Embedded Controller).
> 

When it was submitted, I suggested to keep it disabled by default
because of the firmware mess qcom has - the rtc is set to
read-only and if one enables it on cros without allow-set-time;
and validating that qtiseclib doesn't block it too, it would
likely cause issues by taking devices back to 1970s :D

Nikita

> -Doug
