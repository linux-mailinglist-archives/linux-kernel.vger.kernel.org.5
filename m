Return-Path: <linux-kernel+bounces-73931-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1414A85CDAC
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 03:04:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4459E1C20EC6
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 02:04:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2298C5666;
	Wed, 21 Feb 2024 02:04:51 +0000 (UTC)
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D7E54C86;
	Wed, 21 Feb 2024 02:04:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708481090; cv=none; b=KhFK22caR1aVDKg55E2W0CP1hViqG6O+bykxxBSMDI9pzXqFATxfH3LIyTbp+4OHn9ki1+OohaF8NauCxswGQ20Tb1yeouEo6XLs3lzbSHPw+dDv03VfienSX6DbR80ifjUpSkZmbLr4DHvbR79dlq/Cn3J2ktSbBCHVzyjTIFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708481090; c=relaxed/simple;
	bh=zoLNIyU6H5r0VawvX8GIESdSRbRovZ8tl3Az1EnVhKA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=c8vQ9mHm/cISN6YhlYp1T/cJ8KEE2dupmaAz1rmR7TUsq8FRD6r26o4sbSM/09SrPL6h4zb5dKStMRxdMBIBSYEtJTeRtlWu1HY2+W6B9H5BwdPNqUGfgQky5cMzUGiR035BRrFxl4+74yi2sVlJallAxQcZgxC+cK1eCsNIL8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-299372abcfeso3147568a91.1;
        Tue, 20 Feb 2024 18:04:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708481088; x=1709085888;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=J0ybMa3hOnERERDnqEPR8wrCPlA+a/LBcKmgYHmGB3Y=;
        b=DKUZd2/ZmQQiLycNb7Ebz5ro6ZHMS53VeAj5ny+mICRrGR/rccVBfFGuBhgmo7Rkck
         BJlsTbaa4lqbrJWFs+lOsbMWmAaM5qp8uPK3XcYTKI7ukuJFdfYJR2x2KYw042apBJgh
         qDmD37xFw8FFeRnDQnNJ6xOTKufk/GHymAjEOakR90sgvDzWUZWgZkmw5SHFNs83YuPI
         LM1NlGg5YgO6hHb/GCqRLVVNWdLl7sjFxDIPgv42xN31cFemn8eH6myZMiKd+C8REeLF
         EluUY1NXlemRlWVqPPRBrH5Zm8kAFk5TVA8+wpTPKG3VeTzYhlphwWzL1IsQep3dhr4Y
         kPug==
X-Forwarded-Encrypted: i=1; AJvYcCXzRMzcETPdyF1qsFDRte2SE91xp96oyG4WbkrBam7aERANXejwXLS1DnH3za79/H3GDwu0SosyfE/KIYV5AA90xhBu+xTYHhXnZAJHzFvu1rUPtmoLUfVPMhr7ezyhMtDJS5ERFcSUXLj0UwtYdA==
X-Gm-Message-State: AOJu0Yyr6xcLYM0hnHjuBX1e9J4ebgRBIJyUlV4dUJw9Qr6VCcwJ8WaI
	Jnk5diRNgAmdrt3pKA2ossnj44qssDISrmUYGGg19FNS+KTACR4f5C0TpDtVDddxMZs682cr5LM
	W2YqJeTh/x053YKtgKSDe3ob6914=
X-Google-Smtp-Source: AGHT+IEZo0nMICe6f0BltzaRpHEaOEBr9f+j59VnoZhsA+S85FA+1x7YAXz4vFUvaLecPeCbfz+f+Bsrb8zzAVJPY94=
X-Received: by 2002:a17:90b:4b4e:b0:299:7f65:7cd1 with SMTP id
 mi14-20020a17090b4b4e00b002997f657cd1mr12507853pjb.9.1708481088545; Tue, 20
 Feb 2024 18:04:48 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240217074046.4100789-1-changbin.du@huawei.com>
 <20240217074046.4100789-3-changbin.du@huawei.com> <9699d30b-f6cb-44d5-ae58-0bdefe3f24eb@intel.com>
In-Reply-To: <9699d30b-f6cb-44d5-ae58-0bdefe3f24eb@intel.com>
From: Namhyung Kim <namhyung@kernel.org>
Date: Tue, 20 Feb 2024 18:04:36 -0800
Message-ID: <CAM9d7cjZO+URmNE0SQBrFR5-rsLobNpYdiT4s=5svCUwoYbRVQ@mail.gmail.com>
Subject: Re: [PATCH v8 2/5] perf: util: use capstone disasm engine to show
 assembly instructions
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: Changbin Du <changbin.du@huawei.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, Andi Kleen <ak@linux.intel.com>, 
	Thomas Richter <tmricht@linux.ibm.com>, changbin.du@gmail.com, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Adrian and Changbin,

On Sun, Feb 18, 2024 at 10:33=E2=80=AFPM Adrian Hunter <adrian.hunter@intel=
com> wrote:
>
> On 17/02/24 09:40, Changbin Du wrote:
> > Currently, the instructions of samples are shown as raw hex strings
> > which are hard to read. x86 has a special option '--xed' to disassemble
> > the hex string via intel XED tool.
> >
> > Here we use capstone as our disassembler engine to give more friendly
> > instructions. We select libcapstone because capstone can provide more
> > insn details. Perf will fallback to raw instructions if libcapstone is
> > not available.
> >
> > The advantages compared to XED tool:
> >  * Support arm, arm64, x86-32, x86_64 (more could be supported),
> >    xed only for x86_64.
> >  * Immediate address operands are shown as symbol+offs.
> >
> > Signed-off-by: Changbin Du <changbin.du@huawei.com>
>
> This is the only patch of V8 that made it to my inbox, Namhyung
> also mentioned problems receiving V7, but the patches are on lore.
>
> For whole patch set:
>
> Reviewed-by: Adrian Hunter <adrian.hunter@intel.com>

I found it in my spam box, maybe there was a change in the spam
filtering logic.

Thanks,
Namhyung

