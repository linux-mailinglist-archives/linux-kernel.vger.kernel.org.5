Return-Path: <linux-kernel+bounces-104397-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 430D787CD3D
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 13:28:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D106DB21E4A
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 12:28:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E0E51C6BC;
	Fri, 15 Mar 2024 12:28:12 +0000 (UTC)
Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35E551AAD2;
	Fri, 15 Mar 2024 12:28:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710505691; cv=none; b=fM+s3vEpyH/8Ly8l3zAwFoCzyfbUYkUQl+IWA56OPzoA3dE8Hv93HOCxZ4NZMEm1p5BnbavLoVRLo7lEaF5y97vyyGo08HLHxA7zt/e8hCtDbNr2ouAb5UUHnVLAb3LsZeM04kfkpQ0d5xsbdhQqExNxwEktspd+WLy6wjU18Q0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710505691; c=relaxed/simple;
	bh=Jue/LIAxwV6F+/SVwPKt9ySNu2ex3QNTL7w1vp43f4A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=l7mzYt5DBUxoBF39i9eqeS9R6Z8MKFZS6uxUEvcIngnCs4xYBx+oTa9cXhS/LSgUkkT50QXvFxAvaJMNWc9Qsw0/7DNun8JnepwI34c+I6e6eQRRD7WpylHTDsUU4QQE6E39Hn6APr1cbSvR2R2IQiJPBr3tdFBNGjV1ry0Vyc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f49.google.com with SMTP id 46e09a7af769-6e677ec9508so110391a34.1;
        Fri, 15 Mar 2024 05:28:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710505689; x=1711110489;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Jue/LIAxwV6F+/SVwPKt9ySNu2ex3QNTL7w1vp43f4A=;
        b=MRfqjJElXbUpoaIOJfvsgua7Vu7MmODSVY3uGRUK47y2IkjPEuDQttZ+cGAf3LjRuT
         qGU97tJPr8Hyy+otyLYblO3LMy0nQzzgmEwwz7I8dV/fngb092XnOGvTOySePTkXZskA
         8iB6ZsCIkUrAgZXxQlUUl2A9TgqGBwf9DkZqVH/lX5cC9xtZ66hFB9wYOLG9mbSMBvWg
         U/GHxZjXT46edSPKsd51bmkJlM8PnVBZHic5+XGZbFiNlHNCgOutQfu9XHORraR3PH8X
         s2Tna/xE+aUR0BnSlBRWY2RJgo6UIQ8TdT2U9fY/WTKXemA1Z+/CKEB+V4TMf9ILbroc
         obxw==
X-Forwarded-Encrypted: i=1; AJvYcCUmn1zZKUVvOUQh7w5yJgHhbz8L0UKdl2bfSnq8eg/Ua/123Y8JxrMWp/a3exnVa507sJl7gLqmkOI3f6B/E7lEejXXDXo2LBiG1VFXTiTVEVkbcNksr9Ba/qvcJalmsIXricSj0KItCg==
X-Gm-Message-State: AOJu0YzE+aAgNHuwrTptEyfUK6Xe1aoEDFcMr1Y4D4tmeq4HdCFh+P7K
	Ob73CEHVct+o7CjF+g3zYtjtZ8Nnd1JjPxnJQ2CudtDpK9TXBgG6Mda5yBVkSEY0ewYnk70MmXM
	FUg3KO9ZEWa2OFsTLkd21P+nFq3Dyayph
X-Google-Smtp-Source: AGHT+IFcaUn8z7QjpJtzdEzYON3twDaQcEDAxvhwcLtUg6lgIfiH2mYgkJlW2YRsUaNMBo74pGBEryZ+3digzjdqIrs=
X-Received: by 2002:a05:6870:3053:b0:221:bc20:76e1 with SMTP id
 u19-20020a056870305300b00221bc2076e1mr2168790oau.0.1710505689257; Fri, 15 Mar
 2024 05:28:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240315003753.96173-1-yang.lee@linux.alibaba.com> <11706f70-539d-43b3-8b5d-e20bdd38d23b@infradead.org>
In-Reply-To: <11706f70-539d-43b3-8b5d-e20bdd38d23b@infradead.org>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 15 Mar 2024 13:27:58 +0100
Message-ID: <CAJZ5v0hmCXgfgECyG+B_Hp10nHchQN-EvF6oQYtW6fT81JoiqA@mail.gmail.com>
Subject: Re: [PATCH -next v2] ACPI: Add kernel-doc comments for ACPI suspend
 and hibernation functions
To: Randy Dunlap <rdunlap@infradead.org>, Yang Li <yang.lee@linux.alibaba.com>
Cc: rafael@kernel.org, linux-acpi@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 15, 2024 at 5:55=E2=80=AFAM Randy Dunlap <rdunlap@infradead.org=
> wrote:
>
>
>
> On 3/14/24 17:37, Yang Li wrote:
> > This patch enhances the documentation for the ACPI power management
> > functions related to system suspend and hibernation. This includes the
> > use of kernel-doc style comments which provide developers with clearer
> > guidance on the usage and expectations of these functions.
> >
> > Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
>
> Reviewed-by: Randy Dunlap <rdunlap@infradead.org>
> Tested-by: Randy Dunlap <rdunlap@infradead.org>

Applied as 6.9-rc material, thanks!

