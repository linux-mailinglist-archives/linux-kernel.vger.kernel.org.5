Return-Path: <linux-kernel+bounces-24109-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 40F8682B72B
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 23:36:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 925B6289A6E
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 22:36:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BC3EFC19;
	Thu, 11 Jan 2024 22:36:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="DdCwfz0Q"
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5ACBFBF8
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jan 2024 22:36:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-557bfc7f7b4so8114774a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jan 2024 14:36:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1705012583; x=1705617383; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=cQ1SU/oJ/hqUhOTuKn5aAqtJtdnCvUaprAQhGYdhU7s=;
        b=DdCwfz0QS0shZ7H9tnILvIePlZTh1Rn3iWvVz8JB8O/yrQgsTpM0lYen4z0JL1HPdR
         9NzNVe18VfZwh06pCP13B4JjUdl8Daorv6QTXox0BEVKOi9QFRUwoN7UPn0QZhZNQxMR
         B/2VhrdxWe6eJubE/t1YKEV4IAAFkZLufe0Mw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705012583; x=1705617383;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cQ1SU/oJ/hqUhOTuKn5aAqtJtdnCvUaprAQhGYdhU7s=;
        b=TdEVFmH9zsDxIBslUb1QI78kpYJDkCuoirZNxvBcFdTnIj1OY0+HKLd0oC/GKW3rHH
         xu+bw+Pzgwb5uEXFfKUEp8ePrcVaR5set++V1l1fBW5xot05IQNQQg+cocG7jVnq3PeJ
         DntHcx28LrO7c84P1UqGoJDgjByJDZZL72Ez2zyV8rHJsKD6R6d0Rw72v4a9IwDIichR
         WKMH2SAECLIgL9nxJDAS4uqge2sCzWkxPItXj6h2XIsr3eFGHq8RZ4xgXrjCFqUDmuxZ
         HhscDrEo78i5+ub7kzjIaT5ASwdvxpnT3+Ax1IoLzF1x+i5cnh9iIUZwR6/SnmEFZ5hz
         z+ug==
X-Gm-Message-State: AOJu0YxIEZWSQFhlcuNxLeyglkkEq7/HQaFbmKV76J+4IbpjoZX63B62
	ObPTOVeNKpf9nWJHR/vS/A9vmSf8uwNmeUZgpNdhdvA0TOf59JSj
X-Google-Smtp-Source: AGHT+IFE3zbEH9aCKeVaIFNp1x6h9hp7ABPBcUIRPmfCiYjly7OJqHfljKWw4rUHYvufwX84umFVPA==
X-Received: by 2002:a17:906:4acc:b0:a2a:fbc0:83e4 with SMTP id u12-20020a1709064acc00b00a2afbc083e4mr478051ejt.69.1705012583616;
        Thu, 11 Jan 2024 14:36:23 -0800 (PST)
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com. [209.85.218.43])
        by smtp.gmail.com with ESMTPSA id hx25-20020a170906847900b00a26ac57b951sm1064029ejc.23.2024.01.11.14.36.22
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Jan 2024 14:36:23 -0800 (PST)
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a28f66dc7ffso1253837166b.0
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jan 2024 14:36:22 -0800 (PST)
X-Received: by 2002:a17:906:504e:b0:a2b:2bdb:5a2a with SMTP id
 e14-20020a170906504e00b00a2b2bdb5a2amr549457ejk.49.1705012582592; Thu, 11 Jan
 2024 14:36:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <c5ac3166f35bac3a618b126dabadaddc11c8512d.camel@HansenPartnership.com>
In-Reply-To: <c5ac3166f35bac3a618b126dabadaddc11c8512d.camel@HansenPartnership.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 11 Jan 2024 14:36:05 -0800
X-Gmail-Original-Message-ID: <CAHk-=whKVgb27o3+jhSRzuZdpjWJiAvxeO8faMjHpb-asONE1g@mail.gmail.com>
Message-ID: <CAHk-=whKVgb27o3+jhSRzuZdpjWJiAvxeO8faMjHpb-asONE1g@mail.gmail.com>
Subject: Re: [GIT PULL] first round of SCSI updates for the 6.7+ merge window
To: James Bottomley <James.Bottomley@hansenpartnership.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-scsi <linux-scsi@vger.kernel.org>, 
	linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Wed, 10 Jan 2024 at 12:48, James Bottomley
<James.Bottomley@hansenpartnership.com> wrote:
>
> git://git.kernel.org/pub/scm/linux/kernel/git/jejb/scsi.git scsi-misc

Ok, I note that this has been signed with ECDSA key
E76040DB76CA3D176708F9AAE742C94CEE98AC85, and while it is currently
available and up-to-date at kernel.org, it shows as

  sub   nistp256 2018-01-23 [S] [expires: 2024-01-16]
        E76040DB76CA3D176708F9AAE742C94CEE98AC85

note that expiration date: it's three days in the future.

Can I please ask you for the umpteenth time to STOP DICKING AROUND
WITH SHORT EXPIRATION DATES!

The pgp keyservers work *so* badly these days that refreshing keys is
a joke. The whole expiration date thing has always been a bad joke,
and only makes pgp an even worse UX than it already is (and damn,
that's saying a lot - pgp is some nasty stuff).

When you make a new key, or when you extend the expiration date, do it
properly. Give ita lifetime that is a big fraction of a decade. Or
two.

Because your keys constantly end up being expired, and they are making
the experience of pulling from you a pain - because I actually *check*
the keys.

Stop making a bad pgp experience even worse - for no reason and
absolutely zero upside.

                Linus

