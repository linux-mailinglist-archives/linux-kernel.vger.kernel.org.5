Return-Path: <linux-kernel+bounces-80069-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 13FD4862A6D
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Feb 2024 14:13:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BD3441F21561
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Feb 2024 13:13:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 783E8134AC;
	Sun, 25 Feb 2024 13:13:14 +0000 (UTC)
Received: from out03.mta.xmission.com (out03.mta.xmission.com [166.70.13.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53CE9134A9
	for <linux-kernel@vger.kernel.org>; Sun, 25 Feb 2024 13:13:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.70.13.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708866794; cv=none; b=Akx65yo1++/b2THxhsDGdzr70X1IgMko8uqroKcGl877kQG7NXSktU+yysLFaFWgT7DneEUmrSs/TceHaSri/aeL4VZwgcyzgHTAhxK4BVs7t+87C42SswzT1qTP6b9Dur0MV/A/XLGu4DazXonEGrjoVs56dc04gA09P9LqgKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708866794; c=relaxed/simple;
	bh=9Vnj5mB1X8wGNKgZILN2wE3E/daqZClASQRspBp6Pn0=;
	h=From:To:Cc:References:Date:In-Reply-To:Message-ID:MIME-Version:
	 Content-Type:Subject; b=s+lfF9GBZAGrmmRwjaFZWryyIRValgZtidAsCOow5LNr6ZGDa5CS1LXVOLCnvGg1ml9aPaO8rOxD9P+XuYin0Bk8DAzgp5Irc/wFCa8m2Bk/m5J1z9JzQQ8kTe9XMINOYOktBCUzCs+L/jLU2MQgIA0TSl4g3hGpX2vzdMROrKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xmission.com; spf=pass smtp.mailfrom=xmission.com; arc=none smtp.client-ip=166.70.13.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xmission.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xmission.com
Received: from in01.mta.xmission.com ([166.70.13.51]:35716)
	by out03.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.93)
	(envelope-from <ebiederm@xmission.com>)
	id 1reDds-004xiu-1E; Sun, 25 Feb 2024 05:30:04 -0700
Received: from ip68-227-168-167.om.om.cox.net ([68.227.168.167]:52470 helo=email.froward.int.ebiederm.org.xmission.com)
	by in01.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.93)
	(envelope-from <ebiederm@xmission.com>)
	id 1reDdq-00FXth-Qy; Sun, 25 Feb 2024 05:30:03 -0700
From: "Eric W. Biederman" <ebiederm@xmission.com>
To: wenyang.linux@foxmail.com
Cc: Luis Chamberlain <mcgrof@kernel.org>,  Kees Cook
 <keescook@chromium.org>,  Joel Granados <j.granados@samsung.com>,
  Christian Brauner <brauner@kernel.org>,  davem@davemloft.net,  David
 Ahern <dsahern@kernel.org>,  Eric Dumazet <edumazet@google.com>,  Jakub
 Kicinski <kuba@kernel.org>,  Paolo Abeni <pabeni@redhat.com>,  Shuah Khan
 <skhan@linuxfoundation.org>,  linux-kernel@vger.kernel.org
References: <20240225040538.845899-1-wenyang.linux@foxmail.com>
	<tencent_AA60553AD4DF41859328E9CACC367EFDCF08@qq.com>
