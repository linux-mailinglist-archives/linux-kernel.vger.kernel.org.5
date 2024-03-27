Return-Path: <linux-kernel+bounces-120186-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C126D88D401
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 02:53:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E3C2B1C24393
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 01:53:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2B8F20B34;
	Wed, 27 Mar 2024 01:53:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ht+b5B02"
Received: from mail-vk1-f173.google.com (mail-vk1-f173.google.com [209.85.221.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98FE2200A0;
	Wed, 27 Mar 2024 01:53:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711504398; cv=none; b=sr2WZiHVlMXn77nRNtp03t31DzsTR4craEoEvl8kf5FrDu/4I9Nws8YJGSKjS/r7NvXb0SpE4wddFU17CBc2SGBWc5iGGIanLyrd+wjHIAJjTvp/QtChbI5TOY4JA2Zw3kWAfzjxn9XnhDOGtsx2GLHoiGflSaNdy3v0D+HWv+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711504398; c=relaxed/simple;
	bh=DRnkkrf8xROfgZfWGbfaO7oz85CrYz5nFzmP7jk/Lpo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=geS9AeL2kvsXVhdK0b2zwUd6x27cFDlhsCO8T1nvsne/o+UyQ6aM1L2V7jFjATjNNF33x6s20JEpWSF0aj0sEiMfdHaYU3mj1JN4jkMYdFeDunA/NA82frmXRJiN4YODCLc2gBhc/broAvjmNfAUcPx5mp9p2pUHkPPa3INHBn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=fail (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ht+b5B02 reason="signature verification failed"; arc=none smtp.client-ip=209.85.221.48; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f173.google.com with SMTP id 71dfb90a1353d-4d435a60217so1791436e0c.0;
        Tue, 26 Mar 2024 18:53:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711504395; x=1712109195;
        h=content-transfer-encoding:mime-version:list-unsubscribe
         :list-subscribe:list-id:precedence:dkim-signature:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DRnkkrf8xROfgZfWGbfaO7oz85CrYz5nFzmP7jk/Lpo=;
        b=Ug4SGtvn5/oHaF4qBnkCk4Ozm/XLWS5Ysv8QRJeDQrL+qP0/CXZC3fuK+fnZP49Xnj
         3bHda3SjFnLVpUvQyC84x8KnqgOf/sdD/06pc4XnoXyrl/mWWKhmhQ1hg182CcUIa7/X
         EwJT9fSwvs7tfk7qpsbGefnCE6XJdRmVe7j56HA8CqTP1gDbbIJQix3cBMfa+3nQsWUc
         qbekfmUA8iSJsPTyYRURf0+pO8mSR60WpHzPfIRG2TBhZi2Jhjc8XKddJj2SinX2C2bH
         iB8HJfockwgplWCgk8Ofqz6qVSyMxaH4Q/4EIsL/R2LAHMv7WRX37rxW5m/Qqt1RnMSO
         osTw==
X-Forwarded-Encrypted: i=1; AJvYcCXValHBaa0TrQwEQUeDrtFZMzuu8+fL6iIqBY1ALq1bdjmQKJily1J0alsgYAxFONEdBCg4sfmK+DRCGplB9g7U18NlAhqBLxx/QG6FtD8KlDGSqJD2AgO7OjH/KgnJfm17BkboxTWqPhKMSKElbIqDEbkGoS87Kf7cUJYm1Z1NtSDsSK9MaNDdu6oFWrTcoYI83LsO1Xn9isDwkuo//JQcHq4jeQfjHZZadHsBsCphjDaX/G0ZSg==
X-Gm-Message-State: AOJu0YzGHYQJD6VBXDo8Al5Ip4c0Y5pp8SRhUh//ZErRdfjdsfBjg4Tk
	ZPFtjKtnxIodNbPneig3nxZrDpNEF42pK3HjyhZQYlaJGKfIvuNP
X-Google-Smtp-Source: AGHT+IHu+26ARqT6YXdlH4UWt1l8C5+RYVEWaKo9otsDSaAzLyvff84BpoFrCdHc4+Dt1anFqquTLw==
X-Received: by 2002:a05:6122:914:b0:4c8:8d45:5325 with SMTP id j20-20020a056122091400b004c88d455325mr1683016vka.7.1711504395386;
        Tue, 26 Mar 2024 18:53:15 -0700 (PDT)
Received: from l1441l.lan0.xorvpn.com (pool-98-116-41-146.nycmny.fios.verizon.net. [98.116.41.146])
        by smtp.gmail.com with ESMTPSA id g15-20020a0562140acf00b0068c8be959a0sm5834155qvi.111.2024.03.26.18.53.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Mar 2024 18:53:14 -0700 (PDT)
From: Daniel Hodges <hodges.daniel.scott@gmail.com>
To: alexei.starovoitov@gmail.com,
	Daniel Hodges <hodges.daniel.scott@gmail.com>,
	netfilter-devel <netfilter-devel@vger.kernel.org>,
	Network Development <netdev@vger.kernel.org>
Cc: ast@kernel.org,
	bpf@vger.kernel.org,
	daniel@iogearbox.net,
	lee@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-leds@vger.kernel.org,
	pavel@ucw.cz
Subject: Re: [PATCH 1/3] leds: trigger: legtrig-bpf: Add ledtrig-bpf module
Date: Tue, 26 Mar 2024 21:53:14 -0400
Message-ID: <CAADnVQ+BsBcp5osqiG46gjtLViQjHStVnPsySffHsybaz7OYEw@mail.gmail.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <ac8e77881212e18d117059a698affd6afc2607af.1711113657.git.hodges.daniel.scott@gmail.com>
References: <cover.1711113657.git.hodges.daniel.scott@gmail.com> <ac8e77881212e18d117059a698affd6afc2607af.1711113657.git.hodges.daniel.scott@gmail.com>
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48]) (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits)) (No client certificate requested) by smtp.subspace.kernel.org (Postfix) with ESMTPS id 544F15491E; Sat, 23 Mar 2024 19:19:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-34175878e30so1992384f8f.3; Sat, 23 Mar 2024 12:19:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20230601; t=1711221558; x=1711826358; darn=vger.kernel.org; h=content-transfer-encoding:cc:to:subject:message-id:date:from :in-reply-to:references:mime-version:from:to:cc:subject:date :message-id:reply-to; bh=yixKxMyJp9zitpdKye9pLVcWEHJONLO0fUVkk9RNx2Q=; b=ht+b5B022yADnDN4bBtI8hIFZg6LP/qjoqSbPdqEGKF3W77asD0frBQ5Kw3XdZwQYK nHavVdO5CaNHbr8HvQPLIr5wFr78x4bHiCFsqkhk+M7N1DWJOtVp243RPanS0rHQNNYZ rHkE7EkevI0Vns01+SQfErkfW17U8hplCAa5EyFjWolpmpVY70Ckdcp7m0/7Z0nY2aEl 0abQz6lAEitw4cPUS0gxZWRg2ejgBs5IBx9WtwdWGQd1hzcn7hWfofuzWMwohwLKMgOA tfV8/DZhFvhbzs13+TzljnOhT90p4dvBHvRbwu5UFoRHzUl4dHlGNOi/8zH0HqtO9vbM aYMg==
X-Forwarded-Encrypted: i=1; AJvYcCWIeaQ/yiBpH2/hsPlo1ilbVrmGWbW1/Q/mj/lYUpLY0mNt9n+PMhtL1TwavvqIOG/JF4WlslG8qKucixGp+ulx+9Ej+OZsA3Uc30xeXt974R4DuKvjyStaBnI1QMrx9Bdc1XtgcDTzxMG2ijeNLuU+ozIdYh1pNbMfa3Fj0oPzOE4qLKz+sub0QqtOv3wrCcBUurTs5GF9dyTu4eEbpsHOcteP88UhdDEXpVBZ2vsoD1uht87SBw==
X-Received: by 2002:a5d:5cc6:0:b0:33e:c522:a071 with SMTP id cg6-20020a5d5cc6000000b0033ec522a071mr1942577wrb.51.1711221558546; Sat, 23 Mar 2024 12:19:18 -0700 (PDT)
Precedence: bulk
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit

