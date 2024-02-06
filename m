Return-Path: <linux-kernel+bounces-54702-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A842284B298
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 11:38:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6499B284850
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 10:38:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53C1D1EB24;
	Tue,  6 Feb 2024 10:37:41 +0000 (UTC)
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99B1818EB2
	for <linux-kernel@vger.kernel.org>; Tue,  6 Feb 2024 10:37:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707215860; cv=none; b=PRjN1ZTuJScAoWnuActMq/JwSesqoPDr4ujImBdZg0cQLawrP2tJ3LNbwB8tGgeextLTTaSsg2MMbyjb+X9nIGH1uGi8FTl02Hot1ZFYXFcDWADfvc3sdizMpi/FlzAIdcTkSSj4STWARxhk9X1kFmbJC/u9abeXzmSpkSb/rCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707215860; c=relaxed/simple;
	bh=vYqglejBEbIWhsWJJRgary59v9AvUT3cInJMjawD7nc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hsoHYIMnVIKkSzIeDpQb/yVihYFRccyAX8EOvRzCJHzAQDvhKVpkiUFuK4o+GEjQfCOs3cvT96J9Og7Md7vSxqOj2gNAnjKDZ22kXedqWhKeaip/5cTDHxlL87sdvl8hR2o5cOzfKnUbaLl+DyTyGB6R0GUd9H+dEQvKk5rJhLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-290d59df3f0so4423371a91.2
        for <linux-kernel@vger.kernel.org>; Tue, 06 Feb 2024 02:37:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707215859; x=1707820659;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vYqglejBEbIWhsWJJRgary59v9AvUT3cInJMjawD7nc=;
        b=ln3WvuxCzIHXlGV0SC+y/A9DEwPkeh2dpaTTcmasZN5VENljWO27dxipTQmgthjX7l
         xboQihjdxcS/JY5jTfo/AHnms6nRpobtt+J/bHcfBgF0PGfB/Mkw34q0HbgeVNvQAE7S
         G85zvqEavAvhuUZZsjZ/ycDfWksXRy0YJyrJvWDOee1Dsg3r+thg9Pf0Bej6WBvkA/1T
         BaegtVyQkGu/enXCXaY/pDWrLFp+ykb9ottZHLYeUNVODy6FLIqQtqk4o6BpIUVP1VGc
         3q1tvkscIDRf/P5+4umRoMdW9MG92bppdEtH7AyVSZN4n5WDe9ncugDS7DZupTvdBALV
         6spQ==
X-Gm-Message-State: AOJu0YwsAZ8PcHrV8dRsoZoErQXBB3/mVOh2Q0keXvztALkVjR4e0RgQ
	y4pnkLdKEhSgfROkOcPndHZd8QPWbQk7tDf7mX2kRivpinEtI3sEV6oo+drpXGRYqQ==
X-Google-Smtp-Source: AGHT+IEtRSGeej+ME2jvYs9A4uZnQmYhV7MqlhSScfDOTwYmlLtelmefEXtHf1H4MOcNiZp83c8AMQ==
X-Received: by 2002:a17:90a:ea07:b0:296:2d0f:bba8 with SMTP id w7-20020a17090aea0700b002962d0fbba8mr2183021pjy.43.1707215858910;
        Tue, 06 Feb 2024 02:37:38 -0800 (PST)
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com. [209.85.210.180])
        by smtp.gmail.com with ESMTPSA id cm17-20020a17090afa1100b00296885dcef7sm1178917pjb.16.2024.02.06.02.37.38
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Feb 2024 02:37:38 -0800 (PST)
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-6da202aa138so3431155b3a.2
        for <linux-kernel@vger.kernel.org>; Tue, 06 Feb 2024 02:37:38 -0800 (PST)
X-Received: by 2002:aa7:868f:0:b0:6e0:3ef3:db3c with SMTP id
 d15-20020aa7868f000000b006e03ef3db3cmr2091250pfo.29.1707215858019; Tue, 06
 Feb 2024 02:37:38 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240204-bus_cleanup-mcb-v1-1-d84b2ef51a0b@marliere.net>
In-Reply-To: <20240204-bus_cleanup-mcb-v1-1-d84b2ef51a0b@marliere.net>
From: Johannes Thumshirn <jth@kernel.org>
Date: Tue, 6 Feb 2024 11:37:26 +0100
X-Gmail-Original-Message-ID: <CAGH8bx40HJdwf23GFZbbnUa0CsFEXjOod9ea1bWOvm-Uqpt6iQ@mail.gmail.com>
Message-ID: <CAGH8bx40HJdwf23GFZbbnUa0CsFEXjOod9ea1bWOvm-Uqpt6iQ@mail.gmail.com>
Subject: Re: [PATCH] mcb: make mcb_bus_type const
To: "Ricardo B. Marliere" <ricardo@marliere.net>
Cc: linux-kernel@vger.kernel.org, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Feb 4, 2024 at 9:02=E2=80=AFPM Ricardo B. Marliere <ricardo@marlier=
e.net> wrote:
>
> Now that the driver core can properly handle constant struct bus_type,
> move the mcb_bus_type variable to be a constant structure as well,
> placing it into read-only memory which can not be modified at runtime.
>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Ricardo B. Marliere <ricardo@marliere.net>

Looks good,
Reviewed-by: Johannes Thumshirn <jth@kernel.org>

