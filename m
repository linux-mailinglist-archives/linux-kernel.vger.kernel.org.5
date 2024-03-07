Return-Path: <linux-kernel+bounces-96339-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EBB4875A6C
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 23:45:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 24B4D1F23327
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 22:45:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EA483C06B;
	Thu,  7 Mar 2024 22:45:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hKi2xFZT"
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37CE9335D8
	for <linux-kernel@vger.kernel.org>; Thu,  7 Mar 2024 22:45:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709851513; cv=none; b=bsjAsiZawzWCMAdmERywZlc2W2jLGY7HNRWvN43n7U5AjMlofcS4aGPocVa4pNEkAjFbMHzlnr6Vyd1DJi+k7QTL6BeJ+iZETN6Su/dY5SZV3uZ2Gz3fdIsWBajszDl6QnkvevHguMPJm0k00O6kMcXWaKSrVHqFwtn//T34+KY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709851513; c=relaxed/simple;
	bh=ypj7AYqbc7IToRNdpZemEdAP5+WqsSoaed+deKjFkpQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OuW/Xl41mGqgn2EdFDoYqnDYjvP4QbAdoHnDYYIK/D+gwGE1AQpNRHQtfkro5hslrZDozmCh+/UrFhcFdVBj21ze6W+Vg3KKNLGFbceoV42nqINV6w6Dr0e6TgusNHlxbYp5FXBFKrL7ybzqoEuyEXFh5yKZ3Yv6mLDh2WErFNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hKi2xFZT; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a4499ef8b5aso31859366b.0
        for <linux-kernel@vger.kernel.org>; Thu, 07 Mar 2024 14:45:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709851510; x=1710456310; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ypj7AYqbc7IToRNdpZemEdAP5+WqsSoaed+deKjFkpQ=;
        b=hKi2xFZT2e04mHZTM9NdRWZxns+PfUCJFCDefYsISyq9Lq9D8/Z2+4a5E6VlY7jSCS
         rYWtW0qgc47yNueBSBO90C4sPg1a9hKCv+i0fwyk7i9GwaPYgiVjgyG1ndU8aFpGhTt8
         ruDneyWZD3wOhcZgYSXsZwz+PBQRLcSCloDVnC/STqfYvD5JRo7b/bBiSQHpPU15gjhO
         R7+o56AJC0IsopNg2coIaSRjQ26rMypV8RKidtxM+YLx52+MAnnqtObHBUiH10xBwmEo
         1NOHJnoYjjnAvB9D6UuRGThs+KNajERNKrKhciAOLpv+HpItI06nmwdthTB8D8N23UHi
         IrVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709851510; x=1710456310;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ypj7AYqbc7IToRNdpZemEdAP5+WqsSoaed+deKjFkpQ=;
        b=uMJYuJDI8XKUT7Kj576HsDUD0OYzYZYG+DijZ8PlpNOBtAXh86HXbc6p2OaRBG2IUt
         cEK83UZsvlNGn1DUA4pFIBV+B3O9VEm2c2za/0eKzLkk2WnQv8Zd+yrCPO+r4pEgzIQ1
         QBrDXk4oe11dqlrtSYu1O7K626GfwpQery898Y0mLGhwmzrmyPENC2wXjf4VkVw6y+nO
         Jb7rOGlJYnrj2b5v3W/AWScc4ZWfIrg9AcOo2h015DPVixf2D8SiPH/sneICZXOKN0ty
         kiBW9kOo8iZIliM29OSg0o9AUZGIsY3kwELqeso3AeaPgy6IJZN6o0nglftPcNCB3YhZ
         B1Sw==
X-Forwarded-Encrypted: i=1; AJvYcCWdTx+vmVbYaywm0tpYN4PL9DNFYmIFh4vz3dR6CImqSszZyL7iVtkIhuRg9Z4koSQ/8TZjiPN/+ClXpN7Z9gT49JqWhf+RtXKtD1La
X-Gm-Message-State: AOJu0YxfkVizXyraWgShNk1v2RlNZ+BiMzbFv5vrphYgJzloh403eNhr
	CLaj1t17X31vEmXmNLtrbtOzN0XdTXTQlArNupOUAd52nDn5D8+BYAwUsA9TUiIbODpStAOdoed
	l22zqW/nnoiAmMAEYYSZwJD6dfghEELcBZeGh
X-Google-Smtp-Source: AGHT+IFUCsgZ+JCEUXueYUsj0QlURI8pHRl4xSoErjg7kQ+BZ0lu/uanDGrm8x+6kRdeAq0RorEjgfpp90vny0VuM4c=
X-Received: by 2002:a17:906:b888:b0:a45:2a53:d6b9 with SMTP id
 hb8-20020a170906b88800b00a452a53d6b9mr9674520ejb.62.1709851510270; Thu, 07
 Mar 2024 14:45:10 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240307133916.3782068-1-yosryahmed@google.com>
 <20240307133916.3782068-3-yosryahmed@google.com> <83b019e2-1b84-491a-b0b9-beb02e45d80c@intel.com>
 <Zeor4DIGj0u6LNIw@google.com> <cb1aaac1-4800-4cae-8aea-acba6353971c@intel.com>
 <Zeo_yUTdGKVed7ff@google.com> <dbdf67a9-35b7-443b-9e19-72a43879255d@intel.com>
In-Reply-To: <dbdf67a9-35b7-443b-9e19-72a43879255d@intel.com>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Thu, 7 Mar 2024 14:44:33 -0800
Message-ID: <CAJD7tkZAq7s6TbZnjSnw1Jw0QU9ywaPREqDR1i4=KdObBtTZ+g@mail.gmail.com>
Subject: Re: [RFC PATCH 2/3] x86/mm: make sure LAM is up-to-date during
 context switching
To: Dave Hansen <dave.hansen@intel.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Thomas Gleixner <tglx@linutronix.de>, 
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Peter Zijlstra <peterz@infradead.org>, 
	Andy Lutomirski <luto@kernel.org>, "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, x86@kernel.org, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 7, 2024 at 2:41=E2=80=AFPM Dave Hansen <dave.hansen@intel.com> =
wrote:
>
> On 3/7/24 14:29, Yosry Ahmed wrote:
> > Just my 2c, let me know what you prefer =F0=9F=99=82
>
> I'll let Andy weigh in here, but I think I kinda already mentioned at
> least twice what I prefer. :)

Well I was hoping my last email changed your mind, but obviously not :)

