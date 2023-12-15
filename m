Return-Path: <linux-kernel+bounces-1649-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 14F56815183
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 22:02:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CE3DE28631B
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 21:02:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 583C647793;
	Fri, 15 Dec 2023 21:02:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="MGySH0OO"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EC9447772
	for <linux-kernel@vger.kernel.org>; Fri, 15 Dec 2023 21:02:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-5e266e8d39eso10385147b3.1
        for <linux-kernel@vger.kernel.org>; Fri, 15 Dec 2023 13:02:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1702674135; x=1703278935; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=MTDZCEFmSpT07ZfLz7vZkizeT1MqLax9S/t8QTl1d0Y=;
        b=MGySH0OOMUNqrEQTGPCH+XoWVEmJdxkS8rLTZ6L2p/hOhN1bwyZqChJfpZhdJZ7s/H
         3LY8bpnXViu521lOEVFvQWnN1sllD7upoTCwM+DYbmtz6I1W08RraW6y4rJg0wdtyjWF
         bKv5+HcBa5OtL+9c027CsEh7ijhbO09o5QhSc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702674135; x=1703278935;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MTDZCEFmSpT07ZfLz7vZkizeT1MqLax9S/t8QTl1d0Y=;
        b=YFX7znyomS8SAPR8qmQ0VV1+l8WfOf+/l9AvXhLV5vgYZ34YypCTDim7X7Az2IhLhe
         9LzK0QjhvtvbGDi81EztjXnSdA5jZKhx5WGJ0ZjlEVCeKyPwVL9DLVMzCioD/jn9pPr0
         ZbpeqHiBnva5tz8rF06mmWB+/o2yTca1tXjFzdhSuSqHitqIXfo+Mf3L8kvsPGTSv0KI
         7CNx1c3xP7YPu6PzM3VAYGCUbs0DGhKC0OGHyH1DbU0+ue/hIYUNp1cCsAF8zJb3SFYi
         i+cyFTrhGSKJ69Gq/QX2PAJ2qhe0hKMlNPcecr4YJIgMX/4rA/JGsDycEUo3D8xuNNYS
         7W9g==
X-Gm-Message-State: AOJu0YyKG4tmdwshYV9zPijs3wtdR47TlWLxiV7CLit/GY9gDh6VMVOp
	5fUlK9wCmNC8OO8Agr1QOiXl9ZxUhTrkxGmSD10ORA==
X-Google-Smtp-Source: AGHT+IHG2yNMC71GN34CM/K6BzT74ojShGEa/vHULoEqCZj+Bn5WMfiAAqFWcB/K1Avy+6c5B8HyegKE+eg87hEaAPQ=
X-Received: by 2002:a0d:c482:0:b0:5d7:1941:2c3c with SMTP id
 g124-20020a0dc482000000b005d719412c3cmr8885843ywd.105.1702674135254; Fri, 15
 Dec 2023 13:02:15 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231213110009.v1.1.Ifd0903f1c351e84376d71dbdadbd43931197f5ea@changeid>
 <20231213110009.v1.6.Ieee574a0e94fbaae01fd6883ffe2ceeb98d7df28@changeid> <ZXpx9esFooSgq11q@google.com>
In-Reply-To: <ZXpx9esFooSgq11q@google.com>
From: Mark Hasemeyer <markhas@chromium.org>
Date: Fri, 15 Dec 2023 14:02:04 -0700
Message-ID: <CANg-bXApLtwuk+B3=F4b0M_xJ06x6kn2Owbb0RC6Rdpcma4_Ow@mail.gmail.com>
Subject: Re: [PATCH v1 6/6] platform/chrome: cros_ec: Use PM subsystem to
 manage wakeirq
To: Tzung-Bi Shih <tzungbi@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Raul Rangel <rrangel@chromium.org>, 
	Benson Leung <bleung@chromium.org>, Bhanu Prakash Maiya <bhanumaiya@chromium.org>, 
	Chen-Yu Tsai <wenst@chromium.org>, Guenter Roeck <groeck@chromium.org>, 
	Prashant Malani <pmalani@chromium.org>, Rob Barnes <robbarnes@google.com>, 
	chrome-platform@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

> It looks to me the patch combines multiple changes.  Please separate them into
> smaller pieces for reviewing easier.

Unfortunately, I don't see an easy way to break up this commit without
breaking EC wake functionality along the way.

> Another confusing about the patch subject: "6/6"?  Is it a series?  I don't
> see the cover letter.

Sorry about that! I'll make sure to add a cover letter and CC you on
the next series version.

