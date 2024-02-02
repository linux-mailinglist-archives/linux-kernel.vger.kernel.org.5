Return-Path: <linux-kernel+bounces-50208-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 98AFA8475D3
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 18:11:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 54144B2E724
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 17:09:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AA4D14D45B;
	Fri,  2 Feb 2024 17:07:23 +0000 (UTC)
Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B53314C5A7
	for <linux-kernel@vger.kernel.org>; Fri,  2 Feb 2024 17:07:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706893643; cv=none; b=a6BDWbosFvJgqqE4VPlcEZLLfhhZQ4fNuKQgLS+qW48DFQxGi2gopwaGMZ7yb6cokt3GWAI6Edbj8GdOBXbzr8eRxBm93lNrciSu+VZ2x5DME7sZ4NXX6RMuU2p0ucBsQrDTLGaTJu+4Qur+MYHslASyVToRaRtVO4E5cTijGDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706893643; c=relaxed/simple;
	bh=y+gAPT68yktKEC3SZi/PBBCLmq/Ebt4n1T1gRSBSaXU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U0zo/8voeseIm1EJU6Aq2Q13WbfquYtsWrt4Vx5O10DfVmL6h77VF4jsI5Zf/0h0uol2nzUhNl3xGTyT1ma5bQEcbns3YT/dlX8+RZpxlA/1JQosIYF6C1xWYiMnrxKISkM+5HSn/VvO4kMRQOqqDnbFvi9ZLjP8KpWrqdkmZvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=manifault.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=manifault.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-68c794970d5so15254556d6.0
        for <linux-kernel@vger.kernel.org>; Fri, 02 Feb 2024 09:07:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706893636; x=1707498436;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=y+gAPT68yktKEC3SZi/PBBCLmq/Ebt4n1T1gRSBSaXU=;
        b=lXSPZ8f6QMAiPzMaF9ru1wjnhcXMPqrS8VQ9PXGPydYlGf4+E7LElId8OI7xthdZ8C
         ipl2LSu366BUlmClIlZU35pZk7mfcMhrLpawL03I155x0I0TqDP5SjhPR/04QojQou+v
         hN519lxJvXNq9OgDtRVD55pbpJtiiy92JQKy1yKkh2ak44bfuuaN+rDI8jPkmrMcSlcE
         g10i5AKAtewp1S+GROKa5/1pLeFlpuV9fqw83gAb1KOLbfoK+a1fGNGJ1X/NrXNiCPr1
         Q2Oy+kMqd8ZHIvG5DQA695SLXmEhm5LphUFw4ICbMGHc6LycQf6kxlPJSX3MSgfNVmIa
         77hA==
X-Gm-Message-State: AOJu0Yzh1v5DXCtagQiVL5oDs5wLmpbH87vKoSIT7YbRB6znemS5S5Qx
	BLRCGJafq5zFS8AGrCUqWFpHJStchvO399s5xNlXHHBi0CATbzsO
X-Google-Smtp-Source: AGHT+IFgMn7G49IMgaFPDtinjH2Oc1djCOjdrS3AUmkMFaaJ19AFcapU2qK6Ndxp3bk/XyGVZNuYAQ==
X-Received: by 2002:a05:6214:2527:b0:68c:7302:8974 with SMTP id gg7-20020a056214252700b0068c73028974mr4680152qvb.30.1706893636113;
        Fri, 02 Feb 2024 09:07:16 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCVzE9W/xHwkhE7x6DjMoApkSYNkXT+2USzaZmjbS3sbgrF3DuuvI/47O2BvF8T08qBw49dxUuhmo9mZIxB1R1AxE4SDiNufQPx9s3iaL6qXyXjpVAe2Y95NnjECfXFS2WA6RIj1XgpClJ30LS65jR3Qo5GlDtlZb5Mk6g2qD1nm33uLFV8d2OytNhHfS0VrXysm0MD5skLE89Da8kxRkxTj/85Es2in21h4yaesgvHX/zuE6yZytjMDD7t4F1H+cw54nL1Jxi9eXUV3zEEAf4uWp869RVSbUr9m1na6vIBBbkDXp5uFVQffYvbizP/7nj8OakHwc8LKkpt2Mbi5hqnMGME7H3dNBA==
Received: from maniforge (c-24-1-27-177.hsd1.il.comcast.net. [24.1.27.177])
        by smtp.gmail.com with ESMTPSA id mf5-20020a0562145d8500b0068c749df8f2sm969308qvb.20.2024.02.02.09.07.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Feb 2024 09:07:15 -0800 (PST)
Date: Fri, 2 Feb 2024 11:07:12 -0600
From: David Vernet <void@manifault.com>
To: Valentin Schneider <vschneid@redhat.com>
Cc: linux-kernel@vger.kernel.org, mingo@redhat.com, peterz@infradead.org,
	juri.lelli@redhat.com, vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
	mgorman@suse.de, bristot@redhat.com, kernel-team@meta.com
Subject: Re: [PATCH] sched/fair: Simplify some logic in
 update_sd_pick_busiest()
Message-ID: <20240202170712.GC2238525@maniforge>
References: <20240202070216.2238392-1-void@manifault.com>
 <xhsmhwmrmhkbh.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="aaczLianmhiTpaH6"
Content-Disposition: inline
In-Reply-To: <xhsmhwmrmhkbh.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
User-Agent: Mutt/2.2.12 (2023-09-09)


--aaczLianmhiTpaH6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 02, 2024 at 06:01:22PM +0100, Valentin Schneider wrote:
> On 02/02/24 01:02, David Vernet wrote:
> > When comparing the current struct sched_group with the yet-busiest
> > domain in update_sd_pick_busiest(), if the two groups have the same
> > group type, we're currently doing a bit of unnecessary work for any
> > group >=3D group_misfit_task. We're comparing the two groups, and then
> > returning only if false (the group in question is not the busiest).
> > Othewise, we break, do an extra unnecessary conditional check that's
> > vacuously false for any group type > group_fully_busy, and then always
> > return true.
> >
> > Let's just return directly in the switch statement instead. This doesn't
> > change the size of vmlinux with llvm 17 (not surprising given that all
> > of this is inlined in load_balance()), but it does shrink load_balance()
> > by 88 bytes on x86. Given that it also improves readability, this seems
> > worth doing.
> >
> > As a bonus, remove an unnecessary goto in update_sd_lb_stats().
> >
>=20
> Given that's a different scope than what the rest of the patch touches, I=
'd
> rather see this as a separate patch.
>=20
> Other than that:
> Reviewed-by: Valentin Schneider <vschneid@redhat.com>

Thanks, would you like me to send a follow-on series split into two with
your tag on both? Or were you just letting me know for next time?

We could also update this check to only do a strict greater than to
avoid unnecessary writes, but I figured it was preferable to have no
logical changes for this iteration:

return sgs->group_misfit_task_load >=3D busiest->group_misfit_task_load;

--aaczLianmhiTpaH6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQRBxU1So5MTLwphjdFZ5LhpZcTzZAUCZb0hQAAKCRBZ5LhpZcTz
ZCd1APsHJ+HAuY/9jG+onEyWQ4qCDcfvGlESj1ixqg+mDd2ZpgEA1Q0HN0+A5vXi
LLt53N1JFUeN7fCOj+uzuP5Rh5G/9ws=
=fzh1
-----END PGP SIGNATURE-----

--aaczLianmhiTpaH6--

