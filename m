Return-Path: <linux-kernel+bounces-72405-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D48A85B2DE
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 07:25:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EB4C41F2150D
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 06:25:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BB4959151;
	Tue, 20 Feb 2024 06:25:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DXlNDAQm"
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AC7A59143
	for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 06:25:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708410321; cv=none; b=Ncczp92t3E/PqY46UxQhjprQgPNivnU17h/c6p8AARhdFywitoU/k5WQxjVgIFCJaCO4rJs2MyGqfoLE2PgHajt6YIUaUJwTwF6vgN2O1WfilDUt5lZ5wCnXBdzp57QUkp9DFn30IxsVy/oqSTZz8j75dsLGJVlXtPbo/29fGxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708410321; c=relaxed/simple;
	bh=Vorv3Mu3J3BFVwhUlwwIWwNS7Cr2J+Xn1H2HkqA4Kew=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=A9vJR1a7FWtJe9irk7s8l4z5rMH7tx/w+AVkq1jhylXXMfoEbTEhp4m/nkgUp7m645qYtPWa1rbFEaw3iFXK88vBcKVPenaoY5Sfe6fGIkhtf2N8q3WEfyfWbPRMii2Wl2jLJjj26HqjbD4KI+ZliDK8GhBOLJpWyxerIskNA3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DXlNDAQm; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-512b29f82d1so2591100e87.1
        for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 22:25:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708410318; x=1709015118; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SUm5uLuiWHsztob0PnCfvKEIfDnDYyNF8vZfs3mZMuU=;
        b=DXlNDAQm7BDJzjve/RYp9weJGutQf4WHCagNgNm+pz15hVaRrRnM1fX0xFdpCJ3nVc
         +YdWH0YAVopbizsaAWkXlvJlAUIlbPogny2ZeJsrX1jz318loc0BhcGXUZCTZorSwo2J
         cbOCUoBnU37BwWkp+DmXMvCR4UPCq3QeOQTpn3PlhuXU25t7I0aUQEDDSu9nLYd6+HKt
         Wd51ZXpnW0OSy+3H6oaQ3zEUY0FTJphdHST3src2p97pkaUXFPVIUFW9J0x4j91LaSco
         oR3Z9kTk/Fw98uZC4VNqBmRvfE0aHHuJgI7jB4aP0TxzPJP4Q2ebvOxJOYT01fDLOhTu
         mZKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708410318; x=1709015118;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SUm5uLuiWHsztob0PnCfvKEIfDnDYyNF8vZfs3mZMuU=;
        b=VnlYGDT4KTU1kDPUDUFJmnJ+Uyi3D1GFeiJCgiSw32oncCtaSaN0imSyutgYYNA0nm
         hOM8oC2XXSYlQSLq3mAXlF5bPt9lizFl/tnqcpopc7IhHaR/mHPPNOhEMUO0CzhAe3dd
         mbS85uN0WJSN/3ph77eTRx/VlgtUVTK5BGN8aFJnS/YrIENPIOJ3xJ5gWo/UjEAve2rV
         lhTmnFbI9xFsSnl5rl5bNIMPeDYlfkYh6EZKgoLddP7YruoYXA7iUwOz/u/EsGTeTGU1
         wj/aWSe1KyYsmdHxVtd+jqJk2PEZuFpylXRkRJd3kJjvCzGBZg+AfQs4UDI3ulbcNcZq
         tLFg==
X-Forwarded-Encrypted: i=1; AJvYcCVFTiZ77pc7EQb5RwsBu/7DLDoa9FT9sL8rXL5p+gs6vprZ3Och/7dqppVB+N2H/0/bP4jUTMZ5jum7xcm+MpnVLE60hyXFKczzfVR0
X-Gm-Message-State: AOJu0YwwYYrgfD4u0B3ZIPT8iL0G0aGTBKIKYdzxwS6h7NnYsaACzbPQ
	Et4F6X+sNjcOpbzq1fTZbyuaPC3ljin5idMuxusF+KTFBJk0MLXB3uz9b1qeO+UMsIwqYCbD4Dg
	xpDSokfSHnkQDOw3plzXCbgedNQ==
