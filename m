Return-Path: <linux-kernel+bounces-105793-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D5BF787E497
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 09:01:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 122441C20C00
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 08:01:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8C4C249FA;
	Mon, 18 Mar 2024 08:01:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hA2ze8xV"
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 621E3241E1
	for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2024 08:01:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710748880; cv=none; b=EUjpwJfsZBjgmUI1EOII2MPBT0nFh6Lwad0KKb3tFXA7nTYGWtF0YmVS1Y/JfHKRBAZS9Igexxl0zcbRh86kE4YW3Jg3Yum0xaVWLJ4nw9Yh8Q2W8CVjizBVNOv9OEKDhYOQMSzUSOt3+Q2KV4tbLOAu1Pd2akjHwK6Kjy3aZJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710748880; c=relaxed/simple;
	bh=iB85aYGmUCbO9V/e5pZGdJl9hpxyDlCg+1fwsehbscI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S9qfL8XJ8WAzggqUU4L+WYO3CK9ph+1q/H86o8Zy/j/HyjMTXUYT/UFIZX1fScoBxoomh6h4HZWuGKP3svtw2nOo8oUgypafL5Kd7hmeeSG1hUeeWUWYwPhvIuhXg77fHRWmi9/sl/HzsaKY/0WONCA/hzCIQR2n2JK/Xt+nrOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=hA2ze8xV; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-56b7facf2e1so341342a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2024 01:01:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1710748877; x=1711353677; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=MKMaAttCP6hb7C+u7MLE+GUVtnN97FseTKGTtYCu3sU=;
        b=hA2ze8xV10hyCvFXMIg70m8LPFxpTFIFTTOkHyN4QeXjuf+oKRGW7fnu7rqK/Y7r9h
         xSD0NZKGkY5R+Q3d84lIiaQqRRvlpnVPkVBOyCB6FpgcN7SAHZZ0u4Gcpyg08KxzDw/H
         MSzu8rm/1u+nyrxkKhv0IFTmBaHrnVO13JdZzcp0M2EmaE9t/uQIk/g0kD/WOnNQ9bak
         dFqbPmWFTXuSvI7Pr3GOYslQCOKNsqHaNSuiN9dJVBuIlp1npRe9yqQv309118o8AYUA
         n+0dwJbOqOWPSrOkD0upJbNHDSxtULgIbBh6cHJVdzfak+RN34MADh74gR0HjwB5/M7i
         iL+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710748877; x=1711353677;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MKMaAttCP6hb7C+u7MLE+GUVtnN97FseTKGTtYCu3sU=;
        b=j6yW9JXfdOQEwifUHwkDDgkKI4+sALko8T8nAKKEtHu3cRLt7lZ7mey0sPmtOA/lT7
         aAgMVYn4KbT2YBMwxvRbjW9laGzZ9iv2w1QX5ZqtHm4WsdCcLIJDXKhEuxHXnz3EWfdW
         gTkcF/vr82y5mBLZpIqJJh/6T/1FAfikkHf17PNBII4Id5OnuvcQzpE40dMnofSO4Q/m
         fFO07PXb0VLRrnvzg/EhRp+q0ehIGHAR071oD4MW7HUGhdUgISAi46tIAYnS/QrnYzmj
         s3ikM5VNyTmdgVyO7BHfk3Zp03ueSvThlRrLlUE7EJI+TH3Jk3BKS1cHzcnPtFehGwXs
         m2gw==
X-Forwarded-Encrypted: i=1; AJvYcCWKtiOeIYtOWqUtil9+oJ7C0K2/xykWGXeRc41fFhHsWXlcRShvNvzr5zorysjDA1NkEwdmOkwF+R/8DxESmuAxm0H+Lyla1Agcedj5
X-Gm-Message-State: AOJu0YwEGv4e0ePsZ9tSGufjvgnkOGbFR+vKf6vGO9gh/EkbRWg0la9M
	6/a1lSD++mRqwehDhSvX10wbYmb3U09DEXli/B+rFdc4xmsTWMriW1WqZ8/Q2YQ=
