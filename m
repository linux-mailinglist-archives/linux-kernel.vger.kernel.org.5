Return-Path: <linux-kernel+bounces-126691-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 303FD893B97
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 15:49:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5E1A41C2141D
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 13:49:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1D323FE24;
	Mon,  1 Apr 2024 13:49:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AnoKuty3"
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC6AF3F8F4;
	Mon,  1 Apr 2024 13:49:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711979387; cv=none; b=kF640+JbG0/cOrKj9UnqbRioMIk6ERmTV23MyXqlDZX9sIkX+UTgHfUJ1ZR++2Phrs9nqgjX8XwtlM7CTn2SqWrFKSOFDOMwNHGCUVpRFsx0qvq1sVkF3SytFedEtKD2dmSaSwiETMC5yhs/mYFW3tu0RsIpKFzwD7dEGbttVGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711979387; c=relaxed/simple;
	bh=VRBLb0H5LEzKv8/yGoomrhzv5ZJR0HMpMftcHhFvWu0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EFBj189FtFU9xwpI1E2bTUrgKkjaPo6MpH2QcV5K65Jy5HLlYlGKMxFTuUEJxkgmlGt9EVkdhlaZd7P0mfuVvYSYpTvsNP8ATuDH6MsM1ZAOCataRnmZHYGN7/NhrTHJ+chAkYQWlJG3vY8WtWkIdxkRfbYY/dP56RgG/3D0zPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AnoKuty3; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-430c7898b91so12840841cf.1;
        Mon, 01 Apr 2024 06:49:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711979385; x=1712584185; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Jl+uIt64f57GTBJjXWFzhhuJgPbyMSgOea8HCMKPEdo=;
        b=AnoKuty3rE9R209UlDBsqKqsnKlYFVc9Sd/ixo+EmEFb0yoeIuIZ1NJRc+GnaIwMMJ
         Bd5sUlLvBmtFldyL8IYO8qswhBstMl7YOd0/0vzlGBA0ddKgkQUMCAevBlsANkDTU+V7
         1JuDKQczksVMZEkzTxII2qqzeKctkqylB5/SA9nXdJXtLBocWvTYbzs9yiZA76XbFhIE
         W0eHgK44zTorwd45Yrxh7WtSjD4CzR7RaWtYket6G+3GvBeYbJ1EFvFc07qGWU0trjCg
         wKJ1x5cXg+luWDjf8kpRnP3j8xPJgNWcwB5LAWsMrpYSMxOWzueXgmcHUlPE+P8TMBAG
         rbzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711979385; x=1712584185;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Jl+uIt64f57GTBJjXWFzhhuJgPbyMSgOea8HCMKPEdo=;
        b=HKHnzocSFOho/JwOhfRapneY6rfxlIwiD4G0m43kY+zfeXH5JMk9NjgD8iHLcfHe8P
         3OcBRo+fnhoJhYOmOO+vHSfClAPH3ELKMa44n56v8s84oz/h671KcqB8lsgzZ6qCB45V
         u9etjeHjZMi3MPfYiAHCyaENSK+W6R90H/LXsdDqYj5ElfjzJmYdKTXzRBEDjfV4g8uZ
         08JBJ9wUK0fuk/lVnOYLLs++sEE1/xzO5xxNzPcRHDdg2Iu75pzG6n+oEBEOBS87gITO
         cmT95/X1yCNSEzy68CZVS8E6vph6zw05uw5D36gzyXwwyVCa4/IfIG+di7kLHzxmMxIy
         8Yrg==
X-Forwarded-Encrypted: i=1; AJvYcCVFInU8IKZ/3aZwKregG4mpEnkRiFGCstlJ876Fo6LeZ6Hvh/BhGiLjfVkOsbikbO/uaU1pHrWHbGOK/XN255y0wknr9NdGBIOrx9k=
X-Gm-Message-State: AOJu0YxrerJZZfU1SlnfRq1Dgkup9gFsupHe5SzCd52NFpOML3zEX6/v
	dO34v/PH+bCWK3O1ebduIlyyiC5Ac4t8KMYPO84VpbmifNTu27tVwaH4jHVc5/Cu1xMv0KRP6h2
	jAwuqQaFHE1kD7ppFhyD3b6pyt0o=
X-Google-Smtp-Source: AGHT+IG8xarylrtGVemOrXft3mFRDMyOj0shCAYvtM20xdIskXxlhuGdqBqt8ba47CFV4cZm2Uw9rhnam4BLDKbVCmY=
X-Received: by 2002:a0c:fad0:0:b0:696:9892:fe29 with SMTP id
 p16-20020a0cfad0000000b006969892fe29mr8969407qvo.5.1711979384658; Mon, 01 Apr
 2024 06:49:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CABXGCsNmEtrN9DK-XmESaPm_1xpXm8A+juE+44Jf6AK5JE0+TQ@mail.gmail.com>
 <874jcl7e83.wl-tiwai@suse.de> <CABXGCsMmRFW3EYJ3UvNd-LO7ZTOyoNqjc_3OAmaCDSL=LuxJqg@mail.gmail.com>
 <87v851e2di.wl-tiwai@suse.de>
In-Reply-To: <87v851e2di.wl-tiwai@suse.de>
From: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Date: Mon, 1 Apr 2024 18:49:33 +0500
Message-ID: <CABXGCsNMBRUaY-V8mhUQKdq+CQW5+eGUWL_YCJWXo0cgh9bGJQ@mail.gmail.com>
Subject: Re: regression/bisected/6.9 commit 587d67fd929ad89801bcc429675bda90d53f6592
 decrease 30% of gaming performance
To: Takashi Iwai <tiwai@suse.de>
Cc: Linux List Kernel Mailing <linux-kernel@vger.kernel.org>, linux-sound@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 1, 2024 at 4:41=E2=80=AFPM Takashi Iwai <tiwai@suse.de> wrote:
> The only code of the commit 587d67fd929a is the close of ALSA timer
> device.  If it really matters, it implies that the user-space seems
> trying to open/close the ALSA timer device so frequently.
>
> Are you using ALSA dmix/dsnoop?  It would explain.

It's new words for me. I didn=E2=80=99t configure anything like this myself=
,
only if the maintainers of my distribution enable it by default.
I only know that Fedora Rawhide uses Pipewire for mixing sound.

--=20
Best Regards,
Mike Gavrilov.

