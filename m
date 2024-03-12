Return-Path: <linux-kernel+bounces-99812-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 35E95878DBB
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 05:08:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2EA0B1C214C3
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 04:08:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65E15B673;
	Tue, 12 Mar 2024 04:07:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OgXektso"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 534219463
	for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2024 04:07:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710216475; cv=none; b=Egh2bBgXsC/CIKSFncRmcgme9eKfKHwWP0ceQAu53ErR64hIDfmTUfeJBBmSDWVrt1LUu81eDdvUcBRR4xfJB9DX2Toasv1dJOPOGg5g0c8ifU/DD5+FJxlIoLe15ecrLRDzMRmG6s76+O+M6vX2kOSxGbfiRyKsu5VLwm1I0ig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710216475; c=relaxed/simple;
	bh=xhCrtIFJOJF9cgRaioYZjeWudvsSAP23BkSvPeUxz0Q=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=UwJju9fqVCJSsryQCugUDU3GsRp+eM3rhE1v+rtcKCKHCFxHBZcpj3jyDHlmBLGrybPuMQHOiHLafIOlWHd59Ecj1BijP4h6FTNzXpz6VP+QU8F8dSJGwTU/EdU8V7iYou0URLwE0rX/omdANAzmaufEtXFvoJPSzQ6QlQKMFzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--yosryahmed.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=OgXektso; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--yosryahmed.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-60a2386e932so46122387b3.1
        for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2024 21:07:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1710216473; x=1710821273; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=RtyFjQ1ew/Km7nQfV9Ii5WtnlkpNOm8r5T7xPWUQ1Vg=;
        b=OgXektsotiFqBs1mze3kSbLN7qcYA9qV0DN2cy9v6GDMuLLP15lLDrPWKoqtVAp/6+
         MNOfG9+nVCZt2sLUasxuieeX5T0Oki1tklwNKC7dLDQASFL7EpNpPOX7xFQsHGkrflRv
         wAmnloKeN9Z9Kt+W6MkCjm7Dtdz+8wtOsF1MqnEdNK6+NHIKqTK+tGT8lpytgwyNt2JX
         5A1lz+6/93kz6wP2S/JZKe+8n5vNsTfjbOqj4AebKyVTBxpn/FvNrZenhz3NJPaugxdj
         Wu4MXQ9B4keHQ2jzTeNL8h8OvJI9kn5VQO34MVNhVBnik2Qdkool1xBrWbamVXZy34wG
         UVxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710216473; x=1710821273;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RtyFjQ1ew/Km7nQfV9Ii5WtnlkpNOm8r5T7xPWUQ1Vg=;
        b=enZf0t4UZTo/z4xf/ptx2Ui3YclwNlLgj3sMOJQhPd0MPIuiBo99I7a/NNAVXE0jAD
         7i4aR0XlmIspt80Dn26HwBwpto+wozSP0KUko+yplvfUBQdoLH0gu6LusQfaptD/DjYG
         BLwoHVRR0gmRQ1uAmizqEx75X5IpYFkQRMlgpJirtaJLHvE3RPOsMdk6xHA8g9S7IoCo
         tnstKd/ls5Vo1SjemGKHslRU41aDv3YBnFriI/oOmgzQbZDH6id0BnP3yqY4Oz/aVvMz
         X2hUS5pdw74U96nctkduIdq6WCCcDH5m4E8YMvdknLm6ly/dBmlHZyJRIsYBUo6twUnd
         UHcg==
X-Forwarded-Encrypted: i=1; AJvYcCVIw65MoWS4B0+dlJdH7KomPKaD90KyyWwYzbn4dkj9pfVdnrJdNAuaWUriSFqBplwDirnoctZbCw8l2C7n2HrE463sKC/fDN/zzTB/
X-Gm-Message-State: AOJu0Yw/cKPYpIK1TZaC8I2KPhen8RKqK9hm09CJn7++o6bBR2ePzlo6
	nCgCzuQ48eAZqTOmAC9xis/PuuOxu5WT8Lifwn4xAfAC6QYuJEXpP7hZsKG4UwG65FfWj+8DQ3W
	+zzTFtTBU0uk8c4Bdpw==
X-Google-Smtp-Source: AGHT+IG/iOZyVwkauiddFoT8Ft1lhQSt8JC0GtCjLf0h8UyhUxK4XKmzq7fY16L4xzPeeRHZ4Geo+Jy3Lm05Gn3/
X-Received: from yosry.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:29b4])
 (user=yosryahmed job=sendgmr) by 2002:a81:9146:0:b0:609:e89c:983f with SMTP
 id i67-20020a819146000000b00609e89c983fmr2319782ywg.10.1710216473351; Mon, 11
 Mar 2024 21:07:53 -0700 (PDT)
Date: Tue, 12 Mar 2024 04:07:51 +0000
In-Reply-To: <20240312023637.GB22705@cmpxchg.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240311161214.1145168-1-hannes@cmpxchg.org> <20240311161214.1145168-2-hannes@cmpxchg.org>
 <Ze-Bsr8lfC1lm1u7@google.com> <20240312023637.GB22705@cmpxchg.org>
Message-ID: <Ze_VF2NmY6xxMod6@google.com>
Subject: Re: [PATCH 2/2] mm: zpool: return pool size in pages
From: Yosry Ahmed <yosryahmed@google.com>
To: Johannes Weiner <hannes@cmpxchg.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Nhat Pham <nphamcs@gmail.com>, 
	Chengming Zhou <zhouchengming@bytedance.com>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Mon, Mar 11, 2024 at 10:36:37PM -0400, Johannes Weiner wrote:
> On Mon, Mar 11, 2024 at 10:12:02PM +0000, Yosry Ahmed wrote:
> > On Mon, Mar 11, 2024 at 12:12:14PM -0400, Johannes Weiner wrote:
> > > All zswap backends track their pool sizes in pages. Currently they
> > > multiply by PAGE_SIZE for zswap, only for zswap to divide again in
> > > order to do limit math. Report pages directly.
> > 
> > Nice. Although I would prefer renaming the zpool interface to
> > total_pages and renaming the zpool backends functions as well to use
> > pages rather than size.
> 
> Ha, I was on the fence, since it's kind of churny. But if you don't
> mind, then it works for me as well.

If we are cleaning up, might as well do it all the way :)

> 
> > Either way:
> > Acked-by: Yosry Ahmed <yosryahmed@google.com>
> 
> Thanks.

LGTM. Feel free to carry the Ack forward.

