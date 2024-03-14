Return-Path: <linux-kernel+bounces-103912-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AE9087C67A
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 00:37:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2BE2A1F22F7B
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 23:37:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E91E114AB4;
	Thu, 14 Mar 2024 23:33:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UgrDhKWy"
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9414714A81;
	Thu, 14 Mar 2024 23:33:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710459239; cv=none; b=WbUxa8mN0RJfFRZcIS8ItAsyoeY7ZjQsez/0QL4XsmInY2cTALp656/wcQHrF4dVoXNAa0RGF4yJxDKfFMRksxWeZSplrQ5w0dsQI1B1FUjNa6NplLGge0KBKStS41PGqNQSLBUcTyRjeYYjTTVO530bKXVPgVoKYt7LpzULgEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710459239; c=relaxed/simple;
	bh=5cD+Utc3WZAxdjmYk1QQU76mBRdqBdbJ5yIsDLbC17g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LamkA9QTfTNEWDYkKdLZBhUuz9VhqwRb2ovrMyldBqYXFMmHGebBbiNpRVON34A+xUtLyq+u7w9qT+/NS2wj9/jINPq/38QlIW8RzaWa+tuNuWvjzOxgrRetjv1pV6lT3i/rmTH86DZWT7xT/Q8mmU+YzKu2ztiftGDr7TYySg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UgrDhKWy; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a44f2d894b7so160924166b.1;
        Thu, 14 Mar 2024 16:33:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710459236; x=1711064036; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9/n7FNd6KF/52kgUyrLcID4ELpWfz14+WSwkN1SHe18=;
        b=UgrDhKWyrH6B5y5oCd7dl2R7JOVkrp+96seSLJuHH7H+w64GnPbEAHvS0rUGlflhVW
         nyClZyR5Oixzq23uT+YwU09W4L4o2OkW391KNU3gqRYEfKUTURHhmTItd/baMqbVBKpZ
         xPRHpI5exFsNAjHOLKA/G26XcDLaDxuX6a253KIKixHCfC3GbO+CSXYOxGv/BI/HT1C7
         ard4/tZ+7PuFTfMnojVZ2MNsM+huYE9DGsSTHuc6IjDYkU+MZ+EEtlX9c40/Le83VxwH
         RbZjqE0szemiN58bvZlZcnLpkqlLbAQcU6V6HrhR/Wl6Hpef1toGV5gaLZuVGD8qOVTk
         nsXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710459236; x=1711064036;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9/n7FNd6KF/52kgUyrLcID4ELpWfz14+WSwkN1SHe18=;
        b=CheE/z8Zxp90PXqUHozlDlvRfcYgFkiGLbJrso91wIn9Y9uuVPL2wsGW2ZGjuCZLWW
         k06kTbzzU+VxCMUQXgRDhjNkL9Ozp3lSlX7PlsZD92hy8H0GQ0zh0KaVR8phbah5z6wx
         RUuIyv0mqCghYWqsppTqSGL5TzIAvnoEIPdTK70uVAVxKmYyEBKWCe/9GFGvMi9NBQrL
         FlsvOg8px4lLQMEUrLLzk8dxdQzDStRVK3AARHaq0WnekViLKU5quarjJEr00U3GWjr+
         D79heBe7H2N/MxQLPH9mQiKJMN096MBT1wo2p3Y0z+hod4G9nMnP8w/pGGS2MdrqqNCj
         qDZw==
X-Forwarded-Encrypted: i=1; AJvYcCWn6NUayyVMeHW5iO8B5yNjTMv8ab5Pd3O+jvlXwI0v/YkRgLmp3ksMzdjoInwFnjOY7JcQWY2roYGsXfzi+S72cCLk2kDS9NNGciVklDLhRgvaIIbgQyZ1dJ93QbI7HsEgiFsKXihnEw==
X-Gm-Message-State: AOJu0YwccX4qRh/sGeblorfJb4qHw3+yI/E2B+B1RtrPkGdrv2+TC5Lk
	hExCLbsdXCowP6dVrO9KTxCgIOLJdspYt9Jc3XX+uhuXS3RkgfWQhAcojB+aAZlXAOqDZ2L45lf
	QwdqsiPGSEZBdYd5A/I0MggbHqlU=
X-Google-Smtp-Source: AGHT+IFG1MsEa8rzFDkEffr39S8L8cz1+zz9I3sgFp2+e3nVoirQ1GwR2OUdsfFfYV8sRDT8uaZ7U9fqTwyPnLm+qME=
X-Received: by 2002:a17:907:c313:b0:a46:58b4:a34a with SMTP id
 tl19-20020a170907c31300b00a4658b4a34amr2815716ejc.47.1710459235740; Thu, 14
 Mar 2024 16:33:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240314201856.1991899-1-gnstark@salutedevices.com> <20240314201856.1991899-2-gnstark@salutedevices.com>
In-Reply-To: <20240314201856.1991899-2-gnstark@salutedevices.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Fri, 15 Mar 2024 01:33:18 +0200
Message-ID: <CAHp75Vd+UUY76K1Z0F4L=hqAfpAy=K8L26fqvh9-xeTHq3nf-A@mail.gmail.com>
Subject: Re: [PATCH v7 1/8] locking/mutex: introduce devm_mutex_init()
To: George Stark <gnstark@salutedevices.com>
Cc: pavel@ucw.cz, lee@kernel.org, vadimp@nvidia.com, 
	christophe.leroy@csgroup.eu, hdegoede@redhat.com, mazziesaccount@gmail.com, 
	peterz@infradead.org, mingo@redhat.com, will@kernel.org, longman@redhat.com, 
	boqun.feng@gmail.com, nikitos.tr@gmail.com, marek.behun@nic.cz, 
	kabel@kernel.org, linux-leds@vger.kernel.org, linux-kernel@vger.kernel.org, 
	kernel@salutedevices.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 14, 2024 at 10:19=E2=80=AFPM George Stark <gnstark@salutedevice=
s.com> wrote:
>
> Using of devm API leads to a certain order of releasing resources.
> So all dependent resources which are not devm-wrapped should be deleted
> with respect to devm-release order. Mutex is one of such objects that
> often is bound to other resources and has no own devm wrapping.
> Since mutex_destroy() actually does nothing in non-debug builds
> frequently calling mutex_destroy() is just ignored which is safe for now
> but wrong formally and can lead to a problem if mutex_destroy() will be
> extended so introduce devm_mutex_init().

..

>  /***

Unrelated to your patch, but there are too many asterisks :-)

>   * mutex_destroy - mark a mutex unusable
>   * @lock: the mutex to be destroyed

--=20
With Best Regards,
Andy Shevchenko

