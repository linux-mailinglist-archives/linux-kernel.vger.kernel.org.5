Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 550357E9E36
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Nov 2023 15:11:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230443AbjKMOLD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Nov 2023 09:11:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229549AbjKMOLA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Nov 2023 09:11:00 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C96BD4C;
        Mon, 13 Nov 2023 06:10:58 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56B90C433C8;
        Mon, 13 Nov 2023 14:10:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699884657;
        bh=2vpy58rQTHTP9krRVNgcAQrv/Q/+avRu6pax/Biruds=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=J3ay90WHC4ALuWZzRA6IAYlybdjApZS9p2RVDXtuXHnkWS7x0DOZEkfn/uXDp1IaA
         WKiPqVM1DJvqdJejm4ZO6tnPrJqw8ph6QyrtjW28Eq1bIzm31leY/dGKFXYYWHqYBg
         y4VAgNZtktIzHV0GYWAuc05wxFSClKCWiwIG1puKsf6fT95+mEDV1F8PJLUgOpzpCb
         B8BJO0bcBD1XK821yKbKpCc1kInm6+ae4p8lWG++1F9rXd4OwuakoWh+YekOWxi9/m
         a2CnN0GSmBUE+1nNZ1B68QZDp9mnQKs+PnOVIYmYyHH8fjQraIzZIjG4zR0lMfkvN0
         GjZqHE6whIX9g==
From:   Kalle Valo <kvalo@kernel.org>
To:     "Luca Weiss" <luca.weiss@fairphone.com>
Cc:     "Dmitry Baryshkov" <dmitry.baryshkov@linaro.org>,
        "Konrad Dybcio" <konrad.dybcio@linaro.org>,
        "Andy Gross" <agross@kernel.org>,
        "Bjorn Andersson" <andersson@kernel.org>,
        "Mathieu Poirier" <mathieu.poirier@linaro.org>,
        "Rob Herring" <robh+dt@kernel.org>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        "Conor Dooley" <conor+dt@kernel.org>,
        "Manivannan Sadhasivam" <mani@kernel.org>,
        <cros-qcom-dts-watchers@chromium.org>,
        <~postmarketos/upstreaming@lists.sr.ht>,
        <phone-devel@vger.kernel.org>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski@linaro.org>,
        "Rob Herring" <robh@kernel.org>,
        Matti =?utf-8?Q?Lehtim=C3=A4ki?= <matti.lehtimaki@gmail.com>,
        <linux-arm-msm@vger.kernel.org>,
        <linux-remoteproc@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <ath11k@lists.infradead.org>
Subject: Re: [PATCH 9/9] arm64: dts: qcom: qcm6490-fairphone-fp5: Enable WiFi
References: <20231027-sc7280-remoteprocs-v1-0-05ce95d9315a@fairphone.com>
        <20231027-sc7280-remoteprocs-v1-9-05ce95d9315a@fairphone.com>
        <12ea48bd-5022-4820-815a-89ef23ec9385@linaro.org>
        <CWMK0AQRL87L.1F9MIDVQ4J439@fairphone.com>
        <CAA8EJpqCeW8NVcrpwo6JVn0kE2W-QMELB1YH7i7pgOH6qiPbCQ@mail.gmail.com>
        <87zfzhu9kx.fsf@kernel.org> <CWXP3TCW3A1G.2ME0JJT3S540G@fairphone.com>
Date:   Mon, 13 Nov 2023 16:10:51 +0200
In-Reply-To: <CWXP3TCW3A1G.2ME0JJT3S540G@fairphone.com> (Luca Weiss's message
        of "Mon, 13 Nov 2023 13:50:21 +0100")
Message-ID: <87r0ktu4k4.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

"Luca Weiss" <luca.weiss@fairphone.com> writes:

>> >> > > --- a/arch/arm64/boot/dts/qcom/qcm6490-fairphone-fp5.dts
>> >> > > +++ b/arch/arm64/boot/dts/qcom/qcm6490-fairphone-fp5.dts
>> >> > > @@ -713,3 +713,7 @@ &venus {
>> >> > >     firmware-name = "qcom/qcm6490/fairphone5/venus.mbn";
>> >> > >     status = "okay";
>> >> > >  };
>> >> > > +
>> >> > > +&wifi {
>> >> > > +   status = "okay";
>> >> > qcom,ath11k-calibration-variant?
>> >>
>> >> What value would I put there for my device? Based on existing usages
>> >> (mostly for ath10k) I'd say "Fairphone_5"?
>> >
>> > I think this is fine.
>>
>> From style point of view I would prefer lower case and dashes, for
>> example "fairphone-5" but I'm just nitpicking, uppercase and underscores
>> work fine as well.
>
> I really don't mind, but I used "Fairphone_5" in v2 now, but I can
> change it for v3 if that happens if you wish.

Nah, no need to resend. That's fine.

But in the future please try to CC the ath11k list for patches like
this, easier to follow what's happening.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
