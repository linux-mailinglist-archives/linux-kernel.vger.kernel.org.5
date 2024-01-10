Return-Path: <linux-kernel+bounces-22597-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C4CD82A037
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 19:27:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 43174B23B7D
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 18:27:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71DD94D581;
	Wed, 10 Jan 2024 18:26:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TBeBi9ld"
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A013495C1
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jan 2024 18:26:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1d3f3ee00a2so21559295ad.3
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jan 2024 10:26:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704911211; x=1705516011; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Ci4qGWcSBeiDUvGPDz+SZ63F2cKIOzMN0O16Aq5QGms=;
        b=TBeBi9ldP5HvS/NhWuZPa1TBB3c8igf0UcWYw1Icui11vZmuKi3I0YsF4d//lzGIa6
         itmwSwqMqh+gFa2/pl5Hs0k18/8VNEj/U0fxXeAfp5KFvuNMwvtQbLR7i4dl3tdJge+Z
         odApxyhDX8Qe+2VvssNTJWOhgLEJ0CJ40apARi1quXJk7zQQgibRL72uTABk5ubgIMKh
         ypQCgmZUmk3BIjjM6rC7NFe2D9DBksl9GenESDEfmN2jgJYplq7hMM96OcSMZqfuRdZu
         2xmVPWMeSeDoAuVsHN7JRG2XQSIUK3SBUzKVg1TLt17+80IxlScT7ne5ht9Jm76WUe0R
         OKdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704911211; x=1705516011;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ci4qGWcSBeiDUvGPDz+SZ63F2cKIOzMN0O16Aq5QGms=;
        b=ld5FUcdFFaqcvCrsA8whItT61qHFGV2YVqDa/ZNKK0mMTIjTETG7r8d3zPrN+Ga7vi
         GpWhMpqHjkUJl7Kl6fxprVsPlow0h77vitu2Ho/SaD1lPiPrVea0KGFtkcizTVxKE0/i
         dBe38JWRlHenafKMsX4AJlbwi6POXC4R94gQFSggMpsUdD+e186WJ0e2nuteDABbDbsK
         hcJodpgKuxrzz+NSrpvyRM0dmfHLXFXd76yox0nTrqc80tQSb3YuWMsVbiY9tSjk506w
         +jbof1Y0BuKqIGg3YQ33uxmvdfkdtQ/tZvmJlC1XNxDthJdNS5jauw+VWsKouh8z6Jn1
         udMg==
X-Gm-Message-State: AOJu0YyAX2xWr2Xvz1//GUa5QHhJoPci2tXh3vOtzqVr2SwEjGMBuy/f
	KZXa/omg0Zh1WMrzVWHR6Oc=
X-Google-Smtp-Source: AGHT+IFepqQUs2uXhRtasqW+idqmw2bGocjBXoYftpgR+FQ1WKn/mVG4uKMmB1PgbwXvhJLUEdRPCg==
X-Received: by 2002:a17:902:a50d:b0:1d5:251:15d9 with SMTP id s13-20020a170902a50d00b001d5025115d9mr1002069plq.136.1704911210645;
        Wed, 10 Jan 2024 10:26:50 -0800 (PST)
Received: from localhost (dhcp-72-253-202-210.hawaiiantel.net. [72.253.202.210])
        by smtp.gmail.com with ESMTPSA id p3-20020a1709026b8300b001cfde4c84bcsm3950800plk.141.2024.01.10.10.26.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jan 2024 10:26:50 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date: Wed, 10 Jan 2024 08:26:49 -1000
From: Tejun Heo <tj@kernel.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: gregkh@linuxfoundation.org, andrea.righi@canonical.com, ast@kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] kernfs: Rearrange kernfs_node fields to reduce its
 size on 64bit
Message-ID: <ZZ7haRXNwyxDSQum@slm.duckdns.org>
References: <20240109214828.252092-1-tj@kernel.org>
 <20240109214828.252092-3-tj@kernel.org>
 <CAMuHMdWD==XWQrcZVfxaL0wSjG5hFPoUubpi6mjrJSPU+nOoJg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMuHMdWD==XWQrcZVfxaL0wSjG5hFPoUubpi6mjrJSPU+nOoJg@mail.gmail.com>

On Wed, Jan 10, 2024 at 04:18:36PM +0100, Geert Uytterhoeven wrote:
> Hi Tejun,
> 
> On Tue, Jan 9, 2024 at 10:49 PM Tejun Heo <tj@kernel.org> wrote:
> > Moving .flags and .mode right below .hash makes kernfs_node smaller by 8
> > bytes on 64bit.
> >
> > Signed-off-by: Tejun Heo <tj@kernel.org>
> 
> Thanks for your patch!
> 
> > --- a/include/linux/kernfs.h
> > +++ b/include/linux/kernfs.h
> > @@ -206,6 +206,9 @@ struct kernfs_node {
> >
> >         const void              *ns;    /* namespace tag */
> >         unsigned int            hash;   /* ns + name hash */
> > +       unsigned short          flags;
> > +       umode_t                 mode;
> > +
> >         union {
> >                 struct kernfs_elem_dir          dir;
> >                 struct kernfs_elem_symlink      symlink;
> > @@ -220,8 +223,6 @@ struct kernfs_node {
> >          */
> >         u64                     id;
> >
> > -       unsigned short          flags;
> > -       umode_t                 mode;
> >         struct kernfs_iattrs    *iattr;
> 
> Note that there is now a hole at the end of the structure on 32-bit
> architectures
> where the alignment of u64 is 8 bytes.
> 
> Hence, sizeof(struct kernfs_node) grew from 104 to 112 bytes on (at
> least) arm32 and rv32.
> It did shrink by 8 bytes on amd64, arm64, mips64, and rv64.
> Size is unchanged on ia32, m68k and sh.
> 
> I didn't check any other architectures.

Ah, thanks. I'll shuffle things a bit more so that the size doesn't increase
for 32bits.

-- 
tejun

