Return-Path: <linux-kernel+bounces-112799-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5288B887E4A
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 19:20:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E551E1F214BF
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 18:20:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1234D25775;
	Sun, 24 Mar 2024 18:20:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="xmqKUySj"
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACD0A25543
	for <linux-kernel@vger.kernel.org>; Sun, 24 Mar 2024 18:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711304412; cv=none; b=rUk7eRtuVPXban2h1z4Fu5SOoj+zXUClEr+HdKREZ70KwtmDqDtx0s8t8sBZAEnfZwOXaMztEbqNbawBVvYek50/I6G3mrMKv4xFUD2KxHlSe8EyuBhxflavcTlaGe/d3MZoCl+g/RaDhOrE8B/F98Lbw8C5mHnz47vLHYv1Z2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711304412; c=relaxed/simple;
	bh=tcURe01+2Dp23RDAAs5J3VwKExLuBYmDlvMP6G0CPRY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TslcEynL++L99+zu7NueEoxhT27raFMth1aXKDLnvzrCYAukqKPa6bc/xO81q+um0idyk8EeoyRXk/38IAgMRdtvjJWhuersGwaQz+5pjePikuX2JIFeCR9dkR1/I4R/i4GuaMh+hegaztGbH3EwWyXj+ol4VIGl22TopnO1+FY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=xmqKUySj; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a44665605f3so413646466b.2
        for <linux-kernel@vger.kernel.org>; Sun, 24 Mar 2024 11:20:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1711304408; x=1711909208; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tcURe01+2Dp23RDAAs5J3VwKExLuBYmDlvMP6G0CPRY=;
        b=xmqKUySjLIXbdVyBeXvPJavrdibFp5g5W3JBrMclGy+PTLzjHt+Rh8i6dcwCNd8qg3
         Rp0FAWz3+CFqZJHjz/9NMu0xM4mUEFkd6WlfVfOzmaucAn81/JaTNpcu7Fy0gv6XS3WR
         8Hr9ZK5T7rVWfL+GGlS8ogSTiOUwXP+70bhEHWIwkYfM3DWj0hJA8ATq1cC84CwVcImg
         XEtR8LsxfmJnKuvUP9KBE2hBbT4gobEtNqTOFgctHUR55qUnsP6q0Z7q8Y3tTXEObxy9
         E0DS7P359H1zbNix/peYH5sLe+WkCpXez7XG6nvAacxO1XqQg8gdDpCJLQaLdR8ukQ7z
         9Vow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711304408; x=1711909208;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tcURe01+2Dp23RDAAs5J3VwKExLuBYmDlvMP6G0CPRY=;
        b=BPFIMShr9NzqLNSfgvXbxspPJjxyVip/tHnq7ta674rKr9SuExcPk9SSOqm02W57Bk
         LZRuYm8J9TUYsWJvKHBBsjEvqM2/i0TprVEbqLJHEy7BkC4tOGhgcizXomwEuAzxEZHQ
         amuUToOZUSRse3RV2llDcln5LHbXbUqgTsiFLUQoFBACy/uA9aX1o7NKhrmEPEf4lfEK
         cMwyt15QPbPAfaHQgz6UrZ5t8UG57/7tTP3NxGqC4sWp2aaM/p2m3x9+7FtH7Q2Ec69J
         RmzZRPU0OSDHxG8iXW+h1hStz/HJVxQN/DG3hER0XPtM06tMjL+OXO3oOn8xwEdj6xDW
         DDkg==
X-Forwarded-Encrypted: i=1; AJvYcCWiKUNMqE6fU58tr1TDS0MXZ8efjVfiv/vfvfd88wzIk8B8+AUdO4XedGIPM1fMQeBKIhID8fyfrKgkQ7Y9YOeRJUGDUx2NLDVvHdbo
X-Gm-Message-State: AOJu0Yz//qK1X//aKkQCCjzGXMWgIJM1F+pxPJFDw1ZG2OlATLI2D/ZZ
	QzWGxVAnVJ4yx5/FdoweWWIdL0TT362sxGtBPDR4wCLN0QNjIjXt1HsNW1KG2pB+fFl4kWzGrc+
	xc6KtkxbXK0rB+3n/HwR+iCn6yBtvCEZaH9DAsg==
X-Google-Smtp-Source: AGHT+IH80eFEX1cLDFFwaoYEe0nA3zQAUOJv6glpAAIEAlcfpQG3B9i6sSNod2Y6qc1if8PuXmzbfow2pjSjlkiL6rM=
X-Received: by 2002:a17:906:fa90:b0:a46:faa7:d014 with SMTP id
 lt16-20020a170906fa9000b00a46faa7d014mr3249934ejb.9.1711304407841; Sun, 24
 Mar 2024 11:20:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240322112629.68170-1-alexghiti@rivosinc.com> <20240323062625.2488-1-dqfext@gmail.com>
In-Reply-To: <20240323062625.2488-1-dqfext@gmail.com>
From: Alexandre Ghiti <alexghiti@rivosinc.com>
Date: Sun, 24 Mar 2024 19:19:56 +0100
Message-ID: <CAHVXubisa6HQJDbj_GfjwhP1Y4as0DzrxsU0B7N6DSU6HZNaaw@mail.gmail.com>
Subject: Re: [PATCH] riscv: Improve sbi_ecall() code generation by reordering arguments
To: Qingfang Deng <dqfext@gmail.com>
Cc: aou@eecs.berkeley.edu, linux-kernel@vger.kernel.org, 
	linux-riscv@lists.infradead.org, palmer@dabbelt.com, paul.walmsley@sifive.com, 
	samuel.holland@sifive.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Qingfang,

On Sat, Mar 23, 2024 at 7:26=E2=80=AFAM Qingfang Deng <dqfext@gmail.com> wr=
ote:
>
> Hi Alexandre,
>
> You can simply make sbi_ecall `__always_inline`, so the C function call
> overhead can be fully avoided.

I understand your point, though I don't think we need to mark
sbi_ecall() as inline, it's not in any hot path so it's not worth it.
This patch simply gets rid of a really useless overhead, but it does
not visibly accelerate anything.

I hope it makes sense,

Thanks,

Alex

