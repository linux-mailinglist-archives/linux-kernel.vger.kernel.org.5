Return-Path: <linux-kernel+bounces-51293-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 932A68488E0
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Feb 2024 22:01:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7C2261F219DF
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Feb 2024 21:01:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4F0911C83;
	Sat,  3 Feb 2024 21:01:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Lr8k/9AG"
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A56F1118E
	for <linux-kernel@vger.kernel.org>; Sat,  3 Feb 2024 21:01:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706994067; cv=none; b=L+Lv58PdiBZfx5BaxsjFXVD3MzbJA6Ku0zxDqFmQcEjhglLWGHS1dfC1574S7cWjTsbpDwYWBlN1RYYcoM38QS9ixm5T1MtlI1SnrdRAGl+9yuKbFQ22btzfLqA6RLzwqr5veKah5LMFW/TBDYmO3Tfuw6+aSitWKngQuqI06DY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706994067; c=relaxed/simple;
	bh=nHLWDYHF017Zrm+26yNP71pmyNxAQQg9ZlHEBeO86rE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=ETga8LtAYg0qmaMiFLXTPLMIlHtyMqEcw9Rvl6u9HwQ/FOvwcwFFoBHCMDVH6MbBaMf0qkKWOiMUUfvnsS6WyMDj2zPLNYComnWnHj9v0/RQWA+KZwS/mch+lGMK5b4Zcbjy/k/Kr2uVptYZmO8b5p7zhuLq67m1XyZj7dHefOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Lr8k/9AG; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-40ef6f10b56so27795675e9.2
        for <linux-kernel@vger.kernel.org>; Sat, 03 Feb 2024 13:01:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706994062; x=1707598862; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HZHEw7r62oDgn74nqIVNJ93e2dbeSeu1A1aKy31wnhM=;
        b=Lr8k/9AGJm4mWzInENOvT8Ne7Zs7CpfSV9COZ6RGI7hDRdx6VK6zbPTik5cvy3E4zb
         cTtFarqd948oCa6yjFu52ABNUlBxgBLTxQYGMaIUY6kSdvyMLCwTLoJN/1ukBp94W51e
         kAwGjpt+qCWWC4EL4XPUUwngDh+85yQKhBGV26g6dzX2aqKUZqEuL8vPGQPqUP/jg4hF
         r7IRQpM2q6d1fu1Zle8d71EBLv13wuMt9pndkvT1/79wOhtejaoSEo9wrnBhR+su37yY
         RHEY5oIhPP1YAmfiCtj01yLie4OgFEc5G/ii0p7KTlMFGOL6NidC4iynEN7dBmcOjxD6
         6l3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706994062; x=1707598862;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HZHEw7r62oDgn74nqIVNJ93e2dbeSeu1A1aKy31wnhM=;
        b=evft2inPtC6pL7uVBzlZHgtTeS8P2aT9rVtkQM8sVobwlMlfgghBlcfSCnP/J5MNkF
         D1Ef5r/bZIH7NTB4aDrtoTfuGU3G3RCxaf0nbVIFtlP/3qEwDM959Ar0MBDvoMb+AAkS
         E7vqrOrumruYraZy8A4jCn3nYV6GBbheHZ+TGRyZyJE4Tlm50shKKAlol7ImfmyGZEH3
         4vylMOIHo7zaBbx/AuPFnQ+4EV85q2nZupz1AJ4sx2ktrkCvSqa46PgF0KOsV0XueLYT
         4qU0FqWpNbws+mOeLBSEnokzhgvWFtvLd6xpELyChKU7cO3cQy1d10JriCXIuuiUXc6G
         Bm6w==
X-Gm-Message-State: AOJu0YwiIwDS27OD0WPaQL+MW7aJ9Bmhq7uP2J1YgkQEVHddCxLB3FME
	oHxkPkVip7ByTgXKz7CJlZZGZAiYFhPkhxMrdRLXdqB/cFwbWhOJqrK4Y2ToZKlwh/JUV29aOTU
	B9btbA8Wvw+NEusaPA2D+DeE875HeeB6C
X-Google-Smtp-Source: AGHT+IFxbBv5ISAd1jGySmahCQXtGLNjBGCyTOyXrmrgWz71sbDYPrltHQTgAGXAnxkxcqKSGuXkY9ORdKKmX3zkuL8=
X-Received: by 2002:a5d:67c3:0:b0:33a:f00c:cb5 with SMTP id
 n3-20020a5d67c3000000b0033af00c0cb5mr5440339wrw.6.1706994061315; Sat, 03 Feb
 2024 13:01:01 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAB0z4NpPhaZcSxynWjk5tATVU2dFcHEqfGxkos43v_KnbUnpXw@mail.gmail.com>
In-Reply-To: <CAB0z4NpPhaZcSxynWjk5tATVU2dFcHEqfGxkos43v_KnbUnpXw@mail.gmail.com>
From: CIJOML CIJOMLovic <cijoml@gmail.com>
Date: Sat, 3 Feb 2024 22:00:49 +0100
Message-ID: <CAB0z4NqdpW_Ov-ZpmvZVqvMke4HLPP9kw6S3yJwxN_zUgvCvVw@mail.gmail.com>
Subject: Fwd: Wifi intel card error
To: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello guys,

today I got following error message:
My kernel:
root@cijoml-HP-EliteBook-840-G5:/home/cijoml# uname -a
Linux cijoml-HP-EliteBook-840-G5 5.15.0-92-generic #102-Ubuntu SMP Wed
Jan 10 09:33:48 UTC 2024 x86_64 x86_64 x86_64 GNU/Linux

