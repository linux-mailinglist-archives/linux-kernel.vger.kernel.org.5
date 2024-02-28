Return-Path: <linux-kernel+bounces-85703-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EF7386B98B
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 22:02:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BC27728CAF5
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 21:02:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FE8C8626D;
	Wed, 28 Feb 2024 21:02:12 +0000 (UTC)
Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C25D8624B;
	Wed, 28 Feb 2024 21:02:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709154131; cv=none; b=MNGkA5HrAptlgQsMhX3VNj9LULOmRVHFCz5EUN8j+PTLhkbF/iJZAncBXts/CHcIAJ7mmowcNMOkb+bet+LC3Sehm19Fzniy/lI+Cn4GQ8ARlkft2tlnOn15dGfKwuT6H2wWHOFlsLh7ehzojfTPtIx6kVUh0ubCE3R1jL/F+Dk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709154131; c=relaxed/simple;
	bh=f2E/PxHTdkAA66JUThG2R7iMitY1zi3+RidEBdAzSbI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XHNrkR0zuMhMDgPwzIPzU1wLpj0tyO5d7Sk3e6bDETcaQROm3jd+8UarIQ60fxd7fwvHXd1pdEM92xNAEQLg1HuS80BLRkBQreG5HzMNujuH1BDH/4W8IlfeClEbsfxIgw6h/Hmf4094v80rGXTEuJgtflD6e6r+wLEKWcjpCCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f49.google.com with SMTP id 46e09a7af769-6e4aa4877a9so29242a34.0;
        Wed, 28 Feb 2024 13:02:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709154129; x=1709758929;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0avo+3TPJ6C9EUCLGrpf7J7w7kB90jDxq4qRrj4Zxv0=;
        b=OSAztUX0NA83S2CJDIbXswASJl0SVSF1eMVWArfFh5NXK53kAk+waa7WKbGsMIRrcW
         Nwp1Hg8Y2REA4u5wvl0QHFtOrxL6ZriQ/FZ97ffZHO0hDE6yn1yeQXXu56P3/x6RJJaG
         +W0TZlv830pYbePh8Gy9RL6FzFDcGCnOSfhXBiWntDq5gWlvapCtLAPkLWphC12iNz5+
         r9YiisKiRZRB/66+bKADV4rqNL9sq9QY4oSqTQiU6rRGAaf9i3V5JbQ0sUQS4KTOemnA
         kZlvV1wPB+QXdC/ms/HnPB81siZuSycyUyxJIm4fWYliB1Bt4rqdti0V+4SnDCrRZ3o4
         /TKA==
X-Forwarded-Encrypted: i=1; AJvYcCX7ATJku6zlxehUXSyJFsFbP2QCN6AxN8bcedot9sPsZrK/xJggY/bgFzjeZNgDvMxuDMimLfTA/DPYXdDkGpbY4qlzZn6poBEJYhqUgufdWIT3DufPGLIUbQh6psKGie8Ij9Q5XHd/IQ==
X-Gm-Message-State: AOJu0YyRDH/g5Uhcrg8SeE5PVqQ0A9ohnb+Sk5a/0J7KJpe3Gnn6KmzC
	SMp0A47r7ABFztbJvChLpYlgG0YLtEV35zyNPmVFgMUoAKlEPTRZp9iC8t/Q7s1PRuSfTQKGEUA
	l7HMzhNWF5egojmypspsWXq/f9Gs=
X-Google-Smtp-Source: AGHT+IFdE9LB/cub6f7YK5AXJkUU9wAyIzEqghD6UR9pim6GcGMmJiookGbi7z8qGJ3v1XHyntEd6yM0iKdZrxq6LBc=
X-Received: by 2002:a05:6820:d09:b0:5a0:3d13:a45a with SMTP id
 ej9-20020a0568200d0900b005a03d13a45amr294699oob.0.1709154129401; Wed, 28 Feb
 2024 13:02:09 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240223155731.858412-1-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20240223155731.858412-1-andriy.shevchenko@linux.intel.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 28 Feb 2024 22:01:57 +0100
Message-ID: <CAJZ5v0gJm48gX_Gssfc_6QOky3WiRLY+Wb5_iEYHR_u5CCVgaw@mail.gmail.com>
Subject: Re: [PATCH v2 0/4] driver core & device property: clean up APIs
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>, Sakari Ailus <sakari.ailus@linux.intel.com>, 
	linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Daniel Scally <djrscally@gmail.com>, 
	Heikki Krogerus <heikki.krogerus@linux.intel.com>, Len Brown <lenb@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 23, 2024 at 4:58=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> There are two, but dependent pair of patches that:
> - hides unused devlink APIs
> - removes 'proxy' header use
>
> v2:
> - most of the patches were sent separately as v1, thus this series is v2
> - harvested tags from that patches (Sakari, Saravana)
>
> Andy Shevchenko (4):
>   driver core: Drop unneeded 'extern' keyword in fwnode.h
>   driver core: Move fw_devlink stuff to where it belongs
>   device property: Move enum dev_dma_attr to fwnode.h
>   device property: Don't use "proxy" headers
>
>  drivers/base/core.c      | 58 ++++++++++++++++++++++++++++++++++
>  drivers/base/property.c  | 67 ++++------------------------------------
>  drivers/base/swnode.c    | 13 +++++++-
>  include/linux/fwnode.h   | 13 +++++---
>  include/linux/property.h |  9 +-----
>  5 files changed, 86 insertions(+), 74 deletions(-)
>
> --

All of the code changes in the series look good to me, so

Acked-by: Rafael J. Wysocki <rafael@kernel.org>

for all of the patches.

The changelog of patch [2/4] could be a bit more to the point IMV, but
let me reply to it directly.

