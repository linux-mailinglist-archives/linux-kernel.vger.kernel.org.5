Return-Path: <linux-kernel+bounces-101287-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B58E487A51E
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 10:42:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 717BB281C88
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 09:42:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDB75225DE;
	Wed, 13 Mar 2024 09:41:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QMB0PnMI"
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F75A20DDC;
	Wed, 13 Mar 2024 09:41:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710322911; cv=none; b=qK+mS02K0U9RBrWh9XuNb+FzB+aWDKj5bsscKf0eWfdj8JOJ5DPK0yKKuwtl1RS5eFkMvQaU3euUdJLUoK09T1LHgSzZ7PForQWm4p8gWBNT3Eu2zz6L8g7vNQTi+1WgV60AZE+WbkPZYRAvzQur5sk/p5w1LHzjEScMsyfx/xA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710322911; c=relaxed/simple;
	bh=Iy33NOA8FEicl4HdVCTiTZ1Jnm6pT2oK0Zfr+wPVLGU=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LXT10y5Mt5L/0DwVVeehkapqOuV/ztzL9UJPLqZiZsd30MPDfge1Oe3vtkVcVX71UEcWfuXtK3aI8w0smjbkx4djt18fOhN4jvkOYSzlCnQ8a5HxsXUzmeoYIR+sAjkGNY9zKx4nYeIemd74qne3dWXQU/MJcSZT1s+abh/9GaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QMB0PnMI; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4132600824bso5610685e9.2;
        Wed, 13 Mar 2024 02:41:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710322908; x=1710927708; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=nqT6MbYIUXhVn1ev/HIV8qz1Uih12KTCzkmhMV6SWPg=;
        b=QMB0PnMI9GjqYeRiGwma3mODigfSyzjeYEs2N1DLTd2lo81g+HajqZKBxyjTfFC0PB
         BeofCcvF4XAIxlR8gzjcjx9H1nUwd6OJgaO/mDLDcmwwGMBajv0x3ekgR3ITOjGxBNXN
         Q56Cm8WMMw/198y+xCOerip2ANEjRTJLqT6LLj1guTaIrobgTo1HIbVZVeM9TRMby3RZ
         gm18IrPKGqRcgnI9TyNN9CQZ16b/hiTLE9j7w8N5j6xkhcVBaRLrKo9uXXzaVtpybTu5
         ia2jHrB9CoSeScfW0XkGL/Jl5Bw0c0/DbBdArZv7z2DJxUTrq5TLXgAE2/TyFDhQBjnJ
         XnvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710322908; x=1710927708;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nqT6MbYIUXhVn1ev/HIV8qz1Uih12KTCzkmhMV6SWPg=;
        b=WYc2hRoguqpYuoQiZIIjpRlzYRVka4CiZJFmyaXyYI2E2gAiuZs+d416f/l6iUFIxl
         T9eOi33jpLPkUS8HUqBFzVgp8ahw9fiE30Oxxl70cp0aX+iQPl9OxhIWbk5VsMvwbq51
         2UUCx2JlMTRY+kG/UYGOxjOyqJa3c+EtArrdUSBrt0FjG2Zo+qrlGNFBCKED4oT5m/0C
         uF++kkWFcieuHXW/ru6EJWQjXoa7MxN+awBf0JqIx4EI1tQpjtBVlfdxwBFWFc98oNTr
         Qj23EKlbLEUyFKBihNQqki4/GvRURFvZ6muTQsgMV9BrR1dcvjaOt0WHuyVFS4YsnY5m
         AobQ==
X-Forwarded-Encrypted: i=1; AJvYcCX88x706dcV3KqpkxhGttEXnJS+F82tlBGs/FzEeoUZqb+7qIGAb+WBX7khamnSWnmlw5GFoZYXO0WnwzLIG0PE8KtunfGYEwwCCqQz3BToXO1Xcj5os8DXaClgHIsyq1XB
X-Gm-Message-State: AOJu0YyxYfe7tKa5sZCpQld6B2NT9TDMHy3P5B1b0jghBDwCrT3qwQCm
	BjHQ1WAvZ/swgLML+5zlx2kyL6jdoFiC3krXzol9bO9Z1+5OpNUz
X-Google-Smtp-Source: AGHT+IG6Xo+xOpnJ7nktDyubCJL/FGt5e8kZ78wAlCMWt+JfD8mn5qZsmzaKSG5u1Tv3FzElNjGzqQ==
X-Received: by 2002:a05:600c:538c:b0:413:e994:16dd with SMTP id hg12-20020a05600c538c00b00413e99416ddmr974339wmb.28.1710322907592;
        Wed, 13 Mar 2024 02:41:47 -0700 (PDT)
Received: from krava (2001-1ae9-1c2-4c00-726e-c10f-8833-ff22.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:726e:c10f:8833:ff22])
        by smtp.gmail.com with ESMTPSA id h4-20020a05600c350400b00413177c3f1dsm1728584wmq.18.2024.03.13.02.41.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Mar 2024 02:41:46 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Wed, 13 Mar 2024 10:41:44 +0100
To: Andrii Nakryiko <andrii@kernel.org>
Cc: linux-trace-kernel@vger.kernel.org, rostedt@goodmis.org,
	mhiramat@kernel.org, bpf@vger.kernel.org,
	mathieu.desnoyers@efficios.com, linux-kernel@vger.kernel.org,
	oleg@redhat.com
Subject: Re: [PATCH bpf-next 0/3] uprobes: two common case speed ups
Message-ID: <ZfF02HCzYLcuwmw9@krava>
References: <20240312210233.1941599-1-andrii@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240312210233.1941599-1-andrii@kernel.org>

On Tue, Mar 12, 2024 at 02:02:30PM -0700, Andrii Nakryiko wrote:
> This patch set implements two speed ups for uprobe/uretprobe runtime execution
> path for some common scenarios: BPF-only uprobes (patches #1 and #2) and
> system-wide (non-PID-specific) uprobes (patch #3). Please see individual
> patches for details.
> 
> Given I haven't worked with uprobe code before, I'm unfamiliar with
> conventions in this subsystem, including which kernel tree patches should be
> sent to. For now I based all the changes on top of bpf-next/master, which is
> where I tested and benchmarked everything anyways. Please advise what should
> I use as a base for subsequent revision. Thanks.
> 
> Andrii Nakryiko (3):
>   uprobes: encapsulate preparation of uprobe args buffer
>   uprobes: prepare uprobe args buffer lazily
>   uprobes: add speculative lockless system-wide uprobe filter check

nice cleanup and speed up, lgtm

Reviewed-by: Jiri Olsa <jolsa@kernel.org>

jirka

> 
>  kernel/trace/trace_uprobe.c | 103 ++++++++++++++++++++++--------------
>  1 file changed, 63 insertions(+), 40 deletions(-)
> 
> -- 
> 2.43.0
> 
> 

