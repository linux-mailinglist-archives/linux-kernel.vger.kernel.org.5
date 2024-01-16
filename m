Return-Path: <linux-kernel+bounces-27306-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EED1F82ED92
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 12:20:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8DC631F2403C
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 11:20:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 771B41B800;
	Tue, 16 Jan 2024 11:19:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fooishbar-org.20230601.gappssmtp.com header.i=@fooishbar-org.20230601.gappssmtp.com header.b="gjsim0FY"
Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C865D1B7F2
	for <linux-kernel@vger.kernel.org>; Tue, 16 Jan 2024 11:19:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fooishbar.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=fooishbar.org
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-68163449a36so7458946d6.2
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jan 2024 03:19:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fooishbar-org.20230601.gappssmtp.com; s=20230601; t=1705403995; x=1706008795; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AS3BBwgYanBUfBnpxKNvwfAfy1OJUBRnEQmNzkGmJ1s=;
        b=gjsim0FYVMmsd8h+YQnmuNSxBe/ctN/yFIrmCCcGbbHx/pE1NBXWrCn8NOgMwGhvf0
         1uDfbfreAJgJFbWf7QmIMsgmgp9cZ0cCF60GeUNTK0ZyjSfbqdKpy+S8HSVcnVMn4DnL
         fu5IzAnUaWndoh0R39lOYmvgd4x1RqJEZZa6Va8Ew5FL1W0D2eQf41sBITLaI1JjJ94N
         3COar4ZwSLn8NOTb8EgnFs30JcjuEQBJYHH8lcylij5Awov+N9j4aVI2RGzV4cyyW56W
         E0C9L+kl2+TXQJtvkLF+t3Rf5Jn4XHdobIYY2UArJOuHw4Z5AqClG7lB2D6B5Esi/hdg
         w/0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705403995; x=1706008795;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AS3BBwgYanBUfBnpxKNvwfAfy1OJUBRnEQmNzkGmJ1s=;
        b=dK+7CoZ7XPfrJyTAhUqICj96syggep1pIcss/hnWmX19alsmL+uLhGMjqNlOk8aERT
         0m6RgQUpOh9eFu6wYvGAmVwEsjg+j5UeeHuiMtpFLfJ/YxKqstgu8T7sbth8Bp/xzFjy
         FkwnSyNK8hf/MvCHJk+x+lw/A86TSfC47j4dbMAl9eaOtgYUsmfWhNGq6YQyguwPTtwu
         CLd+bWbAN1jH2/qhBDbjjEn00HJHv+XDzdHrwzygeXOwe8n9rgEMwygWiR7dJpv18Rc0
         kjQbbBsoUBNWYr0umKHn/RQfjVdEbxdf+ObgWAXokltQraChRsaUZ/garFnQ1mWJcFFF
         l1Aw==
X-Gm-Message-State: AOJu0YySQJwiGvRvZaWnF1Q0BAS8FDw5YYAc8CdVhK8dzeZ+XVZ/Rf5V
	MiOSDVUVivss3f8tZaO20H4MDRkzt2c/2FdL+e886b/6I9JHrg==
X-Google-Smtp-Source: AGHT+IFrGX+QlGcwiMcvFXBVyO7eiX4wVISfsMNIemyKgmDmI8h7UYeLiWdxotNRUa1oCcK60IlwlDmzM+TIfP+BjPM=
X-Received: by 2002:a05:6214:31a1:b0:681:562a:16e1 with SMTP id
 lb33-20020a05621431a100b00681562a16e1mr4955020qvb.102.1705403995478; Tue, 16
 Jan 2024 03:19:55 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240116095439.107324-1-vignesh.raman@collabora.com> <20240116095439.107324-3-vignesh.raman@collabora.com>
In-Reply-To: <20240116095439.107324-3-vignesh.raman@collabora.com>
From: Daniel Stone <daniel@fooishbar.org>
Date: Tue, 16 Jan 2024 11:19:44 +0000
Message-ID: <CAPj87rNKLPETVGzpXaZtQwVGauH2V-fCuFGN4zrOE0nH2R+F+Q@mail.gmail.com>
Subject: Re: [PATCH v2 2/7] drm/ci: mediatek: Rename exisitng job
To: dri-devel <dri-devel@lists.freedesktop.org>, 
	Helen Koike <helen.koike@collabora.com>, Dave Airlie <airlied@gmail.com>, 
	Sima Vetter <daniel@ffwll.ch>, David Heidelberg <david.heidelberg@collabora.com>, 
	guilherme.gallo@collabora.com, sergi.blanch.torne@collabora.com, 
	linux-mediatek@lists.infradead.org, 
	linux-rockchip <linux-rockchip@lists.infradead.org>, linux-amlogic@lists.infradead.org, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hi Vignesh,

On Tue, 16 Jan 2024 at 09:55, Vignesh Raman <vignesh.raman@collabora.com> wrote:
> Rename the name of xfail files for mediatek (mt8173 and mt8183),
> to include information about the tested driver and update xfails
> accordingly. Since the correct driver name is passed from the job to
> test gpu and display driver, remove the check to set IGT_FORCE_DRIVER
> based on driver name.

I think something is still wrong here, because I can see that later
xfails updates are setting expectations on kms tests when we're
supposed to be using the panfrost driver. I can't tell which branch
was used to run this, but you definitely want to look closely at the
job logs and results to find out what's going on here.

Cheers,
Daniel

