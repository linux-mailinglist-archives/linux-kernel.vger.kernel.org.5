Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E1638003A6
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 07:20:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377589AbjLAGUi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 01:20:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbjLAGUe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 01:20:34 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73DD61703;
        Thu, 30 Nov 2023 22:20:40 -0800 (PST)
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3B15vO4M030978;
        Fri, 1 Dec 2023 06:20:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to; s=pp1;
 bh=peQl/tDK1iN+/COEagrUEUhe4ofvOLFew080LgiG+W8=;
 b=igh+I/vUd/WKY0WexQ3S8/E78NP99zxcQ/UgBQ87yugNpmPa/itcbs4HEC6YJx52XNcK
 Jy/g2222XGBaQ7kazIn0tMRoyw/UMaqFGyeOVEdietj8oJNQtLVZ3xknL26Do7m4ZdJ8
 LALt9Ipqi/2g/jjKZl9cNdivyUxxcZEpm6zMYB5rN2dqT3FeAiY6BA8wUkfZrlS7QhJs
 ZWvjFI1qTOMYUBcjteysSnlog1rlHm87tDKE0OojwmmgJQWcWjEcaLuEstTXWtfDBRwD
 OSsKAk0lAsMJ19cO0KfVuSXemToi3fQZ1VzJO+GOClAQ9ezu/pdyGniNeMtRG9lfipli hA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3uq9stgedn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 01 Dec 2023 06:20:18 +0000
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3B16C8Zx005865;
        Fri, 1 Dec 2023 06:20:17 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3uq9stgeda-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 01 Dec 2023 06:20:17 +0000
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
        by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3B16Itwu010627;
        Fri, 1 Dec 2023 06:20:16 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
        by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3ukun03gxs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 01 Dec 2023 06:20:16 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
        by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3B16KEK221824202
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 1 Dec 2023 06:20:14 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id ED43B20040;
        Fri,  1 Dec 2023 06:20:13 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 53A2020049;
        Fri,  1 Dec 2023 06:20:11 +0000 (GMT)
Received: from smtpclient.apple (unknown [9.109.214.114])
        by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTPS;
        Fri,  1 Dec 2023 06:20:11 +0000 (GMT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.200.91.1.1\))
Subject: Re: [PATCH v2 1/4] perf build: Shellcheck support for OUTPUT
 directory
