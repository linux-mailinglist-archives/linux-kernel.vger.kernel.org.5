Return-Path: <linux-kernel+bounces-87332-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B8F686D2F5
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 20:17:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A9F061F2476A
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 19:17:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFAB3137775;
	Thu, 29 Feb 2024 19:17:24 +0000 (UTC)
Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13E167828A;
	Thu, 29 Feb 2024 19:17:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709234244; cv=none; b=Ty+mzYyDDBXEbEEU4ed/mxWIcWOVRzxOtdWbGzQQy6HCmToxOJvwrlPXMObomqIrKA91D7MM6+Llb/gvULPlbHPK2l8mrrPSX/+EfzobCdGIqe8BOEU1D7VDRGQ2Nw6Xv4Pwkfjoc5FOlb7G+YAw2TCOgldN4E/qzI1eaLc4Sro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709234244; c=relaxed/simple;
	bh=FBZleihRz//Gl+B2DFY+Ko0MRtXnH634JYwkpERaJM8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fyhmU8ZuOYiVE64IvN3TLj71yO/iXYzBUndAUuLLm5uIHQLgDZQZ3lmlFSoriI6sf62Y6gt3i+5kYZKh6V1TKpzaRvOfA9OOsV7YOFajk7DmvpHmSZkIr+wpdaiPX6ZnlIlWrmZ/fas91t+heHkGkwF7CiN/8v7rpY0zwQ8wFmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f51.google.com with SMTP id 46e09a7af769-6e4857d93ebso319717a34.0;
        Thu, 29 Feb 2024 11:17:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709234242; x=1709839042;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Y4kpkILx+rl+5M6wPy0kCyBMrKJ22BL2YvhP99fGIT4=;
        b=ffRJ+fLRnj8w41JPom5XetUZowX34+8pRD4pRDLuvRrGdnNk33IphLmqd5pttKVxSF
         fLbkzAsMGC4b0oiFLF6LkNP90B4b6UNy7qykST+6CW9Y/OLOtyh1Wfv3Lc2ZkTBIBBMP
         wc6/GOLRg28aZJa7hTaxbev+hNQA3oYxDo1os/vQlLRdZK9dKk4WANN8pzW8MzD+tP37
         tzyQIGTS3jxw96bTrHus/9xT6wdjgJ1PzzIrzk0Wo5wcFxKWLMuhvi51J59ZwHPY39rg
         ptCQqN5FVbIjDphlZDPEI2k6pOjwPhfJX5+sSyIpYOQzecYMDVN010HBUM65AgxEcAgF
         YO2w==
X-Forwarded-Encrypted: i=1; AJvYcCXsoaU0oZObLYUGRXB6jikOnl5bcSvw/6TCc+WNYDEJ19e5I/xEz6Hoq1zIz5NFuW6TOuGd0dBjja1oD8D3OjUX9+h2sgQvLQx3wj8KiQjuwFVUZJqS22Q/6ecxNWxPg8gaSh0vpEIdBIbXXfCYQmuIKnBugp2W2SALHfljoBeyOiw=
X-Gm-Message-State: AOJu0YwcDFR+L83cDc4bQoOQyv2WwvDgQejnFKf6F2JmAW6fql4GQGjv
	Yct4FsRw3oBfv7R93Lj8N2jrD/Zf7l6qFXm6k000i4p8gFpQyS+ciRhEVdK9bqGWzQvjxSjZkIA
	oNjpeH/iPGmiA/thcPoYPzQKBQjc=
X-Google-Smtp-Source: AGHT+IET15oeZ9A4Gl+g3bcOmsjvaP/3t9x/x3o3O+8cGgdoAH1s+bxhozrHbmv7trCPELLedqDj5+QwUra+XDo4tCQ=
X-Received: by 2002:a4a:625e:0:b0:5a0:4d78:975d with SMTP id
 y30-20020a4a625e000000b005a04d78975dmr3185438oog.1.1709234242209; Thu, 29 Feb
 2024 11:17:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240225130057.42633-1-s921975628@gmail.com>
In-Reply-To: <20240225130057.42633-1-s921975628@gmail.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 29 Feb 2024 20:17:11 +0100
Message-ID: <CAJZ5v0hAcR1oWYJX2oADdyY14dxC_ohS5hOxuAx3D_1rCSesUg@mail.gmail.com>
Subject: Re: [PATCH] Documentation: PM: Fix runtime_pm.rst markdown syntax
To: Yiwei Lin <s921975628@gmail.com>
Cc: rafael@kernel.org, corbet@lwn.net, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Feb 25, 2024 at 4:46=E2=80=AFPM Yiwei Lin <s921975628@gmail.com> wr=
ote:
>
> The '7. Generic subsystem callbacks' should be
> a section title, but the markdown syntax now is wrong to show
> this as expected. Fix it so we can to link the chapter
> at docs.kernel.org correctly.
>
> Signed-off-by: Yiwei Lin <s921975628@gmail.com>
> ---
>  Documentation/power/runtime_pm.rst | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/Documentation/power/runtime_pm.rst b/Documentation/power/run=
time_pm.rst
> index 65b86e487..82bc76d3d 100644
> --- a/Documentation/power/runtime_pm.rst
> +++ b/Documentation/power/runtime_pm.rst
> @@ -730,6 +730,7 @@ out the following operations:
>      for it, respectively.
>
>  7. Generic subsystem callbacks
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D
>
>  Subsystems may wish to conserve code space by using the set of generic p=
ower
>  management callbacks provided by the PM core, defined in
> --

Applied as 6.9 material (with changelog edits), thanks!

