Return-Path: <linux-kernel+bounces-9731-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D6FAB81CA5B
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 13:58:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 56B3B1F22DFA
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 12:58:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76C3618C07;
	Fri, 22 Dec 2023 12:58:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DTnxdcqI"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A529B1863F;
	Fri, 22 Dec 2023 12:58:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-1d3eabe9321so12502845ad.2;
        Fri, 22 Dec 2023 04:58:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703249923; x=1703854723; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=9HjnNbNH2TVinJM34IOYgMM2Kxh5j+hwMU83vJZ9rBI=;
        b=DTnxdcqImOHwB7iWELzSs5yC/WL5o5/3POS1vHTygsGImBKEjI4e7JLoP2YqQrQrKK
         Q8z1hjBK3yXDnFVMGFb7rFNKwWFy/MpcoIeayFPZmoD6M0WrMt3In45FwtsUVgeNEAGY
         KONz/qV05KLrqR1kPt7MFpQFm+oaIMvPr/vEmVv5safw7EsMqnv7xdic2lzWE8iC+lnz
         3uu+Saaa+dmFrqUFXk7/kZBNwpVg1/2P587hijOMQA1i3nL7NoGq5+hQUqv4av+5grMD
         t+93iQCiPehc4hwuJp+P/E01wpLEl5u7w84J1R6sbkGdjzBg70Q5Rq+ZPOnGhZe0CWdK
         gqfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703249923; x=1703854723;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9HjnNbNH2TVinJM34IOYgMM2Kxh5j+hwMU83vJZ9rBI=;
        b=Xlm+3KrFVAu0GVXL+NGZC73Zno3eKOcIoYMIgtCddrO4695MeqOO25RbrcyTwEEY3p
         90Rg+fenYST7O48+mTsTiVL2yL7q6XUcJS4afJ2E10QxrmuAIOpCVx2W8XMUpeZlBRcm
         Nqh/GU6ac3IlX6ffqOu7BLRtR+8WtK5dOQa3cEN/Em12J0G2dHZVyIXsEia9X9DK2D0T
         Asr/j28T7mTt2F36O/w6/Ey74HAZ44x5IlCpkdArZYzthxQ81nJCOyJFMhVhloNouEsM
         b7NeTlGfGsi3NsRk0GENLnZdolplYaK/6TJqbO4w9SjyXflzCdx5C6PxXERUYTkLxvBw
         qGAg==
X-Gm-Message-State: AOJu0YwvPEoiWiZSePCwScnjJtZKSMWXuR2ift5FCYzrhYIfPbSo2v5P
	YnmwezhHwdcmOl8M8qPC94U=
X-Google-Smtp-Source: AGHT+IF8Jz7J4xTrM8h+jgL9PBo16u8k7NgSfDJiJxStwc5yhbCB0A0b2H3LUcMuNoYb5olFmjldiA==
X-Received: by 2002:a17:902:7293:b0:1d3:fa3f:6688 with SMTP id d19-20020a170902729300b001d3fa3f6688mr1001796pll.61.1703249922833;
        Fri, 22 Dec 2023 04:58:42 -0800 (PST)
Received: from rigel (60-241-235-125.tpgi.com.au. [60.241.235.125])
        by smtp.gmail.com with ESMTPSA id f3-20020a17090274c300b001cf6453b237sm3385299plt.236.2023.12.22.04.58.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Dec 2023 04:58:42 -0800 (PST)
Date: Fri, 22 Dec 2023 20:58:37 +0800
From: Kent Gibson <warthog618@gmail.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Bartosz Golaszewski <brgl@bgdev.pl>,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
	Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH v1 1/1] gpiolib: cdev: Split line_get_debounce_period()
 and use
Message-ID: <ZYWH_ZLOz7eKh0CE@rigel>
References: <20231221175527.2814506-1-andriy.shevchenko@linux.intel.com>
 <ZYTihbWMcHMHSkC_@rigel>
 <CAMRc=McSXrivkzhJVEh7-+1fzO6EBLMawhxYd7YgcsXW9wBKbA@mail.gmail.com>
 <ZYWD26B-xQqiDOD2@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZYWD26B-xQqiDOD2@smile.fi.intel.com>

On Fri, Dec 22, 2023 at 02:40:59PM +0200, Andy Shevchenko wrote:
> On Fri, Dec 22, 2023 at 09:58:48AM +0100, Bartosz Golaszewski wrote:
> > On Fri, Dec 22, 2023 at 2:12 AM Kent Gibson <warthog618@gmail.com> wrote:
> > >
> > > On Thu, Dec 21, 2023 at 07:55:27PM +0200, Andy Shevchenko wrote:
> > > > Instead of repeating the same code and reduce possible miss
> > > > of READ_ONCE(), split line_get_debounce_period() heler out
> > > > and use in the existing cases.
> > > >
> > >
> > > helper
> > >
> > >
> > > Not a fan of this change.
> > >
> >
> > Yeah, sorry but NAK. READ_ONCE() is well known and tells you what the
> > code does. Arbitrary line_get_debounce_period() makes me have to look
> > it up.
>
> We have setter, but not getter. It looks confusing, more over, the setter makes
> much more than just set. Hence another way to solve this is make clear (by
> changing name) that the setter is not _just_ a setter.
>

As I mentioned elsewhere, the side effects of the setter are irrelevant
to the caller, so from their point of view it is _just_ a setter.
Calling it something else would actually be more confusing.

Cheers,
Kent.