X-Google-Smtp-Source: AGHT+IEGEjiRa6cGY39cJoh7Inpw4N/t1GFccwnmoUg3ZxjePzAvi5dJkKsrIUxP/whNEF8LmNdhpx1eVikpej1Fndc=
X-Received: by 2002:a05:6512:4cd:b0:512:c802:7a9 with SMTP id
 w13-20020a05651204cd00b00512c80207a9mr354252lfq.38.1708410317935; Mon, 19 Feb
 2024 22:25:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240219031911.10372-1-fangzheng.zhang@unisoc.com> <5cb54690-b357-4e7b-ac6f-23fc8dfe575a@bytedance.com>
In-Reply-To: <5cb54690-b357-4e7b-ac6f-23fc8dfe575a@bytedance.com>
From: zhang fangzheng <fangzheng.zhang1003@gmail.com>
Date: Tue, 20 Feb 2024 14:25:06 +0800
Message-ID: <CA+kNDJKCbd8ygfsZYELKHjCa0BNUSvMM40zWCnkPo7Hrg=HBhQ@mail.gmail.com>
Subject: Re: [PATCH V2 0/2] Introduce slabinfo version 2.2
To: Chengming Zhou <zhouchengming@bytedance.com>
Cc: Fangzheng Zhang <fangzheng.zhang@unisoc.com>, Christoph Lameter <cl@linux.com>, 
	Pekka Enberg <penberg@kernel.org>, David Rientjes <rientjes@google.com>, 
	Joonsoo Kim <iamjoonsoo.kim@lge.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Vlastimil Babka <vbabka@suse.cz>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Hyeonggon Yoo <42.hyeyoo@gmail.com>, Greg KH <gregkh@linuxfoundation.org>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, tkjos@google.com, 
	Yuming Han <yuming.han@unisoc.com>, Chunyan Zhang <zhang.lyra@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 19, 2024 at 7:29=E2=80=AFPM Chengming Zhou
<zhouchengming@bytedance.com> wrote:
>
> On 2024/2/19 11:19, Fangzheng Zhang wrote:
> > Hi all,
> >
> > This series introduces slabinfo version 2.2 to users.
> > In slabinfo V2.2, we added a slabreclaim column to
> > record whether each slab pool is of reclaim type.
> > This will be more conducive for users to obtain
> > the type of each slabdata more intuitively than through
> > the interface /sys/kernel/slab/$cache/reclaim_account.
>
> I want to recommend a better tool: drgn[1] for these tasks, instead of ch=
anging
> the output format of /proc/slabinfo, which may break existing userspace t=
ools.
>
> [1] https://drgn.readthedocs.io/en/latest/index.html#
>

Thank you very much for providing a new way.
I have the following three questions about the new tool you provided:
---- 1. From the introduction, the tool is described as an alternative
to the crash utility.
          Will the permission requirements have different effects when
used, user or userdebug?
----  2. The 'Helpers' chapter introduces the simple use of
common.memory, but there is no output example.
           It involves the use of slab objects, but it also needs to
provide a specific slab_cache_name,
           which cannot give an intuitive overall information like
proc/slabinfo.
           I guess it is difficult to achieve direct output of slab
type (reclaim or unreclaim). I don=E2=80=99t know, right?
---- 3. Regarding the supported versions, is it supported for both
arm/arm64? I don't seem to have seen any similar instructions.
Finally, I would like to express my gratitude again. This tool will be
very helpful for me in other future work.

> > And we have added an example of the output result
> > executing '> cat proc/slabinfo' in the file
> > Documentation/filesystems/proc.rst.
> >
> > Changes in v2:
> > - Modify the slabinfo version number to 2.2.
> > - Add an example of slabinfo output and future works.
> >
> > Changes in v1:
> > - Add a slabreclaim column to record type of each slab
> >   in file proc/slabinfo.
> >
> > [1] https://lore.kernel.org/linux-mm/20240131094442.28834-1-fangzheng.z=
hang@unisoc.com/
> >
> > Fangzheng Zhang (2):
> >   mm/slab: Add slabreclaim flag to slabinfo
> >   Documentation: filesystems: introduce proc/slabinfo to users
> >
> >  Documentation/filesystems/proc.rst | 33 ++++++++++++++++++++++++++++++
> >  mm/slab_common.c                   |  9 ++++----
> >  2 files changed, 38 insertions(+), 4 deletions(-)
> >

