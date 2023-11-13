Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37DAE7E9C12
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Nov 2023 13:22:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229810AbjKMMWe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Nov 2023 07:22:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229761AbjKMMWc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Nov 2023 07:22:32 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68428D47;
        Mon, 13 Nov 2023 04:22:29 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A62CDC433CC;
        Mon, 13 Nov 2023 12:22:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699878149;
        bh=iK08OXY6dY0EIsJ75ch5uI0DUUXVJGJlTdQYigZ01hg=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=rnhE9NFYihQUPPjLIKRhMijY8KEdLTiK9wYpdCjO141idobis2aZBenTLipsNxyGE
         9QtX+Nqjj3Wd4MMOSnbB8mjQXgrsMUJJ60RVi7O5djFD/RwHDLahAIDcW75N8nny8b
         KeZA377P/iXLWbCR+DXc6intGUtUZwlJSNJnA035wN9TTcGQCSn1kYXywL93wql/BD
         gKFvMsr4fV06yeEpO6B9ld4zlZh7cmdWpP57kNf1mM9gMl8W08gLsInLn3X29Bw+4G
         2nMidh6Jd0cT+iscjidxdQiMB8oQnwAXkFJml06EsiFAA5s1Nyhk1OcT8o6zLg7c3T
         ZyaCDE3nDynVQ==
From:   Kalle Valo <kvalo@kernel.org>
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Luca Weiss <luca.weiss@fairphone.com>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        cros-qcom-dts-watchers@chromium.org,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Rob Herring <robh@kernel.org>,
        Matti =?utf-8?Q?Lehtim=C3=A4ki?= <matti.lehtimaki@gmail.com>,
        linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        ath11k@lists.infradead.org
Subject: Re: [PATCH 9/9] arm64: dts: qcom: qcm6490-fairphone-fp5: Enable WiFi
References: <20231027-sc7280-remoteprocs-v1-0-05ce95d9315a@fairphone.com>
        <20231027-sc7280-remoteprocs-v1-9-05ce95d9315a@fairphone.com>
        <12ea48bd-5022-4820-815a-89ef23ec9385@linaro.org>
        <CWMK0AQRL87L.1F9MIDVQ4J439@fairphone.com>
        <CAA8EJpqCeW8NVcrpwo6JVn0kE2W-QMELB1YH7i7pgOH6qiPbCQ@mail.gmail.com>
Date:   Mon, 13 Nov 2023 14:22:22 +0200
In-Reply-To: <CAA8EJpqCeW8NVcrpwo6JVn0kE2W-QMELB1YH7i7pgOH6qiPbCQ@mail.gmail.com>
        (Dmitry Baryshkov's message of "Sat, 4 Nov 2023 15:23:38 +0200")
Message-ID: <87zfzhu9kx.fsf@kernel.org>
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

(adding ath11k list)

Dmitry Baryshkov <dmitry.baryshkov@linaro.org> writes:

> [Added Kalle to the CC list]
>
> On Tue, 31 Oct 2023 at 12:31, Luca Weiss <luca.weiss@fairphone.com> wrote:
>>
>> On Mon Oct 30, 2023 at 8:26 PM CET, Konrad Dybcio wrote:
>> > On 27.10.2023 16:20, Luca Weiss wrote:
>> > > Now that the WPSS remoteproc is enabled, enable wifi so we can use it.
>> > >
>> > > Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
>> > > ---
>> > >  arch/arm64/boot/dts/qcom/qcm6490-fairphone-fp5.dts | 4 ++++
>> > >  1 file changed, 4 insertions(+)
>> > >
>> > > diff --git a/arch/arm64/boot/dts/qcom/qcm6490-fairphone-fp5.dts b/arch/arm64/boot/dts/qcom/qcm6490-fairphone-fp5.dts
>> > > index d65eef30091b..e7e20f73cbe6 100644
>> > > --- a/arch/arm64/boot/dts/qcom/qcm6490-fairphone-fp5.dts
>> > > +++ b/arch/arm64/boot/dts/qcom/qcm6490-fairphone-fp5.dts
>> > > @@ -713,3 +713,7 @@ &venus {
>> > >     firmware-name = "qcom/qcm6490/fairphone5/venus.mbn";
>> > >     status = "okay";
>> > >  };
>> > > +
>> > > +&wifi {
>> > > +   status = "okay";
>> > qcom,ath11k-calibration-variant?
>>
>> What value would I put there for my device? Based on existing usages
>> (mostly for ath10k) I'd say "Fairphone_5"?
>
> I think this is fine.

From style point of view I would prefer lower case and dashes, for
example "fairphone-5" but I'm just nitpicking, uppercase and underscores
work fine as well.

If you have different SKUs or similar which need different ath11k board
files being more specific like "fairphone-5-eu" and "fairphone-5-us" is
one option. But I'm sure Luca knows best what is needed for Fairphone,
just throwing out ideas here.

>> And you mean I should add this property in dts before even looking into
>> the firmware/calibration side of it?
>
> From my experience some (most?) of the device manufacturers do the
> wrong thing here. They do not program a sensible board_id, leaving it
> as 0xff or some other semi-random value. The calibration variant is
> the only way for the kernel to distinguish between such poor devices.
>
> The kernel will do a smart thing though. If the device-specific
> calibration data is not present, it will try to fall back to the
> generic data.

You are correct, just to be specific it's ath11k which will choose which
board file to use. I recommend always setting
qcom,ath11k-calibration-variant in DTS if you can.

Back in the day I have tried to push for the firmware team to improve
the board file selection but no success. So the only practical solution
we have is qcom,ath11k-calibration-variant in DTS.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
