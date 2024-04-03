Return-Path: <linux-kernel+bounces-129062-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D13D1896432
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 07:41:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5EDA5285554
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 05:41:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E18F64EB5F;
	Wed,  3 Apr 2024 05:41:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="geUH5JVY"
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 760EF2EB11;
	Wed,  3 Apr 2024 05:41:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712122899; cv=none; b=GRkIJ72nZgK7kmGOKiURZDjCB7BjlqvN0xg38FBa11syaxRXyqcexkunqWxi756jb2K8rNXSxtjb9jo/JEEcnQBV9IATU+d01fCYgK2R9J2xsybUYodbB0s1oqcg9XyAI4bbbVnvf1tj8cgL97y9uZ52UR2OD0uDhkOhg8Wh0ow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712122899; c=relaxed/simple;
	bh=+t545PBypOguN6hjXWN9AkW/8XTtIWVXgoDys9wwB5o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uQY6dbKp9tksbyCzolwNGqyUU9LSYBcgGBiK3dpAe2Z2FNqVUF0RyFgMT6yrtvY4TP6WeZHBqXlqQzq96GZFdny77wjnA3HGRLqvgewLY8Ca9BpMMo1ItcynUJxE9Do1rTAT0iBQsyUEEuW9XXuO+OYdmDmUBgOE4TWXzPIzkiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=geUH5JVY; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-3438d7a05aaso161653f8f.0;
        Tue, 02 Apr 2024 22:41:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712122896; x=1712727696; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jwTy49e6dNHcCmFsMWwFiFthRuOhI2Gcyw/tIENnsdY=;
        b=geUH5JVY7XGs/CdU4PkKIZkm+W6Ecsoo638BxG9NfMLWqXNrH8kOL5rNf2V4rmfkxN
         NC/sLA7ADfsG8O70wM/tiGZjtdwVy9s0o8MZ4vz0duOls0+75nQ1YwQr3DyBBUK/SrsW
         Vq4txiyKSuKRRvi3DT7+LbyY2MlWVMZMQ4NzMn3kS5uE8d9pLw3pAXZ4Xpj5OSHUcVDK
         +eyqLsOLP3hFI60ibRR7SBXyW9VYy+SrPjVxPqLMjZ3EhtzoLETk9dgepNu9ZY8+AIPT
         i9gBGARjO3AeE8bZEb5fPQQ6dBuwiy74EzKuosaRQdrRu+MGP7CKLoKsUPlAAa1n0c2g
         nV9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712122896; x=1712727696;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jwTy49e6dNHcCmFsMWwFiFthRuOhI2Gcyw/tIENnsdY=;
        b=VNJoVUKbnaXFltsE8KtZ5Lv/NDfUbEGImBVrPBwfS74h7uEe0LdUCYxTlyDOkp8/Ue
         aKHbKU5G+Ec0Brt0wbRl28aAlc3BdfkXJeivlN0+yVRest9JlPC3lotnpiZj+9+ZLlec
         rtbFerzfIDujLWqE6LEupkIufMUFl5vYv6+SJBqek+y6CuUee2wfkSPf7h/0ga83IDPj
         0SwvUKUaIMCKxbIOxo024attW0Bayi7fn27vp2/Dhb/h7M/E0hUZ0GHwn9EcaduQWYRH
         aLf0pL1dHbbN1W+UTtCom9DH3iT1yYoYK2A8pSvLoEqQbZKT5BQVSg4jBzdglLgxTqyy
         S9SQ==
X-Forwarded-Encrypted: i=1; AJvYcCUkXTa8UZ+Yb1MJ9fcuZmOZ/08RHx967EozdS8N3NIe9zQChcVav3SL5lt5mKOSpsH1bdmA0kthk1HP4a6eutzocThn3OPgYVp84uWet4bb5n+k5wy8QDgL7z+1pB036DMn9zsPcsWHJks=
X-Gm-Message-State: AOJu0YwftG6EovzTfAe0eWh+A82qoBks1gZIj3+0LE21Gufynfu599UE
	bRcbaVA6pYRxxcQ7EwQ6KSaUteSNqqzcQjFzAfUMRhgZ4Gbk4Kfb6P0xZcIRTEV/9ohx1r/0PtT
	K1HXXZZ/d9irfqaSWWtdB+xGajNI=
X-Google-Smtp-Source: AGHT+IE+WI7YVu7qLj99K1PWwbBfQZV3Bw3Ncz06Hw0+Y5x6S5aUU96tI6utzWMjZs43wbmEUVjiOXGlRtRsWO/sCf0=
X-Received: by 2002:a5d:4007:0:b0:33e:9f3d:6910 with SMTP id
 n7-20020a5d4007000000b0033e9f3d6910mr1278315wrp.31.1712122895363; Tue, 02 Apr
 2024 22:41:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1711680261-5789-1-git-send-email-zhiguo.niu@unisoc.com>
 <890bd06d-2a94-4138-9854-4a7ed74e0e51@acm.org> <CAHJ8P3K9OL6MHNrSrqmf0esbr2h1HJ3mVRmxDNVpf95ZMHQcqg@mail.gmail.com>
 <92e45c93-e2ff-4d34-b70f-7772f0596e68@acm.org> <CAHJ8P3KgU-tFDAgCNc5GcPbUBtDDyFmcfza2HsoD9TJ3h1DS=Q@mail.gmail.com>
 <c56a1d54-6d7d-4105-8109-d6a81bc1adbc@acm.org>
