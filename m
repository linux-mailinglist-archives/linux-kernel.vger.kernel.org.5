Return-Path: <linux-kernel+bounces-50143-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F08B98474D6
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 17:34:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8E4B31F2AA6D
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 16:34:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B7AC2E3E1;
	Fri,  2 Feb 2024 16:33:53 +0000 (UTC)
Received: from mail-oo1-f41.google.com (mail-oo1-f41.google.com [209.85.161.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AA8714830A;
	Fri,  2 Feb 2024 16:33:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706891632; cv=none; b=WRz9ZShQf4VnkaPI3/aSboMzx8dJYeO6W3Ocq8Hef1YmUtXlerWmfR8q2psip0JmUv9aj3Ic1nq0dGXM57zP5RY+yyi1USDNTaYx7lVR0wP5pi7hINuKxvIggFKWlD4iXBEOuBvk0CRR2/+Fv3RIOalmg1yzKbLnL15U19pjRKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706891632; c=relaxed/simple;
	bh=uhlj6Bq5Vf+ptYFkh6gLEAnY74QLGaRFcC6pbRV9cNM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VYRoljJ1KAB8J0GV/daoe2Vs1Ar5c9A2eP9/K7h8s+Ukzej8Qwws3mCmfT2b3aZkb2izIy3zoJW/aTZOY4dxCP6iGjcpY43juafW1MkusdB5WLpVo2wOYDSQe7kVamn5KBrgmIy3b3VnrbWMF3hpV1OGDcofsyDpbj8qXBoj9x0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.161.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f41.google.com with SMTP id 006d021491bc7-59a1e21b0ebso585821eaf.1;
        Fri, 02 Feb 2024 08:33:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706891630; x=1707496430;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uhlj6Bq5Vf+ptYFkh6gLEAnY74QLGaRFcC6pbRV9cNM=;
        b=on4iUjsmVnu70yioOaNr4ga0sIKPqEarBshdgqayd3S0EuRvIus5Fxud42nyittzmt
         lArXqv3ChUm/IxfYWV780DeGkKFiGQ4A9XXwkC3s2bfUWa++inTgDlg4S+Of3Kdn1gSS
         t358lfZ/FcRXeCG9kdGfRYNeNU+SLuD5asGlppufJ2lv8yGhhTF9Cdk7mJgz7pcvWQHX
         rFpNDwu4W2iDhOnAVioHVDI9EKbOMowFmbHRCF6/LFMRbpugPw4t9wOFqZxUuSAoCBrt
         uS11qSEHDR+0PyICHgXkwg2b7vCsu/D50GgxQGSRahAS736375eIw7jiDPbqI0yuE4M+
         7U9A==
X-Gm-Message-State: AOJu0YyJs9icunXsCt3rMwbKJfqo0V1E6tj2bUguOMeCMQFD0JyZ/BR6
	pATwsVPNQLbjK3gTlGvq0E2Bie5ao/uKIxXihIiG4I/4rrL8x+JrJUUMCm7RN0CkrvTGYCzM6VW
	l7KnzGtS2JvVAn75VUzhnnIWsG5Y=
X-Google-Smtp-Source: AGHT+IH5lbhNXYdvBNW6Z6n3Fh6gB83VX+7ceza1pjweZQFNpcqOeZkwUhLG4lR26gvzCsUTJwL+cw/Xb8a8+aCYyEs=
X-Received: by 2002:a4a:c810:0:b0:599:6d16:353c with SMTP id
 s16-20020a4ac810000000b005996d16353cmr6463248ooq.1.1706891630031; Fri, 02 Feb
 2024 08:33:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231002135458.2603293-1-andriy.shevchenko@linux.intel.com>
 <6531d1e01d0e1_7258329440@dwillia2-xfh.jf.intel.com.notmuch>
 <ZVt1J_14iJjnSln9@smile.fi.intel.com> <CAJZ5v0hk2ygfjU7WtgTBhwXhqDc8+xoBb+-gs6Ym9tOJtSoZ4A@mail.gmail.com>
 <ZVuVMNlfumQ4p6oM@smile.fi.intel.com> <Zb0O8o-REzAjLhzl@smile.fi.intel.com>
In-Reply-To: <Zb0O8o-REzAjLhzl@smile.fi.intel.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 2 Feb 2024 17:33:38 +0100
Message-ID: <CAJZ5v0hwNKm7bNS8uEhK-GVCibLaHvE75Rpc4oE9cpM6ByGmxw@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] ACPI: NFIT: Switch to use acpi_evaluate_dsm_typed()
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Dan Williams <dan.j.williams@intel.com>, 
	Michal Wilczynski <michal.wilczynski@intel.com>, nvdimm@lists.linux.dev, 
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Vishal Verma <vishal.l.verma@intel.com>, Dave Jiang <dave.jiang@intel.com>, 
	Ira Weiny <ira.weiny@intel.com>, Len Brown <lenb@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 2, 2024 at 4:49=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Mon, Nov 20, 2023 at 07:19:44PM +0200, Andy Shevchenko wrote:
> > On Mon, Nov 20, 2023 at 04:11:54PM +0100, Rafael J. Wysocki wrote:
> > > On Mon, Nov 20, 2023 at 4:03=E2=80=AFPM Andy Shevchenko
> > > <andriy.shevchenko@linux.intel.com> wrote:
> > > > On Thu, Oct 19, 2023 at 06:03:28PM -0700, Dan Williams wrote:
> > > > > Andy Shevchenko wrote:
> > > > > > The acpi_evaluate_dsm_typed() provides a way to check the type =
of the
> > > > > > object evaluated by _DSM call. Use it instead of open coded var=
iant.
> > > > >
> > > > > Looks good to me.
> > > > >
> > > > > Reviewed-by: Dan Williams <dan.j.williams@intel.com>
> > > >
> > > > Thank you!
> > > >
> > > > Who is taking care of this? Rafael?
> > >
> > > I can apply it.
> >
> > Would be nice, thank you!
>
> Any news on this?

Fell through the cracks, sorry about that.

Applied now (as 6.9 material).

Thanks!

