Return-Path: <linux-kernel+bounces-23580-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 18F6182AEA2
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 13:22:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BD1AA28357F
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 12:22:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E6E015AC3;
	Thu, 11 Jan 2024 12:22:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=alu.hr header.i=@alu.hr header.b="pZ5QcuGl";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=alu.unizg.hr header.i=@alu.unizg.hr header.b="Uao2RK5W"
Received: from domac.alu.hr (domac.alu.unizg.hr [161.53.235.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9511E156C7;
	Thu, 11 Jan 2024 12:22:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alu.hr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alu.hr
Received: from localhost (localhost [127.0.0.1])
	by domac.alu.hr (Postfix) with ESMTP id E878B60177;
	Thu, 11 Jan 2024 13:22:41 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.hr; s=mail;
	t=1704975761; bh=Uk8yklKEoRrgk9eAUyK20nUPSlbebqbTL3+vl1utoWI=;
	h=Date:From:To:Cc:Subject:From;
	b=pZ5QcuGlmtKqL6XdK/9LHSGr/7jksEfPwTN0Mwb2tRf1iep5AoGqryi5gzsCRvOWk
	 fEywDwb5DqcetMGH1hbgTW5+1ckqN9ribn/RtgY+D6Bbk4pP8eCutO0P1oiMVY7f28
	 XDrlsSJwoiPgQDLX9rUCKygz0w474L0iagx28Wx67cccs9goEvttsSkd9cHDlZ+Ocl
	 Mza7vEguJE7vbr7CCzYyVnmNDoVhat5g9s1U7zwZhKSWSSxn4l2Aqe/CF2KtGh+9Aa
	 R8PiwR66IixdSQGPUdgRwB5TpwCkqBhwQgGtDKwQrSGMBjeduqpL9S4bHSPv6KsUmL
	 YeKFNL+jc9/DQ==
X-Virus-Scanned: Debian amavisd-new at domac.alu.hr
Received: from domac.alu.hr ([127.0.0.1])
	by localhost (domac.alu.hr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 1b8Y0zAnc3gf; Thu, 11 Jan 2024 13:22:39 +0100 (CET)
Received: from [10.0.1.190] (unknown [161.53.83.23])
	by domac.alu.hr (Postfix) with ESMTPSA id DE24B60171;
	Thu, 11 Jan 2024 13:22:39 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
	t=1704975759; bh=Uk8yklKEoRrgk9eAUyK20nUPSlbebqbTL3+vl1utoWI=;
	h=Date:From:To:Cc:Subject:From;
	b=Uao2RK5WkN8011lHStw83RcojJUubx/2qt/PvLr6Jj5+tiOd+5JE/ze+OSK4VCGVt
	 QoWfr/o5tiPB/MydIqXXVbMeNK+Fr0YhddqalK9E7Uqy1YzQUKgolRdqlEdHgwisnk
	 RjCWMCaptUZb7IM+0VcAttynJ79VdkspvaIOl2TVbYkdfnyeHPQozYf8dMXTVYMs8p
	 wB7yn6TAxvZzjO3OynzNpK/yItLJvMT0i35g4fxGrRV7fMaIGA7XIFPommhAluvNEY
	 6RM03X+OehzuLc1+31rjG39X1cNiew7VQ4aRIR7FNw7EwfSIKn+4ZFjqxezMdatS2G
	 PjhGDfIHCkOBg==
Message-ID: <c2adb439-0dea-4de1-996e-5a0caa5c729d@alu.unizg.hr>
Date: Thu, 11 Jan 2024 13:22:39 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
From: Mirsad Todorovac <mirsad.todorovac@alu.hr>
To: linux-kbuild@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Subject: [PROBLEM] Very long .deb package build times for bindeb-pkg build
 target
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

With this new release, it seems that Debian kernel build uses "xz" in single-
threaded mode:

Tasks: 484 total,   2 running, 481 sleeping,   0 stopped,   1 zombie
%Cpu(s):  2.5 us,  2.2 sy,  6.3 ni, 85.1 id,  2.3 wa,  0.0 hi,  1.7 si,  0.0 st
MiB Mem :  64128.3 total,    524.3 free,   5832.0 used,  58540.9 buff/cache
MiB Swap:  32760.0 total,  32758.7 free,      1.2 used.  58296.3 avail Mem

     PID USER      PR  NI    VIRT    RES    SHR S  %CPU  %MEM     TIME+ COMMAND 

  978084 marvin    30  10  112440  97792   2432 R 100.0   0.1  29:30.23 xz 


Before dpkg-deb was using up to 3200% of CPU time on a 16 core SMT CPU.

Can it be something with dpkg-deb --thread-max=%n option?

Waiting for half an hour just for the build of linux-image-...-dbg package
seems like an overkill ...

Thank you.

Best regards,
Mirsad

