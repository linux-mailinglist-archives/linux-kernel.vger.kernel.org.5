Return-Path: <linux-kernel+bounces-12714-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D146581F93A
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Dec 2023 15:48:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 61244285B89
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Dec 2023 14:48:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABA5DF4EC;
	Thu, 28 Dec 2023 14:48:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="MRrlsR3B"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-vs1-f42.google.com (mail-vs1-f42.google.com [209.85.217.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6935BEAF3
	for <linux-kernel@vger.kernel.org>; Thu, 28 Dec 2023 14:48:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-vs1-f42.google.com with SMTP id ada2fe7eead31-466f1fbb707so555631137.0
        for <linux-kernel@vger.kernel.org>; Thu, 28 Dec 2023 06:48:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1703774925; x=1704379725; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u0zhsoc7zLEWUspquC1xbxifv5WBj4GBVb2SAg7HeYA=;
        b=MRrlsR3BmbeN8YQ5cQ2nrmAmHmde8ezPTJeU6CAdN65Q2UFbNFeb/mZOP7vvnEstl+
         hvxf8tSe5fZVhO+yW3eIva5VUlnweIYfuuzjGgKAvaSdkRIQX7utxJsO0G04xs2aDIdN
         BKgVDIde/A/n+tTU535LXp7QSLtfFdw+mpMZRSHzqmuWZsnAVVqmNbDAUv0oV3S7vhBd
         cLN83eTs/hCowvSlR7Fes5kF7ukUMUL09SgldKuMRc9TBlM7RBu2o4Um24ab4XZGqDoW
         rwXQNlZCcCkxtm/6A/040w2LSzclJFIQje/4rbzF3KVd4sphgt9xh8PqAfRWEtDF7V8u
         Dpww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703774925; x=1704379725;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=u0zhsoc7zLEWUspquC1xbxifv5WBj4GBVb2SAg7HeYA=;
        b=W9/8qJ2rcmzEDJo2Qxs82S/4eyk6PIBsBJrjfbM56e1y3/+Zu1znSxAzs0hE858EbW
         56HjmcjCEUDGF0Wlve3/ELxsaPDqvcr1d7+1F2VXrnkUjph4Gjj/D3VTtYwJoQuQcu6+
         ZZozNnUTdQb4gDd8kZkc3R8fCC9PAqUft67L+gks/wY4se47fi+NC8//5ZLZWslvt/vC
         IyQ+VE4fOjkqk65OOH6VIsXUpaVaSGRQsnGjZhdzxBz0ZJ8kSzzUvGjaKJi+ZPkg6D+i
         gVEbhL+ATWHa4jNsW7zcbVZ/eHwLDnPO3oJKS2blOZuK/Xnb4tmhIxlFOx1Ehq6/egie
         N+mA==
X-Gm-Message-State: AOJu0YwWJRZm7Hf/DicRBxSiUK86Uf8BZIYXHnvmCsOlddVE3z1YvXYp
	Jt7r5cATqZ79yGKexs+xJSoGwhx3B1A5gIxM5B88ojqv6zVv4Q==
X-Google-Smtp-Source: AGHT+IG1OslSF2rqep3xU7q5DR6zY2q2AThUtHZXryNBrOdQOuAmmf/X4lKxUxSAnVnfIy4v9Rc7Im0O+qb15ZaPM3k=
X-Received: by 2002:a05:6102:1514:b0:466:59a3:4461 with SMTP id
 f20-20020a056102151400b0046659a34461mr5074746vsv.32.1703774925370; Thu, 28
 Dec 2023 06:48:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231211154644.4103495-1-pasha.tatashin@soleen.com>
 <3d415ab4-e8c7-7e72-0379-952370612bdd@google.com> <CA+CK2bA2vZp3e+HHfB-sdLsPUYghMxvKcWURktDtNjwPL79Csw@mail.gmail.com>
 <b1049bfa-68c4-e237-30a9-1514a378c7f1@google.com> <CA+CK2bBxbvO-osm5XKk4VkaXYgfZXkDAtfayaYJ-vXo=QFqGPA@mail.gmail.com>
 <13e5fbd4-d84d-faba-47f1-d0024d2c572d@google.com> <20231227104244.824b0977ae6d4bb6b37f6f79@linux-foundation.org>
In-Reply-To: <20231227104244.824b0977ae6d4bb6b37f6f79@linux-foundation.org>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Thu, 28 Dec 2023 09:48:08 -0500
Message-ID: <CA+CK2bAARPNHwZB9tkd6miKr8GWrZ_L6h1oiUM0qWu6pJqh3Wg@mail.gmail.com>
Subject: Re: Sysfs one-value-per-file (was Re: [PATCH] vmstat: don't auto
 expand the sysfs files)
To: Andrew Morton <akpm@linux-foundation.org>
Cc: David Rientjes <rientjes@google.com>, Linus Torvalds <torvalds@linux-foundation.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, rafael@kernel.org, surenb@google.com, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, souravpanda@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 27, 2023 at 1:42=E2=80=AFPM Andrew Morton <akpm@linux-foundatio=
n.org> wrote:
>
> On Tue, 26 Dec 2023 16:53:31 -0800 (PST) David Rientjes <rientjes@google.=
com> wrote:
>
> > But for existing files and conventions, I think we should settle it as
> > "keep doing what you've been doing for 13+ years" and don't force this
> > argument every time a kernel developer wants to just add one more stat.
>
> Absolutely.  Let's do what makes most sense.  For new things, one value
> per file.  For stats which logically group with other existing stats,
> do whatever the existing other stats are currently doing.

The intent of "[PATCH] vmstat: don't auto expand the sysfs files" is
to do exactly this: keep the current fields in
/sys/devices/system/node/node*/vmstat as-is, but prevent future fields
added to node_stat, numa_stat, zone_stat from showing in vmstat.

Potentially, we could also extend checkpatch.pl to warn when
VMSTAT_SHOW_SYSFS is used in the future patches.

Pasha

