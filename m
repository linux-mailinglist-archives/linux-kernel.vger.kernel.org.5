Return-Path: <linux-kernel+bounces-143304-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EF168A36FC
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 22:21:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F0B38B218A0
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 20:21:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C7B51514F4;
	Fri, 12 Apr 2024 20:21:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TSK08Iyp"
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D26E01509B7;
	Fri, 12 Apr 2024 20:21:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712953293; cv=none; b=kKaZ95I5V1oo1hAviX30pQleyirIkc1YiuRwbZzvcOQKGLdvZgnQoSkqkOPIrFBgIkzJQ+ipA9kt/xg+OAjNPaN6XMN1JFr7WtU2PMzCwNEp0PmRVeOc0nwBvjKkG1aPFN2ZmNHT18Pe5raOAr/J3wZjj9XAw7pJEGefuq/bkx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712953293; c=relaxed/simple;
	bh=D1LNnJyJyc/QLuWcAtYlqb7DUfFc0XhDzRcdfauRS+c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SdYtHwh09QZKuZpeLTz/MYK7RVHz7+E+P+imHlE5F0KmnSA80HbcII02EqwzwtJjCVT2Gcg+vmpU8qHJf13Cc4SHly/BSeKpFnVq+3QdhT/4mvwRjtmbBzQ9fk0y5DfzZnZDYiwZfX9JSfwdWqjdHH16mT3RGihu81lPZWv6RBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TSK08Iyp; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-2a4df5d83c7so808226a91.0;
        Fri, 12 Apr 2024 13:21:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712953291; x=1713558091; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=xRhxtl0wttxPAELEpzn5FbA0uT6tMNbWqPbBtzgT++s=;
        b=TSK08Iyp1wRfsJK8LxwqE7O3yk61twmYlzYiwe+KrQmFYvaNL3SRMvu8FNOlEkDSL9
         UHxckQ+WqGdQAnKJraVLjJJIyoeVa3n8QlwlCaF5ftllmohwzrShM+yoe9G4P1wLCfKX
         kvKOSafB/WP1dj0MUwCoAed1HCnsoaGBbQTu0LHwE3nNlxbFN7vQyQUr2mUrXaGx9cLD
         q395sjumTZnmxTktU1YbyxosOIYAO6zITWw+c6vIzHh0NSyt4mMS40uV+hrRm9iIYSsv
         1sUFXNkX74TEdS3W+U1dcZXJjbCq/DMu9V0FsZneQZW+ZgPcAYbCuzPdY5/x4J0UwGyU
         BB/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712953291; x=1713558091;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xRhxtl0wttxPAELEpzn5FbA0uT6tMNbWqPbBtzgT++s=;
        b=TZ7ZeTEeGTiYcyE8Hnz2sO+DSiQuYtVObw9HyDa1KPHDL4y0gKRTax/sIseC/gduMj
         TBt32UUYIcnlUro6y+KHVQ5cA+NgGa1MHaz6rhkySRN8WB+hv4t/7lfjI5amldiljvz2
         kJbRs8EU7MRVrOIL3whgaBc8nKw8Aw40BZyYG1rsmQXTOHVZaGMkM5nQ0Qcu6fCE2R55
         guCoLQgoeFHIY3nPDRSQkQArwI1bTZ/aQL8WWFf8M4X5stXkEIgcFmQwESG570OxrTbk
         1JvZkZ1rryDCsnCaYBp9DA6PPxzPuOrXiaO7jWpeImeJqCCL5DoJd0RMJH9hIuVR1xLv
         80Iw==
X-Forwarded-Encrypted: i=1; AJvYcCVu0lfN8qwuS1VZVJvAYEqVNIKWh2uTjbrVboD1VSp3hRCP7D8f/SS+3x8O+8V0yMTBzbZg2gwz8K5FBOyEwBxw2NFJI3k0mtXrXmKU6VgV5UsG1cDUUzHgsAPURpByd2u4/1dlz6nbG5ol8v0jCpmoUXgMGqriUKqGZgSK6EpHE8WVOwJnfj2rx+KtHyRl4i3iYT+Qy3TPI+YEqHjyQH5M
X-Gm-Message-State: AOJu0YxSPJWuKlod0BAN8BeWXP3TV0jYlrFfK4kNgYiqCcDAtJAkivod
	/1QrOXUx+Vtifiot90tMgWpuxnzJLp3L/p6fgQWyeuYNqOOPse18mT1M5t81GMrOhE3rqMwQv8/
	SL01veJA6pCe+TD9mYNKxJbRKUg8=
