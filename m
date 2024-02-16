Return-Path: <linux-kernel+bounces-68987-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EEE485830A
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 17:53:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DB2E6B21607
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 16:53:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43979130E2F;
	Fri, 16 Feb 2024 16:53:25 +0000 (UTC)
Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 600C71E879;
	Fri, 16 Feb 2024 16:53:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708102404; cv=none; b=jjf1hnA0sZpEeT0aRaXOkJSKkB0n6gOE1IMAeGnCbS5noDmnoYCD5r4pYQRAXCVMeEUALtzVbNWfTAEHEa9eGqoSMww6pj02sSnmBjbOYkROZDr3qhrV0io+QNI//Fanct69OBsHQqs5EYIZ9twuVfkVyyJFYGFRJwz5YdUNNJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708102404; c=relaxed/simple;
	bh=FErjLzag8OvcHwPfyzJVxp8QFozpPaEbf6tXjp7xCb0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nZc+77v6VR1q4pdASomkubsznsP9P/dOoFl0IG/ViesbAJVQOkXojDXQFKmbI/Z9ohcUPRQWgb6go8EZdJRV9fRX35FkLoavcfPD9CeqW6BLmRvTgApEiTmu7ZmKUeS73/n+3cvIjHWDJ95jDLL6hBPfryh5N2nQn0VAaPM7E5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f49.google.com with SMTP id 46e09a7af769-6e2edfb179fso208070a34.1;
        Fri, 16 Feb 2024 08:53:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708102402; x=1708707202;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GVWResm0Z43h7lfco2aJn1h4JDvvPOfEAaX8sh8Rwzw=;
        b=bzsTO/2JZnoowMQxWfJBAYlmxn6YJj0bbtdZOJ5HfMNV4TnYOSG5ucrtdpsWZerNtQ
         pCmnzr9bDmWW1tV3KvIGL9/5BT26cU2Tnah06noRGUVU3D5vUyCiVFCiopZju6MUrebB
         C065B3AF6i7350ZI3jwVVnTqRNJJwQ2l43ASqur+QpMRFrLJ8auqrTWY5sL4kgWktA9t
         wXl8YD+i4Flwil5HT/JktMk1tnxB4YpeVaqD/o6xeMAzwNnGCezt+haeoM3S8XwDyMdh
         ui0s104eRscQbyeW+UbaUotQXVtrjNhAYrOOePPtiExSzAeoCKp33JJxzzlZPhd0Dy69
         RaYw==
X-Forwarded-Encrypted: i=1; AJvYcCXjdE2rSWVhgFP2Ai0qx+ZDi80SxMHC8biT1Cgc0iLCfqDoE0NWfiQ1xrOS+f7M8SU6m59kCYxEMoGBrk+jgtnA/x2fiEY+DqbtI2glQpoLEXmFpYLF/kFFYNY5jYX6i4j5X02dnpJIIw==
X-Gm-Message-State: AOJu0YyUOxjqlDL/TJzDfxIMwTPCferQ+kx3vNRkEhPNm8Vs2qGJO+Cn
	NhEXhi+pEBsbSvtBUWTmbVHeQwnxYO9Ziibq35oxd0GbEi9feZT9YlRj1l7S8eMHuh6QEZTwrgj
	q79ql4IwiVr0Gjux3XG55JiCMghs=
X-Google-Smtp-Source: AGHT+IGGP0e6FHjGweMZDJsiihSYm5flh2qWeV/G4aDYOfP/un+SaDim/4yTtp7Gk74igLHZtx7ZtKW0BPKo5BBbodM=
X-Received: by 2002:a4a:e749:0:b0:59f:8e0f:8a34 with SMTP id
 n9-20020a4ae749000000b0059f8e0f8a34mr2854822oov.1.1708102402288; Fri, 16 Feb
 2024 08:53:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <6029478.lOV4Wx5bFT@kreacher> <Zc-SQ1SM6i6RCsRo@smile.fi.intel.com>
In-Reply-To: <Zc-SQ1SM6i6RCsRo@smile.fi.intel.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 16 Feb 2024 17:53:10 +0100
Message-ID: <CAJZ5v0jkp2SP5DDg5eYkZu9_buQ7i2isGfgJYvD2ZHFKtTr_DA@mail.gmail.com>
Subject: Re: [PATCH v3] ACPI: Drop the custom_method debugfs interface
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux ACPI <linux-acpi@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, Zhang Rui <rui.zhang@intel.com>, 
	Kees Cook <kees@kernel.org>, "shiqiang.deng" <shiqiang.deng213@gmail.com>, 
	Sebastian Grzywna <swiftgeek@gmail.com>, Hang Zhang <zh.nvgt@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 16, 2024 at 5:50=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Fri, Feb 16, 2024 at 05:38:55PM +0100, Rafael J. Wysocki wrote:
> > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >
> > The ACPI custom_method debugfs interface is security-sensitive and
> > concurrent access to it is broken [1].
> >
> > Moreover, the recipe for preparing a customized version of a given
> > control method has changed at one point due to ACPICA changes, which
> > has not been reflected in its documentation, so whoever used it before
> > has had to adapt and it had gone unnoticed for a long time.
> >
> > This interface was a bad idea to start with and its implementation is
> > fragile at the design level.  It's been always conceptually questionabl=
e,
> > problematic from the security standpoint and implemented poorly.
> >
> > Patches fixing its most apparent functional issues (for example, [2]) d=
on't
> > actually address much of the above.
> >
> > Granted, at the time it was introduced, there was no alternative, but
> > there is the AML debugger in the kernel now and there is the configfs
> > interface allowing custom ACPI tables to be loaded.  The former can be
> > used for extensive AML debugging and the latter can be use for testing
> > new AML. [3]
> >
> > Accordingly, drop custom_method along with its (outdated anyway)
> > documentation.
> >
> > Link: https://lore.kernel.org/linux-acpi/20221227063335.61474-1-zh.nvgt=
@gmail.com/ # [1]
> > https://lore.kernel.org/linux-acpi/20231111132402.4142-1-shiqiang.deng2=
13@gmail.com/ [2]
> > https://stackoverflow.com/questions/62849113/how-to-unload-an-overlay-l=
oaded-using-acpi-config-sysfs # [3]
>
> I believe you missed Link: tags for 2 and 3.

Obviously, you are right.

That's easy to fix, though, and I'd rather not confuse people by
sending a v4 just because of this.

> > Reported-by: Hang Zhang <zh.nvgt@gmail.com>
> > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > Reviewed-by: Zhang Rui <rui.zhang@intel.com>

