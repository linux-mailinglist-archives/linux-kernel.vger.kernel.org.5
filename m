Return-Path: <linux-kernel+bounces-21692-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A62428292D5
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 04:44:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 039A1B238E5
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 03:44:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58F904A3E;
	Wed, 10 Jan 2024 03:44:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="JB96nfXx"
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D22363C32
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jan 2024 03:44:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-oo1-f69.google.com (mail-oo1-f69.google.com [209.85.161.69])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 7045E3F2C5
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jan 2024 03:44:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1704858253;
	bh=pLgcyTZenokYx0uGkUKde9DGt3BHdUFOCmdzdzfj8Zs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type;
	b=JB96nfXxcu3WdHAzoWp0Puat/DIC8YgfFA4e41kKDPBDc3vvQS8PS2OfoQbizRvyp
	 Rt0Ggj7Ya89rua1xY2NEr9sAdA2nBgRPX7+204dKkt0UlFvD0ZJYinTLUDxe4gEJQa
	 4LWfSevm2gvXUjRCpEjFeKvxk/xdjVLrBICXgeSKejia1bkddJGGFv7QM8DfOYFefI
	 SqjdW2+6DW15sv9ipbPUNBRtUoVpFRLJRK916ZXthfT47yQcF9KylGjLGjpafSqGlk
	 DoNHuaFiRWqOuLukvhyZWLbeyoCbRULx0A4V7p48S8zEmcBywDmB7AYpQnZ5OpNt0o
	 x5og6i7lrWdsQ==
Received: by mail-oo1-f69.google.com with SMTP id 006d021491bc7-594f08f3768so3619136eaf.1
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jan 2024 19:44:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704858252; x=1705463052;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pLgcyTZenokYx0uGkUKde9DGt3BHdUFOCmdzdzfj8Zs=;
        b=Nr4SDwtIS3jhcPr2lEGN8ftvMrO1lCtwo++/ComWGXVr/S655+LFiOcV5Ibf2ZOun6
         zVuDvyU29Y2cZOwhExgRYPqP3y2+MFgtPD9293ym65guOSOLOpKxqZ6qBQW9f2EJ89KY
         FTUBdbVbEbd6TsAKNcILtTpKCXkCTWriblhinSKS4jwPxhdj3eHL/sOABlv1VClKjs88
         EPsevFmGY2mNU+J+lghcnmdYs2PZcbXQdtpqZkaSplogiAdlHn79U83EvIM8omL9KDnG
         brXD8WtMS3nS72YReBdAnWsXjvsjkRU9Nqam/qeHk7JC45T5QWlHCxpSOLO8iEp1LTTV
         QvKw==
X-Gm-Message-State: AOJu0YyFHdYATiJANs+D8YLzECRhRL2f4JHVnaaezJDQwTbvsx1NdDQS
	w0BFw+hfo63Cr2Xrjd3G1T+6qmLL8bNQz4JXr17Fo0mnZhxOmLrX0J3mKcncoKvMSh3xu77SXtr
	Aa3VgXd1/sqTC/DZm8RNvw8I5+8HdY5Cm+1FCXRnp28ohp9+2OVFR35L9pU4gAgeUKjwdiBCc+Q
	o=
X-Received: by 2002:a05:6359:4c1a:b0:175:6b16:437 with SMTP id kj26-20020a0563594c1a00b001756b160437mr372160rwc.41.1704858251848;
        Tue, 09 Jan 2024 19:44:11 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHP3KLBfcLw7NKm+OUg78KN9DAiPdJNkz+1tdABIJcKUQk//5olHZgCKbLN9WY67WMLQLRq+vqwQ7ef67NbgVI=
X-Received: by 2002:a05:6359:4c1a:b0:175:6b16:437 with SMTP id
 kj26-20020a0563594c1a00b001756b160437mr372145rwc.41.1704858251500; Tue, 09
 Jan 2024 19:44:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <954f0b86-dd9e-4d84-8d67-fba7e80bc94e@5challer.de> <20240105155100.GA1861423@bhelgaas>
In-Reply-To: <20240105155100.GA1861423@bhelgaas>
From: Kai-Heng Feng <kai.heng.feng@canonical.com>
Date: Wed, 10 Jan 2024 11:43:58 +0800
Message-ID: <CAAd53p5Eg4J9bRtAHY+JZ11cy1D0TnKmAaLfzcRJzw15VRBxXw@mail.gmail.com>
Subject: Re: [Regression] [PCI/ASPM] [ASUS PN51] Reboot on resume attempt
 (bisect done; commit found)
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Michael Schaller <michael@5challer.de>, bhelgaas@google.com, linux-pci@vger.kernel.org, 
	linux-kernel@vger.kernel.org, regressions@lists.linux.dev, macro@orcam.me.uk, 
	ajayagarwal@google.com, sathyanarayanan.kuppuswamy@linux.intel.com, 
	gregkh@linuxfoundation.org, hkallweit1@gmail.com, 
	michael.a.bottini@linux.intel.com, johan+linaro@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 5, 2024 at 11:51=E2=80=AFPM Bjorn Helgaas <helgaas@kernel.org> =
wrote:
>
> On Fri, Jan 05, 2024 at 12:18:32PM +0100, Michael Schaller wrote:
> > On 05.01.24 04:25, Kai-Heng Feng wrote:
> > > Just wondering, does `echo 0 > /sys/power/pm_asysnc` help?
> >
> > Yes, `echo 0 | sudo tee /sys/power/pm_async` does indeed also result in=
 a
> > working resume. I've tested this on kernel 6.6.9 (which still has commi=
t
> > 08d0cc5f3426). I've also attached the relevant dmesg output of the
> > suspend/resume cycle in case this helps.
>
> Thanks for testing that!
>
> > Furthermore does this mean that commit 08d0cc5f3426 isn't at fault but
> > rather that we are dealing with a timing issue?
>
> PCI does have a few software timing requirements, mostly related to
> reset and power state (D0/D3cold).  ASPM has some timing parameters,
> too, but I think they're all requirements on the hardware, not on
> software.
>
> Adding an arbitrary delay anywhere shouldn't break anything, and other
> than those few required situations, it shouldn't fix anything either.

At least it means 8d0cc5f3426 isn't the culprit?

Michael, does the issue happen when iwlwifi module is not loaded? It
can be related to iwlwifi firmware.

Kai-Heng

>
> Bjorn

