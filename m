Return-Path: <linux-kernel+bounces-45087-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE4E3842B8E
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 19:18:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E03C91C243F5
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 18:18:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A854156968;
	Tue, 30 Jan 2024 18:18:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mcfwcfYS"
Received: from mail-il1-f172.google.com (mail-il1-f172.google.com [209.85.166.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6879A155A33
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 18:18:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706638710; cv=none; b=X75CcfwWhy/Tim3MBLeQA12UpiEvA0SnxaVaXBvA/f4YAxS8DcSVoG3l1WoNcziTp32jDI//jvjx4qijtPkbHUadDnRjvUpucODCwbRTZ3kDPDR0v9pzbUWVVNfZ+YmdY7e9gNMnjHTBjgh0Tv6Qdfq880ZHeHoDk2+dlmQCOp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706638710; c=relaxed/simple;
	bh=QYGx6IS6TCHytMnFpf5YwmAm01y1uABT6/tqdkSyT5c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=u75XDpj6OADC/z4ZVmNxeBYwmuNJYKH7lQvlfF8JjaOSp0UYwEiHbKG31Fsbcy/KYJ/23nPNfNcNfEbCz7lbTB3NMdKzzadqhGKvwWTe2e5hRg4VLUb7oxPga3y/PT41WcoAE/4GQZvP68AiCLGtYxZj0tUw22utVV54xT59bBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mcfwcfYS; arc=none smtp.client-ip=209.85.166.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f172.google.com with SMTP id e9e14a558f8ab-3638b5f8240so277885ab.0
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 10:18:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706638708; x=1707243508; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QYGx6IS6TCHytMnFpf5YwmAm01y1uABT6/tqdkSyT5c=;
        b=mcfwcfYSbKbNDpsqy5RylrH8VYZiE5S7Tyw7YNrLmW5O7++wXun4Qwjy+x7ci1jfxs
         5unacVfryGlp8S/DwXFvjeXNsqTM2b8dqSuDaFjJjr+F87V0NN6IKHU+wi80sMwnuLR+
         NTrP313nxxlaHKHEyM9+K+g7Oy1Y8LAWmrqHlvyYBRGNhsreD5B9tPRRE0rP6R5ikvCg
         ixKQ+pvPEOsH7KZhru3t8RUhtKJ3IoKN6IoWqonAYVptcoTOMRmE18lD4IDD0/eY1M8t
         FmrpSb3Ld3zp6QVnqhWf6I7ZrpG8dHZj6KSqpOggdQCqR+c8BcfT8uIGemq2BIkklJQ0
         OZ0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706638708; x=1707243508;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QYGx6IS6TCHytMnFpf5YwmAm01y1uABT6/tqdkSyT5c=;
        b=uQBPZEpnsTVyTK6jElYrzblpv8+tvhV76zl1dOhlFOsh4lvWIIsQIcc7ErgzS35QWA
         2ljuAgdRNoZZ3jcw8cDjFSQTR0tTGznreYQefXpiHKyOfcqTu+0EVGwRMnZjtythxYeK
         5Fxx7Or/nD1hnfeRbjRCFHQii+CrG42d4493JsR/RilMSkQr742H1lIvj0cAAW6Luorm
         R7zrQrfaQpvbO1Es4egATHbvJDp+M5eF7YIlKBNtlV3kh2SByxFiWnMXg+QuG4G6kaLr
         N70ja9Zzd6NCxAL7aA1F41/JfTvradAlo8epy9/zUpuXIN3XKWuF9Kp1/xegHYWJL3Vi
         d+BA==
X-Gm-Message-State: AOJu0YwB77nor+Fn9PW06SmLdIuBNaHiUosH18DASL8eyVmQA0dT8Rca
	Vox7eMrvcRtCV7tg7OPDh7Cr9zuvBXzNgT7f6SjefHO26gdXzAbeobsN0d0ZKZ/neLZkbb+HUrS
	6ZeSeIaqGIQt9B6+r+5JvoCEbVY5fnpOL4oI=
X-Google-Smtp-Source: AGHT+IGNeH+6/ZvR+lak8aN8tE2aB5TRbv+doV+RUr3w9+dApNV+ZvVl7d5W6W0A4rv/oR7KxOjPde4sY+yvwN5Uyzc=
X-Received: by 2002:a05:6e02:1b87:b0:35f:fefd:653c with SMTP id
 h7-20020a056e021b8700b0035ffefd653cmr1259217ili.3.1706638708483; Tue, 30 Jan
 2024 10:18:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240130014208.565554-1-hannes@cmpxchg.org> <20240130014208.565554-9-hannes@cmpxchg.org>
In-Reply-To: <20240130014208.565554-9-hannes@cmpxchg.org>
From: Nhat Pham <nphamcs@gmail.com>
Date: Tue, 30 Jan 2024 10:18:17 -0800
Message-ID: <CAKEwX=NvXj1eJCOECCV14X58nQVNUvLtn3wFsfcUruJ1nYAnow@mail.gmail.com>
Subject: Re: [PATCH 08/20] mm: zswap: further cleanup zswap_store()
To: Johannes Weiner <hannes@cmpxchg.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Yosry Ahmed <yosryahmed@google.com>, 
	Chengming Zhou <zhouchengming@bytedance.com>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 29, 2024 at 5:42=E2=80=AFPM Johannes Weiner <hannes@cmpxchg.org=
> wrote:
>
> - Remove dupentry, reusing entry works just fine.
> - Rename pool to shrink_pool, as this one actually is confusing.
> - Remove page, use folio_nid() and kmap_local_folio() directly.
> - Set entry->swpentry in a common path.
> - Move value and src to local scope of use.
>
> Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
Reviewed-by: Nhat Pham <nphamcs@gmail.com>

