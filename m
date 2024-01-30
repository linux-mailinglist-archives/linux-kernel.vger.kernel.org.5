Return-Path: <linux-kernel+bounces-44981-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B00978429EE
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 17:51:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6B4FF283158
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 16:51:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B7B312837D;
	Tue, 30 Jan 2024 16:50:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j+P6VWU5"
Received: from mail-io1-f52.google.com (mail-io1-f52.google.com [209.85.166.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E33771272C7
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 16:50:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706633457; cv=none; b=r3ELCmAldd2OZ+NtTw3jr+bdXIjDR2bDLxpphI1svfkU6X5NDO+ird8MIgi3HBZ5dXjXGeGA76fhTZUXo6W/4DzMc9RJfqpdwgwjGdUeQkoqB1ZmGynwSlEmSeuRtdagdAR8mtU6neAiarKW1HOHk6ANGVm6el+oTl15iaGMGMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706633457; c=relaxed/simple;
	bh=WaNq4krNLHt6a61UcNpi0mjlOnPPbIzoJTFazPx30HM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=f+5+x9p3g875I+U4yD1ZXZMmCeXJwQrCIDUsPia7VbDbaTPbhHkuqvZ2P0ZlC8ZOQEiTQx/jxp7jGX/6RTF16hDKJ75d30M9CuPeLWkuPCRm+UgL/Pwjp7yiyB9a2BPMJ5USRQYZlv0d1FC5t037eZWUZkuRkRMfOy/mE4pexJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j+P6VWU5; arc=none smtp.client-ip=209.85.166.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f52.google.com with SMTP id ca18e2360f4ac-7bf7e37dc60so166680539f.3
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 08:50:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706633453; x=1707238253; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WaNq4krNLHt6a61UcNpi0mjlOnPPbIzoJTFazPx30HM=;
        b=j+P6VWU5i1CXbNePjWyDkmbQ0YnhlWxWrFi/To5kvZObh+PvoQBcug/ZL+wOlauT7X
         Silw8gfD0N7elE4eCaWX8ah9ibclDmTeaTv0OkZD/bZJ2Q8LPLgI9bPYYbRQjxJw+QQU
         OQGAX7vUYohruuqIUjWNrCt5jpjh8tPw3/UCf9XdkkXSZnULpaSXQcxQwQNja721w6BA
         y5PnBhdonX6vpgVWkxmvuud3acIDc1XdvpYSsmZEokglwYgj6tdWoVpzSKdjs1ERn9tp
         xEDidzdGe8ABNz+679r0s++xIJ1HZMDPhsE5CtFRbJC+BdGUWHJG1OUD7nUboK6jiYHN
         H4oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706633453; x=1707238253;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WaNq4krNLHt6a61UcNpi0mjlOnPPbIzoJTFazPx30HM=;
        b=rWAu54tbw7IU4BaEQVvq5KiAB2hyvO5seyMMXjKeREYF2q9fYT66yUIdooWgjOX3uR
         mY565lhMGKa93S4YlNd3Ogi9L8yKbiRZ4k6LJDig0B8UYb1vzP+5Oe0ZwxnFI7LmWcoo
         eqqlKrjsBHPwX4Ff7TJeYU2unz6U8uSMjIznVXqbTF9JzXgbIXGJ08v4FJzja5nNhYxu
         LAlcjulVQsucUDSIVfSHYd93gUnCt2okOfwvxpRkuuARmsxtyvKGxvJJuirwbl4WaxGs
         Q9/qq5BJBo2H6OQ7bI3XTfgFdqJYC0lBIDvdo5jVv9s5a5fEyIi1WkKprfWVchQfvC7y
         93og==
X-Gm-Message-State: AOJu0YyaobRoqY8RpFIgV0+JfoB0BOegrKVUCcHEdKuwCbbp5JuciLNe
	qXpGx6s4xtR16/PWVhBhcy9w06ndWZGAgw9UZC7XZ4Kuzi5C7SloPTZX1LjP35aqzlibuIXpRfI
	3V+9Ods/nieyJpPx9n8s87I/uoTU=
X-Google-Smtp-Source: AGHT+IHuqz2gq0dE4xLIMd7PAu5RDHX4hb/TSC+tE+WRwS7XbwIXwFS1AW4oZM1rj3cLxEszzK7f3bpUY35iY3cx4Nw=
X-Received: by 2002:a5e:cb01:0:b0:7c0:19e5:f33d with SMTP id
 p1-20020a5ecb01000000b007c019e5f33dmr170708iom.9.1706633453613; Tue, 30 Jan
 2024 08:50:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240130014208.565554-1-hannes@cmpxchg.org> <20240130014208.565554-10-hannes@cmpxchg.org>
In-Reply-To: <20240130014208.565554-10-hannes@cmpxchg.org>
From: Nhat Pham <nphamcs@gmail.com>
Date: Tue, 30 Jan 2024 08:50:42 -0800
Message-ID: <CAKEwX=N_ajOM6SDejEiujG2qrVMnUt8apW0BsYo3MVSwcDTeog@mail.gmail.com>
Subject: Re: [PATCH 09/20] mm: zswap: simplify zswap_invalidate()
To: Johannes Weiner <hannes@cmpxchg.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Yosry Ahmed <yosryahmed@google.com>, 
	Chengming Zhou <zhouchengming@bytedance.com>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 29, 2024 at 5:42=E2=80=AFPM Johannes Weiner <hannes@cmpxchg.org=
> wrote:
>
> The branching is awkward and duplicates code. The comment about
> writeback is also misleading: yes, the entry might have been written
> back. Or it might have never been stored in zswap to begin with due to
> a rejection - zswap_invalidate() is called on all exiting swap entries.
>
> Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>

Reviewed-by: Nhat Pham <nphamcs@gmail.com>

