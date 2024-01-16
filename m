Return-Path: <linux-kernel+bounces-28313-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E68A82FCD8
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 23:30:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DDB411F2D733
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 22:30:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1D165FDCC;
	Tue, 16 Jan 2024 21:38:35 +0000 (UTC)
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D30B22031D;
	Tue, 16 Jan 2024 21:38:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705441115; cv=none; b=G39sbTwcO3vTggJGIaN39H1i8Ijp5KMWNYnYjA1Vgw8SODF/B7R6t0uJgcMxvVCKMBgnQ2iHvL8yIZwxKHO51QbfjWKxmUlB6+praVsV9+BPNF9lFKjQb7PM59Ani8bnbErOhOum8fIeCgGHFRonmN5lQz0MdhwrUx+1s6ITZDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705441115; c=relaxed/simple;
	bh=0+B9f+SDQ7MNjWm/4XDd8U3BNj5wf0lOZ4O77VNib/o=;
	h=Received:X-Google-DKIM-Signature:X-Gm-Message-State:
	 X-Google-Smtp-Source:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:Message-ID:Subject:To:Cc:Content-Type:
	 Content-Transfer-Encoding; b=MsEsuFL9tbj2px4leklO0Mlh1l+4eoX4H6Aq6M/QGP5lzKxciHQ+aS+w69SkduC3Kqb0mQ2uAz2U/BK/JWW/TmtNFAePkb9vHGLOjgEHwOMq5yolbVtZU09alohuMPFDmaTi5VRA0MS8DU75AYmcWanvNWPnI2Oaa4XNTWnQ12M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-6dad22e13dcso6507272b3a.3;
        Tue, 16 Jan 2024 13:38:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705441113; x=1706045913;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CS3/2X2nggEz5xQcw+haR7fO99OiHUdyAq+EW5k/HVg=;
        b=pGUJvWwZCbDg1uwEOyEA4pTljZxFumLn8B7djXfDm1bbY9MnLsStRntZNC1+7ofZu5
         ls9HhTtZxpNCqa5PElYVXPs5ECjNbNcZWUUqITsoOUFQK0EsrEvcQxq1n33TLcroLMbl
         kh5Htaverf57HJol8Ey9me6cihDwrnRgjJua4MPAIaGTBNEyB6tnPnYLcWJxxc3YTFk1
         EyYH+JkXBj1X2/rikXwgdSYS3xN3sIKzFvBSrmmUNzN3Fhv20fcF6TzvM41HTv4UNJva
         5bZm58Z4ZtLC5iAK2U89MIXONx0/Im9lVR3IpHm7uka4k8ERudFX8QYG6CiWUryRSD21
         gj1g==
X-Gm-Message-State: AOJu0YxA7NZXZE29jNY+cOSpO5lbrPXlSluEDgUIIEsW87h3eQPLlr0/
	a+Oc+Q//uv8PavMEOEyiynqHCnbsJSmJl5/gZnM=
X-Google-Smtp-Source: AGHT+IFkQXg9vLFpGaAiphz/VKhWfCFU2OCPkVqdGN0YFWVKlYYU+8nDURTFF2PrpGk/SdJZYSfVdLSYD4s9dnUNQqQ=
X-Received: by 2002:a05:6a20:ce4d:b0:19a:8556:8caa with SMTP id
 id13-20020a056a20ce4d00b0019a85568caamr4805936pzb.13.1705441113058; Tue, 16
 Jan 2024 13:38:33 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240112034019.3558584-1-yangjihong1@huawei.com>
In-Reply-To: <20240112034019.3558584-1-yangjihong1@huawei.com>
From: Namhyung Kim <namhyung@kernel.org>
Date: Tue, 16 Jan 2024 13:38:21 -0800
Message-ID: <CAM9d7cgecXt=QsTpv-L2nF1w72_fwV4rZZGG0tZi-LwZS8P-jg@mail.gmail.com>
Subject: Re: [PATCH] perf build: Check whether pkg-config is installed when
 libtraceevent is linked
To: Yang Jihong <yangjihong1@huawei.com>
Cc: peterz@infradead.org, mingo@redhat.com, acme@kernel.org, 
	mark.rutland@arm.com, alexander.shishkin@linux.intel.com, jolsa@kernel.org, 
	irogers@google.com, adrian.hunter@intel.com, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello,

