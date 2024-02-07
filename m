Return-Path: <linux-kernel+bounces-55851-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E9BD84C27E
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 03:29:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CF3932853B6
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 02:29:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46C5EEEDC;
	Wed,  7 Feb 2024 02:28:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QUkclYJR"
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B577DF58;
	Wed,  7 Feb 2024 02:28:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707272936; cv=none; b=YVoY3SPHYgMLxyB/C/yUvBJEVATJExvKRQJPllVceZoC9EuMPYpTaJIY1VfRTIQGXhStROPVh7nmOCuo68UmbioAPdHT8c5eYEODLMdRy4J7NM2wvJ7zaBKDKxKEhywXBDxa6ZBY09CqIdmwLt8BIa4VmNhtVCH9j7YP9HkBw3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707272936; c=relaxed/simple;
	bh=GAzfdjQyUQZQlsw/9SQ4PdngMFFUkF5iE/vp59Bqf/I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OI2HZL7c0oaEWHYqQwnp8SyB8Ph3/1Q9MRnf4v2uPOCZUeGTf3PiC7B4PXA8ctZrSWlcGmUdklp3gRZ8T4DcRa0U5kg4nXEfl77xiHlZ900mbs03RshgGIMZiVhT5Q13CgSqiMXPHw+5yYsyLp2nC+FGuTIrqzFiGv8fxKCjD+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QUkclYJR; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-3394ca0c874so128327f8f.2;
        Tue, 06 Feb 2024 18:28:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707272929; x=1707877729; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+iVcz3g4MxUWRJae273hESZ7afXcLOcAGbcYewPQcZ4=;
        b=QUkclYJRVNI9ZVjWQCWhMYViG515va0/LqMDJe5Fy8+FVGvD31iQFm7Er7pIW7j+om
         AiBNTKFUzlqJJfUaTYBTWan1CdkobSQbgARmmBmLXqljHg30d1CIM6HHnWYeHHa9EMnK
         1LabsdWw7kwFXyoZb27cTkdk1eNVdgEBL25gY9NZKnepsds7x0KucYs3gknSLaBtvKdM
         jNBESIgmZ0tN8MrZTwYbJywp7OW4qS9ssqvLTDXCLuOaoHHL7OoK9/Be0OOKZKaTFfrf
         ZjmoXzysr3KXcqRMl0zTzKhsOaSOSoTvFKJhDwKnFa/in1v0iucjvh60v4JnK0itf1za
         JO7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707272929; x=1707877729;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+iVcz3g4MxUWRJae273hESZ7afXcLOcAGbcYewPQcZ4=;
        b=ot4+nEDtmp2jhFhsQ6JSaGM80OYGlVqrkcfrrfY2nbjvsRucCQPWU0oFW+KqH0bab6
         BWUdszJIbGAf+RZqUIi0KQyLPVFPTsLkK/HG9I8fh6lemxFkz2P7er75iv4/YxDxKEPv
         KDFJYxxjMFJDLm/8dwC7lKQXgrks40+uQIadf6tB4nmxrTKxlUXq4mnWF362Z+HtBnkq
         lyQyNRdGWiid6Ud9ybsR6LRdGM6RRVuSYt4gTtTqjvg0+ObHcITsH7q/A15eg6ZOQALt
         XfEH9/Cn7PIHFfeQ6HqVLmdnHwyjLpb+IKZbdR0AaGQBKoMuAd8mN2TH8faS6vJR0Mf2
         oSTA==
X-Forwarded-Encrypted: i=1; AJvYcCVJHYvDK8KBjG2sSQZaE6P2YVT+WoGFzeEpssFvPZFTXc6u44BY619syG8I62DkK2d9SgY8POvXwuWLk7w4oW+EjprCFNx1S8nC40myBD7CYiwpJ6voFtkcgNFPVmR6JixPKQeqsxPOWUApvETjF70q
X-Gm-Message-State: AOJu0YyFFTBd8hyjx+yDytRxAOUflXs6kHyWKnGNFESmDnyishEgi64V
	GmXo2IaWpdo4P+V5ikhey2ksFggjilnTBUiW3zkPaRdC+z2oElEnUg64VNFnTkQ+Og2hcBNVqtc
	Zx2TBViKuPANttNW+3RPfzrXvfn/bEc3mmAE=
