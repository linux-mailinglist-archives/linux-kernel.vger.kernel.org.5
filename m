Return-Path: <linux-kernel+bounces-76313-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4828585F586
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 11:21:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 03B1D287BBF
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 10:21:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BB493BB46;
	Thu, 22 Feb 2024 10:21:22 +0000 (UTC)
Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com [209.85.167.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0ED73B19E;
	Thu, 22 Feb 2024 10:21:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708597282; cv=none; b=YWAtLAZNPIfiHAh01QRvi4yYuYIwjs/owvOSPvcfmEOjIhgiOvRnMR4B5BHqbQ+R5yef9FcO0z851iU9PEfgphlqhuP6UAHSdZo6rvOjKhOgLg0uZmhkq2jmvbln0G3vbNFdmh9sqBaWojhRQBZJnCyauuzbO6LCeezSS/r2Ers=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708597282; c=relaxed/simple;
	bh=wE2DiKHzedQFS4/Sv7Q4affh96fFxvQSuCyGy/JHcD4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=e4c6o0GRe+cJP9ahc0YDlB1OS+MmHKVuR50UQgBuDvoIKw+0ESNN7zlScgBwdiJSgXEl35+fnbWZy7I+D94/2+XF0ADP+hcNW+3KZaQhqecp8j1b2pxlYJjqPTLsD10OnjnDfogYPlE65yADgUOO33IfqoVR8OguNfm0O8Z/zG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.167.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f180.google.com with SMTP id 5614622812f47-3bc21303a35so2852751b6e.0;
        Thu, 22 Feb 2024 02:21:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708597280; x=1709202080;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kK3gRxW77qjjSvXPb0NgN3PqGi0C2jqyqN8S19nxRnY=;
        b=mrWb3KarGiiaS5SuuqyrkifHBM74bXskGMuWuEYUF4vVXeR8aupoIc8uP/Y4/+pexq
         Jqz9/AM7F4/eExZrZyF7wTDa+Nau8Zpas8EIGoi0UnnxuYGFGR3qhyxVGvJuYKgGKMcn
         OcDSZw50AIyc6tW7kiL2ahcxXzZIgn0Ujp1w5qZ7CNgLa5XUaB2K1xhPZQ4dNPm5nNNM
         YzL+Zv2OXtqs4LRh7Zw3+b+J16vb/FUEmY+6vfSh/fR7RVLojlvkw92dy7j64EEGpF85
         k6xYNof5FIyl0kAfJFOGB35T6cTP5gYM4boVFSgHQk55bffSsWCNBcwzRxadWVx9jpr/
         2KJw==
X-Forwarded-Encrypted: i=1; AJvYcCVnODE1oP7Hee7ky6gEQ5yB2jjT4iTz8Y+s0Hon4bRnpo0RBZG1c8XFQP8mfQce3JpI551ugb8ImyINrXrZG79SF2RYlF9lHda24OqqShLYnbRIksw3hD9MiMG3U6bRBZAdCLFAS24kcv7BoHnS+Hf5Xy1BLFL2eLlCo4Jr96Zn47ptuyE4OIHaLw==
X-Gm-Message-State: AOJu0YyUfrgTN2sA7AVpR3netfmRDjawMv25rmV4+BysgZACPTz2BnXA
	obZ1+NVSSsajDHarM0FPTJ9UxpSAeUcuUmJkIJl3DnnWXyKrvYxf5WHo7FW7kPxsUfB4UBgiHtV
	nKqJB5aYMnGBIoYR2y1f36W+U3aU=
X-Google-Smtp-Source: AGHT+IG+X3dqidb0ShY/50olhNfvLyhndxC1etmc74C0iLVeqGePmbv99hyqomN2a+V5DCBFy0N44slvB4F3YoV38mE=
X-Received: by 2002:a05:6820:b0c:b0:599:e8ff:66d9 with SMTP id
 df12-20020a0568200b0c00b00599e8ff66d9mr1903798oob.1.1708597279817; Thu, 22
 Feb 2024 02:21:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240221123936.3421462-1-colin.i.king@gmail.com>
 <4b78456b-071f-46c0-bb47-919b493cab79@moroto.mountain> <68571997-c33a-49f8-b922-4b102e5b682b@moroto.mountain>
In-Reply-To: <68571997-c33a-49f8-b922-4b102e5b682b@moroto.mountain>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 22 Feb 2024 11:21:08 +0100
Message-ID: <CAJZ5v0h8_F_Fru13aAzZ27W304gwex1d0NPyitourTaS_-ajeQ@mail.gmail.com>
Subject: Re: [PATCH][next] ACPI: thermal_lib: Add missing checks for errors in
 return code ret
To: Dan Carpenter <dan.carpenter@linaro.org>, Colin Ian King <colin.i.king@gmail.com>
Cc: Zhang Rui <rui.zhang@intel.com>, Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, 
	kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 21, 2024 at 2:19=E2=80=AFPM Dan Carpenter <dan.carpenter@linaro=
org> wrote:
>
> Btw, in real life, in 2024, the compiler is going to automatically
> initialize "temp_decik" to zero.  So we could just do:
>
> -       int temp_decik;
> +       int temp_decik =3D 0;
>
> That would silence the warning without affecting anything else at all.

Sounds good to me.

Anyone willing to cut a patch for this?

