Return-Path: <linux-kernel+bounces-85916-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F2A8C86BCCB
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 01:25:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 302291C22D94
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 00:25:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37DA133CF1;
	Thu, 29 Feb 2024 00:21:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a1KchUtt"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50CB42C1B9;
	Thu, 29 Feb 2024 00:21:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709166070; cv=none; b=u+PyF/pE81Xj5ZgPgSlZLMFUQRrjFPmAiiuWivCOSgCywCZxzzEKlcVBUuUAwodYyDQjjnO0Tzblf0viqEkAn98Vno3KBgYyi/DUgaKYdptKPDNrYBqhwBBsOpjzoRRJOBsxz0/9cTVMwJPt5lpxxz6zJM7Ox71FVKPzAOR8WlM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709166070; c=relaxed/simple;
	bh=FugMgdspkT6zJhlIQC/Q4z5pFNZbmb5RDlSTLPs91lM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ae1Ll9Bz0G1ippTfyrDJsL6wDfNgStyVC6CNcVzAtm/2O/lNPZ6/OX3N0PDQwz/GMX8z2kuV3RO5YhXgKj0IGM3lKei1hpuNMOufNQytyXQypUKTP3sEQdg6q+NgWacumeCCXEAL9mBBgNaRoeUXu3GaP+jMzHtEXN2AvlIYbXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a1KchUtt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F26ADC433B1;
	Thu, 29 Feb 2024 00:21:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709166069;
	bh=FugMgdspkT6zJhlIQC/Q4z5pFNZbmb5RDlSTLPs91lM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=a1KchUttbwfvRmdUXg540VZnkLaeVnyOv5wTguWXIa5tYAgJAhgpFpapJk/7ZUSG6
	 tGp7+wdEUv3cVPxwNrdpt1l/9Mk7UiCOgtyIQ6KOIXMGqtrg2CDAj1flvYJT1TKasJ
	 ty9vFiXW6TdUALWoRTpVyB9pdJEbqI9ywgcQiqbBsISTuVN2pBM/JT0gOea38WPzaB
	 t1XVL/idOAdO0KJdqJw/EYDlNZtKto3+5/NkXzFfjKPSSNw3cFVUtQK9/dBayqzMt3
	 lfIIc3bi8n6v0pvkI4OaA8MIRJBdtYoxWWmfAuX8Xjm2VEUfVXO7jie6tjr2VlcrfQ
	 iATFD8kLHtMww==
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-51326436876so3423e87.1;
        Wed, 28 Feb 2024 16:21:08 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXEUBvegFOTN5obZfFh7WHUF5KXMPTyir9MKQP2BjyHceY30aSxzpxhnEHc6l+2kkBh6yOmZZ3h9bPr9KS+1dXITZ7TYYBrXKbaYk+jqNv0wbbbQvm3sHIGU+WLjmGSbmmqFyK4eAGQVm5mhWjPjrQgC2GeWNxY/DekSnthu+Zj+g==
X-Gm-Message-State: AOJu0YwSTq9OeGUfyB/j3hLLBw7LceJv5OpMMgsqEWXeZ6MbFCFRF3CJ
	5eFnQZ8vckqAkqajs7LD4RlpQG44RBNPYagJK77e90bs32osYdBE5A2pSZzxx8JkLLLlx1HhKDX
	dUHLI0L6csKM3XOEyQ0gLAoJHLA==
X-Google-Smtp-Source: AGHT+IFINK+VdGWjXx1hj/7VP5H6B//jfKMU5BWmhXkdZm0BiwUhR1Rkur0uiBO2EHzM0RTkvDifog8O62Rnj4NEwag=
X-Received: by 2002:a19:f70b:0:b0:512:ed8e:97ce with SMTP id
 z11-20020a19f70b000000b00512ed8e97cemr265912lfe.16.1709166067034; Wed, 28 Feb
 2024 16:21:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240224052436.3552333-1-saravanak@google.com> <CAGETcx_m22xLSDz_kk9ovw5veKaij49+LdcRx0iyzEk8iEz_+A@mail.gmail.com>
In-Reply-To: <CAGETcx_m22xLSDz_kk9ovw5veKaij49+LdcRx0iyzEk8iEz_+A@mail.gmail.com>
From: Rob Herring <robh+dt@kernel.org>
Date: Wed, 28 Feb 2024 18:20:54 -0600
X-Gmail-Original-Message-ID: <CAL_JsqL1V0d6scrzYHJZzOOhBmTVwyeJ+ZO=W+9Eu7c0YTE6jw@mail.gmail.com>
Message-ID: <CAL_JsqL1V0d6scrzYHJZzOOhBmTVwyeJ+ZO=W+9Eu7c0YTE6jw@mail.gmail.com>
Subject: Re: [PATCH] of: property: fw_devlink: Fix stupid bug in
 remote-endpoint parsing
To: Saravana Kannan <saravanak@google.com>
Cc: Frank Rowand <frowand.list@gmail.com>, =?UTF-8?Q?Herv=C3=A9_Codina?= <herve.codina@bootlin.com>, 
	Luca Ceresoli <luca.ceresoli@bootlin.com>, kernel-team@android.com, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 23, 2024 at 11:29=E2=80=AFPM Saravana Kannan <saravanak@google.=
com> wrote:
>
> On Fri, Feb 23, 2024 at 9:24=E2=80=AFPM Saravana Kannan <saravanak@google=
com> wrote:
> >
> > Introduced a stupid bug in commit 782bfd03c3ae ("of: property: Improve
> > finding the supplier of a remote-endpoint property") due to a last minu=
te
> > incorrect edit of "index !=3D0" into "!index". This patch fixes it to b=
e
> > "index > 0" to match the comment right next to it.
>
> Greg, this needs to land in the stable branches once Rob picks it up
> for the next 6.8-rc.

Uh, what? Only if I ignore this patch until 6.8 is released.
Otherwise, the bug and fix are both landing in 6.8.

Rob

