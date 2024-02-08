Return-Path: <linux-kernel+bounces-58110-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E82884E161
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 14:06:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 516141C28E70
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 13:06:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 538B4763F9;
	Thu,  8 Feb 2024 13:05:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LNt0guO+"
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E402A763E7
	for <linux-kernel@vger.kernel.org>; Thu,  8 Feb 2024 13:05:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707397536; cv=none; b=dHzdHIMVMexJmEDC4/Yxhay65HEiWrD/7Ox8e6lw90BuFl1Oq6CFRSiSvF06rIJ9WFCyIsUmVSiE0j5wOW8IlpITqixN9+Tx1j+H9hvR9bfiouP33+csMvqCiRDwhwXdOiqtD1N7aKfpL+AVi9KEhT4owUrTU/NruW5PqmHrvDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707397536; c=relaxed/simple;
	bh=OOm3KwQlSkpx/aQ0RD1Q/n3/Iu+q+deGUZmDwakoQcE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pzPM3Njj0uesk+iYAOVGDrO5RV6dSpO61q4w9ydBB3pCydWEWfPoPcZj4GcYfVsFmTDNhnIwF14yeBHpR+xvnT0PhdIGQ6zfAXBccqfusjZASm+Z89CRVEjHD/uqfcbDxWQUlC2gvpqJ3+k0wzhPPLyNv4hfS8iyqG7sk/coKog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=LNt0guO+; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-60492a2593fso17289797b3.2
        for <linux-kernel@vger.kernel.org>; Thu, 08 Feb 2024 05:05:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707397534; x=1708002334; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=yaonEZUtkmkL4+4T+nM7QfSGszePSMsGy31jLocXPig=;
        b=LNt0guO+zv8N1hp1QGPKyIX2TOshE8/9Sz7v+1IQDLCx1F9j1tv33TSSgeyxeWUVgl
         ak3B2gzAKOeK8z5JlQvUxng39OusDMd/IN7Lz7yr+1v6D3bysAZ81xZlMGA2MG2kCktR
         lvqeHM2zia7I0/PloRbzLKN/tFbawD1wO3OtjnVH/Unv6PaUWIk7ho6qrBxiVcLRscMI
         +mkSsx1d/VPAhrGk79dDhfAgiclb6BTAsMx2UdT9AkQiad+bZneN1TJweJDgilTXFfAc
         FTypQZj6pvj5YXamY/Q+hX2YX317WoMZh8g7Ni9zVGABCP0k822JWFlmpla8fCzTVfl9
         qnVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707397534; x=1708002334;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yaonEZUtkmkL4+4T+nM7QfSGszePSMsGy31jLocXPig=;
        b=gW1o4gMwpSdisv4ViIgSrzA34xuqeTghX5yyOWGakHvkpKu53wdx1IBn2H8W1OEIrB
         muhhvYdYrxsnO5qGKvXTfd2ZnQFLNlTgvAF/13PimB/CpxqcFL4wePajCL/iJNkZTXCr
         lhn2JxPUKiHUUout6YpnJhpMYdNJGTM5ZkbkMeNCwOuQqVByDb0sNSwWgjQs2X7lENNC
         dt7S55oMURn8dZiBmNGst8zefWGG2Ey8v3B593UM2zMLVkPSmvjzpbY+4EeESrR1cpPf
         jh6aYNDloUQkkUK1P4d0faR04VnZIKHl2jyFpPNTzD64XXiaY0aVypZQwnJLHoYrq+sZ
         gLjg==
X-Gm-Message-State: AOJu0Yxd2NPN8lDMDGNs4EkEfjNIfnQzgzbL0KV1GxoFZUbJjTR1/FwC
	vhgXyI70Hlyk/FbC3lB3JfoVjiKajAa2z4nu0ZYKdAXdcPSOWR+5ZYdBD4+bpqbf4t40py8MOYM
	aYTmn874MmQWAkRJw8Jxn+BKZjb7jQYWgNSm3L9ExsQb119RL
X-Google-Smtp-Source: AGHT+IGfphzyQv/EWtNvXSUhZkKTokLhrAXhw2QIgrex5Lkm5/2iiFvKEz8iowkI5t4PsE48NVTAvoH79ulzgHlzIPY=
X-Received: by 2002:a0d:c545:0:b0:604:71b3:2021 with SMTP id
 h66-20020a0dc545000000b0060471b32021mr8488916ywd.3.1707397533831; Thu, 08 Feb
 2024 05:05:33 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240130-pmi632-typec-v3-0-b05fe44f0a51@linaro.org>
 <20240130-pmi632-typec-v3-3-b05fe44f0a51@linaro.org> <CAA8EJpqhfWsmUxwmBLtdtx-aFOmTo24erdNfRyz2ymi_y=yidw@mail.gmail.com>
 <ZcTA5hbcladmKuLh@kuha.fi.intel.com>
In-Reply-To: <ZcTA5hbcladmKuLh@kuha.fi.intel.com>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Thu, 8 Feb 2024 15:05:22 +0200
Message-ID: <CAA8EJpqf_iQz5JWwEsZmUOV=VSY5y_RrO6JqEztr9Q2Fc2J-FA@mail.gmail.com>
Subject: Re: [PATCH v3 3/6] usb: typec: qcom-pmic-typec: add support for
 PMI632 PMIC
To: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc: Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konrad.dybcio@linaro.org>, 
	Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
	Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Wesley Cheng <quic_wcheng@quicinc.com>, "Bryan O'Donoghue" <bryan.odonoghue@linaro.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Guenter Roeck <linux@roeck-us.net>, 
	linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-usb@vger.kernel.org, 
	Luca Weiss <luca.weiss@fairphone.com>
Content-Type: text/plain; charset="UTF-8"

On Thu, 8 Feb 2024 at 13:54, Heikki Krogerus
<heikki.krogerus@linux.intel.com> wrote:
>
> On Wed, Feb 07, 2024 at 11:54:50AM +0200, Dmitry Baryshkov wrote:
> > On Tue, 30 Jan 2024 at 21:33, Dmitry Baryshkov
> > <dmitry.baryshkov@linaro.org> wrote:
> > >
> > > The PMI632 PMIC support Type-C port handling, but lacks USB
> > > PowerDelivery support. The TCPM requires all callbacks to be provided
> > > by the implementation. Implement a special, 'stub' Qcom PD PHY
> > > implementation to enable the PMI632 support.
> > >
> > > Acked-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
> > > Acked-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> > > Tested-by: Luca Weiss <luca.weiss@fairphone.com> # sdm632-fairphone-fp3
> > > Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> >
> > Heikki, Gunter, Gret, is there anything left on my side to get these patches in?
>
> Nothing from me. Do you want Greg to pick these?

Yes, please.

-- 
With best wishes
Dmitry

