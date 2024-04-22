Return-Path: <linux-kernel+bounces-153539-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 42B138ACF59
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 16:28:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C42D31F214B5
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 14:28:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C57061514DD;
	Mon, 22 Apr 2024 14:27:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="AvRcdhh6"
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32A781509AE
	for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 14:27:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713796077; cv=none; b=dAkrrb7/sKnB0dMnlJMaPRVkY/SZ5kiX/hvKyw5JpIhENdB6I4vhIJ8AH1N2xOsBfrtUJn+PPXaip4zkFp2YiEfthRjnT4EVoa7aSA6BDZUJ5CX4EBe0l8HpHUMgdZHfwpoWg4YwgyT22eUzaaWaOk1Y754oo7TeSf3HB8I8ef0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713796077; c=relaxed/simple;
	bh=UNBjOTY0qs0uiF8EORx5BtyTGJtQ6MyutJpELBAOp5E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oJGv+BrS+bJ5feQ/dHT5FZjhog41dwWnWnsihaAVpjAapFLoO9gx5yUKLCjFZCSO6HTbGDHfI7s7sTHCFHpKm/XOWHREacwoOefYuaIPramuxYtlOYXm/T9LRUOF7FGiV8QTV6iTSsg4iiELF/fPaduZJ4ZVZUr+rSds222P0Wg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=AvRcdhh6; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2dde561f852so1987931fa.2
        for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 07:27:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713796072; x=1714400872; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UNBjOTY0qs0uiF8EORx5BtyTGJtQ6MyutJpELBAOp5E=;
        b=AvRcdhh6bssrwby6uQ53USsUaKKfA+EIjVX759zcaKj7AUOyOVcb5e+Gds//W8ik/P
         5eJf9yOG2L6bWP60UKgMm61rwbzoWkWZLYigGPhAfGDqy9kao664Tjs5dmvX9EIccXVw
         uOtWZM92YdGqraWkksh+1ibfbv1kwFVdR1kFnPCGvBy719BZ5Mykhtp2V0VFlLdT/1+2
         Ev3PlMbAsuz3Cu97Aos2IWeCW8Y4wwl51tee9K2Ct0OQ2BB5exzpelb6+XoMLtAkM/s1
         ztNZT6H9z7X+3cWolCjRGbkIOC5aZYow7I6ZvEWXg2MmyEa5BihCupNafaKfF1Upekju
         qpYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713796072; x=1714400872;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UNBjOTY0qs0uiF8EORx5BtyTGJtQ6MyutJpELBAOp5E=;
        b=r9nBoSg90IbwpUUAtsGflIxGuB3rBPXLWZN23ZDRYOiPDPOTViQGOkKfId3nt6kR0K
         NuMk/P/xco6EmpaaoBCdjW4VS/cnxXQ53sl78jnidVdEn46yE/B3Q8dkHmPibHfqNaAM
         PgrrYQv6KaysIE27gD1ebMF+/f+P1lGb4gFXnWJ1EgWeLUjHlQZt/gE67bFEVWj1SSHp
         7dy/3JxyN3z1I0PNnAvnw78J4tVdTUtU+DBUERFSW8V2VYYiBpkMJcye+YMdKBhR895d
         LobaAHjlgZc047FziqmZWtcoHwoEpjqeVwW2mgEyEdOnsLCviOnS7ZXhUPoptjEdUIhT
         MX1A==
X-Gm-Message-State: AOJu0Yy7wkgsoQbaQjDYQLngKi1hZ17YN7bKxuwaxxfepMGVqYg4TRIZ
	PVlLdrZf0/huiBYih2wsB1FOksx8VrX0z+E1Xb2URkYjs5UHviqxwWxIhl1dAWU=
X-Google-Smtp-Source: AGHT+IEkN6CNdQTBKxKxXZBn2HlML3rafBsTIUTuTxt2ocrHVbXK17h0QDhg5Z61h1NNgJ6JKtrQow==
X-Received: by 2002:a2e:805a:0:b0:2db:99e4:dbdd with SMTP id p26-20020a2e805a000000b002db99e4dbddmr5541085ljg.53.1713796072319;
        Mon, 22 Apr 2024 07:27:52 -0700 (PDT)
Received: from [172.30.205.46] (UNUSED.212-182-62-129.lubman.net.pl. [212.182.62.129])
        by smtp.gmail.com with ESMTPSA id p5-20020a2e93c5000000b002dce3eab848sm1076631ljh.47.2024.04.22.07.27.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Apr 2024 07:27:51 -0700 (PDT)
Message-ID: <36a1ea2f-92c2-4183-a892-00c5b48c419b@linaro.org>
Date: Mon, 22 Apr 2024 16:27:47 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 00/10] sysctl: Remove sentinel elements from kernel dir
To: Joel Granados <j.granados@samsung.com>,
 Luis Chamberlain <mcgrof@kernel.org>, josh@joshtriplett.org,
 Kees Cook <keescook@chromium.org>, Eric Biederman <ebiederm@xmission.com>,
 Iurii Zaikin <yzaikin@google.com>, Steven Rostedt <rostedt@goodmis.org>,
 Masami Hiramatsu <mhiramat@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Thomas Gleixner <tglx@linutronix.de>, John Stultz <jstultz@google.com>,
 Stephen Boyd <sboyd@kernel.org>, Andy Lutomirski <luto@amacapital.net>,
 Will Drewry <wad@chromium.org>, Ingo Molnar <mingo@redhat.com>,
 Peter Zijlstra <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>, Ben Segall
 <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
 Daniel Bristot de Oliveira <bristot@redhat.com>,
 Valentin Schneider <vschneid@redhat.com>, Petr Mladek <pmladek@suse.com>,
 John Ogness <john.ogness@linutronix.de>,
 Sergey Senozhatsky <senozhatsky@chromium.org>,
 "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>,
 Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
 "David S. Miller" <davem@davemloft.net>, Balbir Singh
 <bsingharora@gmail.com>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 John Fastabend <john.fastabend@gmail.com>,
 Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau
 <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>
Cc: linux-kernel@vger.kernel.org, kexec@lists.infradead.org,
 linux-fsdevel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 bpf@vger.kernel.org, tools@kernel.org
References: <20240328-jag-sysctl_remove_empty_elem_kernel-v3-0-285d273912fe@samsung.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20240328-jag-sysctl_remove_empty_elem_kernel-v3-0-285d273912fe@samsung.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 3/28/24 16:44, Joel Granados wrote:
> What?
> These commits remove the sentinel element (last empty element) from the
> sysctl arrays of all the files under the "kernel/" directory that use a
> sysctl array for registration. The merging of the preparation patches
> [1] to mainline allows us to remove sentinel elements without changing
> behavior. This is safe because the sysctl registration code
> (register_sysctl() and friends) use the array size in addition to
> checking for a sentinel [2].

Hi,

looks like *this* "patch" made it to the sysctl tree [1], breaking b4
for everyone else (as there's a "--- b4-submit-tracking ---" magic in
the tree history now) on next-20240422

Please drop it (again, I'm only talking about this empty cover letter).

Konrad

[1] https://git.kernel.org/pub/scm/linux/kernel/git/sysctl/sysctl.git/commit/?h=sysctl-next&id=ec04a7fa09ddedc1d6c8b86ae281897256c7fdf0

