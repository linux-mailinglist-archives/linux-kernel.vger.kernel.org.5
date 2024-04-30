Return-Path: <linux-kernel+bounces-163189-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 773EC8B66F5
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 02:43:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AA925B21245
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 00:43:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A3673232;
	Tue, 30 Apr 2024 00:43:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YTtTM5sY"
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D672610E4
	for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 00:43:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714437812; cv=none; b=nwMFdvAJzpRymxTi6IyuOsDZ/E+wcXuhYRA+Q86Dxlc7Wd2Z8yAXR5QVmoyI0cn+Xp/1OjTZjMZ7zDFVur4p8cfGXDzs2hUGfQNMwQg1gbX/ycBTgopWIo0irFZI70Dn2uPK4lWTu+oxsHJGqHYelF/EHCbwFkl0LCrG/2LoRiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714437812; c=relaxed/simple;
	bh=Nl3vIVccFoXuhiVoNsPjYFj7L+CWbBMwdwLms1/tMfk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IDRyVgymutGdLQI108u/hqgFH101EtDhmeKzXwfOIugk5dGyTHk4LyF7GwbUFxpN+ChqcQ2Zr16LxfzFHcDILO7gwXdZBNeBbMY0FYRrqYVMYlxxMGsHu5ULv0ZH/mvtTln+iBY22LAcCuhxtG8ZqwxpyITRvxJb0Rd6BcaBFX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YTtTM5sY; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-5727c9b47e7so3977a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 17:43:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1714437809; x=1715042609; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Nl3vIVccFoXuhiVoNsPjYFj7L+CWbBMwdwLms1/tMfk=;
        b=YTtTM5sY/SaIpVZ1prp8+958RMMgCod35fuDBJMx3+5JoZ64JTbtVUMEGu0fhmoYKX
         RoC6GndTQ+myCIS/afsbUnjyhxREdwJ8fDXxdPn4vQ/rElD6cNjsGS+y8jERVfCnzf7D
         2r5VX8bi3GRXUyb8J8aJl9pNpmZ3sItw7T9t8iDM40TS26idoIXLCm/W6oSV5b8O78G0
         pk+2xDUPZSPZv1ehs7CTuVNNwoYkrjy5kxYWF28ZckBNHNTNhXJsLgFEny+vWD6M5c6Y
         LaHsKhtBYL10nGkSY+NQ3KWmb4t1zx4/h7Y8LC8H+GfcY5OizGRYK3hJF7up4/eXBUzK
         0rGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714437809; x=1715042609;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Nl3vIVccFoXuhiVoNsPjYFj7L+CWbBMwdwLms1/tMfk=;
        b=qWsMD44fG2K+YbxOimv344ImKGNey4BvgjtycMT3d7fdWm7MFgpoMPA0IKhvqyL091
         nbFPowDuDLUrr2EvRV7QD6Uh9geDUTmArq9GX1pAG6Eg5x+IUMnwweuAPy2SF/uA9etJ
         y9nMMIlL2AZou5RsUB6I5ySFA15Ya7bkF/JvIMfI/UZK86279B4laAkCBIUR+Suql8bQ
         Q8TjbQ9CO3239lc9mtKjGPgJpjgqYQQOyghQWvwJwMH+Kq09J5sktz1yewc+hSS6blcB
         iVvoQnSTrTDrgK9WyGi0r3zbDFLfmwxffGtW5NOT9f79zO2pN75s83LftZXy3NpOiVOS
         Q6kg==
X-Forwarded-Encrypted: i=1; AJvYcCVMXy/zjiywL7ra7/YoypkFGd4EU6jClaHutkEMLxXNAsiyUWhQBdUB18bHXbAIo/g4PhXOdM+2IqTtKtXyeC0yVexwPWZbPgvC3Rmw
X-Gm-Message-State: AOJu0YyNkob4gJp9i/eWC7mSggkJ9wzYOycBd+EB+X4otsXOfqrtMe59
	aC4I4pSiUZSbKtD3th4CriiiWOBiGfagR31H4r0u9CerEMLapP/O0ycAhrCgI0lIRvYDUSpGGtc
	3Se9NBgCjsuKV16kf+0eyCiHkcNDbSr/rwMvp
X-Google-Smtp-Source: AGHT+IGt9PUEdlFEraByU733LKE7yYh5IRg0/NQ/C1cyVJcW9jesZtQayq8ssQfHwZsnICq7HDA59pz98jE9Gf64snQ=
X-Received: by 2002:a50:ed0d:0:b0:572:3fb6:3d0c with SMTP id
 j13-20020a50ed0d000000b005723fb63d0cmr90047eds.4.1714437809040; Mon, 29 Apr
 2024 17:43:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240424014821.4154159-2-jthies@google.com> <6e028bfa-9063-42ac-b40f-cf17a81c2af2@web.de>
 <2024042547-shimmy-guileless-c7f2@gregkh>
In-Reply-To: <2024042547-shimmy-guileless-c7f2@gregkh>
From: Jameson Thies <jthies@google.com>
Date: Mon, 29 Apr 2024 17:43:16 -0700
Message-ID: <CAMFSARfOYWy0a_iZyuh9e8++xHdAYXcs2pT1_yJaJ60tHR17xQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] usb: typec: ucsi: Fix null deref in trace
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Markus Elfring <Markus.Elfring@web.de>, 
	Abhishek Pandit-Subedi <abhishekpandit@chromium.org>, linux-usb@vger.kernel.org, 
	kernel-janitors@vger.kernel.org, 
	Heikki Krogerus <heikki.krogerus@linux.intel.com>, LKML <linux-kernel@vger.kernel.org>, 
	Benson Leung <bleung@google.com>, Bjorn Andersson <andersson@kernel.org>, 
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, Fabrice Gasnier <fabrice.gasnier@foss.st.com>, 
	Hans de Goede <hdegoede@redhat.com>, Neil Armstrong <neil.armstrong@linaro.org>, 
	Prashant Malani <pmalani@chromium.org>, Rajaram Regupathy <rajaram.regupathy@intel.com>, 
	Saranya Gopal <saranya.gopal@intel.com>, 
	=?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"

Hi Dmitry,
what are your thoughts on Abhishek's comment? I think we should
attempt to register the alternate mode when CONFIG_TYPEC_DP_ALTMODE is
not enabled. It would give us a more accurate representation of the
partner in user space. I understand your point about ignoring a
potential EOPNOTSUPP response from the non-stub function. What if we
leave ucsi.c alone, and replace the stub function's null return with a
call to typec_port_register_altmode(). That would register DP altmode
as an unsupported mode when CONFIG_TYPEC_DP_ALTMODE is not enabled,
and fix the null pointer dereference. But, it won't change behavior
when CONFIG_TYPEC_DP_ALTMODE is enabled.

Hi Markus,
thanks for your feedback. I'll update the commit message to say "null
pointer dereference" when I upload a v3 series.

Thanks,
Jameson