X-Google-Smtp-Source: AGHT+IG7KN6iabo0XlVcK5USdt9XWkJn5cfypcOd3GkkkkUO155mnzCkwslkc6n9NeCzDgFyg6ui/1cj7xcnMb2xXCA=
X-Received: by 2002:a17:90b:3a86:b0:2a6:f977:39e0 with SMTP id
 om6-20020a17090b3a8600b002a6f97739e0mr2640378pjb.3.1712953291083; Fri, 12 Apr
 2024 13:21:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240412162510.29483-1-robimarko@gmail.com> <20240412162510.29483-2-robimarko@gmail.com>
 <4a1e0cb6-c319-4eb1-9bd1-5ff13eabfe1b@isd.uni-stuttgart.de>
In-Reply-To: <4a1e0cb6-c319-4eb1-9bd1-5ff13eabfe1b@isd.uni-stuttgart.de>
From: Robert Marko <robimarko@gmail.com>
Date: Fri, 12 Apr 2024 22:21:19 +0200
Message-ID: <CAOX2RU60K0JqeNWD5go4nM8aDnZmHQzF-Zx89MetqGxK4ySb2w@mail.gmail.com>
Subject: Re: [PATCH 2/2] wifi: ath11k: support DT ieee80211-freq-limit
 property to limit channels
To: Christian Lamparter <christian.lamparter@isd.uni-stuttgart.de>
Cc: kvalo@kernel.org, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, robh@kernel.org, 
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, jjohnson@kernel.org, 
	linux-wireless@vger.kernel.org, netdev@vger.kernel.org, 
	devicetree@vger.kernel.org, ath11k@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 12 Apr 2024 at 21:52, Christian Lamparter
<christian.lamparter@isd.uni-stuttgart.de> wrote:
>
> On 4/12/24 6:24 PM, Robert Marko wrote:
> > The common DT property can be used to limit the available channels
> > but ath11k has to manually call wiphy_read_of_freq_limits().
> >
> > Signed-off-by: Robert Marko <robimarko@gmail.com>
>
> I've seen this before.
>
> https://patchwork.kernel.org/project/linux-wireless/patch/ed266944c721de8dbf0fe35f387a3a71b2c84037.1686486468.git.chunkeey@gmail.com/
>
> (dt-binding too. it has/had an ack)
> https://patchwork.kernel.org/project/linux-wireless/patch/fc606d2550d047a53b4289235dd3c0fe23d5daac.1686486468.git.chunkeey@gmail.com/
>
> sooo.... this is awkward.

Definitively,
I completely missed your patch set and we needed this in OpenWrt.

You were, first so your patch set should be applied.

Regards,
Robert



>
> > ---
> >   drivers/net/wireless/ath/ath11k/mac.c | 1 +
> >   1 file changed, 1 insertion(+)
> >
> > diff --git a/drivers/net/wireless/ath/ath11k/mac.c b/drivers/net/wireless/ath/ath11k/mac.c
> > index c32be587000d..59bde128d351 100644
> > --- a/drivers/net/wireless/ath/ath11k/mac.c
> > +++ b/drivers/net/wireless/ath/ath11k/mac.c
> > @@ -10124,6 +10124,7 @@ static int __ath11k_mac_register(struct ath11k *ar)
> >       if (ret)
> >               goto err;
> >
> > +     wiphy_read_of_freq_limits(ar->hw->wiphy);
> >       ath11k_mac_setup_ht_vht_cap(ar, cap, &ht_cap);
> >       ath11k_mac_setup_he_cap(ar, cap);
> >
>

