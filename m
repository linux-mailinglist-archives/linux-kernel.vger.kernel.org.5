Return-Path: <linux-kernel+bounces-70793-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E334859C74
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 07:58:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 615B41C2169F
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 06:58:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 805AB20324;
	Mon, 19 Feb 2024 06:58:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OtsxI88c"
Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com [209.85.167.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53E26200C4;
	Mon, 19 Feb 2024 06:58:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708325897; cv=none; b=S81z/reugan0uDDlIGzznccCsdCxK4X8M/md4Fot+ehkhbjypd/SApFRqbkeXm/Kp9jdbcdmugNNsdF3H7nDRUBxji4cCCxv2KTTpWRJ+MV2UigEXyAcLN8mm+icaihT4FKmfVHHxjLek5ePMn9sB3xRPTFnXlEH2VSc+Ijvx60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708325897; c=relaxed/simple;
	bh=CbvNehSQsmjo5xsV/L89m1wM6vfv2EwyYMq67xrvs/w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AUBdrXvo5hyhE/CN0vmAJY1//Lifido/n53mDGIQ1vijyE4enra9UkVS80Kp1JOPb957kIMrdTtL6Q6C1qCwnfDmG8NreEw7qOsoG3TD1qBbyOvXoIWtv2jbVsanL1kQ0XO14uKBVnuPze3+gTpgPrdlufoNpe2UF90s5L0/8JI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OtsxI88c; arc=none smtp.client-ip=209.85.167.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f173.google.com with SMTP id 5614622812f47-3c03d6e5e56so4300019b6e.1;
        Sun, 18 Feb 2024 22:58:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708325895; x=1708930695; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=jDzYA3NEdFlq1ACOSgNhvQr7ItIR43JX1Kc+EeVYRPs=;
        b=OtsxI88ckFFqN//ddn6P3rc+pcHfdko/wxMY1Gp30BEpZ0woKtpk76hzYME/rw2tND
         gv4mQ3bDtskkUZwe766qY6clqixDE2u4hI9b+kZypLw42jvwPJ03r4gTk+hQP8rE2u+v
         QkHSVH48TE+14nwn6xJI79fPGmDQAOC4GKg/LpwGSzEninnlxNvXU0hXjc7HJMSuTg6g
         r4E8/Xw07hQ71BQK55Ei+yg982sl8NvXHtoAgOnRygdsgtlqJcz+o2Rj53c2iXUXFSor
         6Rkk+JyRi5meKgrpTHZJOO3dXdrCzWbasoM2ULGViueadFKobAUFOchz+LPDZYVyIqW9
         HEWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708325895; x=1708930695;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jDzYA3NEdFlq1ACOSgNhvQr7ItIR43JX1Kc+EeVYRPs=;
        b=BCdlE+W+R+mMKUrUeddSx2ph8yy6rLTlAmlRs0xUKT0e+ROolVkGgY+2AbUJn3kfDH
         fZUQPLutDiNzjHZy+8iIIvnCXo1SKNZ+ABmjs4NwzNuS8pxO5CcEspyWequs8JpRfU7F
         St+pbvr5LC2Qc1/Q5uMvCXF/MTLJY2HXEgypVAMyk7UwKax9Qm9GAR7ey9VTnj8RxZQF
         CV+8Mrlf0bKiF381/QqtDlflnn3Zz4YNMCChVd/46ZMy0VyDmnBjX0Pfyk0ncJFcTkhY
         zMAKbfrPa2qqvqzzqxKTbKFOcpug9+hHJsr8mdzqq1Nw6EaltyYvlNReLiCoPLq29/P0
         QQmA==
X-Forwarded-Encrypted: i=1; AJvYcCXEFx18w/EUvXfoDzw8M/Db4hpeF191Je8qSgJqDXh0jZxN9cpGtLa8KdSZa5PC/oZNj64I4IqMT3Upwn5NcgVeD3gHk/SDpVHVLo6X6uWLvSnDK7o5xEMrIVcBwLUUwlAKtFGrV9jKTAZERNw=
X-Gm-Message-State: AOJu0YzFgwyiR02/Xv0q78exBOCJ2NwnM4OZkKXXxUCLdzdjsTWL/pLE
	kxaje6j50GVlHGXPxGfuQ/P6/JjKRYkL3+phpnJ+w2VavrMBDYlH
X-Google-Smtp-Source: AGHT+IGbw7iculL+CN0bnGdj6v5FvEw/7MjbSFePuDJZLsQqsdRE0Y/d4XJ8gI+wJ/VXx9jPn/ixUw==
X-Received: by 2002:a05:6808:10d3:b0:3c0:b3f3:c30f with SMTP id s19-20020a05680810d300b003c0b3f3c30fmr14896630ois.9.1708325895301;
        Sun, 18 Feb 2024 22:58:15 -0800 (PST)
Received: from gmail.com ([192.184.167.79])
        by smtp.gmail.com with ESMTPSA id p27-20020a056a0026db00b006e4648059b6sm1011242pfw.26.2024.02.18.22.58.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Feb 2024 22:58:14 -0800 (PST)
Date: Sun, 18 Feb 2024 22:58:07 -0800
From: Calvin Owens <jcalvinowens@gmail.com>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Russell King <linux@armlinux.org.uk>, Dave Martin <Dave.Martin@arm.com>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	"linux-bcachefs@vger.kernel.org" <linux-bcachefs@vger.kernel.org>,
	Kent Overstreet <kent.overstreet@linux.dev>
Subject: Re: [PATCH] arm: Silence gcc warnings about arch ABI drift
Message-ID: <ZdL7_-2VCJqjn634@gmail.com>
References: <fe51512baa18e1480ce997fc535813ce6a0b0721.1708286962.git.jcalvinowens@gmail.com>
 <431dd956-ad31-4da8-ad42-34f7380824bb@app.fastmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <431dd956-ad31-4da8-ad42-34f7380824bb@app.fastmail.com>

On Monday 02/19 at 07:21 +0100, Arnd Bergmann wrote:
> On Mon, Feb 19, 2024, at 05:09, Calvin Owens wrote:
> > 32-bit arm builds uniquely emit a lot of spam like this:
> >
> >     fs/bcachefs/backpointers.c: In function ‘extent_matches_bp’:
> >     fs/bcachefs/backpointers.c:15:13: note: parameter passing for 
> > argument of type ‘struct bch_backpointer’ changed in GCC 9.1
> >
> > Apply the arm64 change from commit ebcc5928c5d9 ("arm64: Silence gcc
> > warnings about arch ABI drift") to silence them. It seems like Dave's
> > original rationale applies here too.
> >
> > Cc: Dave Martin <Dave.Martin@arm.com>
> > Signed-off-by: Calvin Owens <jcalvinowens@gmail.com>
> > ---
>
> I think these should be addressed in bcachefs instead.

That seems reasonable to me. For clarity, I just happened to notice this
while doing allyesconfig cross builds for something entirely unrelated.

I'll take it up with them. It's not a big problem from my POV, the notes
don't cause -Werror builds to fail or anything like that.

Thanks,
Calvin

> While it's not the fault of bcachefs that the calling
> convention changed between gcc versions, have a look at
> the actual structure layout:
> 
> struct bch_val {
>         __u64           __nothing[0];
> };
> struct bpos {
>         /*
>          * Word order matches machine byte order - btree code treats a bpos as a
>          * single large integer, for search/comparison purposes
>          *
>          * Note that wherever a bpos is embedded in another on disk data
>          * structure, it has to be byte swabbed when reading in metadata that
>          * wasn't written in native endian order:
>          */
> #if __BYTE_ORDER__ == __ORDER_LITTLE_ENDIAN__
>         __u32           snapshot;
>         __u64           offset;
>         __u64           inode;
> #elif __BYTE_ORDER__ == __ORDER_BIG_ENDIAN__
>         __u64           inode;
>         __u64           offset;         /* Points to end of extent - sectors */
>         __u32           snapshot;
> #else
> #error edit for your odd byteorder.
> #endif
> } __packed
> struct bch_backpointer {
>         struct bch_val          v;
>         __u8                    btree_id;
>         __u8                    level;
>         __u8                    data_type;
>         __u64                   bucket_offset:40;
>         __u32                   bucket_len;
>         struct bpos             pos;
> } __packed __aligned(8);
> 
> This is not something that should ever be passed by value
> into a function.
> 
>       Arnd

