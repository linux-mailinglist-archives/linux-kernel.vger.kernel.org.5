Return-Path: <linux-kernel+bounces-91969-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 62F1D871930
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 10:12:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7823DB25348
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 09:11:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1623E50263;
	Tue,  5 Mar 2024 09:11:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ixPBNacA"
Received: from mail-vk1-f170.google.com (mail-vk1-f170.google.com [209.85.221.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1BAE4DA1F
	for <linux-kernel@vger.kernel.org>; Tue,  5 Mar 2024 09:11:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709629911; cv=none; b=dpRuJcVb1XNNsHhqFSX7Gvk4uLcMxXZpWRFAnNJyfTewZl6UBW/A4zvGwmEx94rKhwLO5kyqcuSKr8Z8BsheEt8mM+6GEyLth2coaF3U/S/wfruWazgOmtq+/UcIm6fl+u89RL0ZV+QU3W9gj7G07zU4UGBlsnokfmPAA1upk/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709629911; c=relaxed/simple;
	bh=lspHgMoDrQwCjSsOqQZMNObR97AWdxVqEXmXExyUvME=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UFTSMwUsGa/9oUNkD3t0xQkSAJJcemo9GJOY6m/QfaGBYE9vRQ5NsaiCqq8vFdGwHmbraFyJK9u7r6y4NNz4thvuOsLuDl/3Zkbi4kv6gEcf/xH2VFm7Ns0Q9YeQjYnJnsyWCDULarhoA0tp2SUoLaB9QujRzUzoh46nvsP31zw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ixPBNacA; arc=none smtp.client-ip=209.85.221.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f170.google.com with SMTP id 71dfb90a1353d-4d332d0db9cso1176361e0c.3
        for <linux-kernel@vger.kernel.org>; Tue, 05 Mar 2024 01:11:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709629909; x=1710234709; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HK4MOFklGD0kksSLsuZIfHxojou135gVm+eLOXKc4TA=;
        b=ixPBNacAZbJ37BCTTj7pe5ptRU10Afa6LbYqjn3tiELLfmuLQaVT6PGwAsEj/D7nT0
         zcJxzdzxaY7DlmI9dZIl17L6cM74QRWrJvjoqSd2K0Kbhk2KhTNElfqnqCjYVmyiXps0
         2stB/9oim58S0QtzZNEEziIbzDqOqeAliVuaPQ7iGVJk+yZq1kazxs4w2iO7Y8n7O7sH
         crzljuTzfNuOp56qR34zzBJqshokddRA6Uc8egQBVNq0PgUJ6MJZVp17vgfIwAzA3Sgu
         4QDsOTr7vYH3/8pNDnPOZheMd290JF1XnoV6EegUog5WONRVFs8yzIt5t/noul2JIc8O
         YJlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709629909; x=1710234709;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HK4MOFklGD0kksSLsuZIfHxojou135gVm+eLOXKc4TA=;
        b=WrYbGWKjRoVw74IVJh0KT9lYznIPCQd+Xf5/h99dS5v65ec7d2GpDKfwxLzZvcY6H9
         gejvX/9/3EYjV0GmqhTbAUISt2dBoRY6Y/s6F9oDhU77lb9CnMoX48Rvcele8VAm6bC2
         IbrEqjBs12RdOV2owlfENq0PD2r02uiR58OCx63qztAsfA5dqK6YRCTbDicTcHCx8gUl
         Er57ZSvB8v5fi3pwL/ReVzKCIylomst1iyfqcva9fjmvMs803dzIRtVLswPkICzteI92
         lDVUDVffcxyUmNoWtCe9w41YhEXR8CYDkmY8FSQ6gHdS04PuPF2AxQVokFU603SL7nd9
         1pWw==
X-Forwarded-Encrypted: i=1; AJvYcCU5QaCxDdMs9dOhis7fIl2gCKnPHS5BdT/evE7iQ5guBAwUAh84SRqNyFbPtWmKsmLGhF5yJTItKeGCLJ3JlX6Stez2v0CmlrKvY/b7
X-Gm-Message-State: AOJu0YxQSXFj0eOME2PlArS7VSQKJBUYf5OHBvwARHd3fFm+b1ju/IDD
	3OXofbmrBk9pkOYm+lv4bBV5EcRTXE/9HVRrfn1PycuyiQE0rUOYMaYjz1nkn1K7ZV2wohTPyZ4
	DEP4pIBRe3P9AHOEGuh/XpuQWu6Y=
X-Google-Smtp-Source: AGHT+IE4lOQmCFcFkhWmA8JnrePAC2BlSKtHgiX+UOC2rbFU7aoFWdKcbH1dasCBbpDAPaXiQJXVUe0mhCSyJyVN90o=
X-Received: by 2002:a05:6122:2521:b0:4d3:3359:b97d with SMTP id
 cl33-20020a056122252100b004d33359b97dmr1377973vkb.2.1709629908769; Tue, 05
 Mar 2024 01:11:48 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240304103757.235352-1-21cnbao@gmail.com> <878r2x9ly3.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <CAGsJ_4yKhoztyA1cuSjGEeVwJfNdhNPNidrX-D_dRazRL7D5hg@mail.gmail.com> <6c16c7c5-8cf4-4c30-b3a5-a9ab55b21114@arm.com>
In-Reply-To: <6c16c7c5-8cf4-4c30-b3a5-a9ab55b21114@arm.com>
From: Barry Song <21cnbao@gmail.com>
Date: Tue, 5 Mar 2024 22:11:37 +1300
Message-ID: <CAGsJ_4w1dhqCu6UA4LGt9XDU_2jmcmWm1=E9MzX2tRv85NrLuw@mail.gmail.com>
Subject: Re: [RFC PATCH] mm: hold PTL from the first PTE while reclaiming a
 large folio
To: Ryan Roberts <ryan.roberts@arm.com>
Cc: "Huang, Ying" <ying.huang@intel.com>, akpm@linux-foundation.org, linux-mm@kvack.org, 
	david@redhat.com, chrisl@kernel.org, yuzhao@google.com, hanchuanhua@oppo.com, 
	linux-kernel@vger.kernel.org, willy@infradead.org, xiang@kernel.org, 
	mhocko@suse.com, shy828301@gmail.com, wangkefeng.wang@huawei.com, 
	Barry Song <v-songbaohua@oppo.com>, Hugh Dickins <hughd@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 5, 2024 at 10:08=E2=80=AFPM Ryan Roberts <ryan.roberts@arm.com>=
 wrote:
>
> On 05/03/2024 08:56, Barry Song wrote:
> > are writing pte to zero(break) before writing a new value(make). while
>
> As an aside, "break-before-make" as defined in the Arm architecture would=
 also
> require a TLBI, which usually isn't done for these
> write-0-modify-prots-write-back operations. Arm doesn't require
> "break-before-make" in these situations so its legal (as long as only cer=
tain
> bits are changed). To my understanding purpose of doing this is to avoid =
races
> with HW access/dirty flag updates; if the MMU wants to set either flag an=
d finds
> the PTE is 0 (invalid) it will cause an exception which will be queued wa=
iting
> for the PTL.
>
> So I don't think you really mean break-before-make here.

I agree I use a stronger term. will change it to something lighter in v2.

>
> > this behavior is within PTL in another thread,  page_vma_mapped_walk()
> > of try_to_unmap_one thread won't take PTL till it meets a present PTE.
> > for example, if another threads are modifying nr_pages PTEs under PTL,
> > but we don't hold PTL, we might skip one or two PTEs at the beginning o=
f
> > a large folio.
> > For a large folio, after try_to_unmap_one(), we may result in PTE0 and =
PTE1
> > untouched but PTE2~nr_pages-1 are set to swap entries.
> >
> > by holding PTL from PTE0 for large folios, we won't get these intermedi=
ate
> > values. At the moment we get PTL, other threads have done.
>

Thanks
Barry

