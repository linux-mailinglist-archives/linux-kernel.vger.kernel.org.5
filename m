Return-Path: <linux-kernel+bounces-90324-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E9FD86FD99
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 10:29:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2644A1C21A95
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 09:29:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 442D322EEF;
	Mon,  4 Mar 2024 09:26:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ia5EcrpY"
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7681224DE
	for <linux-kernel@vger.kernel.org>; Mon,  4 Mar 2024 09:26:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709544375; cv=none; b=Nia4YHlLVpjM+Yfl2eDrfbRPgOvtafLU+qbe5fPaIVJogIg4C1C7c19M6fC+j4xcv3LlF8yIoQ8rJa9YSDwmudfZcLiKk1PGbF7AAlzPI9LKZgexqxBHCjU4BAY6Jl3I/JtTgiqZ6310LdG5W18E/qpYQtzKISyc3mbDneiXGwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709544375; c=relaxed/simple;
	bh=3gxdjgse67y7XYptiPwcIMmhTe7VR33lWUSVmELHwW8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NlKfMryHRNP9zStI6z/V1eM4q61ilHvbOVEaAaUMK6Xh9es9qvsNbmv0MRtC50sIbCk2kNyVbjGHfFxWc3rMKzZAwKIvrRod+0v8JpeUAiKTZ7lKs2t7UGOqTaRQZOuWglVreFywNWBA32dvinWhA/mtlR0Pqcy7yXNkq3WTNfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ia5EcrpY; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-564fc495d83so5116548a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 04 Mar 2024 01:26:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709544372; x=1710149172; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8SSs3DJIcxXw1e3lTxNpFOhqFCbXvsgZH5bFFnKMSII=;
        b=ia5EcrpYg7XbBtD3ffpBfqzBmCi1xDMEE7dc3KPABWSYxPYZ8NPsAZkMp9NAS3jlcj
         hEobOu2h+9/yTUWUWvwZEPmVS5TuRJEjZFE6eKrz/CIV0/lIkDrzrrWbpnKSPkhd63+j
         TNgiDnOF0FMCAPY02GipW7qliYRL4DPV3vH1JbyMjZeQBxpb0uXbMcP7gkyT89rmPgU8
         gvml6KrymT14ygeF++9n1dLolullIcLavvWD7m0WhPTkvGCRtFZ/K29PH3BZxO/JmodO
         XjiWzTP9iXHU10tlFhY574X+acSveWPH3Fg2Wl6eSz9ob4qLg34tz7CWSw3gUISlp7dV
         NQjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709544372; x=1710149172;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8SSs3DJIcxXw1e3lTxNpFOhqFCbXvsgZH5bFFnKMSII=;
        b=fFnpLNb5JT7rcXhoD2C8ElZtB57OxE92pz/LlNa1WkKedTcXpkm013OwyQraT36CMW
         ALZHBJXoA0YF06aKu+QT2iV9VYVdTa+ZLZ5Fy2zKofRkEChb7uCNx+7e8tCKY9IuQ2KU
         kypKWPICa7LOleNWRbMlymPgUZ3JGdkbVbVb7XifoeHF4IV6qce1c5CR5sg6tZYbLGNC
         4xbza/YJat4A9dsIuXgcwR7siZu/386PU2W6onODUpiMkeHEcCoOJuS28SzwnX6TAPte
         iWCzVGN6ACCiTOLAb8z/YSZ7r89GRrXGIOFytVNWDu9VHNf2DOjUPPAQMnfgSok5whdx
         TTtw==
X-Forwarded-Encrypted: i=1; AJvYcCUgXhv55H9BjdTuSNyCv/xI/6nyd2gw64PxRHclv2DnZOTcbKMSWTv6gAP/7ta8DEpi0lmqpqxA+JroUfjXTJ7H5oh7sILoyLN1Mea2
X-Gm-Message-State: AOJu0Yy8PbOeORqRH2JBuzKWbsx5WMBmxARypCLuA7T+v6TKN19JYIhJ
	aLmh6CGRuOjChK5rXPSIL3s8kDMjUubSvEU2yUdJwz5xRlXVPFLr
X-Google-Smtp-Source: AGHT+IEHTgInl/w6XbkuesjYIuH/BxXxXppOU2Q/JnbcT1Odq96mkibfBODIzqdSlMF+vHcnxqQ6mw==
X-Received: by 2002:aa7:d788:0:b0:566:ec94:5e48 with SMTP id s8-20020aa7d788000000b00566ec945e48mr4341503edq.32.1709544372293;
        Mon, 04 Mar 2024 01:26:12 -0800 (PST)
Received: from gmail.com (1F2EF13F.nat.pool.telekom.hu. [31.46.241.63])
        by smtp.gmail.com with ESMTPSA id h26-20020aa7c95a000000b005663b0d7243sm4345636edt.83.2024.03.04.01.26.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Mar 2024 01:26:11 -0800 (PST)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date: Mon, 4 Mar 2024 10:26:09 +0100
From: Ingo Molnar <mingo@kernel.org>
To: Shrikanth Hegde <sshegde@linux.ibm.com>
Cc: Peter Zijlstra <peterz@infradead.org>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Valentin Schneider <vschneid@redhat.com>,
	LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/7] sched/balancing: Change 'enum cpu_idle_type' to have
 more natural definitions
Message-ID: <ZeWTsTcK+3uvKeju@gmail.com>
References: <20240301110951.3707367-1-mingo@kernel.org>
 <20240301110951.3707367-3-mingo@kernel.org>
 <588d1af3-e619-414f-a26f-467ea51b4ab8@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <588d1af3-e619-414f-a26f-467ea51b4ab8@linux.ibm.com>


* Shrikanth Hegde <sshegde@linux.ibm.com> wrote:

> I think its all getting accounted. Just that its not being printed. With 
> the below change, able to see all the three types, albeit not in right 
> order as per schedstat documentation.
> 
> diff --git a/kernel/sched/stats.c b/kernel/sched/stats.c
> index 857f837f52cb..f36b54bdd9fa 100644
> --- a/kernel/sched/stats.c
> +++ b/kernel/sched/stats.c
> @@ -150,7 +150,7 @@ static int show_schedstat(struct seq_file *seq, void *v)
>  
>                         seq_printf(seq, "domain%d %*pb", dcount++,
>                                    cpumask_pr_args(sched_domain_span(sd)));
> -                       for (itype = CPU_IDLE; itype < CPU_MAX_IDLE_TYPES;
> +                       for (itype = 0; itype < CPU_MAX_IDLE_TYPES;
>                                         itype++) {
>                                 seq_printf(seq, " %u %u %u %u %u %u %u %u",
>                                     sd->lb_count[itype],

Indeed, good catch - there was an implicit reliance on CPU_IDLE's position 
in the loop above that my patch didn't take into account.

Fixed.

Thanks,

	Ingo

