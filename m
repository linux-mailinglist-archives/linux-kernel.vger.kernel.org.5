Return-Path: <linux-kernel+bounces-161604-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 195248B4EA3
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 00:37:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C6996B20C59
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Apr 2024 22:37:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C96501170D;
	Sun, 28 Apr 2024 22:36:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QVDdxWS/"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59E271118E
	for <linux-kernel@vger.kernel.org>; Sun, 28 Apr 2024 22:36:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714343815; cv=none; b=gNVL6/CmZNe5RZad8qHO3d847OdSSjecjEw27mo63A0yWDqx9HqDm3WB6bg9bBWbTH+DtWSOR3Lc+yw5ak+62Cx8cnlV2V9OVNqK0KSzYO1SmChr0dzxt/HPM6FC6lGYaohskvOKeL6XIEtOHdmlr1oe1czf/FFSCjchkSAQeAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714343815; c=relaxed/simple;
	bh=aeqWL+M+dOs1eMt5/grwIg0g0doOtg7UuwksVx4uTFs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WpKgk+VpNSaRD33P172QT3DEzsh3qdMaqhnYxpcyD7iiUrC6FbpWWxpKvkduN8a3Uz26QVBkI8fN2o4Rjt8BSosjm5w6VGoTt6bUawmuvHloRqAa9rWkO3qJ+TvCT3nxOtsO5Vi1SWt/BEm3+FLPpw+iq6I4gp3P6x212Fk9YnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QVDdxWS/; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-418e4cd2196so31721265e9.1
        for <linux-kernel@vger.kernel.org>; Sun, 28 Apr 2024 15:36:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714343812; x=1714948612; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=UKYx+oWNKFvba+FkqjDcxw7eUfXCIKcYAEx9pzsmkH0=;
        b=QVDdxWS/IRwxOoRl0x7RI4YvoOk03Q/XcsewNQa8JyDFJCtymnZYKb4PMQ8ONGtFYv
         ShkVMtqQF0JCrOAxEmquljo4hDod3CWPPvUawERyX3GIext2SMmfgnL9dLC74j5BtQP5
         5rJb0x27qzm1GKd3W8M0BNID8d4bRBwRgwcL63B21rVl0ec17EVahumEQa+orYTzfi4n
         LOtfLP9UhaYnF/eP1EuSzlHn5jjKx4p9jgi2bs6piLPs+OaRT+PTml5EzJJXJHiZkFeT
         KN0LmifY07XbF6mOaf42AZSO4Due+/wQQaWdhHF/q3jABkevKF6YqHlaLiIZK9NKnNke
         dSKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714343812; x=1714948612;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UKYx+oWNKFvba+FkqjDcxw7eUfXCIKcYAEx9pzsmkH0=;
        b=Be2raOnC7Ho3HSuFkOhjWttIdqY6iWaptzrW8I05Ys8rXjPpwNlbDk15FlKWSxWzJO
         rbRKSOSO7loNukix1Souy6rZtgp1igVBHF0RvquTwCyYcwCmWoEhxek+OoCRQ4//MGvF
         hAeNeAUhlt+tZWj3iV9OXduQHmRYrbGDXq0TdRwp/eBuTDUpANMPmxDKSxlcUNMzkk33
         /U3MD6tjqjrMiZJgYVvMzmciT2iFL44/FW3FZXCHgUiYpDfm8WWQGzETObp64D0weWNK
         erD7SWU2oHTjpBtC7rTUllb8qsOnYNRL4bEiRvDG9fAx6uzyZmKE1fYeyzyCnT9VelNp
         1T7w==
X-Forwarded-Encrypted: i=1; AJvYcCXiGrhbwVrgXhTR0bVLNNLg1vC4Py4qjJVPem228EHQTUginxrefNiThqdU9s94qbRILooYtd1FBlQhkPXfVB6gReiCGH3GOPKn7nLt
X-Gm-Message-State: AOJu0YzrDTBbl3zQ+KIjnlyijYXRUK3cJTt/J44LYkBEORIsPb2uX6Ix
	dI1Til5QsVnYoeNot4Yu08QzemLBA3ba/8PIaz6Psbdj+4rwdlV55UZ74DPYxCc=
X-Google-Smtp-Source: AGHT+IHWbeqF6rpVr6YcpYOuodyKpdSccQX6Ap+he1yUQz9M3z2grcMRRxdq2zrCxtPQyQo+/WTDmA==
X-Received: by 2002:a05:600c:4f08:b0:419:f3f9:8ed6 with SMTP id l8-20020a05600c4f0800b00419f3f98ed6mr6579236wmq.4.1714343811435;
        Sun, 28 Apr 2024 15:36:51 -0700 (PDT)
Received: from debian.local (80-44-68-74.dynamic.dsl.as9105.com. [80.44.68.74])
        by smtp.gmail.com with ESMTPSA id s8-20020a05600c45c800b0041be9cb540esm6038632wmo.18.2024.04.28.15.36.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Apr 2024 15:36:51 -0700 (PDT)
Date: Sun, 28 Apr 2024 23:36:48 +0100
From: Chris Bainbridge <chris.bainbridge@gmail.com>
To: Lyude Paul <lyude@redhat.com>
Cc: Jeff Layton <jlayton@kernel.org>, David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>, Wayne.Lin@amd.com,
	alexdeucher@gmail.com, Jani Nikula <jani.nikula@linux.intel.com>,
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] drm: use mgr->dev in drm_dbg_kms in
 drm_dp_add_payload_part2
