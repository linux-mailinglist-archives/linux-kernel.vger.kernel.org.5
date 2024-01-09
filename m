Return-Path: <linux-kernel+bounces-20715-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E3FDA8283F9
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 11:27:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 95FD41F247CC
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 10:27:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEE88364A2;
	Tue,  9 Jan 2024 10:26:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gR8WJl1J"
Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com [209.85.219.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4505360AB
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jan 2024 10:26:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f171.google.com with SMTP id 3f1490d57ef6-dbed729a4f2so1966803276.2
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jan 2024 02:26:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1704796015; x=1705400815; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=kgqGlkcMY7u56Ey8Ssan/W4yPE2JFQtM3N3GgOR/j04=;
        b=gR8WJl1J//qv9if6koihIbit0Zd7NxTDX7R0irdnFoqdnSsM5W4AYuMSN/Q1P+Lq9k
         vc/6hEtrPhFqo9ZNhdcH2Zm/QJ1vQFQOiOU87J6V14C2vYYdc53AZt2Q7JXBnrBUC5Cm
         FtbqfYYhpdiRIioTF7l2TbUMNd0uz3azs+u7705vmcZ8wqCAcE5DlMTzMZ1FVH8PBtPV
         nf6oN/wvRmysmK+WpdAgfi2AdzAx1SFcz+WA46hi5WCMIz3JsYjGXCQyc44AkhJsoMLH
         1k1VKlpdkFSer1fVr9XSWFbLjya6Hjux4gYI28JqoQzhLn1gtFsuLRS1ZpsFcbBoHt9D
         HCQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704796015; x=1705400815;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kgqGlkcMY7u56Ey8Ssan/W4yPE2JFQtM3N3GgOR/j04=;
        b=R1eEdBhD9+wgodt54Oar9Xe6wt0dGPvNRt/S4xldbEnIZMi/DoViET2HZPkF/+NPHi
         yRpgjqm6PQpecZjkaFDvzy9laDOW6KCf2hU3rFgIcBppUz7BnPuFD1V8LNG5KKKet29I
         EojAzlKfqZe++1acJGULlB8HJmWiY8NTwTwiMj2E/a4iGQpqTsBQIpZ04f5I9ykTrd7R
         yfLEdTpg3QxFrYpWZv3E06KCJWR7Uscg16mIIszwtSRT91Y6jjzMWwlgWl54TRCrH6hL
         09TEqAzMnX97XI1UuonGCkbEMB7O/kPqVdpMMwDD42uo1hIq78bB95uFlPlENVXLjWp4
         x6bw==
X-Gm-Message-State: AOJu0YwpWvwdxB6JFrgEkjWL0OeEmzbSfeDxxhjTVPQt/Os8GdmGtgff
	W5GRtFSa0gJpDSVE1CIv5jxITKA1JDau/RRMVv1/oc070ASavg==
X-Google-Smtp-Source: AGHT+IEQcZ6P9lXrBSBQ98idjcrgG87Zex/N/4zJ2/Drg8bOifKzxnfvcNAyWLYxJMhEyMuLNyRozZ9WLgS7M5DCWzc=
X-Received: by 2002:a25:fe10:0:b0:dbe:ab5b:c659 with SMTP id
 k16-20020a25fe10000000b00dbeab5bc659mr2117007ybe.37.1704796014777; Tue, 09
 Jan 2024 02:26:54 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240105-fp4-thermals-v1-0-f95875a536b7@fairphone.com>
 <20240105-fp4-thermals-v1-2-f95875a536b7@fairphone.com> <18dc5f88-6590-4e2d-948f-fd77f4713f8b@linaro.org>
In-Reply-To: <18dc5f88-6590-4e2d-948f-fd77f4713f8b@linaro.org>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Tue, 9 Jan 2024 12:26:43 +0200
Message-ID: <CAA8EJpp5ZwJUJbbt7YG=1aAdGoScA+PTEf==7gJk3RUP2yu8uw@mail.gmail.com>
Subject: Re: [PATCH 2/2] arm64: dts: qcom: sm7225-fairphone-fp4: Add PM6150L thermals
To: Konrad Dybcio <konrad.dybcio@linaro.org>
Cc: Luca Weiss <luca.weiss@fairphone.com>, Bjorn Andersson <andersson@kernel.org>, 
	Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 9 Jan 2024 at 12:10, Konrad Dybcio <konrad.dybcio@linaro.org> wrote:
>
>
>
> On 1/5/24 15:54, Luca Weiss wrote:
> > Configure the thermals for the PA_THERM1, MSM_THERM, PA_THERM0,
> > RFC_CAM_THERM, CAM_FLASH_THERM and QUIET_THERM thermistors connected to
> > PM6150L.
> >
> > Due to hardware constraints we can only register 4 zones with
> > pm6150l_adc_tm, the other 2 we can register via generic-adc-thermal.
>
> Ugh.. so the ADC can support more inputs than the ADC_TM that was
> designed to ship alongside it can?

Yes. ADC_TM can support monitoring of 8 channels in total.

>
> And that's why the "generic-adc-thermal"-provided zones need to
> be polled?
>
> >
> > The trip points can really only be considered as placeholders, more
> > configuration with cooling etc. can be added later.
> >
> > Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
> > ---
> [...]
>
> I've read the sentence above, but..
> > +             sdm-skin-thermal {
> > +                     polling-delay-passive = <1000>;
> > +                     polling-delay = <5000>;
> > +                     thermal-sensors = <&msm_therm_sensor>;
> > +
> > +                     trips {
> > +                             active-config0 {
> > +                                     temperature = <125000>;
> > +                                     hysteresis = <1000>;
> > +                                     type = "passive";
>
> I don't fancy burnt fingers for dinner!
>
> Konrad
>


-- 
With best wishes
Dmitry

