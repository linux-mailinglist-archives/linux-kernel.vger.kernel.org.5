Return-Path: <linux-kernel+bounces-16016-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 12E0182370A
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 22:20:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 132FA1C24636
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 21:20:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC9701D6A6;
	Wed,  3 Jan 2024 21:19:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fIwBTq+F"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3420F1D696;
	Wed,  3 Jan 2024 21:19:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7BB75C433C7;
	Wed,  3 Jan 2024 21:19:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704316791;
	bh=pECIEIb28EtEOiDFQMWcUuOJdfm106t6mJYZ646MxwY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fIwBTq+Fat5ri3bGo7Y8PJD1wtV1IVfRaoQCX8PUkdWwu/aabUhBW3okHAVp/Sa34
	 C6BV6MTWQxSXK0Vf4VrJVol5n5QonJcO0NXCbgMgX61gFWPGlthlFO+r56GIgF+dXr
	 JLgVnCRYXIpox7fwpWcoR46cUaYTrb97MeGbWGC/dFXgFHFdAxvq5XUhExnl+ReWZt
	 xKaWuXtKAjlkdewIIoMuq/GqwSH9l9OvkrHZjQvkW7+ZKfIfQhgxI3OHDJrcQo7Xrt
	 HkMGXSvTivWrwCYeWmhsbS4zGWwFaW+XXbBqjJOxp/mjIJ0c0sNRNuvuOMC7jhh3Kd
	 ByPuu+TmZpJlA==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
	id 3133F403EF; Wed,  3 Jan 2024 18:19:49 -0300 (-03)
Date: Wed, 3 Jan 2024 18:19:49 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: baomingtong001@208suo.com, peterz@infradead.org, mingo@redhat.com,
	mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
	jolsa@kernel.org, namhyung@kernel.org, adrian.hunter@intel.com,
	anshuman.khandual@arm.com, linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf tools:remove unneeded variable from
 perf_event_attr__fprintf()
Message-ID: <ZZXPdSo38DRTUVj_@kernel.org>
References: <20230614062234.24149-1-luojianhong@cdjrlc.com>
 <329a5b1b6e2c9061467ed6ef82247b8d@208suo.com>
 <CAP-5=fW_tgXjWpevy+y4gY5XxpYq27zHahPZ8fv5L3+LdjaFnQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fW_tgXjWpevy+y4gY5XxpYq27zHahPZ8fv5L3+LdjaFnQ@mail.gmail.com>
X-Url: http://acmel.wordpress.com

Em Wed, Jul 12, 2023 at 06:20:12PM -0700, Ian Rogers escreveu:
> On Tue, Jun 13, 2023 at 11:25 PM <baomingtong001@208suo.com> wrote:
> >
> > fix the following coccicheck warning:
> >
> > tools/perf/util/perf_event_attr_fprintf.c:97:5-8: Unneeded variable:
> > "ret". Return "0".
> >
> > Signed-off-by: Mingtong Bao <baomingtong001@208suo.com>
> 
> Acked-by: Ian Rogers <irogers@google.com>

util/perf_event_attr_fprintf.c: In function ‘perf_event_attr__fprintf’:
util/perf_event_attr_fprintf.c:256:17: error: ‘ret’ undeclared (first use in this function)
  256 |                 ret += attr__fprintf(fp, _n, buf, priv);\
      |                 ^~~
util/perf_event_attr_fprintf.c:267:9: note: in expansion of macro ‘PRINT_ATTRn’
  267 |         PRINT_ATTRn("type", type, p_type_id, true);
      |         ^~~~~~~~~~~

All those PRINT_ATTRf use that ret variable:

#define PRINT_ATTRn(_n, _f, _p, _a)                     \
do {                                                    \
        if (_a || attr->_f) {                           \
                _p(attr->_f);                           \
                ret += attr__fprintf(fp, _n, buf, priv);\
        }                                               \
} while (0)

#define PRINT_ATTRf(_f, _p)     PRINT_ATTRn(#_f, _f, _p, false

- Arnaldo
 
> Thanks,
> Ian
> 
> > ---
> >   tools/perf/util/perf_event_attr_fprintf.c | 3 +--
> >   1 file changed, 1 insertion(+), 2 deletions(-)
> >
> > diff --git a/tools/perf/util/perf_event_attr_fprintf.c
> > b/tools/perf/util/perf_event_attr_fprintf.c
> > index 7e5e7b30510d..4a8f625b80c7 100644
> > --- a/tools/perf/util/perf_event_attr_fprintf.c
> > +++ b/tools/perf/util/perf_event_attr_fprintf.c
> > @@ -94,7 +94,6 @@ int perf_event_attr__fprintf(FILE *fp, struct
> > perf_event_attr *attr,
> >                    attr__fprintf_f attr__fprintf, void *priv)
> >   {
> >       char buf[BUF_SIZE];
> > -    int ret = 0;
> >
> >       PRINT_ATTRf(type, p_unsigned);
> >       PRINT_ATTRf(size, p_unsigned);
> > @@ -155,5 +154,5 @@ int perf_event_attr__fprintf(FILE *fp, struct
> > perf_event_attr *attr,
> >       PRINT_ATTRf(aux_sample_size, p_unsigned);
> >       PRINT_ATTRf(sig_data, p_unsigned);
> >
> > -    return ret;
> > +    return 0;
> >   }

-- 

- Arnaldo

