Return-Path: <linux-kernel+bounces-54525-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 37B9584B04D
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 09:48:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CD115B222D4
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 08:48:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F44A12BE83;
	Tue,  6 Feb 2024 08:48:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="foVtXMmx"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 492712E3F0;
	Tue,  6 Feb 2024 08:48:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707209311; cv=none; b=BJuEY0beoRzFkQ2/JKSNuxDJEQvmmZXp07i+CLRefoTpQZvkGHd+1k/Jjx48Y2c7ozVXv/EW5wCEkj0PdfU7kyzGtqMpDwDgXgkCSjoUhEss0QNDqXJEO5PrduyzaUafh4Rju0famu4uQ+Xc92jtV+DJBdC051xcnlQPCMMlocs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707209311; c=relaxed/simple;
	bh=+WjsFcTceA8X8B+jIsmK4AkVAO3quMUcgY/eCwA0gnA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=KLMbVqX1UEi03kcak8efPR5ZJx4Q6Km5NGjzbHzDdaEcqdcYPFgMG9S8X/3HUw0xUDPwDmsUMEcFuOqs6Bnn6sSMyprFrWB5l92/rJdsQp4k9qC73Lsu+Z2cnK34dgb3zn5GpwvlkPbxd5eEmVKymph7R3iCuqmLtk8BgBdNii4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=foVtXMmx; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353727.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 4168gE9h008383;
	Tue, 6 Feb 2024 08:48:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : in-reply-to : references : date : message-id : mime-version :
 content-type; s=pp1; bh=j0CHLrBCXuZm2/lScCN+j8B7uj/p62qacpZ+jr+ClZs=;
 b=foVtXMmx/ORrN7NqDA02NJI/eRI0o91FUUG/X4r3keeVKQw9k3Lwi4iw/fblBQKoANlY
 Z3s9LrCJ9+MRssoCrxM5fkUYxQ/Wb30y8sz0qVeR7OkzOuqfLr84xrDyJ5ctPmjhyADX
 c06brdscJKO2iB/lemCA28WQ85JgA7zMI4MkWDAc1nBDn+I6riwbzErIVGxAT0CKDE7y
 nNg8AFQ/uZh3bw6388r+RUOIfmPsmSDXxb3Wjm56tlCC1DPGDVFppnuxwARckI/+X5mb
 BT3Qx48fFxyl3z/o641TC4QgYR/CGz5bpgnVkpI7RoDpK8BQZtvMhLOUa2qRrRRVolay Aw== 
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3w3hg6g62x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 06 Feb 2024 08:48:21 +0000
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 4165jXJ7014724;
	Tue, 6 Feb 2024 08:48:20 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3w20tnnvrt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 06 Feb 2024 08:48:19 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4168mHFo12386936
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 6 Feb 2024 08:48:17 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5951F20043;
	Tue,  6 Feb 2024 08:48:17 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2C3E220040;
	Tue,  6 Feb 2024 08:48:17 +0000 (GMT)
Received: from tuxmaker.linux.ibm.com (unknown [9.152.85.9])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Tue,  6 Feb 2024 08:48:17 +0000 (GMT)
From: Sven Schnelle <svens@linux.ibm.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
        Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>,
        linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        Mete Durlu <meted@linux.ibm.com>
Subject: Re: [PATCH] tracing: use ring_buffer_record_is_set_on() in
 tracer_tracing_is_on()
In-Reply-To: <yt9d34u63xxz.fsf@linux.ibm.com> (Sven Schnelle's message of
	"Tue, 06 Feb 2024 07:32:08 +0100")
References: <20240205065340.2848065-1-svens@linux.ibm.com>
	<20240205075504.1b55f29c@rorschach.local.home>
	<yt9djznj3vbl.fsf@linux.ibm.com>
	<20240205092353.523cc1ef@rorschach.local.home>
	<yt9d34u63xxz.fsf@linux.ibm.com>
Date: Tue, 06 Feb 2024 09:48:16 +0100
Message-ID: <yt9dsf262d2n.fsf@linux.ibm.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: Fn1fDA3yR4AlgQT39UDWfGUeDdOdEdlK
X-Proofpoint-ORIG-GUID: Fn1fDA3yR4AlgQT39UDWfGUeDdOdEdlK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-06_02,2024-01-31_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 adultscore=0
 priorityscore=1501 clxscore=1015 impostorscore=0 suspectscore=0
 lowpriorityscore=0 spamscore=0 phishscore=0 bulkscore=0 malwarescore=0
 mlxlogscore=720 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402060061

Sven Schnelle <svens@linux.ibm.com> writes:

> Looking at trace_save_cmdline():
>
> tpid = tsk->pid & (PID_MAX_DEFAULT - 1); where PID_MAX_DEFAULT = 0x8000
>
> so this is basically
>
> tpid = tsk->pid & 0x7fff;
>
> further on:
>
>         // might clash with other pid if (otherpid & 0x7fff) == (tsk->pid & 0x7fff)
> 	idx = savedcmd->map_pid_to_cmdline[tpid];
> 	if (idx == NO_CMDLINE_MAP) {
>                 // This will pick an existing entry if there are
>                 // more than cmdline_num entries present
> 		idx = (savedcmd->cmdline_idx + 1) % savedcmd->cmdline_num;      
> 		savedcmd->map_pid_to_cmdline[tpid] = idx;
> 		savedcmd->cmdline_idx = idx;
> 	}
>
> So i think the problem that sometimes '<...>' instead of the correct
> comm is logged is just expected behaviour given the code above. 

I added some logging, and the test is not triggering this issue. So i
assume the default of 128 cmdline entries is just to small. Sorry for
the noise. Lets see whether we're still triggering some failures with
the other fix applied in CI. If we do, maybe we want to increase the
saved_cmdline_size for the ftrace test suite.

