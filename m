Return-Path: <linux-kernel+bounces-73866-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8234385CCCE
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 01:37:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0D12E1F22B6C
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 00:37:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD3DA17D5;
	Wed, 21 Feb 2024 00:37:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="enU54dI8"
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BF2E382
	for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 00:37:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708475867; cv=none; b=AwfGFVfK6Gu0A/ojmNwp4b3VViCSlE8g4G7mncwn5SE0KOskdp70+TA9Cy7V78Ay8H53Pcc1bdG1ZAH2zzz5USNI28zEP7JkjWe24qiBXj4hQgTzs2VP7/EvI9RcgMSAe4oeTmP+JC3RmPWpHQPk7B8cO2fenqzHpJquqqVYToo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708475867; c=relaxed/simple;
	bh=sZFujEQGwqvDqo73gOOFOSYl3R48kflkWHxbAaLmpLY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XjICJBWjz1voNX5eo+sEyzbA/xlZqiyr0n+5zBok4GglxRKNUH15kwIEcmET+UvjRcUkoxGpoXb7ciVVGnb/obi5wC2rG6vBgigQeYAhj9LalirgYi5BwlWFm2XuENZDyShOoqIPa/Sim3bPuSqUGCC1e99d5iNxBCfUbUsf0J0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=enU54dI8; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-42e2507c6e1so58661cf.1
        for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 16:37:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708475864; x=1709080664; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jj0/fVTLPeNEoZzEKQo8XY9MM+vPdpO5v3+GTWMgcVk=;
        b=enU54dI8nRjEFc69xp5FfUwfWTjxnmrmm2whOIlfb+Rnd58KhE8UipqeaPNV6YCGV/
         NftSjHuQQC+5OkftayKehq7n80a8oYcbp7xp3NSkTwya1EFpsTO+lZgg7oIe1cavttY2
         CEI2SypGcoltWfqOjAgnMWymUGuknhg/CJ7/onXSHMZl6ahWzH8D/lCCDldMY0/U/g9S
         WPSh4p4aWrGFd1HP0u2Klk5VuFxwWVrlKkPiR3lJvgHEcFfgMEQYlY5SOvYYb3odbASy
         oo8W0kHlZcNfRZ2zL1Pn8zqLvP1CLrXBxGMz8DV+1/sO715yXQjkr5TKOyrxFFkxl2kg
         Bmjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708475864; x=1709080664;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jj0/fVTLPeNEoZzEKQo8XY9MM+vPdpO5v3+GTWMgcVk=;
        b=EuRUyy3781eTdmFAm+wtrj5+g8DTVvpzcnoSN6V5ueoVJF+JUIoynQ/kdKfXyJoegz
         bU3ZmfASZHxkR1WtcRGg7fOLUDUCkBHxAs5hkyatn9mjcXErEsWadqtk0xYvjRN7k07Y
         XYdyHvm1O0HGQTujL34PkUPMH7Nfg84HSsHhoYMoGOse94KhO/1H2AYnzxXZIJmTK+8I
         q/9Orzn7MmeJ3EBA9rW/MptVMCBdPAk6CwTIBkCqT1rqoTo5vcNRsGbHr38KEEbuzJ5M
         nRIvabnb1cEtXLoVfSVUGOa9fWREMbSHZlFNl08xQC4qysbUmjkJ5KQP8P9cWFhi/+u1
         pvkA==
X-Forwarded-Encrypted: i=1; AJvYcCW+9uRlmjvdt1aYnHhTwTdrgmLKrkDpbbpTGxVDni9rgRMrktL78xnEuvnOJF4Z0fSVUchMEsA3OI4L1MjoHS91fA/CbK0frK05sTVA
X-Gm-Message-State: AOJu0YwLvCmhlZJsT2RodF+e97X8KbkhLpUTNAJ90HzCAd26j/LE59Xq
	L1tnk7WR4UpifI/GO7DxQUGJ+iEE2QifGnqdMmeZsDK2/53KfduadMBf966E2L5XcKYx1BYckYO
	t8usZgHSv3+CJNXE9ts7aSk3fTRFY6zv5K9TU
