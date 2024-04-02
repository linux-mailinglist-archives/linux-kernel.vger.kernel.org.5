Return-Path: <linux-kernel+bounces-128103-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EFBA989562D
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 16:06:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A3C471F24466
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 14:06:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9927D85958;
	Tue,  2 Apr 2024 14:06:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jxZSCTPV"
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EC8184FA5;
	Tue,  2 Apr 2024 14:06:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712066773; cv=none; b=ee6nXokCGIY5k4DjKEJb8jo0NzqQ7b3IHMMcgXZje1dnW5jTIZKcAV2KT8wCG1CpbBszMmwTc2hqEx23F0cDmHMOvpy1YY3YbppSXdb4EuFocIDG0CJST3jIcCJtW//Ka5CqI3Eqpo7tnaYpT4fpzPSBpOVq+KMFqGoWsWEcZ1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712066773; c=relaxed/simple;
	bh=Vvt5mnf6spmL9Bj9mTkjxxdRRvLUW5hBDEJkgWuz6Pk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YLe9+o4bUaqzMNsH08uIMSWYziJ20P3Xhd41eeMCUz8Jyc/nNFlJMqGE8uIErcZnFsLHrlMj6SCDYFlTWQgBzbJuLHBXuiGynjtwzq8WfBQXghJR77dcE4hUGd+8PxznLbLHTTB2zEGsWyoJ2Zp8z5Oyk4Yv2EpumLl40SWRsOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jxZSCTPV; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-5e8470c1cb7so3185800a12.2;
        Tue, 02 Apr 2024 07:06:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712066771; x=1712671571; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SRsvCMsfTonmyjxjOpazHdFxU06P7bQCfx5JSVpO6Oo=;
        b=jxZSCTPVUssCvqRzjCKb4FUCGxkbtVLzB2dnbPf9krJ3/1LPKod3nyRbbUQH58rypU
         1k3gfNGuB53b+L3WXye8nzalDT8krTzdfn64TodDevXpXUZF5ZMxmqR7xNyPjoBFOOMO
         ClAyUWcBnpz5kR+8dpXJs6oz6bhFTeu8KJ5DvKLgqzdUv0rR6u/8KVpKtBpK/LlZ4/M1
         exKysWVrhkbcuF6Nlz6IFt0XmQNvSNnHF7EKy/jvOGAs7O8h6RcU6ll7XucoInaqN/Wi
         n7RDLIkgsn2/Am3EOZZTxqmrKXAwOlFz3iMIrrmsU3PInFtpsCp0nV55h3amChZPUniM
         xJeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712066771; x=1712671571;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SRsvCMsfTonmyjxjOpazHdFxU06P7bQCfx5JSVpO6Oo=;
        b=IY/BsGdjc0y2lHi8GBawIarsSjJJzXDIu2vPfDBsj10QK9hhcYIipkA5NXbNkDYjvL
         g/8EqUeZpG/wIZ/XpHRw7OeCvXAmeCWFpPPZ6akysiCQGTwgg6fSF0aot1rQGJLCTG1m
         jHg0q9KZRVXyG1e8Pas/4/JSxbrby/c6PY9iHfCztffWovre5SRCwifYg+PTDsvjql4z
         urT61JBLngNDos7Owfkwb+Ut+JJdN7PETD3WztKEPdt7N4UsiXKRKO7jfI4Duwx5Que3
         TmuDns+nJgBBH/uAneKM8NhZgJTDMHfioc1X9MEuKKGEGCJ/PRBF53Q34VNS7HgLXIkn
         hysA==
X-Forwarded-Encrypted: i=1; AJvYcCUK/bhg5kTn4gBm7Sg6TelP7hOA2UtTUtHBm/RAHJQJpN/gMRHFhWChDPgtKySqKVPpwTTHc/Q869oGT5Htyz/7VI2yzuCcXlqWVnByLrhFtkwqz4UZGaQYrZd9H2h1ZGy1M6iB720=
X-Gm-Message-State: AOJu0YwJ77YoOWGl64Vj8NMKUXSPCKIUDFrs6tMJdRBQmgsQrCiFOkDV
	Q11VJgjL7cqSmMf5oFkyJk7U2iqSHGh4H4yVn+n0PihZB600R5UO
