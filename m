Return-Path: <linux-kernel+bounces-67422-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E3C2A856B49
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 18:40:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7DBB51F23E96
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 17:40:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8219C1384AE;
	Thu, 15 Feb 2024 17:39:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="oCluk6Mu"
Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com [209.85.219.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93B60138490
	for <linux-kernel@vger.kernel.org>; Thu, 15 Feb 2024 17:39:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708018782; cv=none; b=U2xxJzLbVLBH9ooe01XYSPTpwiWYPUYb0yCdYKkRtm1Raq/4pyybBoSg8R7fWzWtLKe54i9t1Mi3osen+oxfGuqowDv9Bn0ZPGa5JpR2+NZ4oBUwVqXYJPGZC/anPQcjrjBgTkU2/d2TIhehx1eixx0oPFon2q+NHEi7/lY5AQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708018782; c=relaxed/simple;
	bh=Ow2KNKuunpi3CFMpu4ctB3YxV++SCuTQIz8FvzYqWsw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iRXZA17fRgNPw3FkfIqJlqpCQ0jQvEbLcRa5pZuS7akkQUuRiJpK7Yf/FGiWOfhJpGJQFh+zNoUZRAO4LD5rU6M5YETGcm0UOvlphPQQdloHoD7frKcrpvY9mBQW28xCtdRBBvANib26leI1DdXDslNMsncAeo60TCDMYVQxgRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=oCluk6Mu; arc=none smtp.client-ip=209.85.219.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-yb1-f173.google.com with SMTP id 3f1490d57ef6-dc25e12cc63so1940225276.0
        for <linux-kernel@vger.kernel.org>; Thu, 15 Feb 2024 09:39:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1708018779; x=1708623579; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KDtOxyQIUrvHRZYbLeRYhzP9Am/nBdCIsn1qRJuLxtI=;
        b=oCluk6MuB1we9gNYwPOGpxeUsfl6PAWTP3M8fzoNoYYZ/A88EcpLAnESS8VpIfZmAf
         9m1tdlqCaI4brfNoR8QK4z5TzeRmcGtK38hghuU1nIMNTCw3yZFPf4Z4P7adB0l0h3xn
         b9BzJPnbQHW8jKmgXT1et/217j+ngKK5Rt+f6dvrQWAJqrCglkymhp12MUrku3VZAGg1
         U4DBvXTBm6F80NWS20w1mJ3wpdtVUszQaw4Goqli/WTFdFJak5xQtlYNkTB6M/Z2dFuG
         TH+qJXQUsOgqoIcAjPODENkHm7JRrG7Iy8XhpzxiPJoxi0s2tNQbNN0QeB365NaqEag3
         BUgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708018779; x=1708623579;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KDtOxyQIUrvHRZYbLeRYhzP9Am/nBdCIsn1qRJuLxtI=;
        b=cswugICIJOe30jybZQOzDdamO9hh3k0kmiPNX17zOSO92NVo+NudDf5UV9pyMC7EWv
         e5neyzCtTShdCLu9ehlEqLSanIFcj9QhYY0ypLSnYOp0f3qHLHP0GchYnN7sbKemgCQv
         /yZcN+NE0nGqyd9Bh653AhvDu+pO00VNKJKBiF30rE+MCDvqxu0+TnW2JbiCvw4VAf2z
         169OVB/Rbuz2zDYnm3yfjxAqgk582bNuXXWYiwuDtK7GXzApfMY8LFDXmnKPe5hMqwFA
         eX38C2FyFeClfSEzF3/f6+Zem7y5t5bxTSIK0vyWId2Nd4vX2vPz9QglbWIF3vUB5l/Y
         OCag==
X-Forwarded-Encrypted: i=1; AJvYcCUqnxnPATE1GRZJPctAPe3Fvft8NNzPiksnKjQWx+h7NhVC/K+evg3MgtvSU6n0NARf9nN9MdGoqtvdwg/zhHI1RZws4Q+Q9Yym7Y32
X-Gm-Message-State: AOJu0YxwjK6Hb7DhJlVn0J03ZT/9RV+oPKEKsLNzVMuCkTVlM10fQyVS
	MRyi3wWi+D88ARrR4H5nZtNF1W3X65oRi/MzS63DBPneLRdRlHJp+4RORBAH/I8YiUhEY1oDRls
	LRNFT2dN5h93hi/8o6yfp0eixi9ro2qAEFtPg
X-Google-Smtp-Source: AGHT+IGwSaM8UUA2DlZQLmgb04t9x61k5G5l90Kp3W/JMy4waio3qsHOqLdGqzAHAHqwmRlx7ZC0mXhEzhGiFCRjBqg=
X-Received: by 2002:a25:c302:0:b0:dc2:201a:7f1a with SMTP id
 t2-20020a25c302000000b00dc2201a7f1amr4066205ybf.30.1708018779496; Thu, 15 Feb
 2024 09:39:39 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240215160458.1727237-1-ast@fiberby.net> <20240215160458.1727237-2-ast@fiberby.net>
In-Reply-To: <20240215160458.1727237-2-ast@fiberby.net>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Thu, 15 Feb 2024 12:39:28 -0500
Message-ID: <CAM0EoMndBjwC8Otx6th_dM_aV_r80NeLEke9C8PwzGt1q3vAMA@mail.gmail.com>
Subject: Re: [PATCH net-next 1/3] net: sched: cls_api: add skip_sw counter
To: =?UTF-8?B?QXNiasO4cm4gU2xvdGggVMO4bm5lc2Vu?= <ast@fiberby.net>
Cc: Cong Wang <xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>, 
	Daniel Borkmann <daniel@iogearbox.net>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	llu@fiberby.dk, Vlad Buslov <vladbu@nvidia.com>, 
	Marcelo Ricardo Leitner <mleitner@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

+Cc Vlad and Marcelo..

On Thu, Feb 15, 2024 at 11:06=E2=80=AFAM Asbj=C3=B8rn Sloth T=C3=B8nnesen <=
ast@fiberby.net> wrote:
>
> Maintain a count of skip_sw filters.
>
> This counter is protected by the cb_lock, and is updated
> at the same time as offloadcnt.
>
> Signed-off-by: Asbj=C3=B8rn Sloth T=C3=B8nnesen <ast@fiberby.net>
> ---
>  include/net/sch_generic.h | 1 +
>  net/sched/cls_api.c       | 4 ++++
>  2 files changed, 5 insertions(+)
>
> diff --git a/include/net/sch_generic.h b/include/net/sch_generic.h
> index 934fdb977551..46a63d1818a0 100644
> --- a/include/net/sch_generic.h
> +++ b/include/net/sch_generic.h
> @@ -476,6 +476,7 @@ struct tcf_block {
>         struct flow_block flow_block;
>         struct list_head owner_list;
>         bool keep_dst;
> +       atomic_t skipswcnt; /* Number of skip_sw filters */
>         atomic_t offloadcnt; /* Number of oddloaded filters */

For your use case is skipswcnt ever going to be any different than offloadc=
nt?

cheers,
jamal

>         unsigned int nooffloaddevcnt; /* Number of devs unable to do offl=
oad */
>         unsigned int lockeddevcnt; /* Number of devs that require rtnl lo=
ck. */
> diff --git a/net/sched/cls_api.c b/net/sched/cls_api.c
> index ca5676b2668e..397c3d29659c 100644
> --- a/net/sched/cls_api.c
> +++ b/net/sched/cls_api.c
> @@ -3483,6 +3483,8 @@ static void tcf_block_offload_inc(struct tcf_block =
*block, u32 *flags)
>         if (*flags & TCA_CLS_FLAGS_IN_HW)
>                 return;
>         *flags |=3D TCA_CLS_FLAGS_IN_HW;
> +       if (tc_skip_sw(*flags))
> +               atomic_inc(&block->skipswcnt);
>         atomic_inc(&block->offloadcnt);
>  }
>
> @@ -3491,6 +3493,8 @@ static void tcf_block_offload_dec(struct tcf_block =
*block, u32 *flags)
>         if (!(*flags & TCA_CLS_FLAGS_IN_HW))
>                 return;
>         *flags &=3D ~TCA_CLS_FLAGS_IN_HW;
> +       if (tc_skip_sw(*flags))
> +               atomic_dec(&block->skipswcnt);
>         atomic_dec(&block->offloadcnt);
>  }
>
> --
> 2.43.0
>