X-Google-Smtp-Source: AGHT+IFWKa0zQuyXr2Ec98mgUCaCVoQFWOycN+wSYwpSdidN024ExFMoa9bfjWNDWNzC1er2+areNtPyqyYBg1+PmSo=
X-Received: by 2002:ac8:7643:0:b0:42e:1260:c4e6 with SMTP id
 i3-20020ac87643000000b0042e1260c4e6mr117952qtr.10.1708475864337; Tue, 20 Feb
 2024 16:37:44 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231130174126.688486-1-herve.codina@bootlin.com> <20231130174126.688486-3-herve.codina@bootlin.com>
In-Reply-To: <20231130174126.688486-3-herve.codina@bootlin.com>
From: Saravana Kannan <saravanak@google.com>
Date: Tue, 20 Feb 2024 16:37:05 -0800
Message-ID: <CAGETcx_zB95nyTpi-_kYW_VqnPqMEc8mS9sewSwRNVr0x=7+kA@mail.gmail.com>
Subject: Re: [PATCH 2/2] of: overlay: Synchronize of_overlay_remove() with the
 devlink removals
To: Herve Codina <herve.codina@bootlin.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Rob Herring <robh+dt@kernel.org>, Frank Rowand <frowand.list@gmail.com>, 
	Lizhi Hou <lizhi.hou@amd.com>, Max Zhen <max.zhen@amd.com>, 
	Sonal Santan <sonal.santan@amd.com>, Stefano Stabellini <stefano.stabellini@xilinx.com>, 
	Jonathan Cameron <Jonathan.Cameron@huawei.com>, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org, Allan Nielsen <allan.nielsen@microchip.com>, 
	Horatiu Vultur <horatiu.vultur@microchip.com>, 
	Steen Hegelund <steen.hegelund@microchip.com>, 
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>, Luca Ceresoli <luca.ceresoli@bootlin.com>, 
	Nuno Sa <nuno.sa@analog.com>, Android Kernel Team <kernel-team@android.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 30, 2023 at 9:41=E2=80=AFAM Herve Codina <herve.codina@bootlin.=
com> wrote:
>
> In the following sequence:
>   1) of_platform_depopulate()
>   2) of_overlay_remove()
>
> During the step 1, devices are destroyed and devlinks are removed.
> During the step 2, OF nodes are destroyed but
> __of_changeset_entry_destroy() can raise warnings related to missing
> of_node_put():
>   ERROR: memory leak, expected refcount 1 instead of 2 ...
>
> Indeed, during the devlink removals performed at step 1, the removal
> itself releasing the device (and the attached of_node) is done by a job
> queued in a workqueue and so, it is done asynchronously with respect to
> function calls.
> When the warning is present, of_node_put() will be called but wrongly
> too late from the workqueue job.
>
> In order to be sure that any ongoing devlink removals are done before
> the of_node destruction, synchronize the of_overlay_remove() with the
> devlink removals.
>

Add Fixes tag for this one too to point to the change that added the workqu=
eue.

Please CC Nuno and Luca in your v2 series.

> Signed-off-by: Herve Codina <herve.codina@bootlin.com>
> ---
>  drivers/of/overlay.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/drivers/of/overlay.c b/drivers/of/overlay.c
> index a9a292d6d59b..5c5f808b163e 100644
> --- a/drivers/of/overlay.c
> +++ b/drivers/of/overlay.c
> @@ -1202,6 +1202,12 @@ int of_overlay_remove(int *ovcs_id)
>                 goto out;
>         }
>
> +       /*
> +        * Wait for any ongoing device link removals before removing some=
 of
> +        * nodes
> +        */
> +       device_link_wait_removal();
> +

Nuno in his patch[1] had this "wait" happen inside
__of_changeset_entry_destroy(). Which seems to be necessary to not hit
the issue that Luca reported[2] in this patch series. Is there any
problem with doing that?

Luca for some reason did a unlock/lock(of_mutex) in his test patch and
I don't think that's necessary.

Can you move this call to where Nuno did it and see if that works for
all of you?

[1] - https://lore.kernel.org/all/20240205-fix-device-links-overlays-v2-2-5=
344f8c79d57@analog.com/
[2] - https://lore.kernel.org/all/20231220181627.341e8789@booty/

Thank,
Saravana


>         mutex_lock(&of_mutex);
>
>         ovcs =3D idr_find(&ovcs_idr, *ovcs_id);
> --
> 2.42.0
>
>

