Return-Path: <linux-kernel+bounces-109117-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD33C8814D6
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 16:46:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 31C18284A71
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 15:46:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0A785472A;
	Wed, 20 Mar 2024 15:46:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ig4aatuc"
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A8321A291;
	Wed, 20 Mar 2024 15:46:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710949598; cv=none; b=tB7ikERN95RqdKTbK4y0Gxi4ptOvVNbrKsdDCw8YFvDVDBily5pk598mvdnVPXmo+lTSznGV8bJq/yVStEgFvjwF7NVN9dVaElJnUxQO8/Yg0WH5rEMC1akHXg/hWGxICaVqQcuWyGf7QKbtN6ECIBxOQAD02X3kMVnLibr2pZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710949598; c=relaxed/simple;
	bh=ViYPNM62rKHftFHn8EtCwM10ykuEE7S2GB4Mq6QRH9I=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=F0ONlRtgybO8Kb3wUKFcbr6y8FFbhMF0mpi8dDJxK/TqCnhwCto/fpYjAltnaLN+ox/tfi4ewul0A4TIgFdwsT4sAI+68sp18jc7EgyJV7eijo3NfefFP8odJWlErQGSCeQCZc6E0S+9p47wwPp7FEuhPWHsqXmqFRs5Eqr/2/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ig4aatuc; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2d29aad15a5so84561831fa.3;
        Wed, 20 Mar 2024 08:46:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710949595; x=1711554395; darn=vger.kernel.org;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=oaXJM9ZvZn/4LaQiASqOr/xxq5nAZPZqRyNDIlEESuA=;
        b=Ig4aatucE/O8jMGTpjBdR8oyefLUCu7vccGd365GHV/VBgF63OFYkk6ZeV2N1LFWHq
         IuoIlWmDJuihpCpYTKFc8MgxBHPK6L+VIuc6IylwHHle984vgLwns+G8LocgRASd/3ID
         Sp3y4JzZIj6eZ0Qtu9yfueb1vdUiyUTWzLbaXlKFp24Tm9xBTf9ng/rANZrDfDlFRbgA
         epgDGMWZUJEX9gBc0UN3zAkJiKBZGMJFsG3AdD14H6POawlyodDjhzUVy0plN1AcFA6/
         p20qBJ/doQHvZ/DfTpGALec65LPX4STBGcVE+LWHRiSRm9NkNfajAYOky7/wElgJgtM1
         Z04A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710949595; x=1711554395;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oaXJM9ZvZn/4LaQiASqOr/xxq5nAZPZqRyNDIlEESuA=;
        b=tEZJZlNBD1oPQznBtPheIM7dNSykzJrTV3jEjxDqUOF9z+NV/54euhcT3om8TlR7Nt
         sR13yEb69e2Gn7QRBY8tN2lGSxrHbpReXn/sAfYv1v3oqoZZMulKV2N75MukJ+UKeOzu
         +4Sm+el30Rmh6K0XJ9woYBn9Zggk2zjTGWLc6JfPYi3XxVIZEFqYXnTNDrcEeriUaabF
         6ghlnjLB1AmWQM3hT+GfV4jKn7/HobHVLp+soD7p66V2RoRR/Wp6K3vNn3gwJsFiLq0v
         c0o7bom9hBNdGsJQq7Mfst1dkjxHFoWyedyzMu53EmnKiQtACEBYpiix8/YJpzHZap9D
         aGoA==
X-Forwarded-Encrypted: i=1; AJvYcCVShIIl/ibxz69Hkrg1HHQfbonKr2aeFoRCnUgflnCf4veBV6JjKSlg290AjrxI8/TCvL7hELVuzRmoeFpMBw4EUIURA3ICUeUFmjwNXnhismJ6S2BL8X+cFQFDQIPp5sVr1WznhitffnQ5npsYYCI5yTokT+Ah5yQL
X-Gm-Message-State: AOJu0YyccXI9qH2XiZfTyejerWnJGzrKpplnZ59sH+JAWt4im7TEEZg7
	x5CWJfYOMLlP+Kc8H2fx9dbWBd/REUXBbGqCkp6SCwsOAmpaq5cx
X-Google-Smtp-Source: AGHT+IHtAQBGTDzEKsd2vJSQqMdsoYc7Xoc9c6idIuX7GW2nJu0OCfI8MTqhgP4XquycBw3saVi47w==
X-Received: by 2002:a2e:22c3:0:b0:2d4:764f:8256 with SMTP id i186-20020a2e22c3000000b002d4764f8256mr10808698lji.53.1710949594945;
        Wed, 20 Mar 2024 08:46:34 -0700 (PDT)
Received: from localhost (54-240-197-239.amazon.com. [54.240.197.239])
        by smtp.gmail.com with ESMTPSA id n39-20020a05600c3ba700b0041409cabb39sm2607210wms.18.2024.03.20.08.46.34
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 20 Mar 2024 08:46:34 -0700 (PDT)
From: Puranjay Mohan <puranjay12@gmail.com>
To: Artem Savkov <asavkov@redhat.com>, Xu Kuohai <xukuohai@huaweicloud.com>
Cc: Xi Wang <xi.wang@gmail.com>, Catalin Marinas <catalin.marinas@arm.com>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 bpf@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH bpf-next] arm64: bpf: zero upper bits after rev32
In-Reply-To: <20240320133849.GA142600@alecto.usersys.redhat.com>
References: <20240313140205.3191564-1-asavkov@redhat.com>
 <ab5e6307-8d80-4751-940f-4faa5bc41d82@huaweicloud.com>
 <20240320133849.GA142600@alecto.usersys.redhat.com>
