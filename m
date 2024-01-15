Return-Path: <linux-kernel+bounces-26151-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B71D582DBFE
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 16:01:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 39B131F229E7
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 15:01:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F62F175B7;
	Mon, 15 Jan 2024 15:01:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fqcBKQwk"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97CAB175AB
	for <linux-kernel@vger.kernel.org>; Mon, 15 Jan 2024 15:01:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1705330905;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kZzHnpfGGCeoj1X9NKSYhE70cUGpZAspvvuSojm3bTE=;
	b=fqcBKQwkZukShFPxUauykVEIznwbRVqMiSOzjZRC6wvPzoazmqH45bmQz7VbqXc1HXaGUq
	5nYS6DV3n9aaUpI3a76jNzbLp+QLo12SI03JRinGUaveWlV9jPRAJ1U7r9YykvjznWeKtK
	x+J2+muSHfiLnbXCeQhyj8SXXOF9xgs=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-563-Y-V-KbtHPhWq5Tlgd317Gg-1; Mon, 15 Jan 2024 10:01:44 -0500
X-MC-Unique: Y-V-KbtHPhWq5Tlgd317Gg-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-40e5332f6e4so46824145e9.2
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jan 2024 07:01:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705330903; x=1705935703;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kZzHnpfGGCeoj1X9NKSYhE70cUGpZAspvvuSojm3bTE=;
        b=FmRmUEBgjH9In7ZAaAPc61c/+YVrEE5t+YXhiKbpdMZ66XUj1fI+CetzSiDGdEmutd
         AOXhjPWySQpq90WAwf1Bjv91gTtXwOLNdZSXBqWoeAB9hFa9Bs06g+39tVbdqdm8K42a
         +GVMP8uxDf1KfLUwBrErz/HSbss9orc27snsbVNhHT4eLC69MZlhBrKdBnGSMyp+4KqA
         Sq7xNIf97mKl/DY7F39YS80wrWSVNTNBT8dEXUOxCfxgihYQfHWK1JzeViKogrI1Lm3+
         Z+NNv72P7uZeFFGq5UAAcMVPXII8Rxw/SAU6GscZ5X00fCi06It168YWRzZwh7utG4yo
         JqzQ==
X-Gm-Message-State: AOJu0YwiQSvgjnKs+e9kuLxvy41MCjbfVjWTSJ9PENb2GmzeQ6PnyXgk
	FR5LX509/3jfFN5kgYzUOQdDROiqtZ8Hz3RMclghXIFve1UDN1x3pCm1DsV1MDVjxI1u9t0S2Ty
	K9g2Eh6xDfonK4PDbSJnNcj4OIchU6Cgs
X-Received: by 2002:a05:600c:4315:b0:40e:8020:6d5e with SMTP id p21-20020a05600c431500b0040e80206d5emr149755wme.70.1705330902629;
        Mon, 15 Jan 2024 07:01:42 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF/7fGXupNBht5E+PnvxRdM6nCxA+FJyyzrPZ+F54w/p9lzG8dlWP6meDOfojAuC2YDoHnCBA==
X-Received: by 2002:a05:600c:4315:b0:40e:8020:6d5e with SMTP id p21-20020a05600c431500b0040e80206d5emr149739wme.70.1705330902214;
        Mon, 15 Jan 2024 07:01:42 -0800 (PST)
Received: from toolbox ([2001:9e8:8996:a800:5fa3:a411:5e47:8fe5])
        by smtp.gmail.com with ESMTPSA id k9-20020a05600c1c8900b0040d772030c2sm16106519wms.44.2024.01.15.07.01.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jan 2024 07:01:41 -0800 (PST)
Date: Mon, 15 Jan 2024 16:01:40 +0100
From: Sebastian Wick <sebastian.wick@redhat.com>
To: Andri Yngvason <andri@yngvason.is>
Cc: Daniel Stone <daniel@fooishbar.org>,
	Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
	intel-gfx@lists.freedesktop.org, Leo Li <sunpeng.li@amd.com>,
	dri-devel@lists.freedesktop.org, "Pan, Xinhui" <Xinhui.Pan@amd.com>,
	Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
	linux-kernel@vger.kernel.org, Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Werner Sembach <wse@tuxedocomputers.com>,
	amd-gfx@lists.freedesktop.org,
	Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>
Subject: Re: [PATCH 2/7] drm/uAPI: Add "active color format" drm property as
 feedback for userspace
