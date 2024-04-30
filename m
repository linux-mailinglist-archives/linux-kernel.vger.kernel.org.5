Return-Path: <linux-kernel+bounces-164571-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D388F8B7F7D
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 20:09:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 011A3B215E7
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 18:09:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12E8E181BA7;
	Tue, 30 Apr 2024 18:09:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VSNhCnjh"
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1984180A62
	for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 18:09:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714500565; cv=none; b=IGeGc2AjFPiqXqTSW0ag+0MWXSEcS+caHR8XFaNrMHOBZG8OKtNMainBLicHmWHqCn3HutrhopN9icAN5CSLyUXIBtkCTSe1eMClkSpCqfj8nYTnVWlLXvq7Hc0FIivqlCLFRnSLnb0ka7W6v6Sy57jdOR1P6ELTy8D7l1Izegg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714500565; c=relaxed/simple;
	bh=WMNTCdm5svpxXWjpVt60+t7ZBqUkllAdM5ompQ7ypY8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NgRNMU4l8H+N9cMWmhbOm3PF7ZJJrqXCTqqkyfUfkZQVC3Ux8ib/kZ4N9zdrgYRBIoWGWQ5r+RVw1+VBpbAcgVEG3PE5HVeTuUF8SiYgutL2YQo4bce9EJqkSKhXCLCnzCpVPukNcZBgmFQz7Rk4VTYJjAKK4K0BTx7AQ1NL6HY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=VSNhCnjh; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-61bed738438so9016547b3.2
        for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 11:09:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1714500563; x=1715105363; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WMNTCdm5svpxXWjpVt60+t7ZBqUkllAdM5ompQ7ypY8=;
        b=VSNhCnjhAsLxX4IG6kGWD2eekEQSNFADq7KFMewa8xTu7Je33HxhBdZpnHLRWfYssJ
         v/Da1aHbJRfadOUxA3iGRfYkVpDvRAr1VMtlbPbQQI5sH3KhMTM/iiDjaURG7YQZ6eRW
         d8eMenyChU+ZIBieTN7DgxFKM5mJXHGDFSYOLZgtUx+CiL4ku3UN9Rft9IaAGivgyqLS
         7mlDV14CXqo5FyEj4NlEAu21l/9xcL8Wt4yzsZiEzYiwVpOcfj4xjIbpY+a79zE3dHt4
         M02c1AJMck0rv/7e59LA4jgEb08PFE6+4dJ4O9lzURT7yMO2DqBowjXmoHP+9lGoRYSB
         gWlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714500563; x=1715105363;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WMNTCdm5svpxXWjpVt60+t7ZBqUkllAdM5ompQ7ypY8=;
        b=Pe8+X/H4SUZRs9jgieG6mTgA5XGx5JGMdYNjFj92Eb5/01xCK076XVP/btDG48uGfp
         xBV90ccgoKGPnwlUQg/rTFtzgr0Qpl+gWth3fZ/FMLGBxhef5HzQfJ46UIgCtNv0FDL0
         ++2EDW4lmADeL5XdbzR3HXBytNEDwISEKcpwar5pmlhO7yHm5YqSdqSHY9jr0VWM/Oqa
         deV4m02ZYDyTqSPOflcbOrz9SJ7y+TGWJRj096CxQfZK8ZA187201DKS8XzPiyINpf9O
         4HCHRWQg7OlqMqEFYsnTNtgRHzwWtBovGc4hrbmQM0geCiVj8onJ3P1gVQplQhFZlZR1
         Qt8Q==
X-Forwarded-Encrypted: i=1; AJvYcCXiviLCT1b7zjA3JYf0xxXic6zd3v2fKm+EOH9GxWEPIjJ+/XUqIZlYZU8doW8P3U8nvmNStUrZ3eZvt/2X39FtVJs4MYTIVldbtkhZ
X-Gm-Message-State: AOJu0Yz775FE8Nv5TKH9/nbpRWUKuoNSl+w8mQOkLuYAqFSNuhQNqM+1
	djQVYx+uyM3T95yrx7Mgy2sCVaYz2GV4LK/NPiPTSNNUXDdOEvA4CW5Apt2w0WdRvOdQ5Rez/5D
	cFy17kPe3hO8pkIKHLo6J3BWnzRrqZHoT4M60
X-Google-Smtp-Source: AGHT+IFYPUdRIGoJo2FyON4O7qgOmZLSFxrIYUi3aafzci4nIsE7insXex/Szzw+Amr7vCbEJYbG8jzOOcIngN/ttDs=
X-Received: by 2002:a25:97c3:0:b0:de0:e7f2:a03d with SMTP id
 j3-20020a2597c3000000b00de0e7f2a03dmr359262ybo.3.1714500562637; Tue, 30 Apr
 2024 11:09:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240430060612.2171650-1-shakeel.butt@linux.dev> <20240430060612.2171650-9-shakeel.butt@linux.dev>
In-Reply-To: <20240430060612.2171650-9-shakeel.butt@linux.dev>
From: "T.J. Mercier" <tjmercier@google.com>
Date: Tue, 30 Apr 2024 11:09:11 -0700
Message-ID: <CABdmKX0eC7YFbcfjW+1VtPVRfhExxZHiyQ0Dv-oPiPD3HcUfFw@mail.gmail.com>
Subject: Re: [PATCH v3 8/8] memcg: use proper type for mod_memcg_state
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	Michal Hocko <mhocko@kernel.org>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Muchun Song <muchun.song@linux.dev>, Yosry Ahmed <yosryahmed@google.com>, kernel-team@meta.com, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 29, 2024 at 11:06=E2=80=AFPM Shakeel Butt <shakeel.butt@linux.d=
ev> wrote:
>
> The memcg stats update functions can take arbitrary integer but the
> only input which make sense is enum memcg_stat_item and we don't
> want these functions to be called with arbitrary integer, so replace
> the parameter type with enum memcg_stat_item and compiler will be able
> to warn if memcg stat update functions are called with incorrect index
> value.
>
> Signed-off-by: Shakeel Butt <shakeel.butt@linux.dev>

Reviewed-by: T.J. Mercier <tjmercier@google.com>