X-Google-Smtp-Source: AGHT+IGL8HAR6YXekDae3plAm2kECL3tjVhSc5fDO//CWaL5/ApYDPvzX3p2iVkt+QMEDifp98018wjw21wAWXicRy0=
X-Received: by 2002:a5d:4a90:0:b0:33b:3d7b:9df5 with SMTP id
 o16-20020a5d4a90000000b0033b3d7b9df5mr2368927wrq.3.1707272929037; Tue, 06 Feb
 2024 18:28:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ZcDwoce6Ok25K6Dm@FVFF77S0Q05N> <xhsmhmssehp6t.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
 <CAJNi4rMiGcP4wdA=1dSOXwYXOKSCWnN8FYxBaFdaAXBqAU_ePQ@mail.gmail.com> <xhsmhjznigcdr.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
In-Reply-To: <xhsmhjznigcdr.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
From: richard clark <richard.xnu.clark@gmail.com>
Date: Wed, 7 Feb 2024 10:28:33 +0800
Message-ID: <CAJNi4rPHhEMGbv9ndKxFLdTvdN9a3HBiRkT4jtTp0bOTYvWq0Q@mail.gmail.com>
Subject: Re: Question about the ipi_raise filter usage and output
To: Valentin Schneider <vschneid@redhat.com>
Cc: Mark Rutland <mark.rutland@arm.com>, Steven Rostedt <rostedt@goodmis.org>, nico@fluxnic.net, 
	mhiramat@kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 6, 2024 at 5:39=E2=80=AFPM Valentin Schneider <vschneid@redhat.=
com> wrote:
>
> You should have access to the generic fields which include the CPU from
> which the event happens. Any of "CPU", "cpu" or "common_cpu" would match
> this.
>
> So if you're on a recent enough kernel (v6.6 or above AFAICT), you should
> be able to do something like so:
>
>   trace-cmd record -e 'ipi_raise' -f 'CPU & CPUS{7-42}' ./foo.sh
>
> If you just want to match a single CPU, or are on an older kernel, this
> should work as well:
>
>   trace-cmd record -e 'ipi_raise' -f 'CPU =3D=3D 42' ./foo.sh
>
> For example on a QEMU x86 environment:
>
>   # trace-cmd record -e 'call_function*' -f 'CPU & CPUS{3}' hackbench
>   Running in process mode with 10 groups using 40 file descriptors each (=
=3D=3D 400 tasks)
>   Each sender will pass 100 messages of 100 bytes
>   Time: 0.396
>   CPU0 data recorded at offset=3D0x738000
>       0 bytes in size
>   CPU1 data recorded at offset=3D0x738000
>       0 bytes in size
>   CPU2 data recorded at offset=3D0x738000
>       0 bytes in size
>   CPU3 data recorded at offset=3D0x738000
>       4096 bytes in size
>
>   # trace-cmd report
>   CPU 0 is empty
>   CPU 1 is empty
>   CPU 2 is empty
>   cpus=3D4
>             <idle>-0     [003]    29.704387: call_function_single_entry: =
vector=3D251
>             <idle>-0     [003]    29.704388: call_function_single_exit: v=
ector=3D251
>             <idle>-0     [003]    29.705950: call_function_single_entry: =
vector=3D251
>             <idle>-0     [003]    29.705951: call_function_single_exit: v=
ector=3D251
>             <idle>-0     [003]    29.706462: call_function_single_entry: =
vector=3D251
>             <idle>-0     [003]    29.706463: call_function_single_exit: v=
ector=3D251
>          hackbench-962   [003]    29.706501: call_function_single_entry: =
vector=3D251
>          hackbench-962   [003]    29.706502: call_function_single_exit: v=
ector=3D251
>          hackbench-955   [003]    29.706521: call_function_single_entry: =
vector=3D251
>          hackbench-955   [003]    29.706522: call_function_single_exit: v=
ector=3D251
>             <idle>-0     [003]    30.101812: call_function_single_entry: =
vector=3D251
>             <idle>-0     [003]    30.101814: call_function_single_exit: v=
ector=3D251
>             <idle>-0     [003]    30.101897: call_function_single_entry: =
vector=3D251
>             <idle>-0     [003]    30.101898: call_function_single_exit: v=
ector=3D251
>             <idle>-0     [003]    30.101985: call_function_single_entry: =
vector=3D251
>             <idle>-0     [003]    30.101986: call_function_single_exit: v=
ector=3D251
>             <idle>-0     [003]    30.102072: call_function_single_entry: =
vector=3D251
>             <idle>-0     [003]    30.102072: call_function_single_exit: v=
ector=3D251
>             <idle>-0     [003]    30.102161: call_function_single_entry: =
vector=3D251
>             <idle>-0     [003]    30.102161: call_function_single_exit: v=
ector=3D251
>             <idle>-0     [003]    30.102250: call_function_single_entry: =
vector=3D251
>             <idle>-0     [003]    30.102251: call_function_single_exit: v=
ector=3D251
>             <idle>-0     [003]    30.102372: call_function_single_entry: =
vector=3D251
>             <idle>-0     [003]    30.102372: call_function_single_exit: v=
ector=3D251
>
>
>   CPU 0 is empty
>   CPU 1 is empty
>   CPU 2 is empty
>   cpus=3D4
>           <idle>-0     [003]  1067.718304: call_function_single_entry: ve=
ctor=3D251
>           <idle>-0     [003]  1067.718309: call_function_single_exit: vec=
tor=3D251
>
> and that behaves the same as
>
>   trace-cmd record -e 'call_function*' -f 'CPU =3D=3D 3' hackbench
>
Thanks, # trace-cmd record -e 'ipi' -f 'CPU=3D=3D10 || CPU=3D=3D11' -f
'reason=3D=3D"Function call interrupts"' works:
CPU0 data recorded at offset=3D0x336000
    0 bytes in size
