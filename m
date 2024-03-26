Return-Path: <linux-kernel+bounces-120024-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C591088D06A
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 23:06:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5A25F2E773C
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 22:06:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6434F13D8BA;
	Tue, 26 Mar 2024 22:06:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Tv4f1lNE"
Received: from mail-ua1-f47.google.com (mail-ua1-f47.google.com [209.85.222.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EA4B13D604;
	Tue, 26 Mar 2024 22:06:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711490788; cv=none; b=lPfwRjd4e5IU/Gb4Gu8lDeSUhULyM4gv6JrPty/lrigSFqPJEmvkvSMWBxzRVcbhUxmp+NWIWogaf5uBNdU+uheqbRr0fiGljUBAgcxBLI2ddvT7NYFgutMKMElSdBdpgBiVFMNezjNPpd6j22l5gl+lqBQE4Li5ybh1PJi5Las=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711490788; c=relaxed/simple;
	bh=TL9l5kVxRW7ebqXvNEm/v9prUz+V0nX2Ma1t8SHFn80=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=ryd+feDLm3XzUvhOFFh2KOkVZgUbPUJ6Jz8Z7iu3HTR4PdoZ7uMgHFDcyfNLixnMt41J7Yn5jWNg5ZImciciG66lruxno6DDdvkSEOUDKeSEoEvEcYdYdtreyqhSpmi1nBx6seeUtFKwNfR1lD9MGyuoavGq5Ho8HWpF+BHxng8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Tv4f1lNE; arc=none smtp.client-ip=209.85.222.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f47.google.com with SMTP id a1e0cc1a2514c-7e043f577c5so136430241.1;
        Tue, 26 Mar 2024 15:06:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711490785; x=1712095585; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=TU3+ImXwqiVtc0TZrqGynXRP9+v8b83+IYx34sTtg0o=;
        b=Tv4f1lNErnWQOOT6HWyb6ssQFBUaj269JGliife3gklKD096gNenMqTcdYFuPAySl6
         Imy74t9KIp7bjHV5/URQFgNvWK/WGOfGCTZ/Evqy7FMvMArAbyfGv8JcUurSqzTqPUl0
         7OrhS3Eer3EBRsyV9QbTpbTV6ErQScjp7gwBR5F82Kb/uhSYt77GqkgRz529uRpfE+8t
         SF19trGRNFfq2Hj43AwpGIEbWdyRH+MrtewgyqRlRvCf25dniGyq/PUkELzotgi0HV4E
         BrszsjhALIwdUg3Y3WZKwLz9fahKFWDjjNIbEyEgZpoVtSWwIjrUxaBM2Cy6qM5vtyU3
         gIkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711490785; x=1712095585;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TU3+ImXwqiVtc0TZrqGynXRP9+v8b83+IYx34sTtg0o=;
        b=cyHjjLnCqAgWeQV17/6WXrvBtEwxK/X0tWaZ6SKMrJB3MpYn9l3HrM9Yl1dr4NgFII
         ABew/F5b+Mbai60AgBe5ZILeytYPMXXXMPvCN+9NGv6+WKGrcp2fcq+zfsEV3wRSEWre
         Lt2g9++ELP/Gp90i5xF4MJBvoeiRAMAC/i3bxpDKSzH8oKWD2vsFsOIEEdf+UFOgMpcR
         JxCRPwO9Sy5Xu5F+6Q2ycqsnsCK3Imy6d1zNq4VcRi2R0RZmUbJNjLnT3Qpb3PC8VC/e
         Gy12AVIKlaHKwi/4w6nNCzasQf1XesdkuEm/tAlZbHu3Rgfg6ffofJsb+sQ77diY7D4Q
         2T1w==
X-Forwarded-Encrypted: i=1; AJvYcCWfCjAuMhQTDVtCDi7EWYQOBxJ56lp27nWy66hZ5GwiC1VsZiJN7G4fSR9a5BTitmpZrB9hqTLp9ZZJZXoPlN6ywhNeb5vTfxxO5aHTI8qDmhtKuBGsbv3zGX4M7r4NpmSSvisfrXCDIOAoas1OTEoxnp4NvfgVf6bq
X-Gm-Message-State: AOJu0Yy0IbwmA6huKubMoMTxJnS15YpMR8xYHCrpAEjtzRhZwCgCR5Jd
	dE2tLj7LkOaoCmqDAQH8+aipwq+thycsANGSWQN+7O3XCMyGLVn88k137uX/YnZzSwIXlO3maaE
	nht2X02jO42UrRaBJwlOZxqFnW9Y=
X-Google-Smtp-Source: AGHT+IHuR7Iz9HHCrbPSIDe/Dh6qnQz8tqD5xO0PbRSbfqjZSk6fryeuQ5vQk6JDgn8iIjf9hU/2Re5KklxHU3kqaJk=
X-Received: by 2002:a05:6102:32d2:b0:476:d94e:da66 with SMTP id
 o18-20020a05610232d200b00476d94eda66mr2905818vss.13.1711490784977; Tue, 26
 Mar 2024 15:06:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Kaiming Huang <lightninghkm96@gmail.com>
Date: Tue, 26 Mar 2024 18:06:14 -0400
Message-ID: <CAH3=goX+Don_BBskDT0BviROgvjDGQoZ-3YfY+WMwdKsmoh+7w@mail.gmail.com>
Subject: Re: stack access issue. Re: [syzbot] [bpf?] UBSAN:
 array-index-out-of-bounds in check_stack_range_initialized
To: Andrei Matei <andreimatei1@gmail.com>
Cc: alexei.starovoitov@gmail.com, andrii@kernel.org, ast@kernel.org, 
	bpf@vger.kernel.org, daniel@iogearbox.net, eadavis@qq.com, eddyz87@gmail.com, 
	haoluo@google.com, john.fastabend@gmail.com, jolsa@kernel.org, 
	kpsingh@kernel.org, linux-kernel@vger.kernel.org, martin.lau@linux.dev, 
	netdev@vger.kernel.org, sdf@google.com, song@kernel.org, 
	syzkaller-bugs@googlegroups.com, yonghong.song@linux.dev, 
	Kaiming Huang <lightninghkm96@gmail.com>
Content-Type: text/plain; charset="UTF-8"

Hi there,

Please discard my previous email as I figured it may be beneficial to
rephrase some of the content in it for clarity.

I went across this bug using my static analysis tool as well and was
glad to find this email thread.

My understanding is that the root cause of this bug has not been
identified yet given the previous discussion in this thread.

This is the line of code that has the issue.

stype = &state->stack[spi].slot_type[slot % BPF_REG_SIZE];

Based on my analysis result, it is the part "slot_type[slot %
BPF_REG_SIZE]" may result in memory access with a negative index,
which should not be allowed. min_off and max_off are supposed to be
negative based on my understanding of the
workflow. But the spi, slot, and the index of slot_type are not
supposed to be negative.

The slot_type is defined as below:

u8 slot_type[BPF_REG_SIZE];  //BPF_REG_SIZE is 8

So the type of slot_type is u8[8].

However, the bug may alter the "slot" to be negative, say -1. Then
this would cause the result of slot %
BPF_REG_SIZE is -1. This might sound counter-intuitive as % always
gives positive results. But in C, % operation keeps the sign of
the dividend. The applied check checks whether access_size is
negative, I'm not sure whether the fix will catch
this sufficiently). Could the fix be potentially directly applied to
"slot" to ensure it is positive?

You can examine this by simply running this short piece of code. The
result of the modulo operation is -1 on my end, and that is the reason
that causes the OOB negative index -1, which was reported by the Syzkaller.

#include <stdio.h>
#define BPF_REG_SIZE 8
int main() {
    int i = -1;
    unsigned int j = i % BPF_REG_SIZE;
    printf("%d\n", j);
    return 0;
}

A more severe scenario, if possible, is when interpreting the j in the
above example
as unsigned int, aka integer overflow/wrap-around, in that case, the
value of j will be 4,294,967,295. If this is the case, then it is a
classic OOB access on the u8[8]. I don't know whether this part is feasible.

Hopefully, my illustration makes sense, please let me know if you see
any issues. Thanks.

Best regards,
Kaiming.

