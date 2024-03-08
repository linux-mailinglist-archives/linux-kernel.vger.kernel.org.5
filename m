Return-Path: <linux-kernel+bounces-97609-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A2E0876C74
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 22:38:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B30841C213E6
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 21:38:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18A745F848;
	Fri,  8 Mar 2024 21:38:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FpS2LeFy"
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0858367
	for <linux-kernel@vger.kernel.org>; Fri,  8 Mar 2024 21:38:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709933895; cv=none; b=WyMXKeqzdsiHgrNLAaOzvGSyXLCpwLfGVf2UOQoUCXthMQE1fWd+74prD6vGA+fro5SSbBghrzpEspldYi/F9GmQZHuW1y/tl74cdZD5whTKz7+p51O2lCDqoKAQOQk8mSMUR1gPw+glZd+OCSWYbHDPY0BkKdTLslhdra9iyL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709933895; c=relaxed/simple;
	bh=WwpLATMHSHcGIYdzotaP25I/LYMac7JZ2C3/OiMToDI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jEJjmH5r/MBBa5GB255kLGCjMN0xTKU7EDjWrYczycoOFebahuHPGU/ytpZs3W+f2xXm36Dn3BCWicDz89dyhlZx9kvJjQgR4pweyI2bpAv14ic5nrPJwMR/R8xGlM7pXyLe8fVMnWhq122H5+FFSiR2PLsvVUOCltUfQMb04X0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FpS2LeFy; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-564fd9eea75so3518606a12.3
        for <linux-kernel@vger.kernel.org>; Fri, 08 Mar 2024 13:38:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709933892; x=1710538692; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=C5vHRjCeO4bwXd9VgTdyqvaIa5JQzoplykKkt0qJuAw=;
        b=FpS2LeFyGCvALf9AO/LYkDiSwq3u5Klh4VGrNl9IMyksJXiwn1IAI2Ez7+EdxLXRh8
         /oePCFzXT/jVPRThpR4f8M3JKvMBXzUoKeBxsaBaJ6zTwpyTurjBzAyVfYkgYSUUKsCk
         9mprnhJsvz+VP9YO5yY5J4ziurbMSvMhbqXC9oSZwEhi6EdFMuLxI7LifSOgMsu6r57q
         fpSjDagIZixAPDiKdJmmcoOLU4PmsY8ryiRzjdZWlhZy0LYLpU8nWfLTZPP5TNgoNXgZ
         cVBEvY5DNooFX+MDym+v4hvLuBMlJDSc41cnrWn+fA9FC4xYr1uCHJi7SdtK2md63DCg
         Jzjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709933892; x=1710538692;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C5vHRjCeO4bwXd9VgTdyqvaIa5JQzoplykKkt0qJuAw=;
        b=L4WfHZcRZG5J5PsemVkfbII4lam90NEl52b67LY0csRrlQoDtkqgfRD3U43n1zCChR
         Vwj6Qs4OnQMWkkJuKrf+cSlRhD94EaArT/i8KQVeIwwTPFdWowbS2PPASbUBuZPb8BS8
         E8JeL21OSNkQbzwbjuGeMgCsZDUFJhaPkthgNdfKlYvkcNkD2bKRk6TeOemtRuxHnKq5
         TKTIXP4nJ0D6Eee4yvYYz7eWKRDoqgB4KQzEnAq1qm+4fzu63aX7/rXm3mGIAHFxK5zS
         Id5VJqiixgi9ZCxzVcm0sC4v2hMhsyueCDytl+POXTCpi4H2lSTjs+7Y9LqBv6PQ7L+b
         RiWg==
