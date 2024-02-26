Return-Path: <linux-kernel+bounces-82295-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 804268681FC
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 21:38:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0F3C728EE52
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 20:38:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65D3B130E38;
	Mon, 26 Feb 2024 20:38:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CRtgsqzf"
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ACE2405CE;
	Mon, 26 Feb 2024 20:38:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708979910; cv=none; b=H9CWjuq0JnRL4Ejkt7EDiN55Buzrkd0s9J/QG/qiHThQda0nyzdCZuGUIyvoNhHIDbN4hs9AMWe6zN+haP0izS10DSSW3GEH/XJwYztrN0bSwRdMuhcMQKBDO0NHXdNpyKbPGzyNyhqoz9mYCJUiSLcIlrzhwTER1x0iFat6G3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708979910; c=relaxed/simple;
	bh=HsejdDvqC73ldVFNrH/9/DZMlTWUElyHEKA91R848fc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aWa28q2Ii9AO359nBeeSEFgwggxSTw5ETrMzYA6tMC9NQhNbNjY4YRNCZrdEQoYTWKZH5d3/Eq0g4mXrVUZRR298yF/gTFYAh9MozsRfY4pwCOzc3oSNrabjVGNvrF4zEMQVo4g8tOvET4rCGCdxluh7HK5baBxhoi8C5LMnIJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CRtgsqzf; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-5cfcf509fbdso1678583a12.1;
        Mon, 26 Feb 2024 12:38:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708979908; x=1709584708; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0scXHFBtzVvkjRXYq6gEBt9Z90URlSPbBo1jvpXeT4Q=;
        b=CRtgsqzfZ7mwZdpkvLWruY1zfewGt78lLiu9y/XcBkjAGM0tftpLrYXPZGEJZUSjNp
         Suf4ARCDW4feQAQdfx7iDaONEDkFPAGWp7ERFDvcCJUrR1Nk3g2dCvYe9vK4uQc38A7P
         1Gi0rWldyILAMa1aiZoCVUIpsM3wiBHpePsPOu4OP0mlLKfvLlHaPlo2qgsYGIiES6Na
         MsyXWubgjLRN3wHMB/QA7AQt2iI1AphcPpx2xRwKdefTUKIlNNptR7hs6BMOL88LCFhj
         F+xxKIRn0JgCYqFXDcR70UNvfh1VzeL3WhIGMl20Vs04PdTNDzAG/OiGENDE8auUMLGi
         pbNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708979908; x=1709584708;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0scXHFBtzVvkjRXYq6gEBt9Z90URlSPbBo1jvpXeT4Q=;
        b=seniln/SjlerBVX2WJKWtggPI6z8ALN/Hel7wv9E0CPLbk5LAc/9YIDYBSOpUzyAeP
         ypzDYfIncHuXLy8hF4VrIA8xORJV/mtqs53Nx0j+suD36A1M+XkcwnwCVVIYLx6SCxla
         FqKG90GrO8OAg5qUmetqfAY2le5atwubrwgrImJ7cWrpsisbvX5Cd0PC8yrFEGT1ZBq4
         3yh6Ekomqx6NW+8RBCxdzQhkIEZu2RK/gbicQpaagQp/b59JvyyBniX7Gnl+2eU1Cgvj
         mSLDcUwuiCG6WJJFs0mFnA36B8ozbMqRQfvozfuSeLclu02jfV4q4fyBKMDxiNALWxlg
         D/nw==
X-Forwarded-Encrypted: i=1; AJvYcCWZeH8ai2Cm4D20yffIMxGgjEqZ8l7dUO5cE6s6ob8gaTPzvyDFjhoIvLkht0XQl5vD7Hp0TDne5MfM+LrsJZafcGC6nwqPRGu8XKi1bM/yUif9K3MskvIhBxBcFlSRGOQ8FNC4SnZltg==
X-Gm-Message-State: AOJu0YwBtCAiGcqBgXhHOCKBlRpemFGbUYMk3tVzQjFlz0kGEd8OJ8+u
	v9ZJalgBY8ZdtHQennnatW5MkDP7oBeX6Gjw/BD+nOanxOt7CG1Ot4yDGt8upC95k2+bgB27MVK
	S3SERw346BMtzjRmIN/WWdNkx4CGV3GOR
X-Google-Smtp-Source: AGHT+IG/6g2Uunj3KJXa+FfivRmJy6KPW89uXNNLxqYlIofCsJ/0C9Rj5gg9hWMoFnHZFtzVNsWawNA10uncefclPMM=
X-Received: by 2002:a17:902:eb4c:b0:1dc:3c:fb67 with SMTP id
 i12-20020a170902eb4c00b001dc003cfb67mr8978730pli.5.1708979908509; Mon, 26 Feb
 2024 12:38:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240226203358.275986-1-Frank.Li@nxp.com> <20240226203358.275986-3-Frank.Li@nxp.com>
In-Reply-To: <20240226203358.275986-3-Frank.Li@nxp.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Mon, 26 Feb 2024 17:38:16 -0300
Message-ID: <CAOMZO5CoucMLo2T7z25EpBeakmKt38jis-_OC1-_C1vGtXEwWw@mail.gmail.com>
Subject: Re: [PATCH 3/3] arm64: dts: imx8qm-mek: add flexspi0 support
To: Frank Li <Frank.Li@nxp.com>
Cc: Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
	Pengutronix Kernel Team <kernel@pengutronix.de>, 
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>, 
	"open list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" <imx@lists.linux.dev>, 
	"moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>, 
	open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 26, 2024 at 5:34=E2=80=AFPM Frank Li <Frank.Li@nxp.com> wrote:

> +&flexspi0 {
> +       pinctrl-names =3D "default";
> +       pinctrl-0 =3D <&pinctrl_flexspi0>;
> +       nxp,fspi-dll-slvdly =3D <4>;
> +       status =3D "okay";
> +
> +       flash0: mt35xu512aba@0 {

Node names should be generic.

Please run dt-schema checks. Otherwise, you will introduce more warnings.

