Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFC6E7DCAE5
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 11:31:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343687AbjJaKbd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Oct 2023 06:31:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234962AbjJaKbb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 06:31:31 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6A1AA9
        for <linux-kernel@vger.kernel.org>; Tue, 31 Oct 2023 03:31:27 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id 4fb4d7f45d1cf-5230a22cfd1so9431021a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 31 Oct 2023 03:31:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1698748286; x=1699353086; darn=vger.kernel.org;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LwcpAw93f8EcOvzGZFcG9/r02PfDebZGVqeB4dh3eQo=;
        b=sDppNOCPXHUEBhOfx8IlTeuaB0d620dH/TqHK564vPCVsYrtAeM6xU8MKWHNtHbp3g
         VTQsp2XlAL5KTvYomxN7Z/dVSPOp5GWq5ajqd8mM0YPsfFo9bZlxrB013VWpKolgm0mk
         fA+0P5o/3NYP33s6hcbI1NB7kMG3odT6UYUobaD1sgJ1pby8Hxma5Yc+Z5vHbGwS3MWG
         BdE0tjBXMhONnvkM0SuVdv7rRosERjDfGkerYF9f/+zhPgs9IPobv1AbE3UmuhULZzL0
         mBiGoerQ1G3qWGaeFa5HyHpumGEzqF9/wXejZhYOKUvFPltJ+YjyqfuYZRN5xfUlQrBz
         uKww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698748286; x=1699353086;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=LwcpAw93f8EcOvzGZFcG9/r02PfDebZGVqeB4dh3eQo=;
        b=Q0wGCg4gZS77vfjhlHHU0KiWOMMzJxbBsHbhBhU6YpaaIoI0UgrvERN/Hl818Gym0B
         FAK/M2B3Qzfik7WKR5efy41auxvAbOwhi6SY9ld+6rn0lo6iOpksy9MX1l5+Co37gb+z
         r3+WixanApWZn0dKf6gLVert1Yw5nIyigEIld6Ri1QE/sMQHTKdQ58qyus8gAURNuQ4D
         198xGx2MSyBg0oZ+LM3Jui982AK71Rvm7+A68mXL9Q2yPrXY2ChOTtp6HY0tRap2gHNr
         b72leMaz8N5C0t+6tMUPjmW0+IdrAcocJmg+Kxnb3mEWC+m8ELQEvCp+t0N/v72BKUBn
         wNlg==
X-Gm-Message-State: AOJu0Yx0vvKQFyurHZWqyQE8BZKvwXzZVWcat3bQe9MbhhVPeTVTECgv
        063mNGy84W6aWjAMI35Dis7/0w==
X-Google-Smtp-Source: AGHT+IEK2nbNqEftFgCQaEKTK6oP+JGRn2+Pt4iMlF4vWkb9BS+YeoAi2iIM0BIkp3QaBbb1bZ+L0Q==
X-Received: by 2002:a17:907:e88:b0:9c5:64f2:eaba with SMTP id ho8-20020a1709070e8800b009c564f2eabamr11912495ejc.53.1698748285858;
        Tue, 31 Oct 2023 03:31:25 -0700 (PDT)
Received: from localhost (mobiledyn-62-240-134-77.mrsn.at. [62.240.134.77])
        by smtp.gmail.com with ESMTPSA id l11-20020a170906414b00b009b2ca104988sm739894ejk.98.2023.10.31.03.31.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 31 Oct 2023 03:31:25 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Tue, 31 Oct 2023 11:31:20 +0100
Message-Id: <CWMK0AQRL87L.1F9MIDVQ4J439@fairphone.com>
Subject: Re: [PATCH 9/9] arm64: dts: qcom: qcm6490-fairphone-fp5: Enable
 WiFi
From:   "Luca Weiss" <luca.weiss@fairphone.com>
To:     "Konrad Dybcio" <konrad.dybcio@linaro.org>,
        "Andy Gross" <agross@kernel.org>,
        "Bjorn Andersson" <andersson@kernel.org>,
        "Mathieu Poirier" <mathieu.poirier@linaro.org>,
        "Rob Herring" <robh+dt@kernel.org>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        "Conor Dooley" <conor+dt@kernel.org>,
        "Manivannan Sadhasivam" <mani@kernel.org>,
        <cros-qcom-dts-watchers@chromium.org>
Cc:     <~postmarketos/upstreaming@lists.sr.ht>,
        <phone-devel@vger.kernel.org>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski@linaro.org>,
        "Rob Herring" <robh@kernel.org>,
        =?utf-8?q?Matti_Lehtim=C3=A4ki?= <matti.lehtimaki@gmail.com>,
        <linux-arm-msm@vger.kernel.org>,
        <linux-remoteproc@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
X-Mailer: aerc 0.15.2
References: <20231027-sc7280-remoteprocs-v1-0-05ce95d9315a@fairphone.com>
 <20231027-sc7280-remoteprocs-v1-9-05ce95d9315a@fairphone.com>
 <12ea48bd-5022-4820-815a-89ef23ec9385@linaro.org>
In-Reply-To: <12ea48bd-5022-4820-815a-89ef23ec9385@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon Oct 30, 2023 at 8:26 PM CET, Konrad Dybcio wrote:
> On 27.10.2023 16:20, Luca Weiss wrote:
> > Now that the WPSS remoteproc is enabled, enable wifi so we can use it.
> >=20
> > Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
> > ---
> >  arch/arm64/boot/dts/qcom/qcm6490-fairphone-fp5.dts | 4 ++++
> >  1 file changed, 4 insertions(+)
> >=20
> > diff --git a/arch/arm64/boot/dts/qcom/qcm6490-fairphone-fp5.dts b/arch/=
arm64/boot/dts/qcom/qcm6490-fairphone-fp5.dts
> > index d65eef30091b..e7e20f73cbe6 100644
> > --- a/arch/arm64/boot/dts/qcom/qcm6490-fairphone-fp5.dts
> > +++ b/arch/arm64/boot/dts/qcom/qcm6490-fairphone-fp5.dts
> > @@ -713,3 +713,7 @@ &venus {
> >  	firmware-name =3D "qcom/qcm6490/fairphone5/venus.mbn";
> >  	status =3D "okay";
> >  };
> > +
> > +&wifi {
> > +	status =3D "okay";
> qcom,ath11k-calibration-variant?

What value would I put there for my device? Based on existing usages
(mostly for ath10k) I'd say "Fairphone_5"?

And you mean I should add this property in dts before even looking into
the firmware/calibration side of it?

Regards
Luca

>
> Konrad

