Return-Path: <linux-kernel+bounces-83282-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 44E4D869140
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 14:04:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C5B4C1F23602
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 13:04:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B142013AA4B;
	Tue, 27 Feb 2024 13:03:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qepq9O5M"
Received: from mail-oo1-f48.google.com (mail-oo1-f48.google.com [209.85.161.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4A3813AA2A;
	Tue, 27 Feb 2024 13:03:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709039020; cv=none; b=l/noqC0/pWUFs49Mqk+tglo/zKyoUbE6Yi1FWyfxAuaj7CcRjtXg6OiX/kI20o8g6VFrJxeydWvuztf6MlSgAXbDIlKRLD4+kbXlejOPcDifWLUVZstWzfiWxzl4jFF+Dro6JMYOnqgYLYA3DnGqL/jBHtqBZWVuBrC6f3snIlE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709039020; c=relaxed/simple;
	bh=yjFZErIVd1mDusvuksq1t7SXmfcmu7MEmP29L+s1+3I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=q7RCJ3en8Qi9CotxaCCNcawxBiMuGME7u9HoOd7rATNRr9oG4/0nlH7uIp7dTNM1bMR6gNMXoieRJmRCHLdMVMFrkbAQVI9BL9WmKpYSwLPMJII8BCbzmqR7Mp6TkIHmK74cQH2kl5GfhQLfBSIzyzBg7OgDEcDIYM/EMJD0ihc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Qepq9O5M; arc=none smtp.client-ip=209.85.161.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f48.google.com with SMTP id 006d021491bc7-5a0a19c9bb7so930093eaf.3;
        Tue, 27 Feb 2024 05:03:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709039018; x=1709643818; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S3JVqu+QlLfD+a7olzF5yj2OYnoi6pWCcsDzhbKv67M=;
        b=Qepq9O5Mdmt6Nb8SupEDgWpZ1qg4hqKd9YuXto3VA/pXUSWhJpD50MXYIiZWGdOU+L
         soJ+U6uMF4ZfDWg4fpYSsShZm0mxLbcPzzgz5LUWtUg9hJjDXon5agfYBUZBT88HE3WM
         ESqkwhyPgxNJ9AVnRuC5ARm+ny4h2Ah3mkDyRo/FPUrcscJKPr0T8rQ2vJyMHi/Wuw64
         4Ei11J52kMRGaPHH06mPw/TXBVVcdP//Xf9p1R/VtEbXKp7X+pnwWIOm6RK31ONsaDXR
         xKOJZsS1HBdNUQRBUVUQR+WaEc018+GdGGUR6ALwc3dJqHeVbNfkR7LBzxcKSm5epOWW
         zOkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709039018; x=1709643818;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=S3JVqu+QlLfD+a7olzF5yj2OYnoi6pWCcsDzhbKv67M=;
        b=DyOXtJrOC9Bgc2gtNxgpUAzCN0vzTVRC68U0W07mWypkDnDnGT8HwGo5CfGc/RY5xD
         GES8VOwmGPAkMcXPmhwQe5OCHrlNsAaDhODb5zSK5Gz4hyJcTRQxVOmPOLo5Ix4AvYFs
         UXh1OX/8WIo7Ok1ktSn0wgr8M/D7ux0s+7GI9981DdhW+Rcnb9BOe75yjVuHzdHkj3ff
         I0u6djcG3tWEX5uL6FgQZslCzCXiMyLQRuMWnx/NbzKxOxuYXpzhoQWEbD1ZQHSKVVjZ
         QWH/s9mwMzyiivfNwDiXFR3S60C/u43hyV5hpM/u0ikI3iJJ4hiNFcEt92iUKxAo1YPD
         PAnw==
X-Forwarded-Encrypted: i=1; AJvYcCVS95eRNLUFyNmgw+6m5R5QYxu9R9a2Gq0tOvUJhv6OuEQH+XBkNBnJvpBW2U86I8QIezsQ8FIgxMcbF9W5h+z5frD1xP69yAqxibZL125YPLb887AsHZx4depAfTPZVgl6bgnJzZZpZA==
X-Gm-Message-State: AOJu0YxKVH092VhzRik3cLi0uJiOG4DfGjKSE9O69uTvKhRTOyjaJQUc
	/F+nzJfP6iZIt5g7nm2DtwQDIzclPG3BvTL7zZDQk50uJ3wYajp5hSOArq3PxGPzrGCNTelE5xz
	/B7ozCZgitec9hsW8b3aqf7Z0YXg=
X-Google-Smtp-Source: AGHT+IFBJnd1JbLgNvE3v1j3u/f3xE8yJrMViSPG+A0o5LOyHyqt2s5jOPEtzNXGxcrcf3l2cU9wBQ2ClEFo2vLEOas=
X-Received: by 2002:a4a:625a:0:b0:5a0:3bfa:72a6 with SMTP id
 y26-20020a4a625a000000b005a03bfa72a6mr9123958oog.1.1709039016537; Tue, 27 Feb
 2024 05:03:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240205171930.968-1-linux.amoon@gmail.com> <20240205171930.968-3-linux.amoon@gmail.com>
 <26732d5a-9fe1-4662-9362-ed397d266e01@linaro.org>
In-Reply-To: <26732d5a-9fe1-4662-9362-ed397d266e01@linaro.org>
From: Anand Moon <linux.amoon@gmail.com>
Date: Tue, 27 Feb 2024 18:33:20 +0530
Message-ID: <CANAwSgTgh1eBf5ptaLWNv1g6vzLJnNfKdvjkhqn-K2555nmjgA@mail.gmail.com>
Subject: Re: [PATCHv1 2/5] arm64: dts: amlogic: Add cache information to the
 Amlogic SM1 SoC
To: neil.armstrong@linaro.org
Cc: Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Kevin Hilman <khilman@baylibre.com>, Jerome Brunet <jbrunet@baylibre.com>, 
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-amlogic@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Neil,

On Tue, 6 Feb 2024 at 14:24, Neil Armstrong <neil.armstrong@linaro.org> wro=
te:
>
> On 05/02/2024 18:19, Anand Moon wrote:
> > As per S905X3 datasheet add missing cache information to the Amlogic
> > SM1 SoC. ARM Cortex-A55 CPU uses unified L3 cache instead of L2 cache.
> >
> > - Each Cortex-A55 core has 32KB of L1 instruction cache available and
> >       32KB of L1 data cache available.
> > - Along with 512KB Unified L3 cache.
>
> This 512K number is for the NPU, AFAIK the CPU L3 Cache size isn't specif=
ied in the datasheet
>
OK,

As per Arm Cotex A55 TRM it supports cache.
[0] https://developer.arm.com/documentation/100442/0200/Functional-descript=
ion/Introduction-to-the-Cortex-A55-core/Implementation-options

As per the datasheet
[1] https://dn.odroid.com/S905X3/ODROID-C4/Docs/S905X3_Public_Datasheet_Har=
dkernel.pdf

TheCortex=E2=84=A2-A55M subsystem of the chipisa high-performance,
low-power,ARM macro cell with an L1 and L3
cache sub system that provide full virtual memory capabilities.

Best way to let the Amlogic SoC members comment on the CPU  L1/ //L2/
L3 cache size.
But with the lack of pref PMU events we cannot test this feature.

[root@odroid-c4 alarm]# perf list

List of pre-defined events (to be used in -e or -M):

  alignment-faults                                   [Software event]
  bpf-output                                         [Software event]
  cgroup-switches                                    [Software event]
  context-switches OR cs                             [Software event]

List of pre-defined events (to be used in -e or -M):

  alignment-faults                                   [Software event]
  bpf-output                                         [Software event]
  cgroup-switches                                    [Software event]
  context-switches OR cs                             [Software event]
  cpu-clock                                          [Software event]
  cpu-migrations OR migrations                       [Software event]
  dummy                                              [Software event]
  emulation-faults                                   [Software event]
  major-faults                                       [Software event]
  minor-faults                                       [Software event]
  page-faults OR faults                              [Software event]
  task-clock                                         [Software event]
  duration_time                                      [Tool event]
  user_time                                          [Tool event]
  system_time                                        [Tool event]
  rNNN                                               [Raw hardware event de=
scri>
  cpu/t1=3Dv1[,t2=3Dv2,t3 ...]/modifier                  [Raw hardware even=
t descri>
       [(see 'man perf-list' on how to encode it)]
  mem:<addr>[/len][:access]                          [Hardware breakpoint]
  alarmtimer:alarmtimer_cancel                       [Tracepoint event]
  alarmtimer:alarmtimer_fired                        [Tracepoint event]
  alarmtimer:alarmtimer_start                        [Tracepoint event]
  alarmtimer:alarmtimer_suspend                      [Tracepoint event]
  asoc:snd_soc_bias_level_done                       [Tracepoint event]
  asoc:snd_soc_bias_level_start                      [Tracepoint event]
  asoc:snd_soc_dapm_connected                        [Tracepoint event]
  asoc:snd_soc_dapm_done                             [Tracepoint event]
  asoc:snd_soc_dapm_path                             [Tracepoint event]
  asoc:snd_soc_dapm_start                            [Tracepoint event]
  asoc:snd_soc_dapm_walk_done                        [Tracepoint event]
  asoc:snd_soc_dapm_widget_event_done                [Tracepoint event]
  asoc:snd_soc_dapm_widget_event_start               [Tracepoint event]
  asoc:snd_soc_dapm_widget_power                     [Tracepoint event]



Thanks



-Anand

