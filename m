Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 938D87E1BAE
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 09:08:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230520AbjKFIIL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 03:08:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229803AbjKFIIK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 03:08:10 -0500
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 980B09B;
        Mon,  6 Nov 2023 00:08:07 -0800 (PST)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id 0299A5C01E2;
        Mon,  6 Nov 2023 03:08:07 -0500 (EST)
Received: from imap49 ([10.202.2.99])
  by compute3.internal (MEProxy); Mon, 06 Nov 2023 03:08:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mai.rs; h=cc
        :content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1699258086; x=1699344486; bh=aa
        lE5VObBiIUcCq3ni6lb0qhFxT4MrqRCVeFdCozL7A=; b=BHNqdNH7Ch5AkyRktE
        +SoeXLGzPREraJwsA9w383xPI/wTYEhW3Ehac8H1rlpaNfgjFrCv2/yLeUEsg/0u
        lBHvlHiR5hcqoVCfTFqqFk3pvfoNsyF2WhJKE/iA8Rug9R1G1k2v1lJTFnaYwNJ6
        /7sV0j38HQq4rEqQ5o9jbPSnmjKyWhM/mAFkQtuK0W42bSih5GQNmB2QnDrBZgUX
        c66+4yRw1R3RjuryhzH61scTztJaah4oplN1kbxrHx8d+MraAovCuNml/9sAEghl
        LLoH5b53NfsCoqUSGiO9qkmMYI5ZNOLMlXI+KeJ/1dNCm347RQSk5lk/e4dLLRx6
        gzsQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; t=1699258086; x=1699344486; bh=aalE5VObBiIUc
        Cq3ni6lb0qhFxT4MrqRCVeFdCozL7A=; b=E0kwt/84I34ZUbtxVKtvK8EhXywSP
        vrlipddahJUgUMwc66j6yWP5ixeRUoAO+g3oW65js5HTKM1PZCix9biDWWH4a8Fy
        Nci7MAHDK9dBP+8LNU1SGqbNlFmJe1ZvmxoSvQTY18oYgjZKzLaiYmj199qtUu1b
        Tw8SU0jgju9my4C69ZUWqmlmS3Q/HXDps+gUv1w4941nl4KPW+MbYqEQqmo9/bt2
        t0wK3z8dqsY0tDKakHSnMxU7MHDr2CKXdWWPQFwR3ehFEYf4Hl1JNlQbyiu7HTfs
        cGxeb4HpUVyouGwWH418SQYrop/UpSAKUobKzv58E5R0tlCX0DgFUbVQA==
X-ME-Sender: <xms:5p5IZc58ISmHJnKWccxyMICTyiQwMvOxGQUEmGwAQCA_WxohMqwF4Q>
    <xme:5p5IZd5TQZOWkicW4MFX0o4ZtDEKNp4YqIy1u5YOujSKkqLu2FYokfJiJtZEarwku
    LYaha7iyPCcPlSA2g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedruddufedgudduiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefofgggkfgjfhffhffvufgtsehttdertderredtnecuhfhrohhmpedfuehr
    higrnhhtucforghirhhsfdcuoegsrhihrghnthesmhgrihdrrhhsqeenucggtffrrghtth
    gvrhhnpeekgeeivdehkefhleelueduudevfeeujedvkeegtddvhfffieelgefgiefhiedu
    ffenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsrh
    ihrghnthesmhgrihdrrhhs
X-ME-Proxy: <xmx:5p5IZbeBMjAtubcr0sDq7cNRySJ2efXrSBfI-ce4uFQwX66BP9FS-w>
    <xmx:5p5IZRIRo3GEpBH26LMV1jyq1vtFLsgtv3oSXy5AGFmfkNotvaTnag>
    <xmx:5p5IZQI1oHjYJNhD_KvSFSQZsd_seQA8lcR_BYQMZS_XdNb1fO5n-Q>
    <xmx:5p5IZdALZja0hkIfq9i1--WPe6DkBQuNQqO6_ahSZnR7qZdxLhUuRg>
Feedback-ID: i891b436e:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id A831715A0091; Mon,  6 Nov 2023 03:08:06 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-1108-g3a29173c6d-fm-20231031.005-g3a29173c
MIME-Version: 1.0
Message-Id: <8a2743f5-86e1-45ae-b9b3-85b788749686@app.fastmail.com>
In-Reply-To: <1ea6c498-09bc-4491-a083-37fa242766c8@linaro.org>
References: <20231105204759.37107-1-bryant@mai.rs>
 <20231105204759.37107-3-bryant@mai.rs>
 <1ea6c498-09bc-4491-a083-37fa242766c8@linaro.org>
Date:   Mon, 06 Nov 2023 09:07:44 +0100
From:   "Bryant Mairs" <bryant@mai.rs>
To:     "Krzysztof Kozlowski" <krzysztof.kozlowski@linaro.org>,
        "Andy Gross" <agross@kernel.org>,
        "Bjorn Andersson" <andersson@kernel.org>,
        "Konrad Dybcio" <konrad.dybcio@linaro.org>,
        "Rob Herring" <robh+dt@kernel.org>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        "Conor Dooley" <conor+dt@kernel.org>,
        "Dmitry Torokhov" <dmitry.torokhov@gmail.com>,
        "Linus Walleij" <linus.walleij@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
Subject: Re: [PATCH 2/7] dt-bindings: arm: qcom: Document samsung,milletwifi device
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sending again in plain text, sorry about that!

-----
That's a good question. Note that there is also samsung-matisselte, so I wasn't certain what the policy was on naming, which is why I deferred to the manufacturer naming scheme, which seems to be the most common approach.

On Mon, Nov 6, 2023, at 08:37, Krzysztof Kozlowski wrote:
> On 05/11/2023 21:46, Bryant Mairs wrote:
> > Add binding documentation for Samsung Galaxy Tab 4 8.0 Wi-Fi
> > tablet which is based on Snapdragon 400 (apq8026) SoC.
> > 
> > Signed-off-by: Bryant Mairs <bryant@mai.rs>
> > ---
> >  Documentation/devicetree/bindings/arm/qcom.yaml | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/Documentation/devicetree/bindings/arm/qcom.yaml b/Documentation/devicetree/bindings/arm/qcom.yaml
> > index 88b84035e7b1..c66980b79f59 100644
> > --- a/Documentation/devicetree/bindings/arm/qcom.yaml
> > +++ b/Documentation/devicetree/bindings/arm/qcom.yaml
> > @@ -156,6 +156,7 @@ properties:
> >                - huawei,sturgeon
> >                - lg,lenok
> >                - samsung,matisse-wifi
> > +              - samsung,milletwifi
> 
> Not millet-wifi like the other one?
> 
> Best regards,
> Krzysztof
> 
> 