Message-ID: <Zi7PgLmTp5lJWS91@debian.local>
References: <20230419112447.18471-1-jlayton@kernel.org>
 <d0b9654c756069a6f0edcca6f4d410f7af592784.camel@redhat.com>
 <4400e47d6555ed773d1e9cab5566c03429d43ae9.camel@kernel.org>
 <dd8edd9405049b09cd30ea13e5ae5562a437a2d3.camel@redhat.com>
 <3d47da79a59817b69d5ed7cdaf4fbec227be00d9.camel@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3d47da79a59817b69d5ed7cdaf4fbec227be00d9.camel@redhat.com>

On Tue, Jun 20, 2023 at 03:59:24PM -0400, Lyude Paul wrote:
> Also since I forgot, so patchwork picks this up:
> 
> Reviewed-by: Lyude Paul <lyude@redhat.com>
> 
> On Tue, 2023-06-20 at 15:50 -0400, Lyude Paul wrote:
> > Eek - this might have been a situation where everyone involved assumed someone
> > else would push it, whoops. I'll make sure this is pushed upstream :).
> > 
> > FWIW: You could definitely send an MR to the fedora kernel's gitlab to get
> > this included earlier. If you don't get to it before me I'll try to do that
> > today
> > 
> > On Tue, 2023-06-20 at 07:18 -0400, Jeff Layton wrote:
> > > I've noticed that this patch is not included in linux-next currently.
> > > 
> > > Can I get some confirmation that this is going to be included in v6.5?
> > > Currently, I've been having to rebuild Fedora kernels to avoid this
> > > panic, and I'd like to know there is a light at the end of that tunnel.
> > > 
> > > Thanks,
> > > Jeff
> > > 
> > > On Wed, 2023-04-19 at 16:54 -0400, Lyude Paul wrote:
> > > > Reviewed-by: Lyude Paul <lyude@redhat.com>
> > > > 
> > > > Thanks!
> > > > 
> > > > On Wed, 2023-04-19 at 07:24 -0400, Jeff Layton wrote:
> > > > > I've been experiencing some intermittent crashes down in the display
> > > > > driver code. The symptoms are ususally a line like this in dmesg:
> > > > > 
> > > > >     amdgpu 0000:30:00.0: [drm] Failed to create MST payload for port 000000006d3a3885: -5
> > > > > 
> > > > > ...followed by an Oops due to a NULL pointer dereference.
> > > > > 
> > > > > Switch to using mgr->dev instead of state->dev since "state" can be
> > > > > NULL in some cases.
> > > > > 
> > > > > Link: https://bugzilla.redhat.com/show_bug.cgi?id=2184855
> > > > > Suggested-by: Jani Nikula <jani.nikula@linux.intel.com>
> > > > > Signed-off-by: Jeff Layton <jlayton@kernel.org>
> > > > > ---
> > > > >  drivers/gpu/drm/display/drm_dp_mst_topology.c | 2 +-
> > > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > > > 
> > > > > I've been running this patch for a couple of days, but the problem
> > > > > hasn't occurred again as of yet. It seems sane though as long as we can
> > > > > assume that mgr->dev will be valid even when "state" is a NULL pointer.
> > > > > 
> > > > > diff --git a/drivers/gpu/drm/display/drm_dp_mst_topology.c b/drivers/gpu/drm/display/drm_dp_mst_topology.c
> > > > > index 38dab76ae69e..e2e21ce79510 100644
> > > > > --- a/drivers/gpu/drm/display/drm_dp_mst_topology.c
> > > > > +++ b/drivers/gpu/drm/display/drm_dp_mst_topology.c
> > > > > @@ -3404,7 +3404,7 @@ int drm_dp_add_payload_part2(struct drm_dp_mst_topology_mgr *mgr,
> > > > >  
> > > > >  	/* Skip failed payloads */
> > > > >  	if (payload->vc_start_slot == -1) {
> > > > > -		drm_dbg_kms(state->dev, "Part 1 of payload creation for %s failed, skipping part 2\n",
> > > > > +		drm_dbg_kms(mgr->dev, "Part 1 of payload creation for %s failed, skipping part 2\n",
> > > > >  			    payload->port->connector->name);
> > > > >  		return -EIO;
> > > > >  	}
> > > > 
> > > 
> > 
> 
> -- 
> Cheers,
>  Lyude Paul (she/her)
>  Software Engineer at Red Hat
> 

Hello, this patch regressed in Wayne's 5aa1dfcdf0a42 commit:

$ git show 5aa1dfcdf0a42 | grep -A6 'Skip failed payloads'
 	/* Skip failed payloads */
-	if (payload->vc_start_slot == -1) {
-		drm_dbg_kms(mgr->dev, "Part 1 of payload creation for %s failed, skipping part 2\n",
+	if (payload->payload_allocation_status != DRM_DP_MST_PAYLOAD_ALLOCATION_DFP) {
+		drm_dbg_kms(state->dev, "Part 1 of payload creation for %s failed, skipping part 2\n",
 			    payload->port->connector->name);
 		return -EIO;

$ git tag --contains 5aa1dfcdf0a42
v6.7
v6.7-rc1
v6.7-rc2
v6.7-rc3
v6.7-rc4
v6.7-rc5
v6.7-rc6
v6.7-rc7
v6.7-rc8
v6.7.1
v6.7.10
v6.7.11
v6.7.12
v6.7.2
v6.7.3
v6.7.4
v6.7.5
v6.7.6
v6.7.7
v6.7.8
v6.7.9
v6.8
v6.8-rc1
v6.8-rc2
v6.8-rc3
v6.8-rc4
v6.8-rc5
v6.8-rc6
v6.8-rc7
v6.8.1
v6.8.2
v6.8.3
v6.8.4
v6.8.5
v6.8.6
v6.8.7
v6.8.8
v6.9-rc1
v6.9-rc2
v6.9-rc3
v6.9-rc4
v6.9-rc5

