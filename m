Return-Path: <linux-kernel+bounces-55987-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 75F6584C47F
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 06:51:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A27DD1C251FC
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 05:51:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6824814F98;
	Wed,  7 Feb 2024 05:51:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="btcJX+Av"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 518541CD19;
	Wed,  7 Feb 2024 05:51:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707285070; cv=none; b=JufTvkusZdbO6ZL7m3URyU19Bsb0woTFno8itiXTwvnHzonH3vUjtTrNBtN1Jz97vDj5X34lj84J1C/pCU/Iw0XAICdg1FCuG7H4x8s/IFezxG/omDMtRFa3QF4GxbSEdIxWdx6flnP3zDbqUC+XDBt4pJRFQLKw8YAr3nNVsR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707285070; c=relaxed/simple;
	bh=6HFE5XbPkuv4IpUMzgPKK0ywUly+m6JEn80embN3fwQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=RzaQAwR7I3G4k9BMI8X6opC2zWefG0pD6rlno+ypD+sYbZfFebl1utoxjFHV4hrseItMJ3rNwY5ktFY3qjuFBVcRZtGw9ypZyzhWM3IvFvsWf2/4V+T5qig8LP07ncxU6mzndiDdGxFYCBBrHT2jXSRQWmQMSvPzCGGF4u0qBOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=btcJX+Av; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 4175M2YO030237;
	Wed, 7 Feb 2024 05:51:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : in-reply-to : references : date : message-id : mime-version :
 content-type; s=pp1; bh=6HFE5XbPkuv4IpUMzgPKK0ywUly+m6JEn80embN3fwQ=;
 b=btcJX+AvDkJ47AjCW3IomtbuPjmpkUS+WlM/Ca9wzmAaGRZFusT5kKtXUvFov4hVX9uk
 7dSJT4Hk+Wo+Tpo2OYDSQhc1HPxHhz3G4Kdf4NsI5U1JLuT3XfAuuyWauzOs1D9vxPuc
 6FDtiZy/jQDKw0ExkBDUJ3ft7cQkWLe5CTXk+0gslUBcwNCMH1MbU4kGmysYqE+X9fFk
 6DbyVEFBrDrG+DgDLX3SUHQ2x93oXnEUyB1BJvARq+GnSUCuiAebA9ehoEpA+yaA5erl
 dfJGQ3FAYUjtGfKJE65FzKcghFOjXC2Y/Uc2VhMfJd7Yox8+RhV7bUQnd5XnqhbLS5AH MA== 
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3w43nb0m3s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 07 Feb 2024 05:51:03 +0000
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 4174o1cF014739;
	Wed, 7 Feb 2024 05:51:02 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3w20tnuvgn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 07 Feb 2024 05:51:02 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4175p0VN1311332
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 7 Feb 2024 05:51:00 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 294AB2004B;
	Wed,  7 Feb 2024 05:51:00 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E4E4F20040;
	Wed,  7 Feb 2024 05:50:59 +0000 (GMT)
Received: from tuxmaker.linux.ibm.com (unknown [9.152.85.9])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Wed,  7 Feb 2024 05:50:59 +0000 (GMT)
From: Sven Schnelle <svens@linux.ibm.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
        Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>,
        linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        Mete Durlu <meted@linux.ibm.com>
Subject: Re: [PATCH] tracing: use ring_buffer_record_is_set_on() in
 tracer_tracing_is_on()
In-Reply-To: <20240206060113.39c0f5bc@rorschach.local.home> (Steven Rostedt's
	message of "Tue, 6 Feb 2024 06:01:13 -0500")
References: <20240205065340.2848065-1-svens@linux.ibm.com>
	<20240205075504.1b55f29c@rorschach.local.home>
	<yt9djznj3vbl.fsf@linux.ibm.com>
	<20240205092353.523cc1ef@rorschach.local.home>
	<yt9d34u63xxz.fsf@linux.ibm.com> <yt9dsf262d2n.fsf@linux.ibm.com>
	<20240206060113.39c0f5bc@rorschach.local.home>
Date: Wed, 07 Feb 2024 06:50:59 +0100
Message-ID: <yt9deddovn3w.fsf@linux.ibm.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: FuTFExxk6Ff0yYrXjiA9ALP_kp81Bs_E
X-Proofpoint-GUID: FuTFExxk6Ff0yYrXjiA9ALP_kp81Bs_E
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-06_16,2024-01-31_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=735
 malwarescore=0 phishscore=0 bulkscore=0 adultscore=0 suspectscore=0
 clxscore=1015 impostorscore=0 lowpriorityscore=0 mlxscore=0
 priorityscore=1501 spamscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2311290000 definitions=main-2402070042

Hi Steven,

Steven Rostedt <rostedt@goodmis.org> writes:

> On Tue, 06 Feb 2024 09:48:16 +0100
> Sven Schnelle <svens@linux.ibm.com> wrote:
>
>> I added some logging, and the test is not triggering this issue. So i
>> assume the default of 128 cmdline entries is just to small. Sorry for
>> the noise. Lets see whether we're still triggering some failures with
>> the other fix applied in CI. If we do, maybe we want to increase the
>> saved_cmdline_size for the ftrace test suite.
>
> I wonder if it is a good idea to increase the size when tracing starts,
> like the ring buffer expanding code. Maybe to 1024? Or is that still
> too small?

Not sure whether that is enough, have to test. However, it's not really
a fix, it would just require a bit more load and the test would fail
again. The fundamental problem is that even after disabling tracing
there might be some tracing line added due to the lockless nature of
the ringbuffer. This might then replace some existing cmdline entry.
So maybe we should change the test to ignore the program name when
calculating the checksums.

