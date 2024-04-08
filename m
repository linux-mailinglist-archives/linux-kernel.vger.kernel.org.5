Return-Path: <linux-kernel+bounces-135105-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 99BEB89BB39
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 11:07:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D0BC4B22FFA
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 09:07:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F04B4A9BF;
	Mon,  8 Apr 2024 09:07:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="neLQpJu1"
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E40D48792
	for <linux-kernel@vger.kernel.org>; Mon,  8 Apr 2024 09:07:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712567258; cv=none; b=tjECqmRD4xak2eHYkHhop/vxaeu6gDwUPBpZH59ImiLQ5wfLwpp+bOegPC/yXVEF/Q0VEe9TCtHu2eiZZBW7Ol86JFT7BB5pmZrUmDP3heWRw8frNFP0QZBhwJTZjZwW0Ca5laARw9BFQAr4UAWM3qOUzzEc4HDYkOpFVr3mHHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712567258; c=relaxed/simple;
	bh=tk/FMXk9/BxJnMNCpZbjrtftVzviHOWK1p4pvZ7JEcs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QZUmTvt+/pfbgyXokQqIag4T+xfINmsJbLPbseKo0zXAIIHKPdjbX3kW2eGpC0guwJFIsxBJpagN/clDDok2brZ7MTC8PJQ9oBiFYp+P1n/6H6sC32six0/4nlw5AN8cwoyeOESEzAwGmqo2hl6Oy5ZwDBqr35lbCd6EbldvPwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=neLQpJu1; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-61814e68cfcso4123607b3.0
        for <linux-kernel@vger.kernel.org>; Mon, 08 Apr 2024 02:07:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1712567256; x=1713172056; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tk/FMXk9/BxJnMNCpZbjrtftVzviHOWK1p4pvZ7JEcs=;
        b=neLQpJu1ltJQSpt2HIz2fVulRGgAM0rv/Q0y2eAlFnvd6rO6WuAcAiAq1qoFjVytH6
         YRk1BHZZLviSVQZfWLa7hiw/7sccY+wlzeS83PuCTETaCgS1CV8nGCs3T9/LaGx+Wi8F
         d5VoEt7yZj3FvYQBkdJdC0bpBx4EVIqNPX3GmmW9oqOnassdlKHS6jqS5E/Kg+npaFLh
         AETBk+NaQdU32VqUM5AcpZ7CkRuw65XV5220NpEdLq1c+Y4Lm7uqD6gGSM9MVn57dcR1
         q60kBGur4VgFBWzgLi3EGi7F0L7UjhXK+ijSIFppOxoqtq3+n54A7w5eeYdwgl9ChJub
         NKtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712567256; x=1713172056;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tk/FMXk9/BxJnMNCpZbjrtftVzviHOWK1p4pvZ7JEcs=;
        b=dKBCfPFmu0LVhLod5oQkCMK4EyosLqmbd+3LBHHSH409LA1NMA6r3W/sRrfWS+pVb9
         iLwMxMdjdIJO4y4rTd3CEFBsPmlpMt2JqiwXHg6bz4BqJjnKswsxDh1Lspnje9klP46r
         UXeURs9QJMNveuKwPLYmWWGnZYWjMgNn5puniKVaC4Cauv2cWBaGvOy3JCvhxL1HgW40
         IZ64FYt8COZSsdocLgwlNnTe8pfl75BkAeR7J63mwAQKSN3m/gMPP+9RGXzYAI8ayffn
         DVCXNzb+krDNikA4UKdrq9tRH6I9RyOjO5lUyrq15zxnVj5ahS6qT49Hpj/aOp+O26hA
         wmWA==
X-Gm-Message-State: AOJu0YzQc7tI90YJt1kitxkdyVHoEuLib8PtGIfSAWouiwbl5Cl4YrKY
	R/IaSL+Pec7AViXhuE6Rz0jfzoRbUwcsdFtbG4Xx4lLG9pJPLCXvJq/uoYKgepsEmEQtwaZ050r
	L03Udfo6hssX/pKP0M8K4gyD8uEVO/Zbrn+1+QUVrtp5buFKo
X-Google-Smtp-Source: AGHT+IHc7QXzytUFxC5uuwvB0MD7ljWc/U60G9Qiq47arRNTNk1jBZh9YkNee2tiKSi0tDR8vq/XfeSFX3czfX77EaA=
X-Received: by 2002:a5b:b8f:0:b0:dc6:dd80:430e with SMTP id
 l15-20020a5b0b8f000000b00dc6dd80430emr6480600ybq.27.1712567256106; Mon, 08
 Apr 2024 02:07:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240405115318.904143-1-jens.wiklander@linaro.org> <20240405115318.904143-3-jens.wiklander@linaro.org>
In-Reply-To: <20240405115318.904143-3-jens.wiklander@linaro.org>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Mon, 8 Apr 2024 11:07:25 +0200
Message-ID: <CACRpkdYLCuRKZRqRUkav7UoT+0FSaMmciH9bps3VGgxLCw6+_g@mail.gmail.com>
Subject: Re: [PATCH v4 2/3] mmc: block: register RPMB partition with the RPMB subsystem
To: Jens Wiklander <jens.wiklander@linaro.org>
Cc: linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org, 
	op-tee@lists.trustedfirmware.org, 
	Shyam Saini <shyamsaini@linux.microsoft.com>, Ulf Hansson <ulf.hansson@linaro.org>, 
	Jerome Forissier <jerome.forissier@linaro.org>, Sumit Garg <sumit.garg@linaro.org>, 
	Ilias Apalodimas <ilias.apalodimas@linaro.org>, Bart Van Assche <bvanassche@acm.org>, 
	Randy Dunlap <rdunlap@infradead.org>, Ard Biesheuvel <ardb@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Tomas Winkler <tomas.winkler@intel.com>, 
	Alexander Usyskin <alexander.usyskin@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Jens,

On Fri, Apr 5, 2024 at 1:53=E2=80=AFPM Jens Wiklander <jens.wiklander@linar=
o.org> wrote:

> +/**
> + * struct rpmb_frame - rpmb frame as defined by specs

As Tomas said maybe we can write the name of the spec or the number or
something so users can find it?

I would also write explicitly "the stuff bytes and big-endian properties ar=
e
modeled to fit to the spec".

Yours,
Linus Walleij

