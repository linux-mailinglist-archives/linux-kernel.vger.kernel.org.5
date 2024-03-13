Return-Path: <linux-kernel+bounces-101078-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 23BCF87A1F4
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 04:36:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 412E51C21BA3
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 03:36:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9917E10799;
	Wed, 13 Mar 2024 03:36:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hO5jbohR"
Received: from mail-oa1-f41.google.com (mail-oa1-f41.google.com [209.85.160.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78CB8DDCD
	for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2024 03:36:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710300984; cv=none; b=REdN309kU/uwEGBv1nMLH8BAismt76fkqRdOE5HKyqNSxHyz3YmFVgTilIpBjJzX6oCUe+pyH3VYWyhVFX5VU1zl6QUb3H4a7HzNBLhq/sB8XFYibmuhyxw4HFIwLqnWnxqz/ZH9gkS6ByMda5rhSc0KjdANRU2ugx3S5TOXtNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710300984; c=relaxed/simple;
	bh=q75T6CjXdZiLfdbqwBfbdpNeDTcQxDLhgC+M7u0WSvQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Lb/PpwcchitezHbLIiLM4V5GnwF9WpIqs5RrR1hPDOTTP3LVIYfXJWdbKBxidINs30OMJc0XhAfx4QuGPhjLWRQq0YvMTWIkdvStQ91sbTEtRxWvoRqDhtrShPIhzsPNaNATsx/xr3K01jY6DJ9s66dcBCZHmQ/IlbJDjgzJGcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hO5jbohR; arc=none smtp.client-ip=209.85.160.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-2218b571776so3482217fac.0
        for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2024 20:36:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710300982; x=1710905782; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cswU/qzK+hSgY5yYtg2wRRadWrJVp3EWT5DhBoH1TBI=;
        b=hO5jbohRI+q8nG5Gxh2ji1DQLE7nfkuA8R+MK+ejxQx4L4zAeITCXi/2aCgQwz43+g
         V6sbuHC/AhTpmCnxrbE0gwRAVuRpx7Pt1JYzI8kCpN4kRA4hwWaKM+wX5K6zDkTdCOBp
         +vhryAhHdWFNZI5NxtksUj29o7qNp0X+3NWaNdGaLcUsCS7Wa03jXtvxjk//ZOp0k8Bi
         jClcgEojWFrNyzSjJBUwrU5q4zhJkc6vL1G+LIZPR3Sum6UFM+wacic5TAskKkVnqhbj
         XwN2LxvpqOofYFl7KkIJVonIbn1Fc1rRVPaLHR+x5m450Vgd/JmoHILx9oFm1E+lO502
         FCFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710300982; x=1710905782;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cswU/qzK+hSgY5yYtg2wRRadWrJVp3EWT5DhBoH1TBI=;
        b=Z39l5LG6ytEvzPD6+oDJn4Z4GrYHRV8cXwn23TcYzQxlPxSy5vwccoAu6PFSYPAA+6
         E3uNPLUP7mpZzV1L8126DraSaczhzr73Q/FYA+8OvBmmDx7EJvtmEQf+wK40hoBRB0t2
         gAOiop2WGT2MKXOeFgxnXgAfpHzba9IpiMBXQoasNxFmzp/jvcRfM1/mKdPKbpsc/Ote
         giOWDhIa0hgApbsB+GWEDz68i/D+LCvrn/uunXJU4JYtolhFICVmXDTmee5SRTRUdU0S
         g8KXIQ/xVkdKVL+FvWHn3V7bHv1XHS6qoGdhEb3EoK1tcte07nPAvQo6pt8GKN8hAmdb
         snTQ==
X-Forwarded-Encrypted: i=1; AJvYcCW1yC3Ob5GkECxINai3fMlwxqLLybTqduHLe2HOrhpexf99RrkyjTIV40ZOWt2Glunb7Gn+ptlWXsKYfTVV4jJcs9LXwcMJgqu7jKLN
X-Gm-Message-State: AOJu0YwFHGgdfYRh4Y+hF19aEIpXXBe45M2TFiWjAFOgZaw0e9xe+Mir
	vatFiih9sVnS2e/H7aPYQXLH6khaPBdqk16tvMAj17YAXBV4vpJOvKsbKu827XCpQb4YRbyreXb
	/30jBrUrt+4LqZAzTEehx2rteAYdix4TUyTdn3A==
X-Google-Smtp-Source: AGHT+IEiz8JrhcT1awRkr6hThHjTbPBBmqpl9NAEk5CydQz8kt+uB7vCUg8DozjejPzWs9wcvS8Ezq756933QIMWDeU=
X-Received: by 2002:a05:6870:fb88:b0:220:87b2:c13a with SMTP id
 kv8-20020a056870fb8800b0022087b2c13amr12423713oab.26.1710300982471; Tue, 12
 Mar 2024 20:36:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ZfCM2RyeEpxooKz+@MOLeToid> <ZfC6JeVBa9weWBSU@aschofie-mobl2>
In-Reply-To: <ZfC6JeVBa9weWBSU@aschofie-mobl2>
From: Felix Kimbu <felixkimbu1@gmail.com>
Date: Wed, 13 Mar 2024 04:36:10 +0100
Message-ID: <CAK=vLxJmefBNh9tseipYhQiYY6ZYZzoij3oCBKHy3qaH3+bGiw@mail.gmail.com>
Subject: Re: [PATCH v3] staging: wlan-ng: Rename 'foo' to 'rc' in p80211conv.c
To: Alison Schofield <alison.schofield@intel.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-staging@lists.linux.dev, 
	linux-kernel@vger.kernel.org, outreachy@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 12, 2024 at 9:25=E2=80=AFPM Alison Schofield
<alison.schofield@intel.com> wrote:

Greetings Alison,
Thanks for the review. I will work and resubmit the v4 as guided.
Regards

>
> On Tue, Mar 12, 2024 at 06:11:53PM +0100, Felix N. Kimbu wrote:
>
> Hi Felix,
> Thanks for sending this v3 as a new patch. Now, I'm going to ask
> you to create a v4 to straighten out a bit more of the patch
> format.
>
> The commit message below includes some revision history that only
> belongs below the '---',  Your commit message will be with this
> patch when it is committed, and the changelog will fall away.
> The changelog benefits reviewers today, and it also is always
> retrievable in Lore for folks curious about the patches journey.
>
> So, I'll make some edits directly below indicating what I think
> v4 should look like.
>
> Caveat 1: I didn't test the patch. I expect it applies, compiles,
> and passes checkpatch.  Double check that all on v4.
>
> Caveat 2: I don't know if GregKH is going to accept this trivial
> patch. That's OK.  By the time we get though v4 you will have
> applied a bunch of patching practices that you can take forward
> to your next patches.
>
> > Rename identifer 'foo' to 'rc' Suggested-by Alison Schofield in functio=
ns
> > skb_p80211_to_ether() and skb_ether_to_p80211().
> >
>
> Replace above with:
> Rename identifier 'foo' to 'rc' in skb_p80211_to_ether() and
> skb_ether_to_p80211() to match the common kernel coding style.
>
> (Try to get the spell checker running with checkpatch to catch things
> like the misspelled 'identifer' above.)
>
>
> Delete from here:
> > Fix indentation necessitated by above rename Suggested-by Dan Carpenter
> > and Philipp Hortmann.
> >
> > This change adds intuitive meaning to the idenfier, adhering to best
> > practices and coding style.
> >
> to here.
>
> >
> > Signed-off-by: Felix N. Kimbu <felixkimbu1@gmail.com>
> > ---
>
> (The names in parens is optional. Folks often do it to make
> it easier for reviewers to find what they last commented, and
> also it is a bit of a nod, appreciating your reviewers)
>
> Changes in v4:
> - Remove changelog comments from commit log (AlisonS)
>
> Changes in v3:
> - Create a proper new patch revision (AlisonS)
> - Use 'rc' instead of 'decrypt_check' (AlisonS)
>
> Changes in v2:
> - Fix wrong indentation introduced in v1 (DanC)
> - Correct subject to include driver (PhilippH)
>
>