In-Reply-To: <c56a1d54-6d7d-4105-8109-d6a81bc1adbc@acm.org>
From: Zhiguo Niu <niuzhiguo84@gmail.com>
Date: Wed, 3 Apr 2024 13:41:24 +0800
Message-ID: <CAHJ8P3JYXA4VGfgXLMesuuUOUivc1EKwxGce4P5MWDHn1K675Q@mail.gmail.com>
Subject: Re: [PATCH] block/mq-deadline: Fix WARN when set async_depth by sysfs
To: Bart Van Assche <bvanassche@acm.org>
Cc: Zhiguo Niu <zhiguo.niu@unisoc.com>, axboe@kernel.dk, linux-kernel@vger.kernel.org, 
	linux-block@vger.kernel.org, ke.wang@unisoc.com, hongyu.jin@unisoc.com, 
	Damien Le Moal <dlemoal@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 3, 2024 at 7:20=E2=80=AFAM Bart Van Assche <bvanassche@acm.org>=
 wrote:
>
> On 4/1/24 10:44 PM, Zhiguo Niu wrote:
> > On Tue, Apr 2, 2024 at 5:23=E2=80=AFAM Bart Van Assche <bvanassche@acm.=
org> wrote:
> >> Oops, I misread your patch. After having taken another look, my
> >> conclusions are as follows:
> >> * sbitmap_queue_min_shallow_depth() is called. This causes
> >>     sbq->wake_batch to be modified but I don't think that it is a prop=
er
> >>     fix for dd_limit_depth().
> > yes, it will affect sbq->wake_batch,  But judging from the following co=
de:
> > [ ... ]
>
> If we want to allow small values of dd->async_depth, min_shallow_depth
> must be 1. The BFQ I/O scheduler also follows this approach.
>
> >> * dd_limit_depth() still assigns a number in the range 1..nr_requests =
to
> >>     data->shallow_depth while a number in the range 1..(1<<bt->sb.shif=
t)
> >>     should be assigned.
> > yes, In order to avoid the performance regression problem that Harshit
> > Mogalapalli reported, this patch will not directly modify
> > dd->async_depth,
> > but user can modify dd->async_depth from sysfs according to user's
> > request. which will modify data->shallow_depth after user modify it by
> > sysfs.
>
> It seems like there is no other option than keeping the current default
> depth limit for async requests ...
>
> > My personal opinion is to keep the current dd->aync_depth unchanged to
> > avoid causing performance regression,
> > but it should  allow users to set it by sysfs, and the WARN mentioned
> > best to be solved.
> > and just only change this part?
> >   -       sbitmap_queue_min_shallow_depth(&tags->bitmap_tags, dd->async=
_depth);
> >   +       sbitmap_queue_min_shallow_depth(&tags->bitmap_tags, 1);
> > thanks!
>
> The above change will suppress the kernel warning. I think the other
> changes from patch 2/2 are also necessary. Otherwise the unit of
> "async_depth" will depend on sbitmap word shift parameter. I don't think
> that users should have to worry about which shift value has been chosen
> by the sbitmap implementation.
Hi Bart Van Assche,
So will you help do an  official patch version about patch 1 and patch 2?

Besides, I am not sure  that  the following part will cause
performance regression or not?
+static int dd_to_word_depth(struct blk_mq_hw_ctx *hctx, unsigned int
qdepth)
+{
+       struct sbitmap_queue *bt =3D &hctx->sched_tags->bitmap_tags;
+       const unsigned int nrr =3D hctx->queue->nr_requests;
+
+       return max(((qdepth << bt->sb.shift) + nrr - 1) / nrr,
+                  bt->min_shallow_depth);
+}
+
which is somewhat similar to the previous commit d47f9717e5cf
("block/mq-deadline: use correct way to throttling write
requests"). just an example
hw conditions:  8 cpus,emmc flash, one hw queue, and queue_depth=3D64,
sched_tag/nr_request=3D128, init dd->async_depth=3D96
 bt->sb.shift=3D5,
so max(((qdepth << bt->sb.shift) + nrr - 1) / nrr,bt->min_shallow_depth);
will get 24 and commit d47f9717e5cf ("block/mq-deadline: use correct
way to throttling write
requests") also get 24, but your revert commit 256aab46e316 ("Revert
"block/mq-deadline: use
correct way to throttling write requests"") will get 96,
or am I missing something else?
thanks!
>
> Thanks,
>
> Bart.
>

