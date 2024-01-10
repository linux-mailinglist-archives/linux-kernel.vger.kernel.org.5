Return-Path: <linux-kernel+bounces-21770-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D0541829411
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 08:13:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F1EAF1C25798
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 07:13:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96DD238DE0;
	Wed, 10 Jan 2024 07:13:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cXPjv9Lh"
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 696F536AFE
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jan 2024 07:13:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-553ba2f0c8fso4311192a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jan 2024 23:13:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704870789; x=1705475589; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=85ywecMwMu1AdtOzRqPMq0CMfn7XBj3f6oyEvV9h868=;
        b=cXPjv9LhGjNqdF4l18e0fT3sfTUr9s3DSRKJIWocWyS7gHfv2N5j8bLXGkzcYOIB1a
         X1dErwyilpwHRUddF5Fog0dBBnlfYi61ksvZGfW+wAKnrmpncPMbU04YjVIm6bMVAvpW
         pSkRh5qNrUlwgv2o1NMTFyU+Mhay2oqqgn8UH+74hS596QWbZdGWMT8bGbxwsStONd41
         9yjnVs3wtJ8JmOIt02yM8W7evz0w9tim+5oVjy2uTQpC1XV1Uk+HGxk7g9CawwghOzZG
         +hADDNWUwrKZK5Uwdab7B9fiQA4vJLP/gtu3qlseFz3nuhi5EYGmjmfdDp9fVinEM5ud
         aKNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704870789; x=1705475589;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=85ywecMwMu1AdtOzRqPMq0CMfn7XBj3f6oyEvV9h868=;
        b=AnQEc/LYAVhxUHtl1Xh6NM8uT9MVmGz9w4ZKT3ly0pGzQUvEmKfJcDveDdVdZaJKsc
         Hn8Xf108hQN6XzAVDe0H0qOc9LpPGMqVp+qnzu9lQ9mo4TPQTosZfLoR4R7plcxZBW7t
         Wmq7qWp0YFzvFzXlsDHSmqYQiF9E6QWOXNJ9SBczhYzXE+gBCLL1hEBkFRvDCfvXqNDR
         xruKjtep/AHZppAtv9YgwFGZyyTk0oMhHGNd7kZ0haT8cLzSxOXcpVkCUvQrSqLHLTtB
         8bAc56F9/a1vFalatQQPMOFHaPeDx8vAEb/GuVluQRW/EAUH1vgEBtLGx+IfYOOeDPL2
         VPuA==
X-Gm-Message-State: AOJu0YyKQ4IZeNSdwirps4RgvAMjOXh0Ts9WR4uUBJCNtlf1gnsdmU8o
	yg/PqMSpLcZrNlvh3AmEZA==
X-Google-Smtp-Source: AGHT+IF4YJHlFjRRGVxF2qE37e0ua2Nd2i8n12Gp5w1Kot/zNKM4puzluWiLzGWuX/5y6awnkl66KA==
X-Received: by 2002:a50:bb6d:0:b0:554:51a4:a00 with SMTP id y100-20020a50bb6d000000b0055451a40a00mr94414ede.66.1704870789480;
        Tue, 09 Jan 2024 23:13:09 -0800 (PST)
Received: from p183 ([46.53.248.125])
        by smtp.gmail.com with ESMTPSA id es13-20020a056402380d00b00557535489adsm1734767edb.37.2024.01.09.23.13.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jan 2024 23:13:09 -0800 (PST)
Date: Wed, 10 Jan 2024 10:13:07 +0300
From: Alexey Dobriyan <adobriyan@gmail.com>
To: David Howells <dhowells@redhat.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>, pinskia@gmail.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 00/45] C++: Convert the kernel to C++
Message-ID: <aed64ce6-3765-4099-8211-032d4722f184@p183>
References: <3465e0c6-f5b2-4c42-95eb-29361481f805@zytor.com>
 <152261521484.30503.16131389653845029164.stgit@warthog.procyon.org.uk>
 <1681813.1704843645@warthog.procyon.org.uk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1681813.1704843645@warthog.procyon.org.uk>

On Tue, Jan 09, 2024 at 11:40:45PM +0000, David Howells wrote:
> There was also a problem with leaving gaps in static array initialisation and
> a problem with statically initialising fields out of order (with respect to
> the order they're declared in the struct declaration).  Possibly these have
> been fixed in g++.

They weren't :-(
https://gcc.gnu.org/bugzilla/show_bug.cgi?id=113124

Right now g++ hard errors some patterns of C99 inititialisation which
clang++ allows (with warnings which can be turned off).

However, clang++ doesn't believe in pointer arithmetic on void*.

