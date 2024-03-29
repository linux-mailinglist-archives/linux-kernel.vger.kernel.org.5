Return-Path: <linux-kernel+bounces-125327-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A20F892428
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 20:26:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3A2ED1F22E4B
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 19:26:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22EB2139566;
	Fri, 29 Mar 2024 19:26:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="lq2kW5M2"
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D34C0137776
	for <linux-kernel@vger.kernel.org>; Fri, 29 Mar 2024 19:26:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711740375; cv=none; b=XWosXqlP6yQLtPm0ZLkX5+zpSyk8YWoi1PBOWA7Rr+gBOqiJr+30XdgacyXkd2UWi/7nQfJkbLHpbD1RWhkAuBlLvlPp9y1wazeO6nQKkaTC4YvSW5GJeUyFp144Ch4Zo+hoHkVYRXBBQZc4wVVKYVI/GfP9VC4L3uy2RDFaezY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711740375; c=relaxed/simple;
	bh=hoYjB7YSRShpPWgdE1wwf5DcAbSCNkXBSttP8G1VXf8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=P+xjD+8Vq90Wa140ZYB7/bcZo06OVfvGZ3BXevNYJfR1AlydhV3K1NJR0wN6oki8dh5ZUmG28ep1RN0R5SWmkQC6G3HJMX9yd6EagWq6UgQPMG/g60iiVQVTEbvR4OH89y/aeqTmHLc/+fDamcfgTN15OOEh1eipgMbBAhuu6Y8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=lq2kW5M2; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2d718ee7344so11693531fa.2
        for <linux-kernel@vger.kernel.org>; Fri, 29 Mar 2024 12:26:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1711740372; x=1712345172; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=hoYjB7YSRShpPWgdE1wwf5DcAbSCNkXBSttP8G1VXf8=;
        b=lq2kW5M2tPHd/rGeX5nCURbHyfpH3lU+71+j3ej8fBjLmaMm8XOS9RzBShsO5bL4ig
         HMkWojg+8j8/rE02ReuF05A1SQArQwA6iRO2o7YBk2QTp/WLKsb5OlswM3TaiwLsaEG9
         BWUaOdkvfaK0oOXrKKGoFzfAKpT/+zyEOt/ApJIyLEntrgkDA+ApDOd94qHSS97Ax1Zs
         LyOeLCZQz9pDHQNEM7wYEEhA73Tdm6aKrEBhXX6Aik8peh3VrdPV04XVnk1E/+9WVKC3
         mEXgxe/s+Rnn1EhHRI4LhArhkkbpSddvHqqo8yLRFBZqWFxO/DP1TOhiA0E4Gzd3DOV1
         VDsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711740372; x=1712345172;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hoYjB7YSRShpPWgdE1wwf5DcAbSCNkXBSttP8G1VXf8=;
        b=l6SauweiawmBDU3ymE/S0vNYvDAr8Tn+lgNjd9xR/jjkz1a3jTqAzXQOfutJRHujwi
         Vp+lHKZcUzKbG5xR27rWiKAtuPJcOW1bN6r16Kpbc1uv5gfXnVanIwvRl3F6Wk0RS09T
         CYvsi2EV0H/0jd1vHTVnatfwsQUGB0WQUV+dVgvXyjvm4gzVBVl3rlA88PQ7a0wrQnLg
         iq2WrqRwOP+LSnJrZwD0f/z4OGfhgInhK22bpcvQ2zEuMhXiUEH+x9Cq2Jeu8M0Fgkx+
         BsOUiwlJjphpgkjuw042xBZoMv8/xBU1Iin3bR5FrgGvYQj20gIBo7tJDnTgF6x6f+Eh
         jVfQ==
X-Forwarded-Encrypted: i=1; AJvYcCWx/clckbBqJukbhMwrVYEKaZRvgPyPeT8zhJxmJ+DsxSvk6J2sPINUDUJLDfS79Tbih03qROVsq+uTraFGBylotvDLQd8EtLTR7/jP
X-Gm-Message-State: AOJu0YzdPlE+V0ZVWxeqcSGM9dIBtp75xQdp9RBJUj2/xl9wcXrrbn8D
	5z95ehvgbOzvVC6pccFg1qAjbuTxxzE5N7ciP6P/z5AC24IR7HKtp4Hz4djGVfuSslmJt7Y00SZ
	c1vrU/EIlhIzPKEm6ZIvMdIgjogi8eekPOOPl1w==
X-Google-Smtp-Source: AGHT+IEKTm1ECiREoWMldD4G+mpZjxYq2T+rkAxjdHRhz9OpUeLw+CE2waBSUT1msxnEa67+YljQwqpFuoVd8g2ibs0=
X-Received: by 2002:a2e:8610:0:b0:2d4:3d86:54e2 with SMTP id
 a16-20020a2e8610000000b002d43d8654e2mr1950517lji.27.1711740372087; Fri, 29
 Mar 2024 12:26:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240325100359.17001-1-brgl@bgdev.pl> <56e1c63a-4c09-4d92-9ef2-aad5390879cc@gmail.com>
 <CAMRc=Mf_pvrh2VMfTVE-ZTypyO010p=to-cd8Q745DzSDXLGFw@mail.gmail.com>
 <CAMRc=MfsVWcoMC-dB-fdxy332h-ucUPTfEUMAnCt5L-q3zJxWg@mail.gmail.com>
 <82f94b54-82d1-49b9-badf-63d948b347fc@gmail.com> <97e1f121-9e84-4e63-9c9c-57e2de0b29d7@gmail.com>
 <CAMRc=McLJFGcy-A6PZNmjgDXnvx8z0J4k-Dbak-txvWnycHG2A@mail.gmail.com> <2b1dc031-d645-494c-9103-a2bb422ea60b@gmail.com>
In-Reply-To: <2b1dc031-d645-494c-9103-a2bb422ea60b@gmail.com>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Fri, 29 Mar 2024 20:26:01 +0100
Message-ID: <CAMRc=MdoSPuedbGhy4toDEkw0vSzESDz2bXGpyt_=R4hqXW+Uw@mail.gmail.com>
Subject: Re: [PATCH v9 00/13] firmware: qcom: qseecom: convert to using the TZ allocator
To: Maximilian Luz <luzmaximilian@gmail.com>
Cc: Andy Gross <agross@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konrad.dybcio@linaro.org>, Elliot Berman <quic_eberman@quicinc.com>, 
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, 
	Guru Das Srinagesh <quic_gurus@quicinc.com>, Andrew Halaney <ahalaney@redhat.com>, 
	Alex Elder <elder@linaro.org>, Srini Kandagatla <srinivas.kandagatla@linaro.org>, 
	Arnd Bergmann <arnd@arndb.de>, linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, kernel@quicinc.com, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"

On Fri, 29 Mar 2024 at 20:22, Maximilian Luz <luzmaximilian@gmail.com> wrote:
>
> On 3/29/24 8:07 PM, Bartosz Golaszewski wrote:
> >
> > Both with and without SHM bridge?
>
> With CONFIG_QCOM_TZMEM_MODE_GENERIC=y (and the upcoming fix) everything
> works. With CONFIG_QCOM_TZMEM_MODE_SHMBRIDGE=y things unfortunately
> still get stuck at boot (regardless of the fix). I think that's
> happening even before anything efivar related should come up.
>

This is on X13s? I will get one in 3 weeks. Can you get the bootlog
somehow? Does the laptop have any serial console?

Bart

