Return-Path: <linux-kernel+bounces-31593-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 51431833072
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 22:50:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 845821C23DC5
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 21:50:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84AD55821A;
	Fri, 19 Jan 2024 21:49:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h/VojE2L"
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58BE856475;
	Fri, 19 Jan 2024 21:49:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705700997; cv=none; b=letQU90pP/n7PzrsCHHlF0vpHFAV+IjkldKva/LWmAmok5W8yNbcMUY8pBtGl4nonfNkdqBxcNf0fAhNwDg4xZoV1qynfjiGanAHCoFhXrjL6W5MjZ6p/7Jwbz/yQf7GkopoUQVJmX4d8F9eOP5o3OGWuQVuw4zZbw9OE3Vyc2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705700997; c=relaxed/simple;
	bh=koIw2S+oPoZlSQkpE/YFp4fyt/Afka0yTeTXeAzdT+8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DIBllcqZvvOYKs5wjDV5SHK+nAKoywhT2FvlZdI4iQdBx1vQ+r7keoGNQ0RCt/VNjg6C2cP5WcT006ugmflQHH6Jv0lFsu/tKDM7klFn3/aTRFDamxf9U5t/GB/lv20y5IAmubkkLFtgk5ArlUrTgHkVeuKCOb67/zR9DDYvpUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h/VojE2L; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-28e8c930c01so772444a91.0;
        Fri, 19 Jan 2024 13:49:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705700995; x=1706305795; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RjHUcTg8MND0WwJABplo3iwNyI2eRYawZwiqR4g8PDM=;
        b=h/VojE2LdeKIK/quQZvI3gYmU5FhWY2VRBLSvusv3vRg15WKDWCaq1p9z32ARn0mN+
         q+0D3X39/Wru2vQbU55jxKHNksqxyI4CiZYUQyhyMHZi7XLZtjugWM/aS5iACwf8Xctq
         ONrGXuzxM/K2WO8Gv6krG+pJWuLeWcMLhjwgsBtWdT9qhKb+bRtAFfp5xnDGo/yfP8Ld
         9KAxi9jGg6vJ2Edtf8aBXJ+VoRSs23n2NonQzMD9KgrQJg6BDiipfjyKWz9lQvHbMkH2
         EdcXN0MixrOBWxSekLYcnADEGM2o+bj0xBjPPKD+nI5LPDj2aif+/TxENog9LczPLi1V
         1I5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705700995; x=1706305795;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RjHUcTg8MND0WwJABplo3iwNyI2eRYawZwiqR4g8PDM=;
        b=rEEA9Z8D6gTzZdWVR5pUZ6Z8x3ttlW8+U0VKNsWCqnZCLmzk8+krTu9juD7MA8wtsM
         CM5NZzP221knWzPjGO5dzkCOc+aCeJPp8BqYkyoRMeumTVwHs83wkq0sTHF9d0lj5Hk8
         de/n4V49gwDuDNjqTIdIrH5CCsAAqith17K3WNviYYnt7vYLeLL55PKNf5CEF9W159/c
         srFv/BsRxiLY2a+d3MArmy4HmofX6kkR9QGx9Gfy5KHQNRnsxyAMMXDrkSGGZCR/05n6
         9LP9PU9wgostFcmjQ+90GLWRVBzS/94lXHfIe9fsBL/ULDPNlQeXor/rthHWDn1vWAe2
         nwdA==
X-Gm-Message-State: AOJu0YygDvsPCRuwxYjNIklt1TFssyk21ns4XUmh9cXEAMXCk8wYzy9L
	wZpkrwhWAHtKPKDdwh9y2rX/PIMQKU9nHI1irjQRO2xW0DzYANk9bqiFccXgsLHf21P/C1g4yjE
	GgB6VolYp/tJ1kZLjX2adcZk2ki4=
X-Google-Smtp-Source: AGHT+IE6wVpzveGTzO3CdgWIODW3G+6KTz/7Iq/DU+pLquW4T8Z0lu6TFZiCEXagGtDOXVwuWHp6HKUWflWTVEHHGYw=
X-Received: by 2002:a17:90b:3649:b0:28d:290d:8d67 with SMTP id
 nh9-20020a17090b364900b0028d290d8d67mr459948pjb.29.1705700995564; Fri, 19 Jan
 2024 13:49:55 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240115144727.499349-1-tmricht@linux.ibm.com>
In-Reply-To: <20240115144727.499349-1-tmricht@linux.ibm.com>
From: Namhyung Kim <namhyung@gmail.com>
Date: Fri, 19 Jan 2024 13:49:44 -0800
Message-ID: <CAM9d7cjCK-p1VL4Evt6ZwpYz_=wTS=8oAOvgSL3ejO9L5m24hQ@mail.gmail.com>
Subject: Re: [PATCH] perf test: Fix test case perf script tests on s390
To: Thomas Richter <tmricht@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	acme@kernel.org, irogers@google.com, acme@redhat.com, svens@linux.ibm.com, 
	gor@linux.ibm.com, sumanthk@linux.ibm.com, hca@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello,

On Mon, Jan 15, 2024 at 6:50=E2=80=AFAM Thomas Richter <tmricht@linux.ibm.c=
om> wrote:
>
> In linux next repo, test case 'perf script tests' fails on s390.
> The root case is a command line invocation of perf record with
> call-graph information. On s390 only dwarf formatted call-graphs
> are supported and only on software events.
>
> Change the command line parameters fors s390.
>
> Output before:
>  # perf test 89
>  89: perf script tests              : FAILED!
>  #
>
> Output after:
>  # perf test 89
>  89: perf script tests              : Ok
>  #
>
> Fixes: 0dd5041c9a0e ("perf addr_location: Add init/exit/copy functions")
> Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
> Cc: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/tests/shell/script.sh | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
>
> diff --git a/tools/perf/tests/shell/script.sh b/tools/perf/tests/shell/sc=
ript.sh
> index 5ae7bd0031a8..a6a09ef16e06 100755
> --- a/tools/perf/tests/shell/script.sh
> +++ b/tools/perf/tests/shell/script.sh
> @@ -54,7 +54,14 @@ def sample_table(*args):
>  def call_path_table(*args):
>      print(f'call_path_table({args}')
>  _end_of_file_
> -       perf record -g -o "${perfdatafile}" true
> +       case $(uname -m)
> +       in s390x)
> +               cmd_flags=3D"--call-graph dwarf -e cpu-clock"
> +       ;; *)
> +               cmd_flags=3D"-g"
> +       esac

I think this is unusual.  Maybe something like this?

    case $(uname -m) in
    s390x)
        cmd_flags=3D"...";;
    *)
        cmd_flags=3D"...";;
    esac

Thanks,
Namhyung


> +
> +       perf record $cmd_flags -o "${perfdatafile}" true
>         perf script -i "${perfdatafile}" -s "${db_test}"
>         echo "DB test [Success]"
>  }
> --
> 2.43.0
>
>

