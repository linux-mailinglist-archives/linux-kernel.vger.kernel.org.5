Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECFC57E6E5E
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Nov 2023 17:14:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232422AbjKIQOi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 11:14:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229770AbjKIQOh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 11:14:37 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99AE4358C
        for <linux-kernel@vger.kernel.org>; Thu,  9 Nov 2023 08:14:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699546475; x=1731082475;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=6+3Hm35oChc+r8wa9Xj2SEbP1YtXj6yOGjJF7xoF+YE=;
  b=Tsw+e9WhPqRCF45kUpoxMIcWzJSbVd07z+re7LSSdmN+WBWbglJl9qQ8
   lBym4g5ugK3fr3lS1eqdmGo1lc/X4VyuYf62uYIHHBbGSSwwFKVb6Sama
   U1iQ54eKLWvOiMEHaCns4/Mv2mtBVA1w/QFPnHXVPVNfAqKPb1gXYiwMG
   5AoodcTVHPHiGFT4leSlWHCTVkB76ueysAFn1w3qEdR+LsTrTdp/MiQxQ
   9QN+G+gz7hRHSi6Y1Nwg1CFLaFN31nUv2YmnJIxoy7BPdb8Yvi5Qx3SP2
   t/BJaN4QCNKYkCx0MNUTKuCAiv/3WcT3I/3ciqTgCVELksuulmCJaLN86
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10889"; a="370219193"
X-IronPort-AV: E=Sophos;i="6.03,289,1694761200"; 
   d="scan'208";a="370219193"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2023 08:14:35 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10889"; a="829362650"
X-IronPort-AV: E=Sophos;i="6.03,289,1694761200"; 
   d="scan'208";a="829362650"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2023 08:14:34 -0800
