Return-Path: <linux-kernel+bounces-121657-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6830488EBC8
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 17:56:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8A92E1C2A4F6
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 16:56:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B14614C5A7;
	Wed, 27 Mar 2024 16:56:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o6pyTYKO"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E447131BA9;
	Wed, 27 Mar 2024 16:56:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711558602; cv=none; b=mgPtx9dMz3zsy8B22hioTEszSH6sA7kgfSJF8Vz4gEQ2ArW/sO4hcjE2tlaTO63l/SexWFY88H0sJMYz8VYLj0Q6tqbaYYND1ra5t40ExR/5ySiSeoexO9fACa8gvDmstaRiXc26JlQPA6TF4/GUrvq5ya1cIqK7CZ0axGPnqcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711558602; c=relaxed/simple;
	bh=HiC7BqQmXRl4D1EayBeDeK4Ew6tPWv+jQqStxIpWhnA=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:Cc:Subject:From:
	 References:In-Reply-To; b=OAtefInDIXmztGFHXwwRc4k+32acnxdhOn74VmxL/zckoOa4WfM1Fs9DbIy+CDhJlZQQ7mrMvAHO8GnrrrC7nQp7kWy9pcj90zRZsytMuoKw1TvMEIT8bttnwNCLnYNz9yCmQm87+WEaVLImdcI7koStt13t+bO0t+VZw2Z9HvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o6pyTYKO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA65EC433C7;
	Wed, 27 Mar 2024 16:56:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711558602;
	bh=HiC7BqQmXRl4D1EayBeDeK4Ew6tPWv+jQqStxIpWhnA=;
	h=Date:To:Cc:Subject:From:References:In-Reply-To:From;
	b=o6pyTYKOEe4k9F7njyxnfRWaWV9MNmMYgiSCZOSS4yBnWHtx2obvkRNWTtslRKW6Z
	 9xCW1hohxto6fo0mneEXy9QMFXMFOFb0l4MDpdNvKTVyTD73d/Gj0O5zlPY2dkGd25
	 SJIuMREuOoCgzcB5de7wr2h6WljLMPh1SMk535CfxNyBct8DiWlQh2oj6UIY5I0fId
	 oahrSrYb3MDX4DUd4DLYsmX3mzCTeUqphjCGB1aElOZabmsm1/z8c5k8TCYojQuACJ
	 e8Skt9W714Y5j0wUwcLxKMfV0PDtOPjFa6WIGcpEWXsGepl5N3lG/ky5b9LCSB/M4Y
	 Tqs0/XTdRqTbA==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 27 Mar 2024 18:56:35 +0200
Message-Id: <D04OVW6I8MUA.1OAIHFQ8943SM@kernel.org>
To: "Jarkko Sakkinen" <jarkko@kernel.org>, "Haitao Huang"
 <haitao.huang@linux.intel.com>, <dave.hansen@linux.intel.com>,
 <tj@kernel.org>, <mkoutny@suse.com>, <linux-kernel@vger.kernel.org>,
 <linux-sgx@vger.kernel.org>, <x86@kernel.org>, <cgroups@vger.kernel.org>,
 <tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>, <hpa@zytor.com>,
 <sohil.mehta@intel.com>, <tim.c.chen@linux.intel.com>
Cc: <zhiquan1.li@intel.com>, <kristen@linux.intel.com>, <seanjc@google.com>,
 <zhanb@microsoft.com>, <anakrish@microsoft.com>,
 <mikko.ylinen@linux.intel.com>, <yangjie@microsoft.com>,
 <chrisyan@microsoft.com>
Subject: Re: [PATCH v9 15/15] selftests/sgx: Add scripts for EPC cgroup
 testing
From: "Jarkko Sakkinen" <jarkko@kernel.org>
X-Mailer: aerc 0.17.0
References: <20240205210638.157741-1-haitao.huang@linux.intel.com>
 <20240205210638.157741-16-haitao.huang@linux.intel.com>
 <4be7b291010973c203ed8c7bcd25b626c1290231.camel@kernel.org>
In-Reply-To: <4be7b291010973c203ed8c7bcd25b626c1290231.camel@kernel.org>

