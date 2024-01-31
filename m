Return-Path: <linux-kernel+bounces-46483-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DDEEB84405C
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 14:19:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7D0FB1F27889
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 13:19:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1F027D3FA;
	Wed, 31 Jan 2024 13:19:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CPFzVMGY"
Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C2037BAE8;
	Wed, 31 Jan 2024 13:19:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706707147; cv=none; b=sb6IOqGYXOLiyDssyF6D9mIk7z6HzcTGSD4we1RSKycrgx1rn14IUXHQfyrC7dpNU0TL9toFi163BstOfo9Q24j5BCEuh2eS3rV1CAjw00SPZzjL6QdnsUvc6o4ezBDQvLrOCzzZ47V8tRK9xKUvhAv9L0OgPkwcKlmaGNjwIFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706707147; c=relaxed/simple;
	bh=hvDVoSzxIpLOg4w5gixXPSq5JELWl7gfLFSeBIClhM0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FdKcLQr1UnvfaCb03QoaZmjaEvL/LXdCEJO+K7k9f7WN0uKKn36D1Jg6z4+C4xf21jZcbgtOpu4ZyhQXwPvKnF8K9cGqbZhvEnQbE6OnbfIKMRJSfyZo00HvY24eAnUis+NdDcnhja4FjnDWZIvLs2M8BrlNRRvQgTXS008pFyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CPFzVMGY; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-68c4673eff5so25301666d6.1;
        Wed, 31 Jan 2024 05:19:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706707144; x=1707311944; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hvDVoSzxIpLOg4w5gixXPSq5JELWl7gfLFSeBIClhM0=;
        b=CPFzVMGYBHPgyHQ03zXulOOMh8MrYkENLicG+8aQtkReUVVKRT4fyHtqP7pjMkJO3n
         ii0wDYuVOoo/3yW7UU85z2ErsXWLXgrLvodOSDnMRvutfhGPtOAL9+6rHYpojI41hg6m
         k9eLnaQeSVX9tDbhUIjJp3vFnsM+HY3w8T/PS0WQ3Le7StTL2M7e0L4H4SPK2f4XukFX
         8Vi9WoZwGJotKryd5lbwQ4KOY/Ujhbm4W2F0BDwC11AVLF5380OmvUO30R8ih21AYj9K
         fkfsJK+X18RyKpV3q7wh5O4aY4SqSIenb47pXtUWR2+feOcgTUUdmkACR8gxfRmSmGpz
         EWcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706707144; x=1707311944;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hvDVoSzxIpLOg4w5gixXPSq5JELWl7gfLFSeBIClhM0=;
        b=A0MfQoLd/38qvqyCotlXagyvNTby0YiWdALHR2Zp1SR0QHPnex3+5LJfyEIwUnlqtp
         2OF2lfc7iUKqhzmbnj580UqyXMR3cxBtDjwaBiO7QkL+XOLPufm9KW+B5W7Md3oi325H
         n47TJ4XtFzEKcjWEBVla+hLDc3NkU1EWCX0CmahgLPbNnOGf6tKpP0hIuP8ErdtwlwHU
         XWaYDXUwU9D0Irv7hHqg2eNF4drnpqmoho8r7qj11B2QLgQM+tcSr2Z1B14fDFgKa28o
         NUo9RUFv1NlZBRamtT2qzB0JSSx+fUaFpA8Vq367QNWinXylo2/UBxeeuchFSNcnv1r+
         etjQ==
X-Gm-Message-State: AOJu0YwLe3h03SfUTZW8+D+pZ0muaD0hCnbRz26hUrIFHO3NvVbpiIYC
	PdIKlahce913eJuAmjsxVXuc+XrK/UOJMgdghibxSGABpbmbtQPLmgn3aReVFWAv+yIdLOoE3md
	jrlfzbj5vIQir5g38xYI5JJ9cWsY=
X-Google-Smtp-Source: AGHT+IE9N91zszXJSzr7FWqiwqKPxd/D56VH8GS5ujXrAMPqIrvXULJAB0CSAumPWgVae+rrN+Zox9Fcx5YYsbKrlrI=
X-Received: by 2002:a05:6214:57d6:b0:68c:7153:6ed8 with SMTP id
 lw22-20020a05621457d600b0068c71536ed8mr597586qvb.29.1706707144475; Wed, 31
 Jan 2024 05:19:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240130214620.3155380-1-stefanb@linux.ibm.com>
In-Reply-To: <20240130214620.3155380-1-stefanb@linux.ibm.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Wed, 31 Jan 2024 15:18:53 +0200
Message-ID: <CAOQ4uxg9VQ9LksxX5eFFg7E1VO_iFZNmNBaC3pED+a2=ixOhdw@mail.gmail.com>
Subject: Re: [PATCH 0/5] evm: Support signatures on stacked filesystem
To: Stefan Berger <stefanb@linux.ibm.com>
Cc: linux-integrity@vger.kernel.org, linux-security-module@vger.kernel.org, 
	linux-unionfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	paul@paul-moore.com, jmorris@namei.org, serge@hallyn.com, zohar@linux.ibm.com, 
	roberto.sassu@huawei.com, miklos@szeredi.hu
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 30, 2024 at 11:46=E2=80=AFPM Stefan Berger <stefanb@linux.ibm.c=
om> wrote:
>
> EVM has recently been completely disabled on unsupported (e.g.,
> overlayfs). This series now enables copy-up of "portable and immutable"
> signatures on those filesystems and enables the enforcement of
> "portable and immutable" as well as the "original" signatures on
> previously unsupported filesystem when EVM is enabled with EVM_INIT_X509.
> HMAC verification and generation remains disabled on those filesystems.
>

I am missing a high level description of what is in those "portable
and immutable"
signatures and how those signatures remain valid across copy up.

Thanks,
Amir.