Message-ID: <20240115150140.GB160656@toolbox>
References: <20240109181104.1670304-1-andri@yngvason.is>
 <20240109181104.1670304-3-andri@yngvason.is>
 <CAPj87rNan8B5urDFkmD_Vti4to6p3NmvXYsTFQTNg-Ue2ieDug@mail.gmail.com>
 <CAFNQBQwiqqSRqzXAnC035UWCGF3=GGFR5SpDd=biPTOEA+cWbQ@mail.gmail.com>
 <ZZ509L_kmVC4IUBW@phenom.ffwll.local>
 <CAPj87rOiS8F=oDW3iE=bgFyfeJnYhy8kPF2v-uYOq3xgYtVPAg@mail.gmail.com>
 <CAFNQBQwjeJaX6B4oewpgASMUd5_nxZYMxUfdOG294CTVGBTd1w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAFNQBQwjeJaX6B4oewpgASMUd5_nxZYMxUfdOG294CTVGBTd1w@mail.gmail.com>

On Thu, Jan 11, 2024 at 05:17:46PM +0000, Andri Yngvason wrote:
> mið., 10. jan. 2024 kl. 13:26 skrifaði Daniel Stone <daniel@fooishbar.org>:
> > >
> > > This thing here works entirely differently, and I think we need somewhat
> > > new semantics for this:
> > >
> > > - I agree it should be read-only for userspace, so immutable sounds right.
> > >
> > > - But I also agree with Daniel Stone that this should be tied more
> > >   directly to the modeset state.
> > >
> > > So I think the better approach would be to put the output type into
> > > drm_connector_state, require that drivers compute it in their
> > > ->atomic_check code (which in the future would allow us to report it out
> > > for TEST_ONLY commits too), and so guarantee that the value is updated
> > > right after the kms ioctl returns (and not somewhen later for non-blocking
> > > commits).
> >
> > That's exactly the point. Whether userspace gets an explicit
> > notification or it has to 'know' when to read isn't much of an issue -
> > just as long as it's well defined. I think the suggestion of 'do it in
> > atomic_check and then it's guaranteed to be readable when the commit
> > completes' is a good one.
> >
> > I do still have some reservations - for instance, why do we have the
> > fallback to auto when userspace has explicitly requested a certain
> > type? - but they may have been covered previously.
> >
> 
> We discussed this further on IRC and this is summary of that discussion:
> 
> Sima proposed a new type of property that can be used to git feedback to
> userspace after atomic ioctl. The user supplies a list of output properties
> that they want to query and the kernel fills it in before returning from the
> ioctl. This would help to get some information about why things failed
> during TEST_ONLY.
> 
> Emersion raised the point that you might not know how much memory is needed
> beforehand for the returned properties, to which sima replied: blob
> property. There was some discussion about how that makes it possible to leak
> kernel memory, especially if userspace does not know about a new property
> blob. Emersion pointed out that userspace should only request properties
> that it understands and pq agreed.
> 
> Emersion asked how the user should inform the kernel that it's done with the
> blob, to which sima replied: DRM_IOCTL_MODE_DESTROYPROPBLOB. Sima also
> mentioned using some sort of weak reference garbage collection scheme for
> properties and there was some further discussion, but I'm not sure there was
> any conclusion.
> 
> I asked if it made sense to add color format capabilities to the mode info
> struct, but the conclusion was that it wouldn't really be useful because we
> need TEST_ONLY anyway to see if the color format setting is compatible with
> other settings.
> 
> I asked again if we should drop the "active color format" property as it
> seems to be more trouble than it's worth for now. pq mentioned that there
> are 2 separate use cases (in his words):
> - People playing with setting UI would like to know what "auto" would result
>   in, but that's just nice to have
> - The other use case is the flicker-free boot into known configuration He
>   went on to point out that the main problem with "auto" is that any modeset
>   could make the driver decide differently. This means that we cannot fully
>   rely on the previously set property.
> 
> However, leaving out "active color property" did not put us in a worse
> situation than before, so the conclusion was that we should leave it out for
> now. For GUI selectors, the current TEST_ONLY should be good enough, and all
> the fancy stuff discussed previously isn't needed for now.
> 
> To summarise the summary: this means that we will drop the "active
> color format" property and rename the "preferred color format"
> property to "force color format" or just "color format" and failing to
> satisfy that constraint will fail the modeset rather than falling back
> to the "auto" behaviour.

That's a good idea.

Anything else won't work with the new color pipeline API anyways because
user space will be responsible for setting up the color pipeline API in
a way so that the monitor will receive the correctly encoded data.

> Cheers,
> Andri
> 