On Wed Mar 27, 2024 at 2:55 PM EET, Jarkko Sakkinen wrote:
> On Mon, 2024-02-05 at 13:06 -0800, Haitao Huang wrote:
> > The scripts rely on cgroup-tools package from libcgroup [1].
> >=20
> > To run selftests for epc cgroup:
> >=20
> > sudo ./run_epc_cg_selftests.sh
> >=20
> > To watch misc cgroup 'current' changes during testing, run this in a
> > separate terminal:
> >=20
> > ./watch_misc_for_tests.sh current
> >=20
> > With different cgroups, the script starts one or multiple concurrent
> > SGX
> > selftests, each to run one unclobbered_vdso_oversubscribed test.=C2=A0
> > Each
> > of such test tries to load an enclave of EPC size equal to the EPC
> > capacity available on the platform. The script checks results against
> > the expectation set for each cgroup and reports success or failure.
> >=20
> > The script creates 3 different cgroups at the beginning with
> > following
> > expectations:
> >=20
> > 1) SMALL - intentionally small enough to fail the test loading an
> > enclave of size equal to the capacity.
> > 2) LARGE - large enough to run up to 4 concurrent tests but fail some
> > if
> > more than 4 concurrent tests are run. The script starts 4 expecting
> > at
> > least one test to pass, and then starts 5 expecting at least one test
> > to fail.
> > 3) LARGER - limit is the same as the capacity, large enough to run
> > lots of
> > concurrent tests. The script starts 8 of them and expects all pass.
> > Then it reruns the same test with one process randomly killed and
> > usage checked to be zero after all process exit.
> >=20
> > The script also includes a test with low mem_cg limit and LARGE
> > sgx_epc
> > limit to verify that the RAM used for per-cgroup reclamation is
> > charged
> > to a proper mem_cg.
> >=20
> > [1] https://github.com/libcgroup/libcgroup/blob/main/README
> >=20
> > Signed-off-by: Haitao Huang <haitao.huang@linux.intel.com>
> > ---
> > V7:
> > - Added memcontrol test.
> >=20
> > V5:
> > - Added script with automatic results checking, remove the
> > interactive
> > script.
> > - The script can run independent from the series below.
> > ---
> > =C2=A0.../selftests/sgx/run_epc_cg_selftests.sh=C2=A0=C2=A0=C2=A0=C2=A0=
 | 246
> > ++++++++++++++++++
> > =C2=A0.../selftests/sgx/watch_misc_for_tests.sh=C2=A0=C2=A0=C2=A0=C2=A0=
 |=C2=A0 13 +
> > =C2=A02 files changed, 259 insertions(+)
> > =C2=A0create mode 100755
> > tools/testing/selftests/sgx/run_epc_cg_selftests.sh
> > =C2=A0create mode 100755
> > tools/testing/selftests/sgx/watch_misc_for_tests.sh
> >=20
> > diff --git a/tools/testing/selftests/sgx/run_epc_cg_selftests.sh
> > b/tools/testing/selftests/sgx/run_epc_cg_selftests.sh
> > new file mode 100755
> > index 000000000000..e027bf39f005
> > --- /dev/null
> > +++ b/tools/testing/selftests/sgx/run_epc_cg_selftests.sh
> > @@ -0,0 +1,246 @@
> > +#!/bin/bash
>
> This is not portable and neither does hold in the wild.
>
> It does not even often hold as it is not uncommon to place bash
> to the path /usr/bin/bash. If I recall correctly, e.g. NixOS has
> a path that is neither of those two.
>
> Should be #!/usr/bin/env bash
>
> That is POSIX compatible form.
>
> Just got around trying to test this in NUC7 so looking into this in
> more detail.
>
> That said can you make the script work with just "#!/usr/bin/env sh"
> and make sure that it is busybox ash compatible?
>
> I don't see any necessity to make this bash only and it adds to the
> compilation time of the image. Otherwise lot of this could be tested
> just with qemu+bzImage+busybox(inside initramfs).
>
> Now you are adding fully glibc shenanigans for the sake of syntax
> sugar.
>
> > +# SPDX-License-Identifier: GPL-2.0
> > +# Copyright(c) 2023 Intel Corporation.
> > +
> > +TEST_ROOT_CG=3Dselftest
> > +cgcreate -g misc:$TEST_ROOT_CG
>
> How do you know that cgcreate exists? It is used a lot in the script
> with no check for the existence. Please fix e.g. with "command -v
> cgreate".
>
> > +if [ $? -ne 0 ]; then
> > +=C2=A0=C2=A0=C2=A0 echo "# Please make sure cgroup-tools is installed,=
 and misc
