Return-Path: <linux-kernel+bounces-35494-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BCAE8391FC
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 16:04:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5D7671C277DC
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 15:04:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E025560251;
	Tue, 23 Jan 2024 15:03:05 +0000 (UTC)
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFEA66024E
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 15:03:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706022185; cv=none; b=F1O79x3sNMBMSCsurQcbr4qaOLzK1S/lj3IlfancRhzjJzLQ1VXrWjZkJlQWCWlJwPW6n2LiUIW3toBX7huqxTmNijyRv7mupM0tyY9OhKRQMT6w0n4eYKFqy8SITB6VadxZRH3bhXy2nsasAhsv51UWeYXIiVClaPl5CyhP58s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706022185; c=relaxed/simple;
	bh=Im/imel6QkiuJavV9DiVVmiAd2SNxG4iF7EfFslIxiE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DtnkAaMBUFxYIkqdSezvvdKW9G0bzYfgJI1YAtClqYsyzqgAdhgEcxQOhPIT7WMCOxX+doLatQ1DoE4GGEAS/6lmKwIGvCIUbTlHNdLz02Z1iY7/Esf3l/Fp+xda6ktKcb4MY22M1JOpLfM5ekJNBt6KOuFx8Yswl9SFrs8Co9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-55a5e7fa471so3914707a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 07:03:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706022182; x=1706626982;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Dhs6909fGiuYVrjlWIDewNsRSyIOWGo7Oq3G2K8HjAA=;
        b=ljfzRyjFlWpGQE7pplvVuMh01pSd+A30/w7ZMxN20eGM4EGGAHSddBIIL71dkjFzsX
         FA+tQMpO6P1zzQoEudyPGraHtWAp2xgCIBOMceMiDk393P91wCIT+gOBLm/8zkYFAY/G
         2Jbt9mvbh9beFzOG1wXp0eOMvnqby0QUV4hFkPDRVPsRzSnI54Pj3G+C774lAsEBKrLD
         zmgj/LCsyXnAc/SFf0Li9jJO4iDfcSoLViscvtFSqNxsclBGHqEdv/ZFqmjaev8dAq29
         /riw76M23q6Jkz42CwijBaTvYyqYBLkqoPsr36otciPkJi1eHwibWXiVz8472lMRr6W5
         yn/g==
X-Gm-Message-State: AOJu0Yy7gNjimekMSrzNOnVWzUwKsasG4PcEMeZsqAE6z1Q2ALNIxXed
	VNkcQr/dp5VJyMXnfIgUV6vwxChOVc6k2jB+sqeuYBOT4hwstsyD
X-Google-Smtp-Source: AGHT+IEnzfLos23DrPaGv+p8N3nT43kpiwel8aY3MvqbbegMWurexEcUSnaeXUREzqMY/0TZCIkKUg==
X-Received: by 2002:a17:907:2917:b0:a30:6276:3cdf with SMTP id eq23-20020a170907291700b00a3062763cdfmr174885ejc.140.1706022181697;
        Tue, 23 Jan 2024 07:03:01 -0800 (PST)
Received: from gmail.com (fwdproxy-cln-023.fbsv.net. [2a03:2880:31ff:17::face:b00c])
        by smtp.gmail.com with ESMTPSA id 1-20020a170906318100b00a30b613daf9sm750500ejy.188.2024.01.23.07.03.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jan 2024 07:03:01 -0800 (PST)
Date: Tue, 23 Jan 2024 07:02:59 -0800
From: Breno Leitao <leitao@debian.org>
To: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
Cc: mingo@kernel.org, Thomas Gleixner <tglx@linutronix.de>,
	Borislav Petkov <bp@alien8.de>,
	Peter Zijlstra <peterz@infradead.org>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] x86/bugs: spectre_v2_user default mode depends on
 main default
Message-ID: <Za/VIwfxh+dyyfb8@gmail.com>
References: <20240118173213.2008115-1-leitao@debian.org>
 <20240118173213.2008115-4-leitao@debian.org>
 <20240123000431.rqs5g6gjpq5uckcs@desk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240123000431.rqs5g6gjpq5uckcs@desk>

On Mon, Jan 22, 2024 at 04:04:31PM -0800, Pawan Gupta wrote:
> On Thu, Jan 18, 2024 at 09:32:13AM -0800, Breno Leitao wrote:
> >  static enum spectre_v2_user_cmd __init
> >  spectre_v2_parse_user_cmdline(void)
> >  {
> > +	int ret, i, mode;
> 
> mode is being returned, it is better to match its type with function's
> return type "enum spectre_v2_user_cmd".

Agree. I will update. Thanks!

