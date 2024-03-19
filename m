Return-Path: <linux-kernel+bounces-108130-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CFA5288066B
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 22:01:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5AD6D1F22C8F
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 21:01:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 731963D0B8;
	Tue, 19 Mar 2024 21:01:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="B0tVCjgz"
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E4733CF58
	for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2024 21:01:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710882076; cv=none; b=ZIZTm4MbN6GFp2Erch9cinL1CvMgV7e3wzdr46hha8PAeSDlji9y+RAfU8fLr+5COpcTqZRE3/l/pD8Z6dGNEEfrFeVB86yntvDxcd30oNkcy/w+TzDzxmW15o4hJyE3KNebm/NIG0uOJWrDg/0pAEZ7jGN1swHj8gphtfXIYiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710882076; c=relaxed/simple;
	bh=ZvhANbuYYdzjDlSNCOObZlNwSVeG5SJGde/R3AYV+0Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LMUyaCCMgJu26+srJvAwGp3ewfz/XwmxiJ+ewQE+edc2+LAy3GwYG/a33nrHBjcisQLfFy0KcM3Sj+TIGshm0U7GAK7hxILAzci92XSm1kT4w/F90U7mwDYRnzQj/Ru39UeLeCmakNpQbIjt+oOrgSXzWmOlOgkMJp3NvXp7shs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=B0tVCjgz; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-1dddd7d64cdso14855ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2024 14:01:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1710882074; x=1711486874; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZvhANbuYYdzjDlSNCOObZlNwSVeG5SJGde/R3AYV+0Q=;
        b=B0tVCjgzesu+Fy0pe+9lnGHc+9MpO1bIAYLHtiLhgQEjOhqSyFJ63xHnA71lAtsUJU
         lcDFZA0OPjujHEqtDthZWfnUenNKIXey63yb2LrmAWAxEZ42trqOV3XOTrmHaIQR97dU
         kD5BYU1M800qXa0sCDeoHlANuvEN5Y5WMGtU++qULXxyh4By8Vq+OjXySutJNhRNYROE
         hM1OWenE88vokESm56sxMj9XsqwLX0HHqPUIgkyui3J7lka3QHPk9SfVPVO5LhPwqdKG
         nC87780IAeFpO0XwCB38jAqQheOb0ojFrjAcYh9ePEtWhlDb3QN+c1P5XABUdU7xl1i1
         SDgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710882074; x=1711486874;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZvhANbuYYdzjDlSNCOObZlNwSVeG5SJGde/R3AYV+0Q=;
        b=tUnyTsoWc4rgeQyTvQ4l9jtdlGQSSorK8Ozrg0CKEs+GN5jLFq3Vp4nRRBHEw649rL
         1QhhpHOYY53M/zFZMNTY4KCt4XsyujUYbAo/VPdxtw2leijxxSjLpt+ci33HkGhYSvzc
         y2CSsCL9zn3gAWgUwh4jlHQIy7Cuqd602qRzhiol+SsGh07P2OiEG5yoNIC8BsnwxPWV
         63ltn7wTv8Fmp31ho59btAJMyko8JL0QfBznUY2RwsT0TQAYIjH/0P35kBkXlvbq+Naf
         S8NClUMaGUeKT2Z35xSQmR2krzC6f0j3U9ZLOQQcctYRtBujcBS/KLHaY4bI3Whq/bud
         KHKQ==
X-Forwarded-Encrypted: i=1; AJvYcCX99iVvWyaxgeEX4YQEOAUSmoOtfIB1gkvVE2QP2h7V31P2v+hqB9aXuCcMLWKrNif+A268cTDWZ5q/NYioSudhlmK+H0cdCdgQ6i0A
X-Gm-Message-State: AOJu0YzSiIYwkRSaPqOC91lBWP5CJdQ0aF7xlbGIZyf05KiRWul5krwl
	9e4bYuSYA4b8H5aIjCftRrTkoMJWOib6qBsAK5j3ukHxnkmQ9gfk6KAZiOlAoWAsYXDfEAtvPzq
	XomD45VuQ/IpzuqBWllJm06LDsj57cWUQYqHx
