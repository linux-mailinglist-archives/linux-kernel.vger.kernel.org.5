Return-Path: <linux-kernel+bounces-28323-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AAC482FCEF
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 23:34:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 36D3C1F2974A
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 22:34:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5469C3FB1F;
	Tue, 16 Jan 2024 21:55:09 +0000 (UTC)
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 937201D6BD;
	Tue, 16 Jan 2024 21:55:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705442108; cv=none; b=H3LL6eV99xZdc3p6xaoS4WzOXrZj5bkWJuP3qmSafP5zWDlPwxYWsuvPCP5C9EPpIA2x8TrNiew2cpey2tGLyl16lKA/43e782MjEEsqva5w94kZkh7NhbDa39lGLaOzOYRbUUgJG9gK7NThwVV1cvL+uv4yv0/wQ2C76L6N5r0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705442108; c=relaxed/simple;
	bh=1OQ9ocuUq7f0RxHOajJIIjyI25WuDNYx8YfwH07MV3c=;
	h=Received:X-Google-DKIM-Signature:X-Gm-Message-State:
	 X-Google-Smtp-Source:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:Message-ID:Subject:To:Cc:Content-Type:
	 Content-Transfer-Encoding; b=kkNeDqo932DtB7HpLjaTcD26gbHUzHtNEfOc9kgH1rTXp1OgCyYWQ1uzlRAl0eotkgbPGUWPbPkpgigrkZ8+mMTOeqF9BvtsP1XKbmoBhfZSEknc+9qpgM1b4v4pTWh3Ou1lqIxF8Ro2Oxt5hfzCgHM3ZvGz88DmLwV7TooYNa4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-28ff6445faaso74920a91.1;
        Tue, 16 Jan 2024 13:55:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705442107; x=1706046907;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oIZzUXfeyB0JSREarHHCmZzOdwaXVpbV3/qdV2TmR9M=;
        b=fuF47ZrkTV9lSdkXByWd4ze23W1bJwWLQlJw1BdfQNX0bCqGP0c+P/F4a3AhZl9q+5
         eUHfT5e++XcOo5CFtkd0ZCsww9//QF3DBW2RZdv2tg/sD4wG3A1TM9ja8nSYylWqauCM
         RDE7gfyqEQ81EowNtPNGtsUvud/qNkaijUjQzWC8mLi3sLay1nq95P2YaTnuAdQayRgW
         RX8L9r1OOOb6SP7IR2Zc2IoVe3H7CMgPKUl0dhxvoqOsI79jwT1zuJ2ZWTJVywmwfX75
         w5tpovumDi+gzYcCbD2a0RKNlZYIxYWPar55lcg3oPkjLYAcdnAwxNrIP8D/s+aZjzb9
         76Pw==
X-Gm-Message-State: AOJu0YzkzBO1inFZl3S9AjXZWtzZ/JPXE5c0TfVv5wb6MSRMw2ljlZN8
	xDWo7blnacA4MVraPpfbp2mKuWA2tRdhaecj6L0=
X-Google-Smtp-Source: AGHT+IHWox2bKBt1g7JKNDQQ4hF1U1tIzFNGVfikE8a/hzNtDSUeCSVd7E40obU/1Wz4LLybEUA64Ah5vxpb3zLCGg8=
X-Received: by 2002:a17:90b:314a:b0:28c:91a5:1e33 with SMTP id
 ip10-20020a17090b314a00b0028c91a51e33mr5272652pjb.12.1705442106929; Tue, 16
 Jan 2024 13:55:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240112120737.1995575-1-james.clark@arm.com>
In-Reply-To: <20240112120737.1995575-1-james.clark@arm.com>
From: Namhyung Kim <namhyung@kernel.org>
Date: Tue, 16 Jan 2024 13:54:55 -0800
Message-ID: <CAM9d7ciUkjeU1+vzb7ydKCcU=Pybu-qVWFG2Tr+QUPDjJbGNVw@mail.gmail.com>
Subject: Re: [PATCH] perf test: Fixed masked error condition in perf data
 convert test
To: James Clark <james.clark@arm.com>
Cc: linux-perf-users@vger.kernel.org, ilkka@os.amperecomputing.com, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Athira Rajeev <atrajeev@linux.vnet.ibm.com>, Anup Sharma <anupnewsmail@gmail.com>, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 12, 2024 at 4:07=E2=80=AFAM James Clark <james.clark@arm.com> w=
rote:
>
> The test does set -e, so any errors go straight to the exit handler,
> where it returns err=3D0 (success). Fix it by leaving err=3D1 from the
> beginning and only set the success code if it ran all the way to the end
> without errors.
>
> Also remove the exit code argument from the last exit because it doesn't
> do anything, it's always replaced by err in the exit handler.
>
> Fixes: 68d124182610 ("perf test: Add test validating JSON generated by 'p=
erf data convert --to-json'")
> Signed-off-by: James Clark <james.clark@arm.com>

Acked-by: Namhyung Kim <namhyung@kernel.org>

Thanks,
Namhyung


> ---
>  tools/perf/tests/shell/test_perf_data_converter_json.sh | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
>
> diff --git a/tools/perf/tests/shell/test_perf_data_converter_json.sh b/to=
ols/perf/tests/shell/test_perf_data_converter_json.sh
> index c4f1b59d116f..1781b7215c11 100755
> --- a/tools/perf/tests/shell/test_perf_data_converter_json.sh
> +++ b/tools/perf/tests/shell/test_perf_data_converter_json.sh
> @@ -4,7 +4,7 @@
>
>  set -e
>
> -err=3D0
> +err=3D1
>
>  shelldir=3D$(dirname "$0")
>  # shellcheck source=3Dlib/setup_python.sh
> @@ -36,7 +36,6 @@ test_json_converter_command()
>                 echo "Perf Data Converter Command to JSON [SUCCESS]"
>         else
>                 echo "Perf Data Converter Command to JSON [FAILED]"
> -               err=3D1
>                 exit
>         fi
>  }
> @@ -49,7 +48,6 @@ validate_json_format()
>                         echo "The file contains valid JSON format [SUCCES=
S]"
>                 else
>                         echo "The file does not contain valid JSON format=
 [FAILED]"
> -                       err=3D1
>                         exit
>                 fi
>         else
> @@ -62,4 +60,7 @@ validate_json_format()
>  test_json_converter_command
>  validate_json_format
>
> -exit ${err}
> +# Set -e is on, so it was only successful if it ran up to this point.
> +# Therefore only set err=3D0 here.
> +err=3D0
> +exit
> --
> 2.34.1
>

