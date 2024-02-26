Return-Path: <linux-kernel+bounces-82165-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D5A9868019
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 19:53:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 214AF1F27405
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 18:53:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D325812F586;
	Mon, 26 Feb 2024 18:53:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KnWEXuCu"
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6B0312C815
	for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 18:53:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708973606; cv=none; b=XiC1jxcxIQE5/JK/CfApO3sMTdop7XswGfI8j+hdcdJieyON3CJF86MMbwC4eVQ+wnyLGG5BhAe8CrHWahLJm4QyB72kHZvEpWZm+3u3z9ILKgDGyCFRZjW3/RFvKs7q0wj7eQ3u/nHTbLMOZguR0BEPdHhu0G1IsPT6QT4pEM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708973606; c=relaxed/simple;
	bh=peVYCFuW3WQC4d3FfYW1RoRwip0m9I6iyEpEVIqn3Qc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QoV0CWwAoOXOgR6ifpinYYGCzUj7NanYBXLFFKhKNA5oqaoFGui5rGcySE64+tmIwNwu9vYOi0Rxq9jh85lE22M/77GR1fZw1PObZlBpQMwgH0KW+arq20MY8xw8fq9XnQzXycdaM/qvdI339x96FEG3MMdplcWobicDrnIY4cU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KnWEXuCu; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-6e45d0c9676so2021696b3a.0
        for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 10:53:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708973604; x=1709578404; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ROBsrDmwFPfTNY+bEzwaSiQTfPlyL//FcTkKwnSMOcg=;
        b=KnWEXuCuWjm20vprBs2L/i6bFvNQb6Z13NEGK24Fuv7WvbpzG/KUPzKl+602GiahC+
         0gQlIXKq1icrrlwlAN+bZz0yKSqz7KlMm0mulwxbaPwgLxnlsZYLdWZgqaLTFRKvbsQp
         44zUeh4f7zbbM3HdFIy/jQ6DehuwoRNm2x1BrRQrSjjE9WXrWo3q6wpAL05WwXoOdcN/
         TiJlWQ6RlimciLAk3KPjEUrqg68IujOu6cErB9CaFjMBWTM6iaf10ADwlYGmQx6kR3ET
         FEO6h/qBdNKcDP9yxLfeI+TAKg6Gto/kg47sKmoZbIyb55YW7PMKjNkNfG58qP+0T79A
         jwXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708973604; x=1709578404;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ROBsrDmwFPfTNY+bEzwaSiQTfPlyL//FcTkKwnSMOcg=;
        b=nx17CE4FWERXa7o4YRNtXJ4NsSwy3v5SUq7Tc2gGuExTbZNXaOjfYffBWps+qRsFr6
         ouIeyyl90UHHTbBQ1wrFz+5IAe1IeovOxzJPeKypUK3x54AQvbPgmT4fzw5DVMOmUAeC
         /0zy0nI2ydzMHyJ1n8QLjthyvK9QfI3qhyWT0lnVD3sk/jOkf9HkyUY58yEhp46eheg9
         8rP/DVCgChAD0ysLV2/kTQJmLbK5i6SL3X+mTJ31al6kyiT76watW1OS1B9NBxbvLkay
         qL8Bx760/2g8VaOqM9J5Oa2KQTg0zdX44CLmOh8Kgs81T8t4QtC2MFg9bIwZiapoHmb+
         y+ZQ==
X-Forwarded-Encrypted: i=1; AJvYcCXP+g0OgAZ31pWEYsiIWa/eBDftMrFkTIB3rButv0PxnVV2lnraHc9p4BZd5UpomR6+gkjLUtRC0V2yWutCawfd0c1XKpdZr1EHbII+
X-Gm-Message-State: AOJu0YwwCiyoQUDmWngYFq2aeU7lfGbuwt4hsKXZAT1LseT/6zcBZFoq
	FaFU8H1UvZYI9kTcP32POmzV4tlFUQ4+JyJ3M0dxeSVMPkGdcpdj
X-Google-Smtp-Source: AGHT+IGkCosC3uBICvXqd6E+opa2rPE3Zp9IIQnUYzLp+mJWp/uwzWtSsegLebvNKq+Ee0kjjIBJdg==
X-Received: by 2002:a05:6a20:9d90:b0:1a0:8897:85f1 with SMTP id mu16-20020a056a209d9000b001a0889785f1mr17492pzb.6.1708973603996;
        Mon, 26 Feb 2024 10:53:23 -0800 (PST)
Received: from localhost ([2620:10d:c090:400::4:31e4])
        by smtp.gmail.com with ESMTPSA id f26-20020aa79d9a000000b006e4f0e2cc52sm4361264pfq.168.2024.02.26.10.53.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Feb 2024 10:53:23 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date: Mon, 26 Feb 2024 08:53:22 -1000
From: Tejun Heo <tj@kernel.org>
To: Lai Jiangshan <jiangshanlai@gmail.com>
Cc: torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
	allen.lkml@gmail.com, kernel-team@meta.com,
	Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCHSET v2 wq/6.10] workqueue: Implement disable/enable_work()
Message-ID: <ZdzeIvXkRidgyHol@slm.duckdns.org>
References: <20240221174333.700197-1-tj@kernel.org>
 <CAJhGHyCJS7Pb_5dwTQtcZ25yOVzxFULJEYT4o3id_3xdj32EYA@mail.gmail.com>
 <ZdcQ1jfOKNTlbB6C@slm.duckdns.org>
 <CAJhGHyAic563hZMLvbQ2X7RsZNmHHEYfh5Lr48cE1LGTUm_K_w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJhGHyAic563hZMLvbQ2X7RsZNmHHEYfh5Lr48cE1LGTUm_K_w@mail.gmail.com>

Hello,

On Sun, Feb 25, 2024 at 06:55:56PM +0800, Lai Jiangshan wrote:
> > While I agree that this can be argued either way, keeping the interface
> > congruent with the existing cancel_work_sync() and friends seems a lot more
> > important to me. It can be a bit more confusing for users who are used to
> > tasklet interface but then again we aren't gonna rename cancel_work_sync()
> > to kill_work() and the conversion overhead isn't all that significant or
> > lasting. However, if we break the consnistency within workqueue API, that's
> > a source of lasting confusion.
> 
> I don't want to object to any names. But I'm still thinking of just providing
> disable_work_nosync() rather than disable work().  It will be used
> at only places at most.

Yeah, I get your point. That's the same for cancel_work_sync(). I'll think
about it some more but I'm not sure either way is clearly better here.

Thanks.

-- 
tejun

