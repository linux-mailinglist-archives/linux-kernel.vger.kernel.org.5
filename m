Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3B497EDCDA
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Nov 2023 09:28:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344538AbjKPI2K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Nov 2023 03:28:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229806AbjKPI2I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Nov 2023 03:28:08 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B841C19D
        for <linux-kernel@vger.kernel.org>; Thu, 16 Nov 2023 00:28:03 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id ffacd0b85a97d-32da4180ca2so145405f8f.1
        for <linux-kernel@vger.kernel.org>; Thu, 16 Nov 2023 00:28:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google; t=1700123282; x=1700728082; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HoR8YFv2MRX2a6fvRuNrZzhShp2SKZc+/FizpnyYo48=;
        b=hmZFnyKfl9ohnBRHFP/pshHerOenwUuWZWmh4B+WFdu5ukDe6mko9NmGW/uOClR3lK
         eIl5ibVQYttHZ3RqaPWhhUkt14iJPWh6P2r5vB/4zyVeRLtSLxQHMuO6MzntbAtBJ1CP
         Z7XutSzxKiCWNLHBgFWzZfFy11uxO3Dp73quA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700123282; x=1700728082;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HoR8YFv2MRX2a6fvRuNrZzhShp2SKZc+/FizpnyYo48=;
        b=iW1RY/Oz9VGhxP46LpSo8Gr99MpJ/lMHB46cTCbNvzUF8WrZtbG1rFZKZ1qiElsax4
         C+DqVxiUJViAXmjCgLB8/Kzj3D3GzMIqR8Apaik+PHb50bovvxqbpxqZ/dW9YmgRg7h5
         mritBEul1dtq5IHehmaoyQ5wRIyAkO/zZTIimGTkKaR3BNJ3U6orPosRhA4qWWeCO12l
         eQHy5yF8LcHyRXwfuxAV3DsIRwt7+Clz2zCTb6HThLJjHuoRo5b+o+f4KFsDiW3Dg2Vf
         gRLqlSpkxNT/KTeQ4xY/V4/MJZNpzUiyijTpbTQgVUIM+Bdd+fKyBpVZSS9WlXmkc3t4
         OTbg==
X-Gm-Message-State: AOJu0YzT5/7zl4i0dkRxdEtj3kh0I88sHLpvdkfK5lFrBmCqK0xB8YzQ
        U2S8V/m+xgkLb/7TB3ApfZ5g1g==
X-Google-Smtp-Source: AGHT+IFWJ7X36hbELNZsu2Qoy7W883Jbwkj5/xgqtPBcjfnu1qrR6mv1JUwfPmOD8HEOYxyeIbfYIw==
X-Received: by 2002:a5d:6d85:0:b0:32d:c217:8307 with SMTP id l5-20020a5d6d85000000b0032dc2178307mr5571891wrs.5.1700123281310;
        Thu, 16 Nov 2023 00:28:01 -0800 (PST)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id j30-20020adfb31e000000b003197869bcd7sm12910569wrd.13.2023.11.16.00.28.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Nov 2023 00:28:00 -0800 (PST)
Date:   Thu, 16 Nov 2023 09:27:58 +0100
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Maxime Ripard <mripard@redhat.com>
Cc:     Luben Tuikov <ltuikov89@gmail.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Intel Graphics <intel-gfx@lists.freedesktop.org>,
        DRI <dri-devel@lists.freedesktop.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: Signed-off-by missing for commit in the drm-misc tree
Message-ID: <ZVXSjt_1uWHuYXsq@phenom.ffwll.local>
Mail-Followup-To: Maxime Ripard <mripard@redhat.com>,
        Luben Tuikov <ltuikov89@gmail.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Intel Graphics <intel-gfx@lists.freedesktop.org>,
        DRI <dri-devel@lists.freedesktop.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
References: <20231114075501.61321c29@canb.auug.org.au>
 <19740d41-dd5a-47e4-b3e8-539b45bbd3e5@gmail.com>
 <3c306310-04b3-4658-a197-4b2d22a88274@gmail.com>
 <20231114134506.2ba0de1f@canb.auug.org.au>
 <530b6100-4f4e-4b3d-8fea-5b316e989633@gmail.com>
 <20231114140855.0b259b2d@canb.auug.org.au>
 <f1b21cbd-5bb6-4030-ae7d-a0ca2fbc76a9@gmail.com>
 <73cg637ax5cahqocscx5cjvtqkwlt4ves6cxgprbwqllasxq6v@gk6vzsqfc46j>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <73cg637ax5cahqocscx5cjvtqkwlt4ves6cxgprbwqllasxq6v@gk6vzsqfc46j>
X-Operating-System: Linux phenom 6.5.0-4-amd64 
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 16, 2023 at 09:11:43AM +0100, Maxime Ripard wrote:
> On Tue, Nov 14, 2023 at 06:46:21PM -0500, Luben Tuikov wrote:
> > On 2023-11-13 22:08, Stephen Rothwell wrote:
> > > BTW, cherry picking commits does not avoid conflicts - in fact it can
> > > cause conflicts if there are further changes to the files affected by
> > > the cherry picked commit in either the tree/branch the commit was
> > > cheery picked from or the destination tree/branch (I have to deal with
> > > these all the time when merging the drm trees in linux-next).  Much
> > > better is to cross merge the branches so that the patch only appears
> > > once or have a shared branches that are merged by any other branch that
> > > needs the changes.
> > > 
> > > I understand that things are not done like this in the drm trees :-(
> > 
> > Hi Stephen,
> > 
> > Thank you for the clarification--understood. I'll be more careful in the future.
> > Thanks again! :-)
> 
> In this case, the best thing to do would indeed have been to ask the
> drm-misc maintainers to merge drm-misc-fixes into drm-misc-next.
> 
> We're doing that all the time, but we're not ubiquitous so you need to
> ask us :)
> 
> Also, dim should have caught that when you pushed the branch. Did you
> use it?

Yeah dim must be used, exactly to avoid these issues. Both for applying
patches (so not git am directly, or cherry-picking from your own
development branch), and for pushing. The latter is even checked for by
the server (dim sets a special push flag which is very long and contains a
very clear warning if you bypass it).

If dim was used, this would be a bug in the dim script that we need to
fix.

Also backmerges (and in generally anything that is about cross-tree patch
wrangling, like cherry-picking) are maintainer duties in drm-misc and not
for committers:

https://drm.pages.freedesktop.org/maintainer-tools/maintainer-drm-misc.html#maintainer-s-duties

I think it'd be really good for Luben to go through the docs and supply a
patch to clarify this, if it's not clear from the existing docs.

We have some wording in the committer docs, but maybe it's not clear
enough:

https://drm.pages.freedesktop.org/maintainer-tools/committer-drm-misc.html#merge-criteria

"Any non-linear actions (backmerges, merging topic branches and sending
out pull requests) are only done by the official drm-misc maintainers (see
MAINTAINERS, or ask #dri-devel), and not by committers. See the examples
section in dim for more info"

Minor screw-ups like this gives us a great opportunity to improve the
tooling&docs, let's use it.

Cheers, Sima
-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
