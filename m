Return-Path: <linux-kernel+bounces-30623-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D1F54832220
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 00:07:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8BC3A1F23526
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 23:07:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95A6B1DFFA;
	Thu, 18 Jan 2024 23:07:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zly86cSh"
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96C1B28E01;
	Thu, 18 Jan 2024 23:07:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705619221; cv=none; b=GHu/I0/SzV+onfWvg4rCHlHDWgiAv+d7PlhzGN0wZn4ZhmzmtjgxFa5qUfVCxqNPv1cgmRagBIqw9IqHh2B9irIY/YNruv0dDDTE99OQyEI/nLmwboTePwPenxOTPQnXJgwC0pviIZJivYdSJqEisZD7H+Wr0lBVeJmC1EbKNRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705619221; c=relaxed/simple;
	bh=C3czo7khii5HLSj5rEGnLSSs34D6Pt3jnqqN3UEI3zU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bVOISw0sesbEa/SShY/U+Wcj3qz7S6aOcEWMtO0WLuDaRn8VWct7H1+ZbMvM7bl0u2gZdALMLwyUtZ+RI8/xvmD8dSsP0Y5lMyHnrehQmx9Nj/MgiRCvicYERRsrb/1XR0scO9ddNVoErbd0Z66tmFP5VMZRaquEU29IqrgCa7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Zly86cSh; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-6da4a923b1bso208884b3a.2;
        Thu, 18 Jan 2024 15:07:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705619220; x=1706224020; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=c8f0ZMOFj6e5ONvZJKWhCCfR/uGYAf+8vGREsVvAFMM=;
        b=Zly86cShpgMt2qwzjksQe+KimTpyD6eemfA7tg9oQUzOFq8kfWl8U4eVHOe5GLPA9N
         Fr0/mlmuztchay/VY+vUqTZXvya4TVxTfwHT0kLgbhQOgAZDufqhIpM+2FxC4grM2xFR
         VZOm4gN9cyExuNX3edwzhkMnJfpeAC0gMhQCx/mEJFIsn0S+RipC8urJPsgqtgGSHdI2
         9roVv/nlS94sRH5/6rbl4QJ4Dfjm2wOLM+Z6J8x7md6Xk1OvtFZSjZ7yLwRNernkUUgi
         ulMDjKz3KnwQLOJCbmDU18LQ2SH5H1i0MyTT/g+pivbuV2bmE6h+JnTNtuQLNGiV7OtJ
         2fvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705619220; x=1706224020;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c8f0ZMOFj6e5ONvZJKWhCCfR/uGYAf+8vGREsVvAFMM=;
        b=R1Zv61TbbQXa5oEWyi6G66e5KIF+5E0hF2y7JRY0rWmk2DlM+kpoeeDiKDNmK5nsbo
         MYeZI+IS/dlhe/NXh37nx49URfMC/ucssq9Kx20JN2Qmz0dBdaK1UEH9V6KUL75bIpCR
         HscHXzoVj0JP4ic398PB6zr2kikErDK1rZTXNzfCrX3StL79RI71BLlggjHzVbNzJ7SZ
         AYmcKBGuGTeMCB7XAVRTbLDnkMCSuE4JusZ0dzKC+rPHFqBDH+Neg7saqFlZSNVJ1MlM
         02J30UDSJfkwOJisgpXxevRAcTWfGrG4cW9Yqq7M9mTetv2yDRLqqhJawtOmDcdt8wjf
         58fw==
X-Gm-Message-State: AOJu0Yy3P+Q4xF7HWWuZzkRIOvlXd14DpobwzvWMj1HpCMvcQM60se9K
	GbVCTaDS+iEx6N1YGPIGrMfE67tOez4c9UeKPLc+RWsVPywFrZzw
X-Google-Smtp-Source: AGHT+IEJ1tudrXxSISfJ6OkeSmt1gjuBMQTyvcMdQURSlaxaQ70Cu1g0KRISL+QXH+NqMAq4WDztVQ==
X-Received: by 2002:a05:6a20:4294:b0:19b:80f5:3157 with SMTP id o20-20020a056a20429400b0019b80f53157mr1516866pzj.28.1705619219909;
        Thu, 18 Jan 2024 15:06:59 -0800 (PST)
Received: from google.com ([2620:15c:9d:2:f04f:73f4:b79:a70c])
        by smtp.gmail.com with ESMTPSA id j38-20020a635526000000b005cf7c4bb938sm2102597pgb.94.2024.01.18.15.06.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jan 2024 15:06:59 -0800 (PST)
Date: Thu, 18 Jan 2024 15:06:56 -0800
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Doug Anderson <dianders@chromium.org>,
	Tylor Yang <tylor_yang@himax.corp-partner.google.com>,
	Tomasz Figa <tfiga@chromium.org>, jingyliang@chromium.org,
	poyuan_chang@himax.corp-partner.google.com, hbarnor@chromium.org,
	jikos@kernel.org, wuxy23@lenovo.com, conor+dt@kernel.org,
	luolm1@lenovo.com, robh+dt@kernel.org, devicetree@vger.kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	poyu_hung@himax.corp-partner.google.com,
	linux-kernel@vger.kernel.org, linux-input@vger.kernel.org,
	benjamin.tissoires@redhat.com
Subject: Re: [PATCH v3 0/4] HID: touchscreen: add himax hid-over-spi driver
Message-ID: <ZamvEAGGiDrQvmFq@google.com>
References: <20231017091900.801989-1-tylor_yang@himax.corp-partner.google.com>
 <6c7d9c92-7616-4fad-806e-44302c33b63c@linaro.org>
 <CAD=FV=X2kZcyeyK1SBcXaViBft4F6XYtA6+JwBqJswU41V9kUQ@mail.gmail.com>
 <9e1233ce-1a6d-443d-873e-6efb3ed0207c@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9e1233ce-1a6d-443d-873e-6efb3ed0207c@linaro.org>

On Wed, Oct 18, 2023 at 08:07:32AM +0200, Krzysztof Kozlowski wrote:
> On 17/10/2023 23:41, Doug Anderson wrote:
> > 
> > 3. The ChromeOS team is organized much more like the upstream
> > community than a big hierarchical corporation. Just as it's not easy
> > for you to control the behavior of other maintainers, it is not
> > trivial for one person on the team to control what others on the team
> > will do. We could make an attempt to institute rules like "all patches
> > must go through internal review before being posted", but as per #2 I
> > don't think this is a good idea. The ChromeOS team has even less
> > control over what our partners may or may not do. In general it is
> > always a struggle to get partners to even start working upstream and
> > IMO it's a win when I see a partner post a patch. We should certainly
> > help partners be successful here, but the right way to do that is by
> > offering them support.
> 
> I don't know who is exactly core team, who is partner. I see
> "google.com" domain, so Google folks are responsible for not wasting
> time of the community. If Google disagrees, please change the domain so
> I will understand that and not feel like Google wants to use us all.

I think it might help if you think of <company>.corp-partner.google.com
addresses as gmail.com addresses. People who are using these addresses
are not employees of Google nor contractors for Google; they work for
their respective <company>.

The main reason person@<company>.corp-partner.google.com addresses are
being used for mainline submissions is because it is actually possible
to set up "git send-email" with them, as their main domain typically
handled by Exchange and mandates Outlook.

Thanks.

-- 
Dmitry

