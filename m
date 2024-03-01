Return-Path: <linux-kernel+bounces-88808-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 43A7D86E6DE
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 18:10:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B29551F2287F
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 17:10:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 771A0C2C1;
	Fri,  1 Mar 2024 17:09:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="06rxUA6F"
Received: from mail-io1-f41.google.com (mail-io1-f41.google.com [209.85.166.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10D1F28375
	for <linux-kernel@vger.kernel.org>; Fri,  1 Mar 2024 17:09:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709312960; cv=none; b=Se3FAWlCz6r88S4+M508yBNwRwIEyvjrfnMD0ArKd/DAu1Lae08NJXMU9o1m2WE4RIfsV3CskbCpOomfLjos1rSX31Qk3umOm+iNPUGmC1R+Zcnmc4AwzCBO603P8xnEo/sE0ep7fKrE2rfNPG8lDgkZ4B0Y9oDBpSYeTQhv2Vo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709312960; c=relaxed/simple;
	bh=1cS6+LLKKJwc2QewyzocSdAasYEcaBT9FfZr/7scFes=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fJ1smwexX1+ThmnwQnx7Sm74lrY7q1RzJ4TkyR477fKiEW7MAqG2lxoQ2jPavGyuPJGTPHLiBj+ZGb207OmCTNKfD9CKfk9bLL2vgZNVLsrS9RFTWGY+RXcF1goYAKkplFxKRTQE3J14cXtNertRUmY5UBqnzZ9u/eSKGBa5b48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=06rxUA6F; arc=none smtp.client-ip=209.85.166.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-io1-f41.google.com with SMTP id ca18e2360f4ac-7c80a1186bdso102214239f.3
        for <linux-kernel@vger.kernel.org>; Fri, 01 Mar 2024 09:09:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1709312958; x=1709917758; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=TgGayE0Ss0x7kMyOECw4c7ZlvB5+ggeY6MfRBHZyRj0=;
        b=06rxUA6FVMrODxLKRPO790b3zQpCzQvuLqG1lAfKuCFeFONmjF/fbA8FH8n320aFXR
         Cf3y8h05UfZ3nqk5X6a5SBJNC4aUomiHe2bU/cQGXsqQEvSELn5nzZ3xqMhnaDJvQCgO
         2QMmrZ0Kb2ADoTESIa2tqaFXwp+DaRWwaFEESfWij9cJFiwrjL3DqNd0sm+AbRzVhuA1
         EwHsZo6HtJMV0ulzf7AdKIW76i2tMZmfbArQnFNH1QlGDxPi24Nh6TvNmeHnG5Hfg4g0
         u4pEVFsL3fuex3cZGVYCxIoteoIbT+KmIzmgk3DL1vRRkqQ7uVFBcbExO9a0lJeb38yA
         LiHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709312958; x=1709917758;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TgGayE0Ss0x7kMyOECw4c7ZlvB5+ggeY6MfRBHZyRj0=;
        b=J1eQS278N/5FdPGOz6nlXpjzr+yT0UxwDfhUFpae1EO8uwYQ0kKuLGrK/v4QLJkFWS
         wjnEWysC89HkVL6FK0xASNfPbQ/06NLfT7ondQxlV8Veuu0esWuB4FAxun4yw0YpMuZD
         2sJEF5oVuDaEWsgaHvJbk5Ou3hrTITprdEJqugUjDNuVBIYkJkp8dGmZERy8gUy7z92i
         MFyDx8Y2Up8gWLtudZVohSGVu/GFtA/tK/+i7uwryKvza5lF+FyTZGINF1VveTz8Dxqb
         jhRtRhlZbrSg4qxAsxgcI15Ud1EcxMAmj1Fyh0mIWGsf47o+uzliVagW4mKBex+HIg5Q
         VLrg==
X-Forwarded-Encrypted: i=1; AJvYcCU9bPRXVLKgVEjzuZWieFhrAQM0NYAVirR0zy8KnONCFH1pCQihsi7hoplVq5JBoc5haQnzAHsmskLx3QQbItEkpNyt7qVfrvVse77R
X-Gm-Message-State: AOJu0Yw6Fmxbz/DuUHhuZaMik3U9YVTLahLANLW2XsRkoKUGHU+DQeLT
	xvnZdlrtpDidBrksWtXxki5kohTX5IkuY1fRoH6SJZ6T3s7C5vkehviemVddqdI=
X-Google-Smtp-Source: AGHT+IGbtTfgZxtEKonCNw+wmoLQTEBJgPOICKhUbu832VL/S6jYkO75nxPvM+5zad2mc8wT7+h4jw==
X-Received: by 2002:a5d:9c16:0:b0:7c7:97c2:f04f with SMTP id 22-20020a5d9c16000000b007c797c2f04fmr2306910ioe.8.1709312958140;
        Fri, 01 Mar 2024 09:09:18 -0800 (PST)
Received: from ghost ([2601:647:5700:6860:2a1e:5647:311:1139])
        by smtp.gmail.com with ESMTPSA id 132-20020a63008a000000b005dc9439c56bsm3121416pga.13.2024.03.01.09.09.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Mar 2024 09:09:17 -0800 (PST)
Date: Fri, 1 Mar 2024 09:09:15 -0800
From: Charlie Jenkins <charlie@rivosinc.com>
To: Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: Guenter Roeck <linux@roeck-us.net>,
	David Laight <David.Laight@aculab.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Helge Deller <deller@gmx.de>,
	"James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
	Parisc List <linux-parisc@vger.kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Russell King <linux@armlinux.org.uk>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Palmer Dabbelt <palmer@rivosinc.com>,
	Linux ARM <linux-arm-kernel@lists.infradead.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: [PATCH v11] lib: checksum: Use aligned accesses for ip_fast_csum
 and csum_ipv6_magic tests
Message-ID: <ZeILu9x+/STqWVy+@ghost>
References: <20240229-fix_sparse_errors_checksum_tests-v11-1-f608d9ec7574@rivosinc.com>
 <41a5d1e8-6f30-4907-ba63-8a7526e71e04@csgroup.eu>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <41a5d1e8-6f30-4907-ba63-8a7526e71e04@csgroup.eu>

On Fri, Mar 01, 2024 at 07:17:38AM +0000, Christophe Leroy wrote:
> +CC netdev ARM Russell
> 
> Le 29/02/2024 à 23:46, Charlie Jenkins a écrit :
> > The test cases for ip_fast_csum and csum_ipv6_magic were not properly
> > aligning the IP header, which were causing failures on architectures
> > that do not support misaligned accesses like some ARM platforms. To
> > solve this, align the data along (14 + NET_IP_ALIGN) bytes which is the
> > standard alignment of an IP header and must be supported by the
> > architecture.
> 
> In your description, please provide more details on platforms that have 
> a problem, what the problem is exactly (Failed calculation, slowliness, 
> kernel Oops, panic, ....) on each platform.
> 
> And please copy maintainers and lists of platforms your are specifically 
> addressing with this change. And as this is network related, netdev list 
> should have been copied as well.
> 
> I still think that your patch is not the good approach, it looks like 
> you are ignoring all the discussion. Below is a quote of what Geert said 
> and I fully agree with that:
> 
> 	IMHO the tests should validate the expected functionality.  If a test
> 	fails, either functionality is missing or behaves wrong, or the test
> 	is wrong.
> 
> 	What is the point of writing tests for a core functionality like network
> 	checksumming that do not match the expected functionality?
> 
> 
> So we all agree that there is something to fix, because today's test 
> does odd-address accesses which is unexpected for those functions, but 
> 2-byte alignments should be supported hence tested by the test. Limiting 
> the test to a 16-bytes alignment deeply reduces the usefullness of the test.
> 

Maybe I am lost in the conversations. This isn't limited to 16-bytes
alignment? It aligns along 14 + NET_IP_ALIGN. That is 16 on some
platforms and 14 on platforms where unaligned accesses are desired.
These functions are expected to be called with this offset. Testing with
any other alignment is not the expected behavior. These tests are
testing the expected functionality.

- Charlie

> Christophe

