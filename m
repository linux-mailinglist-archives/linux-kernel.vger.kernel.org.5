Return-Path: <linux-kernel+bounces-133341-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A66689A281
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 18:29:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3019F1F23B7D
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 16:29:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C0F9171646;
	Fri,  5 Apr 2024 16:29:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DJN+deEF"
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19D6516EC0B;
	Fri,  5 Apr 2024 16:29:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712334555; cv=none; b=Kiblnzb27tsywxs4I6HH2TJ3hvZmh+VDldowPughH16SRMviyGWY7UaCQpgZCaj7oxx3UF45NDFayeFMzUiqY1sctCKedOgOOtggGf+/vYk0lTR3pdZWHq7c48fSJNV3nGk1FFSfZjY7PJW0aKgEj3IaYS44zH9vOTdr262b+ko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712334555; c=relaxed/simple;
	bh=FFhf8u3vHAwLFDislCLMJxK1IAaYlLiIRKAQetzAuKM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=W3IL0qpPG7yuaR3S55ZHskAwdZi1AlB96bfEhC8w/vKKInVGgMCwb4n4N/bOSMV+gJiQq+B+Tynd2md6jL9dYf+Hqp1/coJiAIX2Hd6sHgTuM+eiYBctFtcYfT/omkrWcC9m03pacyV0GU27mVHWu7ERKKWenNOHL3K2D6dfVh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DJN+deEF; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-2d80baf621eso25534411fa.1;
        Fri, 05 Apr 2024 09:29:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712334552; x=1712939352; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FFhf8u3vHAwLFDislCLMJxK1IAaYlLiIRKAQetzAuKM=;
        b=DJN+deEFPbNZ7bFOlW8D1rO3bVB+Bpt/ywEPE52bPh6MftT11v3jBS6W8ecwRJvDgS
         GUGpKQCCY7bAcd74UckRXjDMX4u9d/SZqPlV5YvjfLJ9moSJVCiQT05GuaN2yZw9QL35
         q5+FkWIWDfBufuGJBazJU4dWoieFIcBH9arCnn7AHbVot7mdJazoS/qoH9kvhsatD1M0
         vxuwzqKFnxSQW6Q9ZY3vUr7FH+r68PMUaDLmv+mzrX0qiEu7vdmeiT5U/na8OfyxDWBF
         qgXqzJc3FS00S42Sx4pytjhedw3cyc9tp0OwQLH1ZuDSCUm9VrdARNNJE5dPUpV3zNWz
         WOmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712334552; x=1712939352;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FFhf8u3vHAwLFDislCLMJxK1IAaYlLiIRKAQetzAuKM=;
        b=u+WYeYSNBFY+t16WYrvfL9xXi2K7FE2VVIAmxwlpbqbjlIRKS8KH4/0UsneX5HmS31
         +ZhkWZ3nHo85DebmNL97dTv50BqW4rwsEUCcQhPmj4SQsnUALKZnw91i03utiW78WA+G
         9nPPkg/692w4MDPuQDiNfUyL5sYTpNiQgfE7ahJ32Ij2n05jbIFB3Am0BsxNIzOxX3/x
         n1jiHLOYlTS7hRcqfxt3z60vzc8waG9Gytxtvn7Q8i4nlaqVUiTGfXTYCXZq0vgfSECd
         KMRo64mNzHAmtviQ8OeOhvM/r/eqG+Kc0z9Eh4GPagKezarswSZ1uZ7PwXIk9LbBIlvF
         CYLw==
X-Forwarded-Encrypted: i=1; AJvYcCXmpxu8QYfV0GpjFTijyP7PU0YaNemy9pe6m78jvzuOL4rQ+nvx87K84NTyYxpLm9V8dAbViDchPo5xqtsbS2rs48U5FTMq+n4bNS11aYkG/ufXXJ02q+7VCQUS6n5Mfi3zvmiKQXX92Q==
X-Gm-Message-State: AOJu0YwEidXxEetvlaSmKpNzWVG5724giN4syghIXkXIKwTZ4CUFzm8b
	QXo/OZhnhKntO7NRmziK5OfqQuWK2vDw672dSn/wwQ+VNORYMz9Wv7FByOMvmpR2YgWVC+1gl7/
	TSpq4LtXooTxjvSEQg4xamZzDuJA=
X-Google-Smtp-Source: AGHT+IGXhxPWut6ckPqQGcFkjTLFe0KuMRKI0c0zhjeW67pxATn0rYPgtZMB8P8956kck0Gl2lRUAL+Q0XwZrEMsZMs=
X-Received: by 2002:a2e:b0d6:0:b0:2d8:60a4:d0d with SMTP id
 g22-20020a2eb0d6000000b002d860a40d0dmr1488430ljl.53.1712334551905; Fri, 05
 Apr 2024 09:29:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240404160649.967-1-bavishimithil@gmail.com> <78091796-fd0a-42dd-a4da-f7bed3025bf9@linaro.org>
 <CAGzNGRnuG_gLUrH1N57WvpKbpiNtFrcsG6nJcacQNJB_yMYNrA@mail.gmail.com> <ec7f77a7-2cf1-4ea6-b9c4-d4fe8a1673ab@linaro.org>
In-Reply-To: <ec7f77a7-2cf1-4ea6-b9c4-d4fe8a1673ab@linaro.org>
From: Mithil <bavishimithil@gmail.com>
Date: Fri, 5 Apr 2024 21:59:00 +0530
Message-ID: <CAGzNGRktm5gMj=bhtX2RAzcn1v5ref+nV-HV3Fct56FzAzxjWA@mail.gmail.com>
Subject: Re: [PATCH v2] dt-bindings: omap-mcpdm: Convert to DT schema
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
	Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	alsa-devel@alsa-project.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 5, 2024 at 9:27=E2=80=AFPM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> On 05/04/2024 16:48, Mithil wrote:
> > So sorry about the 2nd patch being sent as a new mail, here is a new
> > patch with the changes as suggested
> >
> >> Please use subject prefixes matching the subsystem
> > Changed the patch name to match the folder history.
>
> Nothing improved. What the history tells you?
>

Referred to "ASoC: dt-bindings: rt1015: Convert to dtschema"
Not really sure what else I should change.

> >
> >> Is it your full name?
> > Fixed it, my apologies.
> >
> >> Filename like compatible.
> > Fixed.
>
> Still not, compatible is omap4.
>

Sorry, seems like I was sending the old file again.
Will fix this.

> >
> >> Please open existing bindings and look how it is done there.
> > Changed it, is it fine now?
>
> You mean v2? I have no clue to what you are responding here, but no, v2
> did not improve much.
>

Again, could you guide me to what needs to be done?
Description for reg should be fine as this is how it is done in other
files as well.
Interrupts and hwmods use maxItems now.
Changed nodename to be generic in example as well.
Those were the suggested changes previously.

Best regards,
Mithil

