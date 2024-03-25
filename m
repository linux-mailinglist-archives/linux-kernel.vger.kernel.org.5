Return-Path: <linux-kernel+bounces-116716-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8932F88A2D4
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 14:47:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 35C621F3C641
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 13:47:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C49D986AF7;
	Mon, 25 Mar 2024 10:28:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20230601.gappssmtp.com header.i=@brainfault-org.20230601.gappssmtp.com header.b="Q/c+0jDa"
Received: from mail-il1-f182.google.com (mail-il1-f182.google.com [209.85.166.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A90DC128823
	for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 08:47:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711356478; cv=none; b=H8nCKnyLk8nvGWmunb35ei9FJZQgBGIlsU2tCY8YCb8dQLgd6KMOXSW9oopuh+H4qK85BWXJOLBq4aN8yuTb1u87+sKBXDS+q/I9v71NkFm3ErY5CEyGuTSGPhNtx/+2Vcz9miX9xxEFHiB8PL4+4t1HgDCDoTrw3gM6lnHxalM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711356478; c=relaxed/simple;
	bh=oSJ//K8ol+P+P3Zji9tpLkFEeZi6qEgFOq9Ft7w2m3A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PdX8vZayKtMiNtj2XHAObdra+ZcWpnS/FEZsOcpRheuhIuf8CUaXPxOT90078WPK4ssJYvliz4VlvyHNEEFBkUHx7mZvapdTqx9OhTpSjtqZaLNiF3MTQuHGIEJNw9ZyzZk8wEoPqZp49WKtxdRj4k5XBrZR+KjqOnn8FIONMwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org; spf=none smtp.mailfrom=brainfault.org; dkim=pass (2048-bit key) header.d=brainfault-org.20230601.gappssmtp.com header.i=@brainfault-org.20230601.gappssmtp.com header.b=Q/c+0jDa; arc=none smtp.client-ip=209.85.166.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=brainfault.org
Received: by mail-il1-f182.google.com with SMTP id e9e14a558f8ab-366a4bcb2a8so19657785ab.3
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 01:47:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20230601.gappssmtp.com; s=20230601; t=1711356476; x=1711961276; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ms4jkXPSE9adqqhEBzf7IdCmvUVjO/xSfy0M32pByFw=;
        b=Q/c+0jDaGgQYCMEOJaTdZoj++p3BlqBXR11KnFZ0rESNwTqD5gRxO0dnbBMOzKIB+F
         nqTMiUY24noqpvp77sa5QBpo+fzo0ROtsUO6mc7vHwY27+L7PCsLVNgWDgL6ElI5Q87G
         oi2PfBuXcUGRJEzpspjlbTBgjXDeVqqPl5FRiJEDxmUxwSBpzfqAPTi1b6kLDcMBnXon
         kk5aKPiszi6EDTZtaT449yERNirSjYdh3HD8pGgfhIKXRC4SYZdJOF8r4PPfUtUsKpDR
         /UZXbqq3tv0HpoZVaNrfFMuQZ9d78lZ9HP6LRAWR5nhzvhjsclkkr2jSXHxhSjbQ/zru
         cNLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711356476; x=1711961276;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ms4jkXPSE9adqqhEBzf7IdCmvUVjO/xSfy0M32pByFw=;
        b=g7uFoPnGbLDOK2Y3Z1B1fo0YLKVepcFYR9bdJrxe2reNXNMqw2jkWVnHdLhUxCeF0Q
         TDvtLo88FlYX66dO/119i5dwv8pkVy/8zoJ4M4cQmDs+OQQpgOvs/53/1eJUiGCjD/2K
         6ostt1SfI9Y9y+ucwL039+xizVbTz/SC+LF6fCV5lbxSt0Bw2numefmDVLa3WiQtBE88
         ojUVgpyS6HbZAVLQKX+dagt+ScJZA7ozaaEKPIxBSJTS1IEaqVuAI4zC8wVDzfcEjQeA
         52R6toJMXIcb8fqi+EF9BQhMqBbqBFlpTopTmSO+w5d4HC33dXoqdyCKvr4jAJKOVVnS
         sVvQ==
X-Forwarded-Encrypted: i=1; AJvYcCXDTTVf65YVwmNAiDrgxZIXV8eIVsR4LLtK2CIcNZUucTeZQe3kp/JGH/DliuekER0pBITNSUwlraAeo8FM1qOS+Mpzg45ieiOXPiSy
X-Gm-Message-State: AOJu0YzCZcqyP9Lkk+x2wTD0/AUOHxd3H9bQheZOFMwoVyfaFWXO5nSg
	1Ce7wSKC7Sq+4rYigK1mxJmFyizD5r9ywvnsEaBjDNg2woMiCoNZzm1++kgaFY3OxUSmEp3ecBd
	QI1j9gMehrFSMdXCvqwHNY1Su4Bfy5Yt5kEaDZA==
X-Google-Smtp-Source: AGHT+IGSCwvEljJGbfYn9wLE/b5/75aeMuRrUiY3C9t/Q3AwACOXzG/3thuOXyzf1ItEA8Vd59vdH4gk5NwdYae+Ems=
X-Received: by 2002:a92:d744:0:b0:366:ab6f:f63 with SMTP id
 e4-20020a92d744000000b00366ab6f0f63mr6709994ilq.3.1711356475818; Mon, 25 Mar
 2024 01:47:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240315092914.2431214-1-colin.i.king@gmail.com>
In-Reply-To: <20240315092914.2431214-1-colin.i.king@gmail.com>
From: Anup Patel <anup@brainfault.org>
Date: Mon, 25 Mar 2024 14:17:44 +0530
Message-ID: <CAAhSdy2b1nUO5u0cM2uMcow931UX0Q=o_OY_YLQ5+oK499PX+w@mail.gmail.com>
Subject: Re: [PATCH][next] RISC-V: KVM: Remove second semicolon
To: Colin Ian King <colin.i.king@gmail.com>
Cc: Atish Patra <atishp@atishpatra.org>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, kvm@vger.kernel.org, 
	kvm-riscv@lists.infradead.org, linux-riscv@lists.infradead.org, 
	kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 15, 2024 at 2:59=E2=80=AFPM Colin Ian King <colin.i.king@gmail.=
com> wrote:
>
> There is a statement with two semicolons. Remove the second one, it
> is redundant.
>
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>

Queued this patch for Linux-6.9 fixes.

Thanks,
Anup

> ---
>  arch/riscv/kvm/vcpu_onereg.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/riscv/kvm/vcpu_onereg.c b/arch/riscv/kvm/vcpu_onereg.c
> index f4a6124d25c9..994adc26db4b 100644
> --- a/arch/riscv/kvm/vcpu_onereg.c
> +++ b/arch/riscv/kvm/vcpu_onereg.c
> @@ -986,7 +986,7 @@ static int copy_isa_ext_reg_indices(const struct kvm_=
vcpu *vcpu,
>
>  static inline unsigned long num_isa_ext_regs(const struct kvm_vcpu *vcpu=
)
>  {
> -       return copy_isa_ext_reg_indices(vcpu, NULL);;
> +       return copy_isa_ext_reg_indices(vcpu, NULL);
>  }
>
>  static int copy_sbi_ext_reg_indices(struct kvm_vcpu *vcpu, u64 __user *u=
indices)
> --
> 2.39.2
>

