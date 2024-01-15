Return-Path: <linux-kernel+bounces-25811-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C115582D633
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 10:40:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 47D3CB20F69
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 09:40:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66227E541;
	Mon, 15 Jan 2024 09:40:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wO25eBCQ"
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B5E2D514
	for <linux-kernel@vger.kernel.org>; Mon, 15 Jan 2024 09:40:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-40d6b4e2945so98531645e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jan 2024 01:40:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1705311638; x=1705916438; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=DUjf8EcUmZjVmkCxTDXwKlHM+fZcUzkgPqOKaASP32c=;
        b=wO25eBCQEDqcF+ewIp4Mzemnhyr6HY8lXKm70HUUpQAWitOB6+433tKtd/dRPP0iq9
         GxKvQfuaIGQoVOkP6n0aOed4trdZpTTyrWWk49nyne+S9T+V5V8YM9ziihw/CgP9m+nv
         4ddXcWC5ZqZk6tVebIASexYlynve37EcHPMjikVfvrz8Mnx0wSQkZepirLxDiXNB40Cv
         UsgJRQpPr7jmCgu3yJBDSfrdBO1PM2iEtMfrRdD4j567eTOwr4rGtjv6ePxR7zTGCdqR
         e7u2K31C7oDkoVn5CEnlK7gn1nQL74irwlfR3+9QNYkGAdQ2uPPivPjTBJu3lQ8dXsIB
         4/MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705311638; x=1705916438;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DUjf8EcUmZjVmkCxTDXwKlHM+fZcUzkgPqOKaASP32c=;
        b=N98cPsVQxqKX6vSxy/f+eM5+raBxgRNJRLx0Z7mzExmSO4krj/Mb8JdrjFogg+zE8+
         QPgJfZ+T/XNPMuLorRYVzS6oem2BCr3a53klvzGA+ImdAPq1Euct/25q/IGJNv4K2of4
         zO5FMHCCsEihaxGbrF1RnZ5cy7EVBBmQ73m/ewtOX8703klHUd1ibhEWTycUv0ty2dBB
         Eofed0GEcedV8BX3bb8Zd5YeM9YVYnYL+VKLGZctwqY4T7ReC/Ne8c6QqM7w1qfy1A3X
         OuSPsevZtV8duAzF7Ak+GVyZ8wIPPf9iuYHOnZ/EmLPEBUf/J7wIBjgbxgcWVKndmbqw
         OOjA==
X-Gm-Message-State: AOJu0YxyfRDGu6/iYCaVs+TyRo6L+Er4JYFTdLOmFDtUBx+O60NbF+un
	lr6nZUSZdXt73GgRM4AZeO+BUDgAqdVygjzPFcze/IMy0CriDA==
X-Google-Smtp-Source: AGHT+IEJTyA6VGQ1pmR0QXu684SA+wL8v5iXMyFClIBeK7v/xkZcbvvbRveYDGi29Y53uIPAxZpchw==
X-Received: by 2002:a1c:7705:0:b0:40e:78ee:cb61 with SMTP id t5-20020a1c7705000000b0040e78eecb61mr431104wmi.94.1705311638683;
        Mon, 15 Jan 2024 01:40:38 -0800 (PST)
Received: from draszik.lan ([80.111.64.44])
        by smtp.gmail.com with ESMTPSA id w4-20020a05600c474400b0040d5ae2906esm19227470wmo.30.2024.01.15.01.40.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jan 2024 01:40:38 -0800 (PST)
Message-ID: <bcd89ef7a43eb7d652f045c029d8e108adf7ba32.camel@linaro.org>
Subject: Re: [PATCH] dt-bindings: ignore paths outside kernel for
 DT_SCHEMA_FILES
From: =?ISO-8859-1?Q?Andr=E9?= Draszik <andre.draszik@linaro.org>
To: Michal Simek <michal.simek@amd.com>, Rob Herring <robh@kernel.org>
Cc: Rob Herring <robh+dt@kernel.org>, Masahiro Yamada
 <masahiroy@kernel.org>,  Conor Dooley <conor+dt@kernel.org>, Mathieu
 Poirier <mathieu.poirier@linaro.org>,  linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, Krzysztof Kozlowski
 <krzysztof.kozlowski+dt@linaro.org>
Date: Mon, 15 Jan 2024 09:40:37 +0000
In-Reply-To: <827695c3-bb33-4a86-8586-2c7323530398@amd.com>
References: <20231220145537.2163811-1-andre.draszik@linaro.org>
	 <170432630603.2042234.10993333941885772911.robh@kernel.org>
	 <827695c3-bb33-4a86-8586-2c7323530398@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.1-1 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi,

On Mon, 2024-01-15 at 10:20 +0100, Michal Simek wrote:
> This patch is causing issue for me. Look at log below.
> I am running it directly on the latest linux-next/master.
>=20
> Thanks,
> Michal
>=20
> $ make DT_SCHEMA_FILES=3D"Documentation/devicetree/bindings/arm/arm,cci-4=
00.yaml"=20
> dt_binding_check

It'll work if you drop the 'Documentation/devicetree/bindings' part from th=
e path, as
it is implied since bindings can only be in that directory anyway:

    make DT_SCHEMA_FILES=3D"arm/arm,cci-400.yaml" dt_binding_check
    make DT_SCHEMA_FILES=3D"arm,cci-400.yaml" dt_binding_check

both work.

Cheers,
Andre'


