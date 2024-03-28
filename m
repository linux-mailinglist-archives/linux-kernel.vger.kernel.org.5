Return-Path: <linux-kernel+bounces-123577-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D27B890B46
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 21:26:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 197D21F27384
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 20:26:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC06313B29D;
	Thu, 28 Mar 2024 20:24:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ErpvbV5s"
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C438313AD36;
	Thu, 28 Mar 2024 20:24:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711657484; cv=none; b=jMTJ9ovDnozDEOx74VfyIFcWVzNJybITRHaR1+A7PwuKYfC+UhViMdFXVL2xQk/+qKHiVMqAAbcdZzYufC1eJig63lmy9ezqiqZjGf0O75+j3h73RQO+34J1A5V097PkA0OGWF5GC8GbIM1TvbFvZQT+ZsIgNlNKHaUrknVtf7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711657484; c=relaxed/simple;
	bh=nsgSRkxzMwcL9nY3tuBJREALrbXEDPSiM7Rc2uwkNbU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AMYD40H8xYuTaeXrqTnz56PhiaGPYrOHC49fpjgKhqFM6sARgPFQPCEwiXh8Bhrx8Msy7nhN942ciW2JAKrMNmEXWOvJiMwaVD7/IuHC4RtshdIZmGFdbix5lB+3Jab2/MBfZj4L7xWMNWvH7o6X2a6rdA7ixik2FlFsag/6KbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ErpvbV5s; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-1e0f0398553so13914345ad.3;
        Thu, 28 Mar 2024 13:24:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711657482; x=1712262282; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=OSBQzFqQufqwBm+U4G6XPdH75Rro6F7rWhWjrRhCESc=;
        b=ErpvbV5sYBYqnyUlP91TonlqNUcq9w763iSlMGk34Cfzztx61tp83qndlir+ezUN3m
         XgkNbscKIg3LDNoJ6g5phYPsFdbNbViKAxDm1tnG37rF/a0NHPWlnCwyUR0/2G6HgGlQ
         5Y5UaiI6jYICgizegSXDN6R/1ig7GXZAJANzF1S2NgarF/11OQ6ua+NIDPoAR+dAW2hD
         mTiE3JvT8rFj1FHqUZItgFRsFx9uT/voLvQX7qYyQa60MjZTAuMZtpc3A6TUpzLeoY0Z
         UhnS7zYCe7lz9YvrxnPzB5dKQ7SsK3q2j8hOfylVUpJ2MeufGUbSVuP8DhM0bCFsNk7e
         dvTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711657482; x=1712262282;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OSBQzFqQufqwBm+U4G6XPdH75Rro6F7rWhWjrRhCESc=;
        b=lI8ZqGKWCPC/PQnVT7Li52/H1rI26hfbkKpbWdjWNj6OZmZNxOrmokZwMIbUR49kiu
         /Km1zxQKDqcfHqRAN30PnmCr3dAtDTY9DwJ8Ab+Yv6I1utcU57bsXh2rrIH0r64MF648
         7y/JH0IdyEtn1zDB/mmltU1RNKZho3U2ByzEJcPdrnDttP/erR9Boe15yV/sECT28yWq
         FZKIWNL1655fAbcdlODBXQt8WWDZdR3tFaCT0Nmvf5w6TSSQ27kFf26hJmU9SHOvNwqZ
         Ad/FljIGj2c/CPADM1CDWvHmUTyM0k8JBndCJOzBYujeMd6YRO7PqdmGY4J0wkQA+zjm
         dAmQ==
X-Forwarded-Encrypted: i=1; AJvYcCX5ZYi5SrRqSEhTgvuE5J7yjjYph3E1icgTPQvtGyFH+2liiTB9Wu9AXNQV6/M5E9ak9TNdcpCXSm0nmL4tFB8lJF5VabfwaVeh/m01lRvB+CrerGoexnTMzBuzSG4d6V1HxbWLSuQGRDIgdfYRXxb1UUNpVjhHZKuhFt2M260CRWllXDfQkPTK
X-Gm-Message-State: AOJu0Yypyiy0Vbp/c6l0DXQiYUft/zxbDE1ylBXEc+ZYKNme8tde6wgm
	LyjRdl+9YcBFtb0mXnr3b9ckqoI2V/Kr7tjZRp5ItFRVBtrTs3p9iufR5EjV
X-Google-Smtp-Source: AGHT+IEYm311DmU2l4RYrADp6NKGy1vTeD+bo97fMWmOcok6ACRQLIIZgeJAuM+ZhBOnrLw6hHfubA==
X-Received: by 2002:a17:902:dacd:b0:1dc:7bc:d025 with SMTP id q13-20020a170902dacd00b001dc07bcd025mr770219plx.4.1711657481885;
        Thu, 28 Mar 2024 13:24:41 -0700 (PDT)
