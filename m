Return-Path: <linux-kernel+bounces-30912-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F0F28325D3
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 09:38:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 06BB3B21FED
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 08:38:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F234F1E535;
	Fri, 19 Jan 2024 08:37:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JDqM3iCv"
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E334FDDD1
	for <linux-kernel@vger.kernel.org>; Fri, 19 Jan 2024 08:37:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705653476; cv=none; b=gF/13YYaUg5rRFIsYfMvGx1/hmoWOdvC62OqmgY9G+gFhgvcd0oz0hj8v4YJdXkc6RGNqxkLD4lCxD6ER0Y0tB2saBLYNN3hFVI/A+eFV9WuUR12G/3Y5fAQwfnAO8MkTTjnQTC9sYv0nDbf74mWZexy398M5UAF25QdIRg8RL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705653476; c=relaxed/simple;
	bh=Nsv90JhnmzrJby+cvtgjPQ2XglUSKxTpH93cNvEzw90=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=L//C2ScztnccZTXPLqtcjxJCKSMG+jaZVocLmAk2E1gJ6vAYSU73H7FR2Z3EV57IBdgV3zb0AA7LnwtIYQaXm64qkcsZy9ROX4uYqV0HbBycFg5VxBPYaQNPLeX5cFhe/bvOLj0s7C7BXS9ehZrJ2WdoLUxWhjCf7jIjSev62s8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=JDqM3iCv; arc=none smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-5fa4b03f3f5so5126127b3.1
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jan 2024 00:37:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1705653474; x=1706258274; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NRvn5RZ1HsZd07VKkQW6gCaAtfJNR2DY0xUO7eobngo=;
        b=JDqM3iCvURZu6RlHmZ4ygfh2mjne2jN+LQKpBu6tGtG1b8EtY0MdRFC46TlCfus0yF
         u2Jy/XALCxc4rlO7CmZwqE+ltyF11o/30OuWEm20TLPERWHx9BnL7jzcHL1AzzORPKxR
         zwI9rfkMujrXGatlovAbU6E32n6NiJgvMecIfstMS7eDS3Rok4YRrN/XLwMNY3ueVLwb
         FRy1jv6HVzKXHp3oty1VCk9QLvNAdwk94EfE/pIqpafZG6KU7K0lSLduu9v/K2uEdY2L
         X09T2HRlJzz9VGGOFSMTJ+zOqowrhiWaWz4KumBHNSuL3phFFEkWQ6XmeaKKNQW3e3Wz
         /LcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705653474; x=1706258274;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NRvn5RZ1HsZd07VKkQW6gCaAtfJNR2DY0xUO7eobngo=;
        b=QRCl4hGpW04e4g0fjgiCusZwMgDZgxfxOuAJMsgi8Fq7em35Xdg8oEBZOr3DlKUG79
         91FpBwLC6KWgPNWr6sJ4KDlUJIDZ+7FN/HfOs5BPLyQN6JCttpakBlPH5+OaLaRN9S6E
         393/I0BBtWACVuZjMsoly+yWmawiZ6A1IVA5DzaCEUtHPFMg7gKxevuecKXJP6E7KUZQ
         ua42Tme0pXrLm23RC6LMrKCOs92vTemdE2DkoRlLlQNA4RyJnxZ3YIeGbhQkvBr0NoT1
         UfWauPfG8sfQ32ibjMhI3jvvDDY0+pmto7BhITCnsQ/3avnVU/KN3QWn6E3UQZNNsiXw
         HM+A==
X-Gm-Message-State: AOJu0YwptDCIjAPgtaxsITm3cDoriGsU5QI+BuWq2H/eE+Y3Tu5w249v
	A26FpdvYXoRApSyZ4wHpO0gsC6lVjyWZ3xzKbU+stN5E/EuqUMrKDGklo+b70J8sVLEG/r89/Wt
	kjlECPoHYEa95qxdEctF/0Fj3hp+eH4604mhqZQ==
X-Google-Smtp-Source: AGHT+IGnRTPdURLUcKdtp3ipXuTkQDClms+jlN2oiOzaPeSgMjQk19zwgmWNFm3a6edHmF4HgpK7tkJsvVx/Vhghxe8=
X-Received: by 2002:a81:62c5:0:b0:5ff:617e:6edf with SMTP id
 w188-20020a8162c5000000b005ff617e6edfmr2146542ywb.34.1705653473914; Fri, 19
 Jan 2024 00:37:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240116071803.5264-1-quic_riteshk@quicinc.com>
In-Reply-To: <20240116071803.5264-1-quic_riteshk@quicinc.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Fri, 19 Jan 2024 09:37:43 +0100
Message-ID: <CACRpkdaNU-qD0+4CROGJHRb0KDPqrTGe5QpM_r1ztR04EpTENA@mail.gmail.com>
Subject: Re: [PATCH] drm/panel: novatek-nt36672e: Include <linux/of.h>
To: Ritesh Kumar <quic_riteshk@quicinc.com>
Cc: neil.armstrong@linaro.org, quic_jesszhan@quicinc.com, sam@ravnborg.org, 
	maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de, 
	airlied@gmail.com, daniel@ffwll.ch, robh+dt@kernel.org, 
	krzysztof.kozlowski+dt@linaro.org, quic_abhinavk@quicinc.com, 
	quic_rajeevny@quicinc.com, quic_vproddut@quicinc.com, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 16, 2024 at 8:19=E2=80=AFAM Ritesh Kumar <quic_riteshk@quicinc.=
com> wrote:

> Include <linux/of.h> instead of <linux/of_device.h> to fix
> below compilation errors:
>
> drivers/gpu/drm/panel/panel-novatek-nt36672e.c:564:14: error: implicit de=
claration of function 'of_device_get_match_data'
>   ctx->desc =3D of_device_get_match_data(dev);
>               ^
> drivers/gpu/drm/panel/panel-novatek-nt36672e.c:622:34: error: array type =
has incomplete element type 'struct of_device_id'
>  static const struct of_device_id nt36672e_of_match[] =3D {
>                                   ^
>
> Signed-off-by: Ritesh Kumar <quic_riteshk@quicinc.com>

Patch applied to drm-misc-next on top of the commit that need fixing.

Yours,
Linus Walleij

