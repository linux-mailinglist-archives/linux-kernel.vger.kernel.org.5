Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E68FD7E3B16
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 12:26:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233983AbjKGL0Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 06:26:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229720AbjKGL0Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 06:26:24 -0500
Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com [64.147.123.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 170BEDF;
        Tue,  7 Nov 2023 03:26:21 -0800 (PST)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.west.internal (Postfix) with ESMTP id 813643200989;
        Tue,  7 Nov 2023 06:26:19 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Tue, 07 Nov 2023 06:26:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mai.rs; h=cc
        :content-transfer-encoding:content-type:content-type:date:date
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to; s=fm2; t=
        1699356379; x=1699442779; bh=BbC8a1ekJu1ULn7WHDPfqzEIoC0lq6pA5dK
        U5yRw8tk=; b=skEoBdtKwVdbyGGL5qoe52tI98qGaPDiE8J1hI5gGBVKma+hzYt
        Z7zUQ2tq0R79+aYVWLZDKUA9VICHMeV1mjo+VK+HfvGcD56pdKV6slmnE/Y52vFj
        k+Zc3NAlmq/inZNSwH9eEkiiUzLT5Ozq3lftLJADYwdjo0eXG3q4fF2WW5FqRs0+
        im5j5Qt1azrzIRalEcIL7ni7wxnV/ofeUdTUFFZxuFNLDVM2LoC7Z+MwblApqJYC
        GuFRxnsZPLSVEOIVQy6JHq8SGzwEEVYi9b4JU1vXEPcGe2jLbCbqLP9EoICWfZeQ
        V1nggYpi1mNMgOqVD5NTHTncqfLzIx42adw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1699356379; x=
        1699442779; bh=BbC8a1ekJu1ULn7WHDPfqzEIoC0lq6pA5dKU5yRw8tk=; b=I
        Mh/ETbpHG8s3c1gK5nnMA8c3iB+GTwEW/x8TsyFcirbmi09uwnEZ2Z84mR6M4IHX
        wgbamZ4Z5SVM94jFWojUW5w6QAA8vwToAJKMfmgOQ73M2k2vnvEFz6fJgQkppmIX
        zd024L82r+VdT61sSRYa1vq6Jxsc0GqIJGBq9lWlm86bfjoCYOIVO/d2j/7kZVUQ
        1B2k57KqEBVpTNkf+E8WiML3N5kNaY8tENwqug0Z6ozFY1Ei4pMduHswzbIsX6Ic
        oMbJgz53XSjDSrpZuCo/gnz97kuI7nn2eb6wJ58NH/C6quysZwpKc/CXREq0Grf8
        XtnsFcEPPW8AGBk5UpKEg==
X-ME-Sender: <xms:2h5KZYsDT8rN9Iw7aqPNWm9JyEKove0e_NaSR8aO_lX4reolDQyinA>
    <xme:2h5KZVeA7TYqETC_rFG9y3_UyvFrxtVElJUzAIyIz_bSfhrv-p_za4ImUWKnqV_ab
    jPAhPzRWYw_J2W0Yw>
X-ME-Received: <xmr:2h5KZTwnAn5Vx4dbJl74JsRH7Qv5vIoCAQNKgCvvLOe7rUVv9va-dyE9RqRCWqg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrudduiedgvdeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffufggjfhfkgggtgfesthhqmhdttderjeenucfhrhhomhepuehrhigr
    nhhtucforghirhhsuceosghrhigrnhhtsehmrghirdhrsheqnecuggftrfgrthhtvghrnh
    epueduvefhueeftdekuedvjefgfeduuefgfeehhedvhfeitdelleeuveduhfejffevnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsghrhigrnh
    htsehmrghirdhrsh
X-ME-Proxy: <xmx:2h5KZbMIXg6FG-mtl8GrwTJzNBD2iatRTPHtQcPaMvIF9F7oPZ734Q>
    <xmx:2h5KZY9KIhUdMuLqzJgO4fUyu6yl925a-3KlrMRCV5k2gPeSRDzmyA>
    <xmx:2h5KZTXVUA2E4pWOQuZmZ6mz1z8J1FscLrWqrokjet8huwucwqcSrA>
    <xmx:2x5KZTWfyr3u7pPfRgqZXAEpUmsEleEMUzSOcQiSmcjeqozA3_5Kwg>
Feedback-ID: i891b436e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 7 Nov 2023 06:26:18 -0500 (EST)
Date:   Tue, 07 Nov 2023 12:26:15 +0100
From:   Bryant Mairs <bryant@mai.rs>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_3/7=5D_ARM=3A_dts=3A_qcom=3A_Add_sup?= =?US-ASCII?Q?port_for_Samsung_Galaxy_Tab_4_8=2E0_Wi-Fi?=
User-Agent: K-9 Mail for Android
In-Reply-To: <466ffc6c-19c9-44e0-b97b-8fa4358f34ab@linaro.org>
References: <20231105204759.37107-1-bryant@mai.rs> <20231105204759.37107-4-bryant@mai.rs> <466ffc6c-19c9-44e0-b97b-8fa4358f34ab@linaro.org>
Message-ID: <AF3239AF-F0D7-4611-9450-1430B83CE2F8@mai.rs>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Indeed, very sorry about that! Forgot where I left off when doing this and =
missed an (the?) important step=2E

I'll take the feedback I've already gotten, clean this up, make sure thing=
s build ;), and resubmit soon!

- B

On November 7, 2023 8:29:10 AM GMT+01:00, Krzysztof Kozlowski <krzysztof=
=2Ekozlowski@linaro=2Eorg> wrote:
>On 05/11/2023 21:46, Bryant Mairs wrote:
>> Add support for this tablet based on the MSM8226 SoC, codenamed
>> "milletwifi"=2E
>>=20
>> Signed-off-by: Bryant Mairs <bryant@mai=2Ers>
>> ---
>>  arch/arm/boot/dts/qcom/Makefile               |   1 +
>>  =2E=2E=2E/qcom/qcom-apq8026-samsung-milletwifi=2Edts  | 543 ++++++++++=
++++++++
>>  2 files changed, 544 insertions(+)
>>  create mode 100644 arch/arm/boot/dts/qcom/qcom-apq8026-samsung-milletw=
ifi=2Edts
>>=20
>
>LKP reports that patches were most likely not even built :(
>
>Best regards,
>Krzysztof
>
