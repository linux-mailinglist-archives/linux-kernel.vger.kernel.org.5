Return-Path: <linux-kernel+bounces-163743-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AD588B6F19
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 12:07:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CD3BC1C22E91
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 10:07:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 909881292EE;
	Tue, 30 Apr 2024 10:06:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="P8/0UXeA"
Received: from mail-yb1-f180.google.com (mail-yb1-f180.google.com [209.85.219.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83156127E02
	for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 10:06:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714471616; cv=none; b=IvFs5bdS9FTJdm7AQ0tS4fDdkX2bjso603KqD6qEg1x6dtnqLIDNAVQUt7O4/14KU2ndYqSPbdvdH5k9nVznOiDNv7eHjfwnaCYRDZgGDiaHVt4AjA01izVKuefMqfwtZbEURjxPW0f5ZCN/7ykHvfL2nZW964yGUaCf4v2PvtE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714471616; c=relaxed/simple;
	bh=axteUmH6ZxwjdcX+M+kFgVq2+FpkI3vjfHuuHBVqfQI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cR2vxQBjqsYKREAkwXi1B19V7iiAM1r/Cm8uejzmt9r1fYYK4DMmLF6edWTrLL+ffwdzbLoVWptrSkeDsGUUWa10QDwACJSZdxeoC1CWoctrwX1YAoxi5r0PTd/taNb0MSJ/n68YusR6tx2+//L888hKb1AZwU7Pw8IULJ1THI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=P8/0UXeA; arc=none smtp.client-ip=209.85.219.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f180.google.com with SMTP id 3f1490d57ef6-dbed179f0faso4535852276.1
        for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 03:06:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1714471614; x=1715076414; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=MlCHLOgPqDRLXHqKx+3SitAREHYVUHF6/1Vu/GrVjUI=;
        b=P8/0UXeAedpFngzpVva+dG/ekjEUqzLQDewZ0IiVBKfmBKncpwLUfE33/AkDd+uw/+
         rl17QyBkW0FzgeYj9Zk3iahtPUksRKaDbWzv+2DmbN1fj0MwMz5CywUAQcxXUzELzxyR
         Ptvi90SAMjlsa86Ddx3jHptpnVE0vRt4eiJHerD+j5YzgAb95uv9y9thRhNOckWumegb
         yHow4df75bRryeYg08PaMEQynGF6Keck1gGb7OFWKk8kl1JW0n0zqw0ukDpQf9iEBz8w
         6fyWHutJA37DrmU6cMYuq/JjxN+Kd8OlyW0g8TX9h7kA2QN3ZA1gG/9ANYClcpa2bkOr
         becQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714471614; x=1715076414;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MlCHLOgPqDRLXHqKx+3SitAREHYVUHF6/1Vu/GrVjUI=;
        b=vsqwdn1i+S1bT2R0Vf5m4n7H4bV96fbitklTOYS8/OFwLTzMnm4C+qDdsTF2Ymiz06
         mAQZ97f+DcnSOdh5IZzfXJxt9ZAbdTlhmemwUWK8M3wzw4sNGSLTHqz+UitKVZrd8lJ9
         IzyeBwTxWoKvNzFjlFUnfycVNFmV76g+ceWryZ37u4pu2bz9aT6um39S6cau4ZqwCfpM
         yHflIcbaMT0q5f2BGEFnRNTIGDghJkcffmhgbF05/qMaG3WtwL7SpTgCYRx2VcIYrJyH
         F1gDGty+2N8FPSw/HVMtgkRqwinLLms+MfkNfF5f6HPo5mJZncwb8PKN1XfSYh2AqQqi
         F1Ww==
X-Forwarded-Encrypted: i=1; AJvYcCVTheufYQhdDjTpW8w3GXaMiWl9Jle0GVScM9QmtDlgL9mHPOHXLpTUSozQ2w5Ndv9l9DzbTSwD1PN5bDH8or0Za2lHpxqFRfq/a25k
X-Gm-Message-State: AOJu0YyjP7Ip+2WKXWuz6wB1fLn4S3yrvjKK3jri6kw0p6J4H2qDmX6o
	czQweoX8cm579SPPq1DZeMGOH6oqXVYm12tZM3sijka5243EOIuzlOwuhWn4n/1w6fRJF2N5Mce
	GTM/yYe94TLLSDreOkSkyL5PA4bSx7wZbWRLEew==
X-Google-Smtp-Source: AGHT+IHoP+iVd7qlwAFzYWTdougtImUWdhZLRa6FuX18dZxDNxyUVqYihujO3viQd+oKo5o++hiv2iH4hzQQlPWUCcM=
X-Received: by 2002:a05:6902:cc2:b0:de6:a86c:b84e with SMTP id
 cq2-20020a0569020cc200b00de6a86cb84emr248624ybb.16.1714471614593; Tue, 30 Apr
 2024 03:06:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240429-usb-link-dtsi-v1-0-87c341b55cdf@linaro.org>
 <20240429-usb-link-dtsi-v1-11-87c341b55cdf@linaro.org> <a35c0e9f-9f1f-44ea-8248-cc632c6db291@linaro.org>
In-Reply-To: <a35c0e9f-9f1f-44ea-8248-cc632c6db291@linaro.org>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Tue, 30 Apr 2024 13:06:43 +0300
Message-ID: <CAA8EJppK0YPqQXGmQdZrrkTz-mf5h-vOsoak1p0fSMWLKDuovQ@mail.gmail.com>
Subject: Re: [PATCH 11/12] arm64: dts: qcom: delete wrong usb-role-switch properties
To: Konrad Dybcio <konrad.dybcio@linaro.org>
Cc: Bjorn Andersson <andersson@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 30 Apr 2024 at 12:34, Konrad Dybcio <konrad.dybcio@linaro.org> wrote:
>
> On 29.04.2024 2:43 PM, Dmitry Baryshkov wrote:
> > The usb-role-switch property doesn't make sense for the USB hosts which
> > are fixed to either host or peripheral USB data mode. Delete
> > usb-role-switch property being present in SoC dtsi.
> >
> > Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> > ---
>
> I'm more than sure all of these devices are physically capapable of
> doing both modes, but the infra to switch modes / provide VBUS as
> host was / is not hooked up or present yet

Yes. So it makes sense to add the usb-role-switch property if/when the
board gains dr_mode = 'otg' support.


-- 
With best wishes
Dmitry

