Return-Path: <linux-kernel+bounces-146006-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F26118A5E4B
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 01:30:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9081F1F21E2E
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 23:30:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EC60159210;
	Mon, 15 Apr 2024 23:30:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a1M4u5aj"
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26829156F35;
	Mon, 15 Apr 2024 23:30:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713223805; cv=none; b=Ysl9LPmAtVjWs4Xh7/siH7PLxX/ehV0vT+i1hQUmZS/zYXY4zwjx5ClRJB+cE4d6Ky417ybUJ5fQsRne8O3QLvBgKGIKusfBFzGG9yVQKCKDWLUaCx6qwUlyc0Pm1/ZJYaSDThrRvge350Z3i8SXLGxxkmObkiI28G+XFRcrFxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713223805; c=relaxed/simple;
	bh=oQ5kq1vqmdu6YkvfJ3XgQQy1TD59RlmvtSo47UANF+M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RjlucaZg1ScXa1XMYtqdAuR2wjNX0muk5nY+VnaareXrxHnvaldq/A1BgS4eIVxrwkHtQdE0wNn6hC3mHNpfhmez2aeBJtAU8YCmDBIbHy34VAIjLK/x6BHFQcElGuHZfEpMxU4AmmUy2i8EMupI7UOCuYhPa8TmlyRBwSWGCeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a1M4u5aj; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-6ed2dc03df6so3402419b3a.1;
        Mon, 15 Apr 2024 16:30:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713223803; x=1713828603; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=FSEYM5JKOjoaWrt3+QgFKtBmTuxWyIo76LgkeQlZZck=;
        b=a1M4u5ajnX11QLEFN5pMIQHMJRwal+S03QHIhIYsf3nCVG6Kc3bNlW4+AtlyhadCje
         qWCUn8LVz3hHi0MdtGoknXMbamEBBuEJIKNPCOspKNHBodxtkKCGUNWxm1YqZoq4yuEd
         IJXxMl4QCCrVjvDE5HU9RvFVwpLjU0yfaC/bpTZduFeVB5hQmVye8oksXeOiotgYuLSa
         U+RFE0HMqRDS45xYre+f4IcE/x2yfbUHTuyFZ/EsWy7vuq+Rw6UUjkgZp9aKERqO+qjS
         4Rz5QreYLECVeTyYTXnnNTSFxYQ5HVc4k3opmMWVr0+xoyhn1OTCLzCDS2BYiiFbtde/
         Ip5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713223803; x=1713828603;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FSEYM5JKOjoaWrt3+QgFKtBmTuxWyIo76LgkeQlZZck=;
        b=TjN6Ts8jLTzSaDPYovm/dkEZCQwQ2fIByGrEtMOWhN63jq16lq7TMcbDmYlFZvqssk
         RwHN1bLpe2w4yFYbWvEaE6eIxJYyEwj45YqtXxUbDnEr6RY4Rkrj7XgQ3e38gwpxdnnN
         gdhvmfYonadru9O9WVKZACp0iMsZLi3mmfwJ96EKc/CpY9TI42NKTIJefms0esRUbUTm
         ygqwdCLt+Hmc2eNCxM1ni/IP7r/5nO4K7rffsFPcTtYH1R7rndwJZQuP/dSUDyE2Z+Qu
         fGEv2Gg01z8KRnSYqKNgFAWAf+EoZyHl4DvrDg8Dz83bLlOGsQNmprcmPEdnm19Dn3BL
         mcSA==
X-Forwarded-Encrypted: i=1; AJvYcCV9Zu6Zw6Cgk6b4wlP5OndGJUeebK/D/AYysfA2E6rG9DS7oXgPVEGU+t9kUYg4rnvxAIMbiom32QizDUI+0KHDDk7Q0k/MDZgopv8PQxCjxzba6aRBJ9bKR9WU9rhjEyFFiR0FP2qR+G9r0kPfV9ElgoDp5AHMiL6SjBs7pK/+07zIO6B2XIcMpAK2qtrVyhLoGUOhGEX1BDfqWinkO3XDeLpzfQ==
X-Gm-Message-State: AOJu0YxERZHBNhN29kELqDEu4SThWWHrOMCYW1+2t92aJBcja4g9YIOU
	EMXw5q0fMq/3rtu5wC2NI0bS+B54guntCtSARQqBnSyukGGMTq5U
X-Google-Smtp-Source: AGHT+IFirikLgnoHAWTaC/nN665LyYgkIFVQo7PulITNUZsSc3EElcMojy90I2rNO2Q+diEavf4nZQ==
X-Received: by 2002:a05:6a21:3996:b0:1aa:2285:2cd0 with SMTP id ad22-20020a056a21399600b001aa22852cd0mr3880359pzc.23.1713223802937;
        Mon, 15 Apr 2024 16:30:02 -0700 (PDT)
Received: from google.com ([2620:15c:9d:2:fbbe:421b:9296:f28c])
        by smtp.gmail.com with ESMTPSA id u6-20020a17090adb4600b002a51dcecc49sm7540592pjx.38.2024.04.15.16.30.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Apr 2024 16:30:02 -0700 (PDT)
Date: Mon, 15 Apr 2024 16:30:00 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: quic_fenglinw@quicinc.com, kernel@quicinc.com,
	Andy Gross <agross@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	linux-arm-msm@vger.kernel.org, linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v10 1/4] input: pm8xxx-vibrator: correct VIB_MAX_LEVELS
 calculation
Message-ID: <Zh24eN9ZMZ6QhzeZ@google.com>
References: <20240412-pm8xxx-vibrator-new-design-v10-0-0ec0ad133866@quicinc.com>
 <20240412-pm8xxx-vibrator-new-design-v10-1-0ec0ad133866@quicinc.com>
 <CAA8EJpp-awdTyfngeYyJaOObOWz=UCSK9U08TfFPA0v=8Naz=A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAA8EJpp-awdTyfngeYyJaOObOWz=UCSK9U08TfFPA0v=8Naz=A@mail.gmail.com>

On Fri, Apr 12, 2024 at 07:21:16PM +0300, Dmitry Baryshkov wrote:
> On Fri, 12 Apr 2024 at 15:36, Fenglin Wu via B4 Relay
> <devnull+quic_fenglinw.quicinc.com@kernel.org> wrote:
> >
> > From: Fenglin Wu <quic_fenglinw@quicinc.com>
> >
> > The output voltage is inclusive hence the max level calculation is
> > off-by-one-step. Correct it.
> 
> ... while we are at it also add a define for the step size instead of
> using the magic value.

I adjusted the patch description as Dmitry suggested, and applied this
patch. Please address Konrad's feedback on the other 2 and I will apply
the rest.

Thank you.

-- 
Dmitry