Date: Wed, 20 Mar 2024 15:46:31 +0000
Message-ID: <mb61pbk78x5wo.fsf@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Artem Savkov <asavkov@redhat.com> writes:

> On Wed, Mar 20, 2024 at 07:34:46PM +0800, Xu Kuohai wrote:
>> On 3/13/2024 10:02 PM, Artem Savkov wrote:
>> > Commit d63903bbc30c7 ("arm64: bpf: fix endianness conversion bugs")
>> > added upper bits zeroing to byteswap operations, but it assumes they
>> > will be already zeroed after rev32, which is not the case on some
>> > systems at least:
>> > 
>> > [ 9757.262607] test_bpf: #312 BSWAP 16: 0x0123456789abcdef -> 0xefcd jited:1 8 PASS
>> > [ 9757.264435] test_bpf: #313 BSWAP 32: 0x0123456789abcdef -> 0xefcdab89 jited:1 ret 1460850314 != -271733879 (0x5712ce8a != 0xefcdab89)FAIL (1 times)
>> > [ 9757.266260] test_bpf: #314 BSWAP 64: 0x0123456789abcdef -> 0x67452301 jited:1 8 PASS
>> > [ 9757.268000] test_bpf: #315 BSWAP 64: 0x0123456789abcdef >> 32 -> 0xefcdab89 jited:1 8 PASS
>> > [ 9757.269686] test_bpf: #316 BSWAP 16: 0xfedcba9876543210 -> 0x1032 jited:1 8 PASS
>> > [ 9757.271380] test_bpf: #317 BSWAP 32: 0xfedcba9876543210 -> 0x10325476 jited:1 ret -1460850316 != 271733878 (0xa8ed3174 != 0x10325476)FAIL (1 times)
>> > [ 9757.273022] test_bpf: #318 BSWAP 64: 0xfedcba9876543210 -> 0x98badcfe jited:1 7 PASS
>> > [ 9757.274721] test_bpf: #319 BSWAP 64: 0xfedcba9876543210 >> 32 -> 0x10325476 jited:1 9 PASS
>> > 
>> > Fixes: d63903bbc30c7 ("arm64: bpf: fix endianness conversion bugs")
>> > Signed-off-by: Artem Savkov <asavkov@redhat.com>
>> > ---
>> >   arch/arm64/net/bpf_jit_comp.c | 3 ++-
>> >   1 file changed, 2 insertions(+), 1 deletion(-)
>> > 
>> > diff --git a/arch/arm64/net/bpf_jit_comp.c b/arch/arm64/net/bpf_jit_comp.c
>> > index c5b461dda4385..e86e5ba74dca2 100644
>> > --- a/arch/arm64/net/bpf_jit_comp.c
>> > +++ b/arch/arm64/net/bpf_jit_comp.c
>> > @@ -944,7 +944,8 @@ static int build_insn(const struct bpf_insn *insn, struct jit_ctx *ctx,
>> >   			break;
>> >   		case 32:
>> >   			emit(A64_REV32(is64, dst, dst), ctx);
>> > -			/* upper 32 bits already cleared */
>> > +			/* zero-extend 32 bits into 64 bits */
>> > +			emit(A64_UXTW(is64, dst, dst), ctx);
>> 
>> I think the problem only occurs when is64 == 1. In this case, the generated rev32
>> insn reverses byte order in both high and low 32-bit word. To fix it, we could just
>> set the first arg to 0 for A64_REV32:
>> 
>> emit(A64_REV32(0, dst, dst), ctx);
>> 
>> No need to add an extra uxtw isnn.
>
> I can confirm this approach fixes the test issue as well.

Yes, the following diff fixes the issue:

diff --git a/arch/arm64/net/bpf_jit_comp.c b/arch/arm64/net/bpf_jit_comp.c
index bc16eb694..64deff221 100644
--- a/arch/arm64/net/bpf_jit_comp.c
+++ b/arch/arm64/net/bpf_jit_comp.c
@@ -943,7 +943,7 @@ static int build_insn(const struct bpf_insn *insn, struct jit_ctx *ctx,
                        emit(A64_UXTH(is64, dst, dst), ctx);
                        break;
                case 32:
-                       emit(A64_REV32(is64, dst, dst), ctx);
+                       emit(A64_REV32(0, dst, dst), ctx);
                        /* upper 32 bits already cleared */
                        break;
                case 64:

All tests pass with this change:

test_bpf: Summary: 1049 PASSED, 0 FAILED, [1037/1037 JIT'ed]
test_bpf: test_tail_calls: Summary: 10 PASSED, 0 FAILED, [10/10 JIT'ed]
test_bpf: test_skb_segment: Summary: 2 PASSED, 0 FAILED

When you send a patch please add:

Tested-by: Puranjay Mohan <puranjay12@gmail.com>
Acked-by: Puranjay Mohan <puranjay12@gmail.com>


Thanks,
Puranjay