[  924.214086] iwlwifi 0000:01:00.0: Microcode SW error detected.
Restarting 0x0.
[  924.214220] iwlwifi 0000:01:00.0: Start IWL Error Log Dump:
[  924.214227] iwlwifi 0000:01:00.0: Transport status: 0x0000004A, valid: 6
[  924.214236] iwlwifi 0000:01:00.0: Loaded firmware version:
66.f1c864e0.0 ty-a0-gf-a0-66.ucode
[  924.214244] iwlwifi 0000:01:00.0: 0x000028AA | ADVANCED_SYSASSERT
[  924.214252] iwlwifi 0000:01:00.0: 0x000002F0 | trm_hw_status0
[  924.214258] iwlwifi 0000:01:00.0: 0x00000000 | trm_hw_status1
[  924.214265] iwlwifi 0000:01:00.0: 0x004DA722 | branchlink2
[  924.214271] iwlwifi 0000:01:00.0: 0x004D0CCE | interruptlink1
[  924.214277] iwlwifi 0000:01:00.0: 0x004D0CCE | interruptlink2
[  924.214283] iwlwifi 0000:01:00.0: 0x0000002A | data1
[  924.214289] iwlwifi 0000:01:00.0: 0x40080000 | data2
[  924.214295] iwlwifi 0000:01:00.0: 0x054FFFFF | data3
[  924.214301] iwlwifi 0000:01:00.0: 0xB1C18F59 | beacon time
[  924.214307] iwlwifi 0000:01:00.0: 0xBC3890AB | tsf low
[  924.214313] iwlwifi 0000:01:00.0: 0x0000031D | tsf hi
[  924.214319] iwlwifi 0000:01:00.0: 0x00000000 | time gp1
[  924.214325] iwlwifi 0000:01:00.0: 0x3699145E | time gp2
[  924.214331] iwlwifi 0000:01:00.0: 0x00000001 | uCode revision type
[  924.214337] iwlwifi 0000:01:00.0: 0x00000042 | uCode version major
[  924.214343] iwlwifi 0000:01:00.0: 0xF1C864E0 | uCode version minor
[  924.214349] iwlwifi 0000:01:00.0: 0x00000420 | hw version
[  924.214355] iwlwifi 0000:01:00.0: 0x00C89002 | board version
[  924.214361] iwlwifi 0000:01:00.0: 0x80E5FD0B | hcmd
[  924.214367] iwlwifi 0000:01:00.0: 0x00020000 | isr0
[  924.214373] iwlwifi 0000:01:00.0: 0x00000000 | isr1
[  924.214378] iwlwifi 0000:01:00.0: 0x48F84002 | isr2
[  924.214384] iwlwifi 0000:01:00.0: 0x44C3428C | isr3
[  924.214389] iwlwifi 0000:01:00.0: 0x00000000 | isr4
[  924.214395] iwlwifi 0000:01:00.0: 0x057E001C | last cmd Id
[  924.214401] iwlwifi 0000:01:00.0: 0x004D7C72 | wait_event
[  924.214407] iwlwifi 0000:01:00.0: 0x00000000 | l2p_control
[  924.214413] iwlwifi 0000:01:00.0: 0x00000000 | l2p_duration
[  924.214419] iwlwifi 0000:01:00.0: 0x00000000 | l2p_mhvalid
[  924.214424] iwlwifi 0000:01:00.0: 0x00000000 | l2p_addr_match
[  924.214430] iwlwifi 0000:01:00.0: 0x0000001B | lmpm_pmg_sel
[  924.214436] iwlwifi 0000:01:00.0: 0x00000000 | timestamp
[  924.214442] iwlwifi 0000:01:00.0: 0x0000803C | flow_handler
[  924.214507] iwlwifi 0000:01:00.0: Start IWL Error Log Dump:
[  924.214513] iwlwifi 0000:01:00.0: Transport status: 0x0000004A, valid: 7
[  924.214520] iwlwifi 0000:01:00.0: 0x20000070 | NMI_INTERRUPT_LMAC_FATAL
[  924.214527] iwlwifi 0000:01:00.0: 0x00000000 | umac branchlink1
[  924.214533] iwlwifi 0000:01:00.0: 0x8045DFC6 | umac branchlink2
[  924.214539] iwlwifi 0000:01:00.0: 0x8047FAB6 | umac interruptlink1
[  924.214545] iwlwifi 0000:01:00.0: 0x8047FAB6 | umac interruptlink2
[  924.214550] iwlwifi 0000:01:00.0: 0x00000002 | umac data1
[  924.214556] iwlwifi 0000:01:00.0: 0x8047FAB6 | umac data2
[  924.214562] iwlwifi 0000:01:00.0: 0x00000000 | umac data3
[  924.214567] iwlwifi 0000:01:00.0: 0x00000042 | umac major
[  924.214573] iwlwifi 0000:01:00.0: 0xF1C864E0 | umac minor
[  924.214578] iwlwifi 0000:01:00.0: 0x369915DD | frame pointer
[  924.214584] iwlwifi 0000:01:00.0: 0xC088625C | stack pointer
[  924.214634] iwlwifi 0000:01:00.0: 0x0061010C | last host cmd
[  924.214641] iwlwifi 0000:01:00.0: 0x00000000 | isr status reg
[  924.214679] iwlwifi 0000:01:00.0: IML/ROM dump:
[  924.214687] iwlwifi 0000:01:00.0: 0x00000B03 | IML/ROM error/state
[  924.214727] iwlwifi 0000:01:00.0: 0x00007022 | IML/ROM data1
[  924.214758] iwlwifi 0000:01:00.0: 0x00000090 | IML/ROM WFPM_AUTH_KEY_0
[  924.214784] iwlwifi 0000:01:00.0: Fseq Registers:
[  924.214805] iwlwifi 0000:01:00.0: 0x60000100 | FSEQ_ERROR_CODE
[  924.214828] iwlwifi 0000:01:00.0: 0x00440005 | FSEQ_TOP_INIT_VERSION
[  924.214869] iwlwifi 0000:01:00.0: 0x00080009 | FSEQ_CNVIO_INIT_VERSION
[  924.214898] iwlwifi 0000:01:00.0: 0x0000A652 | FSEQ_OTP_VERSION
[  924.214920] iwlwifi 0000:01:00.0: 0x00000002 | FSEQ_TOP_CONTENT_VERSION
[  924.214941] iwlwifi 0000:01:00.0: 0x4552414E | FSEQ_ALIVE_TOKEN
[  924.214962] iwlwifi 0000:01:00.0: 0x00400410 | FSEQ_CNVI_ID
[  924.214984] iwlwifi 0000:01:00.0: 0x00400410 | FSEQ_CNVR_ID
[  924.215005] iwlwifi 0000:01:00.0: 0x00400410 | CNVI_AUX_MISC_CHIP
[  924.215028] iwlwifi 0000:01:00.0: 0x00400410 | CNVR_AUX_MISC_CHIP
[  924.215078] iwlwifi 0000:01:00.0: 0x00009061 |
CNVR_SCU_SD_REGS_SD_REG_DIG_DCDC_VTRIM
[  924.215103] iwlwifi 0000:01:00.0: 0x00000061 |
CNVR_SCU_SD_REGS_SD_REG_ACTIVE_VDIG_MIRROR
[  924.215272] iwlwifi 0000:01:00.0: WRT: Collecting data: ini trigger
4 fired (delay=0ms).
[  924.215285] ieee80211 phy0: Hardware restart was requested
[  924.799950] iwlwifi 0000:01:00.0: Failed to send the temperature
measurement command (err=-5)
[  942.338463] iwlwifi 0000:01:00.0: Microcode SW error detected.
Restarting 0x0.
[  942.338595] iwlwifi 0000:01:00.0: Start IWL Error Log Dump:
[  942.338602] iwlwifi 0000:01:00.0: Transport status: 0x0000004A, valid: 6
[  942.338611] iwlwifi 0000:01:00.0: Loaded firmware version:
66.f1c864e0.0 ty-a0-gf-a0-66.ucode
[  942.338622] iwlwifi 0000:01:00.0: 0x000028AA | ADVANCED_SYSASSERT
[  942.338643] iwlwifi 0000:01:00.0: 0x000002F0 | trm_hw_status0
[  942.338655] iwlwifi 0000:01:00.0: 0x00000000 | trm_hw_status1
[  942.338665] iwlwifi 0000:01:00.0: 0x004DA722 | branchlink2
[  942.338675] iwlwifi 0000:01:00.0: 0x004D0CCE | interruptlink1
[  942.338685] iwlwifi 0000:01:00.0: 0x004D0CCE | interruptlink2
[  942.338696] iwlwifi 0000:01:00.0: 0x0000002A | data1
[  942.338706] iwlwifi 0000:01:00.0: 0x40080000 | data2
[  942.338716] iwlwifi 0000:01:00.0: 0x054FFFFF | data3
[  942.338726] iwlwifi 0000:01:00.0: 0x2A418F67 | beacon time
[  942.338735] iwlwifi 0000:01:00.0: 0xBD4D20A0 | tsf low
[  942.338744] iwlwifi 0000:01:00.0: 0x0000031D | tsf hi
[  942.338751] iwlwifi 0000:01:00.0: 0x00000000 | time gp1
[  942.338757] iwlwifi 0000:01:00.0: 0x010B3707 | time gp2
[  942.338764] iwlwifi 0000:01:00.0: 0x00000001 | uCode revision type
[  942.338769] iwlwifi 0000:01:00.0: 0x00000042 | uCode version major
[  942.338775] iwlwifi 0000:01:00.0: 0xF1C864E0 | uCode version minor
[  942.338781] iwlwifi 0000:01:00.0: 0x00000420 | hw version
[  942.338787] iwlwifi 0000:01:00.0: 0x00C89002 | board version
[  942.338793] iwlwifi 0000:01:00.0: 0x80FDF400 | hcmd
[  942.338799] iwlwifi 0000:01:00.0: 0x00020000 | isr0
[  942.338805] iwlwifi 0000:01:00.0: 0x00000000 | isr1
[  942.338811] iwlwifi 0000:01:00.0: 0x48F84002 | isr2
[  942.338816] iwlwifi 0000:01:00.0: 0x44C3408C | isr3
[  942.338822] iwlwifi 0000:01:00.0: 0x00000000 | isr4
[  942.338827] iwlwifi 0000:01:00.0: 0x8ECF009D | last cmd Id
[  942.338833] iwlwifi 0000:01:00.0: 0x004D7C72 | wait_event
[  942.338839] iwlwifi 0000:01:00.0: 0x00000000 | l2p_control
[  942.338844] iwlwifi 0000:01:00.0: 0x00000000 | l2p_duration
[  942.338850] iwlwifi 0000:01:00.0: 0x00000000 | l2p_mhvalid
[  942.338856] iwlwifi 0000:01:00.0: 0x00000000 | l2p_addr_match
[  942.338861] iwlwifi 0000:01:00.0: 0x0000001B | lmpm_pmg_sel
[  942.338867] iwlwifi 0000:01:00.0: 0x00000000 | timestamp
[  942.338873] iwlwifi 0000:01:00.0: 0x0000B0EC | flow_handler
[  942.339001] iwlwifi 0000:01:00.0: Start IWL Error Log Dump:
[  942.339013] iwlwifi 0000:01:00.0: Transport status: 0x0000004A, valid: 7
[  942.339024] iwlwifi 0000:01:00.0: 0x20000070 | NMI_INTERRUPT_LMAC_FATAL
[  942.339035] iwlwifi 0000:01:00.0: 0x00000000 | umac branchlink1
[  942.339044] iwlwifi 0000:01:00.0: 0x8045DFC6 | umac branchlink2
[  942.339055] iwlwifi 0000:01:00.0: 0x8047FAB6 | umac interruptlink1
[  942.339067] iwlwifi 0000:01:00.0: 0x8047FAB6 | umac interruptlink2
[  942.339076] iwlwifi 0000:01:00.0: 0x00000002 | umac data1
[  942.339085] iwlwifi 0000:01:00.0: 0x8047FAB6 | umac data2
[  942.339094] iwlwifi 0000:01:00.0: 0x00000000 | umac data3
[  942.339105] iwlwifi 0000:01:00.0: 0x00000042 | umac major
[  942.339116] iwlwifi 0000:01:00.0: 0xF1C864E0 | umac minor
[  942.339127] iwlwifi 0000:01:00.0: 0x010B3885 | frame pointer
[  942.339136] iwlwifi 0000:01:00.0: 0xC088625C | stack pointer
[  942.339146] iwlwifi 0000:01:00.0: 0x00630400 | last host cmd
[  942.339155] iwlwifi 0000:01:00.0: 0x00000000 | isr status reg
[  942.339200] iwlwifi 0000:01:00.0: IML/ROM dump:
[  942.339213] iwlwifi 0000:01:00.0: 0x00000B03 | IML/ROM error/state
[  942.339253] iwlwifi 0000:01:00.0: 0x00007025 | IML/ROM data1
[  942.339286] iwlwifi 0000:01:00.0: 0x00000090 | IML/ROM WFPM_AUTH_KEY_0
[  942.339314] iwlwifi 0000:01:00.0: Fseq Registers:
[  942.339339] iwlwifi 0000:01:00.0: 0x60000100 | FSEQ_ERROR_CODE
[  942.339372] iwlwifi 0000:01:00.0: 0x00440005 | FSEQ_TOP_INIT_VERSION
[  942.339406] iwlwifi 0000:01:00.0: 0x00080009 | FSEQ_CNVIO_INIT_VERSION
[  942.339439] iwlwifi 0000:01:00.0: 0x0000A652 | FSEQ_OTP_VERSION
[  942.339483] iwlwifi 0000:01:00.0: 0x00000002 | FSEQ_TOP_CONTENT_VERSION
[  942.339515] iwlwifi 0000:01:00.0: 0x4552414E | FSEQ_ALIVE_TOKEN
[  942.339548] iwlwifi 0000:01:00.0: 0x00400410 | FSEQ_CNVI_ID
[  942.339582] iwlwifi 0000:01:00.0: 0x00400410 | FSEQ_CNVR_ID
[  942.339614] iwlwifi 0000:01:00.0: 0x00400410 | CNVI_AUX_MISC_CHIP
[  942.339649] iwlwifi 0000:01:00.0: 0x00400410 | CNVR_AUX_MISC_CHIP
[  942.339684] iwlwifi 0000:01:00.0: 0x00009061 |
CNVR_SCU_SD_REGS_SD_REG_DIG_DCDC_VTRIM
[  942.339720] iwlwifi 0000:01:00.0: 0x00000061 |
CNVR_SCU_SD_REGS_SD_REG_ACTIVE_VDIG_MIRROR
[  942.339931] iwlwifi 0000:01:00.0: WRT: Collecting data: ini trigger
4 fired (delay=0ms).
[  942.339951] ieee80211 phy0: Hardware restart was requested
[  971.215312] iwlwifi 0000:01:00.0: Microcode SW error detected.
Restarting 0x0.
[  971.215486] iwlwifi 0000:01:00.0: Start IWL Error Log Dump:
[  971.215495] iwlwifi 0000:01:00.0: Transport status: 0x0000004A, valid: 6
[  971.215505] iwlwifi 0000:01:00.0: Loaded firmware version:
66.f1c864e0.0 ty-a0-gf-a0-66.ucode
[  971.215512] iwlwifi 0000:01:00.0: 0x000028AA | ADVANCED_SYSASSERT
[  971.215520] iwlwifi 0000:01:00.0: 0x000002F0 | trm_hw_status0
[  971.215527] iwlwifi 0000:01:00.0: 0x00000000 | trm_hw_status1
[  971.215533] iwlwifi 0000:01:00.0: 0x004DA722 | branchlink2
[  971.215539] iwlwifi 0000:01:00.0: 0x004D0CCE | interruptlink1
[  971.215545] iwlwifi 0000:01:00.0: 0x004D0CCE | interruptlink2
[  971.215551] iwlwifi 0000:01:00.0: 0x0000002A | data1
[  971.215557] iwlwifi 0000:01:00.0: 0x40080000 | data2
[  971.215563] iwlwifi 0000:01:00.0: 0x054FFFFF | data3
[  971.215570] iwlwifi 0000:01:00.0: 0x44818F62 | beacon time
[  971.215576] iwlwifi 0000:01:00.0: 0xBF05C0A1 | tsf low
[  971.215582] iwlwifi 0000:01:00.0: 0x0000031D | tsf hi
[  971.215588] iwlwifi 0000:01:00.0: 0x00000000 | time gp1
[  971.215594] iwlwifi 0000:01:00.0: 0x01AF27D5 | time gp2
[  971.215601] iwlwifi 0000:01:00.0: 0x00000001 | uCode revision type
[  971.215607] iwlwifi 0000:01:00.0: 0x00000042 | uCode version major
[  971.215614] iwlwifi 0000:01:00.0: 0xF1C864E0 | uCode version minor
[  971.215620] iwlwifi 0000:01:00.0: 0x00000420 | hw version
[  971.215627] iwlwifi 0000:01:00.0: 0x00C89002 | board version
[  971.215633] iwlwifi 0000:01:00.0: 0x80EEFD0B | hcmd
[  971.215639] iwlwifi 0000:01:00.0: 0x00020000 | isr0
[  971.215645] iwlwifi 0000:01:00.0: 0x00000000 | isr1
[  971.215651] iwlwifi 0000:01:00.0: 0x48F84002 | isr2
[  971.215656] iwlwifi 0000:01:00.0: 0x44C3408C | isr3
[  971.215661] iwlwifi 0000:01:00.0: 0x00000000 | isr4
[  971.215667] iwlwifi 0000:01:00.0: 0x027B001C | last cmd Id
[  971.215672] iwlwifi 0000:01:00.0: 0x004D7C72 | wait_event
[  971.215678] iwlwifi 0000:01:00.0: 0x00000000 | l2p_control
[  971.215684] iwlwifi 0000:01:00.0: 0x00000000 | l2p_duration
[  971.215689] iwlwifi 0000:01:00.0: 0x00000000 | l2p_mhvalid
[  971.215695] iwlwifi 0000:01:00.0: 0x00000000 | l2p_addr_match
[  971.215701] iwlwifi 0000:01:00.0: 0x0000001B | lmpm_pmg_sel
[  971.215706] iwlwifi 0000:01:00.0: 0x00000000 | timestamp
[  971.215712] iwlwifi 0000:01:00.0: 0x00000800 | flow_handler
[  971.215777] iwlwifi 0000:01:00.0: Start IWL Error Log Dump:
[  971.215782] iwlwifi 0000:01:00.0: Transport status: 0x0000004A, valid: 7
[  971.215789] iwlwifi 0000:01:00.0: 0x20000070 | NMI_INTERRUPT_LMAC_FATAL
[  971.215796] iwlwifi 0000:01:00.0: 0x00000000 | umac branchlink1
[  971.215803] iwlwifi 0000:01:00.0: 0x8045DFC6 | umac branchlink2
[  971.215809] iwlwifi 0000:01:00.0: 0x8047FAB6 | umac interruptlink1
[  971.215815] iwlwifi 0000:01:00.0: 0x8047FAB6 | umac interruptlink2
[  971.215821] iwlwifi 0000:01:00.0: 0x00000002 | umac data1
[  971.215827] iwlwifi 0000:01:00.0: 0x8047FAB6 | umac data2
[  971.215833] iwlwifi 0000:01:00.0: 0x00000000 | umac data3
[  971.215839] iwlwifi 0000:01:00.0: 0x00000042 | umac major
[  971.215845] iwlwifi 0000:01:00.0: 0xF1C864E0 | umac minor
[  971.215851] iwlwifi 0000:01:00.0: 0x01AF2954 | frame pointer
[  971.215857] iwlwifi 0000:01:00.0: 0xC088625C | stack pointer
[  971.215864] iwlwifi 0000:01:00.0: 0x00710400 | last host cmd
[  971.215871] iwlwifi 0000:01:00.0: 0x00000000 | isr status reg
[  971.215911] iwlwifi 0000:01:00.0: IML/ROM dump:
[  971.215917] iwlwifi 0000:01:00.0: 0x00000B03 | IML/ROM error/state
[  971.215956] iwlwifi 0000:01:00.0: 0x00007086 | IML/ROM data1
[  971.215989] iwlwifi 0000:01:00.0: 0x00000090 | IML/ROM WFPM_AUTH_KEY_0
[  971.216018] iwlwifi 0000:01:00.0: Fseq Registers:
[  971.216040] iwlwifi 0000:01:00.0: 0x60000100 | FSEQ_ERROR_CODE
[  971.216061] iwlwifi 0000:01:00.0: 0x00440005 | FSEQ_TOP_INIT_VERSION
[  971.216083] iwlwifi 0000:01:00.0: 0x00080009 | FSEQ_CNVIO_INIT_VERSION
[  971.216105] iwlwifi 0000:01:00.0: 0x0000A652 | FSEQ_OTP_VERSION
[  971.216126] iwlwifi 0000:01:00.0: 0x00000002 | FSEQ_TOP_CONTENT_VERSION
[  971.216148] iwlwifi 0000:01:00.0: 0x4552414E | FSEQ_ALIVE_TOKEN
[  971.216170] iwlwifi 0000:01:00.0: 0x00400410 | FSEQ_CNVI_ID
[  971.216203] iwlwifi 0000:01:00.0: 0x00400410 | FSEQ_CNVR_ID
[  971.216224] iwlwifi 0000:01:00.0: 0x00400410 | CNVI_AUX_MISC_CHIP
[  971.216248] iwlwifi 0000:01:00.0: 0x00400410 | CNVR_AUX_MISC_CHIP
[  971.216271] iwlwifi 0000:01:00.0: 0x00009061 |
CNVR_SCU_SD_REGS_SD_REG_DIG_DCDC_VTRIM
[  971.216295] iwlwifi 0000:01:00.0: 0x00000061 |
CNVR_SCU_SD_REGS_SD_REG_ACTIVE_VDIG_MIRROR
[  971.216466] iwlwifi 0000:01:00.0: WRT: Collecting data: ini trigger
4 fired (delay=0ms).
[  971.216481] ieee80211 phy0: Hardware restart was requested
[ 1202.535918] iwlwifi 0000:01:00.0: Microcode SW error detected.
Restarting 0x0.
[ 1202.536065] iwlwifi 0000:01:00.0: Start IWL Error Log Dump:
[ 1202.536073] iwlwifi 0000:01:00.0: Transport status: 0x0000004A, valid: 6
[ 1202.536082] iwlwifi 0000:01:00.0: Loaded firmware version:
66.f1c864e0.0 ty-a0-gf-a0-66.ucode
[ 1202.536089] iwlwifi 0000:01:00.0: 0x000028AA | ADVANCED_SYSASSERT
[ 1202.536098] iwlwifi 0000:01:00.0: 0x000002F0 | trm_hw_status0
[ 1202.536104] iwlwifi 0000:01:00.0: 0x00000000 | trm_hw_status1
[ 1202.536110] iwlwifi 0000:01:00.0: 0x004DA722 | branchlink2
[ 1202.536117] iwlwifi 0000:01:00.0: 0x004D0CCE | interruptlink1
[ 1202.536123] iwlwifi 0000:01:00.0: 0x004D0CCE | interruptlink2
[ 1202.536128] iwlwifi 0000:01:00.0: 0x0000002A | data1
[ 1202.536134] iwlwifi 0000:01:00.0: 0x40080000 | data2
[ 1202.536140] iwlwifi 0000:01:00.0: 0x054FFFFF | data3
[ 1202.536146] iwlwifi 0000:01:00.0: 0x32C002EE | beacon time
[ 1202.536152] iwlwifi 0000:01:00.0: 0xCCCF6D13 | tsf low
[ 1202.536158] iwlwifi 0000:01:00.0: 0x0000031D | tsf hi
[ 1202.536164] iwlwifi 0000:01:00.0: 0x00000000 | time gp1
[ 1202.536170] iwlwifi 0000:01:00.0: 0x0DC02AB5 | time gp2
[ 1202.536176] iwlwifi 0000:01:00.0: 0x00000001 | uCode revision type
[ 1202.536182] iwlwifi 0000:01:00.0: 0x00000042 | uCode version major
[ 1202.536188] iwlwifi 0000:01:00.0: 0xF1C864E0 | uCode version minor
[ 1202.536194] iwlwifi 0000:01:00.0: 0x00000420 | hw version
[ 1202.536200] iwlwifi 0000:01:00.0: 0x00C89002 | board version
[ 1202.536206] iwlwifi 0000:01:00.0: 0x8065FD0B | hcmd
[ 1202.536212] iwlwifi 0000:01:00.0: 0x00020000 | isr0
[ 1202.536218] iwlwifi 0000:01:00.0: 0x00080000 | isr1
[ 1202.536223] iwlwifi 0000:01:00.0: 0x48F84002 | isr2
[ 1202.536229] iwlwifi 0000:01:00.0: 0x40C3408C | isr3
[ 1202.536234] iwlwifi 0000:01:00.0: 0x00000000 | isr4
[ 1202.536240] iwlwifi 0000:01:00.0: 0x009E019C | last cmd Id
[ 1202.536246] iwlwifi 0000:01:00.0: 0x004D7C72 | wait_event
[ 1202.536252] iwlwifi 0000:01:00.0: 0x00000000 | l2p_control
[ 1202.536257] iwlwifi 0000:01:00.0: 0x00000000 | l2p_duration
[ 1202.536263] iwlwifi 0000:01:00.0: 0x00000000 | l2p_mhvalid
[ 1202.536269] iwlwifi 0000:01:00.0: 0x00000000 | l2p_addr_match
[ 1202.536275] iwlwifi 0000:01:00.0: 0x0000001B | lmpm_pmg_sel
[ 1202.536281] iwlwifi 0000:01:00.0: 0x00000000 | timestamp
[ 1202.536286] iwlwifi 0000:01:00.0: 0x0000A0A0 | flow_handler
[ 1202.536348] iwlwifi 0000:01:00.0: Start IWL Error Log Dump:
[ 1202.536353] iwlwifi 0000:01:00.0: Transport status: 0x0000004A, valid: 7
[ 1202.536360] iwlwifi 0000:01:00.0: 0x20000070 | NMI_INTERRUPT_LMAC_FATAL
[ 1202.536367] iwlwifi 0000:01:00.0: 0x00000000 | umac branchlink1
[ 1202.536373] iwlwifi 0000:01:00.0: 0x8045DFC6 | umac branchlink2
[ 1202.536379] iwlwifi 0000:01:00.0: 0x8047FAB6 | umac interruptlink1
[ 1202.536385] iwlwifi 0000:01:00.0: 0x8047FAB6 | umac interruptlink2
[ 1202.536390] iwlwifi 0000:01:00.0: 0x00000002 | umac data1
[ 1202.536396] iwlwifi 0000:01:00.0: 0x8047FAB6 | umac data2
[ 1202.536402] iwlwifi 0000:01:00.0: 0x00000000 | umac data3
[ 1202.536407] iwlwifi 0000:01:00.0: 0x00000042 | umac major
[ 1202.536413] iwlwifi 0000:01:00.0: 0xF1C864E0 | umac minor
[ 1202.536418] iwlwifi 0000:01:00.0: 0x0DC02C34 | frame pointer
[ 1202.536424] iwlwifi 0000:01:00.0: 0xC088625C | stack pointer
[ 1202.536430] iwlwifi 0000:01:00.0: 0x009E019C | last host cmd
[ 1202.536436] iwlwifi 0000:01:00.0: 0x00000000 | isr status reg
[ 1202.536472] iwlwifi 0000:01:00.0: IML/ROM dump:
[ 1202.536477] iwlwifi 0000:01:00.0: 0x00000B03 | IML/ROM error/state
[ 1202.536517] iwlwifi 0000:01:00.0: 0x0000711C | IML/ROM data1
[ 1202.536546] iwlwifi 0000:01:00.0: 0x00000090 | IML/ROM WFPM_AUTH_KEY_0
[ 1202.536570] iwlwifi 0000:01:00.0: Fseq Registers:
[ 1202.536591] iwlwifi 0000:01:00.0: 0x60000100 | FSEQ_ERROR_CODE
[ 1202.536612] iwlwifi 0000:01:00.0: 0x00440005 | FSEQ_TOP_INIT_VERSION
[ 1202.536634] iwlwifi 0000:01:00.0: 0x00080009 | FSEQ_CNVIO_INIT_VERSION
[ 1202.536656] iwlwifi 0000:01:00.0: 0x0000A652 | FSEQ_OTP_VERSION
[ 1202.536677] iwlwifi 0000:01:00.0: 0x00000002 | FSEQ_TOP_CONTENT_VERSION
[ 1202.536699] iwlwifi 0000:01:00.0: 0x4552414E | FSEQ_ALIVE_TOKEN
[ 1202.536720] iwlwifi 0000:01:00.0: 0x00400410 | FSEQ_CNVI_ID
[ 1202.536741] iwlwifi 0000:01:00.0: 0x00400410 | FSEQ_CNVR_ID
[ 1202.536763] iwlwifi 0000:01:00.0: 0x00400410 | CNVI_AUX_MISC_CHIP
[ 1202.536786] iwlwifi 0000:01:00.0: 0x00400410 | CNVR_AUX_MISC_CHIP
[ 1202.536809] iwlwifi 0000:01:00.0: 0x00009061 |
CNVR_SCU_SD_REGS_SD_REG_DIG_DCDC_VTRIM
[ 1202.536833] iwlwifi 0000:01:00.0: 0x00000061 |
CNVR_SCU_SD_REGS_SD_REG_ACTIVE_VDIG_MIRROR
[ 1202.537001] iwlwifi 0000:01:00.0: WRT: Collecting data: ini trigger
4 fired (delay=0ms).
[ 1202.537017] ieee80211 phy0: Hardware restart was requested
[ 1226.703290] iwlwifi 0000:01:00.0: Microcode SW error detected.
Restarting 0x0.
[ 1226.703425] iwlwifi 0000:01:00.0: Start IWL Error Log Dump:
[ 1226.703432] iwlwifi 0000:01:00.0: Transport status: 0x0000004A, valid: 6
[ 1226.703441] iwlwifi 0000:01:00.0: Loaded firmware version:
66.f1c864e0.0 ty-a0-gf-a0-66.ucode
[ 1226.703449] iwlwifi 0000:01:00.0: 0x000028AA | ADVANCED_SYSASSERT
[ 1226.703457] iwlwifi 0000:01:00.0: 0x000002F0 | trm_hw_status0
[ 1226.703463] iwlwifi 0000:01:00.0: 0x00000000 | trm_hw_status1
[ 1226.703470] iwlwifi 0000:01:00.0: 0x004DA722 | branchlink2
[ 1226.703476] iwlwifi 0000:01:00.0: 0x004D0CCE | interruptlink1
[ 1226.703482] iwlwifi 0000:01:00.0: 0x004D0CCE | interruptlink2
[ 1226.703487] iwlwifi 0000:01:00.0: 0x0000002A | data1
[ 1226.703493] iwlwifi 0000:01:00.0: 0x40080000 | data2
[ 1226.703499] iwlwifi 0000:01:00.0: 0x054FFFFF | data3
[ 1226.703505] iwlwifi 0000:01:00.0: 0x39018F58 | beacon time
[ 1226.703511] iwlwifi 0000:01:00.0: 0xCE4030AE | tsf low
[ 1226.703516] iwlwifi 0000:01:00.0: 0x0000031D | tsf hi
[ 1226.703522] iwlwifi 0000:01:00.0: 0x00000000 | time gp1
[ 1226.703528] iwlwifi 0000:01:00.0: 0x01674BA4 | time gp2
[ 1226.703534] iwlwifi 0000:01:00.0: 0x00000001 | uCode revision type
[ 1226.703540] iwlwifi 0000:01:00.0: 0x00000042 | uCode version major
[ 1226.703546] iwlwifi 0000:01:00.0: 0xF1C864E0 | uCode version minor
[ 1226.703552] iwlwifi 0000:01:00.0: 0x00000420 | hw version
[ 1226.703558] iwlwifi 0000:01:00.0: 0x00C89002 | board version
[ 1226.703563] iwlwifi 0000:01:00.0: 0x8077FC18 | hcmd
[ 1226.703569] iwlwifi 0000:01:00.0: 0x00020000 | isr0
[ 1226.703575] iwlwifi 0000:01:00.0: 0x00080000 | isr1
[ 1226.703580] iwlwifi 0000:01:00.0: 0x48F84002 | isr2
[ 1226.703586] iwlwifi 0000:01:00.0: 0x44C3428C | isr3
[ 1226.703591] iwlwifi 0000:01:00.0: 0x00000000 | isr4
[ 1226.703597] iwlwifi 0000:01:00.0: 0x006A019C | last cmd Id
[ 1226.703603] iwlwifi 0000:01:00.0: 0x004D7C72 | wait_event
[ 1226.703608] iwlwifi 0000:01:00.0: 0x00000000 | l2p_control
[ 1226.703614] iwlwifi 0000:01:00.0: 0x00000000 | l2p_duration
[ 1226.703619] iwlwifi 0000:01:00.0: 0x00000000 | l2p_mhvalid
[ 1226.703625] iwlwifi 0000:01:00.0: 0x00000000 | l2p_addr_match
[ 1226.703631] iwlwifi 0000:01:00.0: 0x0000001B | lmpm_pmg_sel
[ 1226.703637] iwlwifi 0000:01:00.0: 0x00000000 | timestamp
[ 1226.703642] iwlwifi 0000:01:00.0: 0x0000E840 | flow_handler
[ 1226.703708] iwlwifi 0000:01:00.0: Start IWL Error Log Dump:
[ 1226.703713] iwlwifi 0000:01:00.0: Transport status: 0x0000004A, valid: 7
[ 1226.703720] iwlwifi 0000:01:00.0: 0x20000070 | NMI_INTERRUPT_LMAC_FATAL
[ 1226.703727] iwlwifi 0000:01:00.0: 0x00000000 | umac branchlink1
[ 1226.703733] iwlwifi 0000:01:00.0: 0x8045DFC6 | umac branchlink2
[ 1226.703739] iwlwifi 0000:01:00.0: 0x8047FAB6 | umac interruptlink1
[ 1226.703745] iwlwifi 0000:01:00.0: 0x8047FAB6 | umac interruptlink2
[ 1226.703750] iwlwifi 0000:01:00.0: 0x00000002 | umac data1
[ 1226.703756] iwlwifi 0000:01:00.0: 0x8047FAB6 | umac data2
[ 1226.703762] iwlwifi 0000:01:00.0: 0x00000000 | umac data3
[ 1226.703767] iwlwifi 0000:01:00.0: 0x00000042 | umac major
[ 1226.703773] iwlwifi 0000:01:00.0: 0xF1C864E0 | umac minor
[ 1226.703778] iwlwifi 0000:01:00.0: 0x01674D23 | frame pointer
[ 1226.703784] iwlwifi 0000:01:00.0: 0xC088625C | stack pointer
[ 1226.703790] iwlwifi 0000:01:00.0: 0x006B0400 | last host cmd
[ 1226.703795] iwlwifi 0000:01:00.0: 0x00000000 | isr status reg
[ 1226.703835] iwlwifi 0000:01:00.0: IML/ROM dump:
[ 1226.703840] iwlwifi 0000:01:00.0: 0x00000B03 | IML/ROM error/state
[ 1226.703876] iwlwifi 0000:01:00.0: 0x00007287 | IML/ROM data1
[ 1226.703905] iwlwifi 0000:01:00.0: 0x00000090 | IML/ROM WFPM_AUTH_KEY_0
[ 1226.703930] iwlwifi 0000:01:00.0: Fseq Registers:
[ 1226.703950] iwlwifi 0000:01:00.0: 0x60000100 | FSEQ_ERROR_CODE
[ 1226.703972] iwlwifi 0000:01:00.0: 0x00440005 | FSEQ_TOP_INIT_VERSION
[ 1226.703993] iwlwifi 0000:01:00.0: 0x00080009 | FSEQ_CNVIO_INIT_VERSION
[ 1226.704015] iwlwifi 0000:01:00.0: 0x0000A652 | FSEQ_OTP_VERSION
[ 1226.704037] iwlwifi 0000:01:00.0: 0x00000002 | FSEQ_TOP_CONTENT_VERSION
[ 1226.704059] iwlwifi 0000:01:00.0: 0x4552414E | FSEQ_ALIVE_TOKEN
[ 1226.704080] iwlwifi 0000:01:00.0: 0x00400410 | FSEQ_CNVI_ID
[ 1226.704102] iwlwifi 0000:01:00.0: 0x00400410 | FSEQ_CNVR_ID
[ 1226.704123] iwlwifi 0000:01:00.0: 0x00400410 | CNVI_AUX_MISC_CHIP
[ 1226.704146] iwlwifi 0000:01:00.0: 0x00400410 | CNVR_AUX_MISC_CHIP
[ 1226.704170] iwlwifi 0000:01:00.0: 0x00009061 |
CNVR_SCU_SD_REGS_SD_REG_DIG_DCDC_VTRIM
[ 1226.704194] iwlwifi 0000:01:00.0: 0x00000061 |
CNVR_SCU_SD_REGS_SD_REG_ACTIVE_VDIG_MIRROR
[ 1226.704361] iwlwifi 0000:01:00.0: WRT: Collecting data: ini trigger
4 fired (delay=0ms).
[ 1226.704376] ieee80211 phy0: Hardware restart was requested
[ 1248.514488] iwlwifi 0000:01:00.0: Microcode SW error detected.
Restarting 0x0.
[ 1248.514646] iwlwifi 0000:01:00.0: Start IWL Error Log Dump:
[ 1248.514660] iwlwifi 0000:01:00.0: Transport status: 0x0000004A, valid: 6
[ 1248.514674] iwlwifi 0000:01:00.0: Loaded firmware version:
66.f1c864e0.0 ty-a0-gf-a0-66.ucode
[ 1248.514687] iwlwifi 0000:01:00.0: 0x000028AA | ADVANCED_SYSASSERT
[ 1248.514701] iwlwifi 0000:01:00.0: 0x000002F0 | trm_hw_status0
[ 1248.514711] iwlwifi 0000:01:00.0: 0x00000000 | trm_hw_status1
[ 1248.514721] iwlwifi 0000:01:00.0: 0x004DA722 | branchlink2
[ 1248.514731] iwlwifi 0000:01:00.0: 0x004D0CCE | interruptlink1
[ 1248.514741] iwlwifi 0000:01:00.0: 0x004D0CCE | interruptlink2
[ 1248.514747] iwlwifi 0000:01:00.0: 0x0000002A | data1
[ 1248.514753] iwlwifi 0000:01:00.0: 0x40080000 | data2
[ 1248.514760] iwlwifi 0000:01:00.0: 0x054FFFFF | data3
[ 1248.514765] iwlwifi 0000:01:00.0: 0x33418F5A | beacon time
[ 1248.514772] iwlwifi 0000:01:00.0: 0xCF8D00AB | tsf low
[ 1248.514777] iwlwifi 0000:01:00.0: 0x0000031D | tsf hi
[ 1248.514783] iwlwifi 0000:01:00.0: 0x00000000 | time gp1
[ 1248.514789] iwlwifi 0000:01:00.0: 0x01437BB4 | time gp2
[ 1248.514795] iwlwifi 0000:01:00.0: 0x00000001 | uCode revision type
[ 1248.514801] iwlwifi 0000:01:00.0: 0x00000042 | uCode version major
[ 1248.514807] iwlwifi 0000:01:00.0: 0xF1C864E0 | uCode version minor
[ 1248.514813] iwlwifi 0000:01:00.0: 0x00000420 | hw version
[ 1248.514818] iwlwifi 0000:01:00.0: 0x00C89002 | board version
[ 1248.514824] iwlwifi 0000:01:00.0: 0x8035FD0B | hcmd
[ 1248.514830] iwlwifi 0000:01:00.0: 0x00020000 | isr0
[ 1248.514836] iwlwifi 0000:01:00.0: 0x00080000 | isr1
[ 1248.514841] iwlwifi 0000:01:00.0: 0x48F84002 | isr2
[ 1248.514847] iwlwifi 0000:01:00.0: 0x44C3408C | isr3
[ 1248.514852] iwlwifi 0000:01:00.0: 0x00000000 | isr4
[ 1248.514858] iwlwifi 0000:01:00.0: 0x8D44009D | last cmd Id
[ 1248.514864] iwlwifi 0000:01:00.0: 0x004D7C72 | wait_event
[ 1248.514869] iwlwifi 0000:01:00.0: 0x00000000 | l2p_control
[ 1248.514875] iwlwifi 0000:01:00.0: 0x00000000 | l2p_duration
[ 1248.514881] iwlwifi 0000:01:00.0: 0x00000000 | l2p_mhvalid
[ 1248.514886] iwlwifi 0000:01:00.0: 0x00000000 | l2p_addr_match
[ 1248.514892] iwlwifi 0000:01:00.0: 0x0000001B | lmpm_pmg_sel
[ 1248.514898] iwlwifi 0000:01:00.0: 0x00000000 | timestamp
[ 1248.514907] iwlwifi 0000:01:00.0: 0x00005038 | flow_handler
[ 1248.514989] iwlwifi 0000:01:00.0: Start IWL Error Log Dump:
[ 1248.515000] iwlwifi 0000:01:00.0: Transport status: 0x0000004A, valid: 7
[ 1248.515014] iwlwifi 0000:01:00.0: 0x20000070 | NMI_INTERRUPT_LMAC_FATAL
[ 1248.515025] iwlwifi 0000:01:00.0: 0x00000000 | umac branchlink1
[ 1248.515034] iwlwifi 0000:01:00.0: 0x8045DFC6 | umac branchlink2
[ 1248.515044] iwlwifi 0000:01:00.0: 0x8047FAB6 | umac interruptlink1
[ 1248.515052] iwlwifi 0000:01:00.0: 0x8047FAB6 | umac interruptlink2
[ 1248.515067] iwlwifi 0000:01:00.0: 0x00000002 | umac data1
[ 1248.515080] iwlwifi 0000:01:00.0: 0x8047FAB6 | umac data2
[ 1248.515088] iwlwifi 0000:01:00.0: 0x00000000 | umac data3
[ 1248.515097] iwlwifi 0000:01:00.0: 0x00000042 | umac major
[ 1248.515106] iwlwifi 0000:01:00.0: 0xF1C864E0 | umac minor
[ 1248.515115] iwlwifi 0000:01:00.0: 0x01437D32 | frame pointer
[ 1248.515124] iwlwifi 0000:01:00.0: 0xC088625C | stack pointer
[ 1248.515135] iwlwifi 0000:01:00.0: 0x0061010C | last host cmd
[ 1248.515146] iwlwifi 0000:01:00.0: 0x00000000 | isr status reg
[ 1248.515197] iwlwifi 0000:01:00.0: IML/ROM dump:
[ 1248.515209] iwlwifi 0000:01:00.0: 0x00000B03 | IML/ROM error/state
[ 1248.515255] iwlwifi 0000:01:00.0: 0x00007180 | IML/ROM data1
[ 1248.515299] iwlwifi 0000:01:00.0: 0x00000090 | IML/ROM WFPM_AUTH_KEY_0
[ 1248.515328] iwlwifi 0000:01:00.0: Fseq Registers:
[ 1248.515350] iwlwifi 0000:01:00.0: 0x60000100 | FSEQ_ERROR_CODE
[ 1248.515372] iwlwifi 0000:01:00.0: 0x00440005 | FSEQ_TOP_INIT_VERSION
[ 1248.515394] iwlwifi 0000:01:00.0: 0x00080009 | FSEQ_CNVIO_INIT_VERSION
[ 1248.515444] iwlwifi 0000:01:00.0: 0x0000A652 | FSEQ_OTP_VERSION
[ 1248.515466] iwlwifi 0000:01:00.0: 0x00000002 | FSEQ_TOP_CONTENT_VERSION
[ 1248.515488] iwlwifi 0000:01:00.0: 0x4552414E | FSEQ_ALIVE_TOKEN
[ 1248.515519] iwlwifi 0000:01:00.0: 0x00400410 | FSEQ_CNVI_ID
[ 1248.515554] iwlwifi 0000:01:00.0: 0x00400410 | FSEQ_CNVR_ID
[ 1248.515588] iwlwifi 0000:01:00.0: 0x00400410 | CNVI_AUX_MISC_CHIP
[ 1248.515614] iwlwifi 0000:01:00.0: 0x00400410 | CNVR_AUX_MISC_CHIP
[ 1248.515650] iwlwifi 0000:01:00.0: 0x00009061 |
CNVR_SCU_SD_REGS_SD_REG_DIG_DCDC_VTRIM
[ 1248.515684] iwlwifi 0000:01:00.0: 0x00000061 |
CNVR_SCU_SD_REGS_SD_REG_ACTIVE_VDIG_MIRROR
[ 1248.515948] iwlwifi 0000:01:00.0: WRT: Collecting data: ini trigger
4 fired (delay=0ms).
[ 1248.515971] ieee80211 phy0: Hardware restart was requested
[ 1249.136517] iwlwifi 0000:01:00.0: Failed to send the temperature
measurement command (err=-5)

Thanks in advance for fixing

Michal

