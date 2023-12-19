Return-Path: <linux-kernel+bounces-4509-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C9AC4817E59
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 01:03:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5CC23B234EB
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 00:03:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F49E2566;
	Tue, 19 Dec 2023 00:02:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Ajqw1mmN"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 052747F
	for <linux-kernel@vger.kernel.org>; Tue, 19 Dec 2023 00:02:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-5537dd673e5so845851a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 18 Dec 2023 16:02:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1702944172; x=1703548972; darn=vger.kernel.org;
        h=mime-version:user-agent:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=TrhzH6xqKeipPlHlk6gButye0uWQX8hC+dCudfcEL74=;
        b=Ajqw1mmN0CSR0I78MtjFXE4GeldH0y6O3szRL5IVHZGnSf9qVdRqxzfxbRBKUKq12B
         hSeBEIJpgB666fOEFvVEYGKAHjOeF+W0hCs0zkmmuF+OnfmmGYEW4vTp/1pWt5tZz5sO
         BAAEAXpb67fAcP/GlMGKVF6THFVNHXcS+EZ0b8zf3LABfBM6xxEyR566rFEnw7psMEQ5
         pehNp526VfOQhm18oc7DgpkWMWW4RtLsO6SNXbFP9EK5tBVkSeP7doxmryY3v2Woqc5g
         fi3DTPXm4XlYxoXjL4lt2AMrT4+mhp2QRKrxhZwqW1OBrFeybPb9HzYiEymPNEo2vm6E
         6xdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702944172; x=1703548972;
        h=mime-version:user-agent:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TrhzH6xqKeipPlHlk6gButye0uWQX8hC+dCudfcEL74=;
        b=aJcpCCqRAtHCf2okJDX9adZ/45T6SrxtM8HuLsI4RlXxCAYeA8nsv2WjplQQePrb4k
         wIwl0uRB9IY9nJpVUnP+l0uiGH/Au4RSV2A/pj36vFmPqPsKteois024V6PMCujiXDgD
         FGCU90l+OUAATOuNgQacjlnCnAZ3WU44mcuns6cvGQhR/vvttSI7BsK/AM/ayL0sSj/t
         Wosbor9SX8uQFH9EPSS/gsySPAwr4niANFJCz0hx30FtZO+qcUg4gC+OPPWtvIsp1WY/
         WfaUWZSIq97wFXXgy9TNsLHdOjGCoa/2m82KpXaZTh5Nq8FLrhdHEhzBz8BzEO4qRtMz
         RGmw==
X-Gm-Message-State: AOJu0YyzQakZIrcO7vGOrYQcpANmjOg+1+wFG/m4IdT30MciDAKVP9qT
	B/duqKOlObpwUZfQbLIh2gEvBSr76Q5n6yr6BKs=
X-Google-Smtp-Source: AGHT+IHdEOuiZzgohmzKHAqTTBTmaduhnsB5Nyoi+DOfSy3v1QE9HJAHM9oLiBUR+i9Mqnwm18xU3Q==
X-Received: by 2002:a50:85cb:0:b0:54c:6d09:3e3d with SMTP id q11-20020a5085cb000000b0054c6d093e3dmr9354220edh.26.1702944172247;
        Mon, 18 Dec 2023 16:02:52 -0800 (PST)
Received: from localhost (nat2.prg.suse.com. [195.250.132.146])
        by smtp.gmail.com with ESMTPSA id f19-20020a056402195300b005537b00132asm587447edz.91.2023.12.18.16.02.51
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 Dec 2023 16:02:52 -0800 (PST)
From: Jiri Kosina <jkosina@suse.com>
X-Google-Original-From: Jiri Kosina <jikos@kernel.org>
Date: Tue, 19 Dec 2023 01:02:53 +0100 (CET)
To: Linus Torvalds <torvalds@linux-foundation.org>
cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>, 
    linux-kernel@vger.kernel.org
Subject: [GIT PULL] HID fixes for 6.7
Message-ID: <nycvar.YFH.7.76.2312190056450.24250@cbobk.fhfr.pm>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

Linus,

please pull from

  git://git.kernel.org/pub/scm/linux/kernel/git/hid/hid.git tags/hid-for-linus-2023121901

to receive two last-minute fixes that should still go into 6.7;

=====
- fix for division by zero in Nintendo driver when generic joycon is 
  attached, reported and fixed by SteamOS folks (Guilherme G. Piccoli)
- GCC-7 build fix (which is a good cleanup anyway) for Nintendo driver 
  (Ryan McClelland)
=====

Thanks.

----------------------------------------------------------------
Guilherme G. Piccoli (1):
      HID: nintendo: Prevent divide-by-zero on code

Ryan McClelland (1):
      HID: nintendo: fix initializer element is not constant error

 drivers/hid/hid-nintendo.c | 71 +++++++++++++++++++++++++++-------------------
 1 file changed, 42 insertions(+), 29 deletions(-)

-- 
Jiri Kosina
SUSE Labs


