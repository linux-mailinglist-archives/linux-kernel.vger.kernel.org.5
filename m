Return-Path: <linux-kernel+bounces-11594-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 946FE81E8B5
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Dec 2023 18:27:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 244E61F21E41
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Dec 2023 17:27:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71B4C4F8A7;
	Tue, 26 Dec 2023 17:27:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="NANZXvQs"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73B574F880
	for <linux-kernel@vger.kernel.org>; Tue, 26 Dec 2023 17:27:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-4277e7146abso42815991cf.1
        for <linux-kernel@vger.kernel.org>; Tue, 26 Dec 2023 09:27:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1703611624; x=1704216424; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qF6xW1bdeiaI+KNkFjHq71eA86SN7AHEznnIaUPRnMI=;
        b=NANZXvQs76I4zfIEF/R/Gv4JxV+OmPnaFxBTbtf4hRuJ57nKFXpVMmMBLf+3/lri1U
         M2leRqU+B9ICxcaFWlc0oClARdpEr9Y4NDGxzMnB313EoyHQ4BOaqAFqr6jGh9tFO0Qf
         3agpfcgIl1y5J834dQO0w7OdSAdMnOO+1BW+1DN1XExLnQ1786VaCa2Tgh80/Db6gqvO
         w9bayRvvJuRDQI+C5UVnIOnFxmRtz8nASIMFQzB/zRCYbFw8K7+J8MGGxnlPsrr8dffS
         rxyXRZ8V0joY2TsPfOWzW4UaPtxAeRNmWj0J/9j6wwEepwtRserDEnny+tibIuV3G7IN
         /4MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703611624; x=1704216424;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qF6xW1bdeiaI+KNkFjHq71eA86SN7AHEznnIaUPRnMI=;
        b=PrWFvZEI8EnLnvRwCE/avO4oPvu25H9iAjRYcC5UZbqIbzED1Ukoiit3Jzp4ZD5g26
         qc3LtGq7n5F6N5NjKa/5as0xklz8R3+q0iQTEgGfwpmKKPMVDzfrgJEeA0KaQhJNcYuq
         0iKc9XcKgdxMdpVi+34FEaicmQ7s7UpDrJNQ692ahyQ4LOmg6ExcEO4ac0MHG4WA5kr+
         zera9eFtzODe+9eVcffUndDoDgcQLMyjd3DAEgOCNLFrmFK28xLXg9TJGu5yHijqYn09
         zTlauqGRqwlv74Fdf33B30qhwE/vT/CAdpsCH/r8CxMvlDcWQoDy3SfUYtkRKJWXhT/K
         VNGw==
X-Gm-Message-State: AOJu0Ywr5rbh+nx3aeO8Egbjdn1aghHSmUJMGv6+cNhHIm5wFxxhlKts
	iWPumG2tQecMLEH9p9PsOzDDizEbkgahk1Nktn45cUJr1WPwBA==
X-Google-Smtp-Source: AGHT+IH6JuPA8UpnDuV4pxNWx2qfVnI+AAQgcgG4cJ+LVKws3skpVkqpE1GlHsFAzqe0zp/iS42nIMznuVlXnxn82Uk=
X-Received: by 2002:a05:622a:11d1:b0:427:a316:a26a with SMTP id
 n17-20020a05622a11d100b00427a316a26amr11771992qtk.69.1703611624440; Tue, 26
 Dec 2023 09:27:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231211154644.4103495-1-pasha.tatashin@soleen.com>
 <3d415ab4-e8c7-7e72-0379-952370612bdd@google.com> <CA+CK2bA2vZp3e+HHfB-sdLsPUYghMxvKcWURktDtNjwPL79Csw@mail.gmail.com>
 <b1049bfa-68c4-e237-30a9-1514a378c7f1@google.com>
In-Reply-To: <b1049bfa-68c4-e237-30a9-1514a378c7f1@google.com>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Tue, 26 Dec 2023 12:26:27 -0500
Message-ID: <CA+CK2bBxbvO-osm5XKk4VkaXYgfZXkDAtfayaYJ-vXo=QFqGPA@mail.gmail.com>
Subject: Re: [PATCH] vmstat: don't auto expand the sysfs files
To: David Rientjes <rientjes@google.com>
Cc: gregkh@linuxfoundation.org, rafael@kernel.org, akpm@linux-foundation.org, 
	surenb@google.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	souravpanda@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Dec 24, 2023 at 4:26=E2=80=AFPM David Rientjes <rientjes@google.com=
> wrote:
>
> On Thu, 14 Dec 2023, Pasha Tatashin wrote:
>
> > > > Whenever a new fields are added one of the following: node_stat_ite=
m
> > > > numa_stat_item zone_stat_item, the /sys/devices/system/node/nodeX/v=
mstat
> > > > files are auto expanded.
> > > >
> > > > This is a problem, as sysfs files should be only one value per file=
.
> > >
> > > Does this patch address the one-value-per-file issue?  (I think that =
ship
> > > has sailed for vmstat.)
> >
> > That ship has sailed for vmstat, this patch addresses what was asked
> > by GregKH: not to add new values to vmstat, as not to make the
> > existing problem even worse. The sysfs file system has a one page
> > limit per file. The developers will decide how to export the new items
> > added to node_stat, numa_stat, zone_stat individually. Each new item
> > can be exported in its own files, and must have its own documentation
> > about interface stability, value meaning, and expectations when the
> > stat file is absent.
> >
>
> As of at least 6.5, /proc/vmstat is a strict superset of the per-node
> vmstat.  Why is that a problem?

The intent of this series is to stop auto expanding
/sys/devices/system/node/nodeX/vmstat as sysfs should only be one
value per file, and the task is not to make things worse. /proc/vmstat
is mostly ok, however we might not need to auto expand it as well, to
avoid situations where removing a field becomes a problem, and we have
to keep it in the file forever, like what we do with nr_unstable.

> There's great benefit to being able to use the sample implementations to
> parse either /proc/vmstat *or* the per-node vmstat and without needing to
> read the per-node vmstat plus some new set of sysfs files that are
> one-value-per-file.  The per-node vmstat will always be multiple values,
> in fact it's a key value pair.

Yes, but that file is already large, and soon can overflow a page
size, instead of converting it to a binary format, let's add new items
as one item per-file.

> I have to think that doing anything else for vmstat is just adding
> complexity (like this patch) and actually making it *harder* on userspace
> to read the data it needs.
>
> Yes, the per-node vmstat likely shouldn't be in sysfs at all but it
> appears to have been added there 13+ years ago because it was a convenien=
t
> place to add a per-node variant.  That's not ideal, but owell.

It is up-to GregKH who requested this change. Greg, specifically
requested not to add new fields into per-node vmstat, and we are
adding new fields with per-page metadata series, and IOMMU accounting
series as these files are auto-expanded without this series.

Pasha