X-Google-Smtp-Source: AGHT+IFoXELRc9Tw5lJNGAKg3uNqc7S1nog4kOCdlgZSG1DP3JVGB0UzWwCQsfcef1Guf0Wv2xW3sQ==
X-Received: by 2002:a50:cccd:0:b0:568:b71a:5954 with SMTP id b13-20020a50cccd000000b00568b71a5954mr1828600edj.10.1710748876538;
        Mon, 18 Mar 2024 01:01:16 -0700 (PDT)
Received: from localhost ([102.222.70.76])
        by smtp.gmail.com with ESMTPSA id cs4-20020a0564020c4400b00568a1ce4562sm4157752edb.25.2024.03.18.01.01.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Mar 2024 01:01:16 -0700 (PDT)
Date: Mon, 18 Mar 2024 11:01:12 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Philipp Hortmann <philipp.g.hortmann@gmail.com>,
	Lee Jones <lee@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
	Larry Finger <Larry.Finger@lwfinger.net>,
	Johannes Berg <johannes@sipsolutions.net>,
	Kalle Valo <kvalo@kernel.org>, Julia Lawall <julia.lawall@inria.fr>
Subject: Re: [RFC] staging: wlan-ng: Driver broken since kernel 5.15
Message-ID: <cbdb25ca-f419-4afe-9b58-7d274445aefd@moroto.mountain>
References: <6dc14151-e71e-4118-826d-3ca5c8ee907f@gmail.com>
 <fba3951f-00b7-41af-8ef4-1e7c86e0cb48@moroto.mountain>
 <6c772d15-d249-4175-93f4-ca523006129b@gmail.com>
 <5716d138-ace0-4621-ab34-118610255207@app.fastmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5716d138-ace0-4621-ab34-118610255207@app.fastmail.com>

On Sun, Mar 17, 2024 at 09:20:34PM +0100, Arnd Bergmann wrote:
> On Sun, Mar 17, 2024, at 21:07, Philipp Hortmann wrote:
> > On 3/11/24 08:04, Dan Carpenter wrote:
> >> On Sat, Mar 09, 2024 at 11:09:24PM +0100, Philipp Hortmann wrote:
> > You are right with the statement that it is this commit.
> > commit ea82ff749587807fa48e3277c977ff3cec266f25 (HEAD)
> > Author: Lee Jones <lee.jones@linaro.org>
> > Date:   Wed Apr 14 19:10:39 2021 +0100
> >
> >      staging: wlan-ng: cfg80211: Move large struct onto the heap
> >
> >      Fixes the following W=1 kernel build warning(s):
> >
> >       drivers/staging/wlan-ng/cfg80211.c: In function ‘prism2_scan’:
> >       drivers/staging/wlan-ng/cfg80211.c:388:1: warning: the frame size 
> > of 1296 bytes is larger than 1024 bytes [-Wframe-larger-than=]
> >
> > But It is not depending on the line you pointed to.
> 
> Right, the kzalloc() already clears the data, so the memset
> is not needed.
> 

No, it's inside a loop so it needs to be cleared on each iteration.

> > I need another week to look into this.
> 
> I'm fairly sure this fixes the bug, the problem here was that
> the cast to (u8 *) hides the incorrect conversion:
> 
> diff --git a/drivers/staging/wlan-ng/cfg80211.c b/drivers/staging/wlan-ng/cfg80211.c
> index 471bb310176f..9d6a2dd35ba9 100644
> --- a/drivers/staging/wlan-ng/cfg80211.c
> +++ b/drivers/staging/wlan-ng/cfg80211.c
> @@ -350,7 +350,7 @@ static int prism2_scan(struct wiphy *wiphy,
>  		msg2->msgcode = DIDMSG_DOT11REQ_SCAN_RESULTS;
>  		msg2->bssindex.data = i;
>  
> -		result = p80211req_dorequest(wlandev, (u8 *)&msg2);
> +		result = p80211req_dorequest(wlandev, (u8 *)msg2);

Ah, well done.

It feels like this is the kind of bug which should be caught with
static analysis.  One of the things that people want from static
analysis is looking at what a patch does.  So if we pass &msg2 and the
patch moved msg from the stack to be kmalloc()ed, then print a warning.
It's not something that Smatch does.

I have my rename_rev.pl script (https://github.com/error27/rename_rev)
which I use to filter out variable renames or see if (1 << foo) is
converted to BIT(foo) correctly.  Maybe I could extend that to check
"move stack to heap" patches...

regards,
dan carpenter


