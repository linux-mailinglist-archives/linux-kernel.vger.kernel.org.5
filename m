Return-Path: <linux-kernel+bounces-82219-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 905518680AD
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 20:16:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A4FD71C28FB2
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 19:16:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8862C131E34;
	Mon, 26 Feb 2024 19:14:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bKuMmb4m"
Received: from mail-vs1-f42.google.com (mail-vs1-f42.google.com [209.85.217.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 753346A006
	for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 19:14:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708974887; cv=none; b=ZlnBoisX6e6dNS7pOlgY1Kgnfr4g210WOw+a+j2jBh2KW8Jqx9agkK1/5+NONfx0OUJDBfcMA9spu8iWEUINCcbssI2NWCjxQWYPUVlVDMtZCbjM517bJKKisg07tRd9DS/inSsWnQd5FZhzokBQvVPBQ+OjkZkhPcnnq3tuCjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708974887; c=relaxed/simple;
	bh=Jv6aSpqwkNWbv+z1s8rPN96Z6OiyBRL3D8M6WOHcqqo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Mq+sF+UUplsoRzNMUb2nTa7uIcAVz4wL9nh1xtR+CTQxvDU7myEkKUdf4LBofKZfQrr+u9CF+IsxID0bMhqNKsA9vIs/VT3vgW748qkpp7h5qi3Ql9ExeF1mzD17RD2ubOSKUJyMbOS/O+B5AdzeqSOm8cXdkeHPn0Cq/HZkUew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bKuMmb4m; arc=none smtp.client-ip=209.85.217.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f42.google.com with SMTP id ada2fe7eead31-471e55434e9so794677137.0
        for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 11:14:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708974885; x=1709579685; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Jv6aSpqwkNWbv+z1s8rPN96Z6OiyBRL3D8M6WOHcqqo=;
        b=bKuMmb4mbMgxDnji3Iwva9Fb516teEMWyKdj8R72/s2n2w+K0dAHKw/OD7Tk2RFrsK
         c1ZL0UqxfxtDrw3/XTcI2/KTBZQoYEII8BuX8cUHVdly/vZBqzWwByH1YxJ+R4PxGnD1
         1HNWAqPJAYFaJRM1nAJ/iCntDLRyPQQWdxwDgLPuh5EUQIR0FkajYJ1Y/2W3G4UtfAZn
         fsTv5bgiNVyuV+OL5qty3zPysfUxn04/om4DuygcHAogBsN4Ks11vUXyOSFxU8lF3ZPA
         VCtPmHJEv/1QZNgm+UF/2Ef+D8dFiGxx4W9gyAsInbxZ80FrlpkQSbTQE0lB+kqbRDzD
         anWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708974885; x=1709579685;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Jv6aSpqwkNWbv+z1s8rPN96Z6OiyBRL3D8M6WOHcqqo=;
        b=t0NyOu0ULL0G+8pTMtrwP0/OXgC9bvahJmynZgbqt7xzsIiPvXjK5RDvv8d8Slem5g
         3ZIBhpSKRrPRS3tKFR2xYmSM2oAdr+p/M7cdPwk/O2rXJmFBDVSJ09ZYYLvS891w3KJB
         ZmieVVc44q6mxXJhv14zD5zAfHh6BSKWXj9+3GijoPSjd7FCjVHGFehTX0MaFIR+uWVZ
         Lvo1tdPtNIpWBwqWK6q3qnkIhp4QvLYDeuKmOl8wvyTbunEQ4meYykVuFZDV6//khnIo
         qzf5GL8Dk6FwjDjdglKxIhAC4/9aC4DPWcyawO+JkO60Pf2iPdXvrmt5gj45VxrlZDaD
         xaBA==
X-Forwarded-Encrypted: i=1; AJvYcCUy6ob6/AA920XJsRfPHRBiND+7dVA8suyjN57bkO0U4kviWelpvCH7btbFsRbcT78P+ro+BSTMG8zgSru4bD7O4S0D57Hh6AY0/sZ2
X-Gm-Message-State: AOJu0Ywq0uxahMhvYCfnQBBZqO/T2VCHwm+z1GMRnTL8FYq5WfQ01jAj
	YnRr6/yn8DufwHDl4DGxwbsiugCPc44bjxb0Nol/TLUROJI8GqTCHg6cZN7FdWdGvaoLibzvuf2
	OwLAqePPBElsp8l/LBBMTT4k32Eg=
X-Google-Smtp-Source: AGHT+IG4HMyuPvsgf2ypPDH5IWt+1vACdKWfyU0vJS8MldIFTQ7IljaZ+vGZ8uAHsudvy6ILuzrJIW5aa8R3jJZ7IIw=
X-Received: by 2002:a05:6102:22d5:b0:470:62cc:6306 with SMTP id
 a21-20020a05610222d500b0047062cc6306mr5149938vsh.6.1708974885241; Mon, 26 Feb
 2024 11:14:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240223205535.307307-1-jaegeuk@kernel.org> <20240223205535.307307-4-jaegeuk@kernel.org>
 <6b2854fd-8999-4671-a243-d78139f8a40f@kernel.org>
In-Reply-To: <6b2854fd-8999-4671-a243-d78139f8a40f@kernel.org>
From: Daeho Jeong <daeho43@gmail.com>
Date: Mon, 26 Feb 2024 11:14:34 -0800
Message-ID: <CACOAw_x6VLaR0SZQqxdPuB=oggyrq+dTQDn+w+84fHSv_Ta17Q@mail.gmail.com>
Subject: Re: [f2fs-dev] [PATCH 4/5] f2fs: prevent an f2fs_gc loop during disable_checkpoint
To: Chao Yu <chao@kernel.org>
Cc: Jaegeuk Kim <jaegeuk@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Reviewed-by: Daeho Jeong <daehojeong@google.com>

On Sun, Feb 25, 2024 at 6:59=E2=80=AFPM Chao Yu <chao@kernel.org> wrote:
>
> On 2024/2/24 4:55, Jaegeuk Kim wrote:
> > Don't get stuck in the f2fs_gc loop while disabling checkpoint. Instead=
, we have
> > a time-based management.
> >
> > Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
>
> Reviewed-by: Chao Yu <chao@kernel.org>
>
> Thanks,
>
>
> _______________________________________________
> Linux-f2fs-devel mailing list
> Linux-f2fs-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel

