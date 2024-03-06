Return-Path: <linux-kernel+bounces-94183-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A1AE873B04
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 16:44:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5BF8B1C210AD
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 15:44:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A4A613791C;
	Wed,  6 Mar 2024 15:43:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="csZvXbCp"
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55D2B13664D;
	Wed,  6 Mar 2024 15:43:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709739815; cv=none; b=N62lCWHM5M7E/HsZPusQETub65FD8gNH3fKC2fOFUZ25wOUwpCisgjT9fYBGQygwuhiYE+QeqO0GYL6Ww4GjZfMxtVTKliQ2ETq9v7rIEWwGkNekCyIwRzXWIlWjUTOdo3Ic+jhVX0DI3m72hO4uMT8Fz1DaHy6WNDhCLrvHFdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709739815; c=relaxed/simple;
	bh=L54QSDfP6jYa7LP99ropL3BoZ+PWNlbhNlP3Am7ntYg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=o9eNSvNzTB/ASPxtOS26xTAndCVbuhL9805iGGh9rQpGgkbfE7AZRB6hC9P0JeY6XilDKjXXupmj+1iQFCA4gik6P1lpd61URNYiTrxmF7GU0wgWavsGyOF8YDwTCY0uBp+lHD00X3D8HUcHFDBaSQMK3hEx/Go7o6Zv8m/nkKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=csZvXbCp; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a3ed9cae56fso186097166b.1;
        Wed, 06 Mar 2024 07:43:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709739812; x=1710344612; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=564XW1Zg593J2gO92SEH6dhjFbJFfOOzGq+FzdnpDxA=;
        b=csZvXbCpF0PySNx8nIASfPzNisRYGn+sAWi+MtBSj2rowD9bW8K/5qq7lxr4/ggLYv
         4aGAGELdkzRW6LKEJ702oQOMaYUIKj8pNlAfUcsGvzINxuOK3e77kw7bVnSPl5qsEZB7
         DrfAEHvr1l3ydIqoruPhmYDGEhlK953sKowGWntqIS8ZxU4laWAYDniF63Wp+zy82eUq
         UgIJH9dE1rqD0oRAaN+MbP+63qyOREQMyDKeNFPOGSTe0w+o3ifVmtyXjYW9PmO4f6JW
         UhjTjO2C01ZFyCPhGxLGAHc9B75F8elXIGvj0yF94FEA8u9T4fTLBhqKzlhF1YL2DFXI
         jBYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709739812; x=1710344612;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=564XW1Zg593J2gO92SEH6dhjFbJFfOOzGq+FzdnpDxA=;
        b=gNCVfoD65tI7b3+Y3xW7qM2iUlqPQPv7i0sBU7VkVBA9zCYtRowNCo0GL5tKt5Mkf7
         wXMmup0qPnSocz+YrMNc4KxdpeUoeRusaOcQSbkR5+2DKrwurn1FtAPHg2OSOIMRyiiG
         VjwdquQBTWbv0x6xZ8WvaN8D/higNrzHoO/XHO8XYHrM4MtMlKqdHp5CrpC2IskLqEnE
         qRYSXFUxLDAOq6NQKOud4v0+EbSadT6J3Wn8b6ewGltLdtfmg6xo66q2wrWcEI9Mk4nw
         x85C1o+oH6ObHeAM7zH0KYxnt8QhlEObBegjVFcmRWgi68rsAXcehVNLSkCuN863DZgj
         g2Ww==
X-Forwarded-Encrypted: i=1; AJvYcCUXkHaMb6FAHLiEEpFQ51t/jexvN8Po5gOGztRDheKagjtMZX/OzjY0CMcU4hUiJWBC1GBsGEKhwK+pmqnkeT6UgCywdMkJ+FErkOeL
X-Gm-Message-State: AOJu0Yx0yR7kfQVtRc9ZPtbuApp1+nmlXg4K1tOAJqkyqGRZom/F3BAO
	lfNa9FJMrB8fADjXMs8EyqgNaZ/b0Sdw3AG4g2gUcstUnrrYL/uJHs1TDnzX71o34Khr4DmYWtH
	Vz0B3swLjcBlGjjnvTzYUL9VSjnE=
X-Google-Smtp-Source: AGHT+IEYVgDvWAx0tkMslUDJ6VQQCdyJISWKYeieeoobQ8e5jZzjaqU/edPut17SR+CFrTtOMHlgrdnSmMQ8Fwrr2oo=
X-Received: by 2002:a17:907:6d13:b0:a45:9e6e:fba1 with SMTP id
 sa19-20020a1709076d1300b00a459e6efba1mr7618951ejc.15.1709739812372; Wed, 06
 Mar 2024 07:43:32 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <b442a768dd23d9c6fdac6fcc30bc86794e85c8f5.camel@gmail.com> <0eb384a3-5634-453d-b08e-a80db3fb742d@moroto.mountain>
In-Reply-To: <0eb384a3-5634-453d-b08e-a80db3fb742d@moroto.mountain>
From: Ayaan Mirza <ayaanmirza.788@gmail.com>
Date: Wed, 6 Mar 2024 21:13:20 +0530
Message-ID: <CAFSNnn2BsM-DmnT9Or1fCTKMCG58ruNE7vrBggQuns9-_K67HA@mail.gmail.com>
Subject: Re: [PATCH] Subject: Improved help text for rtl8712
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thanks for the tip! Will keep in mind!

On Wed, Mar 6, 2024 at 8:46=E2=80=AFPM Dan Carpenter <dan.carpenter@linaro.=
org> wrote:
>
> Also the subject is wrong.  You left out the subsystem prefix.  It
> should be:
>
> Subject: [PATCH] Staging: rtl8712: Improve help text for rtl8712
>
> regards,
> dan carpenter
>


--=20
Regards,
Ayaan Mirza Baig

