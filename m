Return-Path: <linux-kernel+bounces-21238-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F0366828C61
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 19:19:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 05A831C25218
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 18:19:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC7A63D393;
	Tue,  9 Jan 2024 18:18:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TBWI/mgx"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DB5B3D0D5
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jan 2024 18:18:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1704824317;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KzzgvE0gIC11hFErVwmkGJExGtvPilC4PjYEKFATcqE=;
	b=TBWI/mgxGPG03N/isNRkhF1aTL55xY7M40sBrKFD0RVHdVvO2DnG/IMKL+EvL2PSKOrkDp
	z4fPxkQfZ5yyYf6tHLKGXQgROIQryq0YcGH9FdAhoUgCwJSeBBxqprwlQ6onlHjqIApEtE
	3p6cBus+vgTt6Ys/LHAH2T22jpNuTg8=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-99-_hefjEURMLaRzNRvOVLU2w-1; Tue, 09 Jan 2024 13:18:36 -0500
X-MC-Unique: _hefjEURMLaRzNRvOVLU2w-1
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-1d45ddf3f58so31292625ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jan 2024 10:18:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704824315; x=1705429115;
        h=content-transfer-encoding:content-disposition:mime-version
         :references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KzzgvE0gIC11hFErVwmkGJExGtvPilC4PjYEKFATcqE=;
        b=Krvv7/IFnrgxEZkpV/pExJJRxLeWGPea5+3h7jROpaQgRXU53qmcaRtcGcVZ9Yp1/J
         uub5rbqLdBOxtN6Olnvs44SSgEcivJ3ofIexh1vRbAZxwbICqetTJcLNe6/9GZWDGmfZ
         fHREwiLWYL7ShHyb9a3tkVReeELAtmR9h+46CSh0f6H8W8+zSI0Wq2Hr7FPiBDZFbnwx
         MxO5QOuKxNEc3JMcBcfohJHnlYN2lfG2ZwUIZDcdv6V6gzDT0+C96h5/TP9QchDBi9DN
         579p5+vPD5N8VB17uQ84bUuzHnPgY3uryJYIWocoyAVOx7U0CfRiQSLf/EzOrhxeWtFe
         IlyQ==
X-Gm-Message-State: AOJu0Yxve1J1SamGWSZ8APOr0i/izTy68MhzTu4fHPRCJAFjuMyOCwda
	tcc7l0XPJoml0Qv4yOW6xRBUBw+TnCo5iMPzisZYqBIPtOvlx0j+h7ODiXn8jOlhdFKwn8+atw1
	bGL/q2zj5U+2InNTijxvcPNcwLlyv9Yp9
X-Received: by 2002:a17:903:228f:b0:1d5:6cd7:6d41 with SMTP id b15-20020a170903228f00b001d56cd76d41mr115955plh.86.1704824315312;
        Tue, 09 Jan 2024 10:18:35 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEYBvNo74Agm9CQkIKURXpO44BHS1rks1II+1CfrivxQ/3t8wFldRXmijXd1pjefSzIYwyH3g==
X-Received: by 2002:a17:903:228f:b0:1d5:6cd7:6d41 with SMTP id b15-20020a170903228f00b001d56cd76d41mr115943plh.86.1704824314978;
        Tue, 09 Jan 2024 10:18:34 -0800 (PST)
Received: from LeoBras.redhat.com ([2804:1b3:a803:26a5:3f32:e12b:5335:3c2d])
        by smtp.gmail.com with ESMTPSA id iy4-20020a170903130400b001d3eaab64a3sm2086232plb.219.2024.01.09.10.18.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jan 2024 10:18:34 -0800 (PST)
From: Leonardo Bras <leobras@redhat.com>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Leonardo Bras <leobras@redhat.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	"Eric W. Biederman" <ebiederm@xmission.com>,
	Kees Cook <keescook@chromium.org>,
	Oleg Nesterov <oleg@redhat.com>,
	Mark Brown <broonie@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Guo Hui <guohui@uniontech.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/1] arm64: remove unnecessary ifdefs around is_compat_task()
Date: Tue,  9 Jan 2024 15:18:28 -0300
Message-ID: <ZZ2N9D_HH5a-lodI@LeoBras>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <2f2e8df4-d8bb-4eff-8e70-0ac38736bd74@app.fastmail.com>
References: <20240108174330.472996-2-leobras@redhat.com> <2f2e8df4-d8bb-4eff-8e70-0ac38736bd74@app.fastmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Tue, Jan 09, 2024 at 07:18:46AM +0100, Arnd Bergmann wrote:
> On Mon, Jan 8, 2024, at 18:43, Leonardo Bras wrote:
> > Currently some parts of the codebase will test for CONFIG_COMPAT before
> > testing is_compat_task().
> >
> > is_compat_task() is a inlined function only present on CONFIG_COMPAT.
> > On the other hand, for !CONFIG_COMPAT, we have in linux/compat.h:
> >
> >  #define is_compat_task() (0)
> >
> > Since we have this define available in every usage of is_compat_task() for
> > !CONFIG_COMPAT, it's unnecessary to keep the ifdefs, since the compiler is
> > smart enough to optimize-out those snippets on CONFIG_COMPAT=n
> >
> > This requires some regset code as well as a few other defines to be made
> > available on !CONFIG_COMPAT, so some symbols can get resolved before
> > getting optimized-out.
> >
> > Signed-off-by: Leonardo Bras <leobras@redhat.com>
> > ---
> > Changes since v1:
> > - Move some regset code and other defines outside of CONFIG_COMPAT
> > - Closes: 
> > https://lore.kernel.org/oe-kbuild-all/202401061219.Y2LD7LTx-lkp@intel.com/
> > Link: 
> > https://lore.kernel.org/all/20240105041458.126602-3-leobras@redhat.com/
> 
> Looks good to me, and did not cause any regressions in an overnight
> randconfig build loop.
> 
> Reviewed-by: Arnd Bergmann <arnd@arndb.de>
> 

Thanks!
Leo


