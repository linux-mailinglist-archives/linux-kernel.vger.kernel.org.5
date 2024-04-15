Return-Path: <linux-kernel+bounces-145506-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 15DCF8A571C
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 18:08:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A9CC11F22821
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 16:08:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2956F8062B;
	Mon, 15 Apr 2024 16:08:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hZtsjETm"
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37BEA8BF8;
	Mon, 15 Apr 2024 16:08:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713197315; cv=none; b=J62F+ySPPGcg1LjIBPyZmhlS8wecBp0kjz0czPoaTMxOLU6yGVAdOFSA/Yn24JxC7+w5Ul6Z33VTahpIaBhOlNw1np8OU06/nSsfaArhV6rcg/1ROtCx/vtGh8+SSnkgYAUbP07P3gEHm41qMr/Tipfk5sKX3L7vI/RcT9hM+iQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713197315; c=relaxed/simple;
	bh=7uG1NhDw6PKvPJnncdvPDTqawqTBZ9/3GLUgAKyTgCQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AVlG+id+nZXvd+y5Fy6OO/3IDBHhc9kXAjpt3qY8t5rRsAqSKKa6CWH1BWa3GyUc66znJUWHyfY+OO/AsCrnWOAkxbwfd/8cD0Zqu7dGASDtKFA5+SKD1b5w2TSm7WkwHoq6xP724ginspqvR8p1zHzeca7m3WKhr0uWlKnDlfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hZtsjETm; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-2a55a3d0b8eso2160725a91.1;
        Mon, 15 Apr 2024 09:08:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713197313; x=1713802113; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=7uG1NhDw6PKvPJnncdvPDTqawqTBZ9/3GLUgAKyTgCQ=;
        b=hZtsjETmnhejSU3mWEE5wgZkgfbkKtnG7Ep/trTq5LVkZNX2YaLeVkaV36W4tBB6W4
         ASkzuB1Jk4PJgyprpMq224gS6XnKnE9fv/S4A7WLZdtRMzzgumW1u+1ArmNXPEj7/7F1
         xB5e0fk19IeKIDhBIqQV3j7Q/DEOD6IUX2oV7HVg6CQhQBqwDPzAhn274ZuHA7xqaY1Q
         1TJN6zGi2H/kQK8/aychGxXrro2UZw7S9W4wgPXHqUhjGzN9v8CHtw4f8aikoRzhP853
         nr9DxqGWFbun408GsCBohaLlvdWyqLySQsQZH18foig4aXEam4GO8LKSNLX6tK7lMNLn
         mR1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713197313; x=1713802113;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7uG1NhDw6PKvPJnncdvPDTqawqTBZ9/3GLUgAKyTgCQ=;
        b=S9WuIAl7c2BgbKK5pGBacZTz/rTWEow2HSUnNyjuZpNZZZn6usms0eQrnQ+yJ3DWNg
         gWf2arXl9fv5Fht0VeV5mdW1qnPEd/Dl0cHpdWmIoF75QRhcLShQIQgXuqLdmYGk0bBy
         LXsX1T7vRWK0iPLsZogJH5ydEpeD6GRCsjj2MrI7Ufmcs6s2EiTku0JB1e0V4y5Tq/E6
         BbtwmNMIi0Lpag3xQtcAKxlysX6jxeOJ20ltlBrzzyHBwfBJN0fSVQTTX6Y/DjIbMvHb
         f9KL6bvojhNTYjubXmXO5HclDbOxc6vAU2KeiXu96qTJ7Lpi/L6JaRhMDi0l7Oa/214V
         fvTA==
