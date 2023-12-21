Return-Path: <linux-kernel+bounces-9113-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A6A9181C0CB
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 23:07:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A7BD91C21BF0
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 22:07:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F176377F39;
	Thu, 21 Dec 2023 22:07:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="He86Bu18"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB6CE5820E;
	Thu, 21 Dec 2023 22:07:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a232b787259so29867666b.0;
        Thu, 21 Dec 2023 14:07:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703196447; x=1703801247; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hWQ5z1g9zFywjWikkHBP5I5neaV4NLvVeJytBsfFYhc=;
        b=He86Bu18yUc/CCcfscfitBSifS8GDZ86NB9ujy0NAYAAcdVQZJjDKq4p9EKfJK4x5Y
         HqE8Jqu+ZQGe+w3kCiJYTaqwsqo9003+NpT166wYKFXlombLPGfEcdfd0I+KTLRkA6E6
         fIiDKJjJsTg6GvktHt0INradDPiCNy5yvfKD/T9CtQ2sXz6fUs9h7fVRO0jLFHi5Y8a5
         X+/0su9BMQ9x2H48iexFsPhM2ZWCZyJKFw+Cz8MYcqsWP5NYVe3jiOY1CfUoQFeuXvRt
         lzVT3KjNLla8wwnjT42beGqDMeWbnUFbCfnNWsLOF5uox85yJHQCJ+jZHSSQdbSUVOeI
         j28w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703196447; x=1703801247;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hWQ5z1g9zFywjWikkHBP5I5neaV4NLvVeJytBsfFYhc=;
        b=mDWaraEZkl5T3SaCybPDZ8RpCK6VzKPCLwOI0aKKzlrEM1CNzMxTSXNPN3bs0uOUJx
         lxmC8pW756MWP00t2XdVmhySm6lkYt8zwKtNM4DjBUzCNnrB2g8SykJqzRad4Wd2ApUL
         hvRGnEmrHzUC//0sDwP02VyQ1TcYJC5x5jtMsQr+p/18jaJLDgzKLSPAjCfSKwMiGUyE
         F10iQVtHZ0m0DJ555pl95Ne/x6aQXWiG2gI1As0X2MjfjWmi59d7ieym9Dr5JNk2B2WA
         tHdn8cbuUBeEBZ0gGuZ7z2x1Edv3pd7SQRUeYFWFCPdvhKEJjQ+Zg3xE/7qhFPbLzwax
         xcyQ==
X-Gm-Message-State: AOJu0Yx/aWhk8jeUzW24Ope6KsHodENMAZRiFCIp02PF4s+86DUL53SC
	kUtT0dvMnSxPv7RRgydU4kQJXLGGJsRgzeZHqWp8BQN+07Y=
X-Google-Smtp-Source: AGHT+IENHF4AiglUd143Iu0rg4V7i+HMpiAWBus/Aku067i7b7AXaJZsZ800s9BGiDW4M9c8UKWK0pNOFjPwaYhDJPA=
X-Received: by 2002:a17:907:bc5:b0:a26:9974:2015 with SMTP id
 ez5-20020a1709070bc500b00a2699742015mr384007ejc.4.1703196446733; Thu, 21 Dec
 2023 14:07:26 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231221214822.3063219-1-olvaffe@gmail.com> <c5b28a49-cc0f-41b1-8dfb-76af93636fb0@linaro.org>
In-Reply-To: <c5b28a49-cc0f-41b1-8dfb-76af93636fb0@linaro.org>
From: Chia-I Wu <olvaffe@gmail.com>
Date: Thu, 21 Dec 2023 14:07:15 -0800
Message-ID: <CAPaKu7Rx_tShhmJrwYgnZefaxy37yhms9qoXS9n07+=ohCEZ9w@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: qcom: sc7280: revert back to PSCI PC mode
To: Konrad Dybcio <konrad.dybcio@linaro.org>
Cc: cros-qcom-dts-watchers@chromium.org, Andy Gross <agross@kernel.org>, 
	Bjorn Andersson <andersson@kernel.org>, Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Ulf Hansson <ulf.hansson@linaro.org>, Maulik Shah <quic_mkshah@quicinc.com>, 
	linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 21, 2023 at 1:55=E2=80=AFPM Konrad Dybcio <konrad.dybcio@linaro=
.org> wrote:
>
> On 21.12.2023 22:48, Chia-I Wu wrote:
> > This effectively reverts 7925ca85e9561 ("arm64: dts: qcom: sc7280: Add
> > power-domains for cpuidle states") for sc7280-herobrine.
> >
> > Fixes: 7925ca85e9561 ("arm64: dts: qcom: sc7280: Add power-domains for =
cpuidle states")
> > Signed-off-by: Chia-I Wu <olvaffe@gmail.com>
> > ---
> 0 explanations?
Ouch.  It's in the comment

+ * Devices that use SC7280 with TrustedFirmware-A
+ * need PSCI PC mode instead of the OSI mode provided
+ * by Qualcomm firmware.

and is similar to the case with sc7180-trogdor.  I can send v2 if necessary=
.

>
> Konrad