> > cgroup is mounted."
> > +=C2=A0=C2=A0=C2=A0 exit 1
> > +fi
>
> And please do not do it this way. Also, please remove the advice for
> "cgroups-tool". This is not meant to be debian only. Better would be
> to e.g. point out the URL of the upstream project.
>
> And yeah the whole message should be based on "command -v", not like
> this.
>
> > +TEST_CG_SUB1=3D$TEST_ROOT_CG/test1
> > +TEST_CG_SUB2=3D$TEST_ROOT_CG/test2
> > +# We will only set limit in test1 and run tests in test3
> > +TEST_CG_SUB3=3D$TEST_ROOT_CG/test1/test3
> > +TEST_CG_SUB4=3D$TEST_ROOT_CG/test4
> > +
> > +cgcreate -g misc:$TEST_CG_SUB1
>
>
>
> > +cgcreate -g misc:$TEST_CG_SUB2
> > +cgcreate -g misc:$TEST_CG_SUB3
> > +cgcreate -g misc:$TEST_CG_SUB4
> > +
> > +# Default to V2
> > +CG_MISC_ROOT=3D/sys/fs/cgroup
> > +CG_MEM_ROOT=3D/sys/fs/cgroup
> > +CG_V1=3D0
> > +if [ ! -d "/sys/fs/cgroup/misc" ]; then
> > +=C2=A0=C2=A0=C2=A0 echo "# cgroup V2 is in use."
> > +else
> > +=C2=A0=C2=A0=C2=A0 echo "# cgroup V1 is in use."
>
> Is "#" prefix a standard for kselftest? I don't know this, thus asking.
>
> > +=C2=A0=C2=A0=C2=A0 CG_MISC_ROOT=3D/sys/fs/cgroup/misc
> > +=C2=A0=C2=A0=C2=A0 CG_MEM_ROOT=3D/sys/fs/cgroup/memory
> > +=C2=A0=C2=A0=C2=A0 CG_V1=3D1
>
> Have you checked what is the indentation policy for bash scripts inside
> kernel tree. I don't know what it is. That's why I'm asking.
>
> > +fi
> > +
> > +CAPACITY=3D$(grep "sgx_epc" "$CG_MISC_ROOT/misc.capacity" | awk
> > '{print $2}')
> > +# This is below number of VA pages needed for enclave of capacity
> > size. So
> > +# should fail oversubscribed cases
> > +SMALL=3D$(( CAPACITY / 512 ))
> > +
> > +# At least load one enclave of capacity size successfully, maybe up
> > to 4.
> > +# But some may fail if we run more than 4 concurrent enclaves of
> > capacity size.
> > +LARGE=3D$(( SMALL * 4 ))
> > +
> > +# Load lots of enclaves
> > +LARGER=3D$CAPACITY
> > +echo "# Setting up limits."
> > +echo "sgx_epc $SMALL" > $CG_MISC_ROOT/$TEST_CG_SUB1/misc.max
> > +echo "sgx_epc $LARGE" >=C2=A0 $CG_MISC_ROOT/$TEST_CG_SUB2/misc.max
> > +echo "sgx_epc $LARGER" > $CG_MISC_ROOT/$TEST_CG_SUB4/misc.max
> > +
> > +timestamp=3D$(date +%Y%m%d_%H%M%S)
> > +
> > +test_cmd=3D"./test_sgx -t unclobbered_vdso_oversubscribed"
> > +
> > +wait_check_process_status() {
> > +=C2=A0=C2=A0=C2=A0 local pid=3D$1
> > +=C2=A0=C2=A0=C2=A0 local check_for_success=3D$2=C2=A0 # If 1, check fo=
r success;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 # If 0, check for failure
> > +=C2=A0=C2=A0=C2=A0 wait "$pid"
> > +=C2=A0=C2=A0=C2=A0 local status=3D$?
> > +
> > +=C2=A0=C2=A0=C2=A0 if [[ $check_for_success -eq 1 && $status -eq 0 ]];=
 then
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 echo "# Process $pid succee=
ded."
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return 0
> > +=C2=A0=C2=A0=C2=A0 elif [[ $check_for_success -eq 0 && $status -ne 0 ]=
]; then
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 echo "# Process $pid return=
ed failure."
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return 0
> > +=C2=A0=C2=A0=C2=A0 fi
> > +=C2=A0=C2=A0=C2=A0 return 1
> > +}
> > +
> > +wai
> > wait_and_detect_for_any() {
>
> what is "any"?
>
> Maybe for some key functions could have short documentation what they
> are and for what test uses them. I cannot possibly remember all of this
> just by hints such as "this waits for Any" ;-)
>
> I don't think there is actual kernel guideline to engineer the script
> to work with just ash but at least for me that would inevitably
> increase my motivation to test this patch set more rather than less.

I also wonder is cgroup-tools dependency absolutely required or could
you just have a function that would interact with sysfs?

BR, Jarkko