On Thu, Jan 11, 2024 at 7:44=E2=80=AFPM Yang Jihong <yangjihong1@huawei.com=
> wrote:
>
> If pkg-config is not installed when libtraceevent is linked, the build fa=
ils.
>
> The error information is as follows:
>
>   $ make
>   <SNIP>
>   In file included from /home/yjh/projects_linux/perf-tool-next/linux/too=
ls/perf/util/evsel.c:43:
>   /home/yjh/projects_linux/perf-tool-next/linux/tools/perf/util/trace-eve=
nt.h:149:62: error: operator '&&' has no right operand
>     149 | #if defined(LIBTRACEEVENT_VERSION) &&  LIBTRACEEVENT_VERSION >=
=3D MAKE_LIBTRACEEVENT_VERSION(1, 5, 0)
>         |                                                              ^~
>   error: command '/usr/bin/gcc' failed with exit code 1
>   cp: cannot stat 'python_ext_build/lib/perf*.so': No such file or direct=
ory
>   make[2]: *** [Makefile.perf:668: python/perf.cpython-310-x86_64-linux-g=
nu.so] Error 1
>   make[2]: *** Waiting for unfinished jobs....
>
> Because pkg-config is not installed, fail to get libtraceevent version in
> Makefile.config file. As a result, LIBTRACEEVENT_VERSION is empty.
> However, the preceding error information is not user-friendly.
>
> Identify errors in advance by checking that pkg-config is installed at
> compile time.

Thanks for working on this.  I also think we can disable it when
pkg-config is not installed and continue to build.  But I guess it's
usual to have pkg-config on a build environment so it'd be better
to stop the build and warn the user.

>
> The build results of various scenarios are as follows:
>
> 1. build successful when libtraceevent is not linked and pkg-config is no=
t installed
>
>   $ pkg-config --version
>   -bash: /usr/bin/pkg-config: No such file or directory
>   $ make clean >/dev/null
>   $ make NO_LIBTRACEEVENT=3D1 >/dev/null
>   Makefile.config:1133: No alternatives command found, you need to set JD=
IR=3D to point to the root of your Java directory
>     PERF_VERSION =3D 6.7.rc6.gd988c9f511af
>   $ echo $?
>   0
>
> 2. dummy pkg-config is missing when libtraceevent is linked
>
>   $ pkg-config --version
>   -bash: /usr/bin/pkg-config: No such file or directory
>   $ make clean >/dev/null
>   $ make >/dev/null
>   Makefile.config:221: *** Error: pkg-config needed by libtraceevent is m=
issing on this system, please install it.  Stop.
>   make[1]: *** [Makefile.perf:251: sub-make] Error 2
>   make: *** [Makefile:70: all] Error 2
>   $ echo $?
>   2
>
> 3. build successful when libtraceevent is linked and pkg-config is instal=
led
>
>   $ pkg-config --version
>   0.29.2
>   $ make clean >/dev/null
>   $ make >/dev/null
>   Makefile.config:1133: No alternatives command found, you need to set JD=
IR=3D to point to the root of your Java directory
>     PERF_VERSION =3D 6.7.rc6.gd988c9f511af
>   $ echo $?
>   0
>
> Signed-off-by: Yang Jihong <yangjihong1@huawei.com>

Acked-by: Namhyung Kim <namhyung@kernel.org>

Thanks,
Namhyung


> ---
>  tools/perf/Makefile.config | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
> index aa55850fbc21..70c33c935a98 100644
> --- a/tools/perf/Makefile.config
> +++ b/tools/perf/Makefile.config
> @@ -216,6 +216,12 @@ ifeq ($(call get-executable,$(BISON)),)
>    dummy :=3D $(error Error: $(BISON) is missing on this system, please i=
nstall it)
>  endif
>
> +ifneq ($(NO_LIBTRACEEVENT),1)
> +  ifeq ($(call get-executable,$(PKG_CONFIG)),)
> +  dummy :=3D $(error Error: $(PKG_CONFIG) needed by libtraceevent is mis=
sing on this system, please install it)
> +  endif
> +endif
> +
>  ifneq ($(OUTPUT),)
>    ifeq ($(shell expr $(shell $(BISON) --version | grep bison | sed -e 's=
/.\+ \([0-9]\+\).\([0-9]\+\).\([0-9]\+\)/\1\2\3/g') \>\=3D 371), 1)
>      BISON_FILE_PREFIX_MAP :=3D --file-prefix-map=3D$(OUTPUT)=3D
> --
> 2.34.1
>