From: Alexei Starovoitov <alexei.starovoitov@gmail.com>


> A new kernel module just to call this helper?
> Feels like overkill. Can it be a part of generic led bits?

I looked and in general most of the other triggers are modules so I was trying
to follow that pattern. I think having a few kfuncs in the generic led core
might be far more flexible. I'd have to defer to someone with more insight on
that though.

> btw, have you looked at net/netfilter/xt_LED.c ?
> netfilter had the ability to blink led for a long time.
> I'm curious whether folks found it useful.

I briefly looked at it and to be honest not sure of how widely used it is. I
did see some docs in OpenWRT
(https://openwrt.org/docs/guide-user/base-system/led_configuration) so it may
be used in that context. My thought is to have something like bpftrace be able
to trigger LEDs for troubleshooting purposes. Sure, it can already print
counts and sums of counts over intervals, but one thing I've found interesting
is triggering on perf events. For example, triggering on CPU cycles gives a
nice visual indication of the amount of work being done.

> It can also do led_trigger_event().
> Should that be another kfunc?

That's a good question, there seems to be a few other functions that would
maybe be useful kfuncs (led_set_brightness etc). My only thought was some of
them get passed the led_classdev and wasn't sure how difficult it would easily
it would be for callers of the kfuncs to access/pass it through. With the
trigger interface at least it seems rather self contained.

Anyways, part of this exercise was a learning experience for me on getting
some bearings for being able to submit patches properly and learning the
kernel development process. The V2 patchset (which I wasn't sure if I was
supposed to respond to a thread or make a new one from
https://kernelnewbies.org/FirstKernelPatch it made it seem like either was
acceptable), I think correctly implements a per LED version. Thanks all for
your time and insight.

- Daniel

