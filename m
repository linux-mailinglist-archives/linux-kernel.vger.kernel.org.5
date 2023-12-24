Return-Path: <linux-kernel+bounces-10826-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 64B1081DC75
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Dec 2023 22:26:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 188101F2161B
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Dec 2023 21:26:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5EEBEAE2;
	Sun, 24 Dec 2023 21:26:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OeA54G8H"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10252E56B
	for <linux-kernel@vger.kernel.org>; Sun, 24 Dec 2023 21:26:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-1d3ea8d0f9dso259485ad.1
        for <linux-kernel@vger.kernel.org>; Sun, 24 Dec 2023 13:26:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1703453177; x=1704057977; darn=vger.kernel.org;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=JvNQTdY06fNS62lWjwFwulScBL1udDIwugjQ5w044qk=;
        b=OeA54G8HTjtNVOVsXAoxC3dz8uFZrNYeYggAKwhP/sMAPCSOSoJInMCI+zh+lq6qGh
         dIZeVUV4XwhkrBlwkuRRlCaY8kjodDxaEo4AsUYat37VxSiRiycW/J6mGOgo5Q0KwUZw
         8ad7+RlRbJPwcoLv5RC3zpNMJtFYMNLIB7FIqGF00lpSDmJZ24DjgU1aBiRErNbiBS0q
         rAR4KX2GTjncjUp5yKHUUTZmibsFkk3ZVWEM7vQafy8ax7RFmqHpQ4SGxjhjPhLTZPlX
         an2T1N/rVZ41Mh/SNUn8Fi63o2TtWIIXwhANdoYDZZbCvNsiDjIzi+8VPu/jGlsTz0nk
         NWww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703453177; x=1704057977;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JvNQTdY06fNS62lWjwFwulScBL1udDIwugjQ5w044qk=;
        b=bE60amvVEu2UQlTG0ty6FUrtJlONWXf58wN0I5P5zCVXLJtZHRj+YrmHeLTvK5urGz
         wLcmFjiC5fSRwV4D0RvfnIvC0ruDpRhHG6vfGLw+djpTxqptotjmotuWVpsYnlwo6DHQ
         xBnfTGIQeCS9ZhM4tOezcPf7BUvNNADiw+0aT/8qlAGWsZSP0lVe30/mkim60Y8IkrXY
         1Bbv2v/K8Vo+tK37H8zBny6MLxdYd09FTx/w/rgjswNlMZShvj3Cem2KXFD++bXK73Ch
         F1InTHgoUGD4yXHGd42LE5NOWgljJj5lD5Zqdo6M+0OWsLAvDfmjpSfkF6v00bghXfjQ
         H1OQ==
X-Gm-Message-State: AOJu0Yye4OsPe8QnUgBma1B5keBMFvYzQWNUvccs/yzMP9e5H7mDO6EG
	bBzaZgd8+x95oduMx9iwdFgmSsI4LqAU
X-Google-Smtp-Source: AGHT+IH8WwMaMCxmON/qmcdyxLAKH89h2buOq+WiBap3zwyl/QmhAjUL1KwuUQAUU0YvOH9VC4mdoA==
X-Received: by 2002:a17:903:189:b0:1d4:a9c:dc70 with SMTP id z9-20020a170903018900b001d40a9cdc70mr255214plg.9.1703453176969;
        Sun, 24 Dec 2023 13:26:16 -0800 (PST)
Received: from [2620:0:1008:15:c723:e11e:854b:ac88] ([2620:0:1008:15:c723:e11e:854b:ac88])
        by smtp.gmail.com with ESMTPSA id u19-20020a62ed13000000b006d9ac04b8cesm2147947pfh.114.2023.12.24.13.26.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Dec 2023 13:26:16 -0800 (PST)
Date: Sun, 24 Dec 2023 13:26:15 -0800 (PST)
From: David Rientjes <rientjes@google.com>
To: Pasha Tatashin <pasha.tatashin@soleen.com>
cc: gregkh@linuxfoundation.org, rafael@kernel.org, akpm@linux-foundation.org, 
    surenb@google.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
    souravpanda@google.com
Subject: Re: [PATCH] vmstat: don't auto expand the sysfs files
In-Reply-To: <CA+CK2bA2vZp3e+HHfB-sdLsPUYghMxvKcWURktDtNjwPL79Csw@mail.gmail.com>
Message-ID: <b1049bfa-68c4-e237-30a9-1514a378c7f1@google.com>
References: <20231211154644.4103495-1-pasha.tatashin@soleen.com> <3d415ab4-e8c7-7e72-0379-952370612bdd@google.com> <CA+CK2bA2vZp3e+HHfB-sdLsPUYghMxvKcWURktDtNjwPL79Csw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Thu, 14 Dec 2023, Pasha Tatashin wrote:

> > > Whenever a new fields are added one of the following: node_stat_item
> > > numa_stat_item zone_stat_item, the /sys/devices/system/node/nodeX/vmstat
> > > files are auto expanded.
> > >
> > > This is a problem, as sysfs files should be only one value per file.
> >
> > Does this patch address the one-value-per-file issue?  (I think that ship
> > has sailed for vmstat.)
> 
> That ship has sailed for vmstat, this patch addresses what was asked
> by GregKH: not to add new values to vmstat, as not to make the
> existing problem even worse. The sysfs file system has a one page
> limit per file. The developers will decide how to export the new items
> added to node_stat, numa_stat, zone_stat individually. Each new item
> can be exported in its own files, and must have its own documentation
> about interface stability, value meaning, and expectations when the
> stat file is absent.
> 

As of at least 6.5, /proc/vmstat is a strict superset of the per-node 
vmstat.  Why is that a problem?

There's great benefit to being able to use the sample implementations to 
parse either /proc/vmstat *or* the per-node vmstat and without needing to 
read the per-node vmstat plus some new set of sysfs files that are 
one-value-per-file.  The per-node vmstat will always be multiple values, 
in fact it's a key value pair.

I have to think that doing anything else for vmstat is just adding 
complexity (like this patch) and actually making it *harder* on userspace 
to read the data it needs.

Yes, the per-node vmstat likely shouldn't be in sysfs at all but it 
appears to have been added there 13+ years ago because it was a convenient 
place to add a per-node variant.  That's not ideal, but owell.

