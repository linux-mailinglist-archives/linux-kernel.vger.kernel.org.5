Return-Path: <linux-kernel+bounces-139357-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B64988A01D3
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 23:14:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3895FB26AD0
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 21:14:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DAAC1836DB;
	Wed, 10 Apr 2024 21:14:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pig9wYm+"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ED4215920B;
	Wed, 10 Apr 2024 21:14:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712783644; cv=none; b=EkKJlJoUojQ4TC86MRz3+MPnL0NZR/yGTnrWhTR/5rHr1Iqk/jVOZJ9dGMXXKu56pozanLWa0lRqDcV1N7kD/inTAKo+txaXKHl3hkzYqPI2RIik31t6BE4DlV5VJJyxHJXcbbDciVCYhmkVbmxJ4fRMbHV8C1pYe9Ao3BBBsqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712783644; c=relaxed/simple;
	bh=bLJPnax4qL6EbvyLVR0K3hnjSf/4Yjk4/FnnmMrKwEs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Pf7a/A5hMLAXVJ1DxZdwHU9XBPs8LaelJriTSSZkGOC3PiagVoh0N3GR9MNHXKG2J45HWo0bwRx/ng4miZ+C9SIfVyt+iV+zq8B9AltvE5QKOXE/WJ0caxWUqE3ct0UWjGMYzsWfoc9nlEg5rQoClxL4XAYaMfqeuJupexQPopk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pig9wYm+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A801C433C7;
	Wed, 10 Apr 2024 21:14:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712783644;
	bh=bLJPnax4qL6EbvyLVR0K3hnjSf/4Yjk4/FnnmMrKwEs=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=pig9wYm+6/nFCM0N14POyu3w+eVGvR/kNKOEK1mBQ+qYbbaJSqHXlfGrZFYJDD8+/
	 qSV0tJtC2OOo36nEzvt9cY8KDyKJZhYMMtAbwUiu0MDXeqg8Avom7CEscH5M4MapKY
	 fCDR2zsGTFdE7uXwtEuTak6oev6nuaIikGK2JUJxcQZWrfRNXOzkcOH/tg0ggULhLZ
	 mulV2MzaA1Kjcns2XElneHvjQYST6Z5+dFVTZhx7RHgFL6CWXXD2g/88L/7cHl5DTe
	 a0VGL5OQYVVjN1Q3+Vg/fRiYoRFvaVQC0NoGtpsGgQJjXUz0KckjhzHElkzrYj3jnz
	 JGz5yHxLUbyjQ==
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-5176f217b7bso1842607e87.0;
        Wed, 10 Apr 2024 14:14:04 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVoD96sgvL1rMxM/DLJ4WSnrYp0NLag7qpVP178GoTVaBHaMp7ylsJMejC2pcXq0ADKjDBJ6yJ69urX2g0GHRUzLCQ4fzXAv9P0SVh4l8kdKpmT/vARWq3seNO4/eN46bDROj+wJK/oVQ==
X-Gm-Message-State: AOJu0Yyoa+HMfu3q8AvVMJDbEhDUEO2qsQtS+Fr2DriyDrlBpFCmOiqU
	+DJS7e2GEIe2KtqNCHJCRu40LlP5t+0Nk4CxRtukk78Vx+px28mvD4f+Qyktc1Wdw1DvyJqQum3
	gRpIRdzPQoW3lhsmmUYG/b9sz1O4=
X-Google-Smtp-Source: AGHT+IGQ8UnZ1N24T93Fb8D3wqhBLRCD4YCcA2YU2mbK8WQ31xFkn3XImZg92X+IhDhLlPbP58MNmt5aQzB0QQ4s2yk=
X-Received: by 2002:ac2:554c:0:b0:516:c44a:657d with SMTP id
 l12-20020ac2554c000000b00516c44a657dmr2939280lfk.64.1712783642352; Wed, 10
 Apr 2024 14:14:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <a022f547c43e40e2b9f0aebb2bd0bfa8@kioxia.com>
In-Reply-To: <a022f547c43e40e2b9f0aebb2bd0bfa8@kioxia.com>
From: Song Liu <song@kernel.org>
Date: Wed, 10 Apr 2024 14:13:50 -0700
X-Gmail-Original-Message-ID: <CAPhsuW6iDjPp2B-NEqMEjb9v40US9eN88CuOc+882h6+BRCAQw@mail.gmail.com>
Message-ID: <CAPhsuW6iDjPp2B-NEqMEjb9v40US9eN88CuOc+882h6+BRCAQw@mail.gmail.com>
Subject: Re: [PATCH 00/11] md: avoid counter operation conflicts
To: tada keisuke <keisuke1.tada@kioxia.com>
Cc: "yukuai3@huawei.com" <yukuai3@huawei.com>, 
	"linux-raid@vger.kernel.org" <linux-raid@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thanks for the patchset!

On Tue, Mar 26, 2024 at 3:29=E2=80=AFAM tada keisuke <keisuke1.tada@kioxia.=
com> wrote:
>
> Currently, active_aligned_reads and nr_pending used as counters are atomi=
c types.
> Therefore, when inc/dec in a multi-core results in conflicts.
>
> To solve this problem, use "percpu_ref" counters that can avoid conflicts=
 and maintain consistency.
>
> Switch modes of percpu_ref to achieve both consistency and conflict avoid=
ance.
> During normal operations such as inc/dec, it operates as percpu mode.
> When consistency is required, it operates as atomic mode.
> The operations that require consistency are as follows:
> =E3=83=BBZero check for the counter
> =E3=83=BBAll operations in RAID 1/10

IIUC, the patchset is to resolve race conditions and thus improve performan=
ce.
If this is the case, could you please include some performance numbers in t=
he
next version?

Thanks,
Song