X-Google-Smtp-Source: AGHT+IHTts9WTZeXfm7QG5MBLfM47UzPfKpIRbymYy8+sSS02gQyuQ17Sh9LpPAbl2m9576EbW8jaYR2DD3FniSwitc=
X-Received: by 2002:a17:903:2292:b0:1df:f726:8b50 with SMTP id
 b18-20020a170903229200b001dff7268b50mr85063plh.10.1710882073295; Tue, 19 Mar
 2024 14:01:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <SJ1PR11MB608310C72D7189C139EA6302FC212@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <o6va7b7rc3q46olsbscav7pla4hxot2g6xhctflhmf64pj5hpx@56vtbg3yyquy>
 <SJ1PR11MB60830E546B3D575B01D37104FC202@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <159474e6-ef11-4769-a182-86483efcf2a6@intel.com> <SJ1PR11MB60832DAD58E864F99A16FCC4FC202@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <0393c4ce-7e41-4dcc-940a-a6bea9437970@intel.com> <SJ1PR11MB6083AACB10645E41DD3F9639FC202@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <55a55960-8bb1-4ce2-a2c7-68e167da8bcc@intel.com> <ZepK4mtoV_J8-UbE@agluck-desk3>
 <eacdc287-24bd-4137-85c8-df055cfd78b1@arm.com> <ZetcM9GO2PH6SC0j@agluck-desk3>
 <88430722-67b3-4f7d-8db2-95ee52b6f0b0@arm.com> <47c28b3d-3b90-4b33-ba71-1e359d43238e@intel.com>
 <SJ1PR11MB60832422CBDCCDA580010769FC2D2@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <6948784d-6a20-435a-8781-30f324bed472@intel.com> <SJ1PR11MB608303C5E0BEB42CAC5B02BAFC2D2@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <fe4a54cf-7103-49c7-add4-ee4bcf76c7b3@intel.com> <SJ1PR11MB6083CF09A97C13C0859D5A67FC2D2@SJ1PR11MB6083.namprd11.prod.outlook.com>
In-Reply-To: <SJ1PR11MB6083CF09A97C13C0859D5A67FC2D2@SJ1PR11MB6083.namprd11.prod.outlook.com>
From: Peter Newman <peternewman@google.com>
Date: Tue, 19 Mar 2024 14:01:02 -0700
Message-ID: <CALPaoCiTe+50Ymve5kcjaasQe4AhvayMbTM9yCp2F5PtwHyAcQ@mail.gmail.com>
Subject: Re: [PATCH 4/4] selftests/resctrl: Adjust SNC support messages
To: "Luck, Tony" <tony.luck@intel.com>
Cc: "Chatre, Reinette" <reinette.chatre@intel.com>, James Morse <james.morse@arm.com>, 
	"Wieczor-Retman, Maciej" <maciej.wieczor-retman@intel.com>, "Yu, Fenghua" <fenghua.yu@intel.com>, 
	Shuah Khan <shuah@kernel.org>, 
	"ilpo.jarvinen@linux.intel.com" <ilpo.jarvinen@linux.intel.com>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Tony,

On Mon, Mar 18, 2024 at 3:05=E2=80=AFPM Luck, Tony <tony.luck@intel.com> wr=
ote:
>
> > Could you please help me understand the details by answering my first
> > question: What is the use case for needing to expose the individual clu=
ster
> > counts?
> >
> > This is a model specific feature so if this is something needed for jus=
t a
> > couple of systems I think we should be less inclined to make changes to
> > resctrl interface. I am starting to be concerned about something simila=
r
> > becoming architectural later and then we need to wrangle this model spe=
cific
> > resctrl support (which has then become ABI) again to support whatever t=
hat
> > may look like.
>
> Reinette,
>
> Model specific. But present in multiple consecutive generations (Sapphire=
 Rapids,
> Emerald Rapids, Granite Rapids, Sierra Forest).
>
> Adding Peter Newman for a resctrl user perspective on SNC, rather than me
> continue to speculate on possible ways this might be used.
>
> Peter: You will need to dig back a few messages on lore.kernel.org to
> get context.

Our main concern with supporting SNC in resctrl is all of the
monitoring groups successfully recording memory bandwidth from all
CPUs, regardless of the RMIDs they're assigned.

I would prefer that we don't complicate the model of resctrl
monitoring domains for this feature. On ARM SoCs there will be a
plethora of technologies influencing the layout of resources, so we
shouldn't start cluttering the model with special cases for each.

I think it's valid for the number of domains in the L3 resource to
increase or stay the same when the system is configured for SNC. I
don't think the details of how the domains came about is relevant at
the resctrl interface level so long as the user has enough information
to deduce what the domain is referring to based on knowledge of their
system configuration.

I would prefer per-cluster as more information could prove useful in
some future investigation, but if you feel the data is misleading,
providing the clusters combined is also fine. I would prefer that the
choice remains consistent from this point forward on any particular
implementation to avoid breaking existing controller software
developed for that implementation.

In our main use case, we sum mon_data/*/mbm_total_bytes to determine a
group's total bandwidth, so please don't cause this logic to produce
the wrong answer.

Thanks!
-Peter