From:   Athira Rajeev <atrajeev@linux.vnet.ibm.com>
In-Reply-To: <20231129213428.2227448-1-irogers@google.com>
Date:   Fri, 1 Dec 2023 11:49:59 +0530
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-perf-users <linux-perf-users@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <CE3EBC99-B6B0-4DD5-A88E-26B28B1A4A46@linux.vnet.ibm.com>
References: <20231129213428.2227448-1-irogers@google.com>
To:     Ian Rogers <irogers@google.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        James Clark <james.clark@arm.com>
X-Mailer: Apple Mail (2.3774.200.91.1.1)
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: tFQNelDEBth-gCDYvq9y_3KBuOz6ndTs
X-Proofpoint-ORIG-GUID: puxtTMiz6HJwvQWJIE4TPxfaxbJ7LE0T
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-01_03,2023-11-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999
 priorityscore=1501 lowpriorityscore=0 mlxscore=0 malwarescore=0
 phishscore=0 bulkscore=0 impostorscore=0 spamscore=0 adultscore=0
 suspectscore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2311060000 definitions=main-2312010036
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On 30-Nov-2023, at 3:04=E2=80=AFAM, Ian Rogers <irogers@google.com> =
wrote:
>=20
> Migrate Makefile.tests to Build so that variables like rule_mkdir are
> defined via Makefile.build (needed so the output directory can be
> created). This requires SHELLCHECK being exported and the clean rule
> tweaking to remove the files in find.
>=20
> Change find "-perm -o=3Dx" as it was failing on my Debian based Linux
> kernel tree, switch to using "-executable".
>=20
> Adding a filename prefix of "." to the shellcheck log files is a pain
> and error prone in make, remove this prefix and just add the
> shellcheck log files to .gitignore.
>=20
> Fix the command echo so that running the test is displayed.
>=20
> Fixes: 1638b11ef815 ("perf tools: Add perf binary dependent rule for =
shellcheck log in Makefile.perf")
> Signed-off-by: Ian Rogers <irogers@google.com>

Hi Ian,

Changes looks good to me.
Tested with make, make clean, make with shellcheck error, make with =
NO_SHELLCHECK

Reviewed-by: Athira Rajeev <atrajeev@linux.vnet.ibm.com>

Thanks
Athira
> ---
> tools/perf/.gitignore           |  3 +++
> tools/perf/Makefile.perf        | 30 ++++++++++--------------------
> tools/perf/tests/Build          | 14 ++++++++++++++
> tools/perf/tests/Makefile.tests | 22 ----------------------
> 4 files changed, 27 insertions(+), 42 deletions(-)
> delete mode 100644 tools/perf/tests/Makefile.tests
>=20
> diff --git a/tools/perf/.gitignore b/tools/perf/.gitignore
> index ee5c14f3b8b1..f5b81d439387 100644
> --- a/tools/perf/.gitignore
> +++ b/tools/perf/.gitignore
> @@ -39,6 +39,9 @@ trace/beauty/generated/
> pmu-events/pmu-events.c
> pmu-events/jevents
> pmu-events/metric_test.log
> +tests/shell/*.shellcheck_log
> +tests/shell/coresight/*.shellcheck_log
> +tests/shell/lib/*.shellcheck_log
> feature/
> libapi/
> libbpf/
> diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
> index 824cbc0af7d7..1ab2a908f240 100644
> --- a/tools/perf/Makefile.perf
> +++ b/tools/perf/Makefile.perf
> @@ -229,8 +229,15 @@ else
>   force_fixdep :=3D $(config)
> endif
>=20
> +# Runs shellcheck on perf test shell scripts
> +ifeq ($(NO_SHELLCHECK),1)
> +  SHELLCHECK :=3D
> +else
> +  SHELLCHECK :=3D $(shell which shellcheck 2> /dev/null)
> +endif
> +
> export srctree OUTPUT RM CC CXX LD AR CFLAGS CXXFLAGS V BISON FLEX AWK
> -export HOSTCC HOSTLD HOSTAR HOSTCFLAGS
> +export HOSTCC HOSTLD HOSTAR HOSTCFLAGS SHELLCHECK
>=20
> include $(srctree)/tools/build/Makefile.include
>=20
> @@ -673,23 +680,7 @@ $(PERF_IN): prepare FORCE
> $(PMU_EVENTS_IN): FORCE prepare
> $(Q)$(MAKE) -f $(srctree)/tools/build/Makefile.build dir=3Dpmu-events =
obj=3Dpmu-events
>=20
> -# Runs shellcheck on perf test shell scripts
> -
> -SHELLCHECK :=3D $(shell which shellcheck 2> /dev/null)
> -
> -ifeq ($(NO_SHELLCHECK),1)
> -SHELLCHECK :=3D
> -endif
> -
> -ifneq ($(SHELLCHECK),)
> -SHELLCHECK_TEST: FORCE prepare
> - $(Q)$(MAKE) -f $(srctree)/tools/perf/tests/Makefile.tests
> -else
> -SHELLCHECK_TEST:
> - @:
> -endif
> -
> -$(OUTPUT)perf: $(PERFLIBS) $(PERF_IN) $(PMU_EVENTS_IN) =
SHELLCHECK_TEST
> +$(OUTPUT)perf: $(PERFLIBS) $(PERF_IN) $(PMU_EVENTS_IN)
> $(QUIET_LINK)$(CC) $(CFLAGS) $(LDFLAGS) \
> $(PERF_IN) $(PMU_EVENTS_IN) $(LIBS) -o $@
>=20
> @@ -1152,9 +1143,8 @@ bpf-skel-clean:
> $(call QUIET_CLEAN, bpf-skel) $(RM) -r $(SKEL_TMP_OUT) $(SKELETONS)
>=20
> clean:: $(LIBAPI)-clean $(LIBBPF)-clean $(LIBSUBCMD)-clean =
$(LIBSYMBOL)-clean $(LIBPERF)-clean fixdep-clean python-clean =
bpf-skel-clean tests-coresight-targets-clean
> - $(Q)$(MAKE) -f $(srctree)/tools/perf/tests/Makefile.tests clean
> $(call QUIET_CLEAN, core-objs)  $(RM) $(LIBPERF_A) =
$(OUTPUT)perf-archive $(OUTPUT)perf-iostat $(LANG_BINDINGS)
> - $(Q)find $(or $(OUTPUT),.) -name '*.o' -delete -o -name '\.*.cmd' =
-delete -o -name '\.*.d' -delete
> + $(Q)find $(or $(OUTPUT),.) -name '*.o' -delete -o -name '\.*.cmd' =
-delete -o -name '\.*.d' -delete -o -name '*.shellcheck_log' -delete
> $(Q)$(RM) $(OUTPUT).config-detected
> $(call QUIET_CLEAN, core-progs) $(RM) $(ALL_PROGRAMS) perf =
perf-read-vdso32 perf-read-vdsox32 $(OUTPUT)$(LIBJVMTI).so
> $(call QUIET_CLEAN, core-gen)   $(RM)  *.spec *.pyc *.pyo */*.pyc =
*/*.pyo $(OUTPUT)common-cmds.h TAGS tags cscope* =
$(OUTPUT)PERF-VERSION-FILE $(OUTPUT)FEATURE-DUMP $(OUTPUT)util/*-bison* =
$(OUTPUT)util/*-flex* \
> diff --git a/tools/perf/tests/Build b/tools/perf/tests/Build
> index 2b45ffa462a6..53ba9c3e20e0 100644
> --- a/tools/perf/tests/Build
> +++ b/tools/perf/tests/Build
> @@ -77,3 +77,17 @@ CFLAGS_python-use.o   +=3D =
-DPYTHONPATH=3D"BUILD_STR($(OUTPUT)python)" -DPYTHON=3D"BUI
> CFLAGS_dwarf-unwind.o +=3D -fno-optimize-sibling-calls
>=20
> perf-y +=3D workloads/
> +
> +ifdef SHELLCHECK
> +  SHELL_TESTS :=3D $(shell find tests/shell -executable -type f -name =
'*.sh')
> +  TEST_LOGS :=3D $(SHELL_TESTS:tests/shell/%=3Dshell/%.shellcheck_log)
> +else
> +  SHELL_TESTS :=3D
> +  TEST_LOGS :=3D
> +endif
> +
> +$(OUTPUT)%.shellcheck_log: %
> + $(call rule_mkdir)
> + $(Q)$(call echo-cmd,test)shellcheck -a -S warning "$<" > $@ || (cat =
$@ && rm $@ && false)
> +
> +perf-y +=3D $(TEST_LOGS)
> diff --git a/tools/perf/tests/Makefile.tests =
b/tools/perf/tests/Makefile.tests
> deleted file mode 100644
> index fdaca5f7a946..000000000000
> --- a/tools/perf/tests/Makefile.tests
> +++ /dev/null
> @@ -1,22 +0,0 @@
> -# SPDX-License-Identifier: GPL-2.0
> -# Athira Rajeev <atrajeev@linux.vnet.ibm.com>, 2023
> -
> -PROGS :=3D $(shell find tests/shell -perm -o=3Dx -type f -name =
'*.sh')
> -FILE_NAME :=3D $(notdir $(PROGS))
> -FILE_NAME :=3D $(FILE_NAME:%=3D.%)
> -LOGS :=3D $(join $(dir $(PROGS)),$(FILE_NAME))
> -LOGS :=3D $(LOGS:%=3D%.shellcheck_log)
> -
> -.PHONY: all
> -all: SHELLCHECK_RUN
> - @:
> -
> -SHELLCHECK_RUN: $(LOGS)
> -
> -.%.shellcheck_log: %
> - $(call rule_mkdir)
> - $(Q)$(call frecho-cmd,test)@shellcheck -S warning "$<" > $@ || (cat =
$@ && rm $@ && false)
> -
> -clean:
> - $(eval log_files :=3D $(shell find . -name '.*.shellcheck_log'))
> - @rm -rf $(log_files)
> --=20
> 2.43.0.rc1.413.gea7ed67945-goog
>=20

