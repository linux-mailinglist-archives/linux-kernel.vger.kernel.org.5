Return-Path: <linux-kernel+bounces-89412-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2781D86F003
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Mar 2024 11:23:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BB34F1F22113
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Mar 2024 10:23:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F140156E4;
	Sat,  2 Mar 2024 10:23:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S2lqwERC"
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 451CD17567;
	Sat,  2 Mar 2024 10:23:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709374988; cv=none; b=niKKLUXFLJ5wjdMA2Ynn/aYIOx9AxskHLwKCBBC2Agd8n4SBEWCZcML4RpC/nM3AqIm0I6SwomYiZTrkKeFbritMtSAzky3dT3OPw865wuBuWlVdWoMhhq7C7QITCR29mHbZvVDh9shPIyRJ9XDhkayYzcLRsZ+tv3ySQVJAvI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709374988; c=relaxed/simple;
	bh=1lLSSvoCrJfxIs6CmgAu4Yn8SWy84czRL+/AcPJF23s=;
	h=MIME-Version:In-Reply-To:References:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=c6UzDmI0YxrskUyrQ9AgLZaT78OUXr3ZGpfsKpYKVZHhkVz8Y//PzqjXraAYpCn6CGNLyE7yZ85jAwYYisx6LQFo694GTiuCHsDCCmQHEI91rFLyh9M9hXg8eLE045/wBgVTUMIEG9a2b66UZGblEJA4R7m8yDHG4xHHwkxKEo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S2lqwERC; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a44ee48fcf5so15694466b.3;
        Sat, 02 Mar 2024 02:23:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709374985; x=1709979785; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=LBV9h1xsuZcwlMzBeiT8nBrrdb8gAPnxFwKnUXtUNJU=;
        b=S2lqwERCBM5UC2lyIWcXLUeSaN9Rv09280zTIkuGVxu+fIEbCN5jsKbk2MHSwzveEZ
         cSlDuaK4s/0HoqU56Ikumc3SsB6mt4xbZRBCcsQAkz+EzbBnReY04relrlY0octe6v/w
         JJBXk40hmJ+/Lq4n3ze5W2V8en7UkzqnKtPKxOseaxa9bG4gU79bFWu3GnYy0/BkdH3j
         7bOv1ncbr+l/h/FX2rfTMjtlsF+P78xzvec1Bo2/dNoH/yPAMBzEJF6g7ydKJGNwZFnb
         0xt2wyqc605MBOtV/t3C/6xjikLmXQ1agzhLDb3OnITOE1AfbgjOd+o3Wijf12hIHH1D
         3TNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709374985; x=1709979785;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LBV9h1xsuZcwlMzBeiT8nBrrdb8gAPnxFwKnUXtUNJU=;
        b=EwFZF0czlfr//+SScMbv970HiatxL3Q4E5KkFJchuIBWOJbh0h2d6FJPg8ZXanEH1j
         POPOm2CsuFA9bwK5I01gxk+Vd0YfPuQfm6KT+5iKKMS3V8OWKCfZUNqmRWaeVMIj1MtW
         J/XFpddk2Ek03pxg3L/Iu0pWxvaMu+b4qlDZfv+YjBI25sby7Owni1+LHvbEqZ0E6H8d
         /p2D+TsgGLv+Rxn3eK4GkOwydM6ag0ITbi6UTJZD6CX2kMs6NrVGdWJ19SdGg7g2IbS6
         17vwCdu2WUNdn+tTpCuCJ6icd2p5IDrIeQg0xwwabKkiAkYqWZUb69YgJIBpYnHwwJlo
         v+ug==
X-Forwarded-Encrypted: i=1; AJvYcCXCBME0wU6QMPNlM+n/enjD4CxbV1Ag53OpVYib+aztF5YZ8mqlFolbOWr3hxvZjR+6mDI9GcvvQ5fIerGYkJJqLJKZVUCvE7BUk0RvUVZoWudAEb8n2Oiqng63gtS1wg8Gr9YR7cWCRYlXYTzb8z8uLmAw
X-Gm-Message-State: AOJu0Yzds89aeJl0HeGXauu6hibd0FiyKQXFz/qsGcR3gesAHIzVvKVl
	riNaXY8/cuUAG4mRtMi8fuMp3jQ56d5+UlGEdMNB1Zmb10i4OKsgL1Kw08v09AQ6b0KP985bUjM
	qT+qGPh7NIgCrJwFSlg073Qzz/Jw=
X-Google-Smtp-Source: AGHT+IHj8ONhpi9AB+guG4N/2SKtmitcDyxljlr4elD+4OZN9rDfDcisQjCg1lWLGsGDFnsviiu26cPYDF/qdmHQeko=
X-Received: by 2002:a17:906:b09:b0:a44:2634:5c1e with SMTP id
 u9-20020a1709060b0900b00a4426345c1emr3307282ejg.74.1709374985238; Sat, 02 Mar
 2024 02:23:05 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Received: by 2002:a05:6f02:840e:b0:65:85ee:340a with HTTP; Sat, 2 Mar 2024
 02:23:04 -0800 (PST)
In-Reply-To: <4871a305-5d45-47d2-85f2-d718c423db80@canonical.com>
References: <f184a2d6-7892-4e43-a0cd-cab638c3d5c2@amd.com> <096178c9-91de-4752-bdc4-6a31bcdcbaf8@amd.com>
 <4871a305-5d45-47d2-85f2-d718c423db80@canonical.com>
From: Mateusz Guzik <mjguzik@gmail.com>
Date: Sat, 2 Mar 2024 11:23:04 +0100
Message-ID: <CAGudoHFkDmGuPQDLf6rfiJxUdqFxjeeM-_9rFCApSrBYzfyRmA@mail.gmail.com>
Subject: Re: [RFC 0/9] Nginx refcount scalability issue with Apparmor enabled
 and potential solutions
To: John Johansen <john.johansen@canonical.com>
Cc: Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>, paul@paul-moore.com, jmorris@namei.org, 
	serge@hallyn.com, linux-security-module@vger.kernel.org, 
	linux-kernel@vger.kernel.org, "Gautham R. Shenoy" <gautham.shenoy@amd.com>, 
	"Shukla, Santosh" <Santosh.Shukla@amd.com>, "Narayan, Ananth" <Ananth.Narayan@amd.com>, 
	raghavendra.kodsarathimmappa@amd.com, koverstreet@google.com, 
	paulmck@kernel.org, boqun.feng@gmail.com, vinicius.gomes@intel.com
Content-Type: text/plain; charset="UTF-8"

On 2/9/24, John Johansen <john.johansen@canonical.com> wrote:
> On 2/6/24 20:40, Neeraj Upadhyay wrote:
>> Gentle ping.
>>
>> John,
>>
>> Could you please confirm that:
>>
>> a. The AppArmor refcount usage described in the RFC is correct?
>> b. Approach taken to fix the scalability issue is valid/correct?
>>
>
> Hi Neeraj,
>
> I know your patchset has been waiting on review for a long time.
> Unfortunately I have been very, very busy lately. I will try to
> get to it this weekend, but I can't promise that I will be able
> to get the review fully done.
>

Gentle prod.

Any chances of this getting reviewed in the foreseeable future? Would
be a real bummer if the patchset fell through the cracks.

-- 
Mateusz Guzik <mjguzik gmail.com>