Date: Sun, 25 Feb 2024 06:29:33 -0600
In-Reply-To: <tencent_AA60553AD4DF41859328E9CACC367EFDCF08@qq.com> (wenyang
	linux's message of "Sun, 25 Feb 2024 12:05:38 +0800")
Message-ID: <875xyczpzm.fsf@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1reDdq-00FXth-Qy;;;mid=<875xyczpzm.fsf@email.froward.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.227.168.167;;;frm=ebiederm@xmission.com;;;spf=pass
X-XM-AID: U2FsdGVkX19Oi0Xj5vkAVdLGaHDmadvLSejfCvfPTGY=
X-SA-Exim-Connect-IP: 68.227.168.167
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Level: ***
X-Spam-Report: 
	* -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
	*  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
	*      [score: 0.5000]
	*  0.7 XMSubLong Long Subject
	*  1.5 XMNoVowels Alpha-numberic number with no vowels
	*  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
	* -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
	*      [sa07 1397; Body=1 Fuz1=1 Fuz2=1]
	*  0.0 T_TooManySym_01 4+ unique symbols in subject
	*  1.0 XM_Body_Dirty_Words Contains a dirty word
	* -0.0 T_SCC_BODY_TEXT_LINE No description available.
X-Spam-DCC: XMission; sa07 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ***;wenyang.linux@foxmail.com
X-Spam-Relay-Country: 
X-Spam-Timing: total 622 ms - load_scoreonly_sql: 0.03 (0.0%),
	signal_user_changed: 10 (1.5%), b_tie_ro: 8 (1.3%), parse: 0.96 (0.2%),
	 extract_message_metadata: 26 (4.2%), get_uri_detail_list: 2.2 (0.3%),
	tests_pri_-2000: 45 (7.2%), tests_pri_-1000: 2.7 (0.4%),
	tests_pri_-950: 1.20 (0.2%), tests_pri_-900: 0.99 (0.2%),
	tests_pri_-90: 70 (11.2%), check_bayes: 67 (10.9%), b_tokenize: 15
	(2.4%), b_tok_get_all: 10 (1.6%), b_comp_prob: 4.4 (0.7%),
	b_tok_touch_all: 34 (5.5%), b_finish: 1.04 (0.2%), tests_pri_0: 305
	(49.0%), check_dkim_signature: 0.53 (0.1%), check_dkim_adsp: 3.4
	(0.6%), poll_dns_idle: 134 (21.6%), tests_pri_10: 2.2 (0.4%),
	tests_pri_500: 155 (25.0%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH 8/8] ucounts: delete these duplicate static variables
 ue_zero and ue_int_max
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)

wenyang.linux@foxmail.com writes:

> From: Wen Yang <wenyang.linux@foxmail.com>
>
> Since these static variables (ue_zero and ue_int_max) are only used for
> boundary checks and will not be changed, remove it and use the ones in
> our shared const array.

What happened to the plans to kill the shared const array?

You can still save a lot more by turning .extra1 and .extra2
into longs instead of keeping them as pointers and needing
constants to be pointed at somewhere.

As I recall the last version of this actually broke the code,
(but not on little endian).

This one if the constants are properly named looks better
than that, but I don't see any reason why you want shared
constants for such a handful of things.  Especially when
it has proven to be error prone in the past.

The only people I can see who find a significant benefit by
consolidating all of the constants into one place are people who know
how to stomp kernel memory.

Eric


>
> Signed-off-by: Wen Yang <wenyang.linux@foxmail.com>
> Cc: Luis Chamberlain <mcgrof@kernel.org>
> Cc: Kees Cook <keescook@chromium.org>
> Cc: Joel Granados <j.granados@samsung.com>
> Cc: Christian Brauner <brauner@kernel.org>
> Cc: "Eric W. Biederman" <ebiederm@xmission.com>
> Cc: Shuah Khan <skhan@linuxfoundation.org>
> Cc: linux-kernel@vger.kernel.org
> ---
>  kernel/ucount.c | 7 ++-----
>  1 file changed, 2 insertions(+), 5 deletions(-)
>
> diff --git a/kernel/ucount.c b/kernel/ucount.c
> index 4aa6166cb856..05bbba02ae4f 100644
> --- a/kernel/ucount.c
> +++ b/kernel/ucount.c
> @@ -58,17 +58,14 @@ static struct ctl_table_root set_root = {
>  	.permissions = set_permissions,
>  };
>  
> -static long ue_zero = 0;
> -static long ue_int_max = INT_MAX;
> -
>  #define UCOUNT_ENTRY(name)					\
>  	{							\
>  		.procname	= name,				\
>  		.maxlen		= sizeof(long),			\
>  		.mode		= 0644,				\
>  		.proc_handler	= proc_doulongvec_minmax,	\
> -		.extra1		= &ue_zero,			\
> -		.extra2		= &ue_int_max,			\
> +		.extra1		= SYSCTL_LONG_ZERO,		\
> +		.extra2		= SYSCTL_LONG_S32_MAX,		\
>  	}
>  static struct ctl_table user_table[] = {
>  	UCOUNT_ENTRY("max_user_namespaces"),

