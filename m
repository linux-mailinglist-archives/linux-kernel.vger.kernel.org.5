Return-Path: <linux-kernel+bounces-38174-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 41CBD83BBF4
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 09:27:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ED31C1F219F2
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 08:27:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F81217993;
	Thu, 25 Jan 2024 08:27:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZEMYCeZG"
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D0F7199BE
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jan 2024 08:27:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706171225; cv=none; b=lxFoNM4MyiEp45i+J96p7acyYrj/H0D1b6NojVKVDaNiz+6uhVbeLo791jAmsKdhFTnhz57r0CEBLlhYxilo12FlGjXbgmha4u4RnNA73gQgf67jdh0D19PYF5QjKZhv6R4USr1J+TStqg9ANSp8Lo245Prs/DxVULSt0AmSj1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706171225; c=relaxed/simple;
	bh=epCn74cCro25TUD1QolrGgdibFLExDob+WY6wtKgwgU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LL1WEMuTU28NqAMV0hSmKvTorR7vgbJc0wCGfWa3qAob2YEPlwMnt1h/A7RcR2+6EfcOVj7jtll4rjpwfbAT0M8FNmojhbEZPkUt53daNZujile/9SouKR1P961zYDLsXzcUHw2lO4j7UIHz/u2euOCQPyxHPUr5iZTfMqIdPBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ZEMYCeZG; arc=none smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-600273605a9so37342427b3.1
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jan 2024 00:27:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706171223; x=1706776023; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=5db9cUe3aHqjgTBEeT9QTdcx827mStp0Y3bBIBsr4u0=;
        b=ZEMYCeZGT5DFTI7ZZcwNjRAywthp74itgUlUcL8/0l28YpdHU8mRKiHESNoPuzP761
         KkMaXXph5DRJZiSgYAwkMhnSEhMYqoJEqqM6teV4Yo5SCLRGQvnu7qVDq3ciax9TRmmK
         kG8JGApkxpvc4NZvIBVKwzPleqpLQQRBYix029tsVNQgR2Cb3jaBgyhPDlZqnlP6qmoR
         z2gPEX2JKDSyUY6MLDILzAE5VJZsX2zIbpHtLnjaL5W5W4nmg6vk1VKbZLSYUfvs2GH7
         vXhDPN/o9Dpvg6fjjj6CSHN9L3B89c9LSpmSMjIN88e667pt1JR+MYk5OUJ33aYMPH41
         iVrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706171223; x=1706776023;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5db9cUe3aHqjgTBEeT9QTdcx827mStp0Y3bBIBsr4u0=;
        b=hj51l0irB2sO44lKzuo5JoALURJuQFV5eVnqOmlGSv60cBDhjF9g2bXt8DS83s0QK7
         KVuaar6hdnD+gtw/goZPSlKndDzHYgxhOrtXoC/1p6i1fKI2kstAYhVLhG4vfZl0F43M
         HoN8QDxJAJUHkOq8qzDsSVCjT783UIIIEgXpPQJ2rSTrZwhDDO9L6eR1S3bquWypcBT0
         x/OlrzTRr6mIDkWrYrIaOw7La4UEF/KUllyJptb1ioK7KnHdSm/gM4AU8VrpQLJq0uKg
         Xn0SGEumO+pOUqhg/6Y1z9r6hXt50JqAPbX71nxhfNRP7CGZpEReIDHnAzbURGkPCU++
         ZFdg==
X-Gm-Message-State: AOJu0YzPEhSu2MYz9tDWmJehOWMVGfzsgd+KSo199oORFNHdDJ+VL/t8
	l2uXR2qQ/idQLSdRyNP5BOkKUJEXWq979KIdQ5wSuRxie+v6oTFbJKoVug83JDZj7nLcVxAvEue
	8u17jef8DVTrL3jb86pruCm0Qu5h7qpP/lH58kA==
X-Google-Smtp-Source: AGHT+IEUQCuoEpqKG7r7GJy4FbZtSZ/S0mjmHDm9w7otjaaJRTfJiU+7gOZnFJldnLX/tYEdSk92C7pDiM359eCuLz4=
X-Received: by 2002:a0d:dd89:0:b0:5ff:88d2:631e with SMTP id
 g131-20020a0ddd89000000b005ff88d2631emr355966ywe.90.1706171223325; Thu, 25
 Jan 2024 00:27:03 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240123102817.2414155-1-quic_uchheda@quicinc.com>
 <CAA8EJppwboaEbKFFACr3LO0OHg4iOJPapKRqoH2EGEYcjV6HfA@mail.gmail.com> <735575f5-ee46-4c91-b0bd-e9c6fb97361c@quicinc.com>
In-Reply-To: <735575f5-ee46-4c91-b0bd-e9c6fb97361c@quicinc.com>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Thu, 25 Jan 2024 10:26:52 +0200
Message-ID: <CAA8EJpr6XrhNp2gdbqmCow7ShXLNXEwGZ-a_Yxr08bcxtORg6A@mail.gmail.com>
Subject: Re: [PATCH RESEND] arm64: dts: qcom: qcm6490-idp: Add support for
 PM7250B PMIC
To: Umang Chheda <quic_uchheda@quicinc.com>
Cc: Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konrad.dybcio@linaro.org>, 
	Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Kamal Wadhwa <quic_kamalw@quicinc.com>
Content-Type: text/plain; charset="UTF-8"

On Thu, 25 Jan 2024 at 10:10, Umang Chheda <quic_uchheda@quicinc.com> wrote:
>
> Hi Dmitry,
>
> On 1/23/2024 5:48 PM, Dmitry Baryshkov wrote:
> > On Tue, 23 Jan 2024 at 12:28, Umang Chheda <quic_uchheda@quicinc.com> wrote:
> >>
> >> qcm6490-idp platform supports PM7250B PMIC as well.
> >> Add support for the same.
> >
> > The platform can not "support" PMIC. Please fix the commit message.
> Shall I change the commit message as below in the next patch ?
> "Add PM7250B PMIC support for qcm6490-idp"

This is also not accurate. You are not adding support for the PMIC.
You are describing PMICs present on the board.

-- 
With best wishes
Dmitry

