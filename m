Return-Path: <linux-kernel+bounces-51783-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DCE14848F3B
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 17:25:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1C3BD1C20C4F
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 16:25:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0173122EE5;
	Sun,  4 Feb 2024 16:25:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ERt8fLIp"
Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com [209.85.219.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9605722EF8
	for <linux-kernel@vger.kernel.org>; Sun,  4 Feb 2024 16:25:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707063934; cv=none; b=YzXphCy3t6K5MToGdLxPWeFjXAvNaIVmCNqyVofjibX0fLHntqOd+geuvR2NBqh07mkXWkbTyH5FBqFbmfJ6SVL6ljiY8oMNE50tlasQVuXqrWsI+vcU/yeXC8QZVTrHsa4SVw04TuWqpwhi4zALcVw7xTbJrdRPV7rMzXvqGpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707063934; c=relaxed/simple;
	bh=Cak8oTO/A404VS+TCvIOe2zk0/RX2ID1i3+ycLZpmUg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=J55jT7lw3e3LKS37/HtBYZbOC0rxAVi3iihbCmNJatqNSqRW0PATmLgY/YH3krOfsw5i5tO6PeNHYI8cOPavZleSgtSo1Mv2kWSKhoMztZO5i3t/xT4Y72t0RQ6iNjcnJ4NYUGgHboA8drBoZPl37drf/0i8OzT7g01w7uOHn10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ERt8fLIp; arc=none smtp.client-ip=209.85.219.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f177.google.com with SMTP id 3f1490d57ef6-dc6df28315fso3322649276.3
        for <linux-kernel@vger.kernel.org>; Sun, 04 Feb 2024 08:25:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707063931; x=1707668731; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=tDgFyXQiTCVfR+Z+vTC+6dB9P+1VUIHJVTRXgZF6nms=;
        b=ERt8fLIpHT9grIP2abTNG7eWXCQ9Ciew4wofWDS512Pr+Qa9l9ky57BqI6pLgZ3Zuc
         P24j4Wj7hhpnhv1sZnMPZUwfhSL/OPh/nOCN6V/Y0+ozzd6Jyd6sL0WVflVB+nOvDCgU
         nq7j7aV0FhzGkOc2VSKFBg18jh6IV1lyrP1L+xmBV9jj85P1vDptWv7aOQryB3F7WjRV
         y3QeFzxp0vHtaLy5azB37xcNc09zdeqMblhpvL65m7J0KDoQeLeBerJHwdAN/+wX5RVn
         3ja5/1q1zIDdUyy4ScHKyjh6gxb4nec1po+3JenTkBdkA1Oo2dSX42jmu1lrrXG2YiPq
         LlEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707063931; x=1707668731;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tDgFyXQiTCVfR+Z+vTC+6dB9P+1VUIHJVTRXgZF6nms=;
        b=WPcLI8vwYtQNz9GqzuyG4FggB73JZd8sO45MMjPdAn/ZXowGPVuBZJStZyIqu7fb2x
         sgxnwdugMkqqp/8mWWAv1kmDNN39iW+vicLBLJwDwOXNOARtT+xHE07IXYOHNGKT2H5q
         IunheKY7y2HrJT2O96sQ6wRXXlrzG6eemLK1IC3pVqA39hfwaJsxrxnFO6IcS+qK+icP
         uz9HkTEttO0Ruk8y2zIxThSB8yQ68B7YPpK5pyyG+/GqWDNdSEiKYAseF8oLjqWy6etH
         92c7rvKUNOuAz/lLy8t1EsJB29VS9I+v8VHjPO0JN+ysialbSUIywmSgr+UAtkz7NHbh
         4Oeg==
X-Gm-Message-State: AOJu0YzluorgMSPHhTIsdI6anZGdYYd/XUi9mZWh9wjhCD2RfGFlW946
	K4QITrlugV2R2uIFH58dVXaPdCqP4DKYlqD8+pMMk42H/5/Kr5Z2ZGtl8YNXPNJr8vtayhLypln
	64OoXFQSy6qzn8/WL+pTFWp0u25Xwkbr9Z2W+Gw==
X-Google-Smtp-Source: AGHT+IECF7o2B+g+CzkQ5IhaJ3FdrB8va470/nqmyCBQ8xGw3mpQ4DVtoT8W9hL5NIjDWFu+zUgzBEDOEaTGljsj1Ew=
X-Received: by 2002:a25:ad5b:0:b0:dc3:7305:549f with SMTP id
 l27-20020a25ad5b000000b00dc37305549fmr5894882ybe.16.1707063931514; Sun, 04
 Feb 2024 08:25:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240119100621.11788-1-quic_tengfan@quicinc.com>
 <20240119100621.11788-2-quic_tengfan@quicinc.com> <7e7bc8ba-f349-47f5-b6ba-6594edccaaa8@linaro.org>
In-Reply-To: <7e7bc8ba-f349-47f5-b6ba-6594edccaaa8@linaro.org>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Sun, 4 Feb 2024 17:25:20 +0100
Message-ID: <CAA8EJpq8vvAeHuQYe2cp395m2K7VL46rrhALPySoFpYL5CXLbA@mail.gmail.com>
Subject: Re: [PATCH v4 1/6] dt-bindings: arm: qcom: Document QCM8550, QCS8550
 SoC and board
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Tengfei Fan <quic_tengfan@quicinc.com>, andersson@kernel.org, 
	konrad.dybcio@linaro.org, robh+dt@kernel.org, 
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, 
	linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, kernel@quicinc.com
Content-Type: text/plain; charset="UTF-8"

On Fri, 2 Feb 2024 at 15:34, Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> On 19/01/2024 11:06, Tengfei Fan wrote:
> > Document QCM8550, QCS8550 SoC and the AIM300 AIoT board bindings.
> > QCS8550 and QCM8550 processor combines powerful computing, extreme edge
> > AI processing, Wi-Fi 7, and robust video and graphics for a wide range
> > of use cases for the Internet of Things (IoT). QCS8550 is a QCS version
> > for QCM8550. Modem RF only in QCM8550 but not in QCS8550.
> > AIM300 Series is a highly optimized family of modules designed to
> > support AIoT applications. The module is mounted onto Qualcomm AIoT
> > carrier board to support verification, evaluation and development. It
> > integrates QCS8550 SoC, UFS and PMIC chip etc.
> > AIM stands for Artificial Intelligence Module. AIoT stands for AI IoT.
> >
> > Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>
> I want to unreview it.

Well, you asked Tengei to drop this trailer in response to v3. But
surprisingly got ignored.

>
> Please fix your commit msg to drop marketing and instead describe the
> SoC. I don't see for example any explanation why there is qcm8550 and
> sm8550. Aren't they the same?
>
>
>
> Best regards,
> Krzysztof
>


-- 
With best wishes
Dmitry