Received: from [10.212.120.254] (zholbroo-mobl3.amr.corp.intel.com [10.212.120.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id BC6E3580D4E;
        Thu,  9 Nov 2023 08:14:32 -0800 (PST)
Message-ID: <a40ff4eb-5507-45b9-9f21-1d153a544e16@linux.intel.com>
Date:   Thu, 9 Nov 2023 11:14:31 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V5 2/8] perf/x86: Add PERF_X86_EVENT_NEEDS_BRANCH_STACK
 flag
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     peterz@infradead.org, mingo@redhat.com,
        linux-kernel@vger.kernel.org, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@kernel.org,
        namhyung@kernel.org, irogers@google.com, adrian.hunter@intel.com,
        ak@linux.intel.com, eranian@google.com,
        alexey.v.bayduraev@linux.intel.com, tinghao.zhang@intel.com
References: <20231025201626.3000228-1-kan.liang@linux.intel.com>
 <20231025201626.3000228-2-kan.liang@linux.intel.com>
 <ZUlWuROfYcYJlRn4@kernel.org>
 <fb1ebf48-ac2f-499a-b480-ba8474b12200@linux.intel.com>
 <ZUpTtoCzJFHhnSdh@kernel.org> <ZUv+G+w5EvJgQS45@kernel.org>
Content-Language: en-US
From:   "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <ZUv+G+w5EvJgQS45@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023-11-08 4:31 p.m., Arnaldo Carvalho de Melo wrote:
> Em Tue, Nov 07, 2023 at 12:11:50PM -0300, Arnaldo Carvalho de Melo escr=
eveu:
>> Em Mon, Nov 06, 2023 at 04:19:13PM -0500, Liang, Kan escreveu:
>>> On 2023-11-06 4:12 p.m., Arnaldo Carvalho de Melo wrote:
>>>> Em Wed, Oct 25, 2023 at 01:16:20PM -0700, kan.liang@linux.intel.com =
escreveu:
>>> Ian has already reviewed the tool parts.
>=20
>>> But I still owe a test case for the feature. I will post a patch late=
r.
>>> https://lore.kernel.org/lkml/acbb895a-475e-4679-98fc-6b90c05a00af@lin=
ux.intel.com/
>=20
>> I saw Ian's suggestion, and agree with it, we need to pair new feature=
s
>> with regression tests in 'perf test', thanks for working on it!
>=20
> Kan,
>=20
> 	I still have to bisect, but can you check if this works for you?

The branch counters feature requires all the events to belong to a
group. There is no problem for the normal perf usage which usually
initializes an evlist even for a single evsel.
But perf test is special, which may not initialize an evlist. The Sample
parsing test case is one of the examples. It crashes with the
!evsel->evlist.

The below change should fix it. I will post a complete patch shortly.

diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index 58a9b8c82790..7a6a2d1f96db 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -2355,6 +2355,10 @@ static inline bool
evsel__has_branch_counters(const struct evsel *evsel)
 {
        struct evsel *cur, *leader =3D evsel__leader(evsel);

+       /* The branch counters feature only supports group */
+       if (!leader || !evsel->evlist)
+               return false;
+
        evlist__for_each_entry(evsel->evlist, cur) {
                if ((leader =3D=3D evsel__leader(cur)) &&
                    (cur->core.attr.branch_sample_type &
PERF_SAMPLE_BRANCH_COUNTERS))

Thanks,
Kan

>=20
>=20
> (gdb) run test -F -v 27
> Starting program: /root/bin/perf test -F -v 27
>=20
>  27: Sample parsing                                                  :
> --- start ---
>=20
> Program received signal SIGSEGV, Segmentation fault.
> 0x00000000004e4aa6 in evsel.parse_sample ()
> Missing separate debuginfos, use: dnf debuginfo-install bzip2-libs-1.0.=
8-13.fc38.x86_64 cyrus-sasl-lib-2.1.28-9.fc38.x86_64 elfutils-debuginfod-=
client-0.189-3.fc38.x86_64 elfutils-libelf-0.189-3.fc38.x86_64 elfutils-l=
ibs-0.189-3.fc38.x86_64 glib2-2.76.5-2.fc38.x86_64 glibc-2.37-13.fc38.x86=
_64 keyutils-libs-1.6.1-6.fc38.x86_64 krb5-libs-1.21-3.fc38.x86_64 libbab=
eltrace-1.5.11-2.fc38.x86_64 libbrotli-1.0.9-11.fc38.x86_64 libcap-2.48-6=
=2Efc38.x86_64 libcom_err-1.46.5-4.fc38.x86_64 libcurl-8.0.1-5.fc38.x86_6=
4 libevent-2.1.12-8.fc38.x86_64 libgcc-13.2.1-4.fc38.x86_64 libidn2-2.3.4=
-2.fc38.x86_64 libnghttp2-1.52.0-2.fc38.x86_64 libpfm-4.11.0-11.fc38.x86_=
64 libpsl-0.21.2-2.fc38.x86_64 libselinux-3.5-1.fc38.x86_64 libssh-0.10.5=
-1.fc38.x86_64 libstdc++-13.2.1-4.fc38.x86_64 libtraceevent-1.7.2-1.fc38.=
x86_64 libunistring1.0-1.0-1.fc38.x86_64 libunwind-1.6.2-7.fc38.x86_64 li=
buuid-2.38.1-4.fc38.x86_64 libxcrypt-4.4.36-1.fc38.x86_64 libzstd-1.5.5-1=
=2Efc38.x86_64 opencsd-1.3.3-1.fc38.x86_64 openldap-2.6.6-1.fc38.x86_64 o=
penssl-libs-3.0.9-2.fc38.x86_64 perl-libs-5.36.1-497.fc38.x86_64 popt-1.1=
9-2.fc38.x86_64 python3-libs-3.11.6-1.fc38.x86_64 slang-2.3.3-3.fc38.x86_=
64 zlib-1.2.13-3.fc38.x86_64
> (gdb) bt
> #0  0x00000000004e4aa6 in evsel.parse_sample ()
> #1  0x00000000004b28dc in do_test ()
> #2  0x00000000004b2acd in test.sample_parsing ()
> #3  0x0000000000495348 in test_and_print.isra ()
> #4  0x0000000000495f5d in cmd_test ()
> #5  0x00000000004c2a29 in run_builtin ()
> #6  0x000000000041053f in main ()
> (gdb)
>=20