X-Forwarded-Encrypted: i=1; AJvYcCVyqVANDVBT4Lxwuend7rDF80D3AA63cUgbj0cF8ljlzHbOW380Q5v8VVTJow8j6sbYJ/PH0Jaq7tpCc0tRFYLNoXyFAav7xa3iLyV0
X-Gm-Message-State: AOJu0YzdVjMl6lymglpquL3hY0poKeMgbU8UXueXSXEAlutZiSxN6Y47
	N8uTyeT3tJtmgtireJmH1aY8H0lO1NfcQPTGDRaSzhisGF8DPIGTUm0cBHBB
X-Google-Smtp-Source: AGHT+IFTFjNnoCdcMcUnL9iB5Dv1T1XNqt9/pyHkPbDxRK6LvjdBTLlprpUQwwXkrHl599u7h7JCdg==
X-Received: by 2002:a50:d541:0:b0:566:f5d6:4b4 with SMTP id f1-20020a50d541000000b00566f5d604b4mr266667edj.12.1709933891881;
        Fri, 08 Mar 2024 13:38:11 -0800 (PST)
Received: from andrea ([31.189.122.3])
        by smtp.gmail.com with ESMTPSA id fg3-20020a056402548300b005656bbb5b3fsm158817edb.63.2024.03.08.13.38.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Mar 2024 13:38:11 -0800 (PST)
Date: Fri, 8 Mar 2024 22:38:09 +0100
From: Andrea Parri <parri.andrea@gmail.com>
To: Kenneth-Lee-2012@foxmail.com
Cc: Alan Stern <stern@rowland.harvard.edu>, linux-kernel@vger.kernel.org,
	paulmck@kernel.org
Subject: Re: Question about PB rule of LKMM
Message-ID: <ZeuFQdk/zcjkILbC@andrea>
References: <tencent_744E0AF832049C200F96FD6582D5114D7F0A@qq.com>
 <ZeipiSVLR01jmM6b@andrea>
 <e05fa6a9-c810-46cb-b033-b91ae7a5c382@rowland.harvard.edu>
 <ZejC+lutRuwXQrMz@andrea>
 <Zenip+8BDM3p+MUh@andrea>
 <eb8f2a21-d388-424d-8504-ccd7bdb53a93@rowland.harvard.edu>
 <ZeoFBkB1BeTdEQsn@andrea>
 <bde188b0-1c5b-4b3b-94de-395a52fc37ce@rowland.harvard.edu>
 <ZeoQvj3l6moF9KdQ@andrea>
 <tencent_3FCF3AA5E98BC9395F98803764A6B2F7CC07@qq.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tencent_3FCF3AA5E98BC9395F98803764A6B2F7CC07@qq.com>

> In the "THE HAPPENS-BEFORE RELATION: hb" section of explanation.txt,
> it uses the following example to explain the prop relation:
> 
> 	P0()
> 	{
> 		int r1;
> 
> 		WRITE_ONCE(x, 1);
> 		r1 = READ_ONCE(x);
> 	}
> 
> 	P1()
> 	{
> 		WRITE_ONCE(x, 8);
> 	}
> 
> if r1 = 8, we can deduce P0:Wx1 ->coe P1:Wx8 ->rfe P0:Rx, this can be
> explained with the operational model. But according to the definition of
> prop,
> 
>   let prop = [Marked] ; (overwrite & ext)? ; cumul-fence* ; [Marked] ; rfe? ; [Marked]
> 
> The link should contain a cumul-fence, which doesn't exist in the
> example.

Remark that, in the CAT language, the identity relation ({(e, e) : each event e})
is a subset of R* (the _reflexive_-transitive closure of R) for any relation R.

The link at stake, (P0:Wx1, P0:Rx), is the result of the following composition:

  [Marked]         ; (overwrite & ext)? ; cumul-fence*     ; [Marked]          ; rfe?            ; [Marked]
  (P0:Wx1, P0:Wx1)   (P0:Wx1, P1:Wx8)     (P1:Wx8, P1:Wx8)   (P1:Wx8, P1:Wx8))   (P1:Wx8, P0:Rx)   (P0:Rx, P0:Rx)

  Andrea

