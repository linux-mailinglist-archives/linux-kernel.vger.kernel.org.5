Return-Path: <linux-kernel+bounces-119987-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B38F988CFBF
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 22:11:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E5CB01C3A0D4
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 21:11:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77DB213D625;
	Tue, 26 Mar 2024 21:11:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bGlSc53g"
Received: from mail-vs1-f53.google.com (mail-vs1-f53.google.com [209.85.217.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FB5D12AAF3;
	Tue, 26 Mar 2024 21:11:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711487477; cv=none; b=SMZ6U7jIenAMHhRnK/567M6QXi/bd1cRgi8EtGg2oU1jdek033We5js5rfcUg+6PciSb6y5UeoD+Dm2vE9mHmTpFkS8sKoBYDCXnXpzBe6MmZheWDqih+foh5XAfyHwKJvk1F9eB0ADYUtTtzs/UPMD5KZj2b9XbjdXSFF10Rng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711487477; c=relaxed/simple;
	bh=DhbIwGimzO1Ys/eDgtivAIaXcxFjjx+5Qj98m0RzjXQ=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=OLLWA1+PMfhryQ/iBZnlwQn4BzSuUjzoP9PzVrkpAKbma+vDQOm0AjuwhVSrZwkSAqyKikGptRMZG7dgWBy5Ou3iwBqPbC5c5cfucvpuEW5jkPpBvCKfk/bkOf6xWr7mupemDm7vtewbkX/WwD2T523WTDicDLoXT8s3Zl1v3jg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bGlSc53g; arc=none smtp.client-ip=209.85.217.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f53.google.com with SMTP id ada2fe7eead31-476757820ceso1831622137.1;
        Tue, 26 Mar 2024 14:11:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711487475; x=1712092275; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=C4E86kR2DKRyNfP7j7T5NXYDBgBKUpRjZk7CC48kM2A=;
        b=bGlSc53gJffjewX7VH7dFLnSgwfdMIj2KUiyo32cAQ7qSl4+BaUmfX7esZKgCo+x5Z
         7lbGRPcQf6+fFUNAhHhR725MNz/0V1v/oKizKaxl4LJiwdgTTfP2qlMYwIVOqLM9iWal
         KKafF08XPVi6TMIekFYO2Lyp07JKkdOU7//cub+V3wZMuch1ByDZceLOwugxlj9JSMbY
         1C1Re36iBRw+QZ1rf74GnY7iB5IORhv+FdWYE6pCHTIEUATOs43zbNX4J8E2bYrTCyjh
         tqQUX0IbncN6UNo1uibSx2rTSLjtt/Y7df0HHFpYo4OaL9pJAk/Vux2AJF0jsfQ26xO3
         616w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711487475; x=1712092275;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=C4E86kR2DKRyNfP7j7T5NXYDBgBKUpRjZk7CC48kM2A=;
        b=AGTszqpYA3a0sTkxDntWEURjLc+t4O4Xmo+8IbNZHORi32+k/6+fLGLvBw4QtpNMUu
         izaeCh/AmBTAyw/YZ3MwrwZmsmdVpchQmlbeCfVU5/EpCFzWA1NTw4OLBeRzLq3gHTU/
         5chGxjght53YAAObYKdjUs5ZYAy4TIR1nAkZc1JGeU6CslmdWjjXq7t7egblmeIbCzq+
         SNkw56xtGhtarecuNmBIMgcwcQrfC12AHqjt9EfmIp6g5PgbBNaGZ9dU8ndkdyFj3YCI
         BBMn3NhuHDI+JfivDbYEytNLcOn2XM5b8VExg+kUc7Iaw55oLT2iC+8pcQMldJFDdoCf
         axDw==
X-Forwarded-Encrypted: i=1; AJvYcCUKIAXrZaIm1Ruf6XN+fWJuusebhSvjsv481Y3Ua+tpDEKCbYPbEyq8kCkrhoX6OkJ5UBarifPK7RI2B1b5JGoK8N95RD38ilqhbX/WaJHAfsI0rAljzN1Ntbm7DVqg692onvC+i+mXOp13eOX/NZpyMnyysjXsna6H
X-Gm-Message-State: AOJu0YzYljIT7o8VE7pc3Cio2u9dav+xUdrhcbnkEyk7rAVNYg+0mXAc
	3I5mb5NM1Mv87IWseseR/ef29q+lOVjQTNENCLPb70vaEgp+yBHeocN/YhocpZP0jBp7T7NnOn/
	6xPBPMOmvpXvTgnFM8gRq3gCjtlY=
X-Google-Smtp-Source: AGHT+IE7IPPA6+eiifPNtX5vhNKID0Vd5arCLCtKWkE363s0aP8X5jekc/off5y2gyHlDp/JMEXXN7dlJEf7zml3Qc4=
X-Received: by 2002:a05:6102:12d8:b0:478:23c8:1c23 with SMTP id
 jd24-20020a05610212d800b0047823c81c23mr950756vsb.14.1711487475103; Tue, 26
 Mar 2024 14:11:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Kaiming Huang <lightninghkm96@gmail.com>
Date: Tue, 26 Mar 2024 17:11:04 -0400
Message-ID: <CAH3=goWGETBPj+-qcKo4E+sXZv1pT+UeVhXnv-q9N4Yagb1m-g@mail.gmail.com>
Subject: Re: stack access issue. Re: [syzbot] [bpf?] UBSAN:
 array-index-out-of-bounds in check_stack_range_initialized
To: Andrei Matei <andreimatei1@gmail.com>
Cc: alexei.starovoitov@gmail.com, andrii@kernel.org, ast@kernel.org, 
	bpf@vger.kernel.org, daniel@iogearbox.net, eadavis@qq.com, eddyz87@gmail.com, 
	haoluo@google.com, john.fastabend@gmail.com, jolsa@kernel.org, 
	kpsingh@kernel.org, linux-kernel@vger.kernel.org, martin.lau@linux.dev, 
	netdev@vger.kernel.org, sdf@google.com, song@kernel.org, 
	syzkaller-bugs@googlegroups.com, yonghong.song@linux.dev
Content-Type: text/plain; charset="UTF-8"

Hi there,

I went across this bug using my static analysis tool as well and was
glad to find this email thread.

My understanding is that the root cause of this bug has not been
identified yet given the previous discussion in this thread.

This is the line of code that has the issue.

stype = &state->stack[spi].slot_type[slot % BPF_REG_SIZE];

Based on my analysis result, it is the part "slot_type[slot %
BPF_REG_SIZE]" may result in memory access with a negative index,
which should not be allowed. spi (as well as min_off, max_off, and
slot) is(are) supposed to be negative based on my understanding of the
workflow. But the index of slot_type is not supposed to be negative.

The slot_type is defined as below:

u8 slot_type[BPF_REG_SIZE];  //BPF_REG_SIZE is 8

So the type of slot_type is u8[8].

However, given "slot" can be negative, say -1. The result of slot %
BPF_REG_SIZE is -1. This might sound counter-intuitive as % always
gives positive results. But in C, % operation keeps the sign of
dividend (and thus that's why I'm not sure whether the fix will catch
this).

You can examine this by simply running this short piece of code. The
result of the modulo operation is -1 on my end, and that is the reason
that causes the OOB negative index, and this would be an off-by-one on
the u8[8].

#include <stdio.h>
#define BPF_REG_SIZE 8
int main() {
    int i = -1;
    unsigned int j = i % BPF_REG_SIZE;
    printf("%d\n", j);
    return 0;
}

A more severe scenario is when interpreting the j in the above example
as unsigned int, aka integer overflow/wrap-around, in that case, the
value of j will be 4,294,967,295. If it is the case, then it is a
classic OOB access on the u8[8].

Hopefully my illustration makes sense, please let me know if you see
any issues. Thanks.

Best regards,
Kaiming.

