Return-Path: <linux-kernel+bounces-93420-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8495E872F7F
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 08:21:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 40F30281C4E
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 07:21:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 083305C900;
	Wed,  6 Mar 2024 07:20:59 +0000 (UTC)
Received: from mail-oi1-f182.google.com (mail-oi1-f182.google.com [209.85.167.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BD075C8FB;
	Wed,  6 Mar 2024 07:20:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709709658; cv=none; b=MVthmyQ0Up3liCWOImwQR6FzvIu21k6NBLJYTueMjJkFMduNw5kzSR6BqNXO7HzevB+I1n/gUVeKJRnaABsh4yulozzTZeoPajA/Skt7CROm2EO7407hfNeGfpDtc51ZuIcV8qv+4gPKNgo0iiWHmQkYLaYKlPH0UC3YL/PraB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709709658; c=relaxed/simple;
	bh=L5mJ15rIwi4rFnSttjgMuyaksPH2SXNe2fdObsvQezc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lyEvd4Onu92Mr/wiZf/6JIVNmc/aPe4J4GswSVJbCnp3VRfLBWCLj5hJpTib+wgLFoQj8NGKaVpFu6X2QqM6yls+voqcnAZAOf7icPLpPXguUMT1+XhP7lSYMC2EPWe3wFHKOQiTKwNaKq0fudhwPVndct5aQAXqUgKupG5xP9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.167.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f182.google.com with SMTP id 5614622812f47-3c1e6c32a55so2141047b6e.2;
        Tue, 05 Mar 2024 23:20:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709709656; x=1710314456;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tQuWM38UhwK25qNu10dyRUtuaAMUFqlAh3c+JZ+R14g=;
        b=suhcAnIDXoZR8kRqFKLz2CqYpRKuP1td9+nQBDhhNsAUda3e5yCxoFnNu6X6ZvJgnA
         Mcn5ErsoYP833Orxs4shxao6zZ6XfjQ9qxnapE5ZIbyjit5zkRXmTB5VvMCD/RRRZcId
         fav8IqqD6EzSrT0b62nfKOYgl2wOJRqpJ5jnGvSuaJj0Ne78Z9V8FuoJmUWBSwUB1x0k
         RBmgO9FEtqQuVEAHsrbPq3nbyoohQW4XeCcMjFyJLwDbI188aWDNNJn6fTzxS9HQKqQa
         WXRx4Osjrfp+8q+Vn5tAWa277pn3n8wVEhKmFs6QZEHZpz5aqbieRIBwMumdS7LtFZLE
         /Mdg==
X-Forwarded-Encrypted: i=1; AJvYcCXAVvH2/1oAc33bXJtgdXYDowV2Tb/RUxgZCr8OLsoBM4AP6t7r7SYW+I1bcJGEZsdOwV9ngY8TqfQypJppD7+FoXBrLFOmR42DaIPUSJhMF2sr3Ey6Nq6VkPn2J2njVC887/spyaa4aYR9sQj3Iw==
X-Gm-Message-State: AOJu0Yx6DIbsUsFIusCGWsKK0SbLmJ2RJYYlkIFhCuneEHuu5PGIFfb0
	Bvma0dx4xfnGPq/r7nC0bav9NWp16l8dsaZz8LeXPhHPb0PjsWgrr9Q+Z6U3n3rsJSG9D1q0fcb
	NMUuP57tQ5sAuyIf59N1Yz+EnOeY=
X-Google-Smtp-Source: AGHT+IEQu81YATsoQvFr1ILkfjqyKIrNCHr3xlQen+zHHAtM0aU+9He5ISMOWb2a4SUuaI0u49syb3WlnXCmwhWwrvk=
X-Received: by 2002:a05:6808:2817:b0:3c2:1944:e39b with SMTP id
 et23-20020a056808281700b003c21944e39bmr1579254oib.17.1709709656039; Tue, 05
 Mar 2024 23:20:56 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240302005950.2847058-1-irogers@google.com> <20240302005950.2847058-6-irogers@google.com>
In-Reply-To: <20240302005950.2847058-6-irogers@google.com>
From: Namhyung Kim <namhyung@kernel.org>
Date: Tue, 5 Mar 2024 23:20:44 -0800
Message-ID: <CAM9d7cjVE=gH8A4zzsUFwLibgHy=3C71UnFe5SEu-RDFTOWkDw@mail.gmail.com>
Subject: Re: [PATCH v2 05/12] perf jevents: Support parsing negative exponents
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, John Garry <john.g.garry@oracle.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Jing Zhang <renyu.zj@linux.alibaba.com>, 
	Thomas Richter <tmricht@linux.ibm.com>, James Clark <james.clark@arm.com>, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	Andi Kleen <ak@linux.intel.com>, Kajol Jain <kjain@linux.ibm.com>, 
	Sandipan Das <sandipan.das@amd.com>, Ravi Bangoria <ravi.bangoria@amd.com>, 
	Perry Taylor <perry.taylor@intel.com>, Samantha Alt <samantha.alt@intel.com>, 
	Caleb Biggers <caleb.biggers@intel.com>, Weilin Wang <weilin.wang@intel.com>, 
	Edward Baker <edward.baker@intel.com>, Stephane Eranian <eranian@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 1, 2024 at 5:00=E2=80=AFPM Ian Rogers <irogers@google.com> wrot=
e:
>
> Support negative exponents when parsing from a json metric string by
> making the numbers after the 'e' optional in the 'Event' insertion fix
> up.
>
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/pmu-events/metric.py      | 2 +-
>  tools/perf/pmu-events/metric_test.py | 4 ++++
>  2 files changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/tools/perf/pmu-events/metric.py b/tools/perf/pmu-events/metr=
ic.py
> index 847b614d40d5..31eea2f45152 100644
> --- a/tools/perf/pmu-events/metric.py
> +++ b/tools/perf/pmu-events/metric.py
> @@ -573,7 +573,7 @@ def ParsePerfJson(orig: str) -> Expression:
>    # a double by the Bison parser
>    py =3D re.sub(r'0Event\(r"[xX]([0-9a-fA-F]*)"\)', r'Event("0x\1")', py=
)
>    # Convert accidentally converted scientific notation constants back
> -  py =3D re.sub(r'([0-9]+)Event\(r"(e[0-9]+)"\)', r'\1\2', py)
> +  py =3D re.sub(r'([0-9]+)Event\(r"(e[0-9]*)"\)', r'\1\2', py)

I don't understand how it can handle negative numbers.
Why isn't it like Event\(r"(e-?[0-9]+)"\) ?

Thanks,
Namhyung


>    # Convert all the known keywords back from events to just the keyword
>    keywords =3D ['if', 'else', 'min', 'max', 'd_ratio', 'source_count', '=
has_event', 'strcmp_cpuid_str']
>    for kw in keywords:
> diff --git a/tools/perf/pmu-events/metric_test.py b/tools/perf/pmu-events=
/metric_test.py
> index ee22ff43ddd7..8acfe4652b55 100755
> --- a/tools/perf/pmu-events/metric_test.py
> +++ b/tools/perf/pmu-events/metric_test.py
> @@ -61,6 +61,10 @@ class TestMetricExpressions(unittest.TestCase):
>      after =3D before
>      self.assertEqual(ParsePerfJson(before).ToPerfJson(), after)
>
> +    before =3D r'a + 3e-12 + b'
> +    after =3D before
> +    self.assertEqual(ParsePerfJson(before).ToPerfJson(), after)
> +
>    def test_IfElseTests(self):
>      # if-else needs rewriting to Select and back.
>      before =3D r'Event1 if #smt_on else Event2'
> --
> 2.44.0.278.ge034bb2e1d-goog
>

