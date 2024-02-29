Return-Path: <linux-kernel+bounces-87366-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5354186D371
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 20:41:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E89A11F25CA8
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 19:41:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0299613C9E1;
	Thu, 29 Feb 2024 19:41:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b="G4Yg9EHh"
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77C0C13C9E8
	for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 19:41:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709235707; cv=none; b=h+uaGM6aExbPRaKCh3G/YPotyQe7jT+xCsypB0s+BSD2Sx2HvNqv/Dpz9tdwRJPHhyiWpfRLsChEunRFpIC256ZBRPTYQH6cPTvZxiWsO6OeDZY56XOw5ep6JtYVC1ErnbdS68+QFoyQ5k9cd08Bbg37kgtF44OX9vTAjYulhc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709235707; c=relaxed/simple;
	bh=1WeRi85DTX5lSTK6mlOcymKvnVy6AoW4RjHw5tld64Q=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=BBYxu482MdoZa/HX/KeiSWaPOICRWrz1bJaIc2cKpcDL36dFBexuJHtvGM9EcBFaGNalIb6lO5fnwL2PPKHVXpEPmH6RkLGcftT0tIRT4QpyFxP1liYnkPqBVqMQNYQrMFT2YTuwmJ6g+NmsFaY4Pu10cg87uJ3dO0+X74g/Xrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com; spf=none smtp.mailfrom=toblux.com; dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b=G4Yg9EHh; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toblux.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a3ddc13bbb3so413323566b.0
        for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 11:41:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toblux-com.20230601.gappssmtp.com; s=20230601; t=1709235704; x=1709840504; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1WeRi85DTX5lSTK6mlOcymKvnVy6AoW4RjHw5tld64Q=;
        b=G4Yg9EHhQaMtTfrL2N4vtrib1wEkvhZiBq3QLw/DBR3fCyzaQYGikMN5C7nDEtrMli
         ZjSgqEaecxu+AS4NymYOnIYHSN/DU04wQGB55cwLb1YrpaRXt5iwz32PtD2Y/G1bNt3U
         VXFm4cBy0heTcLmv+P9Ka28sw7uHNHw0F150sbgv1iexcWNKTM10yvsHvMH82EiIh1pz
         IAaI9+lW5iBmx/zknPpHtgidYQEguk1CVbgYts9deGZ5xOgg59wQgvMkwIbhv5BUK07x
         sb3y6loJdXv2Z41oxUVz+aqAwJqFnpPghbP3XgQFGZ3HS7wi6BeHAuSA7PE1S7HSjRhE
         4NqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709235704; x=1709840504;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1WeRi85DTX5lSTK6mlOcymKvnVy6AoW4RjHw5tld64Q=;
        b=RKzNLQ8b1yzg/NiPQ2ekiNOVo7aDPlRTJyCV/egEvwiORwnZyv/4jThA8YTUdubL1Z
         IObwBIO3eHWyLZPWcWniRSAU5gtLmenlfDODwh/20OaSXb1XdshR6YxOO8N5KarOAZ4K
         n/oNNqlFz6ogkeU+xPAnQ608Dk5dJNMqsQACboI2lb20+OEF7Wirugm+PlgWS9Z671gW
         of6ksLQBBaGBw0a87/dr64IE6+9xB2Vixhx/iXtly2NWz/0K18B6wbPRB3brZHKQLTAv
         zixBVik5r9Jp/y89X9MGBBwYvnfbsouo10N9Zl//UcVD+rCcJNkLSTukt8NfNIUHXwLt
         HaPw==
X-Forwarded-Encrypted: i=1; AJvYcCXmzyur78x/XPPfeusNPxiJ5XtfH+38ZMGufYGpj0wKMsa/Phb1rNbEfpXwgg5HicPMDL0+eAA7FIIcpbL2IctrWycZRCKvdhJ7R/oZ
X-Gm-Message-State: AOJu0YydZwNksbefibwlJhiq4LmjhVSw0bxEc64WpKbzUNgbdn0fGVla
	PRklpCW4/QAh/kVa38sBif4lVlUjm1u0zJyZ/T6qOz7QbNOb3wrwNMW2o/iFr4o=
X-Google-Smtp-Source: AGHT+IGa8cHSa2YssKkjMsxGZwqzI4YU3LhHoWTI53iNfFzF2CIuO8B+o/NL/Td0ZrJKNRmMt6XnzQ==
X-Received: by 2002:a17:906:ce28:b0:a44:591:a3d8 with SMTP id sd8-20020a170906ce2800b00a440591a3d8mr2030486ejb.31.1709235703096;
        Thu, 29 Feb 2024 11:41:43 -0800 (PST)
Received: from smtpclient.apple ([2001:a61:1069:f701:6c1a:d05d:ad7c:b80d])
        by smtp.gmail.com with ESMTPSA id tj7-20020a170907c24700b00a413d1eda4bsm976623ejc.87.2024.02.29.11.41.42
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 29 Feb 2024 11:41:42 -0800 (PST)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.400.31\))
Subject: Re: [PATCH] nilfs2: Use div64_ul() instead of do_div()
From: Thorsten Blum <thorsten.blum@toblux.com>
In-Reply-To: <CAKFNMomtp7ZwB0gmxoemp_ums4rqOSbfF2BMS6kX+LwtKYtvCg@mail.gmail.com>
Date: Thu, 29 Feb 2024 20:41:31 +0100
Cc: linux-nilfs@vger.kernel.org,
 linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <19910196-DFF3-4F94-B6D3-B9BF722DF8B8@toblux.com>
References: <20240229121650.33983-1-thorsten.blum@toblux.com>
 <CAKFNMomtp7ZwB0gmxoemp_ums4rqOSbfF2BMS6kX+LwtKYtvCg@mail.gmail.com>
To: Ryusuke Konishi <konishi.ryusuke@gmail.com>
X-Mailer: Apple Mail (2.3774.400.31)


> On Feb 29, 2024, at 19:45, Ryusuke Konishi <konishi.ryusuke@gmail.com> =
wrote:
>=20
> All of the fixes in this patch seem to be correct, but this doesn't
> cover nilfs_resize_fs(), nilfs_max_segment_count(), and
> nilfs_sb2_bad_offset(), which also have do_div() that doesn't use the
> return value.

I just tested this, and Coccinelle didn't report nilfs_resize_fs() or
nilfs_max_segment_count() because both divisors are fields of a struct. =
I will
refactor this and submit a v2.

For nilfs_sb2_bad_offset(), where the dividend is u64 and the divisor is =
u32, we
would need a dedicated function like div64_u32() that doesn't calculate =
the
remainder, which doesn't seem to exist. What do you think?

Thanks,
Thorsten=