X-Google-Smtp-Source: AGHT+IFv2uzi3zbj43YEcQbEoMt6P4GKKzFQhhBekCAxoGrsz+UV65Epz2Dew1HronxR1aB7zZlxcw==
X-Received: by 2002:a17:90a:d14a:b0:2a0:7ee2:1abc with SMTP id t10-20020a17090ad14a00b002a07ee21abcmr8972596pjw.41.1712066771472;
        Tue, 02 Apr 2024 07:06:11 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id m5-20020a17090b068500b0029fbfb620cdsm9717028pjz.28.2024.04.02.07.06.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Apr 2024 07:06:10 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Tue, 2 Apr 2024 07:06:09 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	Yoshinori Sato <ysato@users.sourceforge.jp>
Cc: Rich Felker <dalias@libc.org>, linux-sh@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Revert "sh: Handle calling csum_partial with misaligned
 data"
Message-ID: <cb8d3d2a-b843-49d5-a219-10a29b5877d0@roeck-us.net>
References: <20240324231804.841099-1-linux@roeck-us.net>
 <059d03a5da257660fa0bc188c6cc8d0152e97704.camel@physik.fu-berlin.de>
 <a9ac59cd-82db-45a0-9f85-ec3880c54dbf@roeck-us.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a9ac59cd-82db-45a0-9f85-ec3880c54dbf@roeck-us.net>

Hi,

On Mon, Mar 25, 2024 at 07:34:00AM -0700, Guenter Roeck wrote:
> On 3/25/24 00:39, John Paul Adrian Glaubitz wrote:
> > Hi Guenter,
> > 
> > On Sun, 2024-03-24 at 16:18 -0700, Guenter Roeck wrote:
> > > This reverts commit cadc4e1a2b4d20d0cc0e81f2c6ba0588775e54e5.
> > > 
> > > Commit cadc4e1a2b4d ("sh: Handle calling csum_partial with misaligned
> > > data") causes bad checksum calculations on unaligned data. Reverting
> > > it fixes the problem.
> > > 
> > >      # Subtest: checksum
> > >      # module: checksum_kunit
> > >      1..5
> > >      # test_csum_fixed_random_inputs: ASSERTION FAILED at lib/checksum_kunit.c:500
> > >      Expected ( u64)result == ( u64)expec, but
> > >          ( u64)result == 53378 (0xd082)
> > >          ( u64)expec == 33488 (0x82d0)
> > >      # test_csum_fixed_random_inputs: pass:0 fail:1 skip:0 total:1
> > >      not ok 1 test_csum_fixed_random_inputs
> > >      # test_csum_all_carry_inputs: ASSERTION FAILED at lib/checksum_kunit.c:525
> > >      Expected ( u64)result == ( u64)expec, but
> > >          ( u64)result == 65281 (0xff01)
> > >          ( u64)expec == 65280 (0xff00)
> > >      # test_csum_all_carry_inputs: pass:0 fail:1 skip:0 total:1
> > >      not ok 2 test_csum_all_carry_inputs
> > >      # test_csum_no_carry_inputs: ASSERTION FAILED at lib/checksum_kunit.c:573
> > >      Expected ( u64)result == ( u64)expec, but
> > >          ( u64)result == 65535 (0xffff)
> > >          ( u64)expec == 65534 (0xfffe)
> > >      # test_csum_no_carry_inputs: pass:0 fail:1 skip:0 total:1
> > >      not ok 3 test_csum_no_carry_inputs
> > >      # test_ip_fast_csum: pass:1 fail:0 skip:0 total:1
> > >      ok 4 test_ip_fast_csum
> > >      # test_csum_ipv6_magic: pass:1 fail:0 skip:0 total:1
> > >      ok 5 test_csum_ipv6_magic
> > >   # checksum: pass:2 fail:3 skip:0 total:5
> > >   # Totals: pass:2 fail:3 skip:0 total:5
> > > not ok 22 checksum
> > 
> > Can you tell me how the tests are run so I can try to verify this on real hardware?
> > 
> 
> Enabling CONFIG_KUNIT and CHECKSUM_KUNIT and booting with those tests enabled
> should do it.
> 

Did you have time to test this on real hardware ?

Thanks,
Guenter