Received: from google.com ([2620:15c:9d:2:493e:82a3:49f9:d88])
        by smtp.gmail.com with ESMTPSA id c3-20020a170903234300b001db594c9d17sm2051032plh.254.2024.03.28.13.24.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Mar 2024 13:24:41 -0700 (PDT)
Date: Thu, 28 Mar 2024 13:24:38 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Fenglin Wu <quic_fenglinw@quicinc.com>
Cc: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
	krzysztof.kozlowski+dt@linaro.org, robh+dt@kernel.org,
	agross@kernel.org, andersson@kernel.org,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	linux-input@vger.kernel.org, quic_collinsd@quicinc.com,
	quic_subbaram@quicinc.com, quic_kamalw@quicinc.com,
	jestar@qti.qualcomm.com, Luca Weiss <luca.weiss@fairphone.com>
Subject: Re: [RESEND PATCH v6 3/3] input: pm8xxx-vibrator: add new SPMI
 vibrator support
Message-ID: <ZgXSBiQcBEbwF060@google.com>
References: <20230922083801.3056724-1-quic_fenglinw@quicinc.com>
 <20230922083801.3056724-4-quic_fenglinw@quicinc.com>
 <CAA8EJpoW8DJOTVHBu9_+BQs5DtxyJu3xrCfDNyYHn2MeHZHV4w@mail.gmail.com>
 <12887370-0ada-359b-8a4f-18a28495c69a@quicinc.com>
 <ZRhKAWYBLcBZHc73@google.com>
 <98c668b6-7595-2c0a-ebe5-2f729d29b618@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <98c668b6-7595-2c0a-ebe5-2f729d29b618@quicinc.com>

Hi Fenglin,

On Thu, Mar 28, 2024 at 02:52:32PM +0800, Fenglin Wu wrote:
> 
> 
> On 2023/10/1 0:17, Dmitry Torokhov wrote:
> > On Mon, Sep 25, 2023 at 10:54:45AM +0800, Fenglin Wu wrote:
> > > 
> > > 
> > > On 9/24/2023 3:07 AM, Dmitry Baryshkov wrote:
> > > > > +
> > > > > +       switch (vib->data->hw_type) {
> > > > > +       case SSBI_VIB:
> > > > >                   mask = SSBI_VIB_DRV_LEVEL_MASK;
> > > > >                   shift = SSBI_VIB_DRV_SHIFT;
> > > > > +               break;
> > > > > +       case SPMI_VIB:
> > > > > +               mask = SPMI_VIB_DRV_LEVEL_MASK;
> > > > > +               shift = SPMI_VIB_DRV_SHIFT;
> > > > > +               break;
> > > > > +       case SPMI_VIB_GEN2:
> > > > > +               mask = SPMI_VIB_GEN2_DRV_MASK;
> > > > > +               shift = SPMI_VIB_GEN2_DRV_SHIFT;
> > > > > +               break;
> > > > > +       default:
> > > > > +               return -EINVAL;
> > > > Could you please move the switch to the previous patch? Then it would
> > > > be more obvious that you are just adding the SPMI_VIB_GEN2 here.
> > > > 
> > > > Other than that LGTM.
> > > 
> > > Sure, I can move the switch to the previous refactoring patch.
> > 
> > Actually, the idea of having a const "reg" or "chip", etc. structure is
> > to avoid this kind of runtime checks based on hardware type and instead
> > use common computation. I believe you need to move mask and shift into
> > the chip-specific structure and avoid defining hw_type.
> > 
> > Thanks.
> 
> Hi Dmitry,
> 
> The v7 changes have been pending for a while, I am not sure if you are still
> insist on this. As I explained, I actually did it this way in v2 and it got
> updated to this by following other comments.
> 
> Can you respond and tell me if you prefer changes similar to v2? I can
> update and push v8 by following your suggestion.
> 
> v7: https://lore.kernel.org/linux-arm-msm/20231108-pm8xxx-vibrator-v7-0-632c731d25a8@quicinc.com/
> 
> v2: https://lore.kernel.org/linux-arm-msm/20230718062639.2339589-3-quic_fenglinw@quicinc.com/

Yes, I believe what you had in v2 was better, and Dmitry Baryshkov's
comments on v2 were also great.

You can have 2 styles of code - you have a hw type for each regulator
and then use it to do conditional logic in the code. If you do it this
way you and you need to add a new device type or model you have to go
through the code and validate all the checks. Or you could have a
structure that is defined flexibly enough to cover all existing
permutations, and you rely on the data in it to control the behavior.
You should not mix the 2 styles, as this just makes the code more
confusing.

Thanks.

-- 
Dmitry