X-Forwarded-Encrypted: i=1; AJvYcCXW4cDwPSGVIzcfdayjNsx5fy9n1E8Bm3dev3vdwIrOiD4ktfLcO/AcO33KJf2B9j6psUamdi2himlE1iSgWrtrnMPe4eZcHKNd6RvDkNBUAlJcn1AGQtLcwAaITVmny5ESlrEUISSaYLAviXY23RO1EqmB/aA8cyieQTtCA2MGa9IdmgrujsICkBSTphRSSxELVZtZ2NPcDN1gw84K7XRH
X-Gm-Message-State: AOJu0YwNhNr2S323b7jS5hVJ7Fi4rLxy1Bp+9QFuLDar6cAMMRe8o05L
	FBJTw4HpaFDwa9vqMXq5axPlr4jLd7KHZ5HEHZW05Ft0WY1DmMXSxdgfKvXYGFrsSwA92xZc3gx
	7qmjLv6FX6AVZfpSz5c3QCiB7gOo=
X-Google-Smtp-Source: AGHT+IFWO6nlrMJmutSX59RW7e3qJHcpdliV/hqVvvX5tCC4s9nNzTrSMT2rNbIwYz3dSTVQ1wEOkjiblCWkFGYaVuc=
X-Received: by 2002:a17:90a:5315:b0:2a2:6244:32b5 with SMTP id
 x21-20020a17090a531500b002a2624432b5mr124718pjh.11.1713197313458; Mon, 15 Apr
 2024 09:08:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240412162510.29483-1-robimarko@gmail.com> <20240412162510.29483-2-robimarko@gmail.com>
 <4a1e0cb6-c319-4eb1-9bd1-5ff13eabfe1b@isd.uni-stuttgart.de>
 <c7106c8e-0c99-4160-966e-b1a8ba5770ee@quicinc.com> <87ttk2y5iz.fsf@kernel.org>
In-Reply-To: <87ttk2y5iz.fsf@kernel.org>
From: Robert Marko <robimarko@gmail.com>
Date: Mon, 15 Apr 2024 18:08:21 +0200
Message-ID: <CAOX2RU535xy_nGBnsqZzbjF1VGqNRtFKdT-zMVTNTgUmi0HeXw@mail.gmail.com>
Subject: Re: [PATCH 2/2] wifi: ath11k: support DT ieee80211-freq-limit
 property to limit channels
To: Kalle Valo <kvalo@kernel.org>
Cc: Jeff Johnson <quic_jjohnson@quicinc.com>, 
	Christian Lamparter <christian.lamparter@isd.uni-stuttgart.de>, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, robh@kernel.org, 
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, jjohnson@kernel.org, 
	linux-wireless@vger.kernel.org, netdev@vger.kernel.org, 
	devicetree@vger.kernel.org, ath11k@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 15 Apr 2024 at 18:06, Kalle Valo <kvalo@kernel.org> wrote:
>
> Jeff Johnson <quic_jjohnson@quicinc.com> writes:
>
> > On 4/12/2024 12:52 PM, Christian Lamparter wrote:
> >> On 4/12/24 6:24 PM, Robert Marko wrote:
> >>> The common DT property can be used to limit the available channels
> >>> but ath11k has to manually call wiphy_read_of_freq_limits().
> >>>
> >>> Signed-off-by: Robert Marko <robimarko@gmail.com>
> >>
> >> I've seen this before.
> >>
> >> https://patchwork.kernel.org/project/linux-wireless/patch/ed266944c721de8dbf0fe35f387a3a71b2c84037.1686486468.git.chunkeey@gmail.com/
> >>
> >> (dt-binding too. it has/had an ack)
> >> https://patchwork.kernel.org/project/linux-wireless/patch/fc606d2550d047a53b4289235dd3c0fe23d5daac.1686486468.git.chunkeey@gmail.com/
> >>
> >> sooo.... this is awkward.
> >
> > Patchwork indicates Changes Requested
> > Any idea what changes Kalle is looking for?
>
> I can't remember anymore but most likely I assumed based on Krzysztof's
> comments there will be v3 and missed that Conor already had acked it.
> Sorry about that, I set Christian's patches to New state now so that
> they are back in queue. And I'll drop Robert patches. Does this sound ok
> to everyone?

Sounds good to me, thanks for looking into it.

Regards,
Robert
>
> --
> https://patchwork.kernel.org/project/linux-wireless/list/
>
> https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

