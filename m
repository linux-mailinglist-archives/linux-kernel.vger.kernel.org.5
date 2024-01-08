Return-Path: <linux-kernel+bounces-19384-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 850E9826C30
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 12:09:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7CF531C22230
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 11:09:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1075D28E1E;
	Mon,  8 Jan 2024 11:08:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mVE7S4Y/"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6E292575B;
	Mon,  8 Jan 2024 11:08:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-40e4582ed74so10018025e9.1;
        Mon, 08 Jan 2024 03:08:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704712090; x=1705316890; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=47u96KtdzEvbIpKBaQmivqY/mxW7t8J2PKKE9/Wcn3U=;
        b=mVE7S4Y/3pFCsUzFSvdf4XgZz6CUGkQaoudC5XTRfT0McHt/Fs2dXWQQ93S9SASvhG
         xxXN9AdRMv7f6/JkGgncLnbS0w0kM/HbqcRzkBFS4JMNvXOQRU975V+E52yGVB0duAXd
         hkMVm3dNf10EUBDFdnavZzpS/FUYINS2XxbNYNcIxTHeKLfgS7dKUqAPjG4bYVT7lO3p
         PH/0asJiK7ZHUDl5vECwfDQRFnWEIFEaEhAXINNNpWMOK7g15QcL9XBMvFiRpdrER0f1
         SOctbG7Uef0RF5ispRcKCXCHREN89IXfDYAm6nfJOi2fCwf6v03fNeozxCCs7baZudJ3
         GJdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704712090; x=1705316890;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=47u96KtdzEvbIpKBaQmivqY/mxW7t8J2PKKE9/Wcn3U=;
        b=bDQEh2rPjyET8m6jjz+bCNkupk3cE10lD3tfb1xTLQzpXkGOEkxorJc+2IAaze5ym2
         fkvc2oC+Mccwhf43kCP9CqkzjyfrIpXXvYuFjiv8tIiIvlDZK2gTAEgMqFdm8KGpj9sQ
         fJk7pmkX1fpK5GxfLMn3BrGdAm3eDt3lM45EhWMiShmY9lb88be1m6ZWYpxEcjvuF2ru
         IEYUc2Bp+5cOGZJ4lBf+bX+XgOKPEkwnR1bZHKD778ZO+NihKTX+bqQ0H9LwtNMog4Ff
         SnzzIEAUQLPRCbhAc2fczSf/GvEqYmvmW9k8wI5dKJUqNQyIKccDcU68TJKRUtwXQmkn
         vHBA==
X-Gm-Message-State: AOJu0YwtMMZSlwkZnhLoNNJLzBEqgaGWXcDay0fV/asMbmssblISLrts
	Ol/9+YVho2LIrlUYL23DbjCY1Yk2Azg=
X-Google-Smtp-Source: AGHT+IGljMzclHKVfoI+sXkPb2zICLcFM1DoUK59Ef+y09I+psVm/Oh8UmBC8uDStHQXnZLH0LCwnQ==
X-Received: by 2002:a05:600c:358d:b0:40e:3d34:3e77 with SMTP id p13-20020a05600c358d00b0040e3d343e77mr972856wmq.44.1704712089757;
        Mon, 08 Jan 2024 03:08:09 -0800 (PST)
Received: from gmail.com (1F2EF3FE.nat.pool.telekom.hu. [31.46.243.254])
        by smtp.gmail.com with ESMTPSA id c12-20020a05600c0a4c00b0040c11fbe581sm10556031wmq.27.2024.01.08.03.08.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jan 2024 03:08:09 -0800 (PST)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date: Mon, 8 Jan 2024 12:08:07 +0100
From: Ingo Molnar <mingo@kernel.org>
To: Borislav Petkov <bp@alien8.de>
Cc: linux-kernel@vger.kernel.org, linux-tip-commits@vger.kernel.org,
	Jun'ichi Nomura <junichi.nomura@nec.com>,
	Derek Barbosa <debarbos@redhat.com>,
	Kees Cook <keescook@chromium.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Andy Lutomirski <luto@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>,
	Peter Zijlstra <peterz@infradead.org>, x86@kernel.org
Subject: Re: [tip: x86/boot] x86/boot: Ignore NMIs during very early boot
Message-ID: <ZZvXlyW8Khmr805c@gmail.com>
References: <170133478498.398.5261666675868615202.tip-bot2@tip-bot2>
 <20231130103339.GCZWhlA196uRklTMNF@fat_crate.local>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231130103339.GCZWhlA196uRklTMNF@fat_crate.local>


* Borislav Petkov <bp@alien8.de> wrote:

> On Thu, Nov 30, 2023 at 08:59:44AM -0000, tip-bot2 for Jun'ichi Nomura wrote:
> > +void do_boot_nmi_trap(struct pt_regs *regs, unsigned long error_code)
> > +{
> > +	/* Empty handler to ignore NMI during early boot */
> 
> It might be good to issue something here to say that a spurious NMI got
> ignored.
> 
> Something ala
> 
> 	error_putstr("Spurious early NMI ignored.\n");
> 
> so that we at least say that we ignored an NMI and not have it disappear
> unnoticed.

That makes sense. Jun'ichi-san, could you please send a patch for this?

Thanks,

	Ingo

