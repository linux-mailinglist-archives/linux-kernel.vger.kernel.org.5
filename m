Return-Path: <linux-kernel+bounces-25745-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DAFDB82D53B
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 09:45:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 609B2B210A4
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 08:45:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF9B363B6;
	Mon, 15 Jan 2024 08:45:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SsTq2872"
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C34D2563;
	Mon, 15 Jan 2024 08:44:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-5596fa1e2ebso10907a12.2;
        Mon, 15 Jan 2024 00:44:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705308297; x=1705913097; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0C76vN2UDn6EUDP01K9KG9fUM6gU4ZfDAK5/kbr9SnI=;
        b=SsTq2872saE3bVYCJAa/ewPZP6DZcdhFgxMJojkIgWT7InUKotCt++3yciP4nwk1HL
         v0NsMp8ZdzSNFhYaAgbZM2GsMXtnCD/ZHL+cEBfT0RYPPeQ/4wBqheI31IC6r/Kp4iXh
         vVtYxlQfO6Wt3w1jXEqy91kEuP9xtCjiZoSuoKMtP59vdwEpOJuJAGGOhAAA5BborEAA
         EjR/3W4vDHIJnqgBEnW7UekRObmIO9VjgaWnYddt9W2tXYBJk18gKbLjtLHTXjdhHOAr
         4vVuMLOUlj+ccP+V3vGIUU22mBYYEzx8NUEYN0K67uA5f6hh3yrqtwo+DO0wnfs4OL8S
         bj3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705308297; x=1705913097;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0C76vN2UDn6EUDP01K9KG9fUM6gU4ZfDAK5/kbr9SnI=;
        b=toSf00nQJgTI6078Eq5iSoFCQ242tukRKqrVfscd3JxXNHx6wGR6Q0Nqw46bDVh9lo
         UqCIvBytP4TIfDWbusclm9T8JuhP8FM8FyfDor7uySwFgwIcpWRCU1cPTVgjC40srTMj
         Yu2jjv95dv9KXqp7j4NTdI51k4IvryXyP+5gLUueJcQj9YZwlqRF/sz7yPV30uR9GGlS
         4PAZXi+7K5nbt58EfHcjIBsB21jMR0JPuHf4hpDVtVibfTtbBgnupzO/LBIZXbiXlSsX
         JKBZwU6+j9hukucvN4tNOUULhvRS+zUOUEU5SUCmDwkwCKlUFTWwYmKIzM931vaihWKp
         l0CQ==
X-Gm-Message-State: AOJu0YxVb4HCVWjK5r227L2J9hnmZyNxLZJhRdDAwDAeyrNz0HCBPlVG
	lbi5N4TFVDGi64c3NJ2nkN0F9/ZPTefRT3zKtDdQyymb1jQ=
X-Google-Smtp-Source: AGHT+IH7nvS/JdO/EzfUQDdzm0WV8ZdWqB1u3wrr0534j/vihMpugOZn083H8/xbA9kXJqWmr0IeLilNh0zeciM1Nsg=
X-Received: by 2002:a17:907:a80a:b0:a2c:aff6:f6a9 with SMTP id
 vo10-20020a170907a80a00b00a2caff6f6a9mr2469795ejc.150.1705308296578; Mon, 15
 Jan 2024 00:44:56 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240112054331.3244104-1-chancel.liu@nxp.com>
In-Reply-To: <20240112054331.3244104-1-chancel.liu@nxp.com>
From: Daniel Baluta <daniel.baluta@gmail.com>
Date: Mon, 15 Jan 2024 10:44:44 +0200
Message-ID: <CAEnQRZCT31ti278aLqh1QtTQ33fJU6xnb_qoVMRooBi7WsJ6Yg@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] ASoC: Support SAI and MICFIL on i.MX95 platform
To: Chancel Liu <chancel.liu@nxp.com>
Cc: lgirdwood@gmail.com, broonie@kernel.org, robh+dt@kernel.org, 
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, 
	shengjiu.wang@gmail.com, Xiubo.Lee@gmail.com, festevam@gmail.com, 
	nicoleotsuka@gmail.com, perex@perex.cz, tiwai@suse.com, 
	linux-sound@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org, 
	linuxppc-dev@lists.ozlabs.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 12, 2024 at 7:44=E2=80=AFAM Chancel Liu <chancel.liu@nxp.com> w=
rote:
>
> Support SAI and MICFIL on i.MX95 platform
>
> changes in v2
> - Remove unnecessary "item" in fsl,micfil.yaml
> - Don't change alphabetical order in fsl,sai.yaml
>
> Chancel Liu (3):
>   ASoC: dt-bindings: fsl,sai: Add compatible string for i.MX95 platform
>   ASoC: fsl_sai: Add support for i.MX95 platform
>   ASoC: dt-bindings: fsl,micfil: Add compatible string for i.MX95
>     platform

For all patches in the series:

Reviewed-by: Daniel Baluta <daniel.baluta@nxp.com>