CPU1 data recorded at offset=3D0x336000
    0 bytes in size
CPU2 data recorded at offset=3D0x336000
    0 bytes in size
CPU3 data recorded at offset=3D0x336000
    0 bytes in size
CPU4 data recorded at offset=3D0x336000
    0 bytes in size
CPU5 data recorded at offset=3D0x336000
    0 bytes in size
CPU6 data recorded at offset=3D0x336000
    0 bytes in size
CPU7 data recorded at offset=3D0x336000
    0 bytes in size
CPU8 data recorded at offset=3D0x336000
    0 bytes in size
CPU9 data recorded at offset=3D0x336000
    0 bytes in size
CPU10 data recorded at offset=3D0x336000
    4096 bytes in size
CPU11 data recorded at offset=3D0x337000
    4096 bytes in size

# trace-cmd report
CPU 0 is empty
CPU 1 is empty
CPU 2 is empty
CPU 3 is empty
CPU 4 is empty
CPU 5 is empty
CPU 6 is empty
CPU 7 is empty
CPU 8 is empty
CPU 9 is empty
cpus=3D12
          insmod-8519  [010] 170847.580062: ipi_raise:
target_mask=3D00000000,00000bff (Function call interrupts)
          <idle>-0     [011] 170847.580070: ipi_entry:
(Function call interrupts)
          <idle>-0     [011] 170847.580071: ipi_exit:
(Function call interrupts)
          insmod-8519  [010] 170847.580078: ipi_raise:
target_mask=3D00000000,00000bff (Function call interrupts)
          <idle>-0     [011] 170847.580080: ipi_entry:
(Function call interrupts)
          <idle>-0     [011] 170847.580080: ipi_exit:
(Function call interrupts)
          insmod-8519  [010] 170847.580282: ipi_raise:
target_mask=3D00000000,00000002 (Function call interrupts)
          insmod-8519  [010] 170847.580329: ipi_raise:
target_mask=3D00000000,00000800 (Function call interrupts)
          <idle>-0     [011] 170847.580331: ipi_entry:
(Function call interrupts)
          <idle>-0     [011] 170847.580343: ipi_exit:
(Function call interrupts)

BTW: where does 12 come from in 'cpus=3D12' :-)

