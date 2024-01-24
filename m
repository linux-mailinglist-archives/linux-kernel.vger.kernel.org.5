Return-Path: <linux-kernel+bounces-36289-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FDC4839E73
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 02:53:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 287C81C23EBC
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 01:53:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51A6A17D5;
	Wed, 24 Jan 2024 01:53:35 +0000 (UTC)
Received: from szxga07-in.huawei.com (szxga07-in.huawei.com [45.249.212.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 665CB15CE;
	Wed, 24 Jan 2024 01:53:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706061214; cv=none; b=VVbP2toE4sbcKYk/OjOfy+f0HfjZQ2IW4rfwj1Ivnce6qfxKRKVV4iQxzdcN8a/TMr894BnNEbjGhhcyw+REjPlyLhQ8wU4FZkiixKGQWVA+LBHvhKRXNfLFwgYvwlTfGqP7g2jYbFynAZ4fIv7SM6rD4sN2T6NZ6a03KQwWlf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706061214; c=relaxed/simple;
	bh=DDNWme+4AILDS/KFY3d5eitfWWGEsGAmesTFSpiLOlA=;
	h=Subject:To:References:CC:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=jvxAZR1ZAQH4lpT5otfuuzlG4V392t9ptuHQgkJe0iyOf7vcPIbHN8P2omz8TV/fk7+dwQF3dyJEhSqMsWbZa/yvlU6fe3Sqj5Utur4f0jTTqJDWXS6JyiEpyPj5TEC7JxlbDdR1pM7IoJuF4cDFDmQoJBcqXv/VZXPcX7MFea8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.17])
	by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4TKRlN1zqYz1Q8Bx;
	Wed, 24 Jan 2024 09:51:44 +0800 (CST)
Received: from canpemm500010.china.huawei.com (unknown [7.192.105.118])
	by mail.maildlp.com (Postfix) with ESMTPS id 909BF1A0172;
	Wed, 24 Jan 2024 09:53:28 +0800 (CST)
Received: from [10.174.178.185] (10.174.178.185) by
 canpemm500010.china.huawei.com (7.192.105.118) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 24 Jan 2024 09:53:28 +0800
Subject: Re: [PATCH v4 7/7] selftests/ftrace: add test cases for VFS type
 "%pd" and "%pD"
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
References: <20240123092139.3698375-1-yebin10@huawei.com>
 <20240123092139.3698375-8-yebin10@huawei.com>
 <20240124103201.6dd8d466b1b734796418c1c4@kernel.org>
CC: <rostedt@goodmis.org>, <mathieu.desnoyers@efficios.com>,
	<linux-trace-kernel@vger.kernel.org>, <linux-kernel@vger.kernel.org>
From: "yebin (H)" <yebin10@huawei.com>
Message-ID: <65B06D97.40308@huawei.com>
Date: Wed, 24 Jan 2024 09:53:27 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.1.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240124103201.6dd8d466b1b734796418c1c4@kernel.org>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 canpemm500010.china.huawei.com (7.192.105.118)



On 2024/1/24 9:32, Masami Hiramatsu (Google) wrote:
> On Tue, 23 Jan 2024 17:21:39 +0800
> Ye Bin <yebin10@huawei.com> wrote:
>
>> This patch adds test cases for new print format type "%pd/%pD".The test cases
>> test the following items:
>> 1. Test README if add "%pd/%pD" type;
>> 2. Test "%pd" type for dput();
>> 3. Test "%pD" type for vfs_read();
>>
>> Signed-off-by: Ye Bin <yebin10@huawei.com>
>> ---
>>   .../ftrace/test.d/kprobe/kprobe_args_vfs.tc   | 79 +++++++++++++++++++
>>   1 file changed, 79 insertions(+)
>>   create mode 100644 tools/testing/selftests/ftrace/test.d/kprobe/kprobe_args_vfs.tc
>>
>> diff --git a/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_args_vfs.tc b/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_args_vfs.tc
>> new file mode 100644
>> index 000000000000..1d8edd294dd6
>> --- /dev/null
>> +++ b/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_args_vfs.tc
>> @@ -0,0 +1,79 @@
>> +#!/bin/sh
>> +# SPDX-License-Identifier: GPL-2.0
>> +# description: Kprobe event VFS type argument
>> +# requires: kprobe_events
>> +
>> +case `uname -m` in
>> +x86_64)
>> +  ARG1=%di
>> +;;
>> +i[3456]86)
>> +  ARG1=%ax
>> +;;
>> +aarch64)
>> +  ARG1=%x0
>> +;;
>> +arm*)
>> +  ARG1=%r0
>> +;;
>> +ppc64*)
>> +  ARG1=%r3
>> +;;
>> +ppc*)
>> +  ARG1=%r3
> You can merge this ppc* and ppc64* cases :)
>
>> +;;
>> +s390*)
>> +  ARG1=%r2
>> +;;
>> +mips*)
>> +  ARG1=%r4
>> +;;
>> +loongarch*)
>> +  ARG1=%r4
>> +;;
>> +riscv*)
>> +  ARG1=%a0
> Anyway, I wonder why don't you use '$arg1' instead of these registers.
> Is there any reason?
>
> Thank you,
Thank you for your advice.
Actually, I wrote the test case by referring to " 
kprobe_args_string.tc". I'll modify it
according to your suggestion.

>> +;;
>> +*)
>> +  echo "Please implement other architecture here"
>> +  exit_untested
>> +esac
>> +
>> +: "Test argument %pd/%pD in README"
>> +grep -q "%pd/%pD" README
>> +
>> +: "Test argument %pd with name"
>> +echo "p:testprobe dput name=${ARG1}:%pd" > kprobe_events
>> +echo 1 > events/kprobes/testprobe/enable
>> +grep -q "1" events/kprobes/testprobe/enable
>> +echo 0 > events/kprobes/testprobe/enable
>> +grep "dput" trace | grep -q "enable"
>> +echo "" > kprobe_events
>> +echo "" > trace
>> +
>> +: "Test argument %pd without name"
>> +echo "p:testprobe dput ${ARG1}:%pd" > kprobe_events
>> +echo 1 > events/kprobes/testprobe/enable
>> +grep -q "1" events/kprobes/testprobe/enable
>> +echo 0 > events/kprobes/testprobe/enable
>> +grep "dput" trace | grep -q "enable"
>> +echo "" > kprobe_events
>> +echo "" > trace
>> +
>> +: "Test argument %pD with name"
>> +echo "p:testprobe vfs_read name=${ARG1}:%pD" > kprobe_events
>> +echo 1 > events/kprobes/testprobe/enable
>> +grep -q "1" events/kprobes/testprobe/enable
>> +echo 0 > events/kprobes/testprobe/enable
>> +grep "vfs_read" trace | grep -q "enable"
>> +echo "" > kprobe_events
>> +echo "" > trace
>> +
>> +: "Test argument %pD without name"
>> +echo "p:testprobe vfs_read ${ARG1}:%pD" > kprobe_events
>> +echo 1 > events/kprobes/testprobe/enable
>> +grep -q "1"  events/kprobes/testprobe/enable
>> +echo 0 > events/kprobes/testprobe/enable
>> +grep "vfs_read" trace | grep -q "enable"
>> +echo "" > kprobe_events
>> +echo "" > trace
>> -- 
>> 2.31.1
>>
>


