Return-Path: <linux-kernel+bounces-83258-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 67C6B8690E6
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 13:50:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E35ED281FF7
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 12:50:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CC4613A883;
	Tue, 27 Feb 2024 12:50:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bY4lN4vd"
Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com [209.85.167.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 287E1135A5C;
	Tue, 27 Feb 2024 12:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709038207; cv=none; b=q0dnfgjYkm3KCQyxp/FVseW6/IOa0m7R4e6A0473SkvmsFyk4No9RmywIfm49nFfij+fBHvLrITCIfMJDYAqjmjElPQCMSt4Hl9VSRZg3AhoIZol8b3Tfd8OMdyIZD/52B0dT+9NaMDiT7eAkVmICkd0BJWYpCtAwN+1P1l4wmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709038207; c=relaxed/simple;
	bh=dBAwc9AUX2eiHfVnP7QKfGIEipxZrMAtd9DEhO5h2zw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pTKpNnEBDedzg31dbUbOfUm9p84mEmaqMG2TUBx44vOILWBoXDi7HFk7v4hiCeEtZVEztKJqPuL1y7pGnf5gGB32vo02H9+lR1oznK3I0qckpKUbqD5t2P340+OTGrv1RB5FBTRzkZ8QM+m8vMy75XCsgWYlscVevyJs8IOIuIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bY4lN4vd; arc=none smtp.client-ip=209.85.167.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f174.google.com with SMTP id 5614622812f47-3c1a172e158so384931b6e.0;
        Tue, 27 Feb 2024 04:50:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709038205; x=1709643005; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=F/8TLN5kAmVzuWnrwCPlCAhzdNiyKR8NIwFU1ivGP6Q=;
        b=bY4lN4vdBHesuM32kO5e+oGTINVfiVZo5smXjJ5OW+/HpZubQBX2LNkJLG84eZsZ7n
         AmR96g+vzYchrxskyRdbUkf/lzoEWdwMwS08dvRh1VKQuvHYo8LZtwryPlpyQEO2/XMV
         gVZD27ESSI0PR0LRf/V/f/bk05TFo6ER12sKbMZkltunJwuc1AvMBsdB4jG0CFLHmFNm
         AqqZgo9hGhOCJ9YyFK0nEVRF+ALq9DDncWCnF1Aqb8sGqLV53UDaqQhHiT5qb5glXBoU
         nrPc6JMP3quWh0780Sd5sDmH8IjjyELVc3gM2cqPJGWy7NXFru8GykoprofUc+qnd3FX
         c/nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709038205; x=1709643005;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=F/8TLN5kAmVzuWnrwCPlCAhzdNiyKR8NIwFU1ivGP6Q=;
        b=I50yw33SeLSamN0zGwslAYUv9d9Ivi5ciMziwWpvNc+HfE4ONaYt6vxwNC6VvYFcvX
         QNShZ2McJJzO6FYgY6Z1+y9Jlq7Z6XDkA/3o4/hFNqhN3D1cErS7jf9iRWIWgAF57tZP
         eHSMhKQxkILj6jQ5qHwoCkSXhaEHhC+Bj8vHvFvR8a1KvLzT5gxbAEd3cO+N2jOdu4Vb
         3kDa/g/cdBZa3ZoQCEwYwAfjgp//uwxPl0Ip/Y4XDVB1F2g8LeXXgXy/0jMO2Fxw9vEM
         Jsguz2z524yLJ91EGsGvJn/W3NNL0GnyfWu3nYgWYPDzXHWoNx+cM7MDlLPwCZCcmY8D
         39/A==
X-Forwarded-Encrypted: i=1; AJvYcCUZ0nrW27eBlZhbYQg8o1CIb/x5FwG3TJPjnkj/GI/F1xcfsziAtTKGByEU5ZcmWKWDzX2AFNd8S+R80x63dTv2A6H1bZtHw6Me9WtfCi3fD8rajkt9NQq5RmSS9GehvOwg8JzHmG0xsQ==
X-Gm-Message-State: AOJu0YyBjkz5Ow1cqhTkmjY2hjUDZst3I690Nv2UwWU60M4O74fvw29/
	vifZyoEL/VD5debtxA8shhbc/9EKKdp/aR0OoYjGuh1hoh39np/IUrzcVxk1Q9SMYzyfND/3ke0
	wvKKiu81SIULmBuZLPFpR0oDDECs=
X-Google-Smtp-Source: AGHT+IFpf3fUm6FcmrIThs6BXQtgpJXTn3AU43946pENs6vOHlERSeU5iODtj2rnFktpgmREMTo4xF5qQjXehS/m7ew=
X-Received: by 2002:a05:6808:274b:b0:3c1:9422:8953 with SMTP id
 eh11-20020a056808274b00b003c194228953mr684685oib.25.1709038205105; Tue, 27
 Feb 2024 04:50:05 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240226182310.4032-1-linux.amoon@gmail.com> <8ceea100f2ef7cce296943ce1397161a@manjaro.org>
In-Reply-To: <8ceea100f2ef7cce296943ce1397161a@manjaro.org>
From: Anand Moon <linux.amoon@gmail.com>
Date: Tue, 27 Feb 2024 18:19:48 +0530
Message-ID: <CANAwSgQnoBx+th6s254sML+Zw+RZQC6WU9TjfMoWgHxmCqbDcw@mail.gmail.com>
Subject: Re: [PATCH v1] arm64: dts: rockchip: Add cache information to the
 Rockchip RK3566 and RK3568 SoC
To: Dragan Simic <dsimic@manjaro.org>
Cc: Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Heiko Stuebner <heiko@sntech.de>, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Dragan

On Tue, 27 Feb 2024 at 00:39, Dragan Simic <dsimic@manjaro.org> wrote:
>
> Hello Anand,
>
> On 2024-02-26 19:23, Anand Moon wrote:
> > As per RK3568 Datasheet and TRM add missing cache information to
> > the Rockchip RK3566 and RK3568 SoC.
> >
> > - Each Cortex-A55 core has 32KB of L1 instruction cache available and
> >       32KB of L1 data cache available with ECC.
> > - Along with 512KB Unified L3 cache with ECC.
> >
> > With adding instruction cache and data cache and a write buffer to
> > reduce the effect of main memory bandwidth and latency on data
> > access performance.
> >
> > Signed-off-by: Anand Moon <linux.amoon@gmail.com>
>
> I was about to send my own patch that adds the same missing cache
> information, so please allow me to describe the proposed way to move
> forward.
>
> The way I see it, your commit summary and description need a rather
> complete rewrite, to be more readable, more accurate, and to avoid
> including an irrelevant (and slightly misleading) description of the
> general role of caches.
>
> Also, the changes to the dtsi file would benefit from small touch-ups
> here and there, for improved consistency, etc.
>
> With all that in mind, I propose that you withdraw your patch and let
> me send my patch that will addresses all these issues, of course with
> a proper tag that lists you as a co-developer.  I think that would
> save us a fair amount of time going back and forth.
>
> I hope you agree.
>

I have no issue with this,.If you have a better version plz share this.

Thanks
-Anand

